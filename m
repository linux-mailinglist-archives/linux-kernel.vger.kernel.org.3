Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA55AC8BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiIECRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiIECRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:17:51 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B0D6472;
        Sun,  4 Sep 2022 19:17:49 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2852HOZK016501;
        Mon, 5 Sep 2022 11:17:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2852HOZK016501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662344245;
        bh=N9ZMoFBzL/HSLiz2YY5nJ5r4hHtleAVA1hzG2kvT8lQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gsCLNKxmBJPwyrnSt7B6jp5tvElRsfwOegejUL3aYCL0uJt/BZCEPh9SVLe31lvsz
         YM96HgdEwj2XPnDOwEfnpviz4iWdbMsTwF4tsIKSTkEiVVTewz6xSmuU2F8GBUoL+7
         5VBQeOXNIyNDWAxUmO0FbiOnjjLC/QLxLpq7BJVO58RqkAzpjH336ago4Mjl3pC1Ac
         173k+fIJjPADuLPSdttXun4ycG95+YZEg92IPwLWQrJoGBx2K8HVdqzA6ijoLP5Eic
         pXV0EQQiY1JoYRZO9GEhqhl+BghVOTi6QNWWvqa7IFqyEhTtMLOXKcoMJCtfGumG1s
         rHRp/TEmFpbyA==
X-Nifty-SrcIP: [209.85.160.44]
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1274ec87ad5so3651339fac.0;
        Sun, 04 Sep 2022 19:17:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo1vuwHHE4IVcgLpplpjyNxPy6yujqPgO7QEkyXMk8J40basbiMc
        7Ijjz3plSnv5E8b4ghq7EOTbD7YtxRE8h2/fK9s=
X-Google-Smtp-Source: AA6agR5LPaJmDqc2/WhMMW4ZJoy78YggKnyDMRUvUEKHqD3L6Afv7DSBXQavaI4loufCnW3pnLVZhc4aPn13RD7srVA=
X-Received: by 2002:a05:6808:2099:b0:343:49f5:5300 with SMTP id
 s25-20020a056808209900b0034349f55300mr6430170oiw.287.1662344244204; Sun, 04
 Sep 2022 19:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <YjpLiKRUIB4TGJm0@zn.tnic> <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjsCpoRK7W4l6tSh@zn.tnic> <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com> <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
 <YkC08gKqJOUM7CA8@gmail.com> <YkHXQTKImf7Wr+Sk@dev-arch.thelio-3990X>
 <YxHD1MkulyL3yB9y@gmail.com> <CAK7LNASyp8SzO3G+th5RgmRNBM_ryKuy0XzaMrdUdo8Sd6RR0A@mail.gmail.com>
 <YxR0UlS0Jpz9uqb7@gmail.com>
In-Reply-To: <YxR0UlS0Jpz9uqb7@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 5 Sep 2022 11:16:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnGO3LHZ7VvJRziDqz50gRq7MUJPOJLMfcv=pCiA=-mg@mail.gmail.com>
Message-ID: <CAK7LNATnGO3LHZ7VvJRziDqz50gRq7MUJPOJLMfcv=pCiA=-mg@mail.gmail.com>
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022 at 6:48 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > > Unfortunately, even without the ARCH=i386 'make savedefconfig' doesn't
> > > seem to be doing the right thing & is dropping the '# CONFIG_64BIT is
> > > not set' line:
> >
> >
> > Oh, really?
> >
> > Without ARCH=i386, it works correctly for me.
> >
> >
> >
> > masahiro@zoe:~/ref/linux$ make i386_defconfig savedefconfig
> > #
> > # No change to .config
> > #
> > masahiro@zoe:~/ref/linux$ grep CONFIG_64BIT defconfig
> > # CONFIG_64BIT is not set
>
> Yeah, so why do these two seemingly identical commands produce two
> different .config's:
>
>   $ make ARCH=i386 defconfig
>   *** Default configuration is based on 'i386_defconfig'
>
>   $ make i386_defconfig
>
> ?





As Nathan explained in this thread,
the prompt of CONFIG_64BIT is hidden
when ARCH=i386.


config 64BIT
        bool "64-bit kernel" if "$(ARCH)" = "x86"
        default "$(ARCH)" != "i386"
        help
          Say yes to build a 64-bit kernel - formerly known as x86_64
          Say no to build a 32-bit kernel - formerly known as i386




[1] "make ARCH=i386 defconfig"

ARCH is i386, so the Kconfig snippet becomes as follows:


  config 64BIT
          bool
          default n




[2] "make i386_defconfig"


ARCH is x86, so the Kconfig snippet becomes as follows:


  config 64BIT
          bool "64-bit kernel"
          default y







"# ... is not set" is output when
the prompt is visible and the user did not enable it.












> Basically the canonical way to generate a defconfig is to provide an ARCH,
> then use the common 'defconfig' target:



I do not know what you mean by "canonical", but
there are only 3 architectures (x86, sparc, sh) that
allow two ways for configuration.

This is somewhat related to a historical reason
(commit 8c4d9b145ba3 mentioned this a little).

After arch/i386/ and arch/x86_64/ were merged into arch/x86,
ARCH=i386 and ARCH=x86_64 became a subset of ARCH=x86.






