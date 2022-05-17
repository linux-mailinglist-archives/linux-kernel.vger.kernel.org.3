Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9815B5299FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiEQG6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbiEQG6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:58:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406DF3CFC6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:58:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so29630561lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:reply-to:content-transfer-encoding;
        bh=1RvgKJ6LvNRwpDqbWjhSHqRjqbALbxe9WSC5YoB1n3M=;
        b=4ofP/QmIn0Ha+/IoETbP26y/1YXDl9NYa76GpbV1x2jtShvYRG5BBAFub2bSgyKTCg
         1iqD/ultqkysZd62hwyWznfZDmPRa+8U+A3A8ymPT3PXHUnRTDra/GFt7IKMJb2xWKQ1
         u7YMZ+kE1e/nNKNlf8uD7iFXiYlAmxu4f2UVpqo3MlbJ2/Mfcd/gQRlpyc57tdfb7Af9
         TvbbWkkeR7E2eSnH3z1N3D9FeV7cvJiurq2MY/zeD0SmJIYNUjGEiAZqjPeFZCCvfAfe
         VwmKx/qBVQLymHnopbowsHyPSO+AXBmIWnPekuth5vmHOEA9GUmchRmwOrPG6S4Wafyb
         rxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:reply-to:content-transfer-encoding;
        bh=1RvgKJ6LvNRwpDqbWjhSHqRjqbALbxe9WSC5YoB1n3M=;
        b=tjuWcS5PaYepTCob7OjFx1/zYXZWxnhinV4R/zXq1yjAlJT2X6F7P+z9H9Ff+LT+uh
         KT2th9putcSmq0RIimzwCaYVRvUxO3hK5w/5u4OVg+G9WPif+NZAo4prgq9iX3RCcca+
         hS5LLlRjLbYZIvrj4A4jp1sc+qZ00nJiVRNR40ybH8sNCdZiqNA+gTrSWktnhoslh3mQ
         1qOVdcvmCsrIETcC24Mvmz49g4mvU69U9Dw8Bff6yOYghoIbuXR/quPBebT97F4Ku0KJ
         2fqL3urhU06PDyyTBgX/3lQDJlAa4hNVP/izywGMTL3kpI8/5RfThWWTwpGFOVaVlT0z
         oOLA==
X-Gm-Message-State: AOAM533YM+jjx/q0p5i5DkvQ0d/v34gtUIrjm3bqlZHRhFczLsZFbKwQ
        t2hThtNhOpSshR5/KBtKAaXRzZ6SSm6MMg==
X-Google-Smtp-Source: ABdhPJxQiYOTTwfhcNqXc4iNzdCwgn9Wb/kdPusee9Rz30iAZ0YokR51Jy/E+754zL2U4qWSxHvMnw==
X-Received: by 2002:a05:6512:3888:b0:477:a898:2e75 with SMTP id n8-20020a056512388800b00477a8982e75mr592971lft.147.1652770695610;
        Mon, 16 May 2022 23:58:15 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id d23-20020a056512369700b00473cb4f7cf6sm1487674lfs.309.2022.05.16.23.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 23:58:15 -0700 (PDT)
Message-ID: <6f811e19-41c6-f3e8-fca6-23a19a62e313@openvz.org>
Date:   Tue, 17 May 2022 09:58:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm-stable] cleanup for "tracing: incorrect gfp_t conversion"
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>
Content-Language: en-US
Reply-To: 20220516135537.8458fe08464d97bb45684252@linux-foundation.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch re-defines __def_gfpflag_names array according to
akpm@, willy@ and Joe Perches recommendations.

Fixes: fe573327ffb1 ("tracing: incorrect gfp_t conversion")
Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 include/trace/events/mmflags.h | 84 +++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index fcb1ffb2cc8d..e87cb2b80ed3 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -13,49 +13,51 @@
  * Thus most bits set go first.
  */
 
