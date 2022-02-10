Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37F44B1441
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbiBJRbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:31:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBJRbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:31:05 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901A22647;
        Thu, 10 Feb 2022 09:31:06 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id e7so12967909ejn.13;
        Thu, 10 Feb 2022 09:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xFsM0nPuhSGSTkyLUY3o2cz0yH3ogdvJBOAYbLu1Hk=;
        b=NFIqILJvmbmsmCjc0R4PAAQddul5/KzW7LG+BLzvj0/dNZC+u98M4M+qdq+pUjpJ0b
         Oleu3IvMbux2SiwuAWOR1U9+OsImEvzVVlmPi7m2AlkbsoVc17iLL2VeR4OGeHSauJ3Z
         /rqv2WzSu8jI0yXOQWXzGDWEiuw19JQe8GtErQMfpZj3RHdSpjzhDZFqd0ZGjC+vzxif
         RyiMmWlwfe82G51A598rtuz61GRA4dKTTyPOKB9+Vj8byqr+b46L+PNIuHY82wlmKQGr
         Dqd+YsQKZRXvgSeDj27Y1rWXcEygIphIXIO233dTjpulEvX72YGnb0homEo3zfQeUyMn
         cerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xFsM0nPuhSGSTkyLUY3o2cz0yH3ogdvJBOAYbLu1Hk=;
        b=SUuxlvnB9MjtMd4szmNey5R8LloXo6YL7VYLMB/Mn9kGt3vWPFpFdYSozWuqd5uYb2
         XOxjp6PVwnov/icsVnhsP0V8OkaSQKlroyQM/x/ngIVAb7tc/lwg41zQPbCOad8bjP+p
         IUXwsG2sZ2R+9zNKz5FssOPHXAlp/NDlRt/S5mkdqo+FDiCaG+Z3zjEPqlZPhQRZVChA
         niZc6MgbnSfwK2fIAF3/zx0tEKGumKvMhLef0SMdUTzHelXgMuwoS+uiXrAGXJNZjVVo
         7SpsNuz+KALKSP+eYxkwuACdpdmjseg8p/eM8/lzMf51FvmBeYgbSMZepOz+VzbD9let
         no2Q==
X-Gm-Message-State: AOAM531pZkoQgeKkKP4njZld5O3jSkepzwQVNx2sNRo+IusxfOVU2D6D
        GThVKCpgxcCBT4ZZayhtPdY=
X-Google-Smtp-Source: ABdhPJzW89YoTkdkUobSkVso7mwzeF8VsYtPcaPJp9tjMWbNziQCLa1dhnHIn3Q/S1wWdTW8tG6m3g==
X-Received: by 2002:a17:907:f9c:: with SMTP id kb28mr7048664ejc.213.1644514265037;
        Thu, 10 Feb 2022 09:31:05 -0800 (PST)
Received: from fedora.robimarko.hr (dh207-99-63.xnet.hr. [88.207.99.63])
        by smtp.googlemail.com with ESMTPSA id m4sm2206551ejl.45.2022.02.10.09.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:31:04 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dirk Buchwalder <buchwalder@posteo.de>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH] clk: qcom: ipq8074: Use floor ops for SDCC1 clock
Date:   Thu, 10 Feb 2022 18:31:00 +0100
Message-Id: <20220210173100.505128-1-robimarko@gmail.com>
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

From: Dirk Buchwalder <buchwalder@posteo.de>

Use floor ops on SDCC1 APPS clock in order to round down selected clock
frequency and avoid overclocking SD/eMMC cards.

For example, currently HS200 cards were failling tuning as they were
actually being clocked at 384MHz instead of 192MHz.
This caused some boards to disable 1.8V I/O and force the eMMC into the
standard HS mode (50MHz) and that appeared to work despite the eMMC being
overclocked to 96Mhz in that case.

There was a previous commit to use floor ops on SDCC clocks, but it looks
to have only covered SDCC2 clock.

Fixes: 9607f6224b39 ("clk: qcom: ipq8074: add PCIE, USB and SDCC clocks")

Signed-off-by: Dirk Buchwalder <buchwalder@posteo.de>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index 1e493f19fa44..c24e33321f72 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -1074,7 +1074,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 		.name = "sdcc1_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll2_gpll0_out_main_div2,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
2.35.1

