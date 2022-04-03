Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE64F0881
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 10:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiDCJBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 05:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355323AbiDCJB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 05:01:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B816436324
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 01:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EA670CE0B75
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227A8C340F3;
        Sun,  3 Apr 2022 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648976371;
        bh=+MRl4rjdWzvUS2WdlS62P5OnEWVQOdoGiz49cpOtwgg=;
        h=From:To:Cc:Subject:Date:From;
        b=e/UxQhRf7BDgVVBto0RfrPHS5nJwc3nj5bm9X+9H/bcsRhxwHuQIfmdfMd3B9Ap84
         td9OWJ8SFL9YLEGhDfgdv9NyQe3ecY3Sz2KUplVel5FFjb1lEWIt4Efumncx8W+1bs
         OSLr7NmMWm7jAdVGUPfBmT7B9XbTURf5MB/grhSLmhd0iqzhwQBQpEqgsbnlkDJSgD
         05P1AFDMmMCn7u+T3sq09iPWikzNVjzPtd60q0a2J0G3tY9mXtZoW3URJ+ov28yMEY
         r0ClxWttx+wA5uh+PkMRY0ffCVzu7ReGo+ddZES9RkI7VP+u+Mb3EPfnz+zxunVMj1
         mhskVBBOEQ1qw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1naw52-00D6f1-GH; Sun, 03 Apr 2022 10:59:28 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] Make headphone work on Huawei Matebook D15
Date:   Sun,  3 Apr 2022 10:59:23 +0200
Message-Id: <cover.1648975926.git.mchehab@kernel.org>
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

The headphone output at Huawei Matebook D15 is controlled by a separate
GPIO than the speaker. So, the es8336 boards logic need to handle two events:
one for the speaker switch and another one for the headphone.

Please notice that this is my first real incursion at SOC/SOF. While this is working
fine, I'm still struggling with some troubles with pipewire, which I believe are
due to UCM support, as, sometimes when pavucontrol starts, the playback stucks.
Also, sometimes the mixers won't change when jack plug/unplug is detected.

So, more debug is needed, and probably the UCM will also need to be closer to
the definitions that are used at ucm2/codecs/es8316/, as es8336 is a variant of
it.

Anyway, let me submit this as as RFC, in order to get some feedback if this is
going at the right way to support the headphone switch event.

Mauro Carvalho Chehab (2):
  ASoC: Intel: sof_es8336: support a separate gpio to control headphone
  ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio

 sound/soc/intel/boards/sof_es8336.c | 84 ++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 19 deletions(-)

-- 
2.35.1


