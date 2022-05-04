Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1B551ACDC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355683AbiEDSfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377485AbiEDSeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A1EF205F4
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651688050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C0zlJgjvydDgnPqcmveoCO3N//MvSRzCyDmJy5zb+no=;
        b=cGC3CyTHbdbdffS1L49YKDJCZvURDKmJdih5jvMF3llPBFy2Hy4mid0o/xi2L3tqvuWYkl
        B5epjUIyRMMNjHwdsDf8NxxDTogTwahaX/I1bhHLyYh7s965Z2IRMxReoUtWiV98EJztR+
        Aa0aVenSRZxEK52vw3KZEeslcaI/n9g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240--jsXMVQPMX-3zUCI-AEshA-1; Wed, 04 May 2022 14:14:09 -0400
X-MC-Unique: -jsXMVQPMX-3zUCI-AEshA-1
Received: by mail-ed1-f72.google.com with SMTP id s29-20020a50ab1d000000b00427e495f00cso1199757edc.14
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0zlJgjvydDgnPqcmveoCO3N//MvSRzCyDmJy5zb+no=;
        b=410oP031uDfGL9KCGC16XhautRimLJpyiF09x+TJVeJA+fBsiG9jdQBt1dOBPpnbfA
         AdPVUkQgZVhzrb3Dt50R85LRiNTF0bgZr/W8Q0Jm8c8YZwtoczpTZQ4xEzHZP4Y3jeVD
         5ACSxvGzY9Je9dUa9Mb5BAnWj48SYJ6xJVJhhsJ6LOcvgPKgQuqUKXCrHRBhF2FHZbdK
         JrQx2YZpbhveq7dCX8Ug9eZfu4eGlLyKFfNn+irJz+exRozKfgeX1wnM9zqjJUdSmWv/
         mhQIX87WYgaStbGGforidHgpLXbCSfuyp33ivDF3zvvDLOnoWUMBm8ftNWUasaBVd4sO
         OhxA==
X-Gm-Message-State: AOAM532cidRfETMu6mC7uYYIew+wBxMDECS/dWNbfkdmG8304MO7ItBv
        ximfhKL1IQ4hNGWvZUxfnX+w5umlNmMC5eODgN0uuovl6Iv37MvdEaLhsJp7HkX7chvBYdQyd/n
        dXukiDdX15KL1rc7tGr2qdzrGuwXf69mxS0Gt/Gbv
X-Received: by 2002:a05:6402:948:b0:425:ea37:96b8 with SMTP id h8-20020a056402094800b00425ea3796b8mr24153858edz.90.1651688047934;
        Wed, 04 May 2022 11:14:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTEBfb0ryOK/vx4ajvgOHhhpmbxc2K498YISD/TH1LmEO3NLmXijjaZhnJxBKsoUMIv486HQKaYcLmJx8MkqI=
X-Received: by 2002:a05:6402:948:b0:425:ea37:96b8 with SMTP id
 h8-20020a056402094800b00425ea3796b8mr24153831edz.90.1651688047690; Wed, 04
 May 2022 11:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <202205020637.JVJo3blw-lkp@intel.com> <YnK8f7cqMoHxSi0C@dev-arch.thelio-3990X>
In-Reply-To: <YnK8f7cqMoHxSi0C@dev-arch.thelio-3990X>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 4 May 2022 15:13:56 -0300
Message-ID: <CAJ6HWG5P6LXEY80tcXxtfvnPnhiNcqUvV+xyKygLbcw37UFvyw@mail.gmail.com>
Subject: Re: ld.lld: error: inline assembly requires more registers than
 available at line 523
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 2:55 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, May 02, 2022 at 06:29:38AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
> > commit: ba1f77c546966c12d86220d078e5838dcaeab348 x86/kvm: Fix compilation warning in non-x86_64 builds
> > date:   2 months ago
> > config: i386-randconfig-a012-20220502 (https://download.01.org/0day-ci/archive/20220502/202205020637.JVJo3blw-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba1f77c546966c12d86220d078e5838dcaeab348
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout ba1f77c546966c12d86220d078e5838dcaeab348
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> ld.lld: error: inline assembly requires more registers than available at line 523
> > >> ld.lld: error: inline assembly requires more registers than available at line 523
> >
>
> I don't think this bisection result is correct; this error is visible at
> v5.17-rc3, which this commit is based on. This is likely the same root
> cause as https://github.com/ClangBuiltLinux/linux/issues/1589, just with
> LTO. I'll reduce something down and comment there if it turns out to be
> different.
>
> Cheers,
> Nathan
>

Hello Nathan,
I went down on this issue, but I have no idea how to proceed. These
are my findings:
- This commit (ba1f77c546966c12d86220d078e5838dcaeab348) fixes the
build, thus allowing this error to happen later (in LTO stage)
- The commit that introduced this issue was 69d0db01e210, due to removing :
   ubsan-cflags-$(CONFIG_UBSAN_OBJECT_SIZE)       += -fsanitize=object-size
- Only by having this flag enabled in ubsan-cflags-y on
torvalds/master causes the build to succeed

At this point, given the commit message in 69d0db01e210 I was thinking
of finding & fixing the code that causes the ld.lld error to happen,
but I was lacking the skills to extract any filename from LTO step.

But it's also possible to create a patch just adding
'ubsan-cflags-$(CONFIG_SOMETHING)      += -fsanitize=object-size'
and fix this build.

What would you suggest?

Best regards,
Leo

