Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3655400DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245081AbiFGOLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245176AbiFGOLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B154DA0057
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FFBB6157B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DADCC385A5;
        Tue,  7 Jun 2022 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654611096;
        bh=cJyU+230aiz3hoabBrQP0N+I1Q926hj1jnMqC2WpPTo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Xaa7RW0UOlpXmuEQJCNVGyLHFldqiJn1YvEvkSSJk6FYeqT/mwPcEq/X2EkBkMNJE
         8/S6s++4kXiQjCJ1Ne17gp+hxWYyCGfssDyxcRBuHIeC8h3RaGilmktV6vbxSq28ev
         OF7gq/r3h2qCI21Ti/8jSz9fVzK6j6wcgivZtB0ywaQ1wt/camEcx/U9cLuekBQJOL
         ECCjBxtDCWbQtUyL1u5e4/WhBb2jlqVkTp1E717ZoAWaj3/PmkAPSmDLWaOEbATkXQ
         VKLVy34eecT3Ow6KS5uHK0Am9GjANeGZTNo6BlH4v0XoHceSmKtjMONamMyAm6OHUC
         4p5oLYP8cxiAw==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, akihiko.odaki@gmail.com, pc.liao@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        linux-mediatek@lists.infradead.org, tzungbi@google.com,
        koro.chen@mediatek.com, linux-kernel@vger.kernel.org,
        jiaxin.yu@mediatek.com, tiwai@suse.com, drinkcat@chromium.org,
        linmq006@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        matthias.bgg@gmail.com
In-Reply-To: <20220603124243.31358-1-linmq006@gmail.com>
References: <20220603124243.31358-1-linmq006@gmail.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8173-rt5650: Fix refcount leak in mt8173_rt5650_dev_probe
Message-Id: <165461109323.1597191.3939968146449868630.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 15:11:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 16:42:41 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Fix refcount leak in some error paths.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8173-rt5650: Fix refcount leak in mt8173_rt5650_dev_probe
      commit: efe2178d1a32492f99e7f1f2568eea5c88a85729

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
