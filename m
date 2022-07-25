Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5E580780
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiGYWhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbiGYWh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:37:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27AC25E96
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 523AAB81135
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 22:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554D1C341CD;
        Mon, 25 Jul 2022 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658788618;
        bh=WTLwrkIPsf8FEgIVjgSmfxrI9GvpGImfD1cmaawndOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3kOtIK4uopUXtPH2SH/KNXRpbsTQ/RF0B5SBznEhsqZllj3MxlsP+CMJwho7O0Wl
         TxL3mZdV8Qw+rCJIhQMShP7OmuYbUs1Ee6u78VoVOy0Mw9tkm18xhnKl60zv4IsuZ2
         xYj/kLCZy/i9vhtyTD2AxHuiEYGpmj9QE8quUeUWoiGjOvquoHpKKOdGggvxLdDaxG
         rfDAMhX1pmlijmzdpVr8Tk9hlPnOAD3TEKNpfRqjlObqqUNuT21rNmfOv5LrQDHLLe
         L5IvHruk+TuXgHk1TbspN/z5o64r62N8wOSS0xJCLaM9U6fLBcOiBzepiq33DZjW4a
         +UEfmPazMo1LQ==
Date:   Mon, 25 Jul 2022 15:36:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Simon Trimmer <simont@opensource.cirrus.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: sound/soc/codecs/wm_adsp.c:1490:32: warning: taking address of
 packed member 'name' of class or structure 'wm_adsp_host_buf_coeff_v1' may
 result in an unaligned pointer value
Message-ID: <Yt8bB+lAoGM2Jmq0@dev-arch.thelio-3990X>
References: <202207260648.ERQjXCRB-lkp@intel.com>
 <Yt8aZ3OZ7lJBgf1V@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt8aZ3OZ7lJBgf1V@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 03:34:15PM -0700, Nathan Chancellor wrote:
> On Tue, Jul 26, 2022 at 06:29:46AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e0dccc3b76fb35bb257b4118367a883073d7390e
> > commit: 353bb6a5f2ac495f289b7c7a528c7d134c9a8ec4 ASoC: wm_adsp: Compressed stream DSP memory structs should be __packed
> > date:   5 months ago
> > config: arm-randconfig-r013-20220724 (https://download.01.org/0day-ci/archive/20220726/202207260648.ERQjXCRB-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9e88cbcc403bdf82f29259ad60ff60a8fc4434a1)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=353bb6a5f2ac495f289b7c7a528c7d134c9a8ec4
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 353bb6a5f2ac495f289b7c7a528c7d134c9a8ec4
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/codecs/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> sound/soc/codecs/wm_adsp.c:1490:32: warning: taking address of packed member 'name' of class or structure 'wm_adsp_host_buf_coeff_v1' may result in an unaligned pointer value [-Waddress-of-packed-member]
> >            cs_dsp_remove_padding((u32 *)&coeff_v1.name, ARRAY_SIZE(coeff_v1.name));
> >                                          ^~~~~~~~~~~~~
> >    1 warning generated.
> 
> This warning is disabled in the main Makefile but a recent change in
> LLVM has caused that check to fail, sorry for the noise :(
> 
> https://github.com/ClangBuiltLinux/linux/issues/1674

Ah nevermind, looks like Fangrui already worked around this, it should
be resolved on the next LLVM uprev:

https://github.com/llvm/llvm-project/commit/1d23f6c5a4f6ebb101c282f8f506588fe4d9e92f

Cheers,
Nathan
