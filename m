Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0408574BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiGNLYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbiGNLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:24:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE10DFAE;
        Thu, 14 Jul 2022 04:24:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="286227621"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="286227621"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:24:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="738243957"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:24:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1oBwx5-001DBX-2t;
        Thu, 14 Jul 2022 14:24:15 +0300
Date:   Thu, 14 Jul 2022 14:24:15 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>, knaerzche@gmail.com,
        Collabora Kernel ML <kernel@collabora.com>,
        bob.beckett@collabora.com,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-staging@lists.linux.dev, nicolas.dufresne@collabora.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/6] bitops: bitmap helper to set variable length values
Message-ID: <Ys/835VdAYRVYdXW@smile.fi.intel.com>
References: <20220713163201.136202-1-sebastian.fricke@collabora.com>
 <Ys8Txuq9/u/EL6sj@yury-laptop>
 <CAHp75VeOLfKw4-+Dpn54yy6j=tdiBNA_2Kvhj7mUUjTD-M_vYA@mail.gmail.com>
 <Ys8gpl3m+vvEM7Sy@yury-laptop>
 <CAHp75VeGSWoq-a10nA9NLKBEX7L_eiL0zPMJHUbX=c64wG8hkg@mail.gmail.com>
 <Ys8uKUKErpoWL873@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys8uKUKErpoWL873@yury-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 01:42:17PM -0700, Yury Norov wrote:
> On Wed, Jul 13, 2022 at 10:14:24PM +0200, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 9:44 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > On Wed, Jul 13, 2022 at 09:10:33PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Jul 13, 2022 at 8:56 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > > > On Wed, Jul 13, 2022 at 06:31:59PM +0200, Sebastian Fricke wrote:

...

> > > > > I'd suggest you to try implementing
> > > > >         bitmap_copy_from(dst, src, dst_off, len)
> > > > > or even
> > > > >         bitmap_copy_from(dst, dst_off, src, src_off, len)
> > > > > if you expect that you'll need more flexibility in the future.
> > > >
> > > > Do you think it would be useful?
> > > >
> > > > We have bitmap_replace() & bitmap_remap(). Wouldn't that be enough?
> > >
> > > bitmap_replace and bitmap_remap have no an 'offset' parameter.
> > 
> > True.
> > 
> > But then it's a bit too generic to have this src_off, no?
> 
> That's why I said:
> 
> > > > > if you expect that you'll need more flexibility in the future.
> 
> My preferred option is bitmap_copy_from(dst, src, dst_off, len).
> 
> > I would rather expect for asymmetrical bitmaps that the other side
> > will be either one of the fixed width types (it makes sense to have
> > for 32- or 64-bit arguments.
> 
> Look at patch #6 - it copies 1,4,5,9,10,32,37... - pretty much a random
> number number of bits.

It's too poor randomness, as u64 covers all what in patch 6.

> > When you have a source bitmap of x bits and  you would like to copy it
> > into a y-bit one, I would think that either you have a small amount of
> > bits in x anyway, or x is a full-sized bitmap (same order as y).
> 
> It sounds like a speculation to me. Why shouldn't we let people to
> copy with an offset any number of bits? 

Because it's a common case. You have a value in the register / variable, which
naturally is one of the POD types. Now you want to inject this into bitmap at
the arbitrary offset. Value itself also needs to be variadic size in bits.

Basically what he is trying to achieve is something like bitfield.h API over
bitmaps. Dunno, if actually bitfield.h in the certain driver wouldn't be
enough.

> > Also
> > keep in mind that granularity is long, so less than long it makes no
> > sense.
> > 
> >   bitmap_copy_from_T(unsigned long *map, start, len, T src),
> > 
> > where T is type, start is the offset in map, len is the amount of bits
> > from src starting from 0. That's what is required in most of the cases
> > I believe.
> 
> But not in Sebastian's case, according to patch #6.

I think it's a case, see above.

-- 
With Best Regards,
Andy Shevchenko


