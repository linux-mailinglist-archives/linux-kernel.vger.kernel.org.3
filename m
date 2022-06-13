Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECF6549C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbiFMS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345578AbiFMS61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E34F29817;
        Mon, 13 Jun 2022 09:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1339261523;
        Mon, 13 Jun 2022 16:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25DAC3411C;
        Mon, 13 Jun 2022 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655136477;
        bh=tfjRnPB5emG2L4Jef72rHm8N5OHicWHsvAUn6VvcjmU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=l+BRpCEHp3ZqrvfTlaeybd8XxUuh/8/GU9hy6eiahvhAHgcL/QTzRyoYO8E+R5tqE
         wrpFVFCuARhQpYHkb5Q3zKEoSAdxJxrPuQYh2z1q60zpIMi54eWvaoQE7jUKrpev02
         ffBgOfSEruQveZSVakIoLHFndG78oxdVJno+ePJ1bpTiEhaX4yCW6/MBmN/dmGvcZ7
         uwxh00lYIA6r6kscLMo+gdo0KLjz/rQ3EUZUvjDl0hc4H8CbItrI43i8mxwIAh5Q0i
         ts/PEyjmhyKlRo8i9vsLkEycPp/90b9hUl1omsy+bXOJyfAFz1ASXdVAW7ufEK1MDR
         FdipfA0UvuPHQ==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, yassine.oudjana@gmail.com, lgirdwood@gmail.com,
        srinivas.kandagatla@linaro.org, tiwai@suse.com
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        y.oudjana@protonmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220606152226.149164-1-y.oudjana@protonmail.com>
References: <20220606152226.149164-1-y.oudjana@protonmail.com>
Subject: Re: [PATCH] ASoC: wcd9335: Remove RX channel from old list before adding it to a new one
Message-Id: <165513647538.514792.3755540877211595484.b4-ty@kernel.org>
Date:   Mon, 13 Jun 2022 17:07:55 +0100
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

On Mon, 6 Jun 2022 19:22:26 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Currently in slim_rx_mux_put, an RX channel gets added to a new list
> even if it is already in one. This can mess up links and make either
> it, the new list head, or both, get linked to the wrong entries.
> This can cause an entry to link to itself which in turn ends up
> making list_for_each_entry in other functions loop infinitely.
> To avoid issues, always remove the RX channel from any list it's in
> before adding it to a new list.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335: Remove RX channel from old list before adding it to a new one
      commit: 7263fc6c71c3a88c17a1ce3565b7b6f378d13878

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
