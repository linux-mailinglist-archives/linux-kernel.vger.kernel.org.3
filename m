Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6E64D0280
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbiCGPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243667AbiCGPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:10:58 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F4F506C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646665803; x=1678201803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rIZNWu/jDNvC0pIdfE54bHckX5zmXz860wwR0x9gJJ4=;
  b=hBWb4Q8Hl+jSrT8RV8RlTQAAWvR2RV1wAqzkqWGhOeuESxVw9NNvCk42
   8O+DZNVUsUH8RLCANRxd85u6b7kwgmcb9f+UgbEjVb8vSDbFkDX90Pl5L
   levo1lUWFjl9JdFRfM2rq5CtYU4X7TbJhXv781JFHyneOkoAXwzpfnFUf
   EGtM9thYU0ygFzgYsvn0WxqlSU/j2+kUJ43GObNT1qaQjh/5baD+8evBp
   efXlbZoph1G6shQfuuyh3QeEHOsRxK8bWdCB9e4cLRun4k9h8WjFiImhs
   b3NLBOWs0E/R/JnEwQuIhbqSPshvi54KyZxkAGv8QVvVCPuPYCdhWiQAL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254601267"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254601267"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 07:10:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="495088052"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2022 07:10:00 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 227F9wmO005849;
        Mon, 7 Mar 2022 15:09:59 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
Date:   Mon,  7 Mar 2022 16:07:50 +0100
Message-Id: <20220307150750.1762040-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAMZ6RqKaq8GiPYMyL4D1ksUtgketAF905oBgwKuGLtk7BmobZw@mail.gmail.com>
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr> <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com> <20220307105810.1747024-1-alexandr.lobakin@intel.com> <CAK8P3a07uXLTpNz3t1oMwz_imZOTs+1Fw5hhELjUrJ8Zs=8bpQ@mail.gmail.com> <CAMZ6RqKaq8GiPYMyL4D1ksUtgketAF905oBgwKuGLtk7BmobZw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Mon, 7 Mar 2022 22:50:56 +0900

> Hi Arnd and Alexander,
> 
> Thanks for the support!
> 
> On Mon. 7 Mar 2022 at 21:15, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Mar 7, 2022 at 11:58 AM Alexander Lobakin
> > <alexandr.lobakin@intel.com> wrote:
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Have you fixed W=1 warnings?
> > > > Without fixing W=1 (which makes much more sense, when used with
> > > > WERROR=y && COMPILE_TEST=y) this has no value.
> > >
> > > How is this connected?
> > > When I do `make W=2 path/to/my/code`, I want to see the actual code
> > > problems, not something that comes from the include files.
> > > When I do `make W=2 path/to/new/code/from/lkml`, I want to see the
> > > actual new warnings, not something coming from the includes.
> > > It's much easier to overlook or miss some real warnings when the
> > > stderr is being flooded by the warnings from the include files.
> > > I'm aware there are some scripts to compare before/after, but I
> > > don't want to use them just because "this has to value".
> > > I don't want to do `make W=2 KCFLAGS='-Wno-shadow -Wno-type-limits'`
> > > because then I'm not able to spot the actual shadow or type limit
> > > problems in my/new code.
> > > I fixed several `-Wshadow` warnings previously in the include files
> > > related to networking, and *nobody* said "this has no value" or
> > > NAKed it. And `-Wshadow` has always been in W=2.
> >
> > I agree: if we decide that W=2 warnings are completely useless, we should
> > either remove the option to build a W=2 kernel or remove some of the warning
> > flags that go into it. My feeling is that both W=2 in general, and the
> > Wtype-limits have some value, and that reducing the number of W=2 by
> > 30% as this patch does is a useful goal by itself.
> >
> > A different question is whether this particular patch is the best
> > workaround for the warnings, or if a nicer alternative can be found,
> > such as moving -Wtype-limits to W=3,
> 
> I disagree with moving it to W=3 for two reasons:
> 
>   1/ This would just move the issue elsewhere. If I had to
>   compile with W=3 (which I admittedly *almost* never do), the
>   -Wtype-limits spam would still be there.
> 
>   2/ After this patch, the number of remaining -Wtype-limits
>   drops to only 431 for an allyesconfig (and I guess that there
>   are a fair amount of true positives here). This warning is not
>   *as broken* as people think. W=2 is a good place I think.

Agree, W=2 is the best place for -Wtype-limits to me.
I've never seen a single useful warning on W=3, but there were
lots of them on W=2 which revealed some real bugs. That said, it
makes no sense at all to even try to check all new code from LKML
for warnings with W=3, but it's actually feasible to make it build
cleanly with W=2 most of times.

Re -Wtype-limits in particular, it's not useless at all.
For example, people tend to make the following mistake:

	unsigned int i;

	for (i = 0; i ...) {
		ret = setup_something(array[i]);
		if (ret)
			goto unroll;
	}

unroll:
	while (--i)
		unroll_something(array[i]);

The loop will never end as `i` was declared as unsigned.
-Wtype-limits catches this.

Not speaking of checking unsigned variables on < 0:

	unsigned int num;

	/* calculate_something() returns the number of something
	 * or -ERRNO in case of an error
	 */
	num = calculate_something();
	if (num < 0)
		...

Catches as well.

> 
> That said, moving it to W=3 would still solve the core issue: W=2
> being spammed. Definitely not my favorite solution, but still an
> acceptable consensus for me.
> 
> > or using an open-coded variant
> > of __is_constexpr() that includes the comparison in a way that avoids the
> > warning.
> 
> This is easier said than done. This is the __is_constexpr()
> macro:
> 
> | #define __is_constexpr(x) \
> |     (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> 
> Good luck doing an open-coded variant of it!
> 
> What I mean here is that there definitely might be a smarter
> way than my solution to tackle the issue, but I could not see
> it. If you have any concrete ideas, please do not hesitate to
> share :)
> 
> 
> Yours sincerely,
> Vincent Mailhol

Thanks,
Al
