Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6F53CB46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbiFCODl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiFCODh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:03:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EC2C671;
        Fri,  3 Jun 2022 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654265014; x=1685801014;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=sjdGyUtJuDoTjTTLcueGlA/roqxqj9YbEIoz2xAYeLE=;
  b=NAPFas0vu9BMZcfEwMjAlSQKE3xJbRstk+0l7VlbmB7h899i+pkU8+ix
   WT37SpV6XVPrv22rs4W48J1HZF+5w0oX99Aoa0QNFQXQgFxdyFFhv4l7D
   /gk77HhfQEBDQxDRyPwYJ45WR8LtV+d7biGCbtPNCmT8ROKVDYrt5EXNO
   JAbeL2b80GzkC1rFHZYc2YGMXhpIQn5fwSxVqIWeigWcUEImfY0aVzlTC
   dHSOmr9pkE88/Tj0AIQzm9MtndPJKizyurrShmUimGSS/AC/+BM1U1tNj
   Se7UM5k5luQ/cz5wSTMpAnC51HSSHeUQVAuFDPQAyQu2Y/VCScXF3l8RK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="336916961"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="336916961"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 07:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="757486453"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2022 07:03:33 -0700
Received: from [10.252.214.200] (kliang2-MOBL.ccr.corp.intel.com [10.252.214.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 787D75808E0;
        Fri,  3 Jun 2022 07:03:32 -0700 (PDT)
Message-ID: <02135ffb-c19c-6c8c-4900-a16a1c40a746@linux.intel.com>
Date:   Fri, 3 Jun 2022 10:03:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [BUG REPORT] perf tools: x86_64: weight column displays odd
 memory latency data
Content-Language: en-US
To:     Tyson Thomas <tyson.thomas@sydney.edu.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <SYBPR01MB6620E2316BDF9CE29178CB32DBD59@SYBPR01MB6620.ausprd01.prod.outlook.com>
 <fd28e6fb-cf4c-a065-6138-4c581e871341@linux.intel.com>
 <MEYPR01MB66152548BEC4D0113BBBD7A5DBDF9@MEYPR01MB6615.ausprd01.prod.outlook.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <MEYPR01MB66152548BEC4D0113BBBD7A5DBDF9@MEYPR01MB6615.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2022 1:03 AM, Tyson Thomas wrote:
> Hi Kan,
> 
> Thanks for the reply.
> 
> The exact command used was: perf mem report
> 
> The columns are in order: Overhead, Samples, Local Weight, Memory Access.
> The results I sent before are: Overhead, Local Weight and Memory.
> 
> So, to update the table from before, each tuple has a sample of 1, so it is:
> 
>     0.02%,1 ,62515 ,L1 or L1 hit
>     0.02%,1 ,54048 ,L1 or L1 hit
>     0.02%,1 ,52206 ,L1 or L1 hit
>     0.02%,1 ,49831 ,L1 or L1 hit
>     0.02%,1 ,49056 ,Local RAM or RAM hit
>     0.01%,1 ,40666 ,LFB or LFB hit
>     0.01%,1 ,38080 ,L1 or L1 hit
>     0.01%,1 ,36772 ,L1 or L1 hit
> 
> So, the weights are absurdly high here.
> 
> I'll give a reply on perf report -D shortly.
> 
> Regards,
> Tyson
> 
> 
> 
> From: Liang, Kan <kan.liang@linux.intel.com>
> Sent: Wednesday, 25 May 2022 12:58 AM
> To: Tyson Thomas <tyson.thomas@sydney.edu.au>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-perf-users@vger.kernel.org <linux-perf-users@vger.kernel.org>
> Subject: Re: [BUG REPORT] perf tools: x86_64: weight column displays odd memory latency data
>   
> 
> 
> On 5/22/2022 6:14 PM, Tyson Thomas wrote:
>> Hi Kan, Linux-Perf Team
>>
>> I have observed some odd behaviour within perf when using perf-mem. Specifically the reported latency under the weight column appears to be unreasonably high.
>>
>> Here is a given sample from a recent test, I find that some of the  latencies are close to an unsigned short and I cannot seem to be understand why that would be outside of it being an issue with the perf events.
>>
>> This can be replicated using a NAS benchmark, specifically cg.D.


I tried the cg.D benchmark on my machine, but I cannot reproduce the 
issue. The weight looks reasonable.

$ perf mem record ./bin/cg.D.x


  NAS Parallel Benchmarks (NPB3.4-OMP) - CG Benchmark

  Size:     1500000
  Iterations:                    100
  Number of available threads:     4

^C[ perf record: Woken up 118 times to write data ]
[ perf record: Captured and wrote 30.108 MB perf.data (438307 samples) ]

$ perf mem report --stdio
# To display the perf.data header info, please use 
--header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 209K of event 'cpu/mem-loads,ldlat=30/Pu'
# Total weight : 56835744
# Sort order   : 
local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat,p_stage_cyc
#
# Overhead       Samples  Local Weight  Memory access             Symbol 
                            Shared Object         Data Symbol >
# ........  ............  ............  ........................ 
................................  ....................  ............>
#
      0.01%            66  53            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.01%            53  58            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.01%            59  52            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.00%            53  53            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.00%            43  65            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.00%            50  55            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.00%            51  50            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.00%            46  55            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.00%            49  51            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2496          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%            48  52            L1 or L1 hit              [.] 
randlc_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2441          Local RAM or RAM hit      [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2420          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2415          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2403          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2399          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2390          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2385          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2385          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2378          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>
      0.00%             1  2358          LFB or LFB hit            [.] 
sparse_                       cg.D.x                [.] 0x00007f>

Thanks,
Kan

>>
>> I observe the following results in perf mem report (just getting the top 10 results)
>>
> 
> 
> Could you please show me the exact perf command used?
> 
> With my perf mem report,
> The first column is the Overhead.
> The second column is the number of samples.
> The third column is the weight.
> The fourth is the Memory access.
> 
> Seems like the weight is missed?
> 
> Could you please check the perf report -D?
> It will dump the weight for each Sample.
> Does it look correct?
> 
> Thanks,
> Kan
> 
>>     0.02% ,62515 ,L1 or L1 hit
>>     0.02% ,54048 ,L1 or L1 hit
>>     0.02% ,52206 ,L1 or L1 hit
>>     0.02% ,49831 ,L1 or L1 hit
>>     0.02% ,49056 ,Local RAM or RAM hit
>>     0.01% ,40666 ,LFB or LFB hit
>>     0.01% ,38080 ,L1 or L1 hit
>>     0.01% ,36772 ,L1 or L1 hit
>>     0.01% ,36729 ,LFB or LFB hit
>>     0.01% ,27101 ,LFB or LFB hit
>>
>> Is it possible for someone to shed some light on this or am I misunderstanding how the weight column is used here?
>> This appears to have been an issue on 5.4, 5.10 and 5.15. I am looking into seeing if it is still present in 5.17 and 5.18.
>>
>> I've also tried this on different Intel CPUs such as Intel Xeon 6230, i5-1135G7, Intel Xeon 6330
>>
>> Any insight or help would be appreciated,
>> Tyson
