Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C4E5A3FCD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiH1VEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiH1VEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 17:04:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B774F31237
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 720B1B80BA3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E7AC433C1;
        Sun, 28 Aug 2022 21:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661720638;
        bh=lwcPIEyWvsC4YSgBDvQ66yFrUzPW73+nJlFu8TTn4tc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pt98j5xZFB14YgQaDwB52b5tmmcTqR/yNAkZTJSVasCeCCUI6S9VtPd8KwZDY7MX0
         +MygvLSUru/hPjeWOAb3HeeKC0QQCrz+lby+1o83WA9PVS3Q7I7qSf2hiWs/E4Pr3A
         L+QXOOUJ6jKR8n0iwbNGSn4NapFm3sB2J+naow7kBqBiaaSsc0IkcidnKUXMJ43G6/
         qyi+rdLTo1RhVvwswSJmBI+ULl8SK5C6FARgSlJfJDDjfU2LeObys1KgT/9ZYA3KbV
         A/ME1keSUkZVktX0Os3sXbojFqNXFEa7TPm9yyQyg7X8jWW4vmGkIoZYaC+xto00e9
         qDVjP/Gtktnjw==
From:   Mark Brown <broonie@kernel.org>
To:     dianders@chromium.org
Cc:     lgirdwood@gmail.com, ahalaney@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
References: <20220824142229.RFT.v2.1.I137e6bef4f6d517be7b081be926059321102fd3d@changeid>
Subject: Re: [RFT PATCH v2 1/2] regulator: core: Require regulator drivers to check uV for get_optimum_mode()
Message-Id: <166172063687.600288.12015393675226828521.b4-ty@kernel.org>
Date:   Sun, 28 Aug 2022 22:03:56 +0100
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

On Wed, 24 Aug 2022 14:22:56 -0700, Douglas Anderson wrote:
> The get_optimum_mode() for regulator drivers is passed the input
> voltage and output voltage as well as the current. This is because, in
> theory, the optimum mode can depend on all three things.
> 
> It turns out that for all regulator drivers in mainline only the
> current is looked at when implementing get_optimum_mode(). None of the
> drivers take the input or output voltage into account. Despite the
> fact that none of the drivers take the input or output voltage into
> account, though, the regulator framework will error out before calling
> into get_optimum_mode() if it doesn't know the input or output
> voltage.
> 
> [...]

Applied to

   broonie/regulator.git for-next

Thanks!

[1/2] regulator: core: Require regulator drivers to check uV for get_optimum_mode()
      commit: 55841199050d0c6c44eb7f24717816e6e372599f
[2/2] regulator: core: Don't err if allow-set-load but no allowed-modes
      commit: 57919f4a2ea47f75ac6117f7d99831f7fbd89bc7

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
