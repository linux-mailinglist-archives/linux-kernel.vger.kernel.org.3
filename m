Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC24A3D36
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 06:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357679AbiAaFQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 00:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiAaFQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:16:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68CAC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 21:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ACC20CE107B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B326BC340E8;
        Mon, 31 Jan 2022 05:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643606193;
        bh=bCbdZtyVE9qqVHENCZvjLKCsXT+c8sh6hktPiiFReTc=;
        h=From:To:Cc:Subject:Date:From;
        b=YVL/smdUWvdpRpOZW1VTDZAnHmOlLkEGnJRvTvwKEjJgiwY33ruDwgUYgtuSDHz3L
         cp3Dm6dggqXD6z63v10JzF0cxZb1CciWG3CMoFwcFxkCIJ2NRWCd46ha57ARuX1A43
         RLFNciqKzfmveIwabZ4WzIZDpLf3nzCIlvL52Rdupv6qQxorD8TvZs2kdxRPf8scUk
         ixHdHeIirZCjtXpwJThKz4Hsvz+W6KHva2OIlLsBY7UHzNyZRfL3wSaY78e4T5q33s
         8QyuBFwFHx+7Tlr1mZxkcBeFGtAKnN5tCTQ93+ovwbRXnOX7uezwYsGBTechzppVRv
         sxBi9GEkfkAig==
From:   "Andrew G. Morgan" <morgan@kernel.org>
To:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     "Andrew G. Morgan" <morgan@kernel.org>
Subject: [PATCH] proc: add SecBits field to /proc/<PID>/status
Date:   Sun, 30 Jan 2022 21:15:58 -0800
Message-Id: <20220131051558.77127-1-morgan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Securebits strongly influence the way Capabilities work for a process,
make them visible in the proc status files.

Example (aka PURE1E mode):

   SecBits: 239 (RS_A)

The text convention for summarizing the bits (uapi/linux/securebits.h) is:

Key (lower case if unlocked, upper case if locked):

   r = noRoot
   s = no_Setuid_fixup
   k = Keep_caps
   a = no_cap_Ambient_raise

else:

   _ = locked-not-set
   . = unlocked-not-set

Reviewed-by: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Andrew G. Morgan <morgan@kernel.org>
---
 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/array.c                    | 26 ++++++++++++++++++++++++++
 include/uapi/linux/securebits.h    | 20 ++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 061744c436d9..1b61db2a55ce 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -207,6 +207,7 @@ read the file /proc/PID/status::
   CapEff: 0000000000000000
   CapBnd: ffffffffffffffff
   CapAmb: 0000000000000000
+  SecBits:        239 (RS_A)
   NoNewPrivs:     0
   Seccomp:        0
   Speculation_Store_Bypass:       thread vulnerable
@@ -290,6 +291,8 @@ It's slow but very precise.
  CapEff                      bitmap of effective capabilities
  CapBnd                      bitmap of capabilities bounding set
  CapAmb                      bitmap of ambient capabilities
+ SecBits                     numerical value of secbits (with text summary:
+                             see include/uapi/linux/securebits.h for key).
  NoNewPrivs                  no_new_privs, like prctl(PR_GET_NO_NEW_PRIV, ...)
  Seccomp                     seccomp mode, like prctl(PR_GET_SECCOMP, ...)
  Speculation_Store_Bypass    speculative store bypass mitigation status
diff --git a/fs/proc/array.c b/fs/proc/array.c
index fd8b0c12b2cb..da72cd5258e7 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -60,6 +60,7 @@
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
 #include <linux/tty.h>
+#include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/mman.h>
 #include <linux/sched/mm.h>
@@ -93,6 +94,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_struct.h>
 #include <linux/kthread.h>
+#include <linux/securebits.h>
 
 #include <asm/processor.h>
 #include "internal.h"
@@ -308,11 +310,33 @@ static void render_cap_t(struct seq_file *m, const char *header,
 	seq_putc(m, '\n');
 }
 
+static const char secbit_flags[] = SECBIT_FLAGS;
+
+static void render_secbits(struct seq_file *m, unsigned securebits)
+{
+	int i;
+	char c;
+
+	seq_put_decimal_ull(m, "SecBits:\t", securebits);
+	seq_puts(m, "\t(");
+	for (i=0; (c = secbit_flags[i]); i++) {
+		int combo = (securebits >> (2*i)) & 0x3;
+		if (!(combo & 1)) {
+			c = ".?_"[combo];
+		} else if (combo & 2) {
+			c = __toupper(c);
+		}
+		seq_putc(m, c);
+	}
+	seq_puts(m, ")\n");
+}
+
 static inline void task_cap(struct seq_file *m, struct task_struct *p)
 {
 	const struct cred *cred;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective,
 			cap_bset, cap_ambient;
+	unsigned securebits;
 
 	rcu_read_lock();
 	cred = __task_cred(p);
@@ -321,6 +345,7 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
 	cap_effective	= cred->cap_effective;
 	cap_bset	= cred->cap_bset;
 	cap_ambient	= cred->cap_ambient;
+	securebits	= cred->securebits;
 	rcu_read_unlock();
 
 	render_cap_t(m, "CapInh:\t", &cap_inheritable);
@@ -328,6 +353,7 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
 	render_cap_t(m, "CapEff:\t", &cap_effective);
 	render_cap_t(m, "CapBnd:\t", &cap_bset);
 	render_cap_t(m, "CapAmb:\t", &cap_ambient);
+	render_secbits(m, securebits);
 }
 
 static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/securebits.h
index d6d98877ff1a..df39c6a27b07 100644
--- a/include/uapi/linux/securebits.h
+++ b/include/uapi/linux/securebits.h
@@ -52,6 +52,26 @@
 #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
 			(issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED))
 
+/* One character for each bit pair summarizing the bit's state in the
+   /proc/<PID>/status file. If you add another bit pair, assign it a
+   lower case letter at the end of this string to have it show up in
+   the "SecBits:" line. Example, "SecBits:\t239\t(RS_A)" (aka PURE1E
+   mode).
+
+   Key (lower case if unlocked, upper case if locked):
+
+      r = noRoot
+      s = no_Setuid_fixup
+      k = Keep_caps
+      a = no_cap_Ambient_raise
+
+   else:
+
+      _ = locked-not-set
+      . = unlocked-not-set
+ */
+#define SECBIT_FLAGS    "rska"
+
 #define SECURE_ALL_BITS		(issecure_mask(SECURE_NOROOT) | \
 				 issecure_mask(SECURE_NO_SETUID_FIXUP) | \
 				 issecure_mask(SECURE_KEEP_CAPS) | \
-- 
2.34.1

