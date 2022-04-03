Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64AD4F0882
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 10:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355438AbiDCJBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 05:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbiDCJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 05:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD636326
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 01:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C0C60FED
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261E9C36AE3;
        Sun,  3 Apr 2022 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648976371;
        bh=8NKDu5zCu7H/G9k0E5Bk0gLf0mwDJcqOkFVjnVIzf/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6A3008EXzY+Ctoi7fg8HJhZuPlPKPT2rgVwf8xPIOZMkgp8xjpVi2obAI8fhwlls
         yHH77Jqfvejwt7sr0biqLKkhCQ6ydg5xIVDhjLtSBvJZ1uI4wldA7IxvI8SsL3/bk7
         Ii2RLcaES4zIBYuGQJM2TCFeDxAfjz2JQxtoizGj9i6osZSrR747yRPzPbizvJ+f2p
         1ScWo9XJPtV7hfANnNN7RujQB0XcyH6iES/92qVxCMM404Mfb+nX902OofKEYAKi6M
         GHkU6qEpl5JfixJsOC/sZYhzO5QFI/vONNbFD7+YJCGJQRHMc4LLF49Si6q2YLdfqJ
         SmuYiCMrUeftw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1naw52-00D6f8-N1; Sun, 03 Apr 2022 10:59:28 +0200
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
Subject: [PATCH RFC 2/2] ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio
Date:   Sun,  3 Apr 2022 10:59:25 +0200
Message-Id: <67d97e8a367511bc593395f33edcf2391f8066ef.1648975926.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648975926.git.mchehab@kernel.org>
References: <cover.1648975926.git.mchehab@kernel.org>
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

See [PATCH RFC 0/2] at: https://lore.kernel.org/all/cover.1648975926.git.mchehab@kernel.org/

 sound/soc/intel/boards/sof_es8336.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index 96920d3eed8a..fd47aba1bd5d 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -290,6 +290,14 @@ static const struct dmi_system_id sof_es8336_quirk_table[] = {
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

