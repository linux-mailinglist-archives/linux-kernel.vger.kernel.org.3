Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69A2591960
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbiHMIJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 04:09:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8300722B34
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 01:09:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so2743617pjf.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bdMoJB0weVQxk5D+NC587KdcV+uubEp6hO8Wqi+RKc8=;
        b=Q3UqJhD3V0gEP5HJgLeaoKnBWkkCxIlAnoNsF1EXfAl3MoK6BnTIxJaaWGIqvsxA4I
         mHNPO9ZjzD7DVFXhJ5A6ZLIGVbfpewuR+HgnaBiS/G/WR9Owu5Hyfb6K2jHhLNiL+hBR
         3jrkQ5BVXKtnHwD0K14eOBKU/lyCvKqFWz11arbtE8zVVsni04kY/iAHIKToH7hSIzA3
         gLauduyo7ACIF0MsqKgIdnugaBGyE1rK3Oy39lJ7GMijxox8Z0Q8+NujK+GCjBadh0S7
         OrP8OtYY7oi1rlEh8J+ke/SaVhJ6bGrTlWNWJvgEDRPbn8Ew65Cn/TTjydyXmLrWz5k4
         U5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bdMoJB0weVQxk5D+NC587KdcV+uubEp6hO8Wqi+RKc8=;
        b=Zoq9SZfJP6XBY1QVhYLbAt3MP8QlndGj7ygt1q/LS2M2ymQz4qsTfDhB8CFK0uiBLJ
         xyfojwmv24vzfrpXErOtqKzg2DPFlEhg2B7G895kBAkGrN49IrIjPB6iSFgE0vBieMFU
         AE5wf+08bIVNChdk4L8rFUAken5CPoMPVJZz9kHPQh65e0nPOC8EhKrKYzB/f41lcqkD
         3xY1TTNq343MzIz8cpKpmmX/H2OcgM85UTub7boJQPw2bY2Vgup7RHsXa8oi4nr7Jwlz
         4VGEwojoSYrahYwOlxXvXUS/PBha+NwtEbJXIWTgDWWS4deHYVZX43mPn/xQpQNTYR8+
         iqng==
X-Gm-Message-State: ACgBeo2kE809/ehTMfTmSY6Wqx6wX0Wkna+aGy0Y6T5hKs6bQT1ZcBFS
        E5GH0VMtymtcf6CnQvxnjy8=
X-Google-Smtp-Source: AA6agR53zo5hPtKKIqU2D+NEY9ay/ZsmTDKN0wzoIs1CdVh6eNrH2csYhDItPyHEHpyI6RSkV6tVdg==
X-Received: by 2002:a17:90b:1c0a:b0:1f3:1848:591c with SMTP id oc10-20020a17090b1c0a00b001f31848591cmr17341078pjb.24.1660378171021;
        Sat, 13 Aug 2022 01:09:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w190-20020a6262c7000000b0052d417039c2sm2912550pfb.133.2022.08.13.01.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 01:09:30 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] mm/vmscan: make the annotations of refaults code at the right place
Date:   Sat, 13 Aug 2022 08:07:58 +0000
Message-Id: <20220813080757.59131-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Yang Yang <yang.yang29@zte.com.cn>

After patch "mm/workingset: prepare the workingset detection
infrastructure for anon LRU", we can handle the refaults of
anonymous pages too. So the annotations of refaults should
cover both of anonymous pages and file pages.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 mm/vmscan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 428f8fa60331..bb993b21953d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3228,6 +3228,11 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	if (!sc->force_deactivate) {
 		unsigned long refaults;
 
+		/*
+		 * When refaults are being observed, it means a new
+		 * workingset is being established. Deactivate to get
+		 * rid of any stale active pages quickly.
+		 */
 		refaults = lruvec_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_ANON);
 		if (refaults != target_lruvec->refaults[WORKINGSET_ANON] ||
@@ -3236,11 +3241,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 		else
 			sc->may_deactivate &= ~DEACTIVATE_ANON;
 
-		/*
-		 * When refaults are being observed, it means a new
-		 * workingset is being established. Deactivate to get
-		 * rid of any stale active pages quickly.
-		 */
 		refaults = lruvec_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_FILE);
 		if (refaults != target_lruvec->refaults[WORKINGSET_FILE] ||
-- 
2.25.1

