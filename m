Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA64CBF46
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiCCN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiCCN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:59:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B9554BC;
        Thu,  3 Mar 2022 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646315903; x=1677851903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HGB4NWO/V8oYfkT3g8vezDI1GReDGjV0SXRxT5twMAw=;
  b=JtOfCGkpkPMfbPw/isUntBC3t255AiBrdjUxvSih2wCxkn+LHBAcWbD0
   RnCfg+YoSiYaUTJaOk1iiQE5bUtsY6/l4diD2WgD+cAntOcDUnGg7uP+I
   5Kz6cLtlokLd+Yn5tF9t8/LXZTSOFMZJAqZPunNS1t2urBJqbfDUPPvfR
   Y64HJ/Mcvy+IrXT+WFjrN+WKNQW2G9zJF/4kUaAJMjNEqffvfHY6mu41G
   1oIwQapc1F5x1Y4MEY2vNHCt50+w+XlOd0yHMyKiuz4yZ6abK5/GczxWP
   eItTGZNqSO2bH3AFUAqzZBZDSgw98lnZE1recqfj+tu0Bdm78IZv94U40
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316899301"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="316899301"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 05:58:21 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="511436397"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 05:58:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPlxV-00Ap1s-O2;
        Thu, 03 Mar 2022 15:57:33 +0200
Date:   Thu, 3 Mar 2022 15:57:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 3/3] iio: temperature: ltc2983: Make use of device
 properties
Message-ID: <YiDJTZECF9FHFIS4@smile.fi.intel.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
 <20220210135522.26562-3-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB6786304A458CD4B11AF5C42699049@PH0PR03MB6786.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR03MB6786304A458CD4B11AF5C42699049@PH0PR03MB6786.namprd03.prod.outlook.com>
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

On Thu, Mar 03, 2022 at 01:31:56PM +0000, Sa, Nuno wrote:
> Hi Andy,
> 
> Good that we waited to test this patch. The fundamental logic change
> for fetching and writing the custom tables are fine. That said, there
> some issues that I had to fix to test the patch. See below...

Thanks and indeed it's a good news that we caught a bug beforehand.

> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Thursday, February 10, 2022 2:55 PM

...

> > -	phandle = of_parse_phandle(child, "adi,cold-junction-handle",
> > 0);
> > -	if (phandle) {
> > -		ret = of_property_read_u32(phandle, "reg",
> > -					   &thermo-
> > >cold_junction_chan);
> > +	ref = fwnode_find_reference(child, "adi,cold-junction-
> > handle", 0);
> > +	if (ref) {
> 
> This is nok. It needs to be 'if (IS_ERR(ref))'. We then should return
> ERR_CAST() in case of errors inside the if block. As this reference
> is also optional, we need to nullify ref in case we don't find the
> it. Otherwise fwnode_handle_put() breaks.

Got it (I hope).
Lemme go through it again and issue a v4.

> We also need to use ptr error logic in the other places where
> fwnode_find_reference() is used. Although, in the other cases
> the ref is mandatory, so there's no need to care with breaking
> fwnode_handle_put().
> 
> After these changes (I think the changes are straight enough;
> but I can re-test if you or Jonathan ask for it):
> 
> Tested-by: Nuno Sá <nuno.sa@analog.com>

I think of v4 where I may add this, but still would be nice to re-review and
check if I got correctly your testing report.

-- 
With Best Regards,
Andy Shevchenko


