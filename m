Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7925688BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiGFMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiGFMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:53:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641BA1ADB1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:53:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so14271362pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Jrq+9nhJVPkb16NrcuFTfB7e3j9IauFbZGggqbekZE=;
        b=RMIyRXkUpjKnFsk+wP6wqhXeoDxmMid3B2636Lj2B7JZTN1p2wmjS3KpKD4co3iyNI
         edYJxzgcQBzWYIgV5L+rGFGTukpsT/v7zNAEVBfcEKm8pN7U6yrOX4CCfd4tdxNs5K2l
         BcqM08kUWzxMO8XuHPOwYTDbad0jXWomJKCzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Jrq+9nhJVPkb16NrcuFTfB7e3j9IauFbZGggqbekZE=;
        b=Jd5eqGH08JoSOipZffvWKtBS2Xlvs4tIrt0d8onZiFRWnJqRNKc7RMzC5BAdiqb8Bd
         oBCJRIzGV6aGLxKwKpDXXRtIHO0zHD2U/JeCgVtwX+k49qP0KncPGCkwXq05xuXOn0/w
         YXb1O/2B2ELJLHi+HD3+9ljGKII8oxDviUDvD+95GEr/aR73bfiqeFxZ2KcqmoIOu1dN
         nXepngzbw7w3BjR6TNFJrGEY/xx4Xua8JOyrYH1me60LL2J0DRoMf5qOOfIGDfFQqjPS
         Yixd7tzsSu93oXhmo3MFa3nzIw8j23SxXPX4JK70CnhukGFjfKZw1Kim3pVs5/BHISxt
         TneQ==
X-Gm-Message-State: AJIora8pWaiqhFrimROq5VAhvvBbBNmmi6rwCGpFzdpjwHyWAwc/OGwu
        gAFLMILb0ZqXLPR7S6QXnFWPxQ==
X-Google-Smtp-Source: AGRyM1tFsvASDX/k79J0S9FSg9rF1KUurn8OfXWYH4+7+zq6n6k0/x6kaTMJPetzy+8EIukF98Q+2A==
X-Received: by 2002:a05:6a00:14c7:b0:525:89c1:35fb with SMTP id w7-20020a056a0014c700b0052589c135fbmr46792853pfu.36.1657111981746;
        Wed, 06 Jul 2022 05:53:01 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5300:b974:1680:1bd])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b0016a6cd546d6sm25640127ple.251.2022.07.06.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:53:01 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>, Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] anx7625: Cleanup, fixes, and implement wait_hpd_asserted
Date:   Wed,  6 Jul 2022 20:52:50 +0800
Message-Id: <20220706125254.2474095-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains:
Cleanup:
- Convert to use devm_i2c_new_dummy_device()
- Use pm_runtime_force_suspend(resume)
Fixes:
- Fix NULL pointer crash when using edp-panel
and Impelment wait_hpd_asserted() callback.

The patches are not related to each other, but they are all
anx7625 patches so they are all stacked in this series.

Hsin-Yi Wang (4):
  drm/bridge: anx7625: Convert to devm_i2c_new_dummy_device()
  drm/bridge: anx7625: use pm_runtime_force_suspend(resume)
  drm/bridge: anx7625: Fix NULL pointer crash when using edp-panel
  drm/bridge: anx7625: Add wait_hpd_asserted() callback

 drivers/gpu/drm/bridge/analogix/anx7625.c | 179 ++++++++--------------
 1 file changed, 65 insertions(+), 114 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

