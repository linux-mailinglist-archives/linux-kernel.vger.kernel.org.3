Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7650E74B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbiDYR3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244097AbiDYR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF89941307;
        Mon, 25 Apr 2022 10:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B82361585;
        Mon, 25 Apr 2022 17:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68287C385A4;
        Mon, 25 Apr 2022 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907495;
        bh=+80wHVodptz//ofhkGGYWEEAicTPsSLWn5+WM/nG7v4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hG4sh8Adq815IjPH7rdRf8US4h3Qr/fh9BekQURg5sIFT5j1PUnNmtAmQ1hcPTche
         W8tzXKnhlZDoQj7LcED+fVZas8hrZORY2tafZ8QKSJ7kJVCfr9Yj1Kbm8aYsy5PVtl
         Q68P+Oa9HpGK3mUcmaph7kAGU+ANM4rFFUFP3zpTH3cgdMDZjXdjQpyNi5VWRsNgLJ
         zYTsJ39bHxbmx0bRoJseuv7+ci/2zOVLI74GnLxRQs4tAI9iwYvkIbeE6N3H9Cmb0T
         kDm3SXSzhuzM/Ztgn6rMjatmKiRjfosh2bjJP291O9WehxRP4IVl03vQt7R+vUHR9F
         qKFBDKd5cpz6w==
From:   Mark Brown <broonie@kernel.org>
To:     luca.ceresoli@bootlin.com, linux-spi@vger.kernel.org
Cc:     chris.ruehl@gtsys.com.hk, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de
In-Reply-To: <20220421213251.1077899-1-luca.ceresoli@bootlin.com>
References: <20220421213251.1077899-1-luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] spi: rockchip: fix missing error on unsupported SPI_CS_HIGH
Message-Id: <165090749413.584172.1969660470967557422.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:54 +0100
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

On Thu, 21 Apr 2022 23:32:51 +0200, Luca Ceresoli wrote:
> The hardware (except for the ROCKCHIP_SPI_VER2_TYPE2 version) does not
> support active-high native chip selects. However if such a CS is configured
> the core does not error as it normally should, because the
> 'ctlr->use_gpio_descriptors = true' line in rockchip_spi_probe() makes the
> core set SPI_CS_HIGH in ctlr->mode_bits.
> 
> In such a case the spi-rockchip driver operates normally but produces an
> active-low chip select signal without notice.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip: fix missing error on unsupported SPI_CS_HIGH
      commit: d5d933f09ac326aebad85bfb787cc786ad477711

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
