Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDC59C49B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbiHVRGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiHVRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:06:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D5241D33
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:06:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id l1so15643969lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZeOAZdZ1yXvrhpvKyMHxQ22SxHwyD0iMdKanQBhxciM=;
        b=SV06XhiZ34abyfKHMPGCLESwF1jJ/D7wDFiHsP4gMcJpxxIUm0Du+uj/p7zs/Znp2h
         aFi4/kp0rzH+6uNv6jImDeAxzbpYnoX2tWx/wdWZfWX9ak7rGoGV/fTqARbchTIvtiMT
         COFjOJzRTIySYt08HgMcJCPCCsu0F59sSyqvWRVoRm8Lg+KJp+dcdVnU52RpU3I6/YXy
         i5jU4MkzqaqXH1tHnN56cOmTAh0WCCw1V/avRkB7saX5Jwk+pzZzrPCXSocR7FR684lE
         VuFCLslADfqU3rDvao3HBu9W3n0Rilzo+2038Q7LLhbFAGzxifR4raf8VF8Kr6RZ7nt9
         VW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZeOAZdZ1yXvrhpvKyMHxQ22SxHwyD0iMdKanQBhxciM=;
        b=a0hXMrqM5deR4WXM0LjXrT6fdivVXm0B0IHDdbhoQ9KSssF41Hi+Z2fcwGwSy4wmQt
         Vz1gn4M8hYXKwyWuUwMsKpwJSqM6t9efp2IVcEcxrWNNnx68D0aDbrZxzlUXaFHot9kh
         Z0DMoiKmOEhF351rIImAJ8SMjm3DIO0uBVLmenWW15vY+iYVeEW0Sl/ds/FkAXZ0X3F/
         tCoJP7iratW1UQAZsjiRCW8Q1GZxzmo/pZUU58gRs0eh3oHrG9K3CtS4kDnA+DiqD54d
         Uec98roCLQ6UQZjGgSSvFGrdhKxgKq3IOnJDuIh5hVGoI33cReaKwEm5oBVuiIRFgLw8
         SfaA==
X-Gm-Message-State: ACgBeo1s32IeySTO05oJBLcW4EL0nGfHa2kD9NTw0dll7RIB73CPqJka
        AkPvw6BUdXyYCHL65yAKSXM0DLUDVHafdP2OC3ztYQ==
X-Google-Smtp-Source: AA6agR4EmGcItOfTk/CWgl/iZqu4ysFcUq5qUh9eN7VnoNdQDE5dFY4pVHcynNxzLUX0r2KEZtmyymsRMpq01zDNfQo=
X-Received: by 2002:a05:6512:158b:b0:48b:38:cff8 with SMTP id
 bp11-20020a056512158b00b0048b0038cff8mr6949964lfb.100.1661187962925; Mon, 22
 Aug 2022 10:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <202208210645.72NkUj0g-lkp@intel.com>
In-Reply-To: <202208210645.72NkUj0g-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Aug 2022 10:05:50 -0700
Message-ID: <CAKwvOd=VD-Oxtko-tq=GjcLZg5tNj_cMZwMhw7NqBbOYLxuidA@mail.gmail.com>
Subject: Re: [linux-stable-rc:queue/4.14 13/175] Makefile:877: *** Recursive
 variable 'LDFLAGS' references itself (eventually). Stop.
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Sat, Aug 20, 2022 at 3:51 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.14
> head:   ed8a2f4d20af62ebd64e4092d988d4ae6b54657c
> commit: 17c47886b521ae64a733f41364def799797e45ef [13/175] Makefile: link with -z noexecstack --no-warn-rwx-segments
> config: arc-randconfig-r043-20220821 (https://download.01.org/0day-ci/archive/20220821/202208210645.72NkUj0g-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 7.5.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=17c47886b521ae64a733f41364def799797e45ef
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc queue/4.14
>         git checkout 17c47886b521ae64a733f41364def799797e45ef
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> Makefile:877: *** Recursive variable 'LDFLAGS' references itself (eventually).  Stop.

Thanks for the report!

That's not something that I've seen before...

Masahiro, does ARCH=arc do something special to LDFLAGS?

This report is a randconfig against a branch of stable for arc, so
guessing this might be more obscure than usual.

>
>
> vim +/LDFLAGS +877 Makefile
>
>    875
>    876  LDFLAGS += -z noexecstack
>  > 877  LDFLAGS += $(call ld-option,--no-warn-rwx-segments)
>    878
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Thanks,
~Nick Desaulniers
