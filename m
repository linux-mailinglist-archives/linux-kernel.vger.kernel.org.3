Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA7B4DD204
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiCRArI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCRArH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:47:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C06247C2F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647564349; x=1679100349;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ioIK2vITaATAP80hVGQmV1FVy0+JSS1KHG27psb3DZw=;
  b=fULJiA+Q3zI6eQTJPS9IkXX5SDNrxw4TaEk89fBT+mKGbXpuMryNuZQ3
   jHDCBRVVcYojcqRgcqt5lLKEX/KC/pIMURJLkVg5SDdhxpWOu0I/3+XbQ
   C7MNgnMaQXB3ezITuagCIa0tarxwxa70ZAuRXIakgpqC0QDZrd5Z4Qni5
   fwai13RYIDQXTDOD02RxLRB8LkJpRi/JuSLjB0pdWiMA8+5nF9oHQG9Ub
   9G+gpTBSCD4u0o36u+G5JAQIw3ivftLkGdrjO9JvKXhW06eqOaAoJYIJR
   DhminPxYxh1W+0afgvj0HZJ9h0cGTP0DXF6f80j+kdDke5ShbTVWBJuq0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256964364"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="256964364"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 17:45:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="516984044"
Received: from dstanfie-mobl2.amr.corp.intel.com (HELO [10.212.178.19]) ([10.212.178.19])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 17:45:48 -0700
Message-ID: <d4f62008-faa7-2931-5690-f29f9544b81b@intel.com>
Date:   Thu, 17 Mar 2022 17:45:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20220317090415.GE735@xsang-OptiPlex-9020>
 <c85ae95a-6603-ca0d-a653-b3f2f7069e20@intel.com>
 <3B958B13-75F0-4B81-B8CF-99CD140436EB@vmware.com>
 <96f9b880-876f-bf4d-8eb0-9ae8bbc8df6d@intel.com>
 <DC37F01B-A80F-4839-B4FB-C21F64943E64@vmware.com>
 <dd8be93c-ded6-b962-50d4-96b1c3afb2b7@intel.com>
 <A185DAD5-3AA7-445B-B57D-AFAF6B55D144@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
In-Reply-To: <A185DAD5-3AA7-445B-B57D-AFAF6B55D144@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 17:20, Nadav Amit wrote:
> I don’t have other data right now. Let me run some measurements later
> tonight. I understand your explanation, but I still do not see how
> much “later” can the lazy check be that it really matters. Just
> strange.

These will-it-scale tests are really brutal.  They're usually sitting in
really tight kernel entry/exit loops.  Everything is pounding on kernel
locks and bouncing cachelines around like crazy.  It might only be a few
thousand cycles between two successive kernel entries.

Things like the call_single_queue cacheline have to be dragged from
other CPUs *and* there are locks that you can spin on.  While a thread
is doing all this spinning, it is forcing more and more threads into the
lazy TLB state.  The longer you spin, the more threads have entered the
kernel, contended on the mmap_lock and gone idle.

Is it really surprising that a loop that can take hundreds of locks can
take a long time?

                for_each_cpu(cpu, cfd->cpumask) {
                        csd_lock(csd);
			...
		}
