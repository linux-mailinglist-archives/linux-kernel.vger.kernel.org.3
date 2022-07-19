Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3BE57A73F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiGSTdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiGSTdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:33:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6752545E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:33:06 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z23so29115045eju.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZJEcqzpDxUsMV047uEotdB5e23S3+dI1OnJ5Dw86hI=;
        b=RnXne9qFCWJP8CfvFDS57nwqFy6dIAM7iEBRrJzzK561MWgVks8YJ2IPMBQ4iyVL7r
         cpBMCqun7iPOK0wF1zg648E8IUwMEfJZbSmyvr5+XQom8GSfc8HDIj46B8O3cgU4wYET
         Lym20NGU7rTpDScpQe10reGkes4lyRNraHzMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZJEcqzpDxUsMV047uEotdB5e23S3+dI1OnJ5Dw86hI=;
        b=H3zWjac8zNSFgPiVjp+FH6bGPE//XLap0FHTVSAJm/a+YlOeTcOqKyJwm85+ATvsyx
         NusY82fRGmavLLsuW8Zhi5RfEyaJUGT76vCXwt4I9+n7nd+Z5SuSQax9bgZnW6QKGiKd
         zzKuFI2I+B4F4XKMimcJ5y7Rs3X3tnWMZK0wgL0E/HJH+IDMqE3qQHXVujw4hmmpV8P6
         OkCwc/3P5J7/vlmPRK1eanW0ximR1lgSC89LfsNZPBynPGU84g79IZ0on9n0UOHCVXAZ
         v3M0VOdDpvs4nP5Ar3Hcw0AUOYtvlXgDq+pjJvSlVh9Yl2GpXyHKlx0vl//Wlu4spPoA
         hf+A==
X-Gm-Message-State: AJIora+VOi6TQybjfnHo5/UypeQVhHoNwHulbfr7Sv9sj3YEE3S7/MVg
        ej26rSuDhAuGvWNNvKl46hFkQU1IZbhb2r6BDFE=
X-Google-Smtp-Source: AGRyM1vpEZlebRKQ4gG6pz5CxgJ1GaI3ERx7lKNfPvhtkyJSvw5HfWUSqoikv+zondWTRirT/6XrDg==
X-Received: by 2002:a17:907:8a28:b0:72e:cef6:eba0 with SMTP id sc40-20020a1709078a2800b0072ecef6eba0mr28586145ejc.765.1658259185372;
        Tue, 19 Jul 2022 12:33:05 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7cd4a000000b00437d3e6c4c7sm11011157edw.53.2022.07.19.12.33.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 12:33:05 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id z13so3522841wro.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:33:04 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr28517559wry.97.1658259184451; Tue, 19
 Jul 2022 12:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220719114714.247441733@linuxfoundation.org> <CA+G9fYsCL48P5zFMKUxoJ-1vwUJSWhcn17rUx=1rxOdzdw_Mmg@mail.gmail.com>
In-Reply-To: <CA+G9fYsCL48P5zFMKUxoJ-1vwUJSWhcn17rUx=1rxOdzdw_Mmg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Jul 2022 12:32:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjo-u8=yJQJQnaP41FkQw7we9A-zJH3UELx5x_1ynPDfw@mail.gmail.com>
Message-ID: <CAHk-=wjo-u8=yJQJQnaP41FkQw7we9A-zJH3UELx5x_1ynPDfw@mail.gmail.com>
Subject: Re: [PATCH 5.18 000/231] 5.18.13-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Slade Watkins <slade@sladewatkins.com>,
        John Harrison <John.C.Harrison@intel.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:57 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
>
> Details log:
> ------------
> 1. i386 build failures with clang-13 and clang-14
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
> ARCH=i386 CROSS_COMPILE=i686-linux-gnu- 'HOSTCC=sccache clang'
> 'CC=sccache clang'
> ld.lld: error: undefined symbol: __udivdi3

Looks like the one introduced by aff1e0b09b54 ("drm/i915/ttm: fix
sg_table construction"), and fixed by ced7866db39f ("drm/i915/ttm: fix
32b build").

> 2. Large number of build warnings on x86 with gcc-11,
> I do not see these build warnings on mainline,
..
> 'naked' return found in RETPOLINE build

Hmm. Does your cross-compiler support '-mfunction-return=thunk-extern'?

Your build does magic things with 'scripts/kconfig/merge_config.sh',
and I'm wondering if you perhaps end up enabling CONFIG_RETHUNK with a
compiler that doesn't actually support it, or something like that?

             Linus
