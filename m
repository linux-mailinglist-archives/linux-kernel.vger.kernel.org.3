Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA3B542CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiFHKPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiFHKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:13:15 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D7F220779
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:59:45 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id BF2861E80D76;
        Wed,  8 Jun 2022 17:59:17 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OU5N-MUYhBoA; Wed,  8 Jun 2022 17:59:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 29B4E1E80CB8;
        Wed,  8 Jun 2022 17:59:15 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     bp@alien8.de, mingo@redhat.com, tglx@linutronix.de
Cc:     dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH v2] x86: replace_intsrc_all function removes unused return values
Date:   Wed,  8 Jun 2022 17:59:05 +0800
Message-Id: <20220608095904.83592-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220608081625.82731-1-xupengfei@nfschina.com>
References: <20220608081625.82731-1-xupengfei@nfschina.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the return value of the replace_intsrc_all function to
void to reduce eAX register calls .

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 arch/x86/kernel/mpparse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f90116..0c9b9db9cac3 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -723,7 +723,7 @@ static
 inline void __init check_irq_src(struct mpc_intsrc *m, int *nr_m_spare) {}
 #endif /* CONFIG_X86_IO_APIC */
 
-static int  __init replace_intsrc_all(struct mpc_table *mpc,
+static void  __init replace_intsrc_all(struct mpc_table *mpc,
 					unsigned long mpc_new_phys,
 					unsigned long mpc_new_length)
 {
@@ -793,8 +793,6 @@ static int  __init replace_intsrc_all(struct mpc_table *mpc,
 	/* update checksum */
 	mpc->checksum = 0;
 	mpc->checksum -= mpf_checksum((unsigned char *)mpc, mpc->length);
-
-	return 0;
 }
 
 int enable_update_mptable;
-- 
2.18.2

