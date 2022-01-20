Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1996B4956EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378244AbiATXV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378187AbiATXUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D631C061748;
        Thu, 20 Jan 2022 15:20:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so8046630wms.0;
        Thu, 20 Jan 2022 15:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EXW/q6yX9wxCGxkY1EpqijRPyr0+7BNt2tp7DEwa3FY=;
        b=CLcuoxP7b2nyCEsoGcgJWSzkusmI6fi81voE1CX+UPLwCpqi5JWmVP1EN/HbrCfJah
         nrEOTgfUf0VutgmSUPMDek+PoTsnuIU0y4awxxHslUeOrG3bSrhjxtS1HlT69p0ZlMb2
         b3YQhKcYg25PHFhTrOSq8eoTtuy2cpNUgTUxsDW3wp216GAj5a/zW6E21Umo5UZVATTy
         ipSfjQlwP2kDJCx82oB4SbWZFlWNpPHTGuFo+kYsf/zz8D7iH2Ehiif1TEpfvi4X0RHL
         vysCd+E6G2CNi+f6nUqq930dP8fpEvbkuQJGRcl5v3ABCy4cuEgsBDIRHMQ0g7uO10WH
         330Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXW/q6yX9wxCGxkY1EpqijRPyr0+7BNt2tp7DEwa3FY=;
        b=fKrHPF/+kKheSvhuIHoHLpiWj222GV/6FOrFFJLTV3qteFFA5iQeGCAetLQRUR1gGO
         L+wTImK62M9y7pVDuOUftdOTc1fAZveNMIw9VBTiktPd5NA5JJcdFSLiiYLIKTx9EoBi
         Ux9or6WsHzH0BxAY8vhCSQ2RF/V/ivPHOYADasxrXsPsZ60xNcHDCMgQg2G9CgQOBC1S
         INKga4meDxMUmz38lplnTr5UiTxTMBB1SQ45pmpbgP1HECqSTjXyftz0t//2kGUG9quc
         YcoGUPfBM/1pGKMmBOqGWDOSO2p+3AofvgQoXJD/8M6gq3HPwEDHzDXb2VciYDcboQXj
         NAXQ==
X-Gm-Message-State: AOAM531Ta6svEjnpH0aWz7csknXh+KZyyue6W0r0OGtmmbWqeVffj1KL
        U4FAcgJAKHCXtsWDZpOi8EE=
X-Google-Smtp-Source: ABdhPJyuS982P3dJ+9/hHjPwlCWgs1xqXBuft+Q47eoy8lSRRAPlhuDfLZ82NRh9r1IW7XzYUW6wYA==
X-Received: by 2002:a05:6000:1184:: with SMTP id g4mr1285241wrx.278.1642720843117;
        Thu, 20 Jan 2022 15:20:43 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:42 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/15] drivers: clk: qcom: gcc-ipq806x: add additional freq for sdc table
Date:   Fri, 21 Jan 2022 00:20:23 +0100
Message-Id: <20220120232028.6738-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional freq supported for the sdc table.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 77bc3d94f580..dbd61e4844b0 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -1292,6 +1292,7 @@ static const struct freq_tbl clk_tbl_sdc[] = {
 	{  20210000, P_PLL8,  1, 1,  19 },
 	{  24000000, P_PLL8,  4, 1,   4 },
 	{  48000000, P_PLL8,  4, 1,   2 },
+	{  52000000, P_PLL8,  1, 2,  15 }, /* 51.2 Mhz */
 	{  64000000, P_PLL8,  3, 1,   2 },
 	{  96000000, P_PLL8,  4, 0,   0 },
 	{ 192000000, P_PLL8,  2, 0,   0 },
-- 
2.33.1

