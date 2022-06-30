Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA856174F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiF3KIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiF3KIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:08:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924A510551;
        Thu, 30 Jun 2022 03:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656583710; x=1688119710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WznRl6xaiipvfWJGGB8hMSubUdFubuJ4I3rc1anmHEo=;
  b=ZGgAatgzxat+ZrsZmcLJW2j+prY15FR9VwynbdfYcLpLXGRG3CqXEitd
   lnVsupoL1mQKCI3MLbxiJoPgdSO5jwpzHxsXFi+g3/iyQMVyyUN4CLfdG
   k6Et13+awYZtJBu5lHIRVODvPz6Ve0YqX1y8w1iFD/5DQ53wIhrrUUEC6
   t8VMpfgArhbJasTL+vVbIwj3YXBaBbztvJsAd3j8YE3BKGh5L16inJcao
   eQbNXZrwLHoATwRfiTV9SsSvfNYGh887FhgEH45XqSi5mwuMFD9LMBRgz
   MPw+qhifL12PjV8AIFPMOdcLhLIR9yhWcdvNCgLTL9r43UCyJKwYYUYbK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="283041434"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="283041434"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 03:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="837549037"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 03:08:10 -0700
Message-ID: <c676e655-bdc8-5930-7516-86be21ae7320@linux.intel.com>
Date:   Thu, 30 Jun 2022 13:09:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH] usb: host: xhci: Fix potential memory leak in
 xhci_alloc_stream_info()
Content-Language: en-US
To:     Jianglei Nie <niejianglei2021@163.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220630011008.2167298-1-niejianglei2021@163.com>
 <bcf4d8db-317f-f0c9-0e9e-5edf25e0c7e8@linux.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <bcf4d8db-317f-f0c9-0e9e-5edf25e0c7e8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> How about:
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 8c19e151a945..f7cac1af51c5 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -641,7 +641,7 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
>                          num_stream_ctxs, &stream_info->ctx_array_dma,
>                          mem_flags);
>          if (!stream_info->stream_ctx_array)
> -               goto cleanup_ctx;
> +               goto cleanup_rings;

Small sidenote, "cleanup_rings" label was already in use, so maybe something like
"cleanup_ring_array" could be used

Thanks
-Mathias


