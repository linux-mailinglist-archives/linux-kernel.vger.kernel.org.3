Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5250875D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378250AbiDTLxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiDTLxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:53:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D442511A1B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:50:28 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 897111EC04EC;
        Wed, 20 Apr 2022 13:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650455427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=QcJGoUKK849qjQfP32KT/DB395vjWIaLjTRFtrLgTuM=;
        b=jaMNswgxDqnjPA7/EwDWeH05ltD+uM/+vnRG3VTzzayBMBM1VsdbYJUCNOkVqcZ1Fqn4Hk
        Ymzh2wmsJTuf6VNHzuOUuMLyVbn5qvCq05aDgX61YeH965OHoNvhuVG/yh+3VPyDPDFAKm
        eSjbZoOanroDJDmBtcOSrl61Ay7o7pg=
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/tdx: Annotate a noreturn function
Date:   Wed, 20 Apr 2022 13:50:25 +0200
Message-Id: <20220420115025.5448-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

objdump complains:

  vmlinux.o: warning: objtool: __tdx_hypercall()+0x74: unreachable instruction

because __tdx_hypercall_failed() won't return but panic the guest.
Annotate that that is ok and desired.

Fixes: eb94f1b6a70a ("x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions")
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/coco/tdx/tdcall.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 245888290bb6..eeb4511dc414 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -200,5 +200,6 @@ SYM_FUNC_START(__tdx_hypercall)
 .Lpanic:
 	call __tdx_hypercall_failed
 	/* __tdx_hypercall_failed never returns */
+	REACHABLE
 	jmp .Lpanic
 SYM_FUNC_END(__tdx_hypercall)
-- 
2.35.1

