Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13664B53D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355429AbiBNO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:56:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355435AbiBNO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:56:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8630C48E7C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:56:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34593B810D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD81DC340EE;
        Mon, 14 Feb 2022 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644850560;
        bh=y+Rr2b5WM7F6auE0BW2a+3Ab1MYhu1zzwg5gCTdAqH0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=uhVfjJh+bKD8Lhh2LM5ApUe0IXmjlp2loNhS8irmzKR2weyQXsE+dbzbo3VnG/S31
         uIGqxIEaSH4aAHJser2DJiBJZ/+WRMPO59ccn1JA8wyq+rI+1HXlgadEgSndi/geL8
         jcFxWXuWgn6bcnO3MxbFM10FGfClt09QMcv9/WPDMXHQvVDkaht6MfvAendi8dea3b
         iQVRHh7kX1CWME38u+S+KdypK0ym3loxfKQQax6zISrSWdHQdLxamtZOa02HZZZV4Z
         rW2/iYPMCVI38hIfOX0WHyxXZdr97+v3ZdkOS1HkPCOpVhtBcEOlvnIyZJTwBgCFsv
         25yxmJIwwJEWQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shengjiu Wang <shengjiu.wang@freescale.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        patches@opensource.cirrus.com,
        "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
In-Reply-To: <20220208121727.4461-1-viorel.suman@oss.nxp.com>
References: <20220208121727.4461-1-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH] ASoC: codec: wm8960: complete discharge on BIAS OFF->STANDBY
Message-Id: <164485055842.397940.7117468372476499848.b4-ty@kernel.org>
Date:   Mon, 14 Feb 2022 14:55:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 14:17:27 +0200, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> On BIAS STANDBY->OFF transition the current implementation sleeps
> 600ms on suspend in order to discharge the chip. The suspend is
> propagated from "snd_soc_suspend" call for all audio cards in a
> serial fashion, thus in case of boards like i.MX8DXL EVK which has
> 3 distinct WM8960 codecs the total cumulated sleep on suspend is 1.8
> seconds.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: wm8960: complete discharge on BIAS OFF->STANDBY
      commit: 3c7a4c24bd0ac2dfeb4f3f9053a2207cad90c7dd

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
