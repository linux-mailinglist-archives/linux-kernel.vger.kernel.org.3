Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B64F6C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiDFVZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiDFVYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:24:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D52EC4ED
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9066AB8254F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F510C385A3;
        Wed,  6 Apr 2022 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649276363;
        bh=uYwQNf4aBCpGoDJHxfG+lIO94Xv7pYvgXWwzyJ3IDhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YwquvnPIe2o/tbGz7xsGoji7vymngVe+SOBBOBq3EJuiO53zpIivN72W0CAs+lRWw
         chqzfStNFbGnb/RSK+fM56Pyn3s4HqVFjXAyRnQGrS1XANG91xDBaOVNBy4NYzyoeG
         I/bqFUBN2a9dkpQuAotCiJcdU8oel7sIbkRJevAEtdpwu7slc04MUmyKv1yMi2CX2B
         bQZ+g8EvDbYjb7+PiRWuibYZpshDZ4kxN1mCDViMDlNU11k0CEwM8LZMVedEftdeoi
         jsi3IsJ9qNY7AlXdtDlKa704meIBdoGlOmA+Z3OzlORvYoia8Cyg+aL9Boz2INPvTm
         iPC2DJBMcfVWA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ncC7c-00GGaV-OQ; Wed, 06 Apr 2022 22:19:20 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     alsa-devel@alsa-project.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] ASoC: Intel: sof_es8336: Add a quirk for Huawei Matebook D15
Date:   Wed,  6 Apr 2022 22:19:18 +0200
Message-Id: <ef3d8eda90e0b3a054cd83d75b50adca0fe0e9a1.1649275618.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649275618.git.mchehab@kernel.org>
References: <cover.1649275618.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on experimental tests, Huawei Matebook D15 actually uses
both gpio0 and gpio1: the first one controls the speaker, while
the other one controls the headphone.

Also, the headset is mapped as MIC1, instead of MIC2.

So, add a quirk for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v4 0/4] at: https://lore.kernel.org/all/cover.1649275618.git.mchehab@kernel.org/

 sound/soc/intel/boards/sof_es8336.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index bc5bc6124223..e9bf516ae4c9 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -309,6 +309,15 @@ static const struct dmi_system_id sof_es8336_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK)
 	},
+	{
+		.callback = sof_es8336_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_BOARD_NAME, "BOHB-WAX9-PCB-B2"),
+		},
+		.driver_data = (void *)(SOF_ES8336_HEADPHONE_GPIO |
+					SOC_ES8336_HEADSET_MIC1)
+	},
 	{}
 };
 
-- 
2.35.1

