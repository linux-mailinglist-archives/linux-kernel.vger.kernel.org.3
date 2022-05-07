Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC051E9E9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387266AbiEGUdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387194AbiEGUdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B1BC99;
        Sat,  7 May 2022 13:29:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ba17so12163189edb.5;
        Sat, 07 May 2022 13:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVsuzFv9nImFGpDrqebroDd7vxQ+CQ3cbUIBolPZTpE=;
        b=nTyJjN7cBhOrq/T0R7DQ/2HurtjwJuJVm0LgIkFe3g4pfl7QfeN9zuSG5X93bRihvR
         LL5gfjRsN5YuqsY0o2ii19nyU24EOZEtx7dWBuudoD9QhO98f28D7c+D+fXzsFW2fElE
         DEw3pnMzyg+LHerAncpuURMT8DmJzofg7YveSicDfqHD76JsdY0gSKAQjrWfO3Y994NZ
         Doj/IlWRLvb64F8qHj2914ltUZ2jVtbk8fWixbLTOP0Oa/xGO973vgrFqWfBwmkwUyL+
         vF6nIjS89dagMk/a6xWHaS7R+3UCnShL/qhU6yPMwkQuJcOYpTSTCRPdUsGUXPeHlpnU
         Xu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVsuzFv9nImFGpDrqebroDd7vxQ+CQ3cbUIBolPZTpE=;
        b=7/hz6J+NIeZOPBkSUcc3mCsc+ZIh/dOohdcA9nvjpbpn2+jEAtzRAg0K8th8X+3bIQ
         eIL0U4ywHicaJGC+gDASJt/YRT35snTZDVb9IAIIG3GNcus02oyPZ0DMbDOh8bpp9PGS
         6x1gkAxRTMpWkm4bjtADpQNHBNL4dq429u9Yf9cOA4ZsSvDd8EAg0e4r0Ev5wUdG9CxL
         hNrivbSWLr3y+8Jqf6JS+hzXzU/tvLVDs6StgqR8LLP63jN/veZ5APInbnVPc1UA3yy3
         epEh54KQ+VDe+PD4YVS6ZVJtDUnxJPavPYijzecyDDQ0sZc7k1pKdPyHgDItiHtjt3CH
         tbOQ==
X-Gm-Message-State: AOAM530CnWr0u8jD4cAZ2m9ujWMNGA61JyICPHDIprFvuwQIUjBUhdvm
        prAFip+unYx0hJLtA3rTw7BAiuQLfo+baA==
X-Google-Smtp-Source: ABdhPJxHQU0dvQr9rPl0/XdeFJKsyLibl4dVUb1raUn89rz69rq0Xw5IacLnprtVj6YJFvRyMez64g==
X-Received: by 2002:aa7:d416:0:b0:425:f5c7:d633 with SMTP id z22-20020aa7d416000000b00425f5c7d633mr9832309edq.105.1651955394531;
        Sat, 07 May 2022 13:29:54 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:29:54 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 03/11] clk: qcom: ipq8074: fix NSS port frequency tables
Date:   Sat,  7 May 2022 22:29:40 +0200
Message-Id: <20220507202948.397271-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507202948.397271-1-robimarko@gmail.com>
References: <20220507202948.397271-1-robimarko@gmail.com>
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

NSS port 5 and 6 frequency tables are currently broken and are causing a
wide ranges of issue like 1G not working at all on port 6 or port 5 being
clocked with 312 instead of 125 MHz as UNIPHY1 gets selected.

So, update the frequency tables with the ones from the downstream QCA 5.4
based kernel which has already fixed this.

Fixes: 7117a51ed303 ("clk: qcom: ipq8074: add NSS ethernet port clocks")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/gcc-ipq8074.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
index b4291ba53c78..f1017f2e61bd 100644
--- a/drivers/clk/qcom/gcc-ipq8074.c
+++ b/drivers/clk/qcom/gcc-ipq8074.c
@@ -1788,8 +1788,10 @@ static struct clk_regmap_div nss_port4_tx_div_clk_src = {
 static const struct freq_tbl ftbl_nss_port5_rx_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(25000000, P_UNIPHY1_RX, 12.5, 0, 0),
+	F(25000000, P_UNIPHY0_RX, 5, 0, 0),
 	F(78125000, P_UNIPHY1_RX, 4, 0, 0),
 	F(125000000, P_UNIPHY1_RX, 2.5, 0, 0),
+	F(125000000, P_UNIPHY0_RX, 1, 0, 0),
 	F(156250000, P_UNIPHY1_RX, 2, 0, 0),
 	F(312500000, P_UNIPHY1_RX, 1, 0, 0),
 	{ }
@@ -1828,8 +1830,10 @@ static struct clk_regmap_div nss_port5_rx_div_clk_src = {
 static const struct freq_tbl ftbl_nss_port5_tx_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(25000000, P_UNIPHY1_TX, 12.5, 0, 0),
+	F(25000000, P_UNIPHY0_TX, 5, 0, 0),
 	F(78125000, P_UNIPHY1_TX, 4, 0, 0),
 	F(125000000, P_UNIPHY1_TX, 2.5, 0, 0),
+	F(125000000, P_UNIPHY0_TX, 1, 0, 0),
 	F(156250000, P_UNIPHY1_TX, 2, 0, 0),
 	F(312500000, P_UNIPHY1_TX, 1, 0, 0),
 	{ }
@@ -1867,8 +1871,10 @@ static struct clk_regmap_div nss_port5_tx_div_clk_src = {
 
 static const struct freq_tbl ftbl_nss_port6_rx_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
+	F(25000000, P_UNIPHY2_RX, 5, 0, 0),
 	F(25000000, P_UNIPHY2_RX, 12.5, 0, 0),
 	F(78125000, P_UNIPHY2_RX, 4, 0, 0),
+	F(125000000, P_UNIPHY2_RX, 1, 0, 0),
 	F(125000000, P_UNIPHY2_RX, 2.5, 0, 0),
 	F(156250000, P_UNIPHY2_RX, 2, 0, 0),
 	F(312500000, P_UNIPHY2_RX, 1, 0, 0),
@@ -1907,8 +1913,10 @@ static struct clk_regmap_div nss_port6_rx_div_clk_src = {
 
 static const struct freq_tbl ftbl_nss_port6_tx_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
+	F(25000000, P_UNIPHY2_TX, 5, 0, 0),
 	F(25000000, P_UNIPHY2_TX, 12.5, 0, 0),
 	F(78125000, P_UNIPHY2_TX, 4, 0, 0),
+	F(125000000, P_UNIPHY2_TX, 1, 0, 0),
 	F(125000000, P_UNIPHY2_TX, 2.5, 0, 0),
 	F(156250000, P_UNIPHY2_TX, 2, 0, 0),
 	F(312500000, P_UNIPHY2_TX, 1, 0, 0),
-- 
2.35.1

