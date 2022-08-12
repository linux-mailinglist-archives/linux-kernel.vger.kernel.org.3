Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C4E590D42
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiHLIRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHLIQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:16:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB37647C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660292216; x=1691828216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=puWWKKmgbPbHIfRytrQSzGlFO/mtlwKz6m0M9s0UNxs=;
  b=hFTwDrg5aYvxr7Muy0P37VpLRbbNYakVfrZIIBBGkWtUfWz01iBvVnAS
   t1gu8ht9prDP4vuC2O91KHskjHhM9gssBkHb5+64xsc3zzO7o/5NDz64o
   pSn+Thi9fU624kRTm/legb9Tls8hTu3vFQyqKRBxeQYmSIf/FLPfJClg7
   nkiMjSl8390ZfcRToyyiQbGa/Ke36zjPmH0qSJQ6r2zoYWzSw0a7BieKg
   gh33UF2JT702DTJB+ZQ6V03o4PN06VE/nXVrLSbfha5zlATY/2m+yiy6r
   lJon06z9H9DO+/e9JSb56mYjRHT/kCiEPMWK6H/L4OFpct/vWiRB1sIyv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="290304398"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="290304398"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:16:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="665737642"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.37.223]) ([10.252.37.223])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:16:52 -0700
Message-ID: <fa9f74d3-3a5e-9b8c-3142-9377677a6b74@linux.intel.com>
Date:   Fri, 12 Aug 2022 10:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] perf/x86/intel/lbr: fix branch type encoding
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
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
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <2fc8dc1d-6922-e2e0-8b5d-fad25ab12cbd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I think the option is to avoid the overhead of disassembling of branch
> instruction. See eb0baf8a0d92 ("perf/core: Define the common branch type
> classification")
> "Since the disassembling of branch instruction needs some overhead,
> a new PERF_SAMPLE_BRANCH_TYPE_SAVE is introduced to indicate if it
> needs to disassemble the branch instruction and record the branch
> type."


Thanks for digging it out. So it was only performance.

>
> I have no idea how big the overhead is. If we can always be benefit from
> the branch type. I guess we can make it default on.

I thought even arch LBR had one case where it had to disassemble, but 
perhaps it's unlikely enough because it's pre filtered. If yes it may be 
ok to enable it there unconditionally at the kernel level.

Still have to decide if we want older parts to have more overhead by 
default. I guess would need some data on that.


-Andi

