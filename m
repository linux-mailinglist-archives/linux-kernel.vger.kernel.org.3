Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA3D4F7BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiDGJk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbiDGJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8427A1B3F5A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E66FDB826EC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1C8C385A8;
        Thu,  7 Apr 2022 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324307;
        bh=q6HaN3d0Wc4BX8ScAWKhh8emcIaugeEwIsXTjJpawCQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jDs25bbn3/0QsT4YpXsLyKfbVWolN6z7t2NW5wae9Xx7AbvyoCskY4Gki2pAChFJh
         fxrPJTgP2NS2nU1lm9L+pHXj39Qf4lOZ9N7ohio9BBUbZpE7fInyEkJGOGbp/7L88v
         F9dRCwftYPgfY5XFZGfNOLUaV0ZJ9ACI1+3s6uTvEqnt3ld5/xMbmhvbRIuyVH+vnC
         ocUdo9UYJztl6mtBhYhhLtxSgNiKRjC+JSpDz/i8AalrcdBH2Nge4JvGcZqzeZzRUt
         3CVTb/XNaOEUrj1OHBDXgYaxVyw/ZiWzIP3bOsTvqJookhEHQwYE9bJictLCSj2Heg
         VN2Be9RiddtWg==
From:   Mark Brown <broonie@kernel.org>
To:     viorel.suman@nxp.com, shengjiu.wang@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com,
        Sascha Hauer <s.hauer@pengutronix.de>, a.fatoum@pengutronix.de,
        Xiubo.Lee@gmail.com, festevam@gmail.com
Cc:     kernel@pengutronix.de, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220405155731.745413-1-a.fatoum@pengutronix.de>
References: <20220405155731.745413-1-a.fatoum@pengutronix.de>
Subject: Re: [PATCH] ASoC: fsl_sai: fix 1:1 bclk:mclk ratio support
Message-Id: <164932430460.3844153.13561902931852849107.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tue, 5 Apr 2022 17:57:31 +0200, Ahmad Fatoum wrote:
> Refactoring in commit a50b7926d015 ("ASoC: fsl_sai: implement 1:1
> bclk:mclk ratio support") led to the bypass never happening
> as (ratio = 1) was caught in the existing if (ratio & 1) continue;
> check. The correct check sequence instead is:
> 
>  - skip all ratios lower than one and higher than 512
>  - skip all odd ratios except for 1:1
>  - skip 1:1 ratio if and only if !support_1_1_ratio
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: fix 1:1 bclk:mclk ratio support
      commit: d00887c106dac47b9af6ed70e8d5c45b69c4bd52

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
