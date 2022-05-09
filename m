Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6551F475
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiEIGUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiEIGPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:15:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD6F21255;
        Sun,  8 May 2022 23:11:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so12912011plg.6;
        Sun, 08 May 2022 23:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tLx5Pm6Ngh4YLs7U4uiQY60BpXpO+WnLGyecC77JrZw=;
        b=Jnf9FtUJSdYHxR7peyJf3TzliXYeHQrTsId7OaDoq71bojBxuF9kPLSuguaSt0bpAr
         oOikRnEOw1TuiIJD6/iXR0PxSRIjkVeKUk89cZqEdQ8MPrnOyweopgjeJyvmAMj0EgMq
         sDXCkaTbjZs9WRrtgQwibByiyBBliFpqQVD87QlVnIeosD/LRHtuvVWfZREX3tvfQLEs
         yq4eovHKjSOUeR+pdIW1HtjdObCpfuimJlfNKao5/VsRAud/dNmF72XboTCCU8NwCjOy
         SPIE1raBJoijowbBnBfPsZQdeJw44hKiwwumgsWHLVVVMJRQJHzAtxh0gnRf9Xkd+bLJ
         7c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tLx5Pm6Ngh4YLs7U4uiQY60BpXpO+WnLGyecC77JrZw=;
        b=eHgfrY3VVtzPvAySOhGP+QaVCW/eouqwBL4P6nUsMeagWlC7hZ/jEiCAVd75Jjefdq
         gTKv8/29hJF9oy6CziBzfsFU+IpjNC+7xNsMrN1BT7FKitLMwU3j+0HwpE3QbIPH98yT
         cvBpgtthmhk3Vus2OuJSm3jFwOkc4FCI6c8RRdaATLyOfJ6jSC7mIwa5wta/sb9Y/y/H
         K4gsz3we2PAOOr8M1/X23lgBEYwXuDRQAtYHfOwhIm/BlvbyEzlbk8KRx6/ulxSYMAXl
         RTVA+jnHuS133OTyejuWYW8eKluFso6IsS7uLV1YBbb/AriXr3MFnaO3BflCObFDjwbo
         efsw==
X-Gm-Message-State: AOAM533qC9PiL6fBzQS4iPLHZbPSmqu6ineSq9MBg/tCkz6jKLZmeKG4
        C27Tp4knzgLM+kWPO7baaJA=
X-Google-Smtp-Source: ABdhPJxv9Zjx5DUMC6R3uYLXLUaG+lxpUae+8y4732Pr++SO/sJa3ZwhEvnos3IXYMSepsop/B152Q==
X-Received: by 2002:a17:902:ec8c:b0:15e:a371:ad7d with SMTP id x12-20020a170902ec8c00b0015ea371ad7dmr14751207plg.12.1652076703604;
        Sun, 08 May 2022 23:11:43 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902988d00b0015e8d4eb257sm6135771plp.161.2022.05.08.23.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:11:43 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch, dmitry.baryshkov@linaro.org,
        gbeeresh@codeaurora.org, sviau@codeaurora.org,
        wentaox@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] drm: msm: fix possible memory leak in mdp5_crtc_cursor_set()
Date:   Mon,  9 May 2022 14:11:25 +0800
Message-Id: <20220509061125.18585-1-hbh25y@gmail.com>
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

drm_gem_object_lookup will call drm_gem_object_get inside. So cursor_bo
needs to be put when msm_gem_get_and_pin_iova fails.

Fixes: e172d10a9c4a ("drm/msm/mdp5: Add hardware cursor support")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
index b966cd69f99d..6a5f73f6a23b 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
@@ -991,8 +991,10 @@ static int mdp5_crtc_cursor_set(struct drm_crtc *crtc,
 
 	ret = msm_gem_get_and_pin_iova(cursor_bo, kms->aspace,
 			&mdp5_crtc->cursor.iova);
-	if (ret)
+	if (ret) {
+		drm_gem_object_put(cursor_bo);
 		return -EINVAL;
+	}
 
 	pm_runtime_get_sync(&pdev->dev);
 
-- 
2.25.1

