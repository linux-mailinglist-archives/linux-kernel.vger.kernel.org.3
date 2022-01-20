Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F518494FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbiATN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:58:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:61702 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241081AbiATN6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642687086; x=1674223086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MtPKbTXvTh6ak1y3SGppvN/XkoH+ghr8tdmxMpz+yQ4=;
  b=eyMwoDoERkA8T0huKNnqpOrGIEvKiQLDdrDsmkCt1spyW28WBWNtLh1/
   xPYWWohOKC4uBcmjyXuJ47/K60rZLxJ/JA+lzcZtXLV4f19fNPbf7XAYA
   RWKbDLhKxnw357QvXag+6c8wn6/V3ZjRrdt0/Kuy7UUaUl/eAITvPwE5z
   wxE6oksIllUJihL9r+mBd+y1oYcdQirwKo+lVaOmPxorTqlNiXxArxz60
   hMYJB3M5WrQOVBsLrRgfUF39tcRC8QxVDX+J1Q8WOsr/rDrXZUUW3NK9z
   NsU9j5ZLootx44BN52mrxye4LaT1IEvvRBmRZ2CMjo4ntpvTfjFyJYZ0p
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="269759429"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="269759429"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 05:57:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="477793978"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 05:57:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nAXvS-00CWgc-Kv;
        Thu, 20 Jan 2022 15:56:30 +0200
Date:   Thu, 20 Jan 2022 15:56:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yong Mao <yong.mao@mediatek.com>
Subject: Re: [PATCH v4 3/3] mmc: mediatek: add support for SDIO eint IRQ
Message-ID: <YelqDifksEmtMv44@smile.fi.intel.com>
References: <20220119103212.13158-1-axe.yang@mediatek.com>
 <20220119103212.13158-4-axe.yang@mediatek.com>
 <Yehq7L36yfJ8D/j2@smile.fi.intel.com>
 <0b6ef0ce05bb92cd458043be2441101e20166242.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b6ef0ce05bb92cd458043be2441101e20166242.camel@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 01:34:08PM +0800, Axe Yang wrote:
> On Wed, 2022-01-19 at 21:47 +0200, Andy Shevchenko wrote:
> > On Wed, Jan 19, 2022 at 06:32:12PM +0800, Axe Yang wrote:

...

> > > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > 
> > The submitters SoB must be last among all SoB tags. Please, read
> > Submitting
> > Patches document carefully.
> > 
> > > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > 
> > Who is they, why their SoB appeared here?
> 
> Yong Mao is the co-developer of this patch, I will reorder the SoB
> chains.

And you will need to add a corresponding tag.

...

> > > - * Copyright (c) 2014-2015 MediaTek Inc.
> > > + * Copyright (c) 2022 MediaTek Inc.
> > 
> > This doesn't feel right. Why did you remove old years?
> 
> I should keep the publish year 2014 of this driver.
> But I still think range 2014-2022 is the most appropriate way to change
> the copyright time. Over these years, mediatek is keeping maintaining
> this driver continuously. What do you think?

I guess I already showed my opinion on the topic? The common sense tells
me that it should be as simple as '2014-2015,2022' there.

-- 
With Best Regards,
Andy Shevchenko


