Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913AA592632
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 21:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiHNThM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 15:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiHNThK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 15:37:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D213517A87
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660505826; x=1692041826;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nvUBt5yAqZtewDqK8UmX6A25s9Ss+M+JptJQQ9NffDY=;
  b=ZMnRwtWKUQPSQACicJ3MQrQI6HZgI7OLQbt+BSx+vJjNjjmuCFhBWjw3
   WOI3Tqr1MNs/NwVc+VdvfUqIQg60pYBckZRlc4EFXsOKdedzxXFHdf8NR
   3xMPQ6s6lBaS+9kCRSEzGUVYlb9TbaUslzvUWcwRkPWeRhsRbjSWQVEqv
   ToZ+Cpidnbgfm73qEl9rgj1dVM5TQriJjkNLnXoktsoyqbT81Ldre9Z/o
   0fbaNhwoNi7FNQkEAiUVluAQhwbH/cjQyeDIe7GZ4ZgLaQ5s6ph/oWbs0
   pSdusyFer7ndyiN5mlM3LupFsxqj5ZNygtuZJ05iJXv0x4FcXuhSCZdHY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="274904043"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="274904043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 12:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="709555575"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2022 12:37:05 -0700
Received: from [10.252.214.243] (kliang2-mobl1.ccr.corp.intel.com [10.252.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B882C5807E7;
        Sun, 14 Aug 2022 12:37:04 -0700 (PDT)
Message-ID: <6ebd8b96-b589-cded-58f0-76e56a64081c@linux.intel.com>
Date:   Sun, 14 Aug 2022 15:37:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] perf/x86/intel/lbr: fix branch type encoding
To:     Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kan.liang@intel.com, acme@redhat.com, namhyung@kernel.org,
        irogers@google.com
References: <20220810210656.2799243-1-eranian@google.com>
 <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
 <CABPqkBSD5xg=sEkWU01RQ5+aj1X1dtzt2e7FbZBzrcE8dxqM=A@mail.gmail.com>
 <48297c1e-6e44-53f1-da7d-4437ed87cf6f@linux.intel.com>
 <CABPqkBSUkUTXxS4PwDXYwvTCZ-abY41qyedRGFVoWE9ERtmwsQ@mail.gmail.com>
 <CABPqkBRKpUOEwhbu+YsGTx=bWu6DaeTxcCkcKbx5tkCONnJnRw@mail.gmail.com>
 <2fc8dc1d-6922-e2e0-8b5d-fad25ab12cbd@linux.intel.com>
 <fa9f74d3-3a5e-9b8c-3142-9377677a6b74@linux.intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <fa9f74d3-3a5e-9b8c-3142-9377677a6b74@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-12 4:16 a.m., Andi Kleen wrote:
> 
>>
>> I think the option is to avoid the overhead of disassembling of branch
>> instruction. See eb0baf8a0d92 ("perf/core: Define the common branch type
>> classification")
>> "Since the disassembling of branch instruction needs some overhead,
>> a new PERF_SAMPLE_BRANCH_TYPE_SAVE is introduced to indicate if it
>> needs to disassemble the branch instruction and record the branch
>> type."
> 
> 
> Thanks for digging it out. So it was only performance.
> 
>>
>> I have no idea how big the overhead is. If we can always be benefit from
>> the branch type. I guess we can make it default on.
> 
> I thought even arch LBR had one case where it had to disassemble, but
> perhaps it's unlikely enough because it's pre filtered. If yes it may be
> ok to enable it there unconditionally at the kernel level.
> 

Yes, Arch LBR should have much less overhead than the previous
platforms. The most common branches, JCC and near JMP/CALL, are from the
HW. Only the other branches, e.g., far call, SYS* etc, which still rely
on the SW disassemble. The number of the other branches should not be
big. I agree that we should enable the branch type for the Arch LBR
unconditionally at the kernel level.

Peter? Stephane? What do you think?

> Still have to decide if we want older parts to have more overhead by
> default. I guess would need some data on that.


The previous LBR already has high overhead. The branch type overhead
will make it worse. I think it's better keep it default off. I think we
can make it clear in the document that the branch type is only default
on for the new platforms with Arch LBR support (12th-Gen+ client or
4th-Gen Xeon+ server).

Thanks,
Kan
