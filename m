Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B524F3B64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353615AbiDELzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbiDEIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A133BBCD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9172461509
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D46C385A7;
        Tue,  5 Apr 2022 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649148258;
        bh=nRMo+z2lBnIeY2gWA47akGjKJTExBImxtqaJZH6LZRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovHq+AmOb8oZDAWUl+4rgcc4gCndwuQhRTKEqQVdjzw5XyCv0rAVlwZ53MA5rtR6K
         QBD754frewQOGxu4lI7foMOe0xE19P7cJmEtaxetu2jZ56bYJxRe0SHOvpO7cVxsP3
         8XdcpSOIuEEgQMTXfQu9oMzAsCnwfKeRNCVckSntstTibsr1/O0WzK4SYvdEo04tvo
         k1DMtCn9f+Ia67PGwyBXbs38aGaX9aNg6LYqANyK9JCLkdBIRen3qPrpjFA1gJIrM0
         4dEvT2xbyZbhplrWROhEVpJ5bgyhzbROfjxDffvo3QowqRMwRSvq1RXMWh/OuJpijP
         qpoGZh/q2dA0g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nbenP-001IBq-EM; Tue, 05 Apr 2022 10:44:15 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 2/2] ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio
Date:   Tue,  5 Apr 2022 10:44:13 +0200
Message-Id: <01ca33a28b8f7ef084bfa1317ada0cca1b0589f6.1649147890.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649147890.git.mchehab@kernel.org>
References: <cover.1649147890.git.mchehab@kernel.org>
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Based on experimental tests, Huawei Matebook D15 actually uses
both gpio0 and gpio1: the first one controls the speaker, while
the other one controls the headphone.

Add a quirk for that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 0/2] at: https://lore.kernel.org/all/cover.1649147890.git.mchehab@kernel.org/

 sound/soc/intel/boards/sof_es8336.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index bcd80870d252..79cf9777c4fc 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -292,6 +292,14 @@ static const struct dmi_system_id sof_es8336_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOF_ES8336_TGL_GPIO_QUIRK)
 	},
+	{
+		.callback = sof_es8336_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_BOARD_NAME, "BOHB-WAX9-PCB-B2"),
+		},
+		.driver_data = (void *)(SOF_ES8336_HEADPHONE_GPIO)
+	},
 	{}
 };
 
-- 
2.35.1

