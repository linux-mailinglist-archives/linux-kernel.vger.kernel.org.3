Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA64F4F93E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiDHL02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiDHL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:26:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12862E0AD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EAF0B82A16
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB0AC385A3;
        Fri,  8 Apr 2022 11:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649417057;
        bh=lWoMPg39uyTP/hr0yF/yCGHxTt9syuOEe++UUP9kO2Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l92riz3AuGpmwoYbqUhTX6nRH1rXoz0p/H708Lsgm0Cl1Ie5BO1AJtuVGAQ+2eYsx
         LPRxdLnnEOtvFdBlxGDzNx55rgv2bbm4oeL/zlnmnuHCC2xIe9r7eR8GMnl//RyEDu
         cb3Lrhw9AuKlr24uy2t1up8pC32MqC3QUR2ehWGJjA7tcNpXv3p9kjKcZOalmns6NR
         Wo9sZp+DHUqlg4OMU/zU0myu/gVdqqvnExYwtOS6f4JC3bz7doBvDFCsTY29iltYrq
         fd2qPvheOXW13ACGhRG6PqX4/E15QCCVQf9EVMQg8RXaPcWT36dB10xmmP2db6mu+3
         24oAKPbvDnAdw==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, zheyuma97@gmail.com, tiwai@suse.com,
        lgirdwood@gmail.com
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220405121038.4094051-1-zheyuma97@gmail.com>
References: <20220405121038.4094051-1-zheyuma97@gmail.com>
Subject: Re: [PATCH] ASoC: wm8731: Disable the regulator when probing fails
Message-Id: <164941705528.1295287.5270437045199279011.b4-ty@kernel.org>
Date:   Fri, 08 Apr 2022 12:24:15 +0100
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

On Tue, 5 Apr 2022 20:10:38 +0800, Zheyu Ma wrote:
> When the driver fails during probing, the driver should disable the
> regulator, not just handle it in wm8731_hw_init().
> 
> The following log reveals it:
> 
> [   17.812483] WARNING: CPU: 1 PID: 364 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> [   17.815958] RIP: 0010:_regulator_put+0x3ec/0x4e0
> [   17.824467] Call Trace:
> [   17.824774]  <TASK>
> [   17.825040]  regulator_bulk_free+0x82/0xe0
> [   17.825514]  devres_release_group+0x319/0x3d0
> [   17.825882]  i2c_device_probe+0x766/0x940
> [   17.829198]  i2c_register_driver+0xb5/0x130
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8731: Disable the regulator when probing fails
      commit: 92ccbf17eeacf510cf1eed9c252d9332ca24f02d

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
