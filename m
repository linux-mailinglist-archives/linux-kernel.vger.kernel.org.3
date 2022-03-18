Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7E44DE204
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiCRT7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiCRT7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:59:39 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B5888F1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:58:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id s8so10316658pfk.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YhVmQcxk7mm08dlY1rQzXQP6Uyv11+AP0ourpZiyXRg=;
        b=RWErSpKblwX/sR+pvlG91R/CUdigfxDF5HTT14K/D5D+r33OQUGCfKl1qu032akf3d
         hNT+m0B0xNmpqjbQ5xMOPkHThFptlxGLpGhFXEYWvnhwJRQRQufwe/ppz0j4t2eyG8ZB
         W2XrJ3P1ZFq2h0RG/iKU9pvMWuRpplk0vRDUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YhVmQcxk7mm08dlY1rQzXQP6Uyv11+AP0ourpZiyXRg=;
        b=d8fuRYnaffgi5BRxejOQPP+DTleeocNB9l2xshHv79kVGNYJ+MGf3OY0DtCP2fqJFJ
         AbPsYSB2X5szBXSwKHFddf8KnYmDQ2lwslHMgbejLMa5WuqLJf46XuDBDsTGJq+X0qT/
         1ZbOFF3HZYB6LtG6lRKNrppKP1TAmsIt1TgQzmi6WuyCIxtv6Ii4/RbjKpwCMtaeY3Qs
         d0Ufxl3/YMXgFs+2Hqg0Jpf7vv8JP/7KAsQFYyvrxZQ5B80ci/pS2KZsboeSygrAS0Ij
         Skvsxpn9drXKxSGSuEW1lVlAeUIf4/KPIkaSKiC/1x0gwNQvxRYYiiutUX83o7WwysYQ
         sJAA==
X-Gm-Message-State: AOAM533Xskw5en7N9bw3ltWEqcuwPPlZlyn262BDiG52Kug4GGxNOPot
        +pBpxwrrPn69zlybh/VEE2QPwA==
X-Google-Smtp-Source: ABdhPJx7Q/ytlhyTB0WDX9tZf6nDXxNLstx8vuUE8cccBG/Q3+BCpGDLrgaf1EaxMMvyqRF4bUPLtg==
X-Received: by 2002:a05:6a00:cc2:b0:4fa:7b92:ba06 with SMTP id b2-20020a056a000cc200b004fa7b92ba06mr2026093pfv.59.1647633498442;
        Fri, 18 Mar 2022 12:58:18 -0700 (PDT)
Received: from localhost ([135.84.132.160])
        by smtp.gmail.com with UTF8SMTPSA id a23-20020aa794b7000000b004f7d633a87asm9817009pfl.57.2022.03.18.12.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 12:58:18 -0700 (PDT)
From:   Edmond Gagnon <egagnon@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Edmond Gagnon <egagnon@squareup.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] wcn36xx: Implement tx_rate reporting
Date:   Fri, 18 Mar 2022 14:58:01 -0500
Message-Id: <20220318195804.4169686-1-egagnon@squareup.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements HAL_GET_STATS message in order to report tx_rate to
ieee80211_tx_rate_update. Tested on MSM8939 with WCN3680B running
firmware CNSS-PR-2-0-1-2-c1-00083 on 5.17.

Changes in v2:
 - Refactored to use existing wcn36xx_hal_get_stats_{req,rsp}_msg structs.
 - Added more notes about testing.
 - Reduced reporting interval to 3000msec.
 - Assorted type and memory safety fixes.
 - Make wcn36xx_smd_get_stats friendlier to future message implementors.

Edmond Gagnon (2):
  wcn36xx: Expose get_sta_index in wcn36xx.h
  wcn36xx: Implement tx_rate reporting

 drivers/net/wireless/ath/wcn36xx/hal.h     |  7 ++-
 drivers/net/wireless/ath/wcn36xx/main.c    | 33 +++++++++---
 drivers/net/wireless/ath/wcn36xx/smd.c     | 58 +++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h     |  1 +
 drivers/net/wireless/ath/wcn36xx/txrx.c    | 59 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/txrx.h    |  2 +
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 12 +++++
 7 files changed, 163 insertions(+), 9 deletions(-)

-- 
2.25.1

