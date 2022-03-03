Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44174CBEED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiCCNeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiCCNeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:34:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A856858E6A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:33:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 54D53CE26C8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C6AC340ED;
        Thu,  3 Mar 2022 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646314393;
        bh=Ei0hkSjteYCI4Mye6PPB4xKcN0OiLDypiHdbTkPJbMk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bV1p3W54n9fe12HXoG10azO3Qv2wZbJA2N4wQZyQG5F4/vw+ZZU4bslukFSK7TNZS
         xxRw1IZO560DhSeGmta+18G8k9UrQLG6v9PLuvtIAzpIfdeKI49q7lfkl6TaIdQzSJ
         AwGD7NvD6gb5A0JqWZaIAewbVhp2sE1L+aeHvD/yUn8mrWYwrEE0++rRzbVnwzZwnl
         PbFWddyGcJ/52+2c6CevUJRGj/V4qNbFu39N/ZOH+fQFDLAYpk4c5siHOX6QFOU99e
         Mm6cVy/xqOUS1xBVJy3t/sYvs7PYEaUv0DeAPUKSwXkiz49wA5UKCqm/YJmVKxiAAP
         +OFiCePFaTVGA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Meng Tang <tangmeng@uniontech.com>,
        lgirdwood@gmail.com, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220302094351.3487-1-tangmeng@uniontech.com>
References: <20220302094351.3487-1-tangmeng@uniontech.com>
Subject: Re: [PATCH] ASoC: hdac_hda: Avoid unexpected match when pcm_name is "Analog"
Message-Id: <164631439115.1870788.3267235264627671548.b4-ty@kernel.org>
Date:   Thu, 03 Mar 2022 13:33:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 17:43:51 +0800, Meng Tang wrote:
> pcm name can be "Analog" and "Alt Analog", cpcm->name can be
> "Analog Codec DAI" and "Alt Analog Codec DAI". When pcm_name
> is "Analog", "Analog Codec DAI" and "Alt Analog Codec DAI" are
> both satisfy the 'if (strstr(cpcm->name, pcm_name))' condition,
> which may cause the returned cpcm to be "Alt Analog Codec DAI".
> 
> Even if we get the pcm name by id, and "Analog Codec DAI" goes
> into the loop before "Alt Analog Codec DAI", but I still think
> we'd better have multiple insurances against unexpected return
> values. After, we can correctly return the expected result
> even if other relevant places are changed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdac_hda: Avoid unexpected match when pcm_name is "Analog"
      commit: e94769900f4302b4034945e5d9ec8262a2f5e086

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
