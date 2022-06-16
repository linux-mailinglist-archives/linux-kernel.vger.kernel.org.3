Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099CF54DFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiFPLPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiFPLPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318C5C872;
        Thu, 16 Jun 2022 04:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C2461876;
        Thu, 16 Jun 2022 11:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61BCC34114;
        Thu, 16 Jun 2022 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655378113;
        bh=tKlEDA1EasKYeVLhTpK38Q4V6iDP/hsRbWMhaW6i57c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GiVwek66noUKCP/MpxO6ww/WST+HByktPkLVJ3P54zuvLopaypPwCcIRx6ezoLG6q
         DaTjS/OJP3HgmoY3ECFRd3v5mqu2c8izuJGFmHBOq5sZee2Cmnswv4AO6UtmhB5/MB
         lpBLKrBNQ6bBuUrJVioxOsPFAp6mkL5snuBCHfDDOS9LDTDc6LnEdEZp9aHLUeUhsl
         zlKmjr+I+FbwBpd2/JB8khbW2xiM1KPpz3pE4W3+gUEs70G4yT/7r0RpHzMu5R50kJ
         f4JVA8CLTwFTHArpp4C6Ms1vtz1nyC1LPxVwKD4YS1Ieuw/zKnzP1DA4mDw8wXfxd0
         fnv/8qawZzlKg==
From:   Mark Brown <broonie@kernel.org>
To:     yung-chuan.liao@linux.intel.com,
        Colin Ian King <colin.king@intel.com>,
        ranjani.sridharan@linux.intel.com, perex@perex.cz,
        alsa-devel@alsa-project.org, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, liam.r.girdwood@linux.intel.com,
        kai.vehmanen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20220614183809.163531-1-colin.i.king@gmail.com>
References: <20220614183809.163531-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: remove redundant re-assignments to pointer array
Message-Id: <165537811030.677284.4884559545577351783.b4-ty@kernel.org>
Date:   Thu, 16 Jun 2022 12:15:10 +0100
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

On Tue, 14 Jun 2022 19:38:09 +0100, Colin Ian King wrote:
> There are two occurrences where the pointer array is being assigned a value
> that is never read, the pointer gets updated in the next iteration of a
> loop. These assignments are redundant and can be removed.
> 
> Cleans up clang scan-build warnings:
> sound/soc/intel/skylake/skl-topology.c:2953:3: warning: Value stored to
> 'array' is never read [deadcode.DeadStores]
> sound/soc/intel/skylake/skl-topology.c:3602:3: warning: Value stored to
> 'array' is never read [deadcode.DeadStores]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: remove redundant re-assignments to pointer array
      commit: 1ec0c91f6d6b21703c17d5e89f32d52feac5887e

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
