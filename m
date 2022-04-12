Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C504FDFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353823AbiDLMWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353955AbiDLMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:17:31 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AD38BE1F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:18:11 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23C7YTD1013409;
        Tue, 12 Apr 2022 13:17:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=dSIQyPfmboxOcHNgx6j2T/JIKfq8ga3OyOJlZJqwlsM=;
 b=6FN2LhEwrivHRHyOAOAgOIDHXlSf6VSQUrRJvEPmZpQ+FuZkn0x/p/S0bSIdvIo15ftc
 eEjb83Nd1wbdajhLYTZrcJN0JL/SDYoUBOAuHPz9qj+xkGebUcTr+sCFYaUfyrEKCj9G
 oRjUq87q4YvCqOzkd5Y+QcACc4aMN+rjLPvuS6JxggPmRVLM4BfV5dozAMc9+vYM3k/Z
 17E6VuqhxnKJ/Mob28ipdhox6lye9fczaRghVLHk32AHVyF2dGA4z/LX9MAU2eaBdr/d
 1E28mLFFX6XVVhR78W+ZDK2Ei98S1t62BFU5ObVDA6XBnVciNQ2/yp7djJnZo5uMVuS2 qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fb74q7107-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Apr 2022 13:17:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53ADA10002A;
        Tue, 12 Apr 2022 13:17:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2C76221A21B;
        Tue, 12 Apr 2022 13:17:37 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 12 Apr 2022 13:17:36
 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Robert Hancock <robert.hancock@calian.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Samuel Holland <samuel@sholland.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH] ASoC: simple-card-utils: fix sysclk shutdown
Date:   Tue, 12 Apr 2022 13:16:58 +0200
Message-ID: <20220412111658.11015-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_03,2022-04-12_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In asoc_simple_shutdown() the snd_soc_dai_set_sysclk() function
is called twice with input direction SND_SOC_CLOCK_IN.
Restore one call with output direction SND_SOC_CLOCK_OUT.

Fixes: 5ca2ab459817 ("ASoC: simple-card-utils: Add new system-clock-fixed flag")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/generic/simple-card-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index f2157944247f..da0c27828ce6 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -322,7 +322,7 @@ void asoc_simple_shutdown(struct snd_pcm_substream *substream)
 
 		if (props->mclk_fs && !dai->clk_fixed && !snd_soc_dai_active(cpu_dai))
 			snd_soc_dai_set_sysclk(cpu_dai,
-					       0, 0, SND_SOC_CLOCK_IN);
+					       0, 0, SND_SOC_CLOCK_OUT);
 
 		asoc_simple_clk_disable(dai);
 	}
-- 
2.17.1

