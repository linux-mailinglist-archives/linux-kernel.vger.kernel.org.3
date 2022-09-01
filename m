Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F45A8E11
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiIAGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiIAGNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:13:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FBB1195C8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:13:44 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m2so16178621pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=O8bBDnCoRs8QcF9a9YTHJW00uSuoqigF7Vl9n6fRN+g=;
        b=oH31Gdf5vqRML0p5m5PZryA0ik7pfDhdhHogoEhiVTRPGL/GIP2ESBbkNlUqaE2W8g
         X1+R5+4xiq3VdPB/xHuR6F1YTvXnK6eLW5VPTzrMCeg8CKdRBmmH5zeZ2dEiLzcC6TM/
         MfKDOOeHwAPvdtmBs0esq8nd/djl0lLvVgqYf3J5XlAUE6vg/SFMThRYGL6lN5YrYTBI
         lCGM+hILOwuPZY9veB4ychlnV7Ya/zvLNd4aq4n0v8K+ugQTOcY9a+b2rNgepzhQMu+V
         65zxyEin6g9rJ4NGnvzwLftIxqCYEc+Dtkujn9xsdoie3yAwZ3v2b6gzr8PyBRThPetv
         fOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=O8bBDnCoRs8QcF9a9YTHJW00uSuoqigF7Vl9n6fRN+g=;
        b=vQKZ7f4XaPUkduQ5VSXbcEpY7G8fvuc7RteQDgEfK37DIkQTGFaj5EzaiaLIHiTLTk
         +0i9365N9MR0oEkfttbt8rbFlMBBnPWZbXBZ6LBRJzWK32f5cmCDvGXJrOHIq1nQvl1q
         Kt2eOgx2G6OaVHIuK931KivZhVXLgNvt3qxWh5LctlWk9y/oTC56uV9F9FfwjSxCQ1VY
         WmAYs8+C1oGc1TD0H2jUf0Vg02hxVqOSN3iMw0wUBDgcWVn0XuSXHWBF287vn36Vg5kG
         XMVnp+pCk2nPlELC4+oYaUFmoJx11ZXZW+ZjGQOaKE8OHEYhBmn/MK9rThQqUPoPGrEn
         IcIA==
X-Gm-Message-State: ACgBeo298cfiBKWXfdDI+582nLrQjn6DwHuO4a+dJKahOz9HAC68xK+w
        ORk2nnouRGcMj2I5xAOWyt3le6VgTwYphw==
X-Google-Smtp-Source: AA6agR5rNhEiJTl8CoDIthnCVTDI97QMQTOGDirE9ldr1F2XOZkaos1pd7xmxmlsNjjvxVbJjVFArg==
X-Received: by 2002:a17:90a:c1:b0:1f4:f757:6b48 with SMTP id v1-20020a17090a00c100b001f4f7576b48mr6963259pjd.56.1662012823273;
        Wed, 31 Aug 2022 23:13:43 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id c14-20020a170903234e00b00174e9e14f60sm7016929plh.82.2022.08.31.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:13:42 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     mka@chromium.org, dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/2] Add a new board device tree named 'evoker' for herobrine variant.
Date:   Thu,  1 Sep 2022 14:13:33 +0800
Message-Id: <20220901061336.61386-1-sheng-liang.pan@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the initial dts file for new board 'evoker'.


Sheng-Liang Pan (2):
  arm64: dts: qcom: sc7280: Add device tree for herobrine evoker
  dt-bindings: arm: qcom: document sc7280 and evoker board

 .../devicetree/bindings/arm/qcom.yaml         |   5 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sc7280-herobrine-evoker-r0.dts   | 333 ++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts

-- 
2.34.1

