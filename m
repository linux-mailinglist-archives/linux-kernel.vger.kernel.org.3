Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAC158511F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiG2Nv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiG2NvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:51:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3045073;
        Fri, 29 Jul 2022 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659102662; x=1690638662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GXm/43zYBsV5VKNSUng5oQyzYVOlSSfKZxtWgq3e5Ew=;
  b=Dta9YSVgwBjmeEB90tMW8HPSJ76HCEp4iLlUp8SJE3wEg47B/BMruOPa
   /USkDBA1ljDhuvtMVvSushrXLJlidugQ5I5Sz8d+6Ma99hhFRvfxVl2cj
   2TfY8460yyUQFmAjFgVvGftX4qnB9Ul2xXqsuxIb719BreIplGlWgJXkZ
   q3XS1twJ6ui6n2FJTSR9lswDHGwCrFDxTVSDYjskqWYqXKSbh3tGPh8Lr
   hjTCRJayi53yurGZIMWA1tND8EBi7NC7Vla8KWAQ6qGDiaB4nTtAUFz97
   PB0+5yNDYMto6mL1mr0Xc9QxtFVcjmLEyu63S6jD0UFTo9VCDNUt13KSB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="350475468"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="350475468"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 06:51:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="743536255"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 06:50:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oHQOG-001eXm-2B;
        Fri, 29 Jul 2022 16:50:56 +0300
Date:   Fri, 29 Jul 2022 16:50:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Luca Ellero <luca.ellero@brickedbrain.com>,
        dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: Re: [PATCH v2 1/3] ads7846: don't report pressure for ads7845
Message-ID: <YuPlwMP+W1zGKG1D@smile.fi.intel.com>
References: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
 <20220721083458.6412-2-luca.ellero@brickedbrain.com>
 <20220721204835.fobidbnsvhea7r3w@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220721204835.fobidbnsvhea7r3w@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:48:35PM +0200, Uwe Kleine-König wrote:
> On Thu, Jul 21, 2022 at 10:34:56AM +0200, Luca Ellero wrote:
> > From: Luca Ellero <l.ellero@asem.it>
> > 
> > ADS7845 doesn't support pressure.
> > This patch avoids the following error reported by libinput-list-devices:
> > "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE".
> > 
> > Signed-off-by: Luca Ellero <l.ellero@asem.it>
> 
> I don't know how picky Dmitry is, but some maintainers would ask you to
> either add a Signed-off-by with the email address you sent this patch
> from, or make sure to send it from the asem.it address.

It's fine to be sent from different email of the same person.
But like you said, some maintainers are really picky and that
may block contribution (I have been seen a case, where actually
allowing to do as above unblocks contribution since person can't
re-sent properly the change from another address by some reasons).


-- 
With Best Regards,
Andy Shevchenko


