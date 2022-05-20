Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77852E9A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348053AbiETKK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiETKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8100DFF6A;
        Fri, 20 May 2022 03:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44B2861CFE;
        Fri, 20 May 2022 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92626C36AE3;
        Fri, 20 May 2022 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653041420;
        bh=b5B3dWn6n9Wxng7nBg4KPCY57stZm2SUMOlxnd/cJt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDeht8FOFq8hO8w1PZZUlFAGMZjBPOubMjKDjmKbHJu6IkiTaaRuPx98Tg+mqAMUP
         szPmag55Qof2XpivZOcAujXs0Inu/jN7h3+BwGEU7VKHxNSVcrpK9QEOWGNzQiu94H
         Vj25DWKdDUHKc9s+DjdGPCqsabrvPZZ4z7fJzmOg8qV+Od0DxH79gTzPnYsEWleupI
         etyJ+AxawS3VPkAry7uclzUndFIDeHV+fixCkLSaPRKcmFTFbw9jDZ3j/NKfGPkzYU
         YJpO/GG5H1PlxNjRjed0vJiMqQRUiRPqcauJ25p3fkaq3fnfvf8p43nOI1qgoDr3B2
         XxfR34OqYcVYQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nrzaO-00056w-Bg; Fri, 20 May 2022 12:10:20 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/3] clk: qcom: gdsc: add collapse-bit helper
Date:   Fri, 20 May 2022 12:09:46 +0200
Message-Id: <20220520100948.19622-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520100948.19622-1-johan+linaro@kernel.org>
References: <20220520100948.19622-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper for updating the SW_COLLAPSE bit during initialisation and
state updates.

Note that the update during initialisation was relying on the
SW_COLLAPSE bit not having been set earlier rather than passing in zero
explicitly to clear the collapse vote.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gdsc.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 44520efc6c72..c676416e685f 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -132,10 +132,24 @@ static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
 	return -ETIMEDOUT;
 }
 
+static int gdsc_update_collapse_bit(struct gdsc *sc, bool val)
+{
+	u32 reg, mask;
+	int ret;
+
+	reg = sc->gdscr;
+	mask = SW_COLLAPSE_MASK;
+
+	ret = regmap_update_bits(sc->regmap, reg, mask, val ? mask : 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
 {
 	int ret;
-	u32 val = (status == GDSC_ON) ? 0 : SW_COLLAPSE_MASK;
 
 	if (status == GDSC_ON && sc->rsupply) {
 		ret = regulator_enable(sc->rsupply);
@@ -143,9 +157,7 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status)
 			return ret;
 	}
 
-	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
-	if (ret)
-		return ret;
+	ret = gdsc_update_collapse_bit(sc, status == GDSC_OFF);
 
 	/* If disabling votable gdscs, don't poll on status */
 	if ((sc->flags & VOTABLE) && status == GDSC_OFF) {
@@ -425,8 +437,7 @@ static int gdsc_init(struct gdsc *sc)
 		 * If a Votable GDSC is ON, make sure we have a Vote.
 		 */
 		if (sc->flags & VOTABLE) {
-			ret = regmap_update_bits(sc->regmap, sc->gdscr,
-						 SW_COLLAPSE_MASK, val);
+			ret = gdsc_update_collapse_bit(sc, false);
 			if (ret)
 				return ret;
 		}
-- 
2.35.1

