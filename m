Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D8E515123
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379305AbiD2Qxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378872AbiD2Qxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:53:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51306477
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:50:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e24so11515951wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZGgtz32ux6a+OFJ5/9VUJE0pTJLJ3hFARi5porqzLY=;
        b=mJ2uwubh2mGYZxllmwWKD9RM2ZavquJsVT7gT6QG/jVUC7AzRe7Qyl/mngWRORVKti
         7CEg+PYWxxgYNfMyOx+a5xBdKyhQPmo5HdfeACux/TIi6AAG8pmjMV239qsDmHhMhp3C
         K2TkgkO97H/+//z0StZiwkVZDi6bnrH6l+uhFOqKMmT8E6SK/HWhWNysx/DzUtiMccIt
         DmEIRC/ZggmSGg4WKX2uSSKNCjwuujJyFFKGcLStZoF3SCFR/SFmDSqfueYtPOmqOBXR
         2z4H8zzsZ997lRgojXOHoUZD58x15pX58Y8uvZFX9BIWivp32HEso4QT+NvsHnPP8BdT
         HVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZGgtz32ux6a+OFJ5/9VUJE0pTJLJ3hFARi5porqzLY=;
        b=Tl1hNLHVpHlFMFdBhwyo7Qs3+mndU0I+yI5/VJfERC9rIn8UQIGNakcW58Q84inuIh
         x86+UpnisiNINepu6XCTm852XS9d+RbZwnMQ4onNQ+uXUO2yqCO3xAT/enbgOVTg/TfF
         wKermNtrcGfKeCRhFNlGsuXbL20b0yi/BUtMKpUV9OrzsdNcW+DxYVlY3dS5OSv75Adc
         40DhUh7IMIT8iTAjdtuP3Yq1xVZ0xZs7Up0hafurVjr7alvZL9nOsglV06b3xDieb0Xc
         dIVNYTV8sEQq7MJQCgCLKiYAswvtYZ9Aw3oU+VdLArks/eyf/jwOP5O4Bysv4BnwR6Uz
         KMTg==
X-Gm-Message-State: AOAM5325P4RjWBGtRw8dPl/p/bZjgvUVdpqKaofKCM8fw2wWPaQs9Xmr
        U9EPfI6nO3NtGtuqplYgOu/uXA==
X-Google-Smtp-Source: ABdhPJxlPvkIrCj7tXMA8hbNTBxwLZRQdHesJLKWQ2Kh+633gVLhaVKIF6HsaACVZ3dMdLyZnkApyQ==
X-Received: by 2002:adf:e2cc:0:b0:203:e8ba:c709 with SMTP id d12-20020adfe2cc000000b00203e8bac709mr31056396wrj.713.1651251021407;
        Fri, 29 Apr 2022 09:50:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm6846906wmc.7.2022.04.29.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:50:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/1] slimbus: Fixes for 5.18
Date:   Fri, 29 Apr 2022 17:49:16 +0100
Message-Id: <20220429164917.5202-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is one SLIMbus fix for 5.18.
Can you please queue this up for 5.18.

Thanks,
Srini

Miaoqian Lin (1):
  slimbus: qcom: Fix IRQ check in qcom_slim_probe

 drivers/slimbus/qcom-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.21.0

