Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0A659C6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiHVSsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbiHVSrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FA73AB1C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1459601C6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96193C433D6;
        Mon, 22 Aug 2022 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661194035;
        bh=WKJbLZ7cEwqX9z2InyWLGiM4hroAgjIoOKEaIa/kXhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sAvka1sD66qLYgvf6+zVHt29xezOIY1oqEqZ8YJDtqzB2SkEG6RstYlbVNTz4KpSr
         Ud5Tqz+mQ9HUsrJDV3zA/A2NHtgJqwFUcCxdFSDPkzaBuhQLk0QTttGsCm4rHtNJK5
         njEO+de/14AvXbnMfQMp4+ZFnLPfpn3q8aJv8utGdmMzl+JHyHSZK2vnwLLF8UStNs
         poMJN1vxPbSVqiSxIHTcD70xmWHXgasYhNOTOy5FPnit+jnKAXTKXNCkX9z9rIFC9d
         wRjywUeaS+9Sup2HHL6nwlDPDNuawvYZSCqF3ZfmSyi/J65Ga2qIyQ4yatEkANnGJG
         zdg/m/DlRLy1A==
Date:   Mon, 22 Aug 2022 11:47:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [linux-stable-rc:queue/4.14 13/175] Makefile:877: *** Recursive
 variable 'LDFLAGS' references itself (eventually). Stop.
Message-ID: <YwPPMK3ouRi0wJBT@dev-arch.thelio-3990X>
References: <202208210645.72NkUj0g-lkp@intel.com>
 <CAKwvOd=VD-Oxtko-tq=GjcLZg5tNj_cMZwMhw7NqBbOYLxuidA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=VD-Oxtko-tq=GjcLZg5tNj_cMZwMhw7NqBbOYLxuidA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:05:50AM -0700, Nick Desaulniers wrote:
> On Sat, Aug 20, 2022 at 3:51 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.14
> > head:   ed8a2f4d20af62ebd64e4092d988d4ae6b54657c
> > commit: 17c47886b521ae64a733f41364def799797e45ef [13/175] Makefile: link with -z noexecstack --no-warn-rwx-segments
> > config: arc-randconfig-r043-20220821 (https://download.01.org/0day-ci/archive/20220821/202208210645.72NkUj0g-lkp@intel.com/config)
> > compiler: arc-elf-gcc (GCC) 7.5.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=17c47886b521ae64a733f41364def799797e45ef
> >         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >         git fetch --no-tags linux-stable-rc queue/4.14
> >         git checkout 17c47886b521ae64a733f41364def799797e45ef
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> Makefile:877: *** Recursive variable 'LDFLAGS' references itself (eventually).  Stop.
> 
> Thanks for the report!
> 
> That's not something that I've seen before...
> 
> Masahiro, does ARCH=arc do something special to LDFLAGS?
> 
> This report is a randconfig against a branch of stable for arc, so
> guessing this might be more obscure than usual.

I suspect this would be fixed with commit ce99d0bf312d ("kbuild: clear
LDFLAGS in the top Makefile"), which backports cleanly to 4.14.

Cheers,
Nathan
