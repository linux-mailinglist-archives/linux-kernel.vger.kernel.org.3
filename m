Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEAA5AD1C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbiIELrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiIELq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:46:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2F85B7BE;
        Mon,  5 Sep 2022 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662378416; x=1693914416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rmq9EipHS9L8xFuFMT+S4A7GTg/VyYZlxDZR36o9V9g=;
  b=BRZmBspeJtgEzhH/0yaLv1RaiA0yzs2rFX9wldtnDBWYQBGlIzB8KsI1
   fu9yHd+pAbM10Ps4G2mUPNZrPq9i5/C2TD6rZHW8qS9jY6W8NyM/yJnBE
   B4ON0IqOVebu7/fYMrCl0ln1mSUl6sX5ux92cMRTFVwbUYS46fBUQSlr4
   flqET9prekWSoVupPr38qU2r6fLtQPeFb3bQ8ZUZBb99IxNGRKlTY09cJ
   aFEmJunIX3ohW+SDwNCuQqRGE5lkElHpOCg0ljLeSUvsAdRXsTbrHE4Xa
   zEWSrMbDLPY8VXg6zKjzpOYx6b7XhTzEMlW6tCgUEhpMJyL+tnHbSHLJH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="276766910"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="276766910"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 04:46:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="609654202"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 04:46:53 -0700
Message-ID: <030c90fe-a09b-eff2-a1cf-55f6609825fb@intel.com>
Date:   Mon, 5 Sep 2022 14:46:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: perf top -p broken for multithreaded processes since 5.19
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     =?UTF-8?B?VG9tw6HFoSBUcm5rYQ==?= <trnka@scm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
 <2fd9b620-e9a8-9cd9-1b4a-6b13d829b2ae@intel.com>
 <YxJW19MwaMOb8D30@kernel.org>
 <ca905aa0-9d7b-d6d8-c789-2bd22057619b@intel.com>
 <YxNf2/H5Iyz5M8sn@kernel.org>
 <9a7bc232-e647-0667-4402-2f207003854b@intel.com>
 <CA+JHD91ReRGYNiBuO=1CGNZy1egcMjDo+VFO=kmCFrqE0mnK7w@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+JHD91ReRGYNiBuO=1CGNZy1egcMjDo+VFO=kmCFrqE0mnK7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/09/22 21:42, Arnaldo Carvalho de Melo wrote:
> 
> 
> On September 3, 2022 2:35:09 PM GMT-03:00, Adrian Hunter <adrian.hunter@intel.com <mailto:adrian.hunter@intel.com>> wrote:
>>On 3/09/22 17:08, Arnaldo Carvalho de Melo wrote:
>>> Em Sat, Sep 03, 2022 at 10:14:25AM +0300, Adrian Hunter escreveu:
>>>> On 2/09/22 22:17, Arnaldo Carvalho de Melo wrote:
>>>>> Em Fri, Sep 02, 2022 at 05:50:22PM +0300, Adrian Hunter escreveu:
>>>>>> On 2/09/22 17:46, Tomáš Trnka wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> A bug in perf v5.19 and newer completely breaks monitoring multithreaded
>>>>>>> processes using "perf top -p". The tool fails to start with "Failed to mmap
>>>>>>> with 22 (Invalid argument)". It still seems to work fine on single-threaded
>>>>>>> processes. "perf record" is also unaffected.
>>>>>>
>>>>>> It has been reported here:
>>>>>>
>>>>>>   https://bugzilla.kernel.org/show_bug.cgi?id=216441 <https://bugzilla.kernel.org/show_bug.cgi?id=216441>
>>>>>
>>>>> If I do:
>>>>>
>>>>> ⬢[acme@toolbox perf-urgent]$ git log -2
>>>>> commit dfeb0bc60782471c293938e71b1a1117cfac2cb3 (HEAD -> perf/urgent)
>>>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com <mailto:acme@redhat.com>>
>>>>> Date:   Fri Sep 2 16:15:39 2022 -0300
>>>>>
>>>>>     Revert "libperf evlist: Check nr_mmaps is correct"
>>>>>
>>>>>     This reverts commit 4ce47d842d4c16c07b135b8a7975b8f0672bcc0e.
>>>>>
>>>>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com <mailto:acme@redhat.com>>
>>>>>
>>>>> commit 78cd283f6b8ab701cb35eafd5af8140560a88f16
>>>>> Author: Arnaldo Carvalho de Melo <acme@redhat.com <mailto:acme@redhat.com>>
>>>>> Date:   Fri Sep 2 16:13:41 2022 -0300
>>>>>
>>>>>     Revert "libperf evlist: Allow mixing per-thread and per-cpu mmaps"
>>>>>
>>>>>     This reverts commit ae4f8ae16a07896403c90305d4b9be27f657c1fc.
>>>>>
>>>>>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com <mailto:acme@redhat.com>>
>>>>> ⬢[acme@toolbox perf-urgent]$
>>>>>
>>>>> It works again, Tomáš can you please try doing this to see if this works
>>>>> for you?
>>>>>
>>>>
>>>> This is the fix I have so far.  I would like to test it some more though.
>>>
>>> Ok, so I'll leave it for the next pull req, possibly after Linux
>>> Plumbers.
>>>
>>> What do you think about reverting those two patches for v6.0 and then
>>> add this for v6.1?
>>
>>That would break sideband collection with selected CPUs, so I would
>>prefer to avoid that.
>>
>>The fix is a effectively a partial revert of "libperf evlist: Allow
>>mixing per-thread and per-cpu mmaps" anyway.  I just need a few days
>>to do more testing.
> 
> Ok, please add any insight or clarification you find while testing to the end result patch, like this sideband collection with selected CPUs.
> 
> This is all complex, so even comments being prone to drift from code, having them added in the commit log message, associated with the codebase at that time may help us in the future when fixing problems, using 'git blame'.

I finished the testing I wanted to do, and sent V2 of the patch with an expanded commit message:

https://lore.kernel.org/lkml/20220905114209.8389-1-adrian.hunter@intel.com/T/#u
