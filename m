Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7B4C0ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiBWEIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiBWEIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:08:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93098532ED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:08:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20155609ED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A41C340E7;
        Wed, 23 Feb 2022 04:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645589289;
        bh=zbRIkwsmMgR93F4yyphb0tidO53L1BRrMen0pEo5/iY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Sw4LffWVPkM56WH+IEMM86nsCvbUlmmQA4xbuLOTZUQcqfDDKHdKNjCtVpkqgJWfc
         dSBcsM8oiUuDFO1bkjsKFHpB1MPjNKJv9F1sDe4t0J/epOfuCHRYGNG1F8JucxCR+l
         dEg/3jdCJWbp3yKK3CgeS4POy0OXScKYgl0kDvuavtorNMhvvu1llf/jLBlBuXv0Iu
         OlHQ59nhf/0bd/jVYpTbjxerEjZqv06UyzufSHuQ0iPe+cBRjx+ihRAmDL1+caRSrv
         30mYaz6dD+OkgBhzIVi4AwJY89WG+XQeF9APVk6HdnGoWo3xTIycpqJpc9wb8vrVQt
         /QOZoIFPeLTXA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
        quic_srivasam@quicinc.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
Subject: Re: (subset) [PATCH 00/16] ASoC: codecs: qcom fix validation failures
Message-Id: <164558928763.1665019.3142653636654338905.b4-ty@kernel.org>
Date:   Wed, 23 Feb 2022 04:08:07 +0000
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

On Tue, 22 Feb 2022 11:59:17 +0000, Srinivas Kandagatla wrote:
> Thanks for pointing out to mixer kselftest and VALIDATION Kconfig.
> 
> This patchset addresses some of the issues in Qualcomm codecs that are
> discovered with recent mixer kselftest and validations added to ASoC.
> 
> Mostly these are under
> 1. accessing integer value type for enum controls, which is clearly an array out of bounds access.
> 2. Fix incorrect ranges.
> 3. Fix incorrect min max for tlv controls. (I can see that other codecs also suffer same issue)
> 4. Fix return values for put functions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[01/16] ASoC: codecs: rx-macro: fix accessing compander for aux
        commit: 42c709c4e1ce4c136891530646c9abd5dff3524f
[02/16] ASoC: codecs: rx-macro: fix accessing array out of bounds for enum type
        commit: bcfe5f76cc4051ea3f9eb5d2c8ea621641f290a5
[04/16] ASoC: codecs: va-macro: fix accessing array out of bounds for enum type
        commit: 0ea5eff7c6063a8f124188424f8e4c6727f35051
[06/16] ASoC: codecs: wc938x: fix accessing array out of bounds for enum type
        commit: cc587b7c8fbbe128f6bd0dad025a0caea5e6d164
[07/16] ASoC: codecs: wcd938x: fix kcontrol max values
        commit: b0217519236924f77a8382b4004e43ef8fd0dcbb
[08/16] ASoC: codecs: wcd934x: fix kcontrol max values
        commit: 61163c3e7480106804269182e24db05244866493

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