-#define __def_gfpflag_names						\
-	{(__force unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
-	{(__force unsigned long)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
-	{(__force unsigned long)GFP_HIGHUSER_MOVABLE,	"GFP_HIGHUSER_MOVABLE"},\
-	{(__force unsigned long)GFP_HIGHUSER,		"GFP_HIGHUSER"},	\
-	{(__force unsigned long)GFP_USER,		"GFP_USER"},		\
-	{(__force unsigned long)GFP_KERNEL_ACCOUNT,	"GFP_KERNEL_ACCOUNT"},	\
-	{(__force unsigned long)GFP_KERNEL,		"GFP_KERNEL"},		\
-	{(__force unsigned long)GFP_NOFS,		"GFP_NOFS"},		\
-	{(__force unsigned long)GFP_ATOMIC,		"GFP_ATOMIC"},		\
-	{(__force unsigned long)GFP_NOIO,		"GFP_NOIO"},		\
-	{(__force unsigned long)GFP_NOWAIT,		"GFP_NOWAIT"},		\
-	{(__force unsigned long)GFP_DMA,		"GFP_DMA"},		\
-	{(__force unsigned long)__GFP_HIGHMEM,		"__GFP_HIGHMEM"},	\
-	{(__force unsigned long)GFP_DMA32,		"GFP_DMA32"},		\
-	{(__force unsigned long)__GFP_HIGH,		"__GFP_HIGH"},		\
-	{(__force unsigned long)__GFP_ATOMIC,		"__GFP_ATOMIC"},	\
-	{(__force unsigned long)__GFP_IO,		"__GFP_IO"},		\
-	{(__force unsigned long)__GFP_FS,		"__GFP_FS"},		\
-	{(__force unsigned long)__GFP_NOWARN,		"__GFP_NOWARN"},	\
-	{(__force unsigned long)__GFP_RETRY_MAYFAIL,	"__GFP_RETRY_MAYFAIL"},	\
-	{(__force unsigned long)__GFP_NOFAIL,		"__GFP_NOFAIL"},	\
-	{(__force unsigned long)__GFP_NORETRY,		"__GFP_NORETRY"},	\
-	{(__force unsigned long)__GFP_COMP,		"__GFP_COMP"},		\
-	{(__force unsigned long)__GFP_ZERO,		"__GFP_ZERO"},		\
-	{(__force unsigned long)__GFP_NOMEMALLOC,	"__GFP_NOMEMALLOC"},	\
-	{(__force unsigned long)__GFP_MEMALLOC,		"__GFP_MEMALLOC"},	\
-	{(__force unsigned long)__GFP_HARDWALL,		"__GFP_HARDWALL"},	\
-	{(__force unsigned long)__GFP_THISNODE,		"__GFP_THISNODE"},	\
-	{(__force unsigned long)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},	\
-	{(__force unsigned long)__GFP_MOVABLE,		"__GFP_MOVABLE"},	\
-	{(__force unsigned long)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},	\
-	{(__force unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
-	{(__force unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
-	{(__force unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
-	{(__force unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"},\
-	{(__force unsigned long)__GFP_ZEROTAGS,		"__GFP_ZEROTAGS"}	\
+#define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
+
+#define __def_gfpflag_names			\
+	gfpflag_string(GFP_TRANSHUGE),		\
+	gfpflag_string(GFP_TRANSHUGE_LIGHT),	\
+	gfpflag_string(GFP_HIGHUSER_MOVABLE),	\
+	gfpflag_string(GFP_HIGHUSER),		\
+	gfpflag_string(GFP_USER),		\
+	gfpflag_string(GFP_KERNEL_ACCOUNT),	\
+	gfpflag_string(GFP_KERNEL),		\
+	gfpflag_string(GFP_NOFS),		\
+	gfpflag_string(GFP_ATOMIC),		\
+	gfpflag_string(GFP_NOIO),		\
+	gfpflag_string(GFP_NOWAIT),		\
+	gfpflag_string(GFP_DMA),		\
+	gfpflag_string(__GFP_HIGHMEM),		\
+	gfpflag_string(GFP_DMA32),		\
+	gfpflag_string(__GFP_HIGH),		\
+	gfpflag_string(__GFP_ATOMIC),		\
+	gfpflag_string(__GFP_IO),		\
+	gfpflag_string(__GFP_FS),		\
+	gfpflag_string(__GFP_NOWARN),		\
+	gfpflag_string(__GFP_RETRY_MAYFAIL),	\
+	gfpflag_string(__GFP_NOFAIL),		\
+	gfpflag_string(__GFP_NORETRY),		\
+	gfpflag_string(__GFP_COMP),		\
+	gfpflag_string(__GFP_ZERO),		\
+	gfpflag_string(__GFP_NOMEMALLOC),	\
+	gfpflag_string(__GFP_MEMALLOC),		\
+	gfpflag_string(__GFP_HARDWALL),		\
+	gfpflag_string(__GFP_THISNODE),		\
+	gfpflag_string(__GFP_RECLAIMABLE),	\
+	gfpflag_string(__GFP_MOVABLE),		\
+	gfpflag_string(__GFP_ACCOUNT),		\
+	gfpflag_string(__GFP_WRITE),		\
+	gfpflag_string(__GFP_RECLAIM),		\
+	gfpflag_string(__GFP_DIRECT_RECLAIM),	\
+	gfpflag_string(__GFP_KSWAPD_RECLAIM),	\
+	gfpflag_string(__GFP_ZEROTAGS)
 
 #ifdef CONFIG_KASAN_HW_TAGS
-#define __def_gfpflag_names_kasan ,					       \
-	{(__force unsigned long)__GFP_SKIP_ZERO,	   "__GFP_SKIP_ZERO"},	       \
-	{(__force unsigned long)__GFP_SKIP_KASAN_POISON,   "__GFP_SKIP_KASAN_POISON"}, \
-	{(__force unsigned long)__GFP_SKIP_KASAN_UNPOISON, "__GFP_SKIP_KASAN_UNPOISON"}
+#define __def_gfpflag_names_kasan ,			\
+	gfpflag_string(__GFP_SKIP_ZERO),		\
+	gfpflag_string(__GFP_SKIP_KASAN_POISON),	\
+	gfpflag_string(__GFP_SKIP_KASAN_UNPOISON)
 #else
 #define __def_gfpflag_names_kasan
 #endif
-- 
2.31.1

