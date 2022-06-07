Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2671D53F9EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbiFGJgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiFGJfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:35:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878DE64DD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:35:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s13so18522067ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9Luysd5PeLuzQcmOTrN0C4TCxyraTACP2lGutp0njA=;
        b=OEFcGHiOWs02B1U8ZYucL+4EF4y74Ze4l8dk9hmWMK3FoD023sKgQyHBsewvH7pJJl
         YvTh8LFtnuzqGOI9PLLplzSzXYJZFK1gYVHuzABkUbwQsoGxgOQgNEusCnjNcnFvnjkd
         Yl9vUMntxnBPqg1POJJlwrG5civzSjESScL8j/tnlRVv2mn5cmcGkdIeLN7YA/CbyZav
         2YVtDUw6X4+2rEN7OA2BrLqdkiZyumlkDfUd5zqAO5M+qMIjTDWVTlyAICItcGoGiyLT
         YBlyritdBTzazGnA/7VDfcoiLM939ljQagYCiIs7486TAFH38GeJvgIxpjgwoKGRT33Y
         +CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9Luysd5PeLuzQcmOTrN0C4TCxyraTACP2lGutp0njA=;
        b=w+hLa00VThLlQcI7dKcKsFxLjH/lig5xsg9WG2TDqzkViXmxWqxPKktgyEWZEwap+0
         GngUzPv3U19YBGlu7645wsMjafh7a98ih9iE8yWmoV6n9+9GtqerejhsrEYXr/CQqN3g
         Bzk8uCYGiNeVQrA2cnFY8jTyQNE8P3wQ+1Ny69FX5r76TLRjGNPS2t4v2Y8pjVeqyY0b
         FoRJSur2BVwParC4hOulHbOM73yzX6Wy4LDo52bn0Zb6T8MCcKVjS3TJ3bjNAhETBn4x
         z8OxxHYt7HB3+JfSLfawRLlC4nuqtZEc64xYUFes/OgsOHnZjGBl7zP36LI8lnHVbWHp
         /kzw==
X-Gm-Message-State: AOAM530eAexaZz9T1loHpGaCxNL3RqbsYva1I7M6yBfUfZUtwBMYJJRn
        7zhhx86P9ZW6GY0EOF9zfFo=
X-Google-Smtp-Source: ABdhPJwUTjbgFpjRhKBjUdEBBKYoMmoQ2FYhd4s1qcIF4yVZY8JkiVy+ymXc7TQCD8Ki1L7N7af7eQ==
X-Received: by 2002:a2e:946:0:b0:255:8750:dfeb with SMTP id 67-20020a2e0946000000b002558750dfebmr9193023ljj.421.1654594504568;
        Tue, 07 Jun 2022 02:35:04 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r27-20020a2e575b000000b002554a4ebf5fsm2748043ljd.74.2022.06.07.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:35:04 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 5/5] lib/test_vmalloc: Switch to prandom_u32()
Date:   Tue,  7 Jun 2022 11:34:49 +0200
Message-Id: <20220607093449.3100-6-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607093449.3100-1-urezki@gmail.com>
References: <20220607093449.3100-1-urezki@gmail.com>
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

A get_random_bytes() function can cause a high contention if it is
called across CPUs simultaneously. Because it shares one lock per
all CPUs:

<snip>
   class name     con-bounces  contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
   &crng->lock:   663145       665886        0.05           8.85         261966.66        0.39            7188152       13731279       0.04           11.89        2181582.30       0.16
   -----------
   &crng->lock    307835       [<00000000acba59cd>] _extract_crng+0x48/0x90
   &crng->lock    358051       [<00000000f0075abc>] _crng_backtrack_protect+0x32/0x90
   -----------
   &crng->lock    234241       [<00000000f0075abc>] _crng_backtrack_protect+0x32/0x90
   &crng->lock    431645       [<00000000acba59cd>] _extract_crng+0x48/0x90
<snip>

Switch from the get_random_bytes() to prandom_u32() that does not
have any internal contention when a random value is needed for the
tests.

The reason is to minimize CPU cycles introduced by the test-suite
itself from the vmalloc performance metrics.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index cf41fd6df42a..4f2f2d1bac56 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -74,12 +74,13 @@ test_report_one_done(void)
 
 static int random_size_align_alloc_test(void)
 {
-	unsigned long size, align, rnd;
+	unsigned long size, align;
+	unsigned int rnd;
 	void *ptr;
 	int i;
 
 	for (i = 0; i < test_loop_count; i++) {
-		get_random_bytes(&rnd, sizeof(rnd));
+		rnd = prandom_u32();
 
 		/*
 		 * Maximum 1024 pages, if PAGE_SIZE is 4096.
@@ -150,7 +151,7 @@ static int random_size_alloc_test(void)
 	int i;
 
 	for (i = 0; i < test_loop_count; i++) {
-		get_random_bytes(&n, sizeof(i));
+		n = prandom_u32();
 		n = (n % 100) + 1;
 
 		p = vmalloc(n * PAGE_SIZE);
@@ -294,14 +295,14 @@ pcpu_alloc_test(void)
 	for (i = 0; i < 35000; i++) {
 		unsigned int r;
 
-		get_random_bytes(&r, sizeof(i));
+		r = prandom_u32();
 		size = (r % (PAGE_SIZE / 4)) + 1;
 
 		/*
 		 * Maximum PAGE_SIZE
 		 */
-		get_random_bytes(&r, sizeof(i));
-		align = 1 << ((i % 11) + 1);
+		r = prandom_u32();
+		align = 1 << ((r % 11) + 1);
 
 		pcpu[i] = __alloc_percpu(size, align);
 		if (!pcpu[i])
@@ -396,7 +397,7 @@ static void shuffle_array(int *arr, int n)
 	int i, j;
 
 	for (i = n - 1; i > 0; i--)  {
-		get_random_bytes(&rnd, sizeof(rnd));
+		rnd = prandom_u32();
 
 		/* Cut the range. */
 		j = rnd % i;
-- 
2.30.2

