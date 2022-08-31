Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D884B5A8030
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiHaO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:29:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD6BF6C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661956175; x=1693492175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qyWaJgg5ZlMcEtWvcwD0jtBBUGQG4+nXNDb6LrRQaGU=;
  b=hEev4SDwWxzP6U8xs0dRkJLWRmfvBgG8+vw2oqbdx4Wjl7vPqJ8Irzo7
   2BLmu2/Tn6bKjXNmVO5s4h9QgAR9eABxiW8UQhIT8iRNSwLznJLbBhyIB
   AKfhgWyz/ZANApXp6sOGjfG1RO/rmkKCR7LiKdPDv0iRfGp4O96ehse0N
   snF8x4PQgx6PQ+Trg//FgkA9DhgHFEbSDTDvgJrlCT7jiAIqWREW1p8Zf
   5zllOTP7kjATXeTNpbAMb4pXpg/lrBAF4Np9nBj0dN24wld5CDl8CCqpJ
   QYq4yCRK84wQ9ZI6ZgJi+DZu4NwEJnqS0w/cPyeRlgyU16rABj/FvFCGj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296243199"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296243199"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:29:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="645246916"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:29:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oTOih-006Q3S-0a;
        Wed, 31 Aug 2022 17:29:31 +0300
Date:   Wed, 31 Aug 2022 17:29:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v5] regmap: Support accelerated noinc operations
Message-ID: <Yw9wSoMUhZVqVhkw@smile.fi.intel.com>
References: <20220816204832.265837-1-linus.walleij@linaro.org>
 <Yw46t9Y1PYoMLSKq@smile.fi.intel.com>
 <CACRpkdZEVYDAPbBkATr=6sea8gu6JmuAjU_sDRV=ZgswfhD-Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZEVYDAPbBkATr=6sea8gu6JmuAjU_sDRV=ZgswfhD-Kg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 03:53:15PM +0200, Linus Walleij wrote:
> On Tue, Aug 30, 2022 at 6:36 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Aug 16, 2022 at 10:48:31PM +0200, Linus Walleij wrote:

...

> > > +             dev_info(map->dev, "%x %s [", reg, write ? "<=" : "=>");
> > > +             for (i = 0; i < val_len; i++) {
> > > +                     switch (val_bytes) {
> > > +                     case 1:
> > > +                             pr_cont("%x", u8p[i]);
> > > +                             break;
> > > +                     case 2:
> > > +                             pr_cont("%x", u16p[i]);
> > > +                             break;
> > > +                     case 4:
> > > +                             pr_cont("%x", u32p[i]);
> > > +                             break;
> > > +#ifdef CONFIG_64BIT
> > > +                     case 8:
> > > +                             pr_cont("%llx", u64p[i]);
> > > +                             break;
> > > +#endif
> > > +                     default:
> > > +                             break;
> > > +                     }
> > > +                     if (i == (val_len - 1))
> > > +                             pr_cont("]\n");
> > > +                     else
> > > +                             pr_cont(",");
> > > +             }
> >
> > I'm wondering why we can't use hex_dump_to_buffer() approach? Or even better,
> > introduce eventually dev_hex_dump() (as it's done for seq_file and printk)
> > and use it.
> 
> Hmmmmm this is under regmap_should_log() which turns on
> dev_info() simple prints like x <= y and y => x to the console.
> e.g. dev_info(map->dev, "%x <= %x\n", reg, val);
> It would be rather print_hex_dump() the problem being
> that hex_dump_* accessors assumes line oriented
> linebufs "must be 16 or 32" (values per line), and here we probably
> don't want that:
> we want to show what we shoehorned into the FIFO.

Perhaps we may add a modifier to %ph (like 2,4,8) to group together several
bytes and use it here instead?

-- 
With Best Regards,
Andy Shevchenko


