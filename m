Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7796E47812F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhLQATP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhLQATO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:19:14 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24F1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:19:13 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q25so1360202oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ENSn6IuB+oeiV3yKnojaUGUax2jZ8l/NgiJmlnlGRM8=;
        b=fhm/OhQ/sdR+Qhsb/I9XemcDSyVjaGBVqHbNBNF1QmgT+42HuyhEMSP79YqVh+pF3b
         dEpBWDTMly9uAy9dTi7R526EUDNhxh5Z8oDmMBdDr/dvWyMA9dqEnuz6RQiW08Hb1bEE
         ecE6Na4fYfIEHhtpSTPyTcEn/Noi5OzKJI0GwFoDPHvQZSrYqxNHbQQCO3e9w/cbGBHd
         684j/j1/IJ10n3aDlFRCcvNhAl/SzDtwOKVYZP9c5nPAVgRkj9P0Q3yguLDqMAdUqCsM
         J4VlevGliw6ez+TD1DpXBBFmZn92ZXPYF3wo3197RqdBBnLEbVQ29yDHUiqKe0MULALF
         WgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ENSn6IuB+oeiV3yKnojaUGUax2jZ8l/NgiJmlnlGRM8=;
        b=xzXqyY7/2F/WP8pDt3g+XH86DBtuU9QLBW0pZOhB8f3WSW8XU7c1Mecby3VaAppNL2
         JCtWE+7QRdFlLrAMAjOgwbllDkaOUvFuJ2qfx5Tvf5lMPcucFBrkgqbyzRCeafki48Nr
         igxrTxiAd2imCMpzMADgUmZx6PAtMgG24HxtnJx/W3oAM+Jufi+Qou6pkF4S1qQPd0vh
         R7AgNRllHEGG0uoq8P3Ncgm56JHXNsnk+f4BuX/cAvwnkGY6b8/mR8GKmcc2kwAu+i/l
         is+igkfQnYQARjJoJ2FooUxyLYs8H3Yn+fRAHhONv4hjkhNOc6B2rs0rwMzsDpdnfOlz
         kUGA==
X-Gm-Message-State: AOAM531OMZUiT1OuTZZN/XV7dKoupmAQzhkgJna8fjXIY7ksGQBhxSu6
        kBSQ5KTixaTUfk4HQcyMYhu+CQ==
X-Google-Smtp-Source: ABdhPJyirE2LAYtTzTmww8lQgs/2HDcezCd+h7aylmB9JAn5/W3GK0bUarTheMMU1gtz40mXLgXJaA==
X-Received: by 2002:a05:6808:209b:: with SMTP id s27mr255871oiw.43.1639700353143;
        Thu, 16 Dec 2021 16:19:13 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e14sm1261737oie.7.2021.12.16.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:19:12 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm/dp: Only create debugfs for PRIMARY minor
Date:   Thu, 16 Dec 2021 16:20:26 -0800
Message-Id: <20211217002026.2304973-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpu_kms_debugfs_init() is invoked for each minor being registered. Most
of the files created are unrelated to the minor, so there's no reason to
present them per minor.
The exception to this is the DisplayPort code, which ends up invoking
dp_debug_get() for each minor, each time associate the allocated object
with dp->debug.

As such dp_debug will create debugfs files in both the PRIMARY and the
RENDER minor's debugfs directory, but only the last reference will be
remembered.

The only use of this reference today is in the cleanup path in
dp_display_deinit_sub_modules() and the dp_debug_private object does
outlive the debugfs entries in either case, so there doesn't seem to be
any adverse effects of this, but per the code the current behavior is
unexpected, so change it to only create debugfs files for the PRIMARY
minor.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Moved the check up from msm_dp_debugfs_init() to dpu_kms_debugfs_init()

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 2ee70072a1b4..a54f7d373f14 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -193,6 +193,10 @@ static int dpu_kms_debugfs_init(struct msm_kms *kms, struct drm_minor *minor)
 	if (!p)
 		return -EINVAL;
 
+	/* Only create one set of debugfs per DP instance */
+	if (minor->type != DRM_MINOR_PRIMARY)
+		return 0;
+
 	dev = dpu_kms->dev;
 	priv = dev->dev_private;
 
-- 
2.33.1

