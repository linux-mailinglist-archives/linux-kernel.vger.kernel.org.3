Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00C4F516F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846283AbiDFCDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457919AbiDEQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:59:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB61D5DA4B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78B30B81E91
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008D4C385A7;
        Tue,  5 Apr 2022 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649177866;
        bh=ms+BtckZ9MEqSCkK6doSJsbJF0vV+8oKpXtP6XAZwOU=;
        h=From:To:Cc:Subject:Date:From;
        b=DID+z+a35JPU0wg3v8o+heAYAG3WEdKWMnjWMd5Ia/miFQsCgEW4juZf/3sDflrfk
         dKB3nrAMPQvQSJcb06MYXeA9ftNwL+KfSFpPgQEYU14IAkiFdEBWoq1FQkKz9YIvXF
         8YplWZ3k0ELG3Ggv1TfMAnX4qJRiWJ0gSGbkmpKJIdSoQKwZsljWvaO5fimjZK4Ksr
         B319re//ltbAenKSFo4oF02i3i85Ca1OJsmMPpW2/RIYVkSvKodqG7xl+YqTPYpZoE
         hrvQqSSOD5yL63ah7DH83U+Za/QvH3RAGFcBih3xcPrR79uAyFF5TjRdfxUNDSYS1V
         WZV29PSlQwIhQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nbmUx-002uYM-BB; Tue, 05 Apr 2022 18:57:43 +0200
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
Subject: [PATCH v3 0/3] Make headphone work on Huawei Matebook D15
Date:   Tue,  5 Apr 2022 18:57:31 +0200
Message-Id: <cover.1649177516.git.mchehab@kernel.org>
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

---

v3:
  - add a patch changing GPIO quirk speaker naming. Patch 2 got rebased on the top of it.

Mauro Carvalho Chehab (2):
  ASoC: Intel: sof_es8336: support a separate gpio to control headphone
  ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio

Pierre-Louis Bossart (1):
  ASoC: Intel: sof_es8336: simplify speaker gpio naming

 sound/soc/intel/boards/sof_es8336.c | 97 +++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 25 deletions(-)

-- 
2.35.1


