Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD856BF57
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiGHQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiGHQYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:24:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D947A7D1C0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:24:05 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h19-20020a9d6f93000000b0061c1ad77d5fso3461813otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eS1DoT862v/g6EpjvGHfLBntfCPBUFxV6o7NJazJK14=;
        b=hSRsjqZkDb6SyYnQtxvHdml60HsCjB3dzHLzVc+Sn2nCDLpjUIt0dvvYQEP4Utv8dp
         HJ4UVRDAwVrjvDJlMu1KWwignFae8tPFXKxvx7w67BsfotkF0yCeNJpCq93RE79nvUPR
         a9/RELWNRH58jLvHLFSo559skengu9ebIkY9qFdA3GmDMtcX249eLdFy15rFNHv4HhIG
         0OPUsVbAD5efrQapJLvTX2j7ZYGpV3Yo5UuU445XhnUTajLmuVDfgNnmSZgTWUCvD4cO
         sshWnVjlDI2wpye7wqBbHjpGgI57nlHFi82d3ln8eARWnN2zIdGS4XSIQQa10QOFAmFK
         hgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eS1DoT862v/g6EpjvGHfLBntfCPBUFxV6o7NJazJK14=;
        b=x2YQNZ7pcBGX0WmUDQKK51bI54fuNWIU1iNFs7hRz5khC9oeP2WfFL8QwytQITJLri
         qn08MamIqYPMaPfnR2vjEXntPTLxj92kFWZqvPYqQy5SF5k1mi9gjvvb/1t3sxakdyLe
         2Z+5PEOCGj5AIxsd/i7xHuhhY3mM2FF+IKFHhtu2fZ7dt2x0pUYdWjHhDuEHcgNC5jqH
         2w/OBYPVIjj62c8CoyCg0zMqJDDWJMsfbhJ1ZzY/doxUW/MPpZ1JUzBJl2fX+SJKYoJe
         NYJIF3bkS3Faykk5xTlZYOVXOsrlPX0JVYHa+nnR4B2xxsVix1vWh1OzT0eYdSQxchqB
         zlXw==
X-Gm-Message-State: AJIora/N048csH6WZhcZlBRaxy6jan+9ENM3VTgLU4C5CdALYbxUnde/
        RwUN++TaG0T/oxOvyt3/oOloZA==
X-Google-Smtp-Source: AGRyM1sHmxfIFe72kNMrpQnCwtapr6QU9N20Rtq+AQ0mLbpRLwO90rb6TwTmApYnhVPsNOLGXUit5Q==
X-Received: by 2002:a05:6830:cf:b0:61c:265b:1d1e with SMTP id x15-20020a05683000cf00b0061c265b1d1emr1862647oto.290.1657297439983;
        Fri, 08 Jul 2022 09:23:59 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f8-20020a056871070800b00101bd4914f9sm6678663oap.43.2022.07.08.09.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:23:59 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/gpu: Drop qos request if devm_devfreq_add_device() fails
Date:   Fri,  8 Jul 2022 09:26:32 -0700
Message-Id: <20220708162632.3529864-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that devm_devfreq_add_device() fails the device's qos freq
list is left referencing df->idle_freq and df->boost_freq. Attempting to
initialize devfreq again after a probe deferral will then cause invalid
memory accesses in dev_pm_qos_add_request().

Fix this by dropping the requests in the error path.

Fixes: 7c0ffcd40b16 ("drm/msm/gpu: Respect PM QoS constraints")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index c2ea978c8921..21e271a318ee 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -198,6 +198,8 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 
 	if (IS_ERR(df->devfreq)) {
 		DRM_DEV_ERROR(&gpu->pdev->dev, "Couldn't initialize GPU devfreq\n");
+		dev_pm_qos_remove_request(&df->idle_freq);
+		dev_pm_qos_remove_request(&df->boost_freq);
 		df->devfreq = NULL;
 		return;
 	}
-- 
2.35.1

