Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBEC4DD1D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiCRARs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCRARp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:17:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA52C2762
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 17:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647562588; x=1679098588;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=na3iWmZQcNakvcNrOYfMY8FuR11b8l0YzV4or8bGtXo=;
  b=Qy3XOGIB5p+CokVPWlvjqmA7B8RGBJg0OWkjYs9MQsAS79ANQMcwTJ+a
   JkgKU8bu58XUTJiGqpg2HUk529DXbgFR4MGIBtinO1RyUX/FqFeDPR/xV
   pYd3lzy55j388RaraNyc+DFw8eJdqjXDl90xK3+NcfN+kbicrMoXREodQ
   LbUpFpG2POCHIgXSuOGCfAjFzfwDvLoY4a6hIafpn4+AhblwBFQw20d1T
   yCR19gA3mxKYsSCQpG3uxNgdQuosqu3YhFK//+U0gaMj+Y1Mvr67XB1Ho
   gyJ+/pfyz7GPJ0yEIyVp2bAM4CCavXQnHH90wgyQWuAdkReTo1yg9UcPk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256740617"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="256740617"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 17:16:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="715242207"
Received: from dstanfie-mobl2.amr.corp.intel.com (HELO [10.212.178.19]) ([10.212.178.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 17:16:27 -0700
Message-ID: <dd8be93c-ded6-b962-50d4-96b1c3afb2b7@intel.com>
Date:   Thu, 17 Mar 2022 17:16:18 -0700
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
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [x86/mm/tlb] 6035152d8e: will-it-scale.per_thread_ops -13.2%
 regression
In-Reply-To: <DC37F01B-A80F-4839-B4FB-C21F64943E64@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 13:32, Nadav Amit wrote:
> I’m not married to this patch, but before a revert it would be good
> to know why it even matters. I wonder whether you can confirm that
> reverting the patch (without the rest of the series) even helps. If
> it does, I’ll try to run some tests to understand what the heck is
> going on.

I went back and tested on a "Intel(R) Core(TM) i7-8086K CPU @ 4.00GHz"
which is evidently a 6-core "Coffee Lake".  It needs retpolines:

> /sys/devices/system/cpu/vulnerabilities/spectre_v2:Mitigation: Full
generic retpoline, IBPB: conditional, IBRS_FW, STIBP: conditional, RSB
filling

I ran the will-it-scale test:

	./malloc1_threads -s 30 -t 12

and took the 30-second average "ops/sec" at the two commits:

	4c1ba3923e:197876
	6035152d8e:199367 +0.75%

Where bigger is better.  So, a small win, but probably mostly in the
noise.  The number of IPIs definitely went up, probably 3-4% to get that
win.

IPI costs go up the more threads you throw at it.  The retpolines do
too, though because you do *more* of them.  Systems with no retpolines
get hit harder by the IPI costs and have no upsides from removing the
retpoline.

So, we've got a small (<1%, possibly zero) win on the bulk of systems
(which have retpolines).  Newer, retpoline-free systems see a
double-digit regression.  The bigger the system, the bigger the
regression (probably).

I tend to think the bigger regression wins and we should probably revert
the patch, or at least back out its behavior.

Nadav, do you have some different data or a different take?
