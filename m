Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633BC51F8E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiEIJf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237939AbiEIJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:21:24 -0400
X-Greylist: delayed 610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 02:17:29 PDT
Received: from mail.codelabs.ch (mail.codelabs.ch [IPv6:2a02:168:860f:1::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449901A0AC5
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:17:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.codelabs.ch (Postfix) with ESMTP id 018F6220003;
        Mon,  9 May 2022 11:07:18 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
        by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ccGl6xt2DNZR; Mon,  9 May 2022 11:07:16 +0200 (CEST)
Received: from zaphod.codelabs.ch (unknown [192.168.10.129])
        by mail.codelabs.ch (Postfix) with ESMTPSA id BA72C220001;
        Mon,  9 May 2022 11:07:16 +0200 (CEST)
From:   Adrian-Ken Rueegsegger <ken@codelabs.ch>
To:     dave.hansen@linux.intel.com, osalvador@suse.de
Cc:     david@redhat.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Adrian-Ken Rueegsegger <ken@codelabs.ch>
Subject: [PATCH] x86/mm: Fix marking of unused sub-pmd ranges
Date:   Mon,  9 May 2022 11:06:37 +0200
Message-Id: <20220509090637.24152-2-ken@codelabs.ch>
In-Reply-To: <20220509090637.24152-1-ken@codelabs.ch>
References: <20220509090637.24152-1-ken@codelabs.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unused part precedes the new range spanned by the start, end
parameters of vmemmap_use_new_sub_pmd. This means it actually goes from
ALIGN_DOWN(start, PMD_SIZE) up to start. Use the correct address when
applying the mark using memset.

Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Signed-off-by: Adrian-Ken Rueegsegger <ken@codelabs.ch>
---
 arch/x86/mm/init_64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 96d34ebb20a9..e2942335d143 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -902,6 +902,8 @@ static void __meminit vmemmap_use_sub_pmd(unsigned long start, unsigned long end
 
 static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
 {
+	const unsigned long page = ALIGN_DOWN(start, PMD_SIZE);
+
 	vmemmap_flush_unused_pmd();
 
 	/*
@@ -914,8 +916,7 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
 	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
 	 */
 	if (!IS_ALIGNED(start, PMD_SIZE))
-		memset((void *)start, PAGE_UNUSED,
-			start - ALIGN_DOWN(start, PMD_SIZE));
+		memset((void *)page, PAGE_UNUSED, start - page);
 
 	/*
 	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of
-- 
2.30.2

