Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733BB5521FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiFTQNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244530AbiFTQN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:13:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A47A2019C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:13:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e2so4862029edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2D5RHmuIZcoIP1zdKa7QdderVGwM9Ky0GeQbDgGuV4E=;
        b=cBeckDrRB9/yhrilFmAYPRbHI+uCOGC9r5l10lGl5KWIuYXQFFSo/hVkPChl9UeCyH
         wBBw7i50bAZfLUQqfouR6sIS2+TebyspNUdWmgOxirNNX4SMGLsZoByt1ziMruvu15R3
         DuUo5zmOue5M1tGJ/JQ1+B1qwrknvfxQ6DXmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2D5RHmuIZcoIP1zdKa7QdderVGwM9Ky0GeQbDgGuV4E=;
        b=K1K+k5SxrCV/zN7mpDgpUoHedXLnamsxmRk2T6rITJpFhlmFkB12ZnPMvc9n62SrQ1
         xNd4w4ikg7R4ESNzfQns6AvwvSO9NhdbxpPGCUtGt4DZI7UTuxHH4xOr8SMhm2jsarMt
         q3wIapGiiEjF9zbNDlefVB6nqx0LyS3xQd1Iefv2YvDiUoE1lW4ejqhmDzCQsq5vB6/H
         Wl2y3+FkKHUSj4su6gpPTl+vl1YMFZUhV/ZLvkquNbABXX86J/JsMNvNwaw+EsZtlqS/
         E6y38CS27QjeEx+URPt6e5V7S0VubGrw1ZMZgiielrqqwiUmatqejoOLLPushLmuLt0j
         qn9w==
X-Gm-Message-State: AJIora8t/eAsRYCceUscFsS0WvGXrfL1th2GZx0R81i9hX7i3wsVLRbL
        gxgu4/ns3sTQjStYdF6y1Sp/5Q==
X-Google-Smtp-Source: AGRyM1v7ZJ3iiAZyELv66iNp28JcyKUeN2jksoFtm1ez5u/wccNGFBn5n/fvYMaTqGQwqfVUvkI44Q==
X-Received: by 2002:a05:6402:e81:b0:432:7f12:1878 with SMTP id h1-20020a0564020e8100b004327f121878mr29886857eda.179.1655741604172;
        Mon, 20 Jun 2022 09:13:24 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-55-189.cust.vodafonedsl.it. [188.217.55.189])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b00706c1327f4bsm6209772ejo.23.2022.06.20.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:13:23 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        jacopo@jmondi.org,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: rockchip: px30: fix ov5695 camera probe
Date:   Mon, 20 Jun 2022 18:13:17 +0200
Message-Id: <20220620161321.1898840-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This series fix camera probing issue of ov5695 camera driver for px30 evb.
Improve also the ov5695.c driver using using regulator_bulk_enable/regulatore_bulk_disable
function in __ov5695_power_on/__ov5695_power_off functions instead of for loop

1. max drive-strength for cif_clkout_m0
2. add mux for mipi-pdn pad
3. use rk gpio naming convention for reset-gpio of ov5695

Note:
 - This series was tested on PX30_Mini_EVB_V11_20190507 board

Tommaso Merciai (3):
  arm64: dts: rockchip: px30: max drive-strength for cif_clkout_m0
  arm64: dts: rockchip: px30: add mux for mipi-pdn pad
  arm64: dts: rockchip: px30: use rk gpio naming convention into
    reset-gpios

 arch/arm64/boot/dts/rockchip/px30-evb.dts | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.25.1

