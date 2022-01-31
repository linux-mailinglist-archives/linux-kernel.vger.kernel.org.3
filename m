Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222784A3C93
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 03:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357364AbiAaC3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 21:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiAaC3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 21:29:18 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E6FC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 18:29:18 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEMRG-005yv8-9D; Mon, 31 Jan 2022 02:29:06 +0000
Date:   Mon, 31 Jan 2022 02:29:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-um@lists.infradead.org
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Message-ID: <YfdJcu1xE1kv55Up@zeniv-ca.linux.org.uk>
References: <202111180219.YkyoBMpf-lkp@intel.com>
 <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
 <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
 <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
 <Ycv5mF+gfGxlmmQL@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ycv5mF+gfGxlmmQL@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 06:00:56AM +0000, Al Viro wrote:
> On Thu, Nov 18, 2021 at 05:00:58PM +0100, Peter Zijlstra wrote:
> 
> > Dear um folks, is this indeed the best solution? It's a bit sad to have
> > to add this to x86_64, but if that's the way it is...
> 
> Something like this, perhaps? (absolutely untested)

[snip]
AFAICS, this (on top of current mainline) does the right thing.

commit 6692531df62d812de5d22c8bca0d90edc163aa84
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jan 30 21:25:53 2022 -0500

    uml/x86: use x86 load_unaligned_zeropad()
    
    allows, among other things, to drop !DCACHE_WORD_ACCESS mess in
    x86 csum-partial_64.c
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index e5a7b552bb384..a58b67ec8119d 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -23,7 +23,6 @@ generic-y += softirq_stack.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += word-at-a-time.h
 generic-y += kprobes.h
 generic-y += mm_hooks.h
 generic-y += vga.h
diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1f8a8f8951738..50734a23034c4 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -93,7 +93,6 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		buff += 8;
 	}
 	if (len & 7) {
-#ifdef CONFIG_DCACHE_WORD_ACCESS
 		unsigned int shift = (8 - (len & 7)) * 8;
 		unsigned long trail;
 
@@ -103,31 +102,6 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    "adcq $0,%[res]"
 			: [res] "+r" (temp64)
 			: [trail] "r" (trail));
-#else
-		if (len & 4) {
-			asm("addq %[val],%[res]\n\t"
-			    "adcq $0,%[res]"
-				: [res] "+r" (temp64)
-				: [val] "r" ((u64)*(u32 *)buff)
-				: "memory");
-			buff += 4;
-		}
-		if (len & 2) {
-			asm("addq %[val],%[res]\n\t"
-			    "adcq $0,%[res]"
-				: [res] "+r" (temp64)
-				: [val] "r" ((u64)*(u16 *)buff)
-				: "memory");
-			buff += 2;
-		}
-		if (len & 1) {
-			asm("addq %[val],%[res]\n\t"
-			    "adcq $0,%[res]"
-				: [res] "+r" (temp64)
-				: [val] "r" ((u64)*(u8 *)buff)
-				: "memory");
-		}
-#endif
 	}
 	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
 	if (unlikely(odd)) {
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 40d6a06e41c81..4eb47d3ba6250 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -8,6 +8,7 @@ endmenu
 
 config UML_X86
 	def_bool y
+	select DCACHE_WORD_ACCESS
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
