Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE6854CA63
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348783AbiFONys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345559AbiFONyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E95AE46;
        Wed, 15 Jun 2022 06:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 319A761B23;
        Wed, 15 Jun 2022 13:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF57FC3411B;
        Wed, 15 Jun 2022 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655301278;
        bh=ekP0QNj5q0wLAX06GcBg0CJvxlJ3QpBhVkxB3X4207k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G1p69ZqU5KSno9XBwtkKDa3gaYtxzLf3SdqOfaLvjVFKW7NNno3JKa8DQcBGa7JK6
         suJpslhmltYavZsPZ9EPCsftE8+daMIgpIDEckeobs8jF1Pz55Qck7A7JtQiKwiiR0
         iKPZDYbxWlIB0QQtbirPdw9DW3kzDP2gUbLNro5mbR6Y/TgQfEdoAiN35EsW/QfoVL
         /cnmpOjnKo8ppFazHzCKV1xMnymZQmkSIPImwC5sGv9AWe9kJNsDYcx7DIoYihUcBf
         Pk1u06qUyB0pJOAYHt74blA37SXt1Z8ukCCWltImrpHxyhdwBxs5Z+GZ5N3uf7KGqt
         VHeDV1KlY/Kdw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, ckeepax@opensource.cirrus.com, tiwai@suse.com,
        perex@perex.cz, spujar@nvidia.com
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com
In-Reply-To: <1655280277-4701-1-git-send-email-spujar@nvidia.com>
References: <1655280277-4701-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH] ASoC: tegra: Fix clock DAI format on Tegra210
Message-Id: <165530127643.947339.2607790181344123264.b4-ty@kernel.org>
Date:   Wed, 15 Jun 2022 14:54:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 13:34:37 +0530, Sameer Pujar wrote:
> I2S reset failures are seen on Tegra210 and later platforms. This indicates
> absence of I2S bit clock, which is required to perform the reset operation.
> Following failures are seen with I2S based tests on Tegra210 and later:
> 
>   tegra210-i2s 2901100.i2s: timeout: failed to reset I2S for playback
>   tegra210-i2s 2901100.i2s: ASoC: PRE_PMU: I2S2 RX event failed: -110
>   tegra210-i2s 2901100.i2s: timeout: failed to reset I2S for capture
>   tegra210-i2s 2901100.i2s: ASoC: PRE_PMU: I2S2 TX event failed: -110
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Fix clock DAI format on Tegra210
      commit: 5983a8a4a4dc13b5f192212a5e744eb303cd65c2

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
