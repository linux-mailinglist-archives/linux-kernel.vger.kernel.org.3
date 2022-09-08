Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0E5B207C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiIHOZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiIHOZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:25:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7097180B66;
        Thu,  8 Sep 2022 07:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31D2CB81FCC;
        Thu,  8 Sep 2022 14:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B09C433D6;
        Thu,  8 Sep 2022 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662647121;
        bh=GnXm3DasQPANuFBkOmVp81W6zikm6F2UaWae26C2T5g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OWJQjCg131BkZfLerYXrBNn0mERHWwF9lUiU3wq5MR17jFYdpoUWmLJmQuU+EoAJ8
         T5fYdr6aKVdppfnCgoiUJlfRwIe7rd1nqus+m2TYnZvFx7xRqqoinfaEEGQpMZLeKj
         3yZZejBk3TjF5SYlg8nQKS7L2IYDidoduq0aCsD3NmnHwJA6jvgT1NESHkADBHQYTT
         ++qF2tPjxW8siFuV9Xf+fAScX0ufBnnQ88h/0NLRxtEuLOiGcPISqBp7kfbCwBmFPj
         w3X3h5U5I6sAI2ckm0km/NQywHcrHch48q1ec3ghld01we1rR3FAFkWziE+wl1lFcN
         nJn+Gm8VGr6Lw==
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220908121803.919943-1-narmstrong@baylibre.com>
References: <20220908121803.919943-1-narmstrong@baylibre.com>
Subject: Re: [PATCH] spi: meson-spicc: do not rely on busy flag in pow2 clk ops
Message-Id: <166264712029.115040.727850066200274922.b4-ty@kernel.org>
Date:   Thu, 08 Sep 2022 15:25:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 14:18:03 +0200, Neil Armstrong wrote:
> Since [1], controller's busy flag isn't set anymore when the
> __spi_transfer_message_noqueue() is used instead of the
> __spi_pump_transfer_message() logic for spi_sync transfers.
> 
> Since the pow2 clock ops were limited to only be available when a
> transfer is ongoing (between prepare_transfer_hardware and
> unprepare_transfer_hardware callbacks), the only way to track this
> down is to check for the controller cur_msg.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: do not rely on busy flag in pow2 clk ops
      commit: 36acf80fc0c4b5ebe6fa010b524d442ee7f08fd3

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
