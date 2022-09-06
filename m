Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5319A5AEE7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiIFPRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiIFPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:17:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA8C91D25;
        Tue,  6 Sep 2022 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662474607; x=1694010607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qYqPp+SqKYB0kW1r5YRu9Qox/5WN1GPuqBVB5ntM/wE=;
  b=dKeVmEtpwaffUB+WogSSGgHeSd+Uo7lK/3LUnJkCbVeBr+JebU4FB2p6
   q2O33FN1G8aSygHiT2HV7/tTxe0xRtUSSaRQI+iK4VzHehN1Fs+cIOZS+
   FcyXiVp9tlDWFA/0CF+EWNNN/kRldVZKY6555cGJt+gNQsSsaywtK32GY
   xtHzg5Xvi3KDNtKA67dmJvSDeC/EEVtohBJXnFSMmTBi4Qy1hKXyDdpxq
   K3j0VDpFf3gZGYogI3lAQkAk1AV3edshat7XRHBgQqqaJyvwXyVT4Gd23
   ko9pmz+3GOv27Ze+0vLNJVu1o1fBctGKbzPncJovQk4uj0h/yaozQzprJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360554915"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360554915"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:28:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="565113463"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:28:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVZZ7-0099gK-1n;
        Tue, 06 Sep 2022 17:28:37 +0300
Date:   Tue, 6 Sep 2022 17:28:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] gpio: pca953x: Add support for PCAL6534
Message-ID: <YxdZFRyv5E0qvXgS@smile.fi.intel.com>
References: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
 <20220906082820.4030401-5-martyn.welch@collabora.co.uk>
 <Yxc8GgUnHOuMIn4p@smile.fi.intel.com>
 <a71dec127a2e188b1eb7df1e385f71410051acca.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a71dec127a2e188b1eb7df1e385f71410051acca.camel@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:01:51PM +0100, Martyn Welch wrote:
> On Tue, 2022-09-06 at 15:24 +0300, Andy Shevchenko wrote:
> > On Tue, Sep 06, 2022 at 09:28:19AM +0100, Martyn Welch wrote:

...

> > > +       u8 (*recalc_addr)(struct pca953x_chip *chip, int reg , int
> > > off);
> > > +       bool (*check_reg)(struct pca953x_chip *chip, unsigned int
> > > reg,
> > > +                         u32 checkbank);
> > 
> > I would think of splitting this change. Like in a separate patch you
> > simply
> > create this interface and only add what you need in the next one.
> 
> Can do, though I didn't feel you were particularly fussed about me
> having split that out...

Oh, it just would be cleaner to see what you have done for a new chip support.
Up to you and maintainers.

-- 
With Best Regards,
Andy Shevchenko


