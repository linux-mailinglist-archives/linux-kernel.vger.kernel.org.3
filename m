Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF66E5AC00A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiICRfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiICRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:35:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F4E23BEF;
        Sat,  3 Sep 2022 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662226514; x=1693762514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bQmJFm6kayaAxD5+OxmTtLH14Ox/blH2BcitTjW6+pA=;
  b=aPjY2ijl5F8gitGrQzCCsD45VqJXPjlzM8d3v3A1M2bdbYz3j3YyTFvt
   BFhv0winGlJjICkUsekd/XVpDhw4T+ayqAnAEdtn04TzR1El1VdivkDZm
   TWSbJDSy4fTLamarf2dAAEfdrmC1E4g2p4xRLhxT4lB6wpy/8fC41fDnw
   U780IQnpT9F4GZ1mcOoYKg7GHN78mbNP2eHtZMRetmT3fvWHjUaRoIjP/
   Mb26tAwha+zRDqBLX+u/zjrX5Yl+t2N5MOYSsga43GBDqUHsXBGyfp+U/
   FLQMHngv3KaoPRiS8m49OJdWH22hcGfdIqvTkaLaYsCy/ah/wASNZNURT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="293762905"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="293762905"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 10:35:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="674750030"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.218])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 10:35:12 -0700
Message-ID: <9a7bc232-e647-0667-4402-2f207003854b@intel.com>
Date:   Sat, 3 Sep 2022 20:35:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: perf top -p broken for multithreaded processes since 5.19
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     =?UTF-8?B?VG9tw6HFoSBUcm5rYQ==?= <trnka@scm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
 <2fd9b620-e9a8-9cd9-1b4a-6b13d829b2ae@intel.com>
 <YxJW19MwaMOb8D30@kernel.org>
 <ca905aa0-9d7b-d6d8-c789-2bd22057619b@intel.com>
 <YxNf2/H5Iyz5M8sn@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YxNf2/H5Iyz5M8sn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/09/22 17:08, Arnaldo Carvalho de Melo wrote:
> Em Sat, Sep 03, 2022 at 10:14:25AM +0300, Adrian Hunter escreveu:
>> On 2/09/22 22:17, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Sep 02, 2022 at 05:50:22PM +0300, Adrian Hunter escreveu:
>>>> On 2/09/22 17:46, Tomáš Trnka wrote:
>>>>> Hello,
>>>>>
>>>>> A bug in perf v5.19 and newer completely breaks monitoring multithreaded
>>>>> processes using "perf top -p". The tool fails to start with "Failed to mmap
>>>>> with 22 (Invalid argument)". It still seems to work fine on single-threaded
>>>>> processes. "perf record" is also unaffected.
>>>>
>>>> It has been reported here:
>>>>
>>>> 	https://bugzilla.kernel.org/show_bug.cgi?id=216441
>>>
>>> If I do:
>>>
>>> ⬢[acme@toolbox perf-urgent]$ git log -2
>>> commit dfeb0bc60782471c293938e71b1a1117cfac2cb3 (HEAD -> perf/urgent)
>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> Date:   Fri Sep 2 16:15:39 2022 -0300
>>>
>>>     Revert "libperf evlist: Check nr_mmaps is correct"
>>>
>>>     This reverts commit 4ce47d842d4c16c07b135b8a7975b8f0672bcc0e.
>>>
>>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>
>>> commit 78cd283f6b8ab701cb35eafd5af8140560a88f16
>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> Date:   Fri Sep 2 16:13:41 2022 -0300
>>>
>>>     Revert "libperf evlist: Allow mixing per-thread and per-cpu mmaps"
>>>
>>>     This reverts commit ae4f8ae16a07896403c90305d4b9be27f657c1fc.
>>>
>>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> ⬢[acme@toolbox perf-urgent]$
>>>
>>> It works again, Tomáš can you please try doing this to see if this works
>>> for you?
>>>
>>
>> This is the fix I have so far.  I would like to test it some more though.
> 
> Ok, so I'll leave it for the next pull req, possibly after Linux
> Plumbers.
> 
> What do you think about reverting those two patches for v6.0 and then
> add this for v6.1?

That would break sideband collection with selected CPUs, so I would
prefer to avoid that.

The fix is a effectively a partial revert of "libperf evlist: Allow
mixing per-thread and per-cpu mmaps" anyway.  I just need a few days
to do more testing.
