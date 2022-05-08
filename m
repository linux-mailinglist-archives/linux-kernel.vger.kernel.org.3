Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3100151ED03
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiEHKxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiEHKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:52:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E45B7DD;
        Sun,  8 May 2022 03:49:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p18so13233188edr.7;
        Sun, 08 May 2022 03:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wj10WxHIbo6UUCAP9oJqNfD8dGhuPiu7BAPjORdqN3c=;
        b=W2scJrPH7Y546YfSLyYIyMgXfyQHp2qyMXq8whSjj8j2+xJkkVDj3EWjOVBnCGc91m
         HEZVf/DxkWYCzI6J5PUcIHQik+fnLHch0xdnciFl3VSwO80wYrtFEfZlYHdT7e7+GZR7
         2ftoJC4s/oHB31264G4FdV/4cbNfhG5PTjxISAOub0yZW6lUgM0xgnib3teSeMhogvNL
         CQb1gTLl8My01k/05vxI+PuMgfc84zy4jzFedUOYg1Q6soI8zb6ov8n9UmK4wRwWHi96
         7TZtShogZZHk8ItUCm1l1FzXo3cq3zT+WumG4Gfio1jmIyR/4z1JxkGrHAAQygd7wxGn
         peag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wj10WxHIbo6UUCAP9oJqNfD8dGhuPiu7BAPjORdqN3c=;
        b=MTeVFu06uzNYTUun+9G9YsXXvIlDEULgB3MektBQdnAz11iOu30ndgPvwnHqN9dMhT
         j6YA8q+yODJ5OZBqR15zziuV9nWi40vpUUxR6ZaNZc+iAdjkd1ISbkyJ6HbZJm5SVEI0
         f4n43m4UIZPpfIlswhkNZaU2ShBJ/wv5Ibci9JS4jMLlZb1GPVrv370SQwMDtmW/2YEx
         DJmFsTm7pSTeNkkz1+AHQh9HH8ZCF2iVnDbeMDMu9JNftpeX+TbRbovhmaG6NAIweonA
         TryGAZsoLTXwsgNkyQAbRhN3GOdcJsii+WLnyu/vQIPXaVTvRQhu6Q1vnArqqWCdZ7aI
         1Wsg==
X-Gm-Message-State: AOAM532aX8fg3SPe18oK2dkq0bBGNeJwIZTdMFoSErjHk6wtxsw04dF0
        m1KnvV7qiFsQZYSPY8w2/r4=
X-Google-Smtp-Source: ABdhPJy9rTN6jNl0tQIuVSuMp8SiY0yYVYp/7QTdUOBAhtt7BjLHKocyvI7uhj5eqwN+BARk6sDVqA==
X-Received: by 2002:a50:eb87:0:b0:425:c3e2:17a9 with SMTP id y7-20020a50eb87000000b00425c3e217a9mr12311085edr.109.1652006942072;
        Sun, 08 May 2022 03:49:02 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:49:01 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 03/11] clk: qcom: ipq8074: fix NSS port frequency tables
Date:   Sun,  8 May 2022 12:48:47 +0200
Message-Id: <20220508104855.78804-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508104855.78804-1-robimarko@gmail.com>
References: <20220508104855.78804-1-robimarko@gmail.com>
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
2.36.0

