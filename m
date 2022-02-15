Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8244B6D39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiBONSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:18:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiBONSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:18:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE50ED10A0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:18:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49A8461704
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E129C340EB;
        Tue, 15 Feb 2022 13:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644931110;
        bh=8cMCtic2t5pEf/DSz0kJZRrHovHUh2AE3w5SyPIBVxo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=sANB+cZNShkF2pr662E4ZWpeXA64APS5swjVSiyw9GZjEsObehp/MFKFJcnjIL6PU
         IIwqQyTX9GRw3DbRMWGePPcl5FOKtQm0pVrKmvok0N120yRB80ueHiunpWJjZ+uvdd
         B/AiH6bCnLHnAsW+E1ZArx0yaIDCykMYVLYAKTZub/woS39wrd/V1Brts8c2TM5Dxk
         oBx2DfK2PgBewS3/n8Ik5MGT7tvUzjLNCGWf49NyF2PighXJhfeE4DP9dHw3JtPf2C
         bDLFnJgKQgjc3G8becqXbdn9i4aeGJGuxo/6ztLKB8ccd+GI240v7rCE7yPo3nmQOO
         YaSobjaXfBgHQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1644491952-7457-1-git-send-email-shengjiu.wang@nxp.com>
References: <1644491952-7457-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: soc-core: skip zero num_dai component in searching dai name
Message-Id: <164493110923.974741.6888113145562787379.b4-ty@kernel.org>
Date:   Tue, 15 Feb 2022 13:18:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 19:19:12 +0800, Shengjiu Wang wrote:
> In the case like dmaengine which's not a dai but as a component, the
> num_dai is zero, dmaengine component has the same component_of_node
> as cpu dai, when cpu dai component is not ready, but dmaengine component
> is ready, try to get cpu dai name, the snd_soc_get_dai_name() return
> -EINVAL, not -EPROBE_DEFER, that cause below error:
> 
> asoc-simple-card <card name>: parse error -22
> asoc-simple-card: probe of <card name> failed with error -22
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: skip zero num_dai component in searching dai name
      commit: f7d344a2bd5ec81fbd1ce76928fd059e57ec9bea

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
