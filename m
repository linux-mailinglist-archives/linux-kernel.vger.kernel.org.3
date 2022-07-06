Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A2C56850D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiGFKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiGFKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:17:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254731AF3E;
        Wed,  6 Jul 2022 03:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4304B81BBD;
        Wed,  6 Jul 2022 10:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A02FC3411C;
        Wed,  6 Jul 2022 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657102625;
        bh=XVdbRrOp8xLesuL5V+XzvyMnqCaufOFVig9zQuXgRQY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MMlQ+fWvP3JUGhLnjIw6+jbnUaJIQZy5aXlLxlLwdGlx7LGIrIJ/UCzdO610lIwV0
         DgbeVbiP0un/T9p59vebdHE943xTi9/sEZmhekVZzmIIZzQKVPLumMtjDYw/zGUP17
         I/5wryk2awc3HeO2mqmIsljW9Sak2cJRzeJ+w5YG2zk+Vdk8yNJPDHA39/XbZDVmhz
         NuQx+t6jY9l2c6IGeNtNho9GJRXGn+T3zpLDTEbIffTnkPWEh9u1bSvf7K22s2Bx2d
         XZukslogWRSrfhsMHbHyMIU1Eaoyq22kbloOFSOCqWaLktQ+xu8dF+tZ2YQIiEZ/AW
         YxVt5p9o2FxwQ==
From:   Mark Brown <broonie@kernel.org>
To:     aidanmacdonald.0x0@gmail.com
Cc:     rafael@kernel.org, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220704112847.23844-1-aidanmacdonald.0x0@gmail.com>
References: <20220704112847.23844-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH] regmap-irq: Fix bug in regmap_irq_get_irq_reg_linear()
Message-Id: <165710262393.218789.1320369501599674730.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 11:17:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 12:28:47 +0100, Aidan MacDonald wrote:
> irq_reg_stride in struct regmap_irq_chip is often 0, but that
> actually means to use the default stride of 1. The effective
> stride is stored in struct regmap_irq_chip_data->irq_reg_stride
> and will get the corrected default value.
> 
> The default ->get_irq_reg() callback was using the stride from
> the chip definition, which is wrong; fix it to use the effective
> stride from the chip data instead.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Fix bug in regmap_irq_get_irq_reg_linear()
      commit: 773d09b4c3acafd35f8b6e90848a39cedc03c52b

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
