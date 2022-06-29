Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA765605C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiF2QYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiF2QYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228323057B;
        Wed, 29 Jun 2022 09:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B189B61C3C;
        Wed, 29 Jun 2022 16:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F57C341CA;
        Wed, 29 Jun 2022 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656519846;
        bh=WuhLwVReyPIuFiHnuKnYYLH+rlvl1fOWMReZYjq2KMA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OI8Xg7Qm9dXd3I4PqyAiYwIlUZOwy/lTokjll5dxRNjUn/wcOvE+OG/l64Ia36WGu
         WUOOnr3BCdaPPggzW0noOgeAOnb9Jv6YCZWkwk3DRlTqSiAX6f5q1WqJF3eABy9vXM
         qsmLH0lwZ+8coBUg8YqhoK1dLdbtOgsdXBo/XbRoLM8yjKL2mwCH9NdsmoulXYzBgJ
         ews2ccFc96qp9YlyzTyq0Ua3775VSFnw8hZ41pVIlKhcrw+sMBB5V9GCvqOSPWQ/GQ
         wsvCSL+NmFADA5JeCTqM5o6RO8veIgJCV2dqDLTMzUfVOU8o+hxv+cQ/SfSxo2RKG7
         qtO9I2UGO+YNQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>,
        bgoswami@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        yassine.oudjana@gmail.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        y.oudjana@protonmail.com, linux-arm-msm@vger.kernel.org
In-Reply-To: <20220622061745.35399-1-y.oudjana@protonmail.com>
References: <20220622061745.35399-1-y.oudjana@protonmail.com>
Subject: Re: [PATCH] ASoC: wcd9335: Use int array instead of bitmask for TX mixers
Message-Id: <165651984367.2058781.2486729060656738913.b4-ty@kernel.org>
Date:   Wed, 29 Jun 2022 17:24:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 10:17:45 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Currently slim_tx_mixer_get reports all TX mixers as enabled when
> at least one is, due to it reading the entire tx_port_value bitmask
> without testing the specific bit corresponding to a TX port.
> Furthermore, using the same bitmask for all capture DAIs makes
> setting one mixer affect them all. To prevent this, and since
> the SLIM TX muxes effectively only connect to one of the mixers
> at a time, turn tx_port_value into an int array storing the DAI
> index each of the ports is connected to.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335: Use int array instead of bitmask for TX mixers
      commit: 4b07ef55d1d4178dbec584195be148685ea25c59

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
