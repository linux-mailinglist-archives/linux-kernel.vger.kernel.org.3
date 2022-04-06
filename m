Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432854F6C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbiDFVYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiDFVXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F572E1942
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:19:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8EBB61607
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 20:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C138C385AA;
        Wed,  6 Apr 2022 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649276363;
        bh=Lf/3oiDQxIjrJslaU4hDBu7sK/Kpd4Up096TW4VK1+8=;
        h=From:To:Cc:Subject:Date:From;
        b=pn+coB4YtR7Vx5Rgy46/4lZm6ZODHkcZrx1Y5uN2zIc5xyazhq2VDeix3XlEUu/h0
         eP2tPVdRHpCEXIrkN0eICnBUml0ibYGSstHWZVJ5gAxLGCGxrCMRxoTo4j76i+hOja
         UuMwuC16hKemHL+1S5OfGm8gv2yW0GPTz8zFM/yaOJzpSsgtpBp+GOwdD9GAoEkzv3
         ueSL40lr0cGiKUihXBB60HdrbanVqtpdcYNKYVPclW1CNaQHhXglJA9ReYn3NLbB3S
         s2gjy11N2wbmhbPoeGDnHhWpKJqq7HVbTHF51TYdhA/DDT1R9JdZxnn538RzJuu2TZ
         4H4B5hFG4BRKA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ncC7c-00GGaG-Fy; Wed, 06 Apr 2022 22:19:20 +0200
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
Subject: [PATCH v4 0/4] Make headphone work on Huawei Matebook D15
Date:   Wed,  6 Apr 2022 22:19:14 +0200
Message-Id: <cover.1649275618.git.mchehab@kernel.org>
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

 sound/soc/intel/boards/sof_es8336.c | 122 +++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 28 deletions(-)

-- 
2.35.1


