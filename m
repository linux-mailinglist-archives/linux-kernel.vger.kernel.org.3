Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C34F93ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiDHL0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiDHL0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EA12E9F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BAC61F75
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC52CC385A3;
        Fri,  8 Apr 2022 11:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649417060;
        bh=NbBmhmOEh0jvqB0emglK41o3wKsbI3NM+mo49ZJS+ss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=exWJsFiXBcf/WaNq/JWzLHOoZsHl7rlXepjq7PqZAD0v9b28PpI8tJbqiKN7eP27Z
         COzsKAxwyhccmHsWgeR4A7I6w2skRBGa6xYQTRSIVBLrpx+iz2X2oBm6EGkKB9ZnV5
         OUtnEhuWOGdNE7EbPFDXf//+7hCvlKsZGoW8aAlpEp7mU/TdVtSl6Ta2m3fik1PZ1X
         mtaYi13UcZVIQLfYeJho6Fj2T8Ieglwr4XGkZUbOVE0JvT8rgNtAvG0UsaIW0mdLxk
         pxse0XeqHVhfnmrpe+5vv+lzwxy6UjcOU1dk3X+CfIf3t1KuAYBIUcJhIZfRQykdk4
         rxqyEQ992gf5g==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     amit.pundir@linaro.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220407094313.2880-1-srinivas.kandagatla@linaro.org>
References: <20220407094313.2880-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: wcd934x: do not switch off SIDO Buck when codec is in use
Message-Id: <164941705855.1295287.1090953205506531438.b4-ty@kernel.org>
Date:   Fri, 08 Apr 2022 12:24:18 +0100
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

On Thu, 7 Apr 2022 10:43:13 +0100, Srinivas Kandagatla wrote:
> SIDO(Single-Inductor Dual-Ouput) Buck powers up both analog and digital
> circuits along with internal memory, powering off this is the last thing
> that codec should do when going to very low power.
> 
> Current code was powering off this Buck if there are no users of sysclk,
> which is not correct. Powering off this buck will result in no register access.
> This code path was never tested until recently after adding pm support
> in SoundWire controller. Fix this by removing the buck poweroff when the
> codec is active and also the code that is not used.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd934x: do not switch off SIDO Buck when codec is in use
      commit: db6dd1bee63d1d88fbddfe07af800af5948ac28e

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
