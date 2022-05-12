Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A28524F97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355128AbiELONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355104AbiELOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E456338D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B23EB61B1F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE53CC385B8;
        Thu, 12 May 2022 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652364778;
        bh=fS5LIWilDa+hz2Ola1gsUeyqJCEe4vAjSZHbZ6Wyv2I=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=jnJCUtKPLyvpYm1omocXcq4bY8fiwWPyNoHSOf2muv4nzjc4/pCzJXco+WbVrys2B
         nVU67xTgNAzmd+KG0jtvtElGYqRyg4AFF0nh7MbnT8oPfogz3e4wGg2D94E5fDhhHb
         AnwD31Bt8FKC8TtmDIYg1SikcscL4PtqVPqSOzy5PKSWj/T5w/Rxx4Ei3WkJlrgVEq
         hS5foECa1v5ajLahqJFojqngPid8DGO+Dc/9zdpYOEWo/7eQbOMe9RZlrPR43A1WLi
         Ii0tbKzsw8OnyryC5YIB6Qi4o5SEMUVQ2JmMHo4cJz0/uYbJXoT5peO0DKv/vb5Ook
         SznOxKhgvpj5w==
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org,
        shawnguo@kernel.org, ye.guojin@zte.com.cn,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-imx@nxp.com,
        linmq006@gmail.com, Xiubo Li <Xiubo.Lee@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20220511052740.46903-1-linmq006@gmail.com>
References: <20220511052740.46903-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix refcount leak in imx_hdmi_probe
Message-Id: <165236477462.1016627.3973321279072799571.b4-ty@kernel.org>
Date:   Thu, 12 May 2022 15:12:54 +0100
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

On Wed, 11 May 2022 09:27:40 +0400, Miaoqian Lin wrote:
> of_find_device_by_node() takes reference, we should use put_device()
> to release it. when devm_kzalloc() fails, it doesn't have a
> put_device(), it will cause refcount leak.
> Add missing put_device() to fix this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-hdmi: Fix refcount leak in imx_hdmi_probe
      commit: ed46731d8e86c8d65f5fc717671e1f1f6c3146d2

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
