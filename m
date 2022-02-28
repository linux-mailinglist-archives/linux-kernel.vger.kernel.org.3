Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0C4C7BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiB1V3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiB1V3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:29:33 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97EA12F156
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:28:53 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 39461 invoked from network); 28 Feb 2022 22:28:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646083731; bh=j3DZPtWMuHI+dM3XWLQum0gNhB5TRsSDDVt7Byh+LvQ=;
          h=From:To:Cc:Subject;
          b=MH7UzumJcHFJcKkZZShU18DAidxlXBGZwrQ7mvuQasvxv+Asj633EsrCyEFzS0ueU
           aUOd+FTJfaYeeiyJTsxkFDYs/i5jdGxQXI8jLE/SsrurRmNGGpdnKDKbuU1/X2pgYi
           oMAp7NcBIkZLZ3c91mtK6Yi63WyXJGDfUXQuXwqM=
Received: from aafa139.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.130.139])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 28 Feb 2022 22:28:50 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 02/10] x86/apic: fix panic message when x2APIC is not supported
Date:   Mon, 28 Feb 2022 22:28:18 +0100
Message-Id: <20220228212826.27080-3-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228212826.27080-1-mat.jonczyk@o2.pl>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 32f4cd5e4a7dd40bb4d6feced50fbcb8
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [gaMk]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct course of action is to enable x2APIC support in the kernel,
not to disable it in the BIOS (which may be impossible).
x2APIC has performance and functionality benefits, so it is best to use
it if it is available on the platform.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b70344bf6600..840511aadbca 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1899,7 +1899,7 @@ static int __init validate_x2apic(void)
 	/*
 	 * Checkme: Can we simply turn off x2apic here instead of panic?
 	 */
-	panic("BIOS has enabled x2apic but kernel doesn't support x2apic, please disable x2apic in BIOS.\n");
+	panic("Kernel does not support x2APIC, please recompile with CONFIG_X86_X2APIC or disable x2APIC in BIOS");
 }
 early_initcall(validate_x2apic);
 
-- 
2.25.1

