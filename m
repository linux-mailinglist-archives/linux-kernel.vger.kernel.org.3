Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4CA49B184
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348763AbiAYKX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbiAYKUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A88C061751
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E583B81750
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96410C340E0;
        Tue, 25 Jan 2022 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106015;
        bh=4XCKnN8xFhrkQ6vCbD+sDCKa+oAw0sswmbb3nIQMD30=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qv2lL5GXzVs3ZKFVKV+QjfsTdk1J4QaHLYck3C2tFm10JGyGf4Sjd77f7oK1QJTF/
         IRrlGsOqUiA6tj4z9f9cwakwuOgy2ULEaJVU9VuU4Dwc+J4sc3foslBfoP8UOMyGxa
         Ede2dfhxPP9UVSKW0QuKvRbEMhn9WwbPim0HAX9kqxb1fmKT7aWtyksn+pe21nV9cs
         PyfdmxKPde3jophCJMBUDsFFZPOCou81R+7qJn4r3xGfnQ8ZKkSDS/yLBLRMi2VWHJ
         33sYG7ASFheUSm7Eh5+7tlvLN/w+zBtbDBYeQtOlm/iMD33khZB0TISYCIog6Z4gHi
         rt62e0hxNPB/g==
From:   Mark Brown <broonie@kernel.org>
To:     cezary.rojewski@intel.com, tiwai@suse.com,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, lgirdwood@gmail.com,
        srinivas.kandagatla@linaro.org, perex@perex.cz,
        bgoswami@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220111013215.494516-1-jiasheng@iscas.ac.cn>
References: <20220111013215.494516-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: codecs: Check for error pointer after calling devm_regmap_init_mmio
Message-Id: <164310601334.74844.2027416131386442592.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 09:32:15 +0800, Jiasheng Jiang wrote:
> The devm_regmap_init_mmio() may return error pointer under certain
> circumstances, for example the possible failure of the kzalloc() in
> regmap_mmio_gen_context(), which is called by devm_regmap_init_mmio().
> Then the error pointer will be dereferenced.
> For example rx->regmap will be used in rx_macro_mclk_enable().
> Therefore, it should be better to check it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Check for error pointer after calling devm_regmap_init_mmio
      commit: aa505ecccf2ae7546e0e262d574e18a9241f3005

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
