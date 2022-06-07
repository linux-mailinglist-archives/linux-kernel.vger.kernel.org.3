Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A753FBC8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbiFGKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbiFGKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CED7ED734
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1275AB81F05
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34022C34119;
        Tue,  7 Jun 2022 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598737;
        bh=VWwzCqMXrN/G0KyRMlKG4MamL4lgLmSXarbHCk4VCkA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bgS3geV/mOzLet2UKYeM0PnA/8Xmll1Djy9ySD6xUZ+i+sR+WpVZIRkahpn4Mdo3a
         cAVRmDT8n0CigHgEDKNvLHkjsKiyPEfpZpcU8fiFLH7hpICXKUuN7nBOjWWLFad4WN
         vFSY+y9Ps3+fRN5sYJDjizcz4ZzDPaZ5WywyI04soPjf3ZGC7vqha5YhOXLRQ7oXwG
         kV1sr8hQhJBN0TmyFAbM40CAl9smif3NBJN95EVkB6vv1l95KimNOB7a0ZRG4J9pYC
         w8DPldUPG9BzMsBMP7GONGRUZqdsZQjPveFamdbhT+BJa5TdPsWIpRu1tQN5Ym7Qgz
         mH9BBfKjcaFxg==
From:   Mark Brown <broonie@kernel.org>
To:     rdunlap@infradead.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        lkp@intel.com, steve.lee.analog@gmail.com,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
In-Reply-To: <20220605163123.23537-1-rdunlap@infradead.org>
References: <20220605163123.23537-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: max98390: use linux/gpio/consumer.h to fix build
Message-Id: <165459873591.301808.2566417791038246308.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:35 +0100
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

On Sun, 5 Jun 2022 09:31:23 -0700, Randy Dunlap wrote:
> Change the header file to fix build errors in max98390.c:
> 
> ../sound/soc/codecs/max98390.c: In function 'max98390_i2c_probe':
> ../sound/soc/codecs/max98390.c:1076:22: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
>  1076 |         reset_gpio = devm_gpiod_get_optional(&i2c->dev,
> ../sound/soc/codecs/max98390.c:1077:55: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function); did you mean 'GPIOF_INIT_HIGH'?
>  1077 |                                              "reset", GPIOD_OUT_HIGH);
> ../sound/soc/codecs/max98390.c:1077:55: note: each undeclared identifier is reported only once for each function it appears in
> ../sound/soc/codecs/max98390.c:1083:17: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
>  1083 |                 gpiod_set_value_cansleep(reset_gpio, 0);
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98390: use linux/gpio/consumer.h to fix build
      commit: aa7407f807b250eca7697e5fe9a699bc6c2fab71

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
