Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389F4585CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 03:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiGaBbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 21:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiGaBbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 21:31:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C6513F44;
        Sat, 30 Jul 2022 18:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B52C1B80C85;
        Sun, 31 Jul 2022 01:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F740C433C1;
        Sun, 31 Jul 2022 01:31:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QNyybTwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659231094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VReljF7NN+hiCEaA067jPq1zcIi9kWxwdhkLIbmifXk=;
        b=QNyybTwPtOS3JimAKc9RATbRIgYdVuqfQB2G4v9WmClb4xUFqdgczPapYnqLmi2jKA2azo
        +2cnJgKdxq9YQ55umPtiHZoOsiUBhv2hOgvUnsXHgvbCrf/ODYbLDbIoPvXTR+E+qGJ+8y
        WVd4nvOSDioPDr/y0ubU3xKFkOXnQCE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cf6e099a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 31 Jul 2022 01:31:33 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH RFC v2] random: implement getrandom() in vDSO
Date:   Sun, 31 Jul 2022 03:31:25 +0200
Message-Id: <20220731013125.2103601-1-Jason@zx2c4.com>
In-Reply-To: <YuXLlUZ8EzvZB43U@zx2c4.com>
References: <YuXLlUZ8EzvZB43U@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two statements:

  1) Userspace wants faster cryptographically secure random numbers of
     arbitrary size, big or small.

  2) Userspace is currently unable to safely roll its own RNG with the
     same security profile as getrandom().

Statement (1) has been debated for years, with arguments ranging from
"we need faster cryptographically secure card shuffling!" to "the only
things that actually need good randomness are keys, which are few and
far between" to "actually, TLS CBC nonces are frequent" and so on. I
don't intend to wade into that debate substantially, except to note that
recently glibc added arc4random(), whose goal is to return a
cryptographically secure uint32_t. So here we are.

Statement (2) is more interesting. The kernel is the nexus of all
entropic inputs that influence the RNG. It is in the best position, and
probably the only position, to decide anything at all about the current
state of the RNG and of its entropy. One of the things it uniquely knows
about is when reseeding is necessary.

For example, when a virtual machine is forked, restored, or duplicated,
it's imparative that the RNG doesn't generate the same outputs. For this
reason, there's a small protocol between hypervisors and the kernel that
indicates this has happened, alongside some ID, which the RNG uses to
immediately reseed, so as not to return the same numbers. Were userspace
to expand a getrandom() seed from time T1 for the next hour, and at some
point T2 < hour, the virtual machine forked, userspace would continue to
provide the same numbers to two (or more) different virtual machines,
resulting in potential cryptographic catastrophe. Something similar
happens on resuming from hibernation (or even suspend), with various
compromise scenarios there in mind.

