Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E3554EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359204AbiFVPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359220AbiFVPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6683ED0A;
        Wed, 22 Jun 2022 08:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A4FE61542;
        Wed, 22 Jun 2022 15:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821F2C34114;
        Wed, 22 Jun 2022 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655911005;
        bh=74OTJmsDUnJ8Yy67wCt0W4gdTWxoxbdt0Ekwa+iJXlw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Wd3MRhoZEa6qShbmTQ//LXyurzxGZedShHyF58V4d/EgvL0X0NAU6WbQjTyrsDCFy
         9o6DzQBjeTAVrFaODUGwNzjWaoCZaomicw4Yz0hU37Q4HtmjEPKP5QpbzZxh61TIle
         VNaUfM6ZI3D7gX/pX/Dt07tQc3sTOG1abvL6llR/iSnNhsy6lnNJoXQH0yB1zO8Rs4
         ryl2ehKgtUYQJ99Okc2O5QWFF377RFC9m7TA/ATUZN8TQEPq/lcfeBPoMAeCCHwYHX
         frMeOdV7fGBnNCxVvKViwd/uGsp9eLgSEEcYIEfWvDGpUE8Lpe6VfYddUCmnYj/OMD
         bT9FlVvImCbeg==
From:   Mark Brown <broonie@kernel.org>
To:     aidanmacdonald.0x0@gmail.com
Cc:     bjorn.andersson@linaro.org, rafael@kernel.org, orsonzhai@gmail.com,
        krzysztof.kozlowski@linaro.org, jernej.skrabec@gmail.com,
        zhang.lyra@gmail.com, b.zolnierkie@samsung.com,
        linux-actions@lists.infradead.org, myungjoo.ham@samsung.com,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        tiwai@suse.com, cristian.ciocaltea@gmail.com, michael@walle.cc,
        lgirdwood@gmail.com, maz@kernel.org, rjones@gateworks.com,
        linux-sunxi@lists.linux.dev, cw00.choi@samsung.com,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        tharvey@gateworks.com, samuel@sholland.org, brgl@bgdev.pl,
        alsa-devel@alsa-project.org, lee.jones@linaro.org,
        linux-gpio@vger.kernel.org, mazziesaccount@gmail.com,
        wens@csie.org, mani@kernel.org, perex@perex.cz,
        baolin.wang7@gmail.com, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: (subset) [PATCH 00/49] regmap-irq cleanups and refactoring
Message-Id: <165591099823.672192.3312043171342090457.b4-ty@kernel.org>
Date:   Wed, 22 Jun 2022 16:16:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 21:05:55 +0100, Aidan MacDonald wrote:
> Here's a bunch of cleanups for regmap-irq focused on simplifying the API
> and generalizing it a bit. It's broken up into three refactors, focusing
> on one area at a time.
> 
> * Patches 01 and 02 are straightforward bugfixes, independent of the
>   rest of the series. Neither of the bugs are triggered by in-tree
>   drivers but they might be worth picking up early anyhow.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[01/49] regmap-irq: Fix a bug in regmap_irq_enable() for type_in_mask chips
        commit: 485037ae9a095491beb7f893c909a76cc4f9d1e7
[02/49] regmap-irq: Fix offset/index mismatch in read_sub_irq_data()
        commit: 3f05010f243be06478a9b11cfce0ce994f5a0890

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
