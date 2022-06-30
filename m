Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D156139E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiF3Hv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiF3Hvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:51:53 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACED3D485
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:51:50 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1656575508; bh=rRoN50bSZ9LjLmVhKTMCvwft+rCdKdFeTqH/6EpOtBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ql8u+nWqq5kjW7gVW/uuylUM6MGYX2NxpAB79e3Pb4yzVmiYelMJ7A0plzO6q7foR
         aa3ifLUMDXLgE5uDzPZkehT/48vQigGGHZ0gc9ZA3zmtBv/HtwrNgFRPt1gMr/CNqH
         yhlxUCT2WK8v0vLL/r/zSTmCQyHXn9xXINECwJp0=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Stephen Kitt <steve@sk2.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Dan Murphy <dmurphy@ti.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 4/4] ASoC: tas2764: Fix amp gain register offset & default
Date:   Thu, 30 Jun 2022 09:51:35 +0200
Message-Id: <20220630075135.2221-4-povik+lin@cutebit.org>
In-Reply-To: <20220630075135.2221-1-povik+lin@cutebit.org>
References: <20220630075135.2221-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

The register default is 0x28 per the datasheet, and the amp gain field
is supposed to be shifted left by one. With the wrong default, the ALSA
controls lie about the power-up state. With the wrong shift, we get only
half the gain we expect.

Signed-off-by: Hector Martin <marcan@marcan.st>
Fixes: 827ed8a0fa50 ("ASoC: tas2764: Add the driver for the TAS2764")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2764.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 55da1b3440e1..846d9d3ecc9d 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -541,7 +541,7 @@ static DECLARE_TLV_DB_SCALE(tas2764_playback_volume, -10050, 50, 1);
 static const struct snd_kcontrol_new tas2764_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Volume", TAS2764_DVC, 0,
 		       TAS2764_DVC_MAX, 1, tas2764_playback_volume),
-	SOC_SINGLE_TLV("Amp Gain Volume", TAS2764_CHNL_0, 0, 0x14, 0,
+	SOC_SINGLE_TLV("Amp Gain Volume", TAS2764_CHNL_0, 1, 0x14, 0,
 		       tas2764_digital_tlv),
 };
 
@@ -565,7 +565,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_SW_RST, 0x00 },
 	{ TAS2764_PWR_CTRL, 0x1a },
 	{ TAS2764_DVC, 0x00 },
-	{ TAS2764_CHNL_0, 0x00 },
+	{ TAS2764_CHNL_0, 0x28 },
 	{ TAS2764_TDM_CFG0, 0x09 },
 	{ TAS2764_TDM_CFG1, 0x02 },
 	{ TAS2764_TDM_CFG2, 0x0a },
-- 
2.33.0

