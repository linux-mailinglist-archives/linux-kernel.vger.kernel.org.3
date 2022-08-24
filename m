Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342CB59F86C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiHXLMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbiHXLMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:12:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91DD67CA9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B406B823AC
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FDCC433D7;
        Wed, 24 Aug 2022 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661339551;
        bh=0jQSAV+e3DFpfOT8Uw+ldmXyihIQw4KJzWHoCN/nq/I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HemH+J2+CHNXyNDfyzK+72NI/FKUv8yMkZzWvDC9kgRfsQu9d/8Kuuuiq/cH/hHkw
         3G5oaRIGJZ+iO6BYj8tyHXzMmuJF2OuzZHLcrHmJ4yJW5iQIYpXdpkncT4pijcfKDJ
         wF60ZLLUCWVUAhp0zqjlr4fVW7Bh3gN0ZtJZIMQO+CumUt69dQpEoLf79JKq2lWWYO
         +vIhABC9ACC9FaPvV2wf/QWdLAd78w16aDQgSipv+/n7Fg7P1yr5B97CE6/VG+6a/W
         LtEEAfzpYy+hBY6OkBcCr+Ncfe2gqEkyIHAagiwwwvu8H6t6R34NlHTMm9t+j7Tz61
         u5LUb3K63sRSQ==
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matt Flax <flatmax@flatmax.com>
Cc:     patches@lists.linux.dev, alsa-devel@alsa-project.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
In-Reply-To: <20220823151939.2493697-1-nathan@kernel.org>
References: <20220823151939.2493697-1-nathan@kernel.org>
Subject: Re: [PATCH v2] ASoC: codes: src4xxx: Avoid clang -Wsometimes-uninitialized in src4xxx_hw_params()
Message-Id: <166133954873.17904.8458082648861330231.b4-ty@kernel.org>
Date:   Wed, 24 Aug 2022 12:12:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 08:19:40 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   sound/soc/codecs/src4xxx.c:280:3: error: variable 'd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>                   default:
>                   ^~~~~~~
>   sound/soc/codecs/src4xxx.c:298:59: note: uninitialized use occurs here
>                   ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_11, d);
>                                                                           ^
>   sound/soc/codecs/src4xxx.c:223:20: note: initialize the variable 'd' to silence this warning
>           int val, pj, jd, d;
>                             ^
>                             = 0
>   sound/soc/codecs/src4xxx.c:280:3: error: variable 'jd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>                   default:
>                   ^~~~~~~
>   sound/soc/codecs/src4xxx.c:293:59: note: uninitialized use occurs here
>                   ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_10, jd);
>                                                                           ^~
>   sound/soc/codecs/src4xxx.c:223:17: note: initialize the variable 'jd' to silence this warning
>           int val, pj, jd, d;
>                         ^
>                           = 0
>   sound/soc/codecs/src4xxx.c:280:3: error: variable 'pj' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>                   default:
>                   ^~~~~~~
>   sound/soc/codecs/src4xxx.c:288:59: note: uninitialized use occurs here
>                   ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);
>                                                                           ^~
>   sound/soc/codecs/src4xxx.c:223:13: note: initialize the variable 'pj' to silence this warning
>           int val, pj, jd, d;
>                     ^
>                       = 0
>   3 errors generated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codes: src4xxx: Avoid clang -Wsometimes-uninitialized in src4xxx_hw_params()
      commit: 7d3ac70d82080f7a934402d66c5238e1d99be412

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
