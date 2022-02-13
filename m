Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3DF4B3B47
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiBMMT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:19:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiBMMTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:19:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2D15C874
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mtMBuSUIwLBq6zU4FNXKoFGq1DKPWDiuJ29Lf1Fid6w=; b=hTUHOIkY3ApbK8ypnrZJZlishe
        zQ2VhuOpyjNP6XEo+HYGiINqaa+ni697oCoRZK3l1iRF8b39MZ1XrJAzvqIQylCbtJS0QkpGKICt3
        1sYlYfwrigO6Q7jz8A9iSkeJv3A7qQobNsDJbR69/UPG/DC6PGgaaMO/tpxLwvt3nwSkr4d3foqE2
        0g5DPM3B7idK9ddj7nHZTq4axAPUXTD9vC50+psbiyA4I6RJRIy0bWUE0noANjE5R4gDfD61XtLg4
        Yc+gFnXP+WRKQeDUpLRj5I7BnwsC1XoTl+uEMbHc164Gxme984MHOwYlaUCMS8hfNjESb+r8Y9UBg
        6o/1yoTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJDqs-00C0MP-Fo; Sun, 13 Feb 2022 12:19:38 +0000
Date:   Sun, 13 Feb 2022 12:19:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
Subject: Re: include/linux/build_bug.h:78:41: error: static assertion failed:
 "offsetof(struct page, compound_head) == offsetof(struct folio, lru)"
Message-ID: <Ygj3Wop0i5Ld0gXu@casper.infradead.org>
References: <202202131828.VxAopBqR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202131828.VxAopBqR-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 07:00:16PM +0800, kernel test robot wrote:
> config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131828.VxAopBqR-lkp@intel.com/config)
> compiler: hppa64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b230db3b8d373219f88a3d25c8fbbf12cc7f233
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7b230db3b8d373219f88a3d25c8fbbf12cc7f233
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare

There's something weird going on here.

If I just download & install gcc-11-hppa64-linux-gnu from Debian, this
config file builds just fine.

If I invoke make.cross as you have it here, I see the same error you
report.

Adding 'V=1' to this, shows:
  sh ../scripts/atomic/check-atomics.sh
  /home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/hppa-linux-gcc [...]

which is weird, right?  It's not hppa64, and it's not gcc-11.2.  So my
suspicion here is that there's some bug in your tooling which is reporting
a bogus error.  You're probably better situated to debug this further
than I am.

Oh, and I checked, in case the filename was confusing me:
$ /home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/hppa-linux-gcc -v
Using built-in specs.
COLLECT_GCC=/home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/hppa-linux-gcc
COLLECT_LTO_WRAPPER=/home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/../libexec/gcc/hppa-linux/9.3.0/lto-wrapper
Target: hppa-linux
Configured with: /tmp/build-crosstools-xh/gcc/gcc-9.3.0/configure --target=hppa-linux --enable-targets=all --prefix=/tmp/build-crosstools-xh/cross --enable-languages=c --without-headers --disable-bootstrap --disable-nls --disable-threads --disable-shared --disable-libmudflap --disable-libssp --disable-libgomp --disable-decimal-float --disable-libquadmath --disable-libatomic --disable-libcc1 --disable-libmpx --enable-checking=release
Thread model: single
gcc version 9.3.0 (GCC)

So it really is a 32-bit hppa build, and it really is gcc 9.3, not 11.2.
