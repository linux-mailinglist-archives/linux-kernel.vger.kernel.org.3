Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504EF516DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384443AbiEBKGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384354AbiEBKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:06:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB111165;
        Mon,  2 May 2022 03:02:47 -0700 (PDT)
From:   Viraj Shah <viraj.shah@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651485765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WHd3sYmGrhY6M+5FnEIdkE/HqreC6sBnMmlSZvNnFpc=;
        b=r0zn+wZ51sP9aEwYpzCnMZ0yX5wqsri6t4lYJ4cjqRNMGkYVvXQal3fSND4y5kmK1cojGm
        3NgeN4bmU81hcmRsj8kE5ISxwFWZhNpe50dO0HA9+3AB4NEWeMengXhbce+HIBlNumilv/
        3rJNMZiQs8UdFvlggdMN0FLdKt1AuJq892vb/4xIgq1ehKr9M81Rm8Bt8AI4R0yN8dA62q
        I5Q0j4fs70EOEvtfEWcEJjjrQNuGeSkFDfNGjOw3/RhDPw44p79Cg1esfVrwfvHuEQcwRH
        xorQnPjcEjDzuui8HfdXRe+go2rwEbrukAyx4rDLyd4tOrjiB+pMPRCwEbig2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651485765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WHd3sYmGrhY6M+5FnEIdkE/HqreC6sBnMmlSZvNnFpc=;
        b=+vwnH20JgOmFpv2rtlYhJNjVvYFHRhxW0sK2xJEh1imI5MEzSPO2gOOL5a3By6P/N8y+uN
        l0wpjdogZs4Kc3Dw==
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] imx8mm display controller power sequence 
Date:   Mon,  2 May 2022 12:02:29 +0200
Message-Id: <20220502100233.6023-1-viraj.shah@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch queue addresses the power sequence of the display controller
of the imx8mm SoC. The sequence mentioned in example code 5 in section
5.2.9.5 of reference manual imx-8MMini-yhsc.pdf was not being performed.
This meant that the display controller was not coming up.

Viraj Shah (4):
  soc: imx: gpcv2: Power sequence for DISP
  soc: imx: imx8m-blk-ctrl: Display Power ON sequence
  soc: imx: imx8m-blk-ctrl: Add reset bits for mipi dsi phy
  arm64: dts: imx8mm.dtsi: Add resets for dispmix power domain.

 arch/arm64/boot/dts/freescale/imx8mm.dtsi |  1 +
 drivers/soc/imx/gpcv2.c                   | 36 +++++++++++++++++++----
 drivers/soc/imx/imx8m-blk-ctrl.c          |  9 ++++--
 3 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.20.1

