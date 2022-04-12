Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA6B4FE9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiDLVFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiDLVFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 17:05:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD4914A6C7;
        Tue, 12 Apr 2022 13:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46AC7B82008;
        Tue, 12 Apr 2022 20:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4B8C385A8;
        Tue, 12 Apr 2022 20:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649796219;
        bh=M3bH5tJjawfGnNazRXpM08pIjIgoih+NhAuD9hNkluo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Lvuhw04fQ+8xsrTQdeje0PY30Cg8y9LsU5yjeS7MSItnguP23C4pkhneTLtxaHs5h
         BWRjToIXF/92r8tc7ouehiBPzd3JDMzYQs+G2G6n8JtJiN+ga5Vz794liB9UV9oLtB
         7Dvu5xRbOy/h8Stx5jiJ2mQX4zUfhLpTQoC8NqTr97mCr7pAvyhkMfWQkypp5LUCPw
         1NONMqj3Mu0XbVwUKK8sZ5T//2z19Aour3kivk/DTEVdAUWLBqJfPu3Eh77nAp2XOg
         kR0l72hbK/o8A4UktSFukggyclm73MnCgmUxKIsaXV1+eMYgkFZTQ51mdSrxhMJt/B
         nzJVwHKVMSVBA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul.kocialkowski@bootlin.com
Cc:     thomas.petazzoni@bootlin.com
In-Reply-To: <20220412122207.130181-1-paul.kocialkowski@bootlin.com>
References: <20220412122207.130181-1-paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] spi: core: Only check bits_per_word validity when explicitly provided
Message-Id: <164979621877.474093.2840489613136118928.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 21:43:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 14:22:07 +0200, Paul Kocialkowski wrote:
> On SPI device probe, the core will call spi_setup in spi_add_device
> before the corresponding driver was probed. When this happens, the
> bits_per_word member of the device is not yet set by the driver,
> resulting in the default being set to 8 bits-per-word.
> 
> However some controllers do not support 8 bits-per-word at all, which
> results in a failure when checking the bits-per-word validity.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: core: Only check bits_per_word validity when explicitly provided
      commit: b3fe2e516741368a643d79527ebccfe557217a53

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
