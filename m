Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D765A3FCE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 23:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiH1VEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 17:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiH1VEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 17:04:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9803134C;
        Sun, 28 Aug 2022 14:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3947BB80B89;
        Sun, 28 Aug 2022 21:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574FAC433D6;
        Sun, 28 Aug 2022 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661720643;
        bh=FnUF9rYTJcPc77tbf/1+ZcTqjLp8rtPouSJhLcvpwFc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GXlQZ5TPGNr54tov+iA1ZRxY0LRGw0mZhlRimWThCDrV4vjGaJGoqtFbHux65UALs
         mISfyRR3HkmsvHlvUkjwWjwVNIGMEokNahHK8vofLJ64NSG18a77iLx7g0nRV+WnAQ
         tAy/vfQm25A90bipbJnu6r7+0OfKHkabrx8czRdvuuOnSD/yjfQpSMAa2Bo+By4uN1
         RYWaJK/AHf6wALAA6o/5oue4UTCXXRgrlUtY/AKfJJsg9iVZbEjcyJC+5wntfkyL5A
         Y56USxiHMCYFIuLaZQSxISA+UlPaaTBPLtbmIFZe6jjzH60c4yyYjafudeiIOfZAgi
         l6Q9LaTakgXDw==
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com
Cc:     dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20220826092031.1393430-1-patrice.chotard@foss.st.com>
References: <20220826092031.1393430-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH] spi: stm32-qspi: Fix stm32_qspi_transfer_one_message() error path
Message-Id: <166172064098.600371.16580591348148311786.b4-ty@kernel.org>
Date:   Sun, 28 Aug 2022 22:04:00 +0100
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

On Fri, 26 Aug 2022 11:20:31 +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> The patch a557fca630cc: "spi: stm32_qspi: Add transfer_one_message()
> spi callback" from Aug 23, 2022, leads to the following Smatch static
> checker warning:
> 
> drivers/spi/spi-stm32-qspi.c:627 stm32_qspi_transfer_one_message()
> error: uninitialized symbol 'ret'.Fix the following Smatch static checker warning:
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: Fix stm32_qspi_transfer_one_message() error path
      commit: 56ec456293239b3c5dfb0e4dcf22972b1b8c571d

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
