Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B224C395E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiBXW7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiBXW7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:59:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF155184634;
        Thu, 24 Feb 2022 14:59:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BCE461BE9;
        Thu, 24 Feb 2022 22:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA000C340F3;
        Thu, 24 Feb 2022 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645743548;
        bh=3Qb2BkHQDJuZIu/isvYb9+K/H30oWB63BPIe7mkdsjA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=eaIXBQmF7b+U5I8q1detGGs6SLD11jCUGts6JTw8S06U0qxITDP8GrJoV1lyEuKJy
         DKjAR34X6/4+QDT5v+fGwHyeFBvU11+MxKgCQiUF+t0gQ3TjBnjXrPuCWIG6BBXtAf
         p4IbMDyWbEQJx+NHqwdyoYOhIMarpzi6J1KAXkEBVek16LK+TjXmMkxgqOBJw82KrC
         GZQg8RvuniuAD/+I6f9ZFN76kRqSlrRxgKgR0cqIO9bEBS2l0UU//sRFPtN/cg8gEn
         2NFeaa0jc7M5fetCBYmNxzrCCE6vDoPsuESA30xzAO1mJGRuXkOAmhd9pl5G+dT1ak
         P8q3PjmQgpBJw==
From:   Mark Brown <broonie@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        judyhsiao@chromium.org, plai@codeaurora.org,
        rohitkr@codeaurora.org, lgirdwood@gmail.com,
        bjorn.andersson@linaro.org
In-Reply-To: <1639503391-10715-1-git-send-email-quic_srivasam@quicinc.com>
References: <1639503391-10715-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v10 00/10] Add support for audio on SC7280 based targets
Message-Id: <164574354548.4011497.8789309217655990766.b4-ty@kernel.org>
Date:   Thu, 24 Feb 2022 22:59:05 +0000
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

On Tue, 14 Dec 2021 23:06:21 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add support for Audio over wcd codec,
> digital mics, through digital codecs and without ADSP.
> 
> Changes Since V9:
>     -- Change individual clock voting to bulk clock voting of lpass-sc7280 platform driver.
>     -- Remove redundant clocks in lpass variant structure.
>     -- Add mclk for MI2S based headset path.
>     -- Remove unused lpass variant structure members in lpass header.
> Changes Since V8:
>     -- Fix errors in sc7280 lpass cpu dt-bindings.
>     -- Move to quicinc domain email id's.
> Changes Since V7:
>     -- Fix indentation errors.
>     -- Bisect patches to avoid interdependency.
> Changes Since V6:
>     -- Split cdc dma regmap config macros.
>     -- Add write dma reg fields for i2s path.
>     -- Add helper function to distinguish rxtx and va dma ports.
>     -- Optimizing clock and reg name in cpu dt-bindings.
>     -- Update buffer management for cdc dma path.
>     -- Remove Kconfig fields of machine driver.
> Changes Since V5:
>     -- Include MI2S primary node to snd_soc_dai_driver in lpass-sc7280 platform driver.
>     -- Move dependency patch list to corresponding patch.
>     -- Add support for missing cdc-dma ports.
>     -- Change if/else conditional statements to switch cases.
>     -- Add missing error handlings.
>     -- Typo errors fix.
> Changes Since V4:
>     -- Remove unused variable in lpass-sc7280 platform driver.
> Changes Since V3:
>     -- Remove redundant power domain controls. As power domains can be configured from dtsi.
> Changes Since V2:
>     -- Split lpass sc7280 cpu driver patch and create regmap config patch.
>     -- Create patches based on latest kernel tip.
>     -- Add helper function to get dma control and lpaif handle.
>     -- Remove unused variables.
> Changes Since V1:
>     -- Typo errors fix
>     -- CPU driver readable/writable apis optimization.
>     -- Add Missing config patch
>     -- Add Common api for repeated dmactl initialization.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/10] ASoC: qcom: SC7280: Update config for building codec dma drivers
        (no commit info)
[02/10] ASoC: qcom: Move lpass_pcm_data structure to lpass header
        commit: 74190d7cd3e8ab5123206d383dbfe125a4b7bb19
[03/10] ASoC: qcom: lpass: Add dma fields for codec dma lpass interface
        commit: ddd60045caa59d4b3d4b2a4b48fefd4974198587
[04/10] ASoC: qcom: Add helper function to get dma control and lpaif handle
        commit: 16413d5c5a2ed81d8fece1c5fe0b85752ecdbdf2
[05/10] ASoC: qcom: Add register definition for codec rddma and wrdma
        commit: dc8d9766bc03efee4d1b6dd912659858fdf981de
[06/10] ASoC: qcom: Add regmap config support for codec dma driver
        commit: b138706225c9ce9fac7a4955df31d8f68bb1d409
[07/10] ASoC: qcom: Add support for codec dma driver
        commit: 7d7209557b6712e8aa72ac1ce67a3fe209f5f889
[08/10] ASoC: qcom: Add lpass CPU driver for codec dma control
        commit: b81af585ea54ee9f749391e594ee9cbd44061eae
[09/10] ASoC: dt-bindings: Add SC7280 lpass cpu bindings
        commit: f3fc4fbfa2d2a09cb279af4e290d0a6dbbc93c7e
[10/10] ASoC: qcom: lpass-sc7280: Add platform driver for lpass audio
        commit: b62c4e5fba2f910bc9f23ae152d11627e4c2f00f

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
