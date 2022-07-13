Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1791A5738DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiGMObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbiGMObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:31:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF6357C0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 609C1B8201A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A28C3411E;
        Wed, 13 Jul 2022 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657722659;
        bh=LfxpWWH095fjZfBkvfImn26SDsToZRyHZ9LxuKCfQLk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A+PioSTmxk1LK79ZJtaRBqYf37FGDZgHEH2JGy++bGzmRPNpw0HaTCP6DWf8YwIQC
         41yvpGUmQ4Hd55HMgJLtq+kwOL6b/3LLIxLY5KYkHcTkRiGgvPu5Q2VfbgYQ0sJCPv
         iLpx8WmohESUK4HbWDghqeTww6RFTCQu09tuIIotUWJPopHn9Sh3zJpAgqbLaNu8Dw
         1h5pnPSm6ubNSepaILbncjbsPvE/aQoyZnerA0n+tsXEZcmvOlY0XDoG+V8YVRYH/9
         6MHPz23Ci+rvkmSIjsN0Qt9+ZQMDgQPzLC+5gYWWFJ5hrx5nG90hVQieK+h2MhbXrL
         Ao+fMhahdH+sw==
From:   Mark Brown <broonie@kernel.org>
To:     rdunlap@infradead.org, linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Vijendar.Mukunda@amd.com, alsa-devel@alsa-project.org
In-Reply-To: <20220712183348.31046-1-rdunlap@infradead.org>
References: <20220712183348.31046-1-rdunlap@infradead.org>
Subject: Re: [PATCH -next] ASoC: amd: fix Jadeite kconfig warning and build errors
Message-Id: <165772265760.116109.4142483197276949409.b4-ty@kernel.org>
Date:   Wed, 13 Jul 2022 15:30:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 11:33:48 -0700, Randy Dunlap wrote:
> Since SND_SOC_ES8316 has a hard dependency on I2C and since 'select'
> does not follow any dependency chains, SND_SOC_AMD_ST_ES8336_MACH
> also needs to have a hard dependency on I2C.
> 
> Fixes a kconfig warning and subsequent build errors:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_ES8316
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
>   Selected by [y]:
>   - SND_SOC_AMD_ST_ES8336_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_ACP [=y] && ACPI [=y] && (I2C [=n] || COMPILE_TEST [=y])
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix Jadeite kconfig warning and build errors
      commit: 1795c16a436057f95fef5b622d808885dd772d0e

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