There's a more general reason why userspace rolling its own RNG from a
getrandom() seed is fraught. There's a lot of attention paid to this
particular Linuxism we have of the RNG being initialized and thus
non-blocking or uninitialized and thus blocking until it is initialized.
These are our Two Big States that many hold to be the holy
differentiating factor between safe and not safe, between
cryptographically secure and garbage. The fact is, however, that the
distinction between these two states is a hand-wavy wishy-washy inexact
approximation. Outside of a few exceptional cases (e.g. a HW RNG is
available), we actually don't really ever know with any rigor at all
when the RNG is safe and ready (nor when it's compromised). We do the
best we can to "estimate" it, but entropy estimation is fundamentally
impossible in the general case. So really, we're just doing guess work,
and hoping it's good and conservative enough. Let's then assume that
there's always some potential error involved in this differentiator.

In fact, under the surface, the RNG is engineered around a different
principal, and that is trying to *use* new entropic inputs regularly and
at the right specific moments in time. For example, close to boot time,
the RNG reseeds itself more often than later. At certain events, like VM
fork, the RNG reseeds itself immediately. The various heuristics for
when the RNG will use new entropy and how often is really a core aspect
of what the RNG has some potential to do decently enough (and something
that will probably continue to improve in the future from random.c's
present set of algorithms). So in your mind, put away the metal
attachment to the Two Big States, which represent an approximation with
a potential margin of error. Instead keep in mind that the RNG's primary
operating heuristic is how often and exactly when it's going to reseed.

So, if userspace takes a seed from getrandom() at point T1, and uses it
for the next hour (or N megabytes or some other meaningless metric),
during that time, potential errors in the Two Big States approximation
are amplified. During that time potential reseeds are being lost,
forgotten, not reflected in the output stream. That's not good.

The simplest statement you could make is that userspace RNGs that expand
a getrandom() seed at some point T1 are nearly always *worse*, in some
way, than just calling getrandom() every time a random number is
desired.

For those reasons, after some discussion on libc-alpha, glibc's
arc4random() now just calls getrandom() on each invocation. That's
trivially safe, and gives us latitude to then make the safe thing faster
without becoming unsafe at our leasure. Card shuffling isn't
particularly fast, however.

How do we rectify this? By putting a safe implementation of getrandom()
in the vDSO, which has access to whatever information a
particular iteration of random.c is using to make its decisions. I use
that careful language of "particular iteration of random.c", because the
set of things that a vDSO getrandom() implementation might need for making
decisions as good as the kernel's will likely change over time. This
isn't just a matter of exporting certain *data* to userspace. We're not
going to commit to a "data API" where the various heuristics used are
exposed, locking in how the kernel works for decades to come, and then
leave it to various userspaces to roll something on top and shoot
themselves in the foot and have all sorts of complexity disasters.
Rather, vDSO getrandom() is supposed to be the *same exact algorithm*
that runs in the kernel, except it's been hoisted into userspace as
much as possible. And so vDSO getrandom() and kernel getrandom() will
always mirror each other hermetically.

API-wise, vDSO getrandom has a pair of functions:

  ssize_t getrandom(void *state, void *buffer, size_t len, unsigned int flags);
  void *getrandom_alloc([inout] size_t *num, [out] size_t *size_per_each);

In the first function, the return value and the latter 3 arguments are
the same as ordinary getrandom(), while the first argument is a pointer
to some state allocated with getrandom_alloc(). getrandom_alloc() takes
the desired number of states, and returns an array of states, the number
actually allocated, and the size in bytes of each one, enabling a libc
to use one per thread. We very intentionally do *not* leave state
allocation up to the caller. There are too many weird things that can go
wrong, and it's important that vDSO does not provide too generic of a
mechanism. It's not going to store its state in just any old memory
address. It'll do it only in ones it allocates.

Right now this means it's a mlock'd page with WIPEONFORK set. In the
future maybe there will be other interesting page flags or
anti-heartbleed measures, or other platform-specific kernel-specific
things that can be set. Again, it's important that the vDSO has a say in
how this works rather than agreeing to operate on any old address;
memory isn't neutral.

The interesting meat of the implementation is in lib/vdso/getrandom.c,
as generic C code, and it aims to mainly follow random.c's buffered fast
key erasure logic. Before the RNG is initialized, it falls back to the
syscall. Right now it uses a simple generation counter to make its
decisions on reseeding; this covers many cases, but not all, so this RFC
still has a little bit of improvement work to do. But it should give you
the general idea.

The actual place that has the most work to do is in all of the other
files. Most of the vDSO shared page infrastructure is centered around
gettimeofday, and so the main structs are all in arrays for different
timestamp types, and attached to time namespaces, and so forth. I've
done the best I could to add onto this in an unintrusive way, but you'll
notice almost immediately from glancing at the code that it still needs
some untangling work. This also only works on x86 at the moment. I could
certainly use a hand with this part.

So far in my test results, performance is pretty stellar (around 15x for
uint32_t generation), and it seems to be working. But this is very, very
young, immature code, suitable for an RFC and no more, so expect
dragons.

Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: Nadia Heninger <nadiah@cs.ucsd.edu>
Cc: Thomas Ristenpart <ristenpart@cornell.edu>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
I'm not in a hurry to make this patch happen, but I know some people
wanted to tinker around with this, and given that this v2 drops v1's
sharding, I figure I should post this sooner so there's something to
play with.

Changes v1->v2:
- Hoist !len check out of batch_len check.
- Use smp_store_release instead of WRITE_ONCE.
- Account for fork() during execution.
- Simplify API so that libc passes a state per thread, allocated with a
  separate function.
- Attempt to approximate crng_has_old_seed(). This needs work still, but is a
  step in the right direction.
- Document generation counter quirks in comment.
- getrandom() takes `unsigned int flags`, not `unsigned long flags`.

 MAINTAINERS                           |   1 +
 arch/x86/entry/vdso/Makefile          |   2 +-
 arch/x86/entry/vdso/vdso.lds.S        |   4 +
 arch/x86/entry/vdso/vgetrandom.c      |  24 ++++
 arch/x86/include/asm/vdso/getrandom.h |  74 +++++++++++++
 arch/x86/include/asm/vvar.h           |  16 +++
 drivers/char/random.c                 |   4 +
 include/vdso/datapage.h               |   6 +
 lib/vdso/getrandom.c                  | 151 ++++++++++++++++++++++++++
 9 files changed, 281 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 lib/vdso/getrandom.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 651616ed8ae2..b0d2dce4855a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16856,6 +16856,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
 S:	Maintained
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
+F:	lib/vdso/getrandom.c
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 76cd790ed0bd..a60d4771d500 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -24,7 +24,7 @@ VDSO32-$(CONFIG_X86_32)		:= y
 VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
-vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index 4bf48462fca7..faf38a5e3d82 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -28,6 +28,10 @@ VERSION {
 		clock_getres;
 		__vdso_clock_getres;
 		__vdso_sgx_enter_enclave;
+		getrandom;
+		__vdso_getrandom;
+		getrandom_alloc;
+		__vdso_getrandom_alloc;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vgetrandom.c b/arch/x86/entry/vdso/vgetrandom.c
new file mode 100644
index 000000000000..2766b0c8e6fd
--- /dev/null
+++ b/arch/x86/entry/vdso/vgetrandom.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "../../../../lib/vdso/getrandom.c"
+
+ssize_t __vdso_getrandom(void *state, void *buffer, size_t len, unsigned int flags)
+{
+	return __cvdso_getrandom(state, buffer, len, flags);
+}
+
+ssize_t getrandom(void *, void *, size_t, unsigned int)
+	__attribute__((weak, alias("__vdso_getrandom")));
+
+void *__vdso_getrandom_alloc(size_t *num, size_t *size_per_each)
+{
+	return __cvdso_getrandom_alloc(num, size_per_each);
+}
+
+void *getrandom_alloc(size_t *, size_t *)
+	__attribute__((weak, alias("__vdso_getrandom_alloc")));
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
new file mode 100644
index 000000000000..00ca03e56ea9
--- /dev/null
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+#ifndef __ASM_VDSO_GETRANDOM_H
+#define __ASM_VDSO_GETRANDOM_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/unistd.h>
+#include <asm/vvar.h>
+
+static __always_inline ssize_t
+getrandom_syscall(void *buffer, size_t len, unsigned int flags)
+{
+	long ret;
+
+	asm ("syscall" : "=a" (ret) :
+	     "0" (__NR_getrandom), "D" (buffer), "S" (len), "d" (flags) :
+	     "rcx", "r11", "memory");
+
+	return ret;
+}
+
+static __always_inline void *
+mmap_syscall(void *addr, size_t len, int prot, int flags, int fd, off_t offset)
+{
+	long ret;
+	register long r10 asm("r10") = flags;
+	register long r8 asm("r8") = fd;
+	register long r9 asm("r9") = offset;
+
+	asm ("syscall" : "=a" (ret) :
+	     "0" (__NR_mmap), "D" (addr), "S" (len), "d" (prot),
+	     "r" (r10), "r" (r8), "r" (r9) :
+	     "rcx", "r11");
+
+	return (void *)ret;
+}
+
+static __always_inline int
+munmap_syscall(void *addr, size_t len)
+{
+	long ret;
+
+	asm ("syscall" : "=a" (ret) :
+	     "0" (__NR_munmap), "D" (addr), "S" (len) :
+	     "rcx", "r11");
+
+	return ret;
+}
+
+static __always_inline int
+madvise_syscall(void *addr, size_t len, int advice)
+{
+	long ret;
+
+	asm ("syscall" : "=a" (ret) :
+	     "0" (__NR_madvise), "D" (addr), "S" (len), "d" (advice) :
+	     "rcx", "r11");
+
+	return ret;
+}
+
+#define __vdso_rng_data (VVAR(_vdso_rng_data))
+
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
+{
+	return &__vdso_rng_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 183e98e49ab9..9d9af37f7cab 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -26,6 +26,8 @@
  */
 #define DECLARE_VVAR(offset, type, name) \
 	EMIT_VVAR(name, offset)
+#define DECLARE_VVAR_SINGLE(offset, type, name) \
+	EMIT_VVAR(name, offset)
 
 #else
 
@@ -37,6 +39,10 @@ extern char __vvar_page;
 	extern type timens_ ## name[CS_BASES]				\
 	__attribute__((visibility("hidden")));				\
 
+#define DECLARE_VVAR_SINGLE(offset, type, name)				\
+	extern type vvar_ ## name					\
+	__attribute__((visibility("hidden")));				\
+
 #define VVAR(name) (vvar_ ## name)
 #define TIMENS(name) (timens_ ## name)
 
@@ -44,12 +50,22 @@ extern char __vvar_page;
 	type name[CS_BASES]						\
 	__attribute__((section(".vvar_" #name), aligned(16))) __visible
 
+#define DEFINE_VVAR_SINGLE(type, name)					\
+	type name							\
+	__attribute__((section(".vvar_" #name), aligned(16))) __visible
+
 #endif
 
 /* DECLARE_VVAR(offset, type, name) */
 
 DECLARE_VVAR(128, struct vdso_data, _vdso_data)
 
+#if !defined(_SINGLE_DATA)
+#define _SINGLE_DATA
+DECLARE_VVAR_SINGLE(640, struct vdso_rng_data, _vdso_rng_data)
+#endif
+
 #undef DECLARE_VVAR
+#undef DECLARE_VVAR_SINGLE
 
 #endif
diff --git a/drivers/char/random.c b/drivers/char/random.c
index d44832e9e709..69694bb3209a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -59,6 +59,7 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/io.h>
+#include <vdso/datapage.h>
 
 /*********************************************************************
  *
@@ -84,6 +85,7 @@ static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
 /* Various types of waiters for crng_init->CRNG_READY transition. */
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 static struct fasync_struct *fasync;
+DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
 
 /* Control how we warn userspace. */
 static struct ratelimit_state urandom_warning =
@@ -221,6 +223,7 @@ static void crng_reseed(void)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
 	WRITE_ONCE(base_crng.birth, jiffies);
+	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -660,6 +663,7 @@ static void __cold _credit_init_bits(size_t bits)
 		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
 		if (static_key_initialized)
 			execute_in_process_context(crng_set_ready, &set_ready);
+		smp_store_release(&_vdso_rng_data.is_ready, true);
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622e7663..cbacfd923a5c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -109,6 +109,11 @@ struct vdso_data {
 	struct arch_vdso_data	arch_data;
 };
 
+struct vdso_rng_data {
+	unsigned long generation;
+	bool is_ready;
+};
+
 /*
  * We use the hidden visibility to prevent the compiler from generating a GOT
  * relocation. Not only is going through a GOT useless (the entry couldn't and
@@ -120,6 +125,7 @@ struct vdso_data {
  */
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
+extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")));
 
 /*
  * The generic vDSO implementation requires that gettimeofday.h
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
new file mode 100644
index 000000000000..d6368e05443b
--- /dev/null
+++ b/lib/vdso/getrandom.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/atomic.h>
+#include <linux/fs.h>
+#include <vdso/datapage.h>
+#include <asm/vdso/getrandom.h>
+#include <asm/vdso/vsyscall.h>
+#include <asm/page.h>
+#include <uapi/linux/mman.h>
+#include "../crypto/chacha.c"
+
+struct getrandom_state {
+	uint64_t last_reseed;
+	unsigned long generation;
+	union {
+		struct {
+			u8 key[CHACHA_KEY_SIZE];
+			u8 batch[CHACHA_BLOCK_SIZE * 3 / 2];
+		};
+		u8 key_batch[CHACHA_BLOCK_SIZE * 2];
+	};
+	u8 pos;
+	bool not_forked;
+};
+
+static void memcpy_and_zero(void *dst, void *src, size_t len)
+{
+#define CASCADE(type) \
+	while (len >= sizeof(type)) { \
+		*(type *)dst = *(type *)src; \
+		*(type *)src = 0; \
+		dst += sizeof(type); \
+		src += sizeof(type); \
+		len -= sizeof(type); \
+	}
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#if BITS_PER_LONG == 64
+	CASCADE(u64);
+#endif
+	CASCADE(u32);
+	CASCADE(u16);
+#endif
+	CASCADE(u8);
+#undef CASCADE
+}
+
+static __always_inline ssize_t
+__cvdso_getrandom(void *opaque_state, void *buffer, size_t len, unsigned int flags)
+{
+	struct getrandom_state *state = opaque_state;
+	const struct vdso_rng_data *rng_info = __arch_get_vdso_rng_data();
+	const struct vdso_data *timebase = &__arch_get_vdso_data()[CS_HRES_COARSE];
+	const struct vdso_timestamp *course_mono = &timebase->basetime[CLOCK_MONOTONIC_COARSE];
+	u32 chacha_state[CHACHA_STATE_WORDS];
+	ssize_t ret = min_t(size_t, MAX_RW_COUNT, len);
+	size_t batch_len;
+
+	if (unlikely(!rng_info->is_ready))
+		return getrandom_syscall(buffer, len, flags);
+
+	if (unlikely(!len))
+		return 0;
+
+	if (unlikely(!READ_ONCE(state->not_forked)))
+		state->not_forked = true;
+
+retry_generation:
+	if (unlikely(state->generation != READ_ONCE(rng_info->generation) ||
+		     /* 15 sec is crude approximation of crng_has_old_seed(). In the future,
+		      * export this in rng_info->expiration, or similar. Needs improvement. */
+		     READ_ONCE(course_mono->sec) - state->last_reseed > 15)) {
+		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key))
+			return getrandom_syscall(buffer, len, flags);
+		/* We shouldn't be reading rng_info->generation afterwards, as technically it could
+		 * be bumped in between these two lines. Instead this should be set to the value
+		 * read in the `if ()` above. But in fact, the lazy semantics of generation bumping
+		 * always make this happen. So live with this for now. Needs improvement. */
+		state->generation = READ_ONCE(rng_info->generation);
+		state->last_reseed = READ_ONCE(course_mono->sec);
+		state->pos = sizeof(state->batch);
+	}
+
+	len = ret;
+more_batch:
+	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);
+	if (batch_len) {
+		memcpy_and_zero(buffer, state->batch, batch_len);
+		state->pos += batch_len;
+		buffer += batch_len;
+		len -= batch_len;
+	}
+	if (!len) {
+		if (unlikely(state->generation != READ_ONCE(rng_info->generation)))
+			goto retry_generation;
+		if (unlikely(!READ_ONCE(state->not_forked))) {
+			state->not_forked = true;
+			goto retry_generation;
+		}
+		return ret;
+	}
+
+	chacha_init_consts(chacha_state);
+	memcpy(&chacha_state[4], state->key, CHACHA_KEY_SIZE);
+	memset(&chacha_state[12], 0, sizeof(u32) * 4);
+
+	while (len >= CHACHA_BLOCK_SIZE) {
+		chacha20_block(chacha_state, buffer);
+		if (unlikely(chacha_state[12] == 0))
+			++chacha_state[13];
+		buffer += CHACHA_BLOCK_SIZE;
+		len -= CHACHA_BLOCK_SIZE;
+	}
+
+	chacha20_block(chacha_state, state->key_batch);
+	if (unlikely(chacha_state[12] == 0))
+		++chacha_state[13];
+	chacha20_block(chacha_state, state->key_batch + CHACHA_BLOCK_SIZE);
+	state->pos = 0;
+	memzero_explicit(chacha_state, sizeof(chacha_state));
+	goto more_batch;
+}
+
+static __always_inline void *
+__cvdso_getrandom_alloc(size_t *num, size_t *size_per_each)
+{
+	void *state;
+	size_t alloc_size;
+
+	alloc_size = size_mul(*num, sizeof(struct getrandom_state));
+	if (alloc_size == SIZE_MAX)
+		return NULL;
+	alloc_size = roundup(alloc_size, PAGE_SIZE);
+
+	state = mmap_syscall(NULL, alloc_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, -1, 0);
+	if (state == (void *)~0UL)
+		return NULL;
+
+	if (madvise_syscall(state, alloc_size, MADV_WIPEONFORK)) {
+		munmap_syscall(state, alloc_size);
+		return NULL;
+	}
+
+	*num = alloc_size / sizeof(struct getrandom_state);
+	*size_per_each = sizeof(struct getrandom_state);
+	return state;
+}
-- 
2.35.1

