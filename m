Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABE51B1FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356313AbiEDWgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiEDWgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:36:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927442CCB2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FCA6B82791
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 22:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D61C385A5;
        Wed,  4 May 2022 22:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651703560;
        bh=5sSmnc3ozns8rvYY0p6S1jYZuv4ruYLbzxRnarZYMTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LD4YxiZzejUE8ulKUUEgX+XPRlJiMnV+Lqb+RxdPUs+37Xqjw1fzwNGQIeME7dd4d
         lwQJ1dW09gNCa5ECwoZ761/hEfrIjE/xh7Y4tR5n1PflzBpILFMADFA8BUIUbutoBd
         WL0z5wdebvnLCGceHGR7Edn4EiWbhBFNCNTBWVl7Ximr94ekTmHnroeaMmz5pMV/5o
         nw9JVSNC3yaQ8YBL7PWp0HHAb5iq8kBN5/6uoAPFy5mhklulKljVOgerh7hSEFAneN
         WHNoqK7ePp4vBqMZNaD2NjF85eK+J6AHECddk0MZFSsn9sqYlxQcEvr4qvOz20ovVK
         +MquWSF7srenQ==
Date:   Wed, 4 May 2022 15:32:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: ld.lld: error: inline assembly requires more registers than
 available at line 523
Message-ID: <YnL/BVvd78zIkwil@dev-arch.thelio-3990X>
References: <202205020637.JVJo3blw-lkp@intel.com>
 <YnK8f7cqMoHxSi0C@dev-arch.thelio-3990X>
 <CAJ6HWG5P6LXEY80tcXxtfvnPnhiNcqUvV+xyKygLbcw37UFvyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ6HWG5P6LXEY80tcXxtfvnPnhiNcqUvV+xyKygLbcw37UFvyw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Wed, May 04, 2022 at 03:13:56PM -0300, Leonardo Bras Soares Passos wrote:
> On Wed, May 4, 2022 at 2:55 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Mon, May 02, 2022 at 06:29:38AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
> > > commit: ba1f77c546966c12d86220d078e5838dcaeab348 x86/kvm: Fix compilation warning in non-x86_64 builds
> > > date:   2 months ago
> > > config: i386-randconfig-a012-20220502 (https://download.01.org/0day-ci/archive/20220502/202205020637.JVJo3blw-lkp@intel.com/config)
> > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba1f77c546966c12d86220d078e5838dcaeab348
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout ba1f77c546966c12d86220d078e5838dcaeab348
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> ld.lld: error: inline assembly requires more registers than available at line 523
> > > >> ld.lld: error: inline assembly requires more registers than available at line 523
> > >
> >
> > I don't think this bisection result is correct; this error is visible at
> > v5.17-rc3, which this commit is based on. This is likely the same root
> > cause as https://github.com/ClangBuiltLinux/linux/issues/1589, just with
> > LTO. I'll reduce something down and comment there if it turns out to be
> > different.
> >
> > Cheers,
> > Nathan
> >
> 
> Hello Nathan,
> I went down on this issue, but I have no idea how to proceed. These
> are my findings:
> - This commit (ba1f77c546966c12d86220d078e5838dcaeab348) fixes the
> build, thus allowing this error to happen later (in LTO stage)
> - The commit that introduced this issue was 69d0db01e210, due to removing :
>    ubsan-cflags-$(CONFIG_UBSAN_OBJECT_SIZE)       += -fsanitize=object-size
> - Only by having this flag enabled in ubsan-cflags-y on
> torvalds/master causes the build to succeed

Ah, thanks for that investigation!

> At this point, given the commit message in 69d0db01e210 I was thinking
> of finding & fixing the code that causes the ld.lld error to happen,
> but I was lacking the skills to extract any filename from LTO step.

Right, this is not always easy with full LTO :( unfortunately, this
issue is not reproducible with either no LTO or ThinLTO... When issues
like this have come up in the past, I have had success linking
individual object files/archives but that has not worked for this issue.
I am going to try and bisect this randconfig against a defconfig and see
if there is a minimal set of configs that reproduces this issue, which
might make it easier to see what is going on here.

> But it's also possible to create a patch just adding
> 'ubsan-cflags-$(CONFIG_SOMETHING)      += -fsanitize=object-size'
> and fix this build.

Right, although that is basically reverting 69d0db01e210 for just that
configuration, which we don't want to do for the reasons outlined in
that commit message.

I'll see what comes of this config bisect.

Cheers,
Nathan
