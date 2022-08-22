Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7CD59C6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiHVSqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiHVSox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:44:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B528C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661193794; x=1692729794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n8LryROOr9/Rmu/wIyOOGB0YSEQdyNpliRqkID42vQM=;
  b=e5T383gH14k9lNfpcTH4fJeJQQEPGT6ErfFb1NfHeoc1dLo6wMEVFBJA
   6D96xa0wigf88LmUNKM2Fiz/6eVQCVigjQnBZY65sEKXAvcvesi+ipti+
   hM4fnO/omyXpAEZWMCr5FRwkI/Hw63KRg6L013F5hD/CTBhmkRZluCEi4
   n9TRmUnppIr5FvktXRJpusRVAfF1D/f/ls9tpySke2Qyur8B+COlnOWr5
   xLGw9fm22z4EpvVkwVqsZW12ugHR/rDNcJcmtrIKIyr3+XwcytmCGTlW/
   bsjrrp/J5dlBwW/S1PQc4wXYtIAd6jDOdVb+y+LU3pflo93rmG7LyTZTv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280464704"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="280464704"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:43:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="669671100"
Received: from apascali-mobl2.ger.corp.intel.com (HELO pbossart-mobl3.home) ([10.252.42.21])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:43:10 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Chao Song <chao.song@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] ASoC: wcd9335: remove always-true condition
Date:   Mon, 22 Aug 2022 20:42:37 +0200
Message-Id: <20220822184239.169757-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220822184239.169757-1-pierre-louis.bossart@linux.intel.com>
References: <20220822184239.169757-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/wcd9335.c:1824:22: style: Condition 'tx_port==13' is
always true [knownConditionTrueFalse]
  } else if (tx_port == 13) {
                     ^
sound/soc/codecs/wcd9335.c:1802:16: note: Assuming that condition
'tx_port==12' is not redundant
  if ((tx_port == 12) || (tx_port >= 14)) {
               ^
sound/soc/codecs/wcd9335.c:1802:35: note: Assuming that condition
'tx_port>=14' is not redundant
  if ((tx_port == 12) || (tx_port >= 14)) {
                                  ^
sound/soc/codecs/wcd9335.c:1824:22: note: Condition 'tx_port==13' is
always true
  } else if (tx_port == 13) {
                     ^
sound/soc/codecs/wcd9335.c:1845:22: style: Condition 'tx_port==13' is
always true [knownConditionTrueFalse]
  } else if (tx_port == 13) {
                     ^
sound/soc/codecs/wcd9335.c:1802:16: note: Assuming that condition
'tx_port==12' is not redundant
  if ((tx_port == 12) || (tx_port >= 14)) {
               ^
sound/soc/codecs/wcd9335.c:1802:35: note: Assuming that condition
'tx_port>=14' is not redundant
  if ((tx_port == 12) || (tx_port >= 14)) {
                                  ^
sound/soc/codecs/wcd9335.c:1845:22: note: Condition 'tx_port==13' is
always true
  } else if (tx_port == 13) {
                     ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Chao Song <chao.song@intel.com>
---
 sound/soc/codecs/wcd9335.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index beeeb35e80321..5b4d3c5973532 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -1821,12 +1821,10 @@ static int wcd9335_set_decimator_rate(struct snd_soc_dai *dai,
 			tx_port_reg = WCD9335_CDC_IF_ROUTER_TX_MUX_CFG3;
 			shift = 0;
 			shift_val = 0x0F;
-		} else if (tx_port == 13) {
+		} else /* (tx_port == 13) */ {
 			tx_port_reg = WCD9335_CDC_IF_ROUTER_TX_MUX_CFG3;
 			shift = 4;
 			shift_val = 0x03;
-		} else {
-			return -EINVAL;
 		}
 
 		tx_mux_sel = snd_soc_component_read(comp, tx_port_reg) &
-- 
2.34.1

