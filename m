Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28902525FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379477AbiEMK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiEMK1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:27:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6710B4F455;
        Fri, 13 May 2022 03:27:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so15380019ejk.5;
        Fri, 13 May 2022 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YI155nUOHSVL4tlE4sOnOadIEa+WgUmCuXYZpMGcHUA=;
        b=Rm6J1pHJxRvPIK4VJ5zMJnC8NhQUTAb6xbEtIs0MFjNRWIx5SR4qIHbXrfqtHex8ub
         RuYaTit+B18n0jsKaC+sAodGadyAVrCbnj/atFYgOUAH1iiM60UX6spRFLtH4AL0E7AA
         9iQ7RJqt1rL4mqt/4r6+HjP6bDRG91dEnA1gAS+aRdpHl/qN1/hYWoLKBQYITgdW+/jq
         xRrL2fGJnhBMNW1iVjLrRWO7yZrKOikM7dJzr0P6yXiCa6a3fpPZpO0f4U38F5acPnR7
         VuG8fBYzQ18keVbumCsKwEna5sBQWk6J1nJyJHWDUQ4V2Vqx7SLvSkYuiKwwK2UX2gUq
         Ti3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YI155nUOHSVL4tlE4sOnOadIEa+WgUmCuXYZpMGcHUA=;
        b=185H6HNnJX1wwhsdqHoZ0q4e8DpJXX1j5iLOMj+ZJjl66PLFxswjgexMtruZzWGUjS
         Inxm/nwyT7Ptj79Ih3QmgIV4J5Z87dCnFNdmCSYA8iRd5tPYLxigWMHo/8kNADaot9vl
         OlaaO5NzeQ8aDLa8RK+QQOx/mNhDdEbO2yHFRKzSu8aoRRbS9Zox8jFhsAZQ1SBjIBJZ
         a49cEs0DCyiulvv2vnw83fWg+9YbY4VYmcKaEhVCsdHoCkBiPXkoxA2GVvMOKtuOtjo1
         7Et1kipqml4zMQImV1YlYGbwRxXhiORjgr861Z1pkOURlkl59NN+I+azD4hRyLOcYT6w
         zX1g==
X-Gm-Message-State: AOAM53262THNCBpNzTVVRyl3yMTengscz+83ZaIaSvL52Knn4ds3x+ZT
        Dw8JwebW/lVY0M1k8qC0EZY=
X-Google-Smtp-Source: ABdhPJwk0hU5ZvhE1p1G//dM8Wx7KxcNah3DnxvezqGgZgu2sEocgBoRVS7QqGPjs0xs2Q1z9M76Aw==
X-Received: by 2002:a17:907:7ea7:b0:6f4:7a72:da92 with SMTP id qb39-20020a1709077ea700b006f47a72da92mr3570906ejc.348.1652437622847;
        Fri, 13 May 2022 03:27:02 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906100300b006f3ef214e40sm609677ejm.166.2022.05.13.03.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 03:27:01 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] ARM: dts: imx6dl-colibri: Unify with changes to Apalis iMX6 device trees.
Date:   Fri, 13 May 2022 12:26:11 +0200
Message-Id: <20220513102616.48040-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>


- Follows a change to the SGTL5000 MCLK handling fixed for Apalis iMX6 by
  Fabio.
- Simplify handling of inverted PWM backlight
- Fixes a regression for the capacitive touch introduced with
  https://lore.kernel.org/all/20220411152234.12678-1-max.oss.09@gmail.com/


Changes in v3:
- add reviewed-by tags
- Extend commit comment of "ARM: dts: imx6qdl-colibri: backlight pwm: Simplify inverted backlight"

Changes in v2:
- add reviewed-by tags
- Split the Backlight PWM patch into two patches, a) #pwm-cells 3, b) adapt brightness steps

Max Krummenacher (4):
  ARM: dts: imx6qdl-colibri: Fix capacitive touch reset polarity
  ARM: dts: imx6qdl-colibri: Mux mclk for sgtl5000 with the codec node
  ARM: dts: imx6qdl-colibri: backlight pwm: Simplify inverted backlight
  ARM: dts: imx6qdl-colibri: backlight pwm: Adapt brightness steps

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.20.1

