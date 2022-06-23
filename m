Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C44556F69
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 02:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357738AbiFWAZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 20:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357371AbiFWAZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 20:25:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1927676
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:25:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q140so17567435pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzh8+fZjM5hPtSMBwoYZp8q7cJJBA1KjGLsk1UEGJzY=;
        b=JeZKCxa6bNzpsmRCpGpgy7EB/22moTTKpfrVHcl/9qlhp/I1SufTP5QykncHgNW9hR
         avenedCjqEyWeq8lKo6Zowji08L4Ek+9niZjCH0F9P3OflsKYnqFT/WrWjb5FjZOb25C
         pH9FQlDVUs5EHyxnSEgE/sKUz80Sk+7gtVR90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzh8+fZjM5hPtSMBwoYZp8q7cJJBA1KjGLsk1UEGJzY=;
        b=LSSXLVDSbXjkMYkG2fsRl3XdUoPecNpsIkpJ1+G2e8JiuFOPa7e6aQCX8kg8jwkPZH
         1DLBsqAXlAa4WIBEv7D11tljZg/ycaXsKmD1Zrm/K3UqV3+JDtIDWv0ryVPNmFQHOCtU
         O8Q1SdiM0njAJTOAC/BEaNUMpo66bQW5CBu7nW+2eDcwTP6fvywdSDt6iQGNhL18hyhE
         ZESz6Y8PBnKK9PEFPT6Fcolmdp0WUWMmZ07x7m0hJrSVouKwrb3XIrahpI5IzkMPi5A9
         Bt98zokk8s2aTLt/qyi8Ae0m+MT/MzCDLClfQgHBMLwbv+qJbTSQthGzTFNcx2GQP/Lc
         esgA==
X-Gm-Message-State: AJIora/320Jb6xMQvWoDZ5LFjJz0uEQ5XZ6Oa1Tdo0Cc13jSyzpmgKRC
        MqPuLUeuQDQmAead5gYoXnJ5rw==
X-Google-Smtp-Source: AGRyM1suCxCy+8DW200CWSyuFAXsy4QJ9tVOXFHRTeywutvEswLKZ/hAgeOYR/sNhbqvBoj6zAIU0A==
X-Received: by 2002:a63:9dc1:0:b0:40b:7771:c2ac with SMTP id i184-20020a639dc1000000b0040b7771c2acmr5135253pgd.39.1655943942707;
        Wed, 22 Jun 2022 17:25:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f28c:6f86:743c:1c04])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903024100b00163fbb1eec5sm13332705plh.229.2022.06.22.17.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 17:25:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH v2 0/3] drm/msm/dp: More cleanups for force link train
Date:   Wed, 22 Jun 2022 17:25:37 -0700
Message-Id: <20220623002540.871994-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches do a little cleanup on the v9 patch[1] from Kuogee.

Changes from v1:
 * Reduce code even more in second patch
 * Pick up tags on first patch

Stephen Boyd (3):
  drm/msm/dp: Reorganize code to avoid forward declaration
  drm/msm/dp: Remove pixel_rate from struct dp_ctrl
  drm/msm/dp: Get rid of dp_ctrl_on_stream_phy_test_report()

 drivers/gpu/drm/msm/dp/dp_ctrl.c | 148 ++++++++++++-------------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h |   1 -
 2 files changed, 59 insertions(+), 90 deletions(-)

[1] https://lore.kernel.org/r/1655411200-7255-1-git-send-email-quic_khsieh@quicinc.com

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
prerequisite-patch-id: 2fc33a2830ec84d922023fddb585728c48a59525
-- 
https://chromeos.dev

