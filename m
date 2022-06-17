Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7554FF87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiFQVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiFQVxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:53:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736D01408C;
        Fri, 17 Jun 2022 14:53:22 -0700 (PDT)
Date:   Fri, 17 Jun 2022 21:53:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655502800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcfnOHV5Bp8+Ur3r0BXq4INHHC+9B8ptbgLOlJRz1nU=;
        b=FQEpO4bskcdgwDcy9z+yvR7K9Vpl9+IMcdlAfDIFDnfTuuD9Z3Fpd9Lu49Eb4tJe6Axj7u
        Q2QpEIAsreiPXAbIDs8fajkP3iWjNW24qmruFit04x9tt5b9ibx7GBaiYR1ebZD3HwgDN3
        j7mbhMrEDOFbEMqulgVql6LsY+fgaqY0tdbT7fsbWqoqgsAFFerGwaE+v1s4ThfzwTGSrM
        tPZRLdUnueiVFEHaq2855v+8BsbgjJfTvb63uTANneu/7S5BhwfdSs1Mdw0rVXkifg/LZv
        fnfXTq42iAUmqgRyubpkaf5b/kER9p3/KIY/EMgiK+mfvjyWYLyebYJgZ/nMLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655502800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcfnOHV5Bp8+Ur3r0BXq4INHHC+9B8ptbgLOlJRz1nU=;
        b=ICXbvaBXHALub84M3Z/hNXbDL/GbDzNT8PgTJU4mqvq4rBzEIK1pXxrwgSaPusXLU2WxZ4
        mvMH3F/O6j2WVwAg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tdx: Fix early #VE handling
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220614120135.14812-2-kirill.shutemov@linux.intel.com>
References: <20220614120135.14812-2-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <165550279938.4207.12499626093792732000.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     60428d8bc27f52e8f1540f98e1b6ef0156d43f0d
Gitweb:        https://git.kernel.org/tip/60428d8bc27f52e8f1540f98e1b6ef0156d43f0d
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 14 Jun 2022 15:01:33 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 15 Jun 2022 10:52:59 -07:00

x86/tdx: Fix early #VE handling

tdx_early_handle_ve() does not increment RIP after successfully
handling the exception.  That leads to infinite loop of exceptions.

Move RIP when exceptions are successfully handled.

[ dhansen: make problem statement more clear ]

Fixes: 32e72854fa5f ("x86/tdx: Port I/O: Add early boot support")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://lkml.kernel.org/r/20220614120135.14812-2-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 03deb4d..faae53f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -447,13 +447,17 @@ static bool handle_io(struct pt_regs *regs, u32 exit_qual)
 __init bool tdx_early_handle_ve(struct pt_regs *regs)
 {
 	struct ve_info ve;
+	bool ret;
 
 	tdx_get_ve_info(&ve);
 
 	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
 		return false;
 
-	return handle_io(regs, ve.exit_qual);
+	ret = handle_io(regs, ve.exit_qual);
+	if (ret)
+		regs->ip += ve.instr_len;
+	return ret;
 }
 
 void tdx_get_ve_info(struct ve_info *ve)
