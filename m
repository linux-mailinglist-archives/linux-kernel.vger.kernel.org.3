Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5997E4DB978
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357995AbiCPUh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358014AbiCPUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:37:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9261E66AE8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:36:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E080B81D48
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CE3C340EC;
        Wed, 16 Mar 2022 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462962;
        bh=ckBpUYs7lGZ5xVv8erHYOiifWXqrkP05DbKl6A1MzhM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=JlAvFFQ614+Y/9z+uHoovLZ2D34RImM7vhHicpisrn9mUPgCs9dCoMeHHKvh16Bu/
         DkENs9F6KIeRQE3xK6lpuU3jupIggS3otE8qqEkaGREzYqXv7w6QvSjVzuixD9LSnn
         IJTyofcFBkLLVJ/qbQn/vab/ZPvr65w4lLKBSINAtFORVtwofyzJuU+BQ1Sk9STkBf
         QFBbQOXVKU4KKanwvPOJrHRCQ6FmRvK5+WEHgkC8ZhY8hcRcCLHb3O2N9R3jVcw2LI
         LRjolW9TpyjYCVjyKy6Mzi6VBL9liP3znV7LQiWMci4I3gpL+/pGmRtdbaMm2Hl2Uw
         Q855HmIPnIyyw==
From:   Mark Brown <broonie@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        YC Hung <yc.hung@mediatek.com>, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220316084623.24238-1-linmq006@gmail.com>
References: <20220316084623.24238-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Fix error handling in mt8195_mt6359_rt1019_rt5682_dev_probe
Message-Id: <164746295912.1220201.14496447901680691673.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:35:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 08:46:15 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error path.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Fix error handling in mt8195_mt6359_rt1019_rt5682_dev_probe
      commit: c4b7174fe5bb875a09a78674a14a1589d1a672f3

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
