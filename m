Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404D259EC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiHWTkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiHWTkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC34E68FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F2E0616FE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E6CC433D6;
        Tue, 23 Aug 2022 18:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661279839;
        bh=6b52WSZ0j72XRJq6uFTsXCAQc695XrtImOHOm6npeI0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fCGqvlzlZe5Fih2wiCo9XuQ6bZuWQpS4Fkb5U9T0AaZAfFtnkTftjnL8OvWZ29Asp
         WRTPf0O0fPAGBPJx6q1Lv0Z3hmboFJvyaFxbs5z0MTX/b7o74pGWz5HeJxdiwfy9n6
         ZkXthBYrOmT36MUgDa8PmrF/903ZpdwLG2J8uQPi89h7asbfIvWVJ9ryQAlVk0mQOa
         c+otNUMpaonl6T8AeR9I1YBiYmlcds+u4+kAwMC6BEo5L4/EGngyhSpy/Y/7kHtljd
         YM4G4eG7gDn1nVmor3ffibw/eIgQJdh2yKIOlnhYLF89o8KCBTHv+jgxZlM2IIKrhQ
         WZM6LZLiIS6Nw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tom Rix <trix@redhat.com>, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220810010809.2024482-1-nathan@kernel.org>
References: <20220810010809.2024482-1-nathan@kernel.org>
Subject: Re: [PATCH] ASoC: mchp-spdiftx: Fix clang -Wbitfield-constant-conversion
Message-Id: <166127983640.711152.15279532246364775048.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:37:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 18:08:09 -0700, Nathan Chancellor wrote:
> A recent change in clang strengthened its -Wbitfield-constant-conversion
> to warn when 1 is assigned to a 1-bit signed integer bitfield, as it can
> only be 0 or -1, not 1:
> 
>   sound/soc/atmel/mchp-spdiftx.c:505:20: error: implicit truncation from 'int' to bit-field changes value from 1 to -1 [-Werror,-Wbitfield-constant-conversion]
>           dev->gclk_enabled = 1;
>                             ^ ~
>   1 error generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mchp-spdiftx: Fix clang -Wbitfield-constant-conversion
      commit: 5c5c2baad2b55cc0a4b190266889959642298f79

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
