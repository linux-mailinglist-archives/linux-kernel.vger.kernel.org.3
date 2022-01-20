Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E6495610
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347503AbiATVo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiATVoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:44:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FBAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:44:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8FC0B81E54
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBABC340E0;
        Thu, 20 Jan 2022 21:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642715091;
        bh=FZe+SAxvQtqmayyXIEIlIPrLP6I5xnrdSTWqJ4EPxLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mu3K0U614ZhC262qaahxQtHOBYM9LjQHb1h83zQ0n6vovlWum9+Mx2ukRl7mOHR4j
         0oDT+BipsYz6Nt2thKg0EAeaFtz4A4TfvgTsoDQ1k2gfiLKJllRaHImWWdeIIm/iXO
         2svOrq97+mt8krHLcTYHrzALygRIA8O5CiZpd1WK0BEhuvu4mY+LFEUj8nv8c8Wxkf
         gwZv769Owh0tb+4lHk1XfhhppDvBPoq6/oD+mu8aXUkoKr1lOk2LihpkoOllVwbdF8
         p8bEzgIYLmIdwkDlgtEz/bilVo36N5qQ7fHus1t+0eX3H6ozvE45APjLJ6uVuN0AmG
         QGPRpEst2CU2A==
Date:   Thu, 20 Jan 2022 14:44:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     kernel test robot <lkp@intel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of
 packed member 'data' of class or structure 'tsc2046_adc_atom' may result in
 an unaligned pointer value
Message-ID: <YenXz+RznXBuJMSR@dev-arch.archlinux-ax161>
References: <202201171718.7ZCI4YeQ-lkp@intel.com>
 <20220117101941.00003c68@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117101941.00003c68@Huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 10:19:41AM +0000, Jonathan Cameron wrote:
> On Mon, 17 Jan 2022 18:00:03 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   0c947b893d69231a9add855939da7c66237ab44f
> > commit: 9374e8f5a38defe90bc65b2decf317c1c62d91dd iio: adc: add ADC driver for the TI TSC2046 controller
> > date:   8 months ago
> > config: mips-randconfig-r002-20220116 (https://download.01.org/0day-ci/archive/20220117/202201171718.7ZCI4YeQ-lkp@intel.com/config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install mips cross compiling tool for clang build
> >         # apt-get install binutils-mips-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9374e8f5a38defe90bc65b2decf317c1c62d91dd
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 9374e8f5a38defe90bc65b2decf317c1c62d91dd
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/iio/adc/ drivers/usb/gadget/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/iio/adc/ti-tsc2046.c:242:62: warning: taking address of packed member 'data' of class or structure 'tsc2046_adc_atom' may result in an unaligned pointer value [-Waddress-of-packed-member]  
> >            return FIELD_GET(TI_TSC2046_DATA_12BIT, get_unaligned_be16(&buf->data));
> >                                                                        ^~~~~~~~~
> 
> I'm open to suggestions on what (if anything) to do about this one...

Hi Jonathan,

-Waddress-of-packed-member is disabled in the main Makefile and this
particular randconfig has a bunch of these warnings. It comes from the
fact that arch/mips/loongson64/Platform adds -mno-branch-likely
unconditionally but clang does not support it so it issues a warning:

clang-14: warning: argument unused during compilation: '-mno-branch-likely' [-Wunused-command-line-argument]

The presence of this warning causes cascading cc-option failures because
cc-option adds -Werror, which means that the requested flag never gets
added to KBUILD_CFLAGS, so we see instances of warnings that should be
disabled.

This has come up in the past because clang has four different ways it
can react to a flag it does not recognize. One is an error, the other
three are warnings.  We handle two in scripts/Makefile.clang to try and
make these failures more obvious in the build but we do not handle this
warning because there are instances of it in arch/arm [1]. I'll push to
get that change into mainline so we can avoid this once and for all.

More background:

* 589834b3a009 ("kbuild: Add -Werror=unknown-warning-option to CLANG_FLAGS")
* 0664684e1ebd ("kbuild: Add -Werror=ignored-optimization-argument to CLANG_FLAGS")

For now, I have sent [2]. It might be nice to clean the kernel up of
these warnings over time (and I recall seeing a patch fly by recently
[3]) but I don't think there is much for you to do now.

[1]: https://lore.kernel.org/r/20210928154143.2106903-14-arnd@kernel.org/
[2]: https://lore.kernel.org/r/20220120214001.1879469-2-nathan@kernel.org/
[3]: https://lore.kernel.org/r/20220110224656.266536-1-sakari.ailus@linux.intel.com/

Cheers,
Nathan
