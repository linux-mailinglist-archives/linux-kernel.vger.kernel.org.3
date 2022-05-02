Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697EE516F3D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384881AbiEBMIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384870AbiEBMIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:08:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6068013F62
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651493104; x=1683029104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9ajzmig39sZIW1tda8C5ZrZa0JA+CxOakY6tZ5XPreo=;
  b=hQ2bwn6syai8i5WDBHKr+PJPDra+ueTWwwxc41MC4PlUjxqwAjv6UEC5
   qKV7EmkyQcSRkov8iJuoVnETP1IDAzGsC0sIcjdCpx1Q6EQC7hMJY8uKc
   Z6xtyq1TILRMPrYPgnP4gC13sPxioi2v8OOlyjhClDVjTSRFr/nxAEabU
   vniXIJtxG+7ZwAOPhEi2DFI8ktAW1wwXvJklrJYaPlCUkoUq/fkfTGXkp
   abupjqc55+M2u/iSBJl/qjRt9JRnahX8AcajKuQYV0KPrIggw2gjrUO4X
   BrL6UelpqaWjE5GXf5Bc4P3VZYPTa3/QfUSPr/KvbFIE41EHTdz7dXNdL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="330179199"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="330179199"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 05:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="663493307"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 May 2022 05:04:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F3115179; Mon,  2 May 2022 15:04:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] ASoC: cs43130: Re-use generic struct u16_fract
Date:   Mon,  2 May 2022 15:04:55 +0300
Message-Id: <20220502120455.84386-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct u16_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/codecs/cs43130.c |  16 ++--
 sound/soc/codecs/cs43130.h | 151 +++++++++++++++++++------------------
 2 files changed, 84 insertions(+), 83 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 04548b577ad5..a2bce0f9f247 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -712,30 +712,30 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 	case CS43130_ASP_PCM_DAI:
 	case CS43130_ASP_DOP_DAI:
 		regmap_write(cs43130->regmap, CS43130_ASP_DEN_1,
-			     (clk_gen->den & CS43130_SP_M_LSB_DATA_MASK) >>
+			     (clk_gen->v.denominator & CS43130_SP_M_LSB_DATA_MASK) >>
 			     CS43130_SP_M_LSB_DATA_SHIFT);
 		regmap_write(cs43130->regmap, CS43130_ASP_DEN_2,
-			     (clk_gen->den & CS43130_SP_M_MSB_DATA_MASK) >>
+			     (clk_gen->v.denominator & CS43130_SP_M_MSB_DATA_MASK) >>
 			     CS43130_SP_M_MSB_DATA_SHIFT);
 		regmap_write(cs43130->regmap, CS43130_ASP_NUM_1,
-			     (clk_gen->num & CS43130_SP_N_LSB_DATA_MASK) >>
+			     (clk_gen->v.numerator & CS43130_SP_N_LSB_DATA_MASK) >>
 			     CS43130_SP_N_LSB_DATA_SHIFT);
 		regmap_write(cs43130->regmap, CS43130_ASP_NUM_2,
-			     (clk_gen->num & CS43130_SP_N_MSB_DATA_MASK) >>
+			     (clk_gen->v.numerator & CS43130_SP_N_MSB_DATA_MASK) >>
 			     CS43130_SP_N_MSB_DATA_SHIFT);
 		break;
 	case CS43130_XSP_DOP_DAI:
 		regmap_write(cs43130->regmap, CS43130_XSP_DEN_1,
-			     (clk_gen->den & CS43130_SP_M_LSB_DATA_MASK) >>
+			     (clk_gen->v.denominator & CS43130_SP_M_LSB_DATA_MASK) >>
 			     CS43130_SP_M_LSB_DATA_SHIFT);
 		regmap_write(cs43130->regmap, CS43130_XSP_DEN_2,
-			     (clk_gen->den & CS43130_SP_M_MSB_DATA_MASK) >>
+			     (clk_gen->v.denominator & CS43130_SP_M_MSB_DATA_MASK) >>
 			     CS43130_SP_M_MSB_DATA_SHIFT);
 		regmap_write(cs43130->regmap, CS43130_XSP_NUM_1,
-			     (clk_gen->num & CS43130_SP_N_LSB_DATA_MASK) >>
+			     (clk_gen->v.numerator & CS43130_SP_N_LSB_DATA_MASK) >>
 			     CS43130_SP_N_LSB_DATA_SHIFT);
 		regmap_write(cs43130->regmap, CS43130_XSP_NUM_2,
-			     (clk_gen->num & CS43130_SP_N_MSB_DATA_MASK) >>
+			     (clk_gen->v.numerator & CS43130_SP_N_MSB_DATA_MASK) >>
 			     CS43130_SP_N_MSB_DATA_SHIFT);
 		break;
 	default:
