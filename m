Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6C59C758
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiHVSy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbiHVSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:54:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189D310F8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:53:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v23so5461284plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DI8SqYRuhD4dfW8aoV8U0vpm1zmv7loV77zhZIVRKgs=;
        b=BSUYK+hPwFo2UUcXcug7bFeBJpcLeuhIBk8GkyZ32AiN0J0T9kt6Q53Zs4ptCr4E6y
         bz6H+1Gc+O5mv45FGya+vh5/XOEI5u7wF35jDy2PLPheh15w/zEdmbDP3Ii2FfzE+Aqh
         GmDqGBJX+jF/Bp2i2I0MpkmGRnQQwPD7fWQ6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DI8SqYRuhD4dfW8aoV8U0vpm1zmv7loV77zhZIVRKgs=;
        b=tTG45l8gIz3fYT4G5sv/RlbCjaovoJwi6DZjQ3cRm7GJBAPUaGI/kbpMAuRl+Xc4eF
         las4A/wwKs0EhwGHz3AnJhaDQBNmiXXvBdzNSutcx3iGWWZB0IUUzF28qZesNIohGYUb
         AcLD0CFvQvW8DH9tSqM4IfYLQMtBCmaoAtlr0dvgIcJLG7O6nbfwl4D5nD9e/vdXtI4g
         Q0mvwsPJ2T6DnRwmmP3rmagsmHAEsmu9d3eDbXxpU8/kcW8IUKmU1z+K0+SVqXNWij2N
         XNB5DmL28TMnulBqeBSgTIGeB87u4xPPYpEzuZqzJK+8jNe8JQiP2YotqjX8iYjtL6o7
         YZDQ==
X-Gm-Message-State: ACgBeo2rjjeluheh0vj8DR1FsB1GNjYXbtp5ejNzUXlFNvOmBi2qPpMd
        QpTgz3CsyzzDXlegqIuEeH4YW6d8RSGfYQ==
X-Google-Smtp-Source: AA6agR63og+ynhTTJk+v2XpcgBYdrLznSAlhS1NHVaZUDxVTOTd5+Acqdc2MwzSAVasoolC9Vrq6hg==
X-Received: by 2002:a17:902:f68f:b0:172:ff8a:90d4 with SMTP id l15-20020a170902f68f00b00172ff8a90d4mr207162plg.2.1661194396612;
        Mon, 22 Aug 2022 11:53:16 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:1969:d650:d765:53ef])
        by smtp.gmail.com with UTF8SMTPSA id 127-20020a621685000000b0052d6ad246a4sm9275058pfw.144.2022.08.22.11.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:53:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 1/2] clk: qcom: gcc-sc7180: Keep USB GDSC power domain on when USB wakeup is enabled
Date:   Mon, 22 Aug 2022 11:53:10 -0700
Message-Id: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set GENPD_FLAG_ACTIVE_WAKEUP for the USB GDSC power domain of SC7180.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/clk/qcom/gcc-sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index c2ea09945c47..2b6b66d01833 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -2223,6 +2223,7 @@ static struct gdsc usb30_prim_gdsc = {
 	.gdscr = 0x0f004,
 	.pd = {
 		.name = "usb30_prim_gdsc",
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 };
-- 
2.37.1.595.g718a3a8f04-goog

