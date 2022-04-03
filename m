Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E07B4F08C3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 12:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiDCKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 06:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiDCKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 06:39:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFAD2529B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 03:37:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n6so356351ejc.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 03:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9qI2Eo7TPlccJ8aRd/LC71d9pVHYGJmUGf3GK2xFlsg=;
        b=VisdoheX0ezHOj0eWVSwSXfjEJWDQGhOtzi47hdsY3QsrBz6UTtLy9rmEfoVKDQ5qG
         RMuydcQuuka3mXjiHPCpSg1UNQKfibkAW6abyWuYDpV/PNMPowQPLVyVxvYqg5gkmQYb
         Stuc5Elwl2H7uN4E2cx5RVf2rgNiMZXNdekWgv1Oz3/9BrEMhMNOEiAhWTra6YQInaPo
         zRh1AEKoByo8H2cUmvU0iPa6AfJdFqteUVFjFuw1wOuCxxlIuW9CJ0nJQSlATNgnd3kf
         gFggjYrmNl/QOeHtSFMavEc6o/xjnDAF4OV/tS6LyiW1YAVvXaaTYxgfWYMdU1WKFoNL
         PNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9qI2Eo7TPlccJ8aRd/LC71d9pVHYGJmUGf3GK2xFlsg=;
        b=zMSMxpI3FVRY761AFJhicSkb4+2Rh2ZpwJPaUaV6nwroEfjGRtB6/4OnHKyPXuwv/B
         FYH9Pbf4LbhWxGZnwwdczr90vYyIEsrKu27RFwkncTsJ5vV1a1NdaNvzmok7BUpHnGHo
         H0fgZVJzRnpt6DkCRzOqH7eHHTRe1O+6dcJZcINbcKDgvdeG+aOYIbXOZLtYyC2LTvh6
         NEx8P6uMU5Ql7YhMCWExPWG6cBM1ec0bnHUf2yrnBUcKWYQr3J6BwqB09676q1yYTcHw
         x2OEuystcKb8FyEtMB7d/csFFTAigGdg+vbHIzdID6jUPfHKPkP9cdHKAWZxtZS3QyR5
         d9Og==
X-Gm-Message-State: AOAM530xS4VoCdJGuuERWVXvj3yVX/4IaJcz/G5g16BySEdiLX3iz77z
        rObjiSU/g5COWAJV67F79u4=
X-Google-Smtp-Source: ABdhPJylypQBQl7Hnw52f7R/ThO7f5sS4AWczy7vYV9j/vcZjMjiH8jmUXuVfhuP5g8HkLP6SKgf8Q==
X-Received: by 2002:a17:906:5d0e:b0:6e0:2cd5:a87c with SMTP id g14-20020a1709065d0e00b006e02cd5a87cmr6694253ejt.708.1648982243041;
        Sun, 03 Apr 2022 03:37:23 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b006e1382b8192sm3130751ejc.147.2022.04.03.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:37:22 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: remove macro rtw_pwr_wakeup()
Date:   Sun,  3 Apr 2022 12:37:09 +0200
Message-Id: <20220403103713.12883-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This series removes the rtw_pwr_wakeup() macro. It is actually just an
alias for the _rtw_pwr_wakeup() function and can be removed to simplify
the code.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: remove unused parameter from _rtw_pwr_wakeup()
  staging: r8188eu: remove constant parameter from _rtw_pwr_wakeup()
  staging: r8188eu: remove macro rtw_pwr_wakeup()
  staging: r8188eu: clean up comment for rtw_pwr_wakeup()

 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 14 ++++++--------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  5 +----
 2 files changed, 7 insertions(+), 12 deletions(-)

-- 
2.35.1

