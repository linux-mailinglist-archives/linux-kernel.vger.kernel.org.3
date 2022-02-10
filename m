Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2B4B0EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiBJNiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:38:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiBJNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:38:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43FDDD2;
        Thu, 10 Feb 2022 05:38:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B98AB82550;
        Thu, 10 Feb 2022 13:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4006C004E1;
        Thu, 10 Feb 2022 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644500294;
        bh=gAO3e038tfnaSDdissyBQOdJAZGLYn06il3KVMfenhw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Rmlj2+Rgua8lTjyMX6K+sKsWM50ahVH2UbEvqxY0RKBdEDu2hI3ljoheDNumnVf2p
         Himx02oVPQ8q1GnvcqGCzdYxmdzQX+g963Wk+MPRVQt5JeaJMC1nZyoaOxbDUWyNdS
         l6vfzGoPBaJSrUPni3Z/BR4BV7tDIvrudwz6/69bajzEerAcndHSkGAhUZxcYaOZV/
         FXdZAN3pVzZlVERx87R2CKIQO0DTATs/sDaN0z49hr33NR4Q4mBjfxXj/AgGyrY2qo
         4KZkZajmHMoOyyukdL/Q6L49Pb79Ag+fM/tQlu6uWwp8HXrgTat06RT3vNtgWJam9r
         EmflE7GyDp/cw==
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
In-Reply-To: <20220209232520.4017634-1-swboyd@chromium.org>
References: <20220209232520.4017634-1-swboyd@chromium.org>
Subject: Re: [PATCH] ASoC: qcom: Actually clear DMA interrupt register for HDMI
Message-Id: <164450029256.1000223.6826935774856204278.b4-ty@kernel.org>
Date:   Thu, 10 Feb 2022 13:38:12 +0000
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

On Wed, 9 Feb 2022 15:25:20 -0800, Stephen Boyd wrote:
> In commit da0363f7bfd3 ("ASoC: qcom: Fix for DMA interrupt clear reg
> overwriting") we changed regmap_write() to regmap_update_bits() so that
> we can avoid overwriting bits that we didn't intend to modify.
> Unfortunately this change breaks the case where a register is writable
> but not readable, which is exactly how the HDMI irq clear register is
> designed (grep around LPASS_HDMITX_APP_IRQCLEAR_REG to see how it's
> write only). That's because regmap_update_bits() tries to read the
> register from the hardware and if it isn't readable it looks in the
> regmap cache to see what was written there last time to compare against
> what we want to write there. Eventually, we're unable to modify this
> register at all because the bits that we're trying to set are already
> set in the cache.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: qcom: Actually clear DMA interrupt register for HDMI
      commit: c8d251f51ee61df06ee0e419348d8c9160bbfb86

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
