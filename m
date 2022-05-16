Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D08528BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbiEPRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344186AbiEPRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:23:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5B366BC;
        Mon, 16 May 2022 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652721782; x=1684257782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z6LbUx/xGNKKivZxZ3fa2EeCKH12QDQRC8tGE+sR4uo=;
  b=NV4pL9QWrBVfmfr7C+7AJc91YfBGrYjuaQz1gGxhXEIrCG9ntJ985+bX
   hRZsczfA6u+3Gutr2mFTCHsyEEXiOkxEeNgKrwTju9IExUf9JZ0Qnra5O
   pJgfGh4L+rfFllST5gHR5YiQpmTYnHeoGc+Jvcb9HuBgzS6gcBo7Rijoq
   QncwmIFJovMwwCRJh0QuTh86GQjK+vfjEK9vMTq6lXbqpOpnhg0CjVYIY
   O+pRRWzem6YRKPcE00HuzJ90U3XLtmnoEWwJucjkxbIVGc+dyxpo+Qk+a
   +qUiwxyIBGVw0Hpr4nLyLYc/WS9ED+SWOExU86m3IJJ+gtAMsgStBksmV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="250803262"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="250803262"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 10:23:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="522546587"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 10:22:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nqeQo-0006wp-CQ;
        Mon, 16 May 2022 20:22:54 +0300
Date:   Mon, 16 May 2022 20:22:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/5] Documentation: gpio: Fix IRQ mask and unmask
 examples
Message-ID: <YoKIbhTK1RjMN3bw@smile.fi.intel.com>
References: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZ50rd7dvZmsx5jTgkVKWHbx_Tsx9W-YY+mAO9RE3RfMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZ50rd7dvZmsx5jTgkVKWHbx_Tsx9W-YY+mAO9RE3RfMw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 10:54:46PM +0200, Linus Walleij wrote:
> On Thu, May 12, 2022 at 7:52 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > After switching to immutable IRQ chips for GPIO drivers the examples become
> > uncompilable due to wrong IRQ API, i.e. irq_desc_get_handler_data() in use.
> > Replace it with proper irq_data_get_irq_chip_data() call where it applies.
> >
> > Fixes: 5644b66a9c63 ("Documentation: Update the recommended pattern for GPIO irqchips")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Entire series with the respective tags has been pushed to my review and testing
queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


