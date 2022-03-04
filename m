Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1AF4CD166
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiCDJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbiCDJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C54E1AAFD7;
        Fri,  4 Mar 2022 01:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A571B827BA;
        Fri,  4 Mar 2022 09:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1354C340E9;
        Fri,  4 Mar 2022 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386603;
        bh=55zyzQl0Utut0R3HWtDL9uTt0ymhG7PO+ZXLPy+52CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tnj7wGX5mtfbPPE8l/IusJSbXGvTBWmDF/6tMYQ0mFiUW6ru9fGw2jG6h21LDY+Qt
         20ACoJLcGOj1MbECyj9yxBr5RL4RInSAna8JyBgZ5OuucK1U8MbBGhKPZ+ievtR6bp
         fP57LaSQOyyliv9NY456JQZqv5Fo8HiCT8COZNScHOn3EDmlUT8Ey860wvy0ShzAJ/
         vgv+xdhqoq1YU4Hj4+yIlnMsa5BjuD6G8RjAgMP3OwFP5Gg3Xwwtzk6FoKTx4+phWH
         FiHck6GE0OtBOPIx3HQNfonufc6EQ0m3gayXWI3W4LLpdZmpTff2IlJDJvJhfUmHxz
         iMjke9QhulTpQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [RFC PATCH v2.1 11/30] x86/sgx: Make sgx_ipi_cb() available internally
Date:   Fri,  4 Mar 2022 11:35:05 +0200
Message-Id: <20220304093524.397485-11-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The ETRACK function followed by an IPI to all CPUs within an enclave
is a common pattern with more frequent use in support of SGX2.

Make the (empty) IPI callback function available internally in
preparation for usage by SGX2.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 arch/x86/kernel/cpu/sgx/sgx.h  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 06492dcffcf1..1a3014aec490 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -172,7 +172,7 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
 	return ret;
 }
 
-static void sgx_ipi_cb(void *info)
+void sgx_ipi_cb(void *info)
 {
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 0f17def9fe6f..b30cee4de903 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -90,6 +90,8 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 
+void sgx_ipi_cb(void *info);
+
 #ifdef CONFIG_X86_SGX_KVM
 int __init sgx_vepc_init(void);
 #else
-- 
2.35.1

