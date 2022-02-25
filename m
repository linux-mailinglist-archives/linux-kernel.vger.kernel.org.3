Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2DC4C429E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiBYKkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiBYKkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:40:42 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C180968F8F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645785610; x=1677321610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Lh99pIe6P2Nw6W6x79cUpkUeEAEuCSeab91A4DY0/c0=;
  b=LK3K1Xd3W/iWU5Zkp0w3GuHPd3o8wjpVgQyD9vuBNCxyXhTcXKt6oorP
   tCdWF/j8Nakoic/30ywREy3IxwNFBButvxKaKlhDtkECCNIyrWnq4Ae0n
   uYkIgpK67hvQnTb57ByR1++pyaAIHJJcXbw6XC7zkrfRUPLb1oZjEvBDL
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Feb 2022 02:40:10 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 02:40:10 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 02:40:06 -0800
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        ierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>,
        <alsa-devel@alsa-project.org>, Zubin Mithra <zsm@chromium.org>,
        <linux-kernel@vger.kernel.org>
CC:     Krishna Jha <quic_kkishorj@quicinc.com>
Subject: [PATCH V0 1/1] ALSA: pcm: fix blocking while loop in snd_pcm_update_hw_ptr0()
Date:   Fri, 25 Feb 2022 16:09:32 +0530
Message-ID: <4d8b1cb4b0db88c3e28207a81403fbf1e4a87bff.1645784757.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1645784757.git.quic_rbankapu@quicinc.com>
References: <cover.1645784757.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When period interrupts are disabled, while loop in snd_pcm_update_hw_ptr0()
results in the machine locking up if runtime->hw_ptr_buffer_jiffies is 0.
Validate runtime->hw_ptr_buffer_jiffies value before while loop to avoid
delta check.

Signed-off-by: Raghu Bankapur <quic_rbankapu@quicinc.com>
---
 sound/core/pcm_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index f2090025236b..bb9097f658be 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -352,7 +352,8 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 		 * the elapsed time to detect xruns.
 		 */
 		jdelta = curr_jiffies - runtime->hw_ptr_jiffies;
-		if (jdelta < runtime->hw_ptr_buffer_jiffies / 2)
+		if ((jdelta < runtime->hw_ptr_buffer_jiffies / 2) ||
+			(runtime->hw_ptr_buffer_jiffies <= 0))
 			goto no_delta_check;
 		hdelta = jdelta - delta * HZ / runtime->rate;
 		xrun_threshold = runtime->hw_ptr_buffer_jiffies / 2 + 1;
-- 
2.17.1

