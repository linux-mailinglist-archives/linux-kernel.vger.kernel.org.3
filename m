Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFDC525296
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356487AbiELQcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352659AbiELQcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8765D63393;
        Thu, 12 May 2022 09:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19C0061FDA;
        Thu, 12 May 2022 16:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CD2C385B8;
        Thu, 12 May 2022 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652373120;
        bh=VGcrNcu5gEaD9NOE27MHl/Wr7tluunIA7FvG7tXRfBo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NDu0ye6cxUW/ueCuDl6gfECptIn83HktVDKdLsm7vPHHBaJ0HexH7j1/JLdHBiQOJ
         ItrnjUClt0430jfBr5nvEOe3KvCM0lNatIKSA6jluRL5teYwooYm5ufJwsQhhUIXPR
         5Ofa0z6oTz6WEBk4JPilGcVjEdugbCkMhbIWUqdhHVMcrTPiQh8iss76niZwJX9Yba
         pAcXkxgGoPGUgB1o5CaL2fzyYPEFqrKkIf++LFi1CU4f9m7PwJzte1BhaBLSZh+ue/
         p3byRZEwg3npTX6d36+l1wn+8aYUKC44c7TMTHB/6JcCV+i9RIKtV8wgq+6QQV16IB
         Ebv/04N2aE1WQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, vaishnav.a@ti.com,
        linux-kernel@vger.kernel.org
Cc:     vigneshr@ti.com, j-keerthy@ti.com, p.yadav@ti.com
In-Reply-To: <20220511115516.14894-1-vaishnav.a@ti.com>
References: <20220511115516.14894-1-vaishnav.a@ti.com>
Subject: Re: [PATCH] drivers: spi: cadence-quadspi: Handle spi_unregister_master() in remove()
Message-Id: <165237311899.1053498.14444513819547781414.b4-ty@kernel.org>
Date:   Thu, 12 May 2022 17:31:58 +0100
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

On Wed, 11 May 2022 17:25:16 +0530, Vaishnav Achath wrote:
> Currently devres managed removal of the spi_controller happens after
> removing the power domain of the host platform_device.While this
> does not affect the clean removal of the controller, but affects
> graceful removal of the child devices if the child  device removal
> requires issuing commands over SPI.
> 
> Eg. flash device being soft reset to 1S-1S-1S mode before removal
> so that on next probe operations in 1S-1S-1S mode is successful.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers: spi: cadence-quadspi: Handle spi_unregister_master() in remove()
      commit: 606e5d408184989f53028125e0cb5aa6713362d5

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
