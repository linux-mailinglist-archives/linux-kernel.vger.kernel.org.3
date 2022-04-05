Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966D44F3FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382459AbiDEMPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbiDEIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFB539680
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E4DB614F9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E67C385A5;
        Tue,  5 Apr 2022 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649148257;
        bh=nXHwI0lbM1sZwxBKRPdZsJoQ9VExflU+okzXpIRAZpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GnAGq0867/gnj3C+jk+gAeVtT7D2qggDRysgca1EWKYLBzHVCsuFYaknoCKr5dXE9
         9ibkXElDFItQuppVhPUyhZWD5pXecpH/oC9iBhyKNR9A6BeMJ8lRRTIUsSf5EV5EJt
         y8+mYshvmCsdx9Z43JEsZXfPd2dSerJP5jdiP/Jz7QrceE9YT1cqo7M65nSKCPyJ3T
         BLLar7OaBIlgrZH/XW7bYBdvKdVTAYhdmHY97rcqZLZVvNXuNqiMcXloi/O10zfkeU
         Zkc5RqD7w8DfoXy1tWlbFBpnZa4j3VOrSL2C5WHEcjsfTxb5GoJXN/kNYumpCiIyIt
         HYKtajren9n2Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nbenP-001IBk-Ak; Tue, 05 Apr 2022 10:44:15 +0200
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
Subject: [PATCH v2 0/2] Make headphone work on Huawei Matebook D15
Date:   Tue,  5 Apr 2022 10:44:11 +0200
Message-Id: <cover.1649147890.git.mchehab@kernel.org>
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

At Huawei Matebook D15 two different GPIOs are used to control the output:
	- gpio0 controls the speaker output;
	- gpio1 controls the headphone output.

Changing both at the same time cause spurious events that are mis-interpreted
as input events, causing troubles on apps. So, a delay is needed before turning
on such gpios.

With this patch, plugging a headphone causes a jack event to trigger the speaker
supply, powering down the speaker and powering up the headphone output.
Removing the headphone also triggers the power supply, powering up the speaker
and powering down the headphone.

Mauro Carvalho Chehab (2):
  ASoC: Intel: sof_es8336: support a separate gpio to control headphone
  ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio

 sound/soc/intel/boards/sof_es8336.c | 68 ++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 10 deletions(-)

-- 
2.35.1


