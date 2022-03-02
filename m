Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F824CAAFE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbiCBRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243586AbiCBRBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:01:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB24C3C30
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:01:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3B2EB82105
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48857C004E1;
        Wed,  2 Mar 2022 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240458;
        bh=MfDFBAyKZO8R+BnzZBCZPZLZ/sz34eRmK3kYoi78u3o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BJEjh3bLaS0dc3swhCdMxhIdLYODlOvGEs+1zBqVQ66qi9Mm/2WTNmeQzSPNrhFSr
         AeTlcYCPQ8RNTiSosUZC1IMQo7OmBGx1kF/tsPql49/54EDMrqy8wvsUcsZetY6GWV
         J9e+NqS0KMk7Ay52HsWjIISnnET1ESiSUNKdt8FExVSTcDoZCEQ1Un0qiYMgTZXSYn
         JqDrP34bw5nqSR15kdNT3WwShZHLPjTWBQ71RAtiuvBNWKravnJ5jTPYWdikHuHlFI
         emsY10enmP7yUxRTuyEwsr8D3EKoiJOVUw6I3zRGgy6iOd7O78o2Pe5tntsg0E9v/9
         JcdklurEh2jOg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <1634285633-529368-1-git-send-email-jiasheng@iscas.ac.cn>
References: <1634285633-529368-1-git-send-email-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v2] ASoC: soc-compress: prevent the potentially use of null pointer
Message-Id: <164624045702.1145067.14385834637074739247.b4-ty@kernel.org>
Date:   Wed, 02 Mar 2022 17:00:57 +0000
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

On Fri, 15 Oct 2021 08:13:53 +0000, Jiasheng Jiang wrote:
> There is one call trace that snd_soc_register_card()
> ->snd_soc_bind_card()->soc_init_pcm_runtime()
> ->snd_soc_dai_compress_new()->snd_soc_new_compress().
> In the trace the 'codec_dai' transfers from card->dai_link,
> and we can see from the snd_soc_add_pcm_runtime() in
> snd_soc_bind_card() that, if value of card->dai_link->num_codecs
> is 0, then 'codec_dai' could be null pointer caused
> by index out of bound in 'asoc_rtd_to_codec(rtd, 0)'.
> And snd_soc_register_card() is called by various platforms.
> Therefore, it is better to add the check in the case of misusing.
> And because 'cpu_dai' has already checked in soc_init_pcm_runtime(),
> there is no need to check again.
> Adding the check as follow, then if 'codec_dai' is null,
> snd_soc_new_compress() will not pass through the check
> 'if (playback + capture != 1)', avoiding the leftover use of
> 'codec_dai'.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-compress: prevent the potentially use of null pointer
      commit: de2c6f98817fa5decb9b7d3b3a8a3ab864c10588

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
