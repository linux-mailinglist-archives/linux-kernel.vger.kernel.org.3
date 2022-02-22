Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393574BFCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiBVPdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiBVPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:33:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FEC792D;
        Tue, 22 Feb 2022 07:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A357BB81899;
        Tue, 22 Feb 2022 15:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C803C340F4;
        Tue, 22 Feb 2022 15:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645543959;
        bh=faAoL7FirSWjNy55jYu7eqkfiUMVq2Vo5OiepkX3N08=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bl+UEg5QaJZxoajp2TaskeWeTKSrLzWyByqmHkRk1Km7HkHqMwDqQiw9GaHleloTU
         oTcnGOP6qt5aQB1NRQhifAF+GXjzL5MWPP68puZ7HG4IZE3+qsghyK1oLk6SMrRtlx
         zl/VjUm0bgy5n78ywoMGHz2oBvQAGi0g7gxR9lsyuCMbHvQzJ9SpmDt2CAhBFFM2UQ
         xRoPPLxE7oHJ9Ysmt2rb6jGt+g6Y44njJBPk18lNXVrK0aHe62IjJh9ldfkS0kUBZl
         LS+yWz18iqtbx+wXDEeCoIWn+FnJHmHqHBihLrxgnniq5WP8QjsgTG11jzSGbFsrDP
         KhaweSV8YFPcA==
From:   Mark Brown <broonie@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        Dillon Min <dillon.minfei@gmail.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220201115142.3999860-1-a.fatoum@pengutronix.de>
References: <20220201115142.3999860-1-a.fatoum@pengutronix.de>
Subject: Re: [RFT PATCH] spi: stm32: ignore Rx queue not empty in stm32f4 Tx only mode
Message-Id: <164554395470.3556326.18373522553071948963.b4-ty@kernel.org>
Date:   Tue, 22 Feb 2022 15:32:34 +0000
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

On Tue, 1 Feb 2022 12:51:41 +0100, Ahmad Fatoum wrote:
> STM32F4_SPI_SR_RXNE and STM32F4_SPI_SR_OVR are distinct bits in the same
> status register.  ~STM32F4_SPI_SR_OVR | STM32F4_SPI_SR_RXNE is thus
> equal to ~STM32F4_SPI_SR_OVR.
> 
> The original intention was likely for transmission-only transfers to
> ignore interrupts both for when the Rx queue has bytes (RXNE) as well
> as when these bytes haven't been read in time (OVR).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: ignore Rx queue not empty in stm32f4 Tx only mode
      commit: 5741150c808b2bbeb1017609f3029daf6651b7d5

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
