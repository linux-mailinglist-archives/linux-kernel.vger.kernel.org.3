Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF510536EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 03:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiE2BBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 21:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiE2BBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 21:01:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AFE6D945
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 18:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 472E860C36
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 01:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56345C34114;
        Sun, 29 May 2022 01:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653786104;
        bh=YhsbeucUoFLNuOAHY7NICLXdLi3u/TPueYompdYiLTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPYknZ/nV5gLUAfdLJf+b6PDj2FW0Uixlykc3vOmRA7tsel0cI741OgawsNlPLl7u
         B6GATlpZayfqJu41GXy3e5VShJnGrvITbgiEXjPnrtBfEup5N0XegJuPiwzghe8+vZ
         P2zfDioVqWDWqttTJbC+3m8egvH967X/fWt2kbvv1ZL6FElsylbFz6RwJ2oL6S1el/
         Npx8YnfNlFXc61s8VCRIz+jPkw96nMH1CfUO7v2akBjv3yhJGjhwQncaB8x7ZhJnIf
         jdhPaNTjweiqsiqPiqSCKJM+0G7Dc5yn5y7RqErd6qMwNjuWAACw5Fx+b7n3kNpZy7
         nqEHMvz6sUbEg==
Date:   Sat, 28 May 2022 18:01:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: drivers/gpu/drm/solomon/ssd130x-spi.c:154:35: warning: unused
 variable 'ssd130x_spi_table'
Message-ID: <YpLF9jdqiub98Nl/@dev-arch.thelio-3990X>
References: <202205290422.eoxGqDMR-lkp@intel.com>
 <607265eb-bfbf-4134-f2fe-d66cacd7bfbb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <607265eb-bfbf-4134-f2fe-d66cacd7bfbb@redhat.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 11:23:04PM +0200, Javier Martinez Canillas wrote:
> Hello,
> 
> On 5/28/22 22:58, kernel test robot wrote:
> > Hi Javier,
> > 
> > FYI, the error/warning still remains.
> >
> 
> Yes, but in my opinion is a false positive.

I don't think it is a false positive for this particular configuration.
MODULE_DEVICE_TABLE expands to nothing when the file it is included in
is built into the kernel, as opposed to a module, so the variable truly
is unused.

$ curl -LSs https://download.01.org/0day-ci/archive/20220529/202205290422.eoxGqDMR-lkp@intel.com/config | rg CONFIG_DRM_SSD130X_SPI
CONFIG_DRM_SSD130X_SPI=y

You'll see the same warning with GCC and a similar configuration:

drivers/gpu/drm/solomon/ssd130x-spi.c:154:35: error: ‘ssd130x_spi_table’ defined but not used [-Werror=unused-const-variable=]
  154 | static const struct spi_device_id ssd130x_spi_table[] = {
      |                                   ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

At the end of the day, this warning only shows up under W=1, so take it
as you will. The kernel test robot is a sign, not a cop :)

Cheers,
Nathan

> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
> > commit: 74373977d2ca26e5735377f8874be70bc2f030f5 drm/solomon: Add SSD130x OLED displays SPI support
> > date:   5 weeks ago
> > config: hexagon-randconfig-r033-20220529 (https://download.01.org/0day-ci/archive/20220529/202205290422.eoxGqDMR-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74373977d2ca26e5735377f8874be70bc2f030f5
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 74373977d2ca26e5735377f8874be70bc2f030f5
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/solomon/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> drivers/gpu/drm/solomon/ssd130x-spi.c:154:35: warning: unused variable 'ssd130x_spi_table' [-Wunused-const-variable]
> >    static const struct spi_device_id ssd130x_spi_table[] = {
> >                                      ^
> >    1 warning generated.
> > 
> > 
> > vim +/ssd130x_spi_table +154 drivers/gpu/drm/solomon/ssd130x-spi.c
> > 
> >    145	
> >    146	/*
> >    147	 * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
> >    148	 * if the device was registered via OF. This means that the module will not be
> >    149	 * auto loaded, unless it contains an alias that matches the MODALIAS reported.
> >    150	 *
> >    151	 * To workaround this issue, add a SPI device ID table. Even when this should
> >    152	 * not be needed for this driver to match the registered SPI devices.
> >    153	 */
> >  > 154	static const struct spi_device_id ssd130x_spi_table[] = {
> 
> This comment is quite clear about it, the table only exists due a limitation in how
> the SPI subsystem reports the module aliases. It always report a "spi:<device> even
> if it was registered by OF, and that's the only reason why we need it.
> 
> Setting the struct spi_driver .id field just to make this warning go away would be
> the wrong thing to do IMO, since always the struct of_device_id should be used.
> 
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
> 
> 
