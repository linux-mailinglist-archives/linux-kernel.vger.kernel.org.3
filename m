Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BCD4F8759
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346978AbiDGSwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiDGSwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:52:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2934F1070AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5E59B8260F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84832C385A0;
        Thu,  7 Apr 2022 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649357402;
        bh=TAbTE0lF5EexKN7OT4x7M57eBGM9nfMRRu7XhDuXa7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=CY7Npgnd7FKGA3gbSEsqEtlyjwFcX4266dB0hKhe/xIimNF74mFoc1p5+ioGavU+o
         vNaGZ0+J5rsL+UnPXnZ4CMQsTjXTh0KRemNqxmafuX+fwVBdTMYd3GPO797hau7Jlo
         ZpKxsGinzrqtF/r4e1scLFiBjlA3puYz6RPWVE6sP0Qd9GcCFxCRO7UtYX6H3Rr91O
         nkxRQ/IFvWTBFVyBUQ3i1885FEOvlkkbxi/adnepTeCIQXQp1LWAfbSBMqztipnY3W
         IBO97sIZ1PlYuyF3wqwALgN6cNUkH85cv03E+ZdBmmGWzK1PMMPWUCEoJgDDlPncBh
         zkHpwyIlxTAZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ncXCi-000Rug-4j; Thu, 07 Apr 2022 20:50:00 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     alsa-devel@alsa-project.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Make headphone work on Huawei Matebook D15
Date:   Thu,  7 Apr 2022 20:49:55 +0200
Message-Id: <cover.1649357263.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Huawei Matebook D15 uses two different GPIOs are used to control the output:

	- gpio0 controls the speaker output;
	- gpio1 controls the headphone output.

Changing both at the same time cause spurious events that are mis-interpreted
as input events, causing troubles on apps. So, a delay is needed before turning
on such gpios.

Also, the headset microphone is connected to MIC1, instead of MIC2 port.

With this patch, plugging a headphone causes a jack event to trigger the speaker
supply, powering down the speaker and powering up the headphone output.
Removing the headphone also triggers the power supply, powering up the speaker
and powering down the headphone.

The headset microphone also works. 

---

v5:
  - dropped an uneeded differential mux from the boards driver.

v4:
  - add support for headset microphone on MIC1 port.

v3:
  - add a patch changing GPIO quirk speaker naming. Patch 2 got rebased on the top of it.

Mauro Carvalho Chehab (3):
  ASoC: Intel: sof_es8336: support a separate gpio to control headphone
  ASoC: Intel: sof_es8336: add a quirk for headset at mic1 port
  ASoC: Intel: sof_es8336: Add a quirk for Huawei Matebook D15

Pierre-Louis Bossart (1):
  ASoC: Intel: sof_es8336: simplify speaker gpio naming

 sound/soc/intel/boards/sof_es8336.c | 117 +++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 28 deletions(-)

-- 
2.35.1


