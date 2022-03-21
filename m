Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486384E2D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350788AbiCUQKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350726AbiCUQJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BA528E1C;
        Mon, 21 Mar 2022 09:08:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o7-20020a05600c4fc700b0038c87edc21eso229962wmq.0;
        Mon, 21 Mar 2022 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qACBw0o2MS9FzPU5J+S+Zvtw1uM7Qy8GLYaDlXl8cVc=;
        b=jv09eBXrKubOhB/lJ/Cnc1XVcj5xu/qO316v/Am5TSXyVGo4NbjwBD1eOlmbnEM3Ww
         9adsDwMfoSnt9kSZLJvE5J3Px/nvoAexUmvAdoTCcKXJQOzQlNMybASUzJUgdY3jOYqG
         cBZauQiPw9/FbEVUyecFVZvjnT58/0uK+rhD3IT0ujmkXIoIHX/W+7kOfIgjsUCsQ6rB
         8IrLv0Ac0WvwZwcHqClklNnItSMt4Au7OHXsYQpd3Sh8iSAZ7nlV0OkzK2ALW8hnTsIu
         D2np3soSSvsZb1FUki0j1Ehz4AyBpn3oonXZrSb01za2jq7vWtDge1zDY2AYrZCP5hBp
         CIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qACBw0o2MS9FzPU5J+S+Zvtw1uM7Qy8GLYaDlXl8cVc=;
        b=ENMvuDvWL2xJXMvagMCc2+swm5QJjC9SxmC015QGnM566PRQ36e7AIN+vzxWZROjN6
         FEZQeKCXF6Xrlw1CdrtOdTnUqtRoKqvno4XnYhgV2T24hYW1hmMghedVE+lfIkeIJaYn
         vOHyI12fN8FA3pLCCT7dQfTTw4WcqiZzSjBx2WNxpIIRnsnGSsDCvShbXqS9Fb0B3Aon
         gvoP9ccxJJhRycEzFuwcyVzZSTbrFbkHfusE48QFHn3ImwjI1POh+AIav1Kuis0fBpAF
         obOaGsKRMGw6MoJa0kwJZ1xfXjJiEPXMxyeg5MM88JnDT5La+ywJZTnqfCQy/ssxkDUS
         d6Ug==
X-Gm-Message-State: AOAM530Qog/69mRfT6K0JsYQiXXHw8XcLnYeDIG8V5SG9SO4DvhPbVWA
        kQXaoyrXbtQclYusNo4equU=
X-Google-Smtp-Source: ABdhPJz4mV/5SRSzgP37E0t//PhLjDGD5FlgzTmgOMo7YXfoPSKRRlOfg6iySAf1FpNIyywRDpvg5A==
X-Received: by 2002:a05:600c:3505:b0:38c:a3a8:8479 with SMTP id h5-20020a05600c350500b0038ca3a88479mr6566275wmq.4.1647878907242;
        Mon, 21 Mar 2022 09:08:27 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:26 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 11/18] clk: qcom: krait-cc: force sec_mux to QSB
Date:   Mon, 21 Mar 2022 16:38:48 +0100
Message-Id: <20220321153855.12082-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

Now that we have converted every driver to parent_data, it was
notice that the bootloader can't really leave the system in a
strange state where l2 or the cpu0/1 can be sourced in a number of ways
for example cpu1 sourcing out of qsb, l2 sourcing out of pxo.
To correctly reset the mux and the HFPLL force the sec_mux to QSB.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 5f98ee1c3681..299eb4c81d96 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -15,6 +15,8 @@
 
 #include "clk-krait.h"
 
+#define QSB_RATE	1
+
 static unsigned int sec_mux_map[] = {
 	2,
 	0,
@@ -181,6 +183,13 @@ krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
 	if (ret)
 		clk = ERR_PTR(ret);
 
+	/*
+	 * Force the sec_mux to be set to QSB rate.
+	 * This is needed to correctly set the parents and
+	 * to later reset mux and HFPLL to a known freq.
+	 */
+	clk_set_rate(clk, QSB_RATE);
+
 err_clk:
 	if (unique_aux)
 		kfree(parent_name);
@@ -378,7 +387,7 @@ static int krait_cc_probe(struct platform_device *pdev)
 	 */
 	cur_rate = clk_get_rate(l2_pri_mux_clk);
 	aux_rate = 384000000;
-	if (cur_rate == 1) {
+	if (cur_rate == QSB_RATE) {
 		dev_info(dev, "L2 @ QSB rate. Forcing new rate.\n");
 		cur_rate = aux_rate;
 	}
@@ -389,7 +398,7 @@ static int krait_cc_probe(struct platform_device *pdev)
 	for_each_possible_cpu(cpu) {
 		clk = clks[cpu];
 		cur_rate = clk_get_rate(clk);
-		if (cur_rate == 1) {
+		if (cur_rate == QSB_RATE) {
 			dev_info(dev, "CPU%d @ QSB rate. Forcing new rate.\n", cpu);
 			cur_rate = aux_rate;
 		}
-- 
2.34.1

