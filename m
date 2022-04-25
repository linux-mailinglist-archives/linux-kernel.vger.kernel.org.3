Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C950E4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiDYQDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243138AbiDYQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:03:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05247DEEF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E857B8185C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC4CC385A4;
        Mon, 25 Apr 2022 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650902420;
        bh=sg3XtHPLSczY3NZ40BxP/EE3YmODP2FdrdZxozyy11c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Zsw+eJFOfD/PqY8ZV5Z5rIUxhV5Eb0R1Kk4OYj3xzAxB0hoMWjdvUVHPWKska8/OG
         ZfNmYneTEbjO61WnAiGDKkS96/Et08nkWaexnVdjE/wRY6fS24uqOrRXyc8wGTUBNX
         pOiPTjS5+E/kSCrQyDba18B4ejKn0dxZFjq4l/d8Eme1A++jqLjvYav/hfj/1FBaa3
         nHHOrsMBPYM33dhRVpR+EZdoNyumyxzhmCD/mGGD3RtaagJ+o7r4ihuQE1xKONvFwE
         KQB5bPLp9qWTCLxOkrs6FtZtya9n817UxKZfUCb4Zd7mw+mpvb+GQSm94q09fX0Fzp
         2ciKp6qIFv7Jw==
From:   Mark Brown <broonie@kernel.org>
To:     codrin.ciubotariu@microchip.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     tiwai@suse.com, sha@pengutronix.de, perex@perex.cz,
        alexandre.belloni@bootlin.com
In-Reply-To: <20220421125403.2180824-1-codrin.ciubotariu@microchip.com>
References: <20220421125403.2180824-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH 1/2] Revert "ASoC: dmaengine: do not use a NULL prepare_slave_config() callback"
Message-Id: <165090241813.345430.3503254961552314811.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 17:00:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 15:54:02 +0300, Codrin Ciubotariu wrote:
> This reverts commit 9a1e13440a4f2e7566fd4c5eae6a53e6400e08a4.
> 
> As pointed out by Sascha Hauer, this patch changes:
> if (pmc->config && !pcm->config->prepare_slave_config)
>         <do nothing>
> to:
> if (pmc->config && !pcm->config->prepare_slave_config)
>         snd_dmaengine_pcm_prepare_slave_config()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] Revert "ASoC: dmaengine: do not use a NULL prepare_slave_config() callback"
      commit: 660564fc9a92a893a14f255be434f7ea0b967901
[2/2] ASoC: atmel: mchp-pdmc: set prepare_slave_config
      commit: 2bde1985e39173d8cb64005dad6f34e9bee4c750

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
