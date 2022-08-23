Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E3059EB31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiHWShr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiHWShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1BD113693;
        Tue, 23 Aug 2022 10:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8184C60FDE;
        Tue, 23 Aug 2022 17:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADB0C433C1;
        Tue, 23 Aug 2022 17:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661274018;
        bh=8XJRkjJBSt9PFqdic69tPPBqRtVjZZnOH7jdPBoSQvM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iJinRQzIFKEw4AyefuwgSmSIn9LpaKkjZbx6hw7P5A0mjF6y3SdNEzWA2IoMDZLbS
         yO1expq7AgjyKl5VAJcdvUuBDls7IdFNXSMfN64aX+vCBS2vXEv9JYrHp4yMgBtL6b
         VZuUukkqmCLzr/FNLAXPyLwNGJKvGMmHf4iyzKqG2AT8dHL6j8EGutvlmALryqTzUc
         oaAoI99xbJrrhvSzWlt+0boBcOZgQaOaAgRimeD0gee2IRteSd8iOE2i8iLSWu894M
         3A/LFdWnbCHQNGmVclBRG3LArqaSoRkRKakxbRIEFCRkIIRN4z+8+9Sytz0JbRHSSW
         +Q7wam88LdZKw==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
In-Reply-To: <20220822181853.23063-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822181853.23063-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] spi: dw: Add deferred controller registration support
Message-Id: <166127401557.469144.1274592925850885799.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 18:00:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 21:18:53 +0300, Serge Semin wrote:
> It's pretty possible to have the spi_register_controller() method
> returning -EPROBE_DEFER status in case, for instance, if the GPIOs used
> for the CS implementation aren't ready to be requested due to the
> corresponding platform devices still pending to be probed. Let's make sure
> the DW SSI driver won't print error message in that case by calling the
> dev_err_probe() function if the SPI-registration procedure exited with
> a non-zero status.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Add deferred controller registration support
      commit: 52c135d495ca019abbacf063f5ef43bd5b189070

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
