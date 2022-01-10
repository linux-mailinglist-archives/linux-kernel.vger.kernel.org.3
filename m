Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE048A121
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbiAJUuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:50:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:28678 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232177AbiAJUuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:50:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242132345"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="242132345"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:50:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="472196811"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:50:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1n71bG-0090oG-RR;
        Mon, 10 Jan 2022 22:49:06 +0200
Date:   Mon, 10 Jan 2022 22:49:06 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Roman Lebedev <lebedev.ri@gmail.com>,
        Richard Smith <richard@metafoo.co.uk>
Subject: Re: drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking
 address of packed member 'pixelformat' of class or structure
 'v4l2_pix_format_mplane' may result in an unaligned pointer value
Message-ID: <YdybwqL1NtF39Wyd@smile.fi.intel.com>
References: <202201081852.uTfBqS4b-lkp@intel.com>
 <CAHp75VfS-4B1AwzawCR7VVAxopK6ACcY63ig07OqY32MswfoOQ@mail.gmail.com>
 <CAKwvOdk9XFOL2RAh5+FKWMR9jWFwrS=J+ogwUPj5OOLXcr-iSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk9XFOL2RAh5+FKWMR9jWFwrS=J+ogwUPj5OOLXcr-iSQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:44:12AM -0800, Nick Desaulniers wrote:
> On Sun, Jan 9, 2022 at 6:26 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > +Nick Desaulniers
> >
> > Any ideas on how to fix this?
> 
> Not obviously.

Thanks for looking into this!

> This code probably will trigger a splat when run with
> UBSan though.
> 
> I'm curious if the structure needs to be packed for interfacing with
> hardware or some ABI, or whether we could add an explicit alignment to
> the member if that would be ok (which may add back some padding)?

Looking into it I think removing packed attribute brings a regression
immediately on 64-bit platforms since u32 member followed by u8.

> Otherwise, I suspect to actually access this properly we may have
> macros for performing underaligned loads and stores?  I suspect you'd
> read potentially unaligned data into an aligned copy, then do
> operations on that, at which point printing the address of the copy is
> legal, but perhaps useless.

Current code does this:

	val = *fourcc & ~BIT(31);
	...
	for (i = 0; i < sizeof(*fourcc); i++) {
	...
	strcpy(p, *fourcc & BIT(31) ? " big-endian" : " little-endian");
	...
	p = special_hex_number(p, output + sizeof(output) - 2, *fourcc, sizeof(u32));

If unaligned access is not good it will crash on some architectures AFAIU.

So, it should use get_unaligned() in the first place.

> Perhaps:
> 
> -       __u32                           pixelformat;
> +       __u32                           pixelformat __aligned(4);

This looks weird, however I can't immediately see any side effects of it.
What if the address of the entire structure is unaligned, would we have a
gap here? In any case I wouldn't go this way.

>         __u32                           field;
>         __u32                           colorspace;
> 
> Perhaps we could tighten up this warning in clang; we don't have any
> holes before this member, so I _wouldn't_ have assumed
> __attribute__((packed)) would have caused the address of pixelformat
> member of an instance of struct v4l2_pix_format_mplane to ever be
> underaligned.
> 
> > On Sun, Jan 9, 2022 at 3:53 PM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi Sakari,
> > >
> > > FYI, the error/warning still remains.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   d1587f7bfe9a0f97a75d42ac1489aeda551106bc
> > > commit: e927e1e0f0dd3e353d5556503a71484008692c82 v4l: ioctl: Use %p4cc printk modifier to print FourCC codes
> > > date:   11 months ago
> > > config: mips-buildonly-randconfig-r002-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081852.uTfBqS4b-lkp@intel.com/config)
> > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 32167bfe64a4c5dd4eb3f7a58e24f4cba76f5ac2)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install mips cross compiling tool for clang build
> > >         # apt-get install binutils-mips-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e927e1e0f0dd3e353d5556503a71484008692c82
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout e927e1e0f0dd3e353d5556503a71484008692c82
> > >         # save the config file to linux build tree
> > >         mkdir build_dir
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/hid/ drivers/media/v4l2-core/ fs/
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_pix_format_mplane' may result in an unaligned pointer value [-Waddress-of-packed-member]
> > >                            mp->width, mp->height, &mp->pixelformat,
> > >                                                    ^~~~~~~~~~~~~~~
> > >    include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
> > >            printk(KERN_CONT fmt, ##__VA_ARGS__)
> > >                                    ^~~~~~~~~~~
> > > >> drivers/media/v4l2-core/v4l2-ioctl.c:347:37: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_sdr_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
> > >                    pr_cont(", pixelformat=%p4cc\n", &sdr->pixelformat);
> > >                                                      ^~~~~~~~~~~~~~~~
> > >    include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
> > >            printk(KERN_CONT fmt, ##__VA_ARGS__)
> > >                                    ^~~~~~~~~~~
> > > >> drivers/media/v4l2-core/v4l2-ioctl.c:353:5: warning: taking address of packed member 'dataformat' of class or structure 'v4l2_meta_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
> > >                            &meta->dataformat, meta->buffersize);
> > >                             ^~~~~~~~~~~~~~~~
> > >    include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
> > >            printk(KERN_CONT fmt, ##__VA_ARGS__)

-- 
With Best Regards,
Andy Shevchenko


