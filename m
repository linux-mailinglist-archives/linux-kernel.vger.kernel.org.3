Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E97749CEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbiAZPg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbiAZPg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:36:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C71C06173B;
        Wed, 26 Jan 2022 07:36:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5532CB81ECB;
        Wed, 26 Jan 2022 15:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D3EC340EB;
        Wed, 26 Jan 2022 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211414;
        bh=wWo760c3ezeEk09F3+obtM0z7sicJxM+6AeAwTTQAAE=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Gl6FticAcyYgFSFBneq5eeEQEUJs3teNa8q8gz8tpexA77dZRw9TItqPGenVMzSkZ
         LR4d3lj44bOsdLKIWYjAp16hM98kk47gYa9RG9LEQt332oJf3kpCFur0nb1aum+pt3
         fCRG+AlQEKW/CnwvTHN8D9SWpIiDyA+Mjp2Hjp27JuDBnigGaEtWCAUVw9RVC56XWa
         nEdXXQeBNwKS5LvoSjyC0ogeoiWXg/Q8ooF/5KKxHdRsQkNxeAEbEJcrbr/4ZfSE9P
         Zrin/YdJhxz4gFjO6wum15o6CdkobA0IXGpPQBsLRXlgICh9YZ+oyB8vZmzURwKnH1
         xrkjXfmysyW4A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20220126110447.24549-1-linmq006@gmail.com>
References: <20220126110447.24549-1-linmq006@gmail.com>
Subject: Re: [PATCH] spi: meson-spicc: add IRQ check in meson_spicc_probe
Message-Id: <164321141213.490397.12590014811818910927.b4-ty@kernel.org>
Date:   Wed, 26 Jan 2022 15:36:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 11:04:47 +0000, Miaoqian Lin wrote:
> This check misses checking for  platform_get_irq()'s call and may passes
> the negative error codes to devm_request_irq(), which takes unsigned IRQ #,
> causing it to fail with -EINVAL, overriding an original error code.
> Stop calling devm_request_irq() with invalid IRQ #s.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: meson-spicc: add IRQ check in meson_spicc_probe
      commit: e937440f7fc444a3e3f1fb75ea65292d6f433a44

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
