Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07D24C4FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiBYU0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiBYU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:26:14 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1149214F9C;
        Fri, 25 Feb 2022 12:25:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y5so5658392pfe.4;
        Fri, 25 Feb 2022 12:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jowACUWHyDsjl7cxkEDIstr2wZ5bnGQyw78YwqjKqdU=;
        b=fyUaoszQBgm4VI9v4r+DenYwgGb8WYioSKjYD8d9GWW3UBQr036krbXYoFR3WWH/BG
         zaPBx5NxUgxhqdxQg3BtO38ndaz2iYhlqTuospXGhKVuMjXvGZ6EC5OylI2lMImDaIr2
         OHz/82KM8hfevJ6SLc372r+bU73gvXeg+6z/T6eRyjpFn/kkXvWob2jcSWOlaM52GCJZ
         3ve09pm/0qlM4+urphZlrd/XtXPsrgsds2NSB82NVX6aUGOcghy4Unz/HpD1bH8qCQIG
         wlhKDRN8CXOLCCin6RBRaY/ytSyiOJNixuPjFJBDZRpHAYPIGAeYw8MNfQb3SJynklho
         fmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jowACUWHyDsjl7cxkEDIstr2wZ5bnGQyw78YwqjKqdU=;
        b=l1jpZAcdRgxPDTipAu4uGfiDKrswH+4suugXnP2PU8Kxbfkaakb90/TUtiXEl7mN/H
         5ttvnwSdPUsg1i9zygoqUc0HUd0kbDk2p6UUCsr5GcpuR2udSvTEszccz+KBmo18Ww4j
         c/X6e6px/MCizqp9huBBpVem/E8qB/XOBId5XA+xiLOWac8HSBry2HyPFsOgN+RvidZs
         H6hlYQVWWKjFQC/U7grbEJP5f/Uwx9rkBEnWrxzA8uIUmjCAG1HCs5NbOnAjtgDkhJYp
         cEA+CGpYkw6Am059GnKKewvUVhyrgdgBWu/bEQqXu1d6wsSYIZzsTIZ/jz8fHWqB6V7b
         5+Vg==
X-Gm-Message-State: AOAM531NUFaqCEU1U6JC03moVloAgG/6EFV6CWJ9LXUZSYmq1gumh58o
        s5NLV2MoIt36DxfWle02TA7TFRrD37s=
X-Google-Smtp-Source: ABdhPJwHXzFJKFr2MWVs+SBL5FNQptcTOBlRKpXW3+HUWllfoU73u+9b/4eXCcOXl7G4Vh5mE59+xQ==
X-Received: by 2002:a62:84d3:0:b0:4e1:b5c:1dd4 with SMTP id k202-20020a6284d3000000b004e10b5c1dd4mr9274529pfd.20.1645820741347;
        Fri, 25 Feb 2022 12:25:41 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id nn15-20020a17090b38cf00b001b90c745188sm3194934pjb.25.2022.02.25.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:25:40 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm/msm: Remove unused field in submit
Date:   Fri, 25 Feb 2022 12:26:13 -0800
Message-Id: <20220225202614.225197-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225202614.225197-1-robdclark@gmail.com>
References: <20220225202614.225197-1-robdclark@gmail.com>
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

Noticed this was unused and never set.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.h | 1 -
 drivers/gpu/drm/msm/msm_gpu.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index af612add5264..58e11c282928 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -329,7 +329,6 @@ struct msm_gem_submit {
 	bool valid;         /* true if no cmdstream patching needed */
 	bool in_rb;         /* "sudo" mode, copy cmds into RB */
 	struct msm_ringbuffer *ring;
-	struct msm_file_private *ctx;
 	unsigned int nr_cmds;
 	unsigned int nr_bos;
 	u32 ident;	   /* A "identifier" for the submit for logging */
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index c99627fc99dd..696e2ed8a236 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -21,6 +21,7 @@
 struct msm_gem_submit;
 struct msm_gpu_perfcntr;
 struct msm_gpu_state;
+struct msm_file_private;
 
 struct msm_gpu_config {
 	const char *ioname;
-- 
2.35.1

