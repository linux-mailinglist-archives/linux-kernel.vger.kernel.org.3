Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41D3508FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381552AbiDTSqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiDTSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:46:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4242A00;
        Wed, 20 Apr 2022 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650480214; x=1682016214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JVLsyYBZq1esqPxRCB4pCE4fLG7rN1RBuCQlNd7wmv0=;
  b=Xjy2ON8gBz3ezQ1REB7LhkXSxEue78ykKHxAB3uH7dfKdIyv/a9hXAO6
   ocIgpxKLI/8WFU/BCvDxExGLeaSCxvGxkCaQZ5Tv2gdijuxJDpPI0+/Sv
   AIrA/dYw+txJl04vF2IEScCD9DvT4RAeMlHCXxDhUbb4mNdnqRNKkeCfH
   OjUh2ERcaexbTaPpnX707yW6inyk/sSDFqVD0JbjdvxLOTtyScVGK5zjH
   xUvNzNFPQRnxAYCNAAv1Yh/fpJSZicK8wqUUSPmSVE4GINi2NbVQic4r2
   o8sbDTu1AXQtQSK2/Rxn/SRxXeZBmKRIHt5GxantFCMnZhSMO/IokmDuI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263886757"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="263886757"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 11:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="647785859"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2022 11:43:31 -0700
Received: from [10.209.97.182] (kliang2-MOBL.ccr.corp.intel.com [10.209.97.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D8F01580AE2;
        Wed, 20 Apr 2022 11:43:29 -0700 (PDT)
Message-ID: <a96681b5-5532-470e-17d1-afe4c8d195ad@linux.intel.com>
Date:   Wed, 20 Apr 2022 14:43:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Content-Language: en-US
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        leo.yan@linaro.org, acme@kernel.org
Cc:     benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-3-alisaidi@amazon.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220408195344.32764-3-alisaidi@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2022 3:53 PM, Ali Saidi wrote:
> Add a flag to the perf mem data struct to signal that a request caused a
> cache-to-cache transfer of a line from a peer of the requestor and
> wasn't sourced from a lower cache level.

It sounds similar to the Forward state. Why can't the 
PERF_MEM_SNOOPX_FWD be reused?

Thanks,
Kan

> The line being moved from one
> peer cache to another has latency and performance implications. On Arm64
> Neoverse systems the data source can indicate a cache-to-cache transfer
> but not if the line is dirty or clean, so instead of overloading HITM
> define a new flag that indicates this type of transfer.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>   include/uapi/linux/perf_event.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 82858b697c05..c9e58c79f3e5 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1308,7 +1308,7 @@ union perf_mem_data_src {
>   #define PERF_MEM_SNOOP_SHIFT	19
>   
>   #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
> -/* 1 free */
> +#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
>   #define PERF_MEM_SNOOPX_SHIFT  38
>   
>   /* locked instruction */
