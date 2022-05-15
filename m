Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30A527A3D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiEOVBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiEOVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:00:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E884A452;
        Sun, 15 May 2022 14:00:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ks9so25273694ejb.2;
        Sun, 15 May 2022 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/I4h6a0+55bSw+/uZ84Z4GGZ1gfpli20lnEWHPl1Hg=;
        b=EQ7RQv5d8XXcBQt7PTNEWL+apenjeues+htUviZ9KkG/nbsKGG/fiMgFqxbYLuh8p2
         LU6DcmEvw2iNKNKtsk/BXckaINBZNemszbQqXBSgcB8Xka1W/rsXKCg04TjgcHzzD0EN
         +cHbPs4n+19yh9B+MGB/Mu3f6DY6z4WvBOH04alSoLJeKdHwSeyNCkby75dT+iNgYrZU
         ed1Nd4DUg+VFwCYY2YIGVHUOn8UvXzPWJPS080lUW+AI55orZ64aPK/4vnVk3f/DVSfq
         nfpXV5o3R/SSRTCOymiuRtCruoTXntpqgC2927+1AMGtyV1pZE1YxTvmuKkJaSRo6EfK
         colQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/I4h6a0+55bSw+/uZ84Z4GGZ1gfpli20lnEWHPl1Hg=;
        b=aWK5jOsqW3n4sFxDBMw3IkYiiXeXW29aiseFUUnkATr+1DByKILljOwDZZWIlVdLoU
         MWx8H6efDqpEzXo0Ahw3A38AimVLsjrircd1XsqiuJdlwPIZF0J5VbYsNNRzjni+xzWM
         44dCtXOxwurwo7+5lr3hspbUSe6GrBcrqbvcK9JHcSdADWoi4LOWx9YfHhUSZsY2At8P
         VTmdjDvI/4LhlIAEYpBHg90F3tk6OZxc9al5qVxPdUl2FA3BPX7AiBIvJJQqK91BeEzz
         DsaK0r1ZYEK8QovG3fT/3CiVIAHtS7qXbT7AYnyEZnArDqfxo8uN3ohNqeSMF3I6+N8D
         IAhQ==
X-Gm-Message-State: AOAM533qaICi2h7T7UlB/GO6UGIPTt4nci7fCx8kVqMDEejgubF8mWwM
        IxCzCyVoc23BbizjNKv5vCQ=
X-Google-Smtp-Source: ABdhPJyOIejBuRFTlDRjZ0spAVelYNvKdT2KdGxTxSdO8irynX9ggM8RylkFU+1M5gM2YcnjVadkmQ==
X-Received: by 2002:a17:907:3f26:b0:6f4:dc59:3cfe with SMTP id hq38-20020a1709073f2600b006f4dc593cfemr12605064ejc.528.1652648453883;
        Sun, 15 May 2022 14:00:53 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:00:53 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 03/11] clk: qcom: ipq8074: fix NSS port frequency tables
Date:   Sun, 15 May 2022 23:00:40 +0200
Message-Id: <20220515210048.483898-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515210048.483898-1-robimarko@gmail.com>
References: <20220515210048.483898-1-robimarko@gmail.com>
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
2.36.1

