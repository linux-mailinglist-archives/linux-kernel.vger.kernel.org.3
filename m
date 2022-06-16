Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3174354E02E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376909AbiFPLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376898AbiFPLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1881E165A8;
        Thu, 16 Jun 2022 04:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8105619E6;
        Thu, 16 Jun 2022 11:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EACC34114;
        Thu, 16 Jun 2022 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655379769;
        bh=Q132C26WTc5ClYHcIA2UoeqKRa/NHeLBCM471XhFPec=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FnR2r1UJqwxQXcdxUb8MVwDT8BxaySA5P+5tE109aZ3c0iVyIKy3xPYFR2JvHsMtk
         hhrS/dXJ6YNKhFceFnEctzUY999h31ZXajyU/BpI4MH8kRpLWGxIE83PrwAs1ND0qd
         wiM0l7eNWTeJtmXs0zlSuR4l84D3T8d7vxq3KR/5GVJWRltPNvdYnRuzBXl+wgnf9m
         iRz5NgUvNT94PX6/vq+L9puZNGFwYG/wMfDugLjC2vrVShg3Gsol9Ulw91ocrV2agQ
         Y8WFx/c78wOTx7O04fGW5c3ApIU/leWXHDqz6HiqncAwzCAFm+98gxBuR+2FRh7OGU
         P6on9EHTqXcEw==
From:   Mark Brown <broonie@kernel.org>
To:     conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        dan.carpenter@oracle.com, daire.mcnamara@microchip.com,
        lewis.hanly@microchip.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220615142028.2991915-1-conor.dooley@microchip.com>
References: <20220615142028.2991915-1-conor.dooley@microchip.com>
Subject: Re: [PATCH v2] spi: microchip-core: fix passing zero to PTR_ERR warning
Message-Id: <165537976740.874420.15190272235131912340.b4-ty@kernel.org>
Date:   Thu, 16 Jun 2022 12:42:47 +0100
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

On Wed, 15 Jun 2022 15:20:29 +0100, Conor Dooley wrote:
> It is possible that the error case for devm_clk_get() returns NULL,
> in which case zero will be passed to PTR_ERR() as shown by the Smatch
> static checker warning:
> drivers/spi/spi-microchip-core.c:557 mchp_corespi_probe()
> warn: passing zero to 'PTR_ERR'
> 
> Remove the NULL check and carry on with a dummy clock in case of an
> error. To avoid a potential div zero, abort calculating clkgen if
> clk_get_rate(spi->clk) is zero.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core: fix passing zero to PTR_ERR warning
      commit: 2081ad1467469b649fc9f9226b235977a7bf9402

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
