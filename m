Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A02049FD61
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349854AbiA1P7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:59:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44156 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349804AbiA1P7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:59:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96AFA61EB7;
        Fri, 28 Jan 2022 15:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB76C340E7;
        Fri, 28 Jan 2022 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385545;
        bh=4ds/QMHf6pPo2/klHwq9ML5MQ6qFcscb6QfQ9G60CYs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iow9U48Ce9aHIJVKX541khyy8uQ8FNGNhvklAIRWhDJLWj1BmUgP6o8L7HEQ8yZdF
         s8AMynvVAATd+JtZTNMtCS0Wey0Hz9R7cZ2De5cQ0mt/WoRFc94AKFrrtpXJJowWiV
         ziz7Ebra+P9RZ3AO3paFLKWTok2wKyD3o+4zneIxxaLY1lb4PRocvJSabvdSn/NbrN
         QGQNKirrR4vY8BUHXspBq5SLoA8kbHCDnGZnjwjjKyBSoPqmfVmTecwDrIzGHeA84W
         mqs4GkIRUg3hhmBZQ1zeDh430WUtXOkC1Kr8JMbcZqCamMdfEPt7myiu4IMxVJLOuH
         KWC5ZCPZZyZnQ==
From:   Mark Brown <broonie@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Xin Xiong <xiongx18@fudan.edu.cn>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc:     Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>, yuanxzhang@fudan.edu.cn
In-Reply-To: <20220125101214.35677-1-xiongx18@fudan.edu.cn>
References: <20220125101214.35677-1-xiongx18@fudan.edu.cn>
Subject: Re: [PATCH] spi: uniphier: fix reference count leak in uniphier_spi_probe()
Message-Id: <164338554302.1711475.9019138910301906036.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:59:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 18:12:15 +0800, Xin Xiong wrote:
> The issue happens in several error paths in uniphier_spi_probe().
> When either dma_get_slave_caps() or devm_spi_register_master() returns
> an error code, the function forgets to decrease the refcount of both
> `dma_rx` and `dma_tx` objects, which may lead to refcount leaks.
> 
> Fix it by decrementing the reference count of specific objects in
> those error paths.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/1] spi: uniphier: fix reference count leak in uniphier_spi_probe()
      commit: 37c2c83ca4f1ef4b6908181ac98e18360af89b42

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
