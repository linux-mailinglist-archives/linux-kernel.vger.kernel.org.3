Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E534DA87A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbiCPCfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353403AbiCPCfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB6065BE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:32:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46FAF6149A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3CBC340E8;
        Wed, 16 Mar 2022 02:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647397940;
        bh=JlWuwsVAf8tixVVfAj7k3At1hsOc2H52eSxmDWkWpNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qi4zpYKrUUrbZLKM+Xl0nS5aG1eZ4vTX/qCHb5xZQd4h2K4CZaJPT1O3J8f4cuQmO
         ikj643PaI0do9JOx4U2u20nixZmCCxYuFzyRXN69OlhnqPurTuTfA9dQQW1ARw+Aol
         KrNmCKUUJhcFAdjc+xxLaBYPXIsPsze9agB9ApcFHB3/35FGDi8F3WHpVM3l1sIbw5
         RijlwULauuXFxRWs85GucfaVVoAI8vfxYmrlpklI3lk3kptoCMXwPZhbtiBcFUrXB9
         ykvLNpzHC1kX8zWNLMV3btNhs/7fH8zY80RnvNRhH9j6CWIaJi55cHaRMGGDpeUXRU
         7BCfWIauqWRBg==
Date:   Wed, 16 Mar 2022 10:32:16 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: mediatek: Fix error handling in
 mt8183_da7219_max98357_dev_probe
Message-ID: <YjFMMEniUVlb1QsX@google.com>
References: <Yia5XgkGyLbIRc1f@google.com>
 <20220316014059.19292-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316014059.19292-1-linmq006@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:40:57AM +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> This function only calls of_node_put() in the regular path.
> And it will cause refcount leak in error paths.
> Fix this by calling of_node_put() in error handling too.
> 
> Fixes: 5bdbe9771177 ("ASoC: mediatek: mt8183-da7219: use hdmi-codec")
> Fixes: ebbddc75bbe8 ("ASoC: Mediatek: MT8183: Add machine driver with DA7219")

Again, I am not sure if the Fixes tag makes sense.  Although the issue was
there when the driver birth, there are some more commits after then.

Given that:
- The patch is a minor fix (see [1][2]).
- There is no specific commit the patch aims to fix.
I prefer to drop the Fixes tags.  In any case, I don't think the tags would be
helpful.

I would defer to Mark.

[1]: https://elixir.bootlin.com/linux/v5.17-rc8/source/include/linux/of.h#L129
[2]: https://elixir.bootlin.com/linux/v5.17-rc8/source/drivers/of/Kconfig#L55

> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
