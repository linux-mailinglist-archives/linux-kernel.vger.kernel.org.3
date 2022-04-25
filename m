Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEDF50E74A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbiDYR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbiDYR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606B840E74
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09103B81928
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CA7C385A4;
        Mon, 25 Apr 2022 17:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907464;
        bh=tJnkeRG9BIqZLpOKq/h7T9aOg9jlOc0o6WxzFD5dKrc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gCPqIbvbWYsMjXDO3Jxj9fu+yo9WsrIYr+rDqr6m3ZH4J/33ONKiTFrhd8Y/81qpT
         b4HRnfwEvC/I7CnztsnbeYU7PmyH8aCmfrkBTDN8Fn+STF3ajXwxZkt2zGsq3IfJOy
         ZtJ77/AFvq4SV6Tk/pHAuXh3bCcVnasZAiBTf62I/1UsouQE+HEms66BGheeFOk3UZ
         rQPIMET9t57/vZZTceLfAvfm8DT+WB2HnsR+5wN1LTf8YKeoIgf7hmGegzzJb8aAqc
         eOGqRPNQC3IzCUN5vk729AjhQqSFRaco6jZmJUJp/YbVrSsnP1BGH9jvORg5SLb0yl
         pmRtyv6bQF2uQ==
From:   Mark Brown <broonie@kernel.org>
To:     rf@opensource.cirrus.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220425095159.3044527-1-rf@opensource.cirrus.com>
References: <20220425095159.3044527-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cirrus: cs_dsp: Avoid padding bytes in cs_dsp_coeff_ctl
Message-Id: <165090746356.583823.11843544325300863784.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 10:51:59 +0100, Richard Fitzgerald wrote:
> Change the order of members in struct cs_dsp_coeff_ctl to avoid
> the compiler having to insert alignment padding bytes. On a x86_64
> build this saves 16 bytes per control.
> 
> - Pointers are collected to the top of the struct (with the exception of
>   priv, as noted below), so that they are inherently aligned.
> - The set and enable bitflags are placed together so they can be merged.
> - priv is placed at the end of the struct - it is for use by the
>   client so it is helpful to make it stand out, and since the compiler
>   will always pad the struct size to an alignment multiple putting a
>   pointer last won't introduce any more padding.
> - struct cs_dsp_alg_region is placed at the end, right before priv, for
>   the same reasoning as priv.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cirrus: cs_dsp: Avoid padding bytes in cs_dsp_coeff_ctl
      commit: 430c3500995484962bdbccf358201afef8055535

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
