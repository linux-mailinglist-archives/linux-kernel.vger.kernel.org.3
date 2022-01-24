Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10828498725
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244753AbiAXRle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:41:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40216 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244741AbiAXRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:41:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D4C061301
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 17:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B5CC340E5;
        Mon, 24 Jan 2022 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046092;
        bh=m7yPjYBJToplRJdYzEt7/9EfxmLG6PmjsXG/AvgQC8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esoRmQ5UrtkmRkcVg7w1dPm78wLUFkXx1e6hL9wijhrRAB+XmBv4zUDUFN/LdKnCI
         u/B937JgzuWLNOVWecvtCzNUd7kX6gErRQgIGq5XB1sfStCc8Stg1T1T1a6WChjZ3Y
         i8fltceG8/cvS4/9m6vT7f0uAu530ISGC2AMpXlXmXVNyxMqKf0Rj31P87XKUeVa66
         6wEx44b7vCp51IIkIFGPDCAltZ7HZrtb5v+LgRoV/jnp1Lz5tyHuPb4A8HORiERgtM
         UGtc2mcUrrUUxEbzTGQhIUOVEbhKTmi6v1pYngc6c7tim8w3I6sToHwni4FMXwYVtl
         aZ2OQhgB4ZXcg==
Date:   Mon, 24 Jan 2022 10:41:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: fs/ntfs3/fsntfs.c:2248:41: warning: taking address of packed
 member 'de' of class or structure 'NTFS_DE_SII' may result in an unaligned
 pointer value
Message-ID: <Ye7kyA3yJupMLSD2@archlinux-ax161>
References: <202201242326.uQ3OazUi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201242326.uQ3OazUi-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:21:59PM +0800, kernel test robot wrote:
> Hi Konstantin,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
> commit: 6e5be40d32fb1907285277c02e74493ed43d77fe fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
> date:   5 months ago
> config: mips-buildonly-randconfig-r001-20220122 (https://download.01.org/0day-ci/archive/20220124/202201242326.uQ3OazUi-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7b3d30728816403d1fd73cc5082e9fb761262bce)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5be40d32fb1907285277c02e74493ed43d77fe
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6e5be40d32fb1907285277c02e74493ed43d77fe
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/ntfs3/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    fs/ntfs3/fsntfs.c:1874:9: warning: variable 'cnt' set but not used [-Wunused-but-set-variable]
>            size_t cnt, off;
>                   ^
> >> fs/ntfs3/fsntfs.c:2248:41: warning: taking address of packed member 'de' of class or structure 'NTFS_DE_SII' may result in an unaligned pointer value [-Waddress-of-packed-member]
>            err = indx_insert_entry(indx_sii, ni, &sii_e.de, NULL, NULL);
>                                                   ^~~~~~~~
>    2 warnings generated.

This warning has the same root cause as
https://lore.kernel.org/r/YenXz+RznXBuJMSR@dev-arch.archlinux-ax161/.

Intel folks, would it be possible to limit instances of
-Waddress-of-packed-member with mips randconfigs to our mailing list for
the reason I note in the link above?

Cheers,
Nathan
