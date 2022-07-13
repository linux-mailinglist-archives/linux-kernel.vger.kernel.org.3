Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA449573899
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiGMOT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiGMOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:19:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6D1DF5C;
        Wed, 13 Jul 2022 07:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0EF561DB6;
        Wed, 13 Jul 2022 14:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A00CC341C0;
        Wed, 13 Jul 2022 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657721995;
        bh=7bISEQ5VIh3fcGJdDgqJceEHAVK2LXvUnv3EIpcVWiw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a0yFv+A+GcIpTKu1ryK8kZDTElcJICsufGf6uxtQnx+34xB/c6k62c3+cRIYCQbo7
         vdF9VVaHWi/tgy5RJRnftAmd9FuyJrRpc5eS9iMZ1QOO120a1etGxeigZZxgNhP98R
         vS2xVtTSJTnqcbDxpAZYyNB/JrNlbsz06z8t5ugz9XE2c4JfkaOGhL4w2+EshSY3iE
         2vz9d8vBTOhvkPFH81ZQkufeaNDKPCv9iKs/OfU1i/J8990BC9JqtMtAqQWv8TuK81
         SDyJirFnK0r3Xk6n+gTicwSX79pqPmd3l2HOw536my7+7TiZRklj+tkncNcxP+aPjD
         WqLmCzmfEP03A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, yangyingliang@huawei.com
Cc:     digetx@gmail.com
In-Reply-To: <20220713094024.1508869-1-yangyingliang@huawei.com>
References: <20220713094024.1508869-1-yangyingliang@huawei.com>
Subject: Re: [PATCH] spi: tegra20-slink: fix UAF in tegra_slink_remove()
Message-Id: <165772199381.105087.9602352533027638795.b4-ty@kernel.org>
Date:   Wed, 13 Jul 2022 15:19:53 +0100
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

On Wed, 13 Jul 2022 17:40:23 +0800, Yang Yingliang wrote:
> After calling spi_unregister_master(), the refcount of master will
> be decrease to 0, and it will be freed in spi_controller_release(),
> the device data also will be freed, so it will lead a UAF when using
> 'tspi'. To fix this, get the master before unregister and put it when
> finish using it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra20-slink: fix UAF in tegra_slink_remove()
      commit: 7e9984d183bb1e99e766c5c2b950ff21f7f7b6c0

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
