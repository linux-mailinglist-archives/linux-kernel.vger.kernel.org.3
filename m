Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED04808B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhL1LHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 06:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhL1LHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 06:07:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D539FC061574;
        Tue, 28 Dec 2021 03:07:40 -0800 (PST)
Date:   Tue, 28 Dec 2021 11:07:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640689657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WG1XEyBl3EM/S+6dLGtTge8B/XvWO4KRht4pjAI5fbo=;
        b=SqF1R/SO7dZtk7Gg2lF47XxXB6yMyGGki/0wOONHCgHZGI9Vl/WnWCEe5qyrTLjzcFWg5R
        QuOYuLxNA/XJAuN/l+9dRSdCwuvUPVQDGmKB+9pU3YwTWqM7E0RnJ0dIGyoEvv/2NZYDgp
        TRFsWU9fB2gz/W0dg3sn+8Gc8USFgYHxhsCV7FakeGhUVfAMSoNzLODNgzelRdJgsDNRN6
        tIif8YH4j3yJLcp9iUa0hlA2Awp7tkGt26ILbuxIKCHucJyLta4LrAOoKFtxUacIvdldbD
        t+0i5c7ZNJBSJWvbYiT7CcEgYEnFtPZAYOgrGc28691qUvJeZqaWkkHLf3y1HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640689657;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WG1XEyBl3EM/S+6dLGtTge8B/XvWO4KRht4pjAI5fbo=;
        b=5e3US/GWHvrBsa8jDnWVc2Dwwi6NFg50GgAWC/gptgOD8Rjja4onze3EoavB4Sh+Jjub27
        pBOQvcUgy0/iSnAQ==
From:   "tip-bot2 for Zhang Zixun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/inject: Avoid out-of-bounds write when setting flags
Cc:     Zhang Zixun <zhang133010@icloud.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164068965610.16921.13613259509987305525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     de768416b203ac84e02a757b782a32efb388476f
Gitweb:        https://git.kernel.org/tip/de768416b203ac84e02a757b782a32efb388476f
Author:        Zhang Zixun <zhang133010@icloud.com>
AuthorDate:    Mon, 27 Dec 2021 22:02:49 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 28 Dec 2021 11:45:36 +01:00

x86/mce/inject: Avoid out-of-bounds write when setting flags

A contrived zero-length write, for example, by using write(2):

  ...
  ret = write(fd, str, 0);
  ...

to the "flags" file causes:

  BUG: KASAN: stack-out-of-bounds in flags_write
  Write of size 1 at addr ffff888019be7ddf by task writefile/3787

  CPU: 4 PID: 3787 Comm: writefile Not tainted 5.16.0-rc7+ #12
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014

due to accessing buf one char before its start.

Prevent such out-of-bounds access.

  [ bp: Productize into a proper patch. Link below is the next best
    thing because the original mail didn't get archived on lore. ]

Fixes: 0451d14d0561 ("EDAC, mce_amd_inj: Modify flags attribute to use string arguments")
Signed-off-by: Zhang Zixun <zhang133010@icloud.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/linux-edac/YcnePfF1OOqoQwrX@zn.tnic/
---
 arch/x86/kernel/cpu/mce/inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 6eac840..5fbd7ff 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -363,7 +363,7 @@ static ssize_t flags_write(struct file *filp, const char __user *ubuf,
 	char buf[MAX_FLAG_OPT_SIZE], *__buf;
 	int err;
 
-	if (cnt > MAX_FLAG_OPT_SIZE)
+	if (!cnt || cnt > MAX_FLAG_OPT_SIZE)
 		return -EINVAL;
 
 	if (copy_from_user(&buf, ubuf, cnt))
