Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECB54FEDF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381528AbiFQUr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiFQUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:47:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149B2BC1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:47:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u37so5105646pfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cthRoKdZynlo7BCJhn2Mvx9FZ9+o8uogeaq20GblQQw=;
        b=nFsBmKmNn+/h8yDv9MpPAjH4ATR3q3Bz0cTI1gh6q7RWGlJq4k9RjlPLJhAYwTAS7p
         fH5Fgfn9tn1XPnw9u35HLDbshjkuLhEvjrdZr3iu2LgriDyOCphiKdNeMNC7ODk7XZo4
         IhYcHQs0mlvPPg1IIzhMtZVfOcaenKJqoL5ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cthRoKdZynlo7BCJhn2Mvx9FZ9+o8uogeaq20GblQQw=;
        b=mnKa0uaH/fPF2ZCY/nTQkBLLXRTrTw292xl+yC0DnKFvUSVkcIxmehCYAHg0y3G/Ew
         rXcmPpLS3ksBYThpLqIIf9EpQQBK5yhXj2nrUbH4IcU/8q87/cGIrXDR0cy9AsxxOBps
         zxivotkRK314kRkMnuK011NG4jUrPXtHoj8dDx9pqHHW24E4rTPkhxzCQ9RnYg1pUYE8
         9CdbVmzVgV85TzQdFLR6sOrO5AdtMeuO3hc6u8MQRGIJX7T8xD0I+ykP5OrOvK9CPpfQ
         o7GCmM151F7FBHc2lmJ3PvFhHpxmKmCOVExd8lf5bmk42MRrLmSkxsGAuIF4G2yFmqWw
         mHIQ==
X-Gm-Message-State: AJIora/JbqUFdr/0AhLhHTkpG9OwmKS9njTNVm39Q6QqDypsRzs4qZYT
        x3y6VtRQ2fFefUlH1QzQAW9zeg==
X-Google-Smtp-Source: AGRyM1s2KT9lZnLB+hTEDMQKftAyY/9OYB52Ihl7t/kjRy+fLlR2MbQtggQk9rA7rcrF+PobFUc2tg==
X-Received: by 2002:a63:6f8d:0:b0:408:c049:aaf1 with SMTP id k135-20020a636f8d000000b00408c049aaf1mr10554739pgc.199.1655498872314;
        Fri, 17 Jun 2022 13:47:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:52e2:7dc8:1e20:f870])
        by smtp.gmail.com with ESMTPSA id z12-20020aa79f8c000000b0052089e1b88esm4098325pfr.192.2022.06.17.13.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:47:51 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 0/3] drm/msm/dp: More cleanups for force link train
Date:   Fri, 17 Jun 2022 13:47:47 -0700
Message-Id: <20220617204750.2347797-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
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

These patches do a little cleanup on the v9 patch from Kuogee.

Stephen Boyd (3):
  drm/msm/dp: Reorganize code to avoid forward declaration
  drm/msm/dp: Remove pixel_rate from struct dp_ctrl
  drm/msm/dp: Get rid of dp_ctrl_on_stream_phy_test_report()

 drivers/gpu/drm/msm/dp/dp_ctrl.c | 145 ++++++++++++++-----------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h |   1 -
 2 files changed, 65 insertions(+), 81 deletions(-)

[1] https://lore.kernel.org/r/1655411200-7255-1-git-send-email-quic_khsieh@quicinc.com

base-commit: 9639746eebb13068dc9de6f436151bd88da2b827
prerequisite-patch-id: 2fc33a2830ec84d922023fddb585728c48a59525
-- 
https://chromeos.dev

