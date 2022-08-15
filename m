Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361EF593262
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiHOPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiHOPpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:45:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8816167F9;
        Mon, 15 Aug 2022 08:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A13EB80F02;
        Mon, 15 Aug 2022 15:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9D4C433D7;
        Mon, 15 Aug 2022 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578303;
        bh=bpJOSnaaKOFAV4EJIOWKkYzEss+zMhG5h5JyLxDFoSc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qY35Wod6KXCNVH5eOCOreFlNufFt2Xd3iFUepG5dxwqNzP267qyYxIu5y058Fcx9E
         qbOC6Qg+6W8WscGW0gDtemMdW4KBq684+Jfc+/iRScSXf5SWiveRP9bHyHzY9WLE7B
         ArWYMRhwC5Mg6fA3axlKhmT8OGQ1r7QaRzppgQUR4ujnFPKJawyPLnzEj9PM+lxU7H
         HPljmhloXy4sAAR1/0hJiSoMVdPrtmKT+Q1M8Q9jnFt4mwx9ojzqbPRBYlnQAZz2K6
         YTkxhFsySct8yGkBty4284JS77uKY4TIRid+Rkbnkrsnc2gxoNpNc6gBR1J7nczzL1
         OGOLofxg99VKg==
From:   Mark Brown <broonie@kernel.org>
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
In-Reply-To: <20220808064603.1174906-1-nagasuresh.relli@microchip.com>
References: <20220808064603.1174906-1-nagasuresh.relli@microchip.com>
Subject: Re: [PATCH v4 0/4] Add support for Microchip QSPI controller
Message-Id: <166057830190.697678.8659830218813922446.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:45:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2022 12:15:59 +0530, Naga Sureshkumar Relli wrote:
> This patch enables the Microchip's FPGA QSPI and Polarfire SoC QSPI
> controller support.
> 
> Tested spi-nand (W25N01GV) and spi-nor (MT25QL256A) on Microchip's
> ICICLE kit. tested using both FPGA QSPI and Polarfie SoC QSPI.
> 
> changes in v4
> -------------
> 1. Removed microchip,mpfs-qspi compatible from the driver
> 2. Changed platform_get_irq() return value check from <=0 to <0
> 3. Fixed dt_binding_check warning by installing latest yamllint
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: dt-binding: document microchip coreQSPI
      commit: a5890c12ecce2696f90ef7d2b8fbb33387f735de
[2/4] spi: dt-binding: add coreqspi as a fallback for mpfs-qspi
      commit: 2ba464e5a3b5743e8f935b5a02b9a7c3d2bd9549
[3/4] spi: microchip-core-qspi: Add support for microchip fpga qspi controllers
      commit: 8596124c4c1bc7561454cee0463c16eca70b5d25
[4/4] MAINTAINERS: add qspi to Polarfire SoC entry
      commit: 1f7d00a7565c8468bbfef87f9fbfebb047003942

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
