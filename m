Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8169C4A31D6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 21:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353097AbiA2Ua6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 15:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349590AbiA2Uaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 15:30:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17598C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DBAF60B40
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 20:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68E3C340E5;
        Sat, 29 Jan 2022 20:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643488253;
        bh=YBtNVYCnYa+w/9Av4t+qwzrK/yfyOR1cVMkdIr9KKHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLPElV0P/nylfr2vGpGoaNeGXgYeV+cJGVc3wF1RjVoK7N51yb/QjhmVTBzbW37d0
         /hTodWTrNZfc9RuJYw9eLMwnuyHl3nrb1FcjDpEJEQVZlEUSwNttNLsIqs9n5YAHdu
         R1jjqg+P82dw0NfdIfxSXsYTabMhrP+5UJbKjS6a2X9W0u/7azrGII9vxOpD4aTDb5
         CLswCEMpLeBda8CTeK+WEftqeg/FAmcF0bkQg2OUUuiTB4LlCOcD71XCTydA3bubOq
         xDXLRzUeHmQDGHLCV3u/5i+oBqgULCyG1yx1mGTrGKLF91KV6KzkU21O9TwSf1r5hF
         akYhw1C2M2T5Q==
Date:   Sat, 29 Jan 2022 13:30:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: drivers/input/touchscreen/ads7846.c:705:24: warning: taking
 address of packed member 'data' of class or structure 'ads7846_buf' may
 result in an unaligned pointer value
Message-ID: <YfWj+hnMiK8dECOp@dev-arch.archlinux-ax161>
References: <202201300020.SS6KSznh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201300020.SS6KSznh-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 12:10:55AM +0800, kernel test robot wrote:
> Hi Dmitry,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   cb323ee75d24e7acc2f188d123ba6df46159cf09
> commit: 415e915fdfc775ad0c6675fde1008f6f43dd6251 Merge tag 'v5.11' into next
> date:   11 months ago
> config: mips-randconfig-r025-20220129 (https://download.01.org/0day-ci/archive/20220130/202201300020.SS6KSznh-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=415e915fdfc775ad0c6675fde1008f6f43dd6251
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 415e915fdfc775ad0c6675fde1008f6f43dd6251
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/ drivers/input/touchscreen/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/input/touchscreen/ads7846.c:705:24: warning: taking address of packed member 'data' of class or structure 'ads7846_buf' may result in an unaligned pointer value [-Waddress-of-packed-member]
>            value = be16_to_cpup(&buf->data);
>                                  ^~~~~~~~~
>    1 warning generated.

Same root cause as https://lore.kernel.org/r/YenXz+RznXBuJMSR@dev-arch.archlinux-ax161/.

Fixed with https://lore.kernel.org/r/20220125221925.3547683-2-nathan@kernel.org/.

Sorry for the noise, this should have only been sent to our mailing
list, not maintainers.

Cheers,
Nathan