diff --git a/sound/soc/codecs/cs43130.h b/sound/soc/codecs/cs43130.h
index e62d671e95bb..1dd893674313 100644
--- a/sound/soc/codecs/cs43130.h
+++ b/sound/soc/codecs/cs43130.h
@@ -10,6 +10,8 @@
 #ifndef __CS43130_H__
 #define __CS43130_H__
 
+#include <linux/math.h>
+
 /* CS43130 registers addresses */
 /* all reg address is shifted by a byte for control byte to be LSB */
 #define CS43130_FIRSTREG	0x010000
@@ -372,97 +374,96 @@ enum cs43130_dai_id {
 };
 
 struct cs43130_clk_gen {
-	unsigned int	mclk_int;
-	int		fs;
-	u16		den;
-	u16		num;
+	unsigned int		mclk_int;
+	int			fs;
+	struct u16_fract	v;
 };
 
 /* frm_size = 16 */
 static const struct cs43130_clk_gen cs43130_16_clk_gen[] = {
-	{22579200,	32000,		441,		10,},
-	{22579200,	44100,		32,		1,},
-	{22579200,	48000,		147,		5,},
-	{22579200,	88200,		16,		1,},
-	{22579200,	96000,		147,		10,},
-	{22579200,	176400,		8,		1,},
-	{22579200,	192000,		147,		20,},
-	{22579200,	352800,		4,		1,},
-	{22579200,	384000,		147,		40,},
-	{24576000,	32000,		48,		1,},
-	{24576000,	44100,		5120,		147,},
-	{24576000,	48000,		32,		1,},
-	{24576000,	88200,		2560,		147,},
-	{24576000,	96000,		16,		1,},
-	{24576000,	176400,		1280,		147,},
-	{24576000,	192000,		8,		1,},
-	{24576000,	352800,		640,		147,},
-	{24576000,	384000,		4,		1,},
+	{ 22579200,	32000,		.v = { 441,	10, }, },
+	{ 22579200,	44100,		.v = { 32,	1, }, },
+	{ 22579200,	48000,		.v = { 147,	5, }, },
+	{ 22579200,	88200,		.v = { 16,	1, }, },
+	{ 22579200,	96000,		.v = { 147,	10, }, },
+	{ 22579200,	176400,		.v = { 8,	1, }, },
+	{ 22579200,	192000,		.v = { 147,	20, }, },
+	{ 22579200,	352800,		.v = { 4,	1, }, },
+	{ 22579200,	384000,		.v = { 147,	40, }, },
+	{ 24576000,	32000,		.v = { 48,	1, }, },
+	{ 24576000,	44100,		.v = { 5120,	147, }, },
+	{ 24576000,	48000,		.v = { 32,	1, }, },
+	{ 24576000,	88200,		.v = { 2560,	147, }, },
+	{ 24576000,	96000,		.v = { 16,	1, }, },
+	{ 24576000,	176400,		.v = { 1280,	147, }, },
+	{ 24576000,	192000,		.v = { 8,	1, }, },
+	{ 24576000,	352800,		.v = { 640,	147, }, },
+	{ 24576000,	384000,		.v = { 4,	1, }, },
 };
 
 /* frm_size = 32 */
 static const struct cs43130_clk_gen cs43130_32_clk_gen[] = {
-	{22579200,	32000,		441,		20,},
-	{22579200,	44100,		16,		1,},
-	{22579200,	48000,		147,		10,},
-	{22579200,	88200,		8,		1,},
-	{22579200,	96000,		147,		20,},
-	{22579200,	176400,		4,		1,},
-	{22579200,	192000,		147,		40,},
-	{22579200,	352800,		2,		1,},
-	{22579200,	384000,		147,		80,},
-	{24576000,	32000,		24,		1,},
-	{24576000,	44100,		2560,		147,},
-	{24576000,	48000,		16,		1,},
-	{24576000,	88200,		1280,		147,},
-	{24576000,	96000,		8,		1,},
-	{24576000,	176400,		640,		147,},
-	{24576000,	192000,		4,		1,},
-	{24576000,	352800,		320,		147,},
-	{24576000,	384000,		2,		1,},
+	{ 22579200,	32000,		.v = { 441,	20, }, },
+	{ 22579200,	44100,		.v = { 16,	1, }, },
+	{ 22579200,	48000,		.v = { 147,	10, }, },
+	{ 22579200,	88200,		.v = { 8,	1, }, },
+	{ 22579200,	96000,		.v = { 147,	20, }, },
+	{ 22579200,	176400,		.v = { 4,	1, }, },
+	{ 22579200,	192000,		.v = { 147,	40, }, },
+	{ 22579200,	352800,		.v = { 2,	1, }, },
+	{ 22579200,	384000,		.v = { 147,	80, }, },
+	{ 24576000,	32000,		.v = { 24,	1, }, },
+	{ 24576000,	44100,		.v = { 2560,	147, }, },
+	{ 24576000,	48000,		.v = { 16,	1, }, },
+	{ 24576000,	88200,		.v = { 1280,	147, }, },
+	{ 24576000,	96000,		.v = { 8,	1, }, },
+	{ 24576000,	176400,		.v = { 640,	147, }, },
+	{ 24576000,	192000,		.v = { 4,	1, }, },
+	{ 24576000,	352800,		.v = { 320,	147, }, },
+	{ 24576000,	384000,		.v = { 2,	1, }, },
 };
 
 /* frm_size = 48 */
 static const struct cs43130_clk_gen cs43130_48_clk_gen[] = {
-	{22579200,	32000,		147,		100,},
-	{22579200,	44100,		32,		3,},
-	{22579200,	48000,		49,		5,},
-	{22579200,	88200,		16,		3,},
-	{22579200,	96000,		49,		10,},
-	{22579200,	176400,		8,		3,},
-	{22579200,	192000,		49,		20,},
-	{22579200,	352800,		4,		3,},
-	{22579200,	384000,		49,		40,},
-	{24576000,	32000,		16,		1,},
-	{24576000,	44100,		5120,		441,},
-	{24576000,	48000,		32,		3,},
-	{24576000,	88200,		2560,		441,},
-	{24576000,	96000,		16,		3,},
-	{24576000,	176400,		1280,		441,},
-	{24576000,	192000,		8,		3,},
-	{24576000,	352800,		640,		441,},
-	{24576000,	384000,		4,		3,},
+	{ 22579200,	32000,		.v = { 147,	100, }, },
+	{ 22579200,	44100,		.v = { 32,	3, }, },
+	{ 22579200,	48000,		.v = { 49,	5, }, },
+	{ 22579200,	88200,		.v = { 16,	3, }, },
+	{ 22579200,	96000,		.v = { 49,	10, }, },
+	{ 22579200,	176400,		.v = { 8,	3, }, },
+	{ 22579200,	192000,		.v = { 49,	20, }, },
+	{ 22579200,	352800,		.v = { 4,	3, }, },
+	{ 22579200,	384000,		.v = { 49,	40, }, },
+	{ 24576000,	32000,		.v = { 16,	1, }, },
+	{ 24576000,	44100,		.v = { 5120,	441, }, },
+	{ 24576000,	48000,		.v = { 32,	3, }, },
+	{ 24576000,	88200,		.v = { 2560,	441, }, },
+	{ 24576000,	96000,		.v = { 16,	3, }, },
+	{ 24576000,	176400,		.v = { 1280,	441, }, },
+	{ 24576000,	192000,		.v = { 8,	3, }, },
+	{ 24576000,	352800,		.v = { 640,	441, }, },
+	{ 24576000,	384000,		.v = { 4,	3, }, },
 };
 
 /* frm_size = 64 */
 static const struct cs43130_clk_gen cs43130_64_clk_gen[] = {
-	{22579200,	32000,		441,		40,},
-	{22579200,	44100,		8,		1,},
-	{22579200,	48000,		147,		20,},
-	{22579200,	88200,		4,		1,},
-	{22579200,	96000,		147,		40,},
-	{22579200,	176400,		2,		1,},
-	{22579200,	192000,		147,		80,},
-	{22579200,	352800,		1,		1,},
-	{24576000,	32000,		12,		1,},
-	{24576000,	44100,		1280,		147,},
-	{24576000,	48000,		8,		1,},
-	{24576000,	88200,		640,		147,},
-	{24576000,	96000,		4,		1,},
-	{24576000,	176400,		320,		147,},
-	{24576000,	192000,		2,		1,},
-	{24576000,	352800,		160,		147,},
-	{24576000,	384000,		1,		1,},
+	{ 22579200,	32000,		.v = { 441,	40, }, },
+	{ 22579200,	44100,		.v = { 8,	1, }, },
+	{ 22579200,	48000,		.v = { 147,	20, }, },
+	{ 22579200,	88200,		.v = { 4,	1, }, },
+	{ 22579200,	96000,		.v = { 147,	40, }, },
+	{ 22579200,	176400,		.v = { 2,	1, }, },
+	{ 22579200,	192000,		.v = { 147,	80, }, },
+	{ 22579200,	352800,		.v = { 1,	1, }, },
+	{ 24576000,	32000,		.v = { 12,	1, }, },
+	{ 24576000,	44100,		.v = { 1280,	147, }, },
+	{ 24576000,	48000,		.v = { 8,	1, }, },
+	{ 24576000,	88200,		.v = { 640,	147, }, },
+	{ 24576000,	96000,		.v = { 4,	1, }, },
+	{ 24576000,	176400,		.v = { 320,	147, }, },
+	{ 24576000,	192000,		.v = { 2,	1, }, },
+	{ 24576000,	352800,		.v = { 160,	147, }, },
+	{ 24576000,	384000,		.v = { 1,	1, }, },
 };
 
 struct cs43130_bitwidth_map {
-- 
2.35.1

