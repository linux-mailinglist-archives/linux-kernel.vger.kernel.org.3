Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE04FFD23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiDMRzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiDMRzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:55:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925F6D3BE;
        Wed, 13 Apr 2022 10:52:47 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:52:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649872365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/JagWb3bJZxrgaefpu0RP7IlAuGtfyhqOL6bvOWQkQ=;
        b=xPIy/rESypWYbKNZmb5JCybiEGaSHd7i9bidO2m6wFxJss5ehJq/OZgf+g9XxBRBs/krn6
        B4wvHG7HBcmz390rYPyndQ0rzm1z/6HF6S27E5U6FggFC62ARY6Fr5AQECiVTkPwFTv771
        JWXyuwLKo9tidI+MMNRciHkutTI+B8ahe/0GxOb26lHkVMayR6+DFy39Yaq7MXlhP5kcE+
        IdyudCXDCzMCLe4gJu4R4aUX+bdwxi6oymg41AkAFkDqgRrKX9HX0NC/5a6nNuDzCyL5kB
        AK6jQo52Q6AP8ex/+OP1BDYJMnnsP3TUQTxJr+VBaFcR84W5HdtEWn33Te34eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649872365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/JagWb3bJZxrgaefpu0RP7IlAuGtfyhqOL6bvOWQkQ=;
        b=w1oyA3r7grVdbYeB8/ZUVNd7Z68KP9Dig4o/hrej6zQWdbOMMPEKuaGZnynCFzKCE+Pdn/
        W0ygVfvZqhuhK6Cg==
From:   "tip-bot2 for Eric DeVolder" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kdump] x86/crash: Fix minor typo/bug in debug message
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        Borislav Petkov <bp@suse.de>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220413164237.20845-2-eric.devolder@oracle.com>
References: <20220413164237.20845-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Message-ID: <164987236423.4207.6815235390586822382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kdump branch of tip:

Commit-ID:     b57a7c9dd732ca29c4400a9a710c56c55877086d
Gitweb:        https://git.kernel.org/tip/b57a7c9dd732ca29c4400a9a710c56c55877086d
Author:        Eric DeVolder <eric.devolder@oracle.com>
AuthorDate:    Wed, 13 Apr 2022 12:42:30 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 13 Apr 2022 19:39:54 +02:00

x86/crash: Fix minor typo/bug in debug message

The pr_debug() intends to display the memsz member, but the
parameter is actually the bufsz member (which is already
displayed). Correct this to display memsz value.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Baoquan He <bhe@redhat.com>
Link: https://lore.kernel.org/r/20220413164237.20845-2-eric.devolder@oracle.com
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e8326a8..9730c88 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
 	}
 	image->elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	return ret;
 }
