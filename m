Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FA559BCD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiHVJ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiHVJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:28:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C2412750;
        Mon, 22 Aug 2022 02:28:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n4so12397620wrp.10;
        Mon, 22 Aug 2022 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=LZiPZabk8uBgJRKOzhDJ2uC93G1aMkxBm+1//LLMvqw=;
        b=PpCeVcqMgILqQyzKcfm/hYQMiH5rJcmQtUa6hRVk7gORFWsMAM2eLp32v6iNcRPARn
         fsAkKZTs/7l5zKLu7ltMs1T/BZ5ZGFymB0XPU4Q+y0zBKGi1q/LoFDldlYrZL354K48/
         dTTuZPFwEoyiKuzStbwLcyQNTCvZUnIqnURkyotQO+xz5KeNVbRlCh9y0xRh6hqHpjyB
         R7VIFpAB70knHoCKjMHifSF9vovtTz7LBvXMpB4Djr0JBm98LGaAKUowFbNo7hMrzkWd
         l/bu3mEzm8qZoFWvCwQNw+SLYbKSyK0IyaIvnVsq0KYqo9jPcubYL8FXUg8GJieNuJvm
         NzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=LZiPZabk8uBgJRKOzhDJ2uC93G1aMkxBm+1//LLMvqw=;
        b=tJmHeJ1jP60wq9WJQMs802HbnMeo4zyVsjN2scwpUTei0p/X+sipL0lCLGoeqPI1ju
         8jNTH//zni/v1s9jqD+g56bBhQ+yTkwKcjL682IV9CiSwgkk/YXCnFtBzSgxWXPnRiex
         jbQ5+vQFbKvADJCdetTtOQX1ZTPLIFI7d4dvzGKrK/9srAZaL8mexKDX2zmKKAJVstUC
         OWsS9DU02XguZjNS9GDPhtJ4wluwj5i59E8/r0xjK5nBExl0m8QVCiipzGQWq6uDGPRX
         TkXM3M22pFNdhXGTgkjhfdSD+PLM52wNgU3ukKyi4XggPZgYx0OOa5+mSuxTIgAnIAxH
         38tw==
X-Gm-Message-State: ACgBeo2pUrpoHUuH+ggsVMgMLBRvKtYdoNa5wjYlVQgCxO1qkLVj8mKR
        tJB73qoo3b//mI1cM0dqjZA=
X-Google-Smtp-Source: AA6agR5TCN6tBlMC5N0TVpsdW5/8135kWB6j/OBUdEV/Us8d0j9b322vyx644RgsF8mNnzeqLXBAVA==
X-Received: by 2002:a05:6000:1acf:b0:222:cff7:3b6c with SMTP id i15-20020a0560001acf00b00222cff73b6cmr10285263wry.191.1661160532519;
        Mon, 22 Aug 2022 02:28:52 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b003a5ee64cc98sm19491518wmq.33.2022.08.22.02.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 02:28:51 -0700 (PDT)
Date:   Mon, 22 Aug 2022 10:28:50 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Matt Flax <flatmax@flatmax.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: build failure of next-20220822 due to 4e6bedd3c396 ("ASoC: codecs:
 add support for the TI SRC4392 codec")
Message-ID: <YwNMUlAmu/qCjuva@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of arm64 with clang failed to
build next-20220822 with the error:

sound/soc/codecs/src4xxx.c:280:3: error: variable 'd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
                default:
                ^~~~~~~
sound/soc/codecs/src4xxx.c:298:59: note: uninitialized use occurs here
                ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_11, d);
                                                                        ^
sound/soc/codecs/src4xxx.c:223:20: note: initialize the variable 'd' to silence this warning
        int val, pj, jd, d;
                          ^
                           = 0
sound/soc/codecs/src4xxx.c:280:3: error: variable 'jd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
                default:
                ^~~~~~~
sound/soc/codecs/src4xxx.c:293:59: note: uninitialized use occurs here
                ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_10, jd);
                                                                        ^~
sound/soc/codecs/src4xxx.c:223:17: note: initialize the variable 'jd' to silence this warning
        int val, pj, jd, d;
                       ^
                        = 0
sound/soc/codecs/src4xxx.c:280:3: error: variable 'pj' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
                default:
                ^~~~~~~
sound/soc/codecs/src4xxx.c:288:59: note: uninitialized use occurs here
                ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);
                                                                        ^~
sound/soc/codecs/src4xxx.c:223:13: note: initialize the variable 'pj' to silence this warning
        int val, pj, jd, d;
                   ^
                    = 0
3 errors generated.

git bisect pointed to 4e6bedd3c396 ("ASoC: codecs: add support for the TI SRC4392 codec").

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
