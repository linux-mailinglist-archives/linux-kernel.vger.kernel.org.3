Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73004B19C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbiBJXrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:47:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245029AbiBJXrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:47:05 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA15F6C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:47:05 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id j24so6629990qkk.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gGkHPLqBQKDsGoPmAyVSh4TYPJ0or382g4vYKeAbj9k=;
        b=Z0iEVeiDJDrqgnuQUo4TAvgwcXJbVN1mbL1mlhsB41Xu/KhWJJf9aEtOe3JS5rAqVM
         /WXBakO1J2nP9r0LWFX+8wyhYMALfRyk4QxyRLlXe8q4TqP9pk8UA6OLvtrFFEcRYMXj
         +lTkqDl2XhNNZ5A19ONY7fUxXo4cGkVHQGkNmOeIwiWwtza+Pk7FVhdT4U9O7dyZQ0ew
         msfnGNc2QANssGVLDL28MoVZJem4RYA3hZO5fyJZgcDntdlO0qsBoyK+Rqp09uKpNy1c
         iBhgf3hgjhEfTS4ijGMv3lYg9dL68LzoyO+Vdh0RDbWOE6IF8l0/qfjLq8ucpGI6YZ6h
         vnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGkHPLqBQKDsGoPmAyVSh4TYPJ0or382g4vYKeAbj9k=;
        b=O80+Qfogg8gOuT+5iwEuOibD/5Hxrdm7dVuhoMvjTGWSNqxXyIx550N0uI4DgYcVBf
         lGIUeHdXmuIsHx25xbmgGzApvHspjKd6iyu8JqtVM1KyptdV1lbtLGMMynx+ajlQxvli
         J3SRnCnDZ8XEJbpkOn374EegVbkDyz+ncz6zrdNKFGxPPMAN3fraGq3UNuoWx9PR44iD
         pkD5EmjLfj3+O4EQtqvdSEgMxQBqJz26rKPdVue9/ZS3f98YAFLiqQOjDI+Ceae0Ikqo
         ylPlfU/N8561TJVg3ye3omjbjAqhNvi/zbQOTgDcLk0YOMHxF1yQjbiuMBtPnV769+hO
         Y6Vw==
X-Gm-Message-State: AOAM530nNtyOmAxLwCgWSSNvdLYiQnpep5aBpZ3WOvZrEQHZcOje18XJ
        TXRiPZhjNBbmZmmCOCe4wAo=
X-Google-Smtp-Source: ABdhPJx6mdswTdq3gyvbThBS8ISzTGJZyPjLxz4l3MqVL6OVv538vYhN/VnV6TPMLq64RMV/nMqiKQ==
X-Received: by 2002:a05:620a:4502:: with SMTP id t2mr5111507qkp.311.1644536824596;
        Thu, 10 Feb 2022 15:47:04 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id bp37sm10202111qkb.135.2022.02.10.15.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:47:04 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 25/49] arch/x86: replace nodes_weight with nodes_empty where appropriate
Date:   Thu, 10 Feb 2022 14:49:09 -0800
Message-Id: <20220210224933.379149-26-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm code calls nodes_weight() to check if any bit of a given nodemask is
set. We can do it more efficiently with nodes_empty() because nodes_empty()
stops traversing the nodemask as soon as it finds first set bit, while
nodes_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/mm/amdtopology.c    | 2 +-
 arch/x86/mm/numa_emulation.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
index 058b2f36b3a6..b3ca7d23e4b0 100644
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -154,7 +154,7 @@ int __init amd_numa_init(void)
 		node_set(nodeid, numa_nodes_parsed);
 	}
 
-	if (!nodes_weight(numa_nodes_parsed))
+	if (nodes_empty(numa_nodes_parsed))
 		return -ENOENT;
 
 	/*
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 1a02b791d273..9a9305367fdd 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -123,7 +123,7 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
 	 * Continue to fill physical nodes with fake nodes until there is no
 	 * memory left on any of them.
 	 */
-	while (nodes_weight(physnode_mask)) {
+	while (!nodes_empty(physnode_mask)) {
 		for_each_node_mask(i, physnode_mask) {
 			u64 dma32_end = PFN_PHYS(MAX_DMA32_PFN);
 			u64 start, limit, end;
@@ -270,7 +270,7 @@ static int __init split_nodes_size_interleave_uniform(struct numa_meminfo *ei,
 	 * Fill physical nodes with fake nodes of size until there is no memory
 	 * left on any of them.
 	 */
-	while (nodes_weight(physnode_mask)) {
+	while (!nodes_empty(physnode_mask)) {
 		for_each_node_mask(i, physnode_mask) {
 			u64 dma32_end = PFN_PHYS(MAX_DMA32_PFN);
 			u64 start, limit, end;
-- 
2.32.0

