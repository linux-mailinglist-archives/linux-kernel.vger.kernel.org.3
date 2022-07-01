Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6AB56370B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiGAPjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiGAPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:39:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573F2E0A2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31281B82F36
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 15:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F74EC3411E;
        Fri,  1 Jul 2022 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656689955;
        bh=p7AFYhpLzu2M8xFRXsuTfQ8FA/Ky7BhHq49tuvGwm5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VL6ajgYlc/roGvV/pCojyfj9H8DxMV2uT5XtOmupqACTAGtU9cmbRdCalHNg0Nkb7
         8hFdmtVQfiWvu9T6FpLdApyqWrAw6GJ//DaK4IikjlSx3u68liGyrND3pGNHbCbOi5
         YDI4HzmoQwlu812+DHJNbFfteMlIil3QFVlYGwnw09rkogSA+3qNkGue9EVq9t8Zk0
         E9zx9rAiM/n5lVhEIIfJrbe/aehq6LsHmqalKTmSnbBw2Q9HpNffrbb/xIGgCZmwq9
         XUztMhzmDLdQQaNdS2UEQeNTN7CjLFz7kBwCJOIUdt0UTZU7FL4CAUeazV7xwnILYP
         ieGNxb5vtfZ0w==
Date:   Fri, 1 Jul 2022 08:39:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [char-misc:char-misc-linus 3/3]
 drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used
 uninitialized whenever 'if' condition is true
Message-ID: <Yr8VIT2vjvGYrbmR@dev-arch.thelio-3990X>
References: <202207011658.rHJFVLWA-lkp@intel.com>
 <Yr63Zyvj49o8U/ti@kroah.com>
 <67a09516-ec1f-d0b6-c027-fd52159318ed@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67a09516-ec1f-d0b6-c027-fd52159318ed@linuxfoundation.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 08:48:11AM -0600, Shuah Khan wrote:
> On 7/1/22 2:59 AM, Greg Kroah-Hartman wrote:
> > On Fri, Jul 01, 2022 at 04:49:50PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-linus
> > > head:   3776c78559853fd151be7c41e369fd076fb679d5
> > > commit: 3776c78559853fd151be7c41e369fd076fb679d5 [3/3] misc: rtsx_usb: use separate command and response buffers
> > > config: arm-buildonly-randconfig-r006-20220629 (https://download.01.org/0day-ci/archive/20220701/202207011658.rHJFVLWA-lkp@intel.com/config)
> > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # install arm cross compiling tool for clang build
> > >          # apt-get install binutils-arm-linux-gnueabi
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=3776c78559853fd151be7c41e369fd076fb679d5
> > >          git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > >          git fetch --no-tags char-misc char-misc-linus
> > >          git checkout 3776c78559853fd151be7c41e369fd076fb679d5
> > >          # save the config file
> > >          mkdir build_dir && cp config build_dir/.config
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/misc/cardreader/
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > > > drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> > >             if (!ucr->rsp_buf)
> > >                 ^~~~~~~~~~~~~
> > >     drivers/misc/cardreader/rtsx_usb.c:678:9: note: uninitialized use occurs here
> > >             return ret;
> > >                    ^~~
> > >     drivers/misc/cardreader/rtsx_usb.c:639:2: note: remove the 'if' if its condition is always false
> > >             if (!ucr->rsp_buf)
> > >             ^~~~~~~~~~~~~~~~~~
> > >     drivers/misc/cardreader/rtsx_usb.c:622:9: note: initialize the variable 'ret' to silence this warning
> > >             int ret;
> > >                    ^
> > >                     = 0
> > >     1 warning generated.
> > 
> > Odd, gcc doesn't show this for me.  Shuah, can you send a follow-on
> > patch to fix this?  The warning does look correct.
> > 
> 
> gcc didn't complain when I compiled either. I will send a follow-on patch.

Unfortunately, GCC won't warn for most uninitialized variables by
default after 5.7, which included commit 78a5255ffb6a ("Stop the ad-hoc
games with -Wno-maybe-initialized"). They will potentially show up at
W=2 or with an explicit KCFLAGS=-Wmaybe-uninitialized (it does in this
case):

| drivers/misc/cardreader/rtsx_usb.c: In function ‘rtsx_usb_probe’:
| drivers/misc/cardreader/rtsx_usb.c:678:16: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
|   678 |         return ret;
|       |                ^~~
| drivers/misc/cardreader/rtsx_usb.c:622:13: note: ‘ret’ was declared here
|   622 |         int ret;
|       |             ^~~
| cc1: all warnings being treated as errors

Cheers,
Nathan
