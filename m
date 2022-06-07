Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8753FC05
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbiFGKsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbiFGKru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:47:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24397ED724;
        Tue,  7 Jun 2022 03:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7485AB81F06;
        Tue,  7 Jun 2022 10:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E277C34114;
        Tue,  7 Jun 2022 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598808;
        bh=EqeS6NbzqWwmRkfg8oDB/9xKcFwc2slbkLCUmJHM7mA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h4p52V/viEECsovLapmkxiQU/zQfD5GXTvBkeHe6qFhWIY2CgIsOiFhGWw17Z/cvH
         yYZZy0XM2WuCY0sXqKqjjST/mp5wMnd7L+Amg6YNyIPbGszfwpnYFBdixb3gZo7nv5
         orWld6P7W0UnbFq4pkbffA93I3DbPfjruyZXCjrHOb7CC9kgL0P/fIFMARvt3shWHE
         aRyOM7Ls0jJE1jci3e9WfRMcWyZYwjKnKLGILW2H/nEBPUVejs1M3sBdVUP93u0fwa
         F0CHoq0fdQEjOiq0fpw50OGYHpTjOmeZDHtMl3imsl3AyIkAsmLhM2kHr2+0Ofi4TJ
         k6ewfxmiDu4iQ==
From:   Mark Brown <broonie@kernel.org>
To:     vaishnav.a@ti.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     vigneshr@ti.com, p.yadav@ti.com
In-Reply-To: <20220601071611.11853-1-vaishnav.a@ti.com>
References: <20220601071611.11853-1-vaishnav.a@ti.com>
Subject: Re: [PATCH -next] spi: cadence-quadspi: Remove spi_master_put() in probe failure path
Message-Id: <165459880689.302078.15844858048042907353.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:46 +0100
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

On Wed, 1 Jun 2022 12:46:11 +0530, Vaishnav Achath wrote:
> Currently the spi_master is allocated by devm_spi_alloc_master()
> and devres core manages the deallocation, but in probe failure
> path spi_master_put() is being handled manually which causes
> "refcount underflow use-after-free" warning when probe failure happens
> after allocating spi_master.
> 
> Trimmed backtrace during failure:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Remove spi_master_put() in probe failure path
      commit: 8523c96894e916b20ba3612e48e404fad5acfdd9

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
