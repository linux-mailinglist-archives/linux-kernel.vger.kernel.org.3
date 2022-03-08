Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12B14D140E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiCHKAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiCHKAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:00:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADBF37A81;
        Tue,  8 Mar 2022 01:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646733561; x=1678269561;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vjg7gyyKwredXX78b2E313XjQRvREzzZhfNhqcfzbRI=;
  b=V2ek+Hr+WaUJFRQ9z3B7KNWkF+uUI8LFlpnn5xsTBSHOyk/lZcjWK3ua
   m4NDeDrKJd3G/H4tqwbHWZm64qWLSMcBD1wPoU58lIZHH6u7CciqDHP3g
   fYC8niBkTyCyZvYW5gMHzu+45RAOfPCMcGkXj1suVzgCQ0BC2P2BsNJWV
   d8rMSSPcC2A+c+eKqeZPjqRFzBmrXhQRS62iaXmWtYM1M2Nof9uAFqzxm
   55hVMTZbPfgXwgGY7M2VBZgPFtVuEZ3L7feAHFNBu7uKbtJI/l8qKjTkS
   lopR2U6TlRVfyJBdHeP0hB4BGuEGOgfVBwY/Obk4gqQ9r2TW8ZEGb8VD/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317875113"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="317875113"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 01:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="577940601"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2022 01:59:19 -0800
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        linux-usb@vger.kernel.org
References: <20220304151953.830111479@infradead.org>
 <20220304152136.035911620@infradead.org>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 3/3] usb: early: xhci-dbc: Fix xdbc number parsing
Message-ID: <4eda8138-76d0-e854-0ddb-8484e8ea283b@linux.intel.com>
Date:   Tue, 8 Mar 2022 12:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220304152136.035911620@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.3.2022 17.19, Peter Zijlstra wrote:
> kstrtoul() assumes the string contains the number only and is \0
> terminated, this is not the case, as such things like:
> 
> 	earlyprintk=xdbc1,keep
> 
> go completely sideways. Use simple_strtoul() instead.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/usb/early/xhci-dbc.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> --- a/drivers/usb/early/xhci-dbc.c
> +++ b/drivers/usb/early/xhci-dbc.c
> @@ -603,6 +603,7 @@ int __init early_xdbc_parse_parameter(ch
>  {
>  	unsigned long dbgp_num = 0;
>  	u32 bus, dev, func, offset;
> +	char *e;
>  	int ret;
>  
>  	if (!early_pci_allowed())
> @@ -613,8 +614,11 @@ int __init early_xdbc_parse_parameter(ch
>  	if (xdbc.xdbc_reg)
>  		return 0;
>  
> -	if (*s && kstrtoul(s, 0, &dbgp_num))
> -		dbgp_num = 0;
> +	if (*s) {

Do you think we need a code comment here stating something like
"use deprecated simple_strtoul() as kstrtoul can't handle characters after the number"

> +	       dbgp_num = simple_strtoul(s, &e, 10);
> +	       if (s == e)
> +		       dbgp_num = 0;
> +	}
>  

If not then PATCH 2/3 and 3/3 looks good to me
I don't know much about PATCH 1/3, the tsc change, but it didn't cause any issues for me either.

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Thanks
-Mathias