>
>    make ARCH=i386      defconfig
>    make ARCH=x86       defconfig
>    make ARCH=arm       defconfig
>    make ARCH=arm64     defconfig
>    make ARCH=powerpc   defconfig
>    make ARCH=s390      defconfig
>    make ARCH=sparc     defconfig
>    make ARCH=sparc64   defconfig
>    ...
>
> This is what my build test scripts are using to quick-test cross-arch
> builds. It's a straightforward way to generate defconfigs without knowing
> the details of the myriads of random defconfig targets some architectures
> have, such as:
>
>   kepler:~/tip> ls arch/arm/configs/
>   am200epdkit_defconfig     gemini_defconfig         multi_v5_defconfig    s5pv210_defconfig
>   aspeed_g4_defconfig       h3600_defconfig          multi_v7_defconfig    sama5_defconfig
>   aspeed_g5_defconfig       h5000_defconfig          mv78xx0_defconfig     sama7_defconfig
>   assabet_defconfig         hackkit_defconfig        mvebu_v5_defconfig    shannon_defconfig
>   at91_dt_defconfig         hisi_defconfig           mvebu_v7_defconfig    shmobile_defconfig
>   axm55xx_defconfig         imxrt_defconfig          mxs_defconfig         simpad_defconfig
>   badge4_defconfig          imx_v4_v5_defconfig      neponset_defconfig    socfpga_defconfig
>   bcm2835_defconfig         imx_v6_v7_defconfig      netwinder_defconfig   sp7021_defconfig
>   cerfcube_defconfig        integrator_defconfig     nhk8815_defconfig     spear13xx_defconfig
>   clps711x_defconfig        iop32x_defconfig         omap1_defconfig       spear3xx_defconfig
>   cm_x300_defconfig         ixp4xx_defconfig         omap2plus_defconfig   spear6xx_defconfig
>   cns3420vb_defconfig       jornada720_defconfig     orion5x_defconfig     spitz_defconfig
>   colibri_pxa270_defconfig  keystone_defconfig       oxnas_v6_defconfig    stm32_defconfig
>   colibri_pxa300_defconfig  lart_defconfig           palmz72_defconfig     sunxi_defconfig
>   collie_defconfig          lpc18xx_defconfig        pcm027_defconfig      tct_hammer_defconfig
>   corgi_defconfig           lpc32xx_defconfig        pleb_defconfig        tegra_defconfig
>   davinci_all_defconfig     lpd270_defconfig         pxa168_defconfig      trizeps4_defconfig
>   dove_defconfig            lubbock_defconfig        pxa255-idp_defconfig  u8500_defconfig
>   dram_0x00000000.config    magician_defconfig       pxa3xx_defconfig      versatile_defconfig
>   dram_0xc0000000.config    mainstone_defconfig      pxa910_defconfig      vexpress_defconfig
>   dram_0xd0000000.config    milbeaut_m10v_defconfig  pxa_defconfig         vf610m4_defconfig
>   ep93xx_defconfig          mini2440_defconfig       qcom_defconfig        viper_defconfig
>   eseries_pxa_defconfig     mmp2_defconfig           realview_defconfig    vt8500_v6_v7_defconfig
>   exynos_defconfig          moxart_defconfig         rpc_defconfig         xcep_defconfig
>   ezx_defconfig             mps2_defconfig           s3c2410_defconfig     zeus_defconfig
>   footbridge_defconfig      multi_v4t_defconfig      s3c6400_defconfig
>
> But this doesn't seem to be working reliably on i386:
>
>   kepler:~/tip> make i386_defconfig
>   #
>   # configuration written to .config
>   #
>   kepler:~/tip> /bin/cp .config .config.i386_defconfig.1
>
>   kepler:~/tip> make ARCH=i386 defconfig
>   *** Default configuration is based on 'i386_defconfig'
>   #
>   # configuration written to .config
>   #
>   kepler:~/tip> /bin/cp .config .config.i386_defconfig.2
>
>   kepler:~/tip> diff -up .config.i386_defconfig.1 .config.i386_defconfig.2
>   --- .config.i386_defconfig.1  2022-09-04 11:34:48.253202205 +0200
>   +++ .config.i386_defconfig.2  2022-09-04 11:35:04.268758331 +0200
>   @@ -1,6 +1,6 @@
>    #
>    # Automatically generated file; DO NOT EDIT.
>   -# Linux/x86 6.0.0-rc3 Kernel Configuration
>   +# Linux/i386 6.0.0-rc3 Kernel Configuration
>    #
>    CONFIG_CC_VERSION_TEXT="gcc (Ubuntu 12-20220319-1ubuntu1) 12.0.1 20220319 (experimental) [master r12-7719-g8ca61ad148f]"
>    CONFIG_CC_IS_GCC=y
>   @@ -261,7 +261,6 @@ CONFIG_PROFILING=y
>    CONFIG_TRACEPOINTS=y
>    # end of General setup
>
>   -# CONFIG_64BIT is not set
>    CONFIG_X86_32=y
>    CONFIG_X86=y
>    CONFIG_INSTRUCTION_DECODER=y
>
> Note how in the ARCH=i386 case the build system claims to use i386_defconfig:
>
>   *** Default configuration is based on 'i386_defconfig'
>
> But that doesn't seem to be identical with when we specify i386_defconfig
> directly as a target...
>
> What am I missing?
>
> Thanks,
>
>         Ingo





-- 
Best Regards
Masahiro Yamada
