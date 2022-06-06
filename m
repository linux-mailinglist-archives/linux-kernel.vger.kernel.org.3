Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE653E632
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbiFFQNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbiFFQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:13:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A941248EF;
        Mon,  6 Jun 2022 09:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBF4B60C97;
        Mon,  6 Jun 2022 16:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F920C34115;
        Mon,  6 Jun 2022 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532017;
        bh=MueADA+CiyJmz39HZzbLm60F2gZNMbcgAKZql4mZf7c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QAI1RHiScg3qpm4z3/qK7ESW37gHCGbfX3wSJ/EQqdzK5dSmxbKNk4JCNAFEjb3Ba
         WoUMsGX5I01tKA+gsmVz9Rb/qkNRW2Lc+WEhoDjV7w066igtO3S7qlEi4Qddiujiol
         mq44PevNwvgnkRDrYyS6SmLtAO+RpalCp+gkZuow10XHakf8OHu1ms82BEPpQHJVOH
         CDHIaECYmDjRbfT9ZUwotD/0y+EOUwhl2C8cHAgCR3u6jaRISGeNctuUaYqF7kiIL6
         RYdT7gFRQbqf5NhaK8KkzWyBgtdPkrRv0y7KH6MN0uzUiWkbF54ILN6jF6rp8jeSp2
         PLKFacvXp1v8A==
From:   Mark Brown <broonie@kernel.org>
To:     amit.kumar-mahapatra@xilinx.com
Cc:     linux-spi@vger.kernel.org, git@xilinx.com,
        lakshmi.sai.krishna.potthuri@xilinx.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606062525.18447-1-amit.kumar-mahapatra@xilinx.com>
References: <20220606062525.18447-1-amit.kumar-mahapatra@xilinx.com>
Subject: Re: [PATCH] spi: spi-cadence: Fix SPI CS gets toggling sporadically
Message-Id: <165453201583.2010189.2681411517456165829.b4-ty@kernel.org>
Date:   Mon, 06 Jun 2022 17:13:35 +0100
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

On Mon, 6 Jun 2022 11:55:25 +0530, Amit Kumar Mahapatra wrote:
> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> 
> As part of unprepare_transfer_hardware, SPI controller will be disabled
> which will indirectly deassert the CS line. This will create a problem
> in some of the devices where message will be transferred with
> cs_change flag set(CS should not be deasserted).
> As per SPI controller implementation, if SPI controller is disabled then
> all output enables are inactive and all pins are set to input mode which
> means CS will go to default state high(deassert). This leads to an issue
> when core explicitly ask not to deassert the CS (cs_change = 1). This
> patch fix the above issue by checking the Slave select status bits from
> configuration register before disabling the SPI.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: Fix SPI CS gets toggling sporadically
      commit: 21b511ddee09a78909035ec47a6a594349fe3296

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
