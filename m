Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743E2595DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiHPNsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiHPNsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783DB25E80
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EA8C60C43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14B9C433C1;
        Tue, 16 Aug 2022 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660657688;
        bh=qsMSkvaZG+FMUsJ/IYkZeIJbBg5RbWs6tR2GQBYACl8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FP6wz1RflINwl7JDtKCpGn3QWRSJytI9CUm3naETWR0GLY8LTo3+aYUu51eq2Pv4z
         IVhoee/3ytzljOQYmsKLv/RDLBIwf1QH8zBs0l/oLnASik1y9D0jFx+DmTGlre0JHb
         JHvtr6JFXHAKVLnjCgO6wnfz/oUAER3ZQs51qxmuBJh/UPtrCUqpY2lMGr0+4pl5pI
         FinMyYcQZHuJ4A1v98BMNFCehw5rmNTim3AXAHsNnS7l6pwu3n0lfL69YKLYahSJ5f
         aeekFabxdLEBOty4Iwd6E1tWMEVhEa8g6YREwmWeZChYD5FoCI1nRVi2XUc62hhxdj
         XVaDyiRClFuyA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     vsujithkumar.reddy@amd.com, Nathan Chancellor <nathan@kernel.org>,
        ssabakar@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Vijendar.Mukunda@amd.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220804072556.601396-1-venkataprasad.potturu@amd.com>
References: <20220804072556.601396-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH v4] ASoC: amd: acp: Initialize list to store acp_stream during pcm_open
Message-Id: <166065768448.1387305.18400628738327646028.b4-ty@kernel.org>
Date:   Tue, 16 Aug 2022 14:48:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 12:55:49 +0530, Venkata Prasad Potturu wrote:
> From: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> 
> We are currently allocating acp_stream during pcm_open and saving
> it in static array corresponds to array index calculated based on
> cpu dai->driver id. This approach will fail if we have single dai
> linked to multiple pcm device as we will have same dai->driver id
> or array index for multiple pcm open. Initialize new linked list
> stream_list to store opened pcm stream info dynamically.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Initialize list to store acp_stream during pcm_open
      commit: 7929985cfe36c336e3d0753e9f23ac4c7758ea7e

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
