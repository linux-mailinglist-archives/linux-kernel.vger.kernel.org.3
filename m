Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B21F59C439
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiHVQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiHVQe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:34:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F1419A3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:34:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d8so3667064lfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2vQSeG17lzwccuXXheDklfdz+rvEzFZchuxcxOfWA70=;
        b=QS+1k7+PE+rePGoe9S3/Sv5bzXx+MhKRdXlXZFyr/Fbt5c6Cz9Zaanza+Ak1wKazBk
         m/rIfz7sa8ff2z4xpc0om5KqeFWYh/69V8JYMeB2GHSkRL7O9KD8hncg+smlKcyWWVPT
         MqFz/Ce4uMUr1qiCsX2rfd2wEeDM899inOCWguVFSAHBHudGjIfswLuaL70NbPhh6wak
         eStexTI6QP7EpgiA3CHeM8D1rfdZiMDqMUNmbiNeMo+s5hO0ktzSywOJxF751Wa/eKMR
         do7TXBX3bO0L16iRgPQ1jbgVrKwlcLIreT0U2UkFsZhZ5rRebQfMNqFHxKluHLm67odY
         uBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2vQSeG17lzwccuXXheDklfdz+rvEzFZchuxcxOfWA70=;
        b=krBHWpArmxPQoAcA8J3nO1CCIzF7MS9YPv02idzb4w/7Ei6AdmxDhztM2A4yvKFfqW
         XKwNcxapFDBDmHeEAUegGYayd+sfBFH3N+wb0vpbHpFJEGzkyOXqEQ03gToJqn3N7PIF
         S2Bsd4OIyG/n6/cp8gtz41roljbTikInqDDBDxP33HakfkWtDWDYYhKJPMa2y4Bc3lZL
         Nie2NmNshzca5OF70f0BJ86RGTSaMZHS1ZNlMhzaJ9OF3jzUam8dCgZu1F8+3i6tYepK
         ijxN9Ww+emAxnKtHcw9SPaLn1v5aYfO0qXdFgFok4HkDlz1mV7zzn1eAA2S9TqD7IogY
         eVcA==
X-Gm-Message-State: ACgBeo3ooQpeamEvSsAKm32ludtMX+Zqw986ZM1jFcQWohXhhK1OheJD
        ws2D0w7fzsxWmlja3xR1VQsWcqHCcUpB10x/vze8Pg==
X-Google-Smtp-Source: AA6agR5wdEQEK+Retm/u5BnbwMryz3pxZ3P0il+KFDxb5lpW/sWxxXD0EVQECkE4rzxIJGgJ1jK/jYaZzrJSAyb58/M=
X-Received: by 2002:a05:6512:2356:b0:492:e06d:7530 with SMTP id
 p22-20020a056512235600b00492e06d7530mr2582685lfu.103.1661186062033; Mon, 22
 Aug 2022 09:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <YwNMUlAmu/qCjuva@debian>
In-Reply-To: <YwNMUlAmu/qCjuva@debian>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Aug 2022 09:34:09 -0700
Message-ID: <CAKwvOd=9ozTdeYDWzY0i-hrD4Vew5qPAcamx6wo_Y7PA+nCYBA@mail.gmail.com>
Subject: Re: build failure of next-20220822 due to 4e6bedd3c396 ("ASoC:
 codecs: add support for the TI SRC4392 codec")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Matt Flax <flatmax@flatmax.com>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 2:28 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> Not sure if it has been reported,

Hi Sudip,
Thanks for the report.  Two ways you can check if it's already been reported:
1. Check our issue tracker
(https://github.com/ClangBuiltLinux/linux/issues), you'll see that it
has been (https://github.com/ClangBuiltLinux/linux/issues/1691 ->
https://lore.kernel.org/all/YvvbKry5FVFbNdcI@dev-arch.thelio-3990X/)
2. Search for the warning message on lore.
(https://lore.kernel.org/all/ -> search for
"sound/soc/codecs/src4xxx.c Wsometimes" ->
https://lore.kernel.org/all/?q=sound%2Fsoc%2Fcodecs%2Fsrc4xxx.c+Wsometimes
and you'll see two reports from bots and two from humans).

> builds of arm64 with clang failed to
> build next-20220822 with the error:
>
> sound/soc/codecs/src4xxx.c:280:3: error: variable 'd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>                 default:
>                 ^~~~~~~


-- 
Thanks,
~Nick Desaulniers
