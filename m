Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1F55AD33
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiFYWzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiFYWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:55:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63C13F3E;
        Sat, 25 Jun 2022 15:55:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so6008535pjj.5;
        Sat, 25 Jun 2022 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUhJyEOgZ2z2SZ5h3XBUNWhKpL54GfHjGG/MbTrPVdE=;
        b=Ck3KdhjbNQUeHJG/pVcofv5UB/TZ3zQDCn+W9qGKvwHN7L/lty9zDtudp8d2kriG4a
         cbG84Xdm8NjzqR8nFyTfhwJrlzLlPVZv44se9PFgsF+18+rK9gACM3d+/WHBFs1IQyax
         9pIDiHAaoD+g3g07UHQQpozFUl5HGG6Y2AU9xF8HSVaKX5DQpzsByYUBNZEKJx9BqKEh
         4fnwX4jdmPZ1Y5VLrMuCwdQ+zkraPnWmMlUBpXcHGBzjSfmPBeELKTY+bVCw21klQ+YI
         /nn5yiAuiyGICbUf23zK13C3zEb/BDw2qwEqfyYqEQZqUFJe+0D3ERzpcE/qbmj3u5pA
         Pr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUhJyEOgZ2z2SZ5h3XBUNWhKpL54GfHjGG/MbTrPVdE=;
        b=BfAUUJfMHzTYKIdz6QC0TK+s79c8+EJ6F493L+935BHyuSo3lOxnGHHXckRhi/ehWm
         T7bxVY9AFjexUdUKMBF80y/TnulJdJJh2Iuei8DKDIVa+cNZ6cygUNIs8QGvHZW6ilAA
         boY6HOBOYfv+VOSauawmC3i5D6NpXYq0E3txjhQNtrwFKbYyFYJeUAUDTm2cL25vE53k
         EPV9E8SYqSq/HOxENC1kAxwqoj+xmHCpN8Hbri+IFJvnrgdxOegyCj3uyhvtyPO9ygMb
         mlMU545YsQYQ7IdM3EPdaWzHGPX0WjItXoP6KxKi1EWasQlB2lmt8q7vJ1o05UAUojTp
         Praw==
X-Gm-Message-State: AJIora8k63+Wr1Gs0HTBZ6qTgAvWFvPIjTSSuZOE0pVnCzzPdJWwGSxo
        hKuSJ5146YbwPYxLZNcWrsY=
X-Google-Smtp-Source: AGRyM1s877XF18gurlXU6S2PYXHqKvW6MpxQeLmMO0u6/ZWCl66vnnSMWEGjsEuEu6yzK4qqJ6m5vg==
X-Received: by 2002:a17:902:c2ce:b0:16a:1aba:9f69 with SMTP id c14-20020a170902c2ce00b0016a1aba9f69mr6558518pla.67.1656197702509;
        Sat, 25 Jun 2022 15:55:02 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090a7c0c00b001eac661025fsm4120994pjf.29.2022.06.25.15.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:55:01 -0700 (PDT)
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
Subject: [PATCH 02/15] drm/msm: Make enable_eviction flag static
Date:   Sat, 25 Jun 2022 15:54:37 -0700
Message-Id: <20220625225454.81039-3-robdclark@gmail.com>
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

No need for it to be visible outside of this one src file.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 086dacf2f26a..6e39d959b9f0 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -15,7 +15,7 @@
 /* Default disabled for now until it has some more testing on the different
  * iommu combinations that can be paired with the driver:
  */
-bool enable_eviction = false;
+static bool enable_eviction = false;
 MODULE_PARM_DESC(enable_eviction, "Enable swappable GEM buffers");
 module_param(enable_eviction, bool, 0600);
 
-- 
2.36.1

