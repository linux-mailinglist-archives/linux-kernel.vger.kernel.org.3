Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA455D282
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbiF0UdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbiF0UdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4111960C2;
        Mon, 27 Jun 2022 13:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC06F61783;
        Mon, 27 Jun 2022 20:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41C8C36AE2;
        Mon, 27 Jun 2022 20:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361996;
        bh=+FrTglff8Xpnd8v7kV4JBmvdtnr4wLIdzufTsm4Cxco=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cvR7yRJSVnPbc+jqz4J6qaQMVFMs5HbzMDiinNj523Z7tyJUeDNdnvzy9eYOBBewl
         dvyhmaTAbTlY+hPr1qNamfM1lwXpoEYwQ9bicAd0suXB1WFxqDA10KW3KNI2zZijxa
         xhIPFS2qjQlLKUCJUpxHZBOU+TZk8qQaY1sMj8fvv33VdM31hhlHIDFhm9Ll9ic128
         5/TSV7uUmtnGzTl1WsAmpHvjiIKLRMTCYihog7UQT00grgEVinKdrOV7Tn6EeMRX3a
         71Cyk2LTsAv54sf7b09JmSQT4qiOBwUNZuklha3j1uKfww0dMo6xmzuvwkP9jGmmxP
         P0y8+gf2VOIWg==
From:   Mark Brown <broonie@kernel.org>
To:     fancer.lancer@gmail.com, Sergey.Semin@baikalelectronics.ru
Cc:     Alexey.Malahov@baikalelectronics.ru, linux-spi@vger.kernel.org,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Pavel.Parkhomenko@baikalelectronics.ru
In-Reply-To: <20220624210623.6383-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624210623.6383-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH RESEND v2] spi: dw: Add deferred DMA-channels setup support
Message-Id: <165636199439.4094756.16397528467156139715.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:33:14 +0100
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

On Sat, 25 Jun 2022 00:06:23 +0300, Serge Semin wrote:
> Currently if the source DMA device isn't ready to provide the channels
> capable of the SPI DMA transfers, the DW SSI controller will be registered
> with no DMA support. It isn't right since all what the driver needs to do
> is to postpone the probe procedure until the DMA device is ready. Let's
> fix that in the framework of the DWC SSI generic DMA implementation. First
> we need to use the dma_request_chan() method instead of the
> dma_request_slave_channel() function, because the later one is deprecated
> and most importantly doesn't return the failure cause but the
> NULL-pointer. Second we need to stop the DW SSI controller probe procedure
> if the -EPROBE_DEFER error is returned on the DMA initialization. The
> procedure will resume later when the channels are ready to be requested.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Add deferred DMA-channels setup support
      commit: e95a1cd2cfe722dc8434db6de33958035853aa05

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
