Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398AB552156
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbiFTPkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiFTPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1811903C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B672361447
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8100C3411B;
        Mon, 20 Jun 2022 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655739605;
        bh=IfpTbZcrYLCExUtg/dND25Q4OR9cRe4Q9s5GvT76wp0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lX7uQ2rvaPOkNMStXI6+HbWrHlgcx27iDcjnTiTjBIjnM0HasK5aotOtbaFOOWM11
         RCVeIhbef1y2siIVb72DvtbPEcyY2PVcE79tub0zsVp0rjS7PmTeGvyI+KF1qsS/HL
         bk34Va7iPk34Mm+3ZPW286JfdzryX7Zn5zF6ITnJ55k7jBhIHDscz7HQgU30+CbdKV
         Hq0OBiKDi35QKwu5KqHuiEP3ib5HK3o5LRVcbdkraB+FXdQ6tQGtHd81JZDN8qy1Gk
         Kmvdk1EYHWqmzSNalc2kY/DSAh+dvkUqrU5CExZhmm5LwHvlYpv7q+OdO0+36iiGdB
         LHl6O8DVCp1Tg==
From:   Mark Brown <broonie@kernel.org>
To:     javierm@redhat.com, linux-kernel@vger.kernel.org
Cc:     marex@denx.de, rafael@kernel.org, gregkh@linuxfoundation.org
In-Reply-To: <20220616073435.1988219-1-javierm@redhat.com>
References: <20220616073435.1988219-1-javierm@redhat.com>
Subject: Re: [PATCH 0/3] remap: Some fixes for bulk read/write callbacks in regmap_config support
Message-Id: <165573960454.716174.18343851467533184828.b4-ty@kernel.org>
Date:   Mon, 20 Jun 2022 16:40:04 +0100
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

On Thu, 16 Jun 2022 09:34:32 +0200, Javier Martinez Canillas wrote:
> This series contains fixes for a few issues found while testing the recent
> support for drivers to define bulk read/write callbacks in regmap_config.
> 
> I tested this with drivers/gpu/drm/solomon/ssd130x-spi.c, by converting it
> to use this new API instead of defining its own regmap bus for bulk write.
> 
> Patch #1 and patch #2 are fixes for regresions introduced by that commit
> and patch #3 adds regmap_config provided bulk write support to functions
> regmap_noinc_write() and regmap_bulk_write(), that were missed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] regmap: Re-introduce bulk read support check in regmap_bulk_read()
      commit: 5ac01e023a1b0492e159ad2f6734e0a350c1b6b6
[2/3] regmap: Make regmap_noinc_read() return -ENOTSUPP if map->read isn't set
      commit: f6e5c3850d1174bf3ca53457d64e6665f48c9041
[3/3] regmap: Wire up regmap_config provided bulk write in missed functions
      commit: 1db43c8ad90ce07311a3ef9af7ace758d79224f9

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
