Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F84750B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbhLOCEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:04:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38098 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbhLOCEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:04:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C810161796
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C80C34601;
        Wed, 15 Dec 2021 02:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639533847;
        bh=TOjtb2aoJCE2pXxO6BztrEzxcbnx3/8gLisrRtT+7d8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GkqHt4YAVUbxahzZiuhPY9tPPoQkLsU+EFYlRaMxLDZMRSgD6IG/ZWTXj1Vi8gt0D
         wpj0B3LKcIMAvvFQktHH9bPFNkUjEi8eBsUrFpTb08SSY4bjfsUcSTYVCzVmKsPwHI
         8X07HiBStSQyVu0QeqbmmczJU/RTuKoZNu0PwYPgxIHlP4wsHMh8zlUHlbaFQ8V/rI
         bN2GY8PyqeS6/hzTxAmIWlv0wuzRn+OUgOVCqCnAQM5/p8Duu6ZEuLOaqNC2EIlrCx
         f9/ogrzOxET5oBXGlBSVI26RhZbCpQTDQIb0U0n2KvJZCZgVg7yissxk1xWrh1gZj/
         ZFtYrxkn0TBew==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, tiwai@suse.de,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Gyeongtaek Lee <gt82.lee@samsung.com>, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
References: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/6] ASoC : soc-pcm: fix trigger race conditions with shared BE
Message-Id: <163953384515.1515253.13641477106348913835.b4-ty@kernel.org>
Date:   Wed, 15 Dec 2021 02:04:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 11:37:39 -0600, Pierre-Louis Bossart wrote:
> We've been adding a 'deep buffer' PCM device to several SOF topologies
> in order to reduce power consumption. The typical use-case would be
> music playback over a headset: this additional PCM device provides
> more buffering and longer latencies, leaving the rest of the system
> sleep for longer periods. Notifications and 'regular' low-latency
> audio playback would still use the 'normal' PCM device and be mixed
> with the 'deep buffer' before rendering on the headphone endpoint. The
> tentative direction would be to expose this alternate device to
> PulseAudio/PipeWire/CRAS via the UCM SectionModifier definitions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
      commit: d8a9c6e1f6766a16cf02b4e99a629f3c5512c183
[2/6] ASoC: soc-pcm: align BE 'atomicity' with that of the FE
      commit: bbf7d3b1c4f40eb02dd1dffb500ba00b0bff0303
[3/6] ASoC: soc-pcm: Fix and cleanup DPCM locking
      commit: b7898396f4bbe160f546d0c5e9fa17cca9a7d153
[4/6] ASoC: soc-pcm: serialize BE triggers
      commit: b2ae80663008a7662febe7d13f14ea1b2eb0cd51
[5/6] ASoC: soc-pcm: test refcount before triggering
      commit: 848aedfdc6ba25ad5652797db9266007773e44dd
[6/6] ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE
      commit: 3aa1e96a2b95e2ece198f8dd01e96818971b84df

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
