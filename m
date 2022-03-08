Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992444D1EFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349204AbiCHRZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349350AbiCHRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:23:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933C35577D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:21:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55CFE61259
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B21C340F5;
        Tue,  8 Mar 2022 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760060;
        bh=Yfasz//GbWj31pLz9SiA6bXz155z6fMe8IJXsB7WIpA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=n11nMwb9nWqKWmlJcFE/z2Z68R6fKnmsJWDEAHmEpFDw337VEC8haxvHUhalJNyiI
         +5F+ghpsKb6jSO1JHlwkbBDRDbB5Sq8X0ALp4G+KbYo6rnuJQNl+P6O8RjJkRarWDq
         3uRrQC4Mcfg4TiaAxZplUtKr81kDfPu7OBmtkXU/nmGMTpzsr5G6QFdYxtKblq84uo
         OjvWfZkATHmZFwuYsPoKrlGE2VJTu56KL4B/2ItejA2NfXwH51SBWfVIe5YQhvEIKJ
         GqtTzEcS8UK2opqMwoRHmtnoETbF0xRFnWFd6sOeSBcx9S/5iHZN4inGGYeKmdyYny
         B/IljWZjCscnw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Meier <florian.meier@koalo.de>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220308013949.20323-1-linmq006@gmail.com>
References: <582c39ac-3099-d54f-5de3-d54a4ace0a04@microchip.com> <20220308013949.20323-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] ASoC: atmel: Fix error handling in snd_proto_probe
Message-Id: <164676005819.54315.3431589094288420530.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:20:58 +0000
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

On Tue, 8 Mar 2022 01:39:48 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error paths.
> Fix this by calling of_node_put() in error handling too.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: Fix error handling in snd_proto_probe
      commit: b0bfaf0544d08d093d6211d7ef8816fb0b5b6c75

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
