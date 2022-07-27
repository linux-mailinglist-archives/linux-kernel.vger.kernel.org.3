Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E3A5823DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiG0KIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiG0KIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:08:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB6F2019C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0910B82010
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38A9C433D6;
        Wed, 27 Jul 2022 10:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658916511;
        bh=XTyMC53zSGPW3G3xLC8IO3gSBxia3L48Jl68lhw05MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTrRCqufh3vZqqrAsQLK4+RYldcZVaQcm0KmzVNeoa9bxD7tM7eOBAd43CxxYOHoz
         fWk2KhSy7wfb2P6q9sebtVFlavysdra1gilkBporalBxC42GrQR5ch7pP5ynqjId+Y
         THyiNYhEIcBE3Er/KHts53u5Cii40LwFbMzMYde0=
Date:   Wed, 27 Jul 2022 12:08:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Daniel Rosenberg <drosen@google.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dennis Cagle <d-cagle@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [linux-stable-rc:linux-4.9.y 967/2229]
 drivers/staging/android/ion/ion-ioctl.c:71:6: warning: variable 'ret' is
 used uninitialized whenever 'if' condition is false
Message-ID: <YuEOnEIRjWfnPEkW@kroah.com>
References: <202207241311.Dv86CbAo-lkp@intel.com>
 <62deb91e.1c69fb81.96632.74a9SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62deb91e.1c69fb81.96632.74a9SMTPIN_ADDED_BROKEN@mx.google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 08:39:07AM -0700, Nathan Chancellor wrote:
> On Sun, Jul 24, 2022 at 01:39:50PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > head:   65be5f5665a580424a7b1102f1a04c4259c559b5
> > commit: a8200613c8c9fbaf7b55d4d438376ebaf0c4ce7e [967/2229] ion: Protect kref from userspace manipulation
> > config: mips-randconfig-r034-20220719 (https://download.01.org/0day-ci/archive/20220724/202207241311.Dv86CbAo-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fa0c7639e91fa1cd0cf2ff0445a1634a90fe850a)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install mips cross compiling tool for clang build
> >         # apt-get install binutils-mipsel-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=a8200613c8c9fbaf7b55d4d438376ebaf0c4ce7e
> >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >         git fetch --no-tags linux-stable-rc linux-4.9.y
> >         git checkout a8200613c8c9fbaf7b55d4d438376ebaf0c4ce7e
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/staging/android/ion/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/staging/android/ion/ion-ioctl.c:71:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >            if (--handle->user_ref_count == 0)
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/staging/android/ion/ion-ioctl.c:74:9: note: uninitialized use occurs here
> >            return ret;
> >                   ^~~
> >    drivers/staging/android/ion/ion-ioctl.c:71:2: note: remove the 'if' if its condition is always true
> >            if (--handle->user_ref_count == 0)
> >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/staging/android/ion/ion-ioctl.c:69:9: note: initialize the variable 'ret' to silence this warning
> >            int ret;
> >                   ^
> >                    = 0
> >    1 warning generated.
> > 
> > 
> > vim +71 drivers/staging/android/ion/ion-ioctl.c
> > 
> >     65	
> >     66	/* Must hold the client lock */
> >     67	static int user_ion_handle_put_nolock(struct ion_handle *handle)
> >     68	{
> >     69		int ret;
> >     70	
> >   > 71		if (--handle->user_ref_count == 0)
> >     72			ret = ion_handle_put_nolock(handle);
> >     73	
> >     74		return ret;
> >     75	}
> >     76	
> 
> Might as well just be
> 
> static void user_ion_handle_put_nolock(struct ion_handle *handle)
> {
> 	if (--handle->user_ref_count == 0)
> 		ion_handle_put_nolock(handle);
> }
> 
> since user_ion_free_nolock() doesn't check the return value of
> user_ion_handle_put_nolock()? I can send a patch if people care (I know
> 4.9 is a bit on the older side).

A patch would be nice, thanks!
