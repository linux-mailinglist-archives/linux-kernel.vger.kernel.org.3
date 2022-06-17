Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B365500A5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383667AbiFQXUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383674AbiFQXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:19:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFF566FA3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 818AFB82C0A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 23:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE71C3411E;
        Fri, 17 Jun 2022 23:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655507987;
        bh=1ZQAmxpThkE2DLyss9Wc6dIO9PFD69OSF6CfY8xWydE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pk/mbNWthNkCEDjD0aDVFlePtSIelO8IwNo1zp+ymn6vxb6jwtPjiTcQHjhxEnKxU
         JxTBSgjXTPWMnhMlT1XdJdAzLpManKtq9/bIJpIvguJNtpwreUEhMTL4KubdOiyutq
         fZ7qTTBmuGX+Vrj9r9Dr2cpDa+uoTrshQNvfc5RfmkpopGqoV35m7aQI1pN6rCZvfg
         aPf09t16WuzEbf3jLneas3RM3Xk0SBWOHXQO0cj1CxC9rIDC2UszxC3wNiiBUDrpSq
         +Fz++F6tVQgbJP1sOu8PxJnBcodeucpFeQDkoee/wDPTRUcc9TyVcJcKUWAMha7Isj
         wuTRSuMrI+hOw==
From:   Mark Brown <broonie@kernel.org>
To:     sbinding@opensource.cirrus.com, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220617153606.2619457-1-sbinding@opensource.cirrus.com>
References: <20220617153606.2619457-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v1] ASoC: ops: Fix integer detection for when max possible values > 1
Message-Id: <165550798591.994018.15249156290558800333.b4-ty@kernel.org>
Date:   Sat, 18 Jun 2022 00:19:45 +0100
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

On Fri, 17 Jun 2022 16:36:06 +0100, Stefan Binding wrote:
> The standard snd_soc_info_volsw() allows a two value control to be
> defined as an integer control only if the control name ends in
> "Volume". It achieves this by creating a substring if it contains
> " Volume", and ensuring this exists at the end of the name. The
> volume substring is then used to decide whether the type is a
> SNDRV_CTL_ELEM_TYPE_INTEGER or SNDRV_CTL_ELEM_TYPE_BOOLEAN.
> However this volume substring is only computed for a two value
> control.
> This means for controls where there are more than two possible
> values, the substring is never created, so in this case the
> substring remains NULL, and the condition yields
> SNDRV_CTL_ELEM_TYPE_BOOLEAN, even though there are more than 2
> possible values.
> If there are more than 2 possible values for the control,
> then it should always be an integer control.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ops: Fix integer detection for when max possible values > 1
      commit: 442302003bd2b151e12d52b0af9a7dac131bf931

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
