Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3391455AD40
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiFYWzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiFYWzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:55:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8854213F8C;
        Sat, 25 Jun 2022 15:55:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k7so5102604plg.7;
        Sat, 25 Jun 2022 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHnA8EA1zYWAltmKrCqgpnviThEUlN7Pg3SwIn6d3WM=;
        b=EkQwqPjzd+LGHdTgSo2dAIAIRpSAC6Nv6RHe+yrSIMYp9IvQfajAKlCp7AcHut07Tp
         DzVol4+DsflE2sydgmeqfi/uE27GbpyLDLtKIWntALoTTjjZujCeng2dckMbBySlgQVO
         IxkahcVYhQmkr46T5tY/NpBYobQNJlUfHnr/JcrN/hkmvjmRv+Z/S/fyDEYwS71K7jA9
         cLS9+sl/7tojk+f1SwEz/059TKhLFFPpg/98lHJsqOWrYxvecCGJbTTCAV6UE+Sa/ATr
         G0QZmAOm9ZYERsmS0G/OLbz3y8XWw1vrAWjfw/KEuM50O0AbEFCc2yeE+e5MOziTAahA
         WPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHnA8EA1zYWAltmKrCqgpnviThEUlN7Pg3SwIn6d3WM=;
        b=rgTr7jsaVqwb9447qGGJgMUjtEHEpc80AMjHr1V2xijPrnHvUxHjzwwzdfPI/b7DMJ
         9jeVFLmkj6gwb6q/T5SBJR+rAdDt2/X2IOlEq/rPvCsFGl9IH5k21dV9gxvrJwKU7Q1S
         cex+Z+jbgVsTDCuU82ijIGr7QkfC9s9U+C47VN4ZEBKqj711mzLt5xc1hc5zr3/+zlY3
         5kdbwpCDZLgQo6b0evaCHrlFdOlenz8yoJbjJ2/rvjOfT32DD2+CRZmlLqB8VyKQPY7P
         7P1aTJhUVG4zWG8ga4LMnp2ftO36kTGYO4yeEWA027mu6xW9LjJSb7bmHci4bZVR1YsN
         o9Qw==
X-Gm-Message-State: AJIora96sPURlXW7vNZUpYUQZupwrEhFCpSNYsbMolzJckdfQzvUeFus
        y9IHh3AKJ55QwkPskTIWFsg=
X-Google-Smtp-Source: AGRyM1samwSo1WxvAFzhw8/vJ684m46AebmiyTYk6zs1V/HkEWtasanv8OtFQnUi/1Bnxeqd8QlG+Q==
X-Received: by 2002:a17:902:e552:b0:163:6a5e:4e08 with SMTP id n18-20020a170902e55200b001636a5e4e08mr6494175plf.130.1656197736053;
        Sat, 25 Jun 2022 15:55:36 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id z26-20020a634c1a000000b0040dd052ab11sm520830pga.58.2022.06.25.15.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:55:35 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 14/15] drm/msm/gem: Consolidate shrinker trace
Date:   Sat, 25 Jun 2022 15:54:49 -0700
Message-Id: <20220625225454.81039-15-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625225454.81039-1-robdclark@gmail.com>
References: <20220625225454.81039-1-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Combine separate trace events for purge vs evict into one.  When we add
support for purging/evicting active buffers we'll just add more info
into this one trace event, rather than adding a bunch more events.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 19 ++++++---------
 drivers/gpu/drm/msm/msm_gpu_trace.h    | 32 +++++++++++---------------
 2 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 530b1102b46d..5cc05d669a08 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -71,25 +71,20 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 	struct msm_drm_private *priv =
 		container_of(shrinker, struct msm_drm_private, shrinker);
 	long nr = sc->nr_to_scan;
-	unsigned long freed;
+	unsigned long freed, purged, evicted = 0;
 
-	freed = drm_gem_lru_scan(&priv->lru.dontneed, nr, purge);
-	nr -= freed;
-
-	if (freed > 0)
-		trace_msm_gem_purge(freed << PAGE_SHIFT);
+	purged = drm_gem_lru_scan(&priv->lru.dontneed, nr, purge);
+	nr -= purged;
 
 	if (can_swap() && nr > 0) {
-		unsigned long evicted;
-
 		evicted = drm_gem_lru_scan(&priv->lru.willneed, nr, evict);
 		nr -= evicted;
+	}
 
-		if (evicted > 0)
-			trace_msm_gem_evict(evicted << PAGE_SHIFT);
+	freed = purged + evicted;
 
-		freed += evicted;
-	}
+	if (freed)
+		trace_msm_gem_shrink(sc->nr_to_scan, purged, evicted);
 
 	return (freed > 0) ? freed : SHRINK_STOP;
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu_trace.h b/drivers/gpu/drm/msm/msm_gpu_trace.h
index ca0b08d7875b..8867fa0a0306 100644
--- a/drivers/gpu/drm/msm/msm_gpu_trace.h
+++ b/drivers/gpu/drm/msm/msm_gpu_trace.h
@@ -115,29 +115,23 @@ TRACE_EVENT(msm_gmu_freq_change,
 );
 
 
-TRACE_EVENT(msm_gem_purge,
-		TP_PROTO(u32 bytes),
-		TP_ARGS(bytes),
+TRACE_EVENT(msm_gem_shrink,
+		TP_PROTO(u32 nr_to_scan, u32 purged, u32 evicted),
+		TP_ARGS(nr_to_scan, purged, evicted),
 		TP_STRUCT__entry(
-			__field(u32, bytes)
+			__field(u32, nr_to_scan)
+			__field(u32, purged)
+			__field(u32, evicted)
 			),
 		TP_fast_assign(
-			__entry->bytes = bytes;
+			__entry->nr_to_scan = nr_to_scan;
+			__entry->purged = purged;
+			__entry->evicted = evicted;
 			),
-		TP_printk("Purging %u bytes", __entry->bytes)
-);
-
-
-TRACE_EVENT(msm_gem_evict,
-		TP_PROTO(u32 bytes),
-		TP_ARGS(bytes),
-		TP_STRUCT__entry(
-			__field(u32, bytes)
-			),
-		TP_fast_assign(
-			__entry->bytes = bytes;
-			),
-		TP_printk("Evicting %u bytes", __entry->bytes)
+		TP_printk("nr_to_scan=%u pages, purged=%u pages, evicted=%u pages",
+			  __entry->nr_to_scan,
+			  __entry->purged,
+			  __entry->evicted)
 );
 
 
-- 
2.36.1

