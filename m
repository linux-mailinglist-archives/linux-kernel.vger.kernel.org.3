Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24E4F3FF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351096AbiDEPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346740AbiDEJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F60CDB4A0;
        Tue,  5 Apr 2022 02:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B49E6165C;
        Tue,  5 Apr 2022 09:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B03AC385A9;
        Tue,  5 Apr 2022 09:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151099;
        bh=zrh6vghs2wjpbqTv1tqfq5bENYFMGsSNRdUt0yAWN5c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bGg50v7M+Hf+yTXrOrpR1xcsEs5OJK2fKabvNa8pEirakb4/97aDkCW1Wgh/mCGlL
         O8pJ9pKi07pLqC6hwoFSM++DIISgE+5mxC1OW7Lqzb/vsSJUGulcQ0DvlCXE0eNYRm
         eGF8ZZoe0wXed5tY5LLcRmpwM2o6g2DuQGdfIeJrKs2jUccKOZF4eKNtGLvQat75Ps
         zBd1C6RwMZo0owP2Tu5yY7Y2X6MHme+3TsFQZaTjSevPWXmkHEly1V959r+LkklMbs
         EimGHqyDk9fqWuJZ0Ky9F/a1qXKhZQo0sdnCDAxLWB3NAto8mhln7DKNy9gczPHOq+
         Op+Iek2/Dopkg==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, christophe.jaillet@wanadoo.fr,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <e740f1930843060e025e3c0f17ec1393cfdafb26.1648757961.git.christophe.jaillet@wanadoo.fr>
References: <e740f1930843060e025e3c0f17ec1393cfdafb26.1648757961.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: soc-pcm: use GFP_KERNEL when the code is sleepable
Message-Id: <164915109789.276574.4185820197463277703.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:37 +0100
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

On Thu, 31 Mar 2022 22:19:44 +0200, Christophe JAILLET wrote:
> At the kzalloc() call in dpcm_be_connect(), there is no spin lock involved.
> It's merely protected by card->pcm_mutex, instead.  The spinlock is applied
> at the later call with snd_soc_pcm_stream_lock_irq() only for the list
> manipulations.  (See it's *_irq(), not *_irqsave(); that means the context
> being sleepable at that point.)  So, we can use GFP_KERNEL safely there.
> 
> This patch revert commit d8a9c6e1f676 ("ASoC: soc-pcm: use GFP_ATOMIC for
> dpcm structure") which is no longer needed since commit b7898396f4bb
> ("ASoC: soc-pcm: Fix and cleanup DPCM locking").
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm: use GFP_KERNEL when the code is sleepable
      commit: fb6d679fee95d272c0a94912c4e534146823ee89

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
