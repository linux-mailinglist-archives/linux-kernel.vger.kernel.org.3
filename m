Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F975500A3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383644AbiFQXUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383671AbiFQXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:19:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4E966CA1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 155DDB82BFD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 23:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B984C3411D;
        Fri, 17 Jun 2022 23:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655507985;
        bh=0/gO3abdMtjXJJpqM36aCEMHAeb67MB4T5VdLEmQPhU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mSYB4A8vVI8/80VKW+wQI60aipjNbjGuov8aEaeV3xzY0qi+mC1IsiMJlrSyx2mcu
         7tgluN/XY6yo1SBCnBgB4ZGnckTjbQMxu7tuwyPKm0E+6Tz2TWP66lT1QfRraSLtHs
         8iz9aXtIeDFQlh0JV8hEwAyc0FQWdR1W3REhmkGYayAm7OFCO50HmRrIq8PiLP6BCV
         +TOnacjJxVxcCl+DC5vFEIYdoyv8hWiA5rvY2sSJX/36lENJjIBfqe7zVHSplywl+W
         gcPoT1cuH8XPRDWTUGocZhKUufUszJyxqfEBrr6Ze4WB1J9SZ9fEn3Mt+93EkJfBON
         DoBIr/62K9WRg==
From:   Mark Brown <broonie@kernel.org>
To:     jiaxin.yu@mediatek.com, fshao@chromium.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220617111003.2014395-1-fshao@chromium.org>
References: <20220617111003.2014395-1-fshao@chromium.org>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8186: Fix mutex double unlock in GPIO request
Message-Id: <165550798423.994018.10916752817659523759.b4-ty@kernel.org>
Date:   Sat, 18 Jun 2022 00:19:44 +0100
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

On Fri, 17 Jun 2022 19:10:04 +0800, Fei Shao wrote:
> The lockdep mechanism revealed an unbalanced unlocking on MT8186:
> 
>   [    2.993966] WARNING: bad unlock balance detected!
>   [    2.993978] -------------------------------------
>   [    2.993983] kworker/u16:1/10 is trying to release lock (gpio_request_mutex) at:
>   [    2.993994] [<ffffffdcd9adebf8>] mt8186_afe_gpio_request+0xf8/0x210
>   [    2.994012] but there are no more locks to release!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: Fix mutex double unlock in GPIO request
      commit: 6c9e9046e1ff356bda66661213735d33c6cfea53

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
