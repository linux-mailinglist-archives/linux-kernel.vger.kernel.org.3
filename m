Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722FD56CF74
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 16:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiGJOYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 10:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGJOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 10:24:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9B2C33
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5693B80990
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF578C3411E;
        Sun, 10 Jul 2022 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657463038;
        bh=Lq2vUSEcY2t246zAbp7QWdEvMPJFKZAy8DlU7fgwago=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojHwjV6RpMazZ8FczuoJXn0PyAHsr+TyiXbtbh/QjihKfqfugwBHr3gH3cJLO0q02
         lWd9D7Mfy6ooqxvmlrz1orZw4WdK9Ye6oKE8n3+8MFCZ6eLKhPxag1cyyM1iwehYfk
         b+3DEYIpuyD4iqpbiJb+24BYO3E6BB6pBdiRGAxo=
Date:   Sun, 10 Jul 2022 16:23:55 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [linux-stable-rc:linux-4.19.y 1539/3265]
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:15: error: implicit
 declaration of function 'read_poll_timeout'
Message-ID: <Ysrg+y/w3pisMnXw@kroah.com>
References: <202207061830.78pJNuwN-lkp@intel.com>
 <701e5ff60f921cb80bbc76e0fe0119b93c9bb431.camel@calian.com>
 <YscfnyyLd5Oxd/3p@kroah.com>
 <64924c3c7d9c67556e4e7931fef652d63bc012fe.camel@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64924c3c7d9c67556e4e7931fef652d63bc012fe.camel@calian.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:24:20PM +0000, Robert Hancock wrote:
> On Thu, 2022-07-07 at 20:02 +0200, gregkh@linuxfoundation.org wrote:
> > On Wed, Jul 06, 2022 at 10:42:48PM +0000, Robert Hancock wrote:
> > > On Wed, 2022-07-06 at 18:43 +0800, kernel test robot wrote:
> > > > Hi Robert,
> > > > 
> > > > FYI, the error/warning still remains.
> > > > 
> > > > tree:  
> > > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git__;!!IOGos0k!nK_4HG5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZas4Ne1iIw$
> > > >   linux-4.19.y
> > > > head:   b9f174a70c6f609b6132c3a65883b16d552984b8
> > > > commit: 8b8ad8a7ac24905937c3975b54c4594b93b66ebb [1539/3265] net:
> > > > axienet: Wait for PhyRstCmplt after core reset
> > > > config: microblaze-randconfig-r003-20220704
> > > > (
> > > > https://urldefense.com/v3/__https://download.01.org/0day-ci/archiv
> > > > e/
> > > > 20220706/202207061830.78pJNuwN-lkp@intel.com/config__;!!IOGos0k!n
> > > > K_4H
> > > > G5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZa
> > > > tUAT
> > > > tDaQ$ )
> > > > compiler: microblaze-linux-gcc (GCC) 11.3.0
> > > > reproduce (this is a W=1 build):
> > > >         wget
> > > > https://urldefense.com/v3/__https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross__;!!IOGos0k!nK_4HG5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZautG4jkgg$
> > > >   -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         #
> > > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=8b8ad8a7ac24905937c3975b54c4594b93b66ebb__;!!IOGos0k!nK_4HG5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZas8R9M_sA$
> > > >  
> > > >         git remote add linux-stable-rc
> > > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git__;!!IOGos0k!nK_4HG5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZas4Ne1iIw$
> > > >  
> > > >         git fetch --no-tags linux-stable-rc linux-4.19.y
> > > >         git checkout 8b8ad8a7ac24905937c3975b54c4594b93b66ebb
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0
> > > > make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash
> > > > drivers/net/ethernet/xilinx/
> > > > 
> > > > If you fix the issue, kindly add following tag where applicable
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > All errors (new ones prefixed by >>):
> > > > 
> > > >    drivers/net/ethernet/xilinx/xilinx_axienet_main.c: In function
> > > > 'axienet_dma_bd_init':
> > > >    drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:9:
> > > > error:
> > > > 'ret' undeclared (first use in this function); did you mean
> > > > 'net'?
> > > >      283 |         ret = read_poll_timeout(axienet_ior, value,
> > > >          |         ^~~
> > > >          |         net
> > > >    drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:9: note:
> > > > each undeclared identifier is reported only once for each
> > > > function it
> > > > appears in
> > > > > > drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:15:
> > > > > > error:
> > > > > > implicit declaration of function 'read_poll_timeout' [-
> > > > > > Werror=implicit-function-declaration]
> > > >      283 |         ret = read_poll_timeout(axienet_ior, value,
> > > >          |               ^~~~~~~~~~~~~~~~~
> > > >    drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:46:
> > > > error:
> > > > 'value' undeclared (first use in this function)
> > > >      283 |         ret = read_poll_timeout(axienet_ior, value,
> > > >          |                                              ^~~~~
> > > >    cc1: some warnings being treated as errors
> > > > 
> > > 
> > > This seems like maybe a bad backport of the listed patch to the
> > > 4.19
> > > stable release?
> > 
> > If so, can you provide a fix for this?
> 
> It looks like read_poll_timeout was not in 4.19 so it's not just a
> missing include, the code would need to be modified to use a different
> API. I don't have a test environment for 4.19 so the most I could do is
> compile test it (and in 4.19 this driver could only be enabled on a
> limited set of platforms, Microblaze being one, which I assume is why
> there weren't more complaints).
> 
> Unless someone had a specific reason for requesting this patch
> ("axienet: Wait for PhyRstCmplt after core reset") be backported to
> 4.19, it might be easier to just drop it from the 4.19 stable tree -
> the problem this is fixing only shows up in certain hardware
> configurations, but the driver not compiling is worse..

True, can you send a revert for this?

thanks,

greg k-h
