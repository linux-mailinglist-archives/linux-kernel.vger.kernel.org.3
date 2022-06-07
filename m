Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8053FC0F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241864AbiFGKtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241858AbiFGKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FBBF33A2;
        Tue,  7 Jun 2022 03:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74DE961548;
        Tue,  7 Jun 2022 10:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF2EC36B09;
        Tue,  7 Jun 2022 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598800;
        bh=YREEwWrp6e3nyVf/yYzkKPpOi0m8pZQUreKe1nSLxp8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Pn/B68XuAYFXzVB4pO5GQNbLn7+KTv3tRX+nkg2Pd5Pn96kMDmy1KaGVGwgfODwgO
         PXh23Jh2r6/NbBfZnHedZRuPqTdG48No874CMuNEMgll33yierYLHWDJRaXkvM7ekN
         NMH3kuIJ3EKRA0OYo/5urTII/7nwcRIH0JS3T3BzI8NqP7b7Xhf5uUb786LK0Z5BZ4
         jkqO97f0OUiaY2PDEb0YzgiYoa1Uex6pd3FLvhia9iYwiwA+60MzFp9jezIJa82mpH
         g40HTAsTGxXB/exNOMg4DEEy4n46QxthVpbB1VWaX4qyGgAmLPqc/erT/nh5pAOKG5
         Vr3R3I7obGdFA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, adithya.kv@samsung.com,
        linux-spi@vger.kernel.org
Cc:     alim.akhtar@samsung.com, linux-kernel@vger.kernel.org,
        andi@etezian.org, krzysztof.kozlowski@linaro.org,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com
In-Reply-To: <20220524140132.59300-1-adithya.kv@samsung.com>
References: <CGME20220524140211epcas5p1b9b61a0ea112beb2327848c37d3ba000@epcas5p1.samsung.com> <20220524140132.59300-1-adithya.kv@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: requests spi-dma channel only during data transfer
Message-Id: <165459879876.302078.13109616236074671922.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:38 +0100
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

On Tue, 24 May 2022 19:31:32 +0530, Adithya K V wrote:
> Current s3c64xx SPI driver acquires DMA channel during driver
> probe and holds on it even when channels are not used
> (no DMA transfer). This is a problem especially when all the
> DMA channels are exhausted (as other IPs on the same DMA
> controller also acquires DMA channel) and if a new IP/Device
> requests for a DMA channel (on the same DMA controller), it won’t
> get DMA channel allocated.
> The said issue can be avoided if s3c64xx driver request and
> release DMA channel before and after data transfer. Let’s modify
> the driver to request and release DMA channel before and after
> DMA mode data transfer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: requests spi-dma channel only during data transfer
      commit: f52b03c707444c5a3d1a0b9c5724f93ddc3c588e

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
