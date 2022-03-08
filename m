Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13644D1EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349139AbiCHRZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349502AbiCHRXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:23:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB40556439
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:21:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32D38B81BA6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F08C340EB;
        Tue,  8 Mar 2022 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760074;
        bh=YzDVRHHe4KzIf6sXoA5Jjdffip2Zv92DuhYkKW62tqo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=EvLSWYVIL9zy84zHJXvJHR6qwowDJYxdmUl1KmGK8Zl+1Ve1KT11oG6GYDPPD+YZ3
         CPgSdPx2EGvltyY6moIgaWk1gj7GSBAjVi/eFlPXTN52ec2wTKfjWutVsMNPD5kDe1
         1Xf0eDyS5dQG3ALvR6VLhciHatZPRUf6LTaWgPhKBg+1eyJqBwyat7c55d2A0l7iUG
         wtgNwE5psvgV9Xfz3sFCrsT4iPTYqg5vpz3+J5qweW86JR8q+XlLufld5CrD5Gka1x
         kgr4NC7xLVOoTOQMYvcRXjixWJJ4vvM22r9jOFHXUSteeAPnr6UX6cs5xkq1GhwnaS
         YfFzsx0/VG5cQ==
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Miaoqian Lin <linmq006@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20220308020146.26496-1-linmq006@gmail.com>
References: <20220308020146.26496-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mxs: Fix error handling in mxs_sgtl5000_probe
Message-Id: <164676007157.54315.10226994232050384296.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:21:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2022 02:01:44 +0000, Miaoqian Lin wrote:
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error paths.
> For example, when codec_np is NULL, saif_np[0] and saif_np[1]
> are not NULL, it will cause leaks.
> 
> of_node_put() will check if the node pointer is NULL, so we can
> call it directly to release the refcount of regular pointers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mxs: Fix error handling in mxs_sgtl5000_probe
      commit: 6ae0a4d8fec551ec581d620f0eb1fe31f755551c

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
