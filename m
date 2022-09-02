Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A085AB537
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiIBPbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiIBPbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:31:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72DEEF1D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E942661ED1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059E0C433D6;
        Fri,  2 Sep 2022 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662131552;
        bh=iQV0UtvNqJy1fdVQmW025M78GOmVWquCHJiS7nGRwKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irm7AVNsKa89ntN7Y2LSJe9M/ZxnSpqDlBZv7Kv99r/g4xU82Nmv5mLxb+zROds6u
         oBQAMMFOki5+gq9og1zCxNNj7JBT+VOt84/QTMg0CvmTPKG5H6YYOrjhKLijir1rJH
         cGqvoCkRVw0z8gaPF7Es2TyLVN3fRhEdFOtSeUpvKSWIikqSUC5ZAxEtmi+9KFtpdT
         YT1j8nXkllRolXZZM0fxabABcuxvZJjPdywFJmmQSUQbpSY8mDxiLR0ekrq1Wqu3sB
         7byOp29GSm1iQJA8tKocek2ylHNInGxsN8l6LxRyp54bVj/wC2rFAmBunuEuAD9CC6
         DAAoRDh7lOlpA==
Date:   Fri, 2 Sep 2022 08:12:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [jpoimboe:s390 2/2] Unsupported relocation type: 26
Message-ID: <YxIdXugKymRtV9zW@dev-arch.thelio-3990X>
References: <202209021319.l7dwyum7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209021319.l7dwyum7-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 01:51:11PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git s390
> head:   fa09ffb73e4d64424faef5988a1e993317db77c5
> commit: fa09ffb73e4d64424faef5988a1e993317db77c5 [2/2] s390: Compile relocatable kernel without -fPIE
> config: s390-randconfig-r044-20220901
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=fa09ffb73e4d64424faef5988a1e993317db77c5
>         git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
>         git fetch --no-tags jpoimboe s390
>         git checkout fa09ffb73e4d64424faef5988a1e993317db77c5
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> Unsupported relocation type: 26

Looks like 26 is R_390_GOTENT according to
https://github.com/llvm/llvm-project/blob/ee761374f797a47919ec8f9f49f9b8b1b20573e8/llvm/include/llvm/BinaryFormat/ELFRelocs/SystemZ.def.

Cheers,
Nathan
