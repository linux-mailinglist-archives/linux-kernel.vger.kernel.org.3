Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296CC55CC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344385AbiF1JuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbiF1JuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:50:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B96DC8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656409813; x=1687945813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EMA9/2kguHnQyf44jaUpIuGsTVx9ehFERtpHBeOXGic=;
  b=mbKJj3voNsMMC2aFuZWMGEfoJMqHktqsy7l118EDpGMIg0AXnAn7mzPd
   4PIznzki/QPoQP9piZFjyk4qtPSYjqJvQhQj4+1pAmu5oE6McZ6HNDgYz
   nA3Sw/XTs3bgt70lrbuNo7LXdVoGjdXRlWeVzRf6xOcSnr1TrSL1LIGv7
   cDUDKpBqHK1Om+w0l3SPx9Z2JeZgPxoWTBxlnZXzz9HHPR2wFueLQZ2R8
   CqlveAoKyhuqPZPc1OqXg2hbuVEh+OusnvsIIreotHkPvg20r0oX1B05R
   /aXtZy3NLpWtjSKxHbwWjiT/dkrCmYA1ueaZi9VvdHciWI0kiANjl3nwl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282430593"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282430593"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:50:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="658070480"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:50:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o67rE-000wfu-L9;
        Tue, 28 Jun 2022 12:50:08 +0300
Date:   Tue, 28 Jun 2022 12:50:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YrrO0CQVv6hj1AB0@smile.fi.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <Yrmr175fsQi6ToEY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrmr175fsQi6ToEY@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:08:39PM +0100, Lee Jones wrote:
> On Thu, 16 Jun 2022, Andy Shevchenko wrote:

...

> >  drivers/mfd/intel_soc_pmic_core.c | 160 -----------------------------
> >  drivers/mfd/intel_soc_pmic_core.h |  25 -----
> >  drivers/mfd/intel_soc_pmic_crc.c  | 162 ++++++++++++++++++++++++++++--
> >  4 files changed, 157 insertions(+), 193 deletions(-)
> >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
> >  delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
> 
> Can you submit this again with the -M flag please.

This is done with this flag. Basically for the last several years I do my
submissions with that flag.

Anything else I can do?

> Trying to figure out what exactly changed is proving challenging.

-- 
With Best Regards,
Andy Shevchenko


