Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA6752324A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiEKL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiEKL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:59:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367122421A6;
        Wed, 11 May 2022 04:59:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j6so3504591ejc.13;
        Wed, 11 May 2022 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DbPj3JhOBqbVdPUyrkosXwDwTkN/D1a4LQkZfr9FqpU=;
        b=N1Hmib5j1Cxd5wufedcJ9p+52lQIk77xnyHltbdGA/6AMAdLT/A2qtvQgDio0luTja
         UGMancHxeH0GO2GZzsDKZKq5Bx68vx39BY3Fw22WQPRdfqkTdwxxtu8OEyv7ALo/d/5i
         ZmWHTaBwyHsa9eVnB4yJTCWaU+MYWOvhJXXI/IRGn5liP8y9z+2HMPRIN7+rd3LTTw3y
         5o++WMvQTq8Dfdb6fR+alvSmAY4G+6pvOBBMORZQ4KyEsG+D0jr5agDN8t8K8DAc7G3t
         FEg12hhbGx0SlmV3zeBDj5/1Uy0T5Os3vpFHrZAZyrzyFBClIQqa335uM2GDP0B6trep
         eZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DbPj3JhOBqbVdPUyrkosXwDwTkN/D1a4LQkZfr9FqpU=;
        b=CUjaWLnGofz68FcgjlkKkV5Ku9U/UQWVjUFtJJTlzgAjYRYrjPx3r3MzbjI+dulo6D
         aqhZaHuSwUQqyzKFTSCXqlVlNfQ9Zq1mfq+o1ExEkn5z5CcafxDN4aNLdLPixf0OwXHo
         Fnz9a3CKsYGwAtLMYz1QspSkzylFSBcHLMoUAXOAbI6Bd0AhPwcXeM2L1y7r/DNiStEp
         AisLPybKP6xUPPL+NkWxRbtSCZYkWQHTzWtVBOE1iav03O5LObgNpVxi3Av9cA7yxu+X
         HNs1nyN75HZTBoj0jmydToiyPMtblylDzgfNCI0rXbdmW16VFKEV4bSInIRL7n+G9t1S
         b+3g==
X-Gm-Message-State: AOAM531rgpHj4Ybnz/+9xSGwYVsJrHf/A0i/LZSdjAXxfKIo7n1qDEWJ
        /wiT7MPBrGHQXDUKSyWB9mtaJDQF8Zc=
X-Google-Smtp-Source: ABdhPJyqSOvgbfYFazGx3UTmI32+65RgbGO3zkfdRX089EYy4xHTAcMTQGcE9NK9IQuz7SPSqpWa+w==
X-Received: by 2002:a17:906:6a11:b0:6fa:5752:9b2d with SMTP id qw17-20020a1709066a1100b006fa57529b2dmr15252129ejc.703.1652270393601;
        Wed, 11 May 2022 04:59:53 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id g6-20020a50d0c6000000b0042617ba63aasm1089279edf.52.2022.05.11.04.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:59:52 -0700 (PDT)
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
Subject: [PATCH v2 0/4] ARM: dts: imx6dl-colibri: Unify with changes to Apalis iMX6 device trees.
Date:   Wed, 11 May 2022 13:59:06 +0200
Message-Id: <20220511115911.54960-1-max.oss.09@gmail.com>
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

