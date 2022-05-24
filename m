Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03206532CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiEXO6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbiEXO6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:58:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B987A1E;
        Tue, 24 May 2022 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653404287; x=1684940287;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JUpfAF9Am5zA2GbGQFfRJxRjAhrPXzVHQcmG8Ad5zuE=;
  b=Llxzv/3vBA+rZEoRTBAH1ecHS3pSdrD/PNOC3RsBOEUHsyaIDCDwfjJx
   88/n3u15kI45DllCp6lBzm+Q3eBmy+9nGkpdHBmeCe7uo1nxpyGjKnHP5
   o23NaczivZ4JY4kcTbGGTFGZUa51jNqvPDWkcnx2sBywDVPc1nAfpgAyp
   WewNaG33UtHn1ygNIfdtqMKm4Fx1MEbNYcQTSyLhX3XgKfKhiEjjFRgIS
   FUjh7j0R/nr2lmC1VE006KRw1nbvrc2SX9cIIiiUQQSjANY/gFYZOJyL1
   M25BzHeOWtkya4bLBp5SDj4uTp4094fz4amfhnSvFRpIlN9E8D9eHbwqs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="271127274"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="271127274"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 07:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="577919340"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2022 07:58:07 -0700
Received: from [10.252.209.117] (kliang2-MOBL.ccr.corp.intel.com [10.252.209.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B6BCD580223;
        Tue, 24 May 2022 07:58:06 -0700 (PDT)
Message-ID: <fd28e6fb-cf4c-a065-6138-4c581e871341@linux.intel.com>
Date:   Tue, 24 May 2022 10:58:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [BUG REPORT] perf tools: x86_64: weight column displays odd
 memory latency data
Content-Language: en-US
To:     Tyson Thomas <tyson.thomas@sydney.edu.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <SYBPR01MB6620E2316BDF9CE29178CB32DBD59@SYBPR01MB6620.ausprd01.prod.outlook.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <SYBPR01MB6620E2316BDF9CE29178CB32DBD59@SYBPR01MB6620.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2022 6:14 PM, Tyson Thomas wrote:
> Hi Kan, Linux-Perf Team
> 
> I have observed some odd behaviour within perf when using perf-mem. Specifically the reported latency under the weight column appears to be unreasonably high.
> 
> Here is a given sample from a recent test, I find that some of the  latencies are close to an unsigned short and I cannot seem to be understand why that would be outside of it being an issue with the perf events.
> 
> This can be replicated using a NAS benchmark, specifically cg.D.
> 
> I observe the following results in perf mem report (just getting the top 10 results)
>


Could you please show me the exact perf command used?

With my perf mem report,
The first column is the Overhead.
The second column is the number of samples.
The third column is the weight.
The fourth is the Memory access.

Seems like the weight is missed?

Could you please check the perf report -D?
It will dump the weight for each Sample.
Does it look correct?

Thanks,
Kan

>   0.02% ,62515 ,L1 or L1 hit
>   0.02% ,54048 ,L1 or L1 hit
>   0.02% ,52206 ,L1 or L1 hit
>   0.02% ,49831 ,L1 or L1 hit
>   0.02% ,49056 ,Local RAM or RAM hit
>   0.01% ,40666 ,LFB or LFB hit
>   0.01% ,38080 ,L1 or L1 hit
>   0.01% ,36772 ,L1 or L1 hit
>   0.01% ,36729 ,LFB or LFB hit
>   0.01% ,27101 ,LFB or LFB hit
> 
> Is it possible for someone to shed some light on this or am I misunderstanding how the weight column is used here?
> This appears to have been an issue on 5.4, 5.10 and 5.15. I am looking into seeing if it is still present in 5.17 and 5.18.
> 
> I've also tried this on different Intel CPUs such as Intel Xeon 6230, i5-1135G7, Intel Xeon 6330
> 
> Any insight or help would be appreciated,
> Tyson
