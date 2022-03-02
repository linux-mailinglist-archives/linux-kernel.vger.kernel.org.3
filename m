Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D044CA9DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbiCBQKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiCBQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:10:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C50CB646;
        Wed,  2 Mar 2022 08:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646237404; x=1677773404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BAwjbMSNSBgg1FOhGnv01+DlxDYMhjhUOyVrW6GFTRY=;
  b=CvhmemfxhfAkorYQud6CPyf2xUikLVbDCBPooSlFP/qdIq+j8rsCsQhX
   Rzw4KmZ3VJbfpilD9h0PSaMYrFNrQZOypAd1kGTqfxnHUhfFdcCF6o7oX
   la+nEbXqt9swwlTdF5LNCXK/y6rc5ib9wPyEMm2PGTW/QdUcLJa6xG2bR
   eKN+TxsbvLY4SgIah//nov4GzWQzE7Lcrv3nfDXxbTTGTP6yrndgQKoLK
   NBsg203eP3M5wi780D3/htZeTp2JLad5Bmi+t/xs/l0e+w6qa6w73HLWh
   TZIC4/DrGeHdrvfpw3AGys85uSWMClZQgKwYZ5qwB/jCt84LhkCwuiROH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234054763"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="234054763"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 08:10:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="609245191"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 08:10:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPRVH-00ANE0-Af;
        Wed, 02 Mar 2022 18:07:03 +0200
Date:   Wed, 2 Mar 2022 18:07:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     shruthi.sanil@intel.com, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Message-ID: <Yh+WJpmVe6V2oJVT@smile.fi.intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
 <91653d8d-1dc6-0170-2c3c-1187b0bad899@linaro.org>
 <Yh925VvqejDe2SR8@smile.fi.intel.com>
 <d1f82398-3f94-2f48-db92-d1fe487032c7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f82398-3f94-2f48-db92-d1fe487032c7@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:58:08PM +0100, Daniel Lezcano wrote:
> On 02/03/2022 14:53, Andy Shevchenko wrote:
> > On Tue, Mar 01, 2022 at 10:09:06PM +0100, Daniel Lezcano wrote:
> > > On 22/02/2022 10:56, shruthi.sanil@intel.com wrote:

...

> > > One line comment format is usually for the network subsystem

> > Any pointers to the documentation, please?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n598
> 
> Well actually it is for multi line, so I may have confused with these one
> line comments.

Seems so.

> On the other hand having one line comment telling what does the function
> right after is not really useful. The function names are self-explanatory.

Agree on this.

-- 
With Best Regards,
Andy Shevchenko


