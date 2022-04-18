Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137F5505C72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbiDRQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346197AbiDRQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:31:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68842FFF6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:28:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i24-20020a17090adc1800b001cd5529465aso12959709pjv.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHmIfYdFlbEBfg1s7Ca3bU++BraBxET9LrYHIdIzDOw=;
        b=Gt4VzL3KTmWKfLKC7W25J/xX9fzpOGWcfANQQKWSw8ZY6PBC7ECL5WDiSRu61kFUXL
         Klgvra4BD/Sxpee4hC5tkrqL9LTGsU6tE1A09569yjOGlXZRSMwgZrN4jM7gME6rLGRX
         lwJr/N+1uGB9mtCSwCCOkBNqgltL3MiNyLDH3FhXVZDk1E34NyCJYmygtdju6pFmYRqF
         SpEgA+g9b8Wghl+MGkZavW6JV8NQqX7w+9sd/VBAL7iklYy3x3EFpj7nv4Eh+cZyYnkJ
         0fLOtNohqHo5uY6TfflUaq+1G70rRypZWnQ3NRdR6KcSL3LGZizaeLc1Vb2wVVWCUGAC
         bfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHmIfYdFlbEBfg1s7Ca3bU++BraBxET9LrYHIdIzDOw=;
        b=w2qTEGc2UvceYLSmBxdqjzbG9vVVC4rESf5Szl7leI9NfRTFwqhkbBbBniWAmLPxLT
         PN+EFIFU0l60/yIzGtZAQN4YYvOIaOxtbyKbbR87bNRvFmH/v7Kih7GBikBc33B3Q/Lm
         /QRmOd+NoE4OdYxJ0P82NYzU2lVsANKZEcSEX5l4f73sXvIMtb+2+OcjO2tWfgl2wnLf
         EcrIKVSQhSmabQSDiSGEsiXTNz8lMNjmcrtJ/ktR82tFPvHerQmGrGBZFpsJ+AqQ9j9l
         JpRYR+PM1rYwalpi9c2YZD+5DzXSR2sep2iHbCW/DaivSJ58v3T1fSqDcsel0WavWgD5
         /a0g==
X-Gm-Message-State: AOAM530nn4/oNwQtHztZgrrBEsQ1bwF9bAO6tQIB58onN1J4nrD1sArp
        eyWGNMlMIn59oUhMT0NRIA8=
X-Google-Smtp-Source: ABdhPJwa0etoZ3UYp1pfmXyyzdO+3SN5JsmGZJH9apOIyhcA7TVy4ZZD9uWEe1HhMAO++LdBOtht1Q==
X-Received: by 2002:a17:902:7c01:b0:156:17a5:a68 with SMTP id x1-20020a1709027c0100b0015617a50a68mr11433631pll.166.1650299321045;
        Mon, 18 Apr 2022 09:28:41 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id h18-20020a63c012000000b0039cc3c323f7sm13295602pgg.33.2022.04.18.09.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:28:40 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH v2 1/3] staging: media: zoran: use seq_puts() instead of seq_printf()
Date:   Mon, 18 Apr 2022 21:52:44 +0530
Message-Id: <20220418162244.15346-2-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418162244.15346-1-aliyarahmani786@gmail.com>
References: <20220418162244.15346-1-aliyarahmani786@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace seq_printf() with seq_puts() for a constant format without
additional arguments, reported by checkpatch.

Signed-off-by: Aliya Rahmani <aliyarahmani786@gmail.com>
---
 drivers/staging/media/zoran/videocodec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
index 3af7d02bd910..16a1f23a7f19 100644
--- a/drivers/staging/media/zoran/videocodec.c
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -250,8 +250,8 @@ int videocodec_debugfs_show(struct seq_file *m)
 	struct codec_list *h = codeclist_top;
 	struct attached_list *a;
 
-	seq_printf(m, "<S>lave or attached <M>aster name  type flags    magic    ");
-	seq_printf(m, "(connected as)\n");
+	seq_puts(m, "<S>lave or attached <M>aster name  type flags    magic    ");
+	seq_puts(m, "(connected as)\n");
 
-- 
2.25.1

