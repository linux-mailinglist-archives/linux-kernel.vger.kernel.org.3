Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753C0525291
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356424AbiELQb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbiELQbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:31:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB00C63393
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D235B829AF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841E7C34100;
        Thu, 12 May 2022 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652373112;
        bh=xh0dzvzjouPjkfWDaavilhb4zB9wsz2ZUVj1FOb1X4Q=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=h73JvsOLfTfwsA0mGsIfgLLc0a2lK2kMgdDflt+e/UFhtrn6msq+/4nz8OyqyxU8/
         dW5dndF7q+MbSPg479IG8fb2jyArWU30mEsVHZjRW72JE+RbbDp6wBPeWUKtX0Rj+s
         pxK+/r0wuKp4+0sSeZQxmcgYqRAddwCvb9EWqsWNxra6wXqXwG+7HyiYnZycZGaLiv
         5gWOnASCPSVFPSx1o7+SG5POZMjqWPozfeBDpANCO/cNIfLE0tjowuuzyexh/rEno0
         jCwHkavFEW/SH7Ua0mgvzPK7ySxIqK7DmeJBGI92ub7sg/8SCXMxtGyEEZzMe3Fwxi
         6ExAVwM2iFZfA==
From:   Mark Brown <broonie@kernel.org>
To:     linmq006@gmail.com, Takashi Iwai <tiwai@suse.com>,
        lgirdwood@gmail.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, s.nawrocki@samsung.com,
        alsa-devel@alsa-project.org, xc-racer2@live.ca, perex@perex.cz
In-Reply-To: <20220512043828.496-1-linmq006@gmail.com>
References: <20220512043828.496-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: samsung: Fix refcount leak in aries_audio_probe
Message-Id: <165237311026.1053236.8801361926991753274.b4-ty@kernel.org>
Date:   Thu, 12 May 2022 17:31:50 +0100
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

On Thu, 12 May 2022 08:38:28 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> If extcon_find_edev_by_node() fails, it doesn't call of_node_put()
> Calling of_node_put() after extcon_find_edev_by_node() to fix this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: Fix refcount leak in aries_audio_probe
      commit: bf4a9b2467b775717d0e9034ad916888e19713a3

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
