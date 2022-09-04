Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892E75AC3AB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 11:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiIDJsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 05:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiIDJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 05:48:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44695255A9;
        Sun,  4 Sep 2022 02:48:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x73so970758ede.10;
        Sun, 04 Sep 2022 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=VaiOF8stiLNejNRgZtnhGgg2Iq0BVvVYE9RhfYFCnLw=;
        b=aiFbRSJa+NYuNSwf7zKTkoRXgjsxPQ1uJYw/BKaGRPWhYvHgrrkG17JFPCOSsryWG6
         dWBlR7b+xMXCEXZ7SM7Ro6kiDhpDeUGM9aPkfnG+TtsNZW5lEoDuxWFuZZdrWBND2Ihh
         D1YmWifO5Pt1zAFmU+r6Gdl+NO6AiByu/iG8nMHsaM2dwC6qlHRuuImUJbTIDK67WYxZ
         g2vF4uLqtqFwVk2slNRurhULqinwmEesqnz2T/z1gzwToqOvP2ryp+5om8aRVQ4wSJ9g
         ozw5j3mlWgFKaitOY1Ba0VD2E/dNX7zpou743KQ7oe77rExcHCXf871HZ4EQ6b8TLov0
         eqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VaiOF8stiLNejNRgZtnhGgg2Iq0BVvVYE9RhfYFCnLw=;
        b=b6YsusTDg7fsbF4eQEltrAVxtrGnuSmq6EAiuvohV6c2bT1tg3PCm/nnK4yXmkEMjT
         HX/GkhsjZ1uYnAhTvs9Qww8F+CMsOd4iCg6AqDbSuQfXkr/veITxf4e8iQ6E1mwMzQoy
         nWw+lt1Y023RvNBfcSondqqGQCW75NtTgxAJ4D3/sr35RewetyKccZkvNnF76jrmOrvd
         JAmVMPp1yT7Nl05Vqy9ho6JwC3tnjxJq263GbSRDjCRq4OiH4oOfbKL6xyovULxlUhn9
         G0jEhC2OhWudDwGl9oLVkSRpglN4JfFXWuydxCtZaDaw9InjQoVDUrc3JOKA3kVZXT47
         /egQ==
X-Gm-Message-State: ACgBeo05vp4xgx6eAcNY3HNE8Q7rPkFYDMX2h+j9enByZDaK49GbxfGZ
        4f+VRWJt0LjoPo0g6LVRjMo=
X-Google-Smtp-Source: AA6agR5vO327jeDw9MnW1XxWtkpmijCUwhzQQHo/+NWa0GEOkeI5qLsAVNlNzdcveWFhB8B2Azr0JQ==
X-Received: by 2002:a05:6402:2423:b0:446:3b6b:e3ee with SMTP id t35-20020a056402242300b004463b6be3eemr39831350eda.412.1662284885685;
        Sun, 04 Sep 2022 02:48:05 -0700 (PDT)
Received: from gmail.com (1F2EF751.nat.pool.telekom.hu. [31.46.247.81])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709061b0700b007311eb42e40sm3497987ejg.54.2022.09.04.02.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 02:48:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 4 Sep 2022 11:48:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
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
Subject: Re: [PATCH] x86/config: Make the x86 defconfigs a bit more usable
Message-ID: <YxR0UlS0Jpz9uqb7@gmail.com>
References: <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjsCpoRK7W4l6tSh@zn.tnic>
 <CAHk-=wi9pLxm+dXoCaiGO+f0EbhyfAR_L510vD0c2=hj6rbMXg@mail.gmail.com>
 <YjwsUT/6PkRPjnHE@gmail.com>
 <YjySjys3QZAWFlfo@dev-arch.thelio-3990X>
 <YkC08gKqJOUM7CA8@gmail.com>
 <YkHXQTKImf7Wr+Sk@dev-arch.thelio-3990X>
 <YxHD1MkulyL3yB9y@gmail.com>
 <CAK7LNASyp8SzO3G+th5RgmRNBM_ryKuy0XzaMrdUdo8Sd6RR0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASyp8SzO3G+th5RgmRNBM_ryKuy0XzaMrdUdo8Sd6RR0A@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <masahiroy@kernel.org> wrote:

> > Unfortunately, even without the ARCH=i386 'make savedefconfig' doesn't 
> > seem to be doing the right thing & is dropping the '# CONFIG_64BIT is 
> > not set' line:
> 
> 
> Oh, really?
> 
> Without ARCH=i386, it works correctly for me.
> 
> 
> 
> masahiro@zoe:~/ref/linux$ make i386_defconfig savedefconfig
> #
> # No change to .config
> #
> masahiro@zoe:~/ref/linux$ grep CONFIG_64BIT defconfig
> # CONFIG_64BIT is not set

Yeah, so why do these two seemingly identical commands produce two 
different .config's:

  $ make ARCH=i386 defconfig
  *** Default configuration is based on 'i386_defconfig'

  $ make i386_defconfig

?

