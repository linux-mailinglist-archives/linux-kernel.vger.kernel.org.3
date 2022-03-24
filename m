Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530D74E610B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349202AbiCXJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCXJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:23:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D19E9D7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:22:03 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238269683"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="238269683"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:22:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="552800752"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 02:22:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nXJeo-005ih8-8L;
        Thu, 24 Mar 2022 11:21:26 +0200
Date:   Thu, 24 Mar 2022 11:21:25 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] auxdisplay: lcd2s: Use array size explicitly in
 lcd2s_gotoxy()
Message-ID: <Yjw4Fdo1ByfxaFdJ@smile.fi.intel.com>
References: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
 <20220308151119.48412-4-andriy.shevchenko@linux.intel.com>
 <CANiq72mVnHWi-tZmT4g+2Y96eYu=Hm=oMKn6RkwpXWh7ARATAA@mail.gmail.com>
 <CAHp75VfMHWObRFs=-fOQnkV=KkAKWuqRF=JLUfzqruTa2U9XjQ@mail.gmail.com>
 <CANiq72=0NLgH4rmRNXMTo2TXLd9KcqEZ2yX40ytcTxSYkq1xKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=0NLgH4rmRNXMTo2TXLd9KcqEZ2yX40ytcTxSYkq1xKQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:15:57PM +0100, Miguel Ojeda wrote:
> On Sat, Mar 19, 2022 at 12:37 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > With [] and parameters not being bytes by type one needs an additional
> > processing step to figure that out. When I see u8 ...[3] I immediately
> > understand that there are 3 _bytes_. Moreover, [] is error prone when
> > one may add something to the buffer with the expectation that it will
> > work somehow (for example, with an old device you need 3, with new
> > device revision you need 4 bytes and passing 4 bytes breaks the old
> > device). Of course most of that quite likely won't happen.
> 
> I agree it is better to be explicit -- I just found the commit message
> very confusing, i.e. the type will always be `u8`, what is unclear is
> the total length, not so much the type change.
> 
> I think the best approach when one needs an array to stay a particular
> size due to some external constraint (like hardware) would be to use a
> `static_assert` with a comment mentioning where the requirement comes
> from. Or at least a comment above the array.
> 
> Either way, I applied this one too to -next a few days ago. Thanks!

Thanks!

-- 
With Best Regards,
Andy Shevchenko


