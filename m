Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80789536DBD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 18:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiE1QWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiE1QWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 12:22:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105E914035
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 09:21:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E6260F44
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 16:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0010C34100;
        Sat, 28 May 2022 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653754918;
        bh=sqSBn24zPcOjIxRI6PxDwB00rh/f+IXnPfvzWXb47YM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACIFDzhforpeM65iGieDGJO0biYvFYCmCSU4GakeonKR79bODM0vNHf2kGRoMFVYl
         znbAF03J8r4RTVSKz7hUI25ap5nQrsYndlbXp1NfIRLeC7flspFAqcwJbDweBJLYJd
         UzJ7FPg21fTFArGUXIeNrz2sYfkzdiEC9Nrwm0SF1gzrAT2VD0BY7LZ3LFtCG7QDPP
         rw1ZINONrDUiJgMKkSRwfFjNK4z6mx3Fl5GGLonma4qm1PfXQsl9tq7/iTRF/yQ+lY
         WZ+K6cDxn4kD5FTMibGwykpCZL9W/lKKnoVDMJ0iEdB3hvlnbAq8939UMzvQ8OCqSZ
         Kb+33DZev4JTg==
Date:   Sat, 28 May 2022 09:21:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: llvm-objcopy: error: invalid output format: 'elf64-s390'
Message-ID: <YpJMIz/QjDW5IQGr@dev-arch.thelio-3990X>
References: <202205290045.gOvUOkt3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205290045.gOvUOkt3-lkp@intel.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 12:04:48AM +0800, kernel test robot wrote:
> Hi Heiko,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9d004b2f4fea97cde123e7f1939b80e77bf2e695
> commit: adda746629b4a3950f313bc645fa0e54daee871c s390/purgatory: workaround llvm's IAS limitations
> date:   11 days ago
> config: s390-randconfig-c005-20220527 (https://download.01.org/0day-ci/archive/20220529/202205290045.gOvUOkt3-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adda746629b4a3950f313bc645fa0e54daee871c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout adda746629b4a3950f313bc645fa0e54daee871c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> llvm-objcopy: error: invalid output format: 'elf64-s390'

This is expected, as llvm-objcopy needs support for s390:
https://github.com/ClangBuiltLinux/linux/issues/1530

Please use GNU objcopy for the time being by explicitly providing
OBJCOPY=${CROSS_COMPILE}objcopy to make.

Cheers,
Nathan
