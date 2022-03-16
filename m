Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E64DB980
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358078AbiCPUhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357957AbiCPUhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EF6E4CE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 462476142A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC8EC340EC;
        Wed, 16 Mar 2022 20:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462956;
        bh=3SuWnJIZVPzyeK9wzgNrICuvhgZfN6hXaxO3JUmohj8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=sM9QtBrt8BDz1o/Ci7oXFIztEdY6bcnrIpfOuzIqBhn5mfWQeSTx7qWfJ3oDxQe/Z
         ulA03Vao09TzKQJf4R+scnqomTFXr5FqhFEIRxJ6Ho6FQIzgV0YKKwZOp4BjC+TAI2
         tsGbXp6nmZkDmZtWhfa8otvDq07RceJcV5IxmJ/3teDxWN5LQWnQnwFM8RtRCMrq5G
         9ZL7pDAow1eU7vSDAAxc8byw1cYsq339rTP5GcqjOF74bhV5+qZYqSlO4FrdS7YqdH
         rrDJTiNKF5WjvDUhtsbVK81yMdH2R1meY4WyPDfnhNDDOR98BNvlXSBI7K/Fc1LAEy
         4MQjLlMhGYUYA==
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Miaoqian Lin <linmq006@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220316111530.4551-1-linmq006@gmail.com>
References: <20220316111530.4551-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: atmel: Fix error handling in sam9x5_wm8731_driver_probe
Message-Id: <164746295410.1220201.13095126032756372624.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:35:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 11:15:30 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error path.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: Fix error handling in sam9x5_wm8731_driver_probe
      commit: 740dc3e846537c3743da98bf106f376023fd085c

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
