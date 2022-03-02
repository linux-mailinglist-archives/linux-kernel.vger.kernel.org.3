Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE74C4CABA8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiCBR2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbiCBR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:41 -0500
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 0BF263FD84
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:27:55 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1646242077; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Qa4oeOoMQCNOhiFhjfjB7NxSM+9SxKiZPhTh4vJHGJU=; b=AB3KUlheRWPAD9tGQgQ5Kk9r1ezy9gArMJaY0RFdPKbhzKKz+bE9we9+TynJZbIo3oKFgeqF
 V1XrE1AHqNFEpBAMm8ATip1iJ3g+mI0OfJJ4iRXASxyQ/FwaWdmKz+6tP5gl3eTBplB7thw0
 8TsyfnoRY1WIdj5CeCXwZhX2JKA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 621fa917e1c212bb9c1e992c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Mar 2022 17:27:51
 GMT
Sender: quic_akhilpo=quicinc.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A23FCC4363F; Wed,  2 Mar 2022 17:27:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_H2,RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
Received: from hyd-lnxbld559.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C826C4338F;
        Wed,  2 Mar 2022 17:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8C826C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=quicinc.com
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Osipenko <digetx@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Wang Qing <wangqing@vivo.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/10] Support for GMU coredump and some related improvements
Date:   Wed,  2 Mar 2022 22:57:26 +0530
Message-Id: <1646242056-2456-1-git-send-email-quic_akhilpo@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Major enhancement in this series is the support for a minimal gmu coredump
which can be captured inline instead of through our usual recover worker. It
is helpful in the case of gmu errors during gpu wake-up/suspend path and
helps to capture a snapshot of gmu before we do a suspend. I had to introduce
a lock to synchronize the crashstate because the runtime-suspend can happen
from an asynchronous RPM thread.

Apart from this, there are some improvements to gracefully handle the
gmu errors by propagating the error back to parent or by retrying. Also, a
few patches to fix some trivial bugs in the related code.


Akhil P Oommen (10):
  drm/msm/a6xx: Add helper to check smmu is stalled
  drm/msm/a6xx: Send NMI to gmu when it is hung
  drm/msm/a6xx: Avoid gmu lock in pm ops
  drm/msm/a6xx: Enhance debugging of gmu faults
  drm/msm: Do recovery on hw_init failure
  drm/msm/a6xx: Propagate OOB set error
  drm/msm/adreno: Retry on gpu resume failure
  drm/msm/a6xx: Remove clk votes on failure
  drm/msm: Remove pm_runtime_get() from msm_job_run()
  drm/msm/a6xx: Free gmu_debug crashstate bo

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c       | 89 +++++++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h       |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 31 +++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h       |  4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 79 +++++++++++++++++++++----
 drivers/gpu/drm/msm/adreno/adreno_device.c  | 10 +++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c     | 10 +++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  2 +
 drivers/gpu/drm/msm/msm_gpu.c               | 28 ++++++++-
 drivers/gpu/drm/msm/msm_gpu.h               | 11 ++--
 drivers/gpu/drm/msm/msm_ringbuffer.c        |  4 --
 11 files changed, 218 insertions(+), 51 deletions(-)

-- 
2.7.4