Basically the canonical way to generate a defconfig is to provide an ARCH, 
then use the common 'defconfig' target:

   make ARCH=i386      defconfig
   make ARCH=x86       defconfig
   make ARCH=arm       defconfig
   make ARCH=arm64     defconfig
   make ARCH=powerpc   defconfig
   make ARCH=s390      defconfig
   make ARCH=sparc     defconfig
   make ARCH=sparc64   defconfig
   ...

This is what my build test scripts are using to quick-test cross-arch 
builds. It's a straightforward way to generate defconfigs without knowing 
the details of the myriads of random defconfig targets some architectures 
have, such as:

  kepler:~/tip> ls arch/arm/configs/
  am200epdkit_defconfig     gemini_defconfig         multi_v5_defconfig    s5pv210_defconfig
  aspeed_g4_defconfig       h3600_defconfig          multi_v7_defconfig    sama5_defconfig
  aspeed_g5_defconfig       h5000_defconfig          mv78xx0_defconfig     sama7_defconfig
  assabet_defconfig         hackkit_defconfig        mvebu_v5_defconfig    shannon_defconfig
  at91_dt_defconfig         hisi_defconfig           mvebu_v7_defconfig    shmobile_defconfig
  axm55xx_defconfig         imxrt_defconfig          mxs_defconfig         simpad_defconfig
  badge4_defconfig          imx_v4_v5_defconfig      neponset_defconfig    socfpga_defconfig
  bcm2835_defconfig         imx_v6_v7_defconfig      netwinder_defconfig   sp7021_defconfig
  cerfcube_defconfig        integrator_defconfig     nhk8815_defconfig     spear13xx_defconfig
  clps711x_defconfig        iop32x_defconfig         omap1_defconfig       spear3xx_defconfig
  cm_x300_defconfig         ixp4xx_defconfig         omap2plus_defconfig   spear6xx_defconfig
  cns3420vb_defconfig       jornada720_defconfig     orion5x_defconfig     spitz_defconfig
  colibri_pxa270_defconfig  keystone_defconfig       oxnas_v6_defconfig    stm32_defconfig
  colibri_pxa300_defconfig  lart_defconfig           palmz72_defconfig     sunxi_defconfig
  collie_defconfig          lpc18xx_defconfig        pcm027_defconfig      tct_hammer_defconfig
  corgi_defconfig           lpc32xx_defconfig        pleb_defconfig        tegra_defconfig
  davinci_all_defconfig     lpd270_defconfig         pxa168_defconfig      trizeps4_defconfig
  dove_defconfig            lubbock_defconfig        pxa255-idp_defconfig  u8500_defconfig
  dram_0x00000000.config    magician_defconfig       pxa3xx_defconfig      versatile_defconfig
  dram_0xc0000000.config    mainstone_defconfig      pxa910_defconfig      vexpress_defconfig
  dram_0xd0000000.config    milbeaut_m10v_defconfig  pxa_defconfig         vf610m4_defconfig
  ep93xx_defconfig          mini2440_defconfig       qcom_defconfig        viper_defconfig
  eseries_pxa_defconfig     mmp2_defconfig           realview_defconfig    vt8500_v6_v7_defconfig
  exynos_defconfig          moxart_defconfig         rpc_defconfig         xcep_defconfig
  ezx_defconfig             mps2_defconfig           s3c2410_defconfig     zeus_defconfig
  footbridge_defconfig      multi_v4t_defconfig      s3c6400_defconfig

But this doesn't seem to be working reliably on i386:

  kepler:~/tip> make i386_defconfig
  #
  # configuration written to .config
  #
  kepler:~/tip> /bin/cp .config .config.i386_defconfig.1

  kepler:~/tip> make ARCH=i386 defconfig
  *** Default configuration is based on 'i386_defconfig'
  #
  # configuration written to .config
  #
  kepler:~/tip> /bin/cp .config .config.i386_defconfig.2

  kepler:~/tip> diff -up .config.i386_defconfig.1 .config.i386_defconfig.2
  --- .config.i386_defconfig.1	2022-09-04 11:34:48.253202205 +0200
  +++ .config.i386_defconfig.2	2022-09-04 11:35:04.268758331 +0200
  @@ -1,6 +1,6 @@
   #
   # Automatically generated file; DO NOT EDIT.
  -# Linux/x86 6.0.0-rc3 Kernel Configuration
  +# Linux/i386 6.0.0-rc3 Kernel Configuration
   #
   CONFIG_CC_VERSION_TEXT="gcc (Ubuntu 12-20220319-1ubuntu1) 12.0.1 20220319 (experimental) [master r12-7719-g8ca61ad148f]"
   CONFIG_CC_IS_GCC=y
  @@ -261,7 +261,6 @@ CONFIG_PROFILING=y
   CONFIG_TRACEPOINTS=y
   # end of General setup
   
  -# CONFIG_64BIT is not set
   CONFIG_X86_32=y
   CONFIG_X86=y
   CONFIG_INSTRUCTION_DECODER=y

Note how in the ARCH=i386 case the build system claims to use i386_defconfig:

  *** Default configuration is based on 'i386_defconfig'

But that doesn't seem to be identical with when we specify i386_defconfig 
directly as a target...

What am I missing?

Thanks,

	Ingo
