Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B2852A391
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347992AbiEQNgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347975AbiEQNfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:35:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65170CF2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:35:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i19so34717589eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CczRdToQYyS79iXvOF9uezGc9FJnQwNkL8FC0j7GqZc=;
        b=qa0WI3zitk4mo/vP9Tgu6LSAg4l9FD+vov9RuP5ZsrevoHrO6BGsT9PZZLR0s0C/ry
         J74uOPc3PMXLsBoZ0snV+t2ugSnjriIVrvfmfJW5ROZkrO7etlFFBnmn5o6n8xlCEtOe
         HMT3v77yUwOJI0Ag/OWI+KV0yZH/U1WpCAa7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CczRdToQYyS79iXvOF9uezGc9FJnQwNkL8FC0j7GqZc=;
        b=ftlfSOVnBdGifOkE7kHGv2xJrcVrDI5lZ+SoUjp2F9RmaU7RjmDQy7Vgt4VKbRrJ4n
         1qJf7HCQiyfr15mbwpm2kbzZxsscjPDIFEatb84PjQUyB+/t07zbvogHJ3JDrnkhTmTy
         0J1qvrZU0zh3qxbayKRzlsQk2Z/doNiH62qKDPySNYgm1q9yszjwCvDRPe06ClDK/V/z
         jm6yA/omOftBL1izoNeZxIG59h+ioyvXvc5amIrPSqdNWfzpghR0o0yX3gRnBNivs25l
         SmfE5zG7hHwM/FpAGfSzQRB1YXq9/17W8NQw6QFOhdx+vYZdyuWCtm7BRa4i180q8r9c
         YdPQ==
X-Gm-Message-State: AOAM532LI0LfIX/P9oxwK6wLAJblS1eV2CrqA8h9O/UxFhnXREqLWeOt
        2z7iZa4hVBdFzrlvPJl6P8shjw==
X-Google-Smtp-Source: ABdhPJyD21G2He0F3CPkBtOh7TINXtxAfy7CevKrvtEdyM5j0DLCSLTKCJ4IqkSMmDe5Tn1vj7Yy+A==
X-Received: by 2002:a17:906:4795:b0:6f3:d1cc:7127 with SMTP id cw21-20020a170906479500b006f3d1cc7127mr20325899ejc.461.1652794544802;
        Tue, 17 May 2022 06:35:44 -0700 (PDT)
Received: from panicking.amarulasolutions.com (mob-176-245-91-171.net.vodafone.it. [176.245.91.171])
        by smtp.gmail.com with ESMTPSA id jl28-20020a17090775dc00b006f50ceabcb8sm1051398ejc.102.2022.05.17.06.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:35:43 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Simon Holesch <simon.holesch@bshg.com>
Subject: [PATCH] arm: dts: imx6ulz-bsh-smm-m2: Support proper board power off
Date:   Tue, 17 May 2022 15:35:40 +0200
Message-Id: <20220517133540.2456987-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Holesch <simon.holesch@bshg.com>

Supports initiating poweroff on SNVS_PMIC_ON_REQ signal.

Signed-off-by: Simon Holesch <simon.holesch@bshg.com>
---
 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
index 59bcfc9a6b10..c92e4e2f6ab9 100644
--- a/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
+++ b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
@@ -29,6 +29,10 @@ &gpmi {
 	status = "okay";
 };
 
+&snvs_poweroff {
+	status = "okay";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
-- 
2.25.1

