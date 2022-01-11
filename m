Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9248B9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbiAKVcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:32:06 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:36009 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245288AbiAKVcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:32:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1641936724; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FC6TGSH21ZDq9oA9xKY52T7V+aBSo3EdCMkvqhp2Wwc=; b=rfw0FepvmGUC0ZPANvsSMxWyouBSPqjnlYiqr4EJJIYddZlbxamrygS4G7XHvXGSNLjo5NCV
 RZx6JfJY9vnklXieSNqM9qWSL+0pk5X1zYJ5jdIsXpgFH26uca75ymKxQW9xYhA3GtPKcP9l
 5v8AJTBVnlma20ecHqyHBo7BdzQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61ddf74b6189a19cb23a6615 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Jan 2022 21:31:55
 GMT
Sender: quic_akhilpo=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B03D1C43635; Tue, 11 Jan 2022 21:31:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld559.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57309C43616;
        Tue, 11 Jan 2022 21:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 57309C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=quicinc.com
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/msm/adreno: Expose speedbin to userspace
Date:   Wed, 12 Jan 2022 03:01:29 +0530
Message-Id: <20220112030115.3.I86c32730e08cba9e5c83f02ec17885124d45fa56@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20220112030115.1.Ibac66e1e0e565313bc28f192e6c94cb508f205eb@changeid>
References: <20220112030115.1.Ibac66e1e0e565313bc28f192e6c94cb508f205eb@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose speedbin through MSM_PARAM_CHIP_ID parameter to help userspace
identify the sku.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f33cfa4..e970e6a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -242,10 +242,11 @@ int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value)
 		*value = !adreno_is_a650_family(adreno_gpu) ? 0x100000 : 0;
 		return 0;
 	case MSM_PARAM_CHIP_ID:
-		*value = adreno_gpu->rev.patchid |
-				(adreno_gpu->rev.minor << 8) |
-				(adreno_gpu->rev.major << 16) |
-				(adreno_gpu->rev.core << 24);
+		*value = (uint64_t) adreno_gpu->rev.patchid |
+				(uint64_t) (adreno_gpu->rev.minor << 8) |
+				(uint64_t) (adreno_gpu->rev.major << 16) |
+				(uint64_t) (adreno_gpu->rev.core << 24) |
+				(((uint64_t) adreno_gpu->rev.sku) << 32);
 		return 0;
 	case MSM_PARAM_MAX_FREQ:
 		*value = adreno_gpu->base.fast_rate;
-- 
2.7.4

