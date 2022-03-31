Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0294ED0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352118AbiCaAeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiCaAeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:34:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496B93525A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648686757; x=1680222757;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=LoTVhZ4P/qZYHzSeRGGVDsqEb1jnpbThtF8t4ridIaE=;
  b=X/c+u/aDCGytfBo35d3P2UxioU3hJyjTlc505fN/z5Pd8PAHAC6RKffq
   RPNQZhwN1UYJRFbnF9RaOK5QlwQeM0K0JXBWNKs53zgFbAtRCOrZlsrHE
   tmGRldPfv/C3Pt9Kx1xNRY6tnppAjnnAZbMT3ZzvRl4z5YSc6qGgxi2kD
   LVojWT0gRS+UIoMj9NYUtCw2w9IPhLMwiWJ7todghyrc9CjiPsq68k35K
   eGUNiaTo7hS8FArIDgnCif4xf1Ty5rFCPiWyeAWZS7QUR2kbUBrmPCKri
   /t9WdcziYCBKZe8gN3e7ns8P4TF/lj1PpE1oBySpNLyVF1p6dfmdKqfkt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241830437"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241830437"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 17:32:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="565952972"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 17:32:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
        <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87lewrxsv1.fsf@linux.ibm.com>
Date:   Thu, 31 Mar 2022 08:32:33 +0800
In-Reply-To: <87lewrxsv1.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Wed, 30 Mar 2022 22:47:22 +0530")
Message-ID: <878rsrc672.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> Hi, Jagdish,
>>
>> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
>>
>
> ...
>
>>> e.g. with below NUMA topology, where node 0 & 1 are
>>> cpu + dram nodes, node 2 & 3 are equally slower memory
>>> only nodes, and node 4 is slowest memory only node,
>>>
>>> available: 5 nodes (0-4)
>>> node 0 cpus: 0 1
>>> node 0 size: n MB
>>> node 0 free: n MB
>>> node 1 cpus: 2 3
>>> node 1 size: n MB
>>> node 1 free: n MB
>>> node 2 cpus:
>>> node 2 size: n MB
>>> node 2 free: n MB
>>> node 3 cpus:
>>> node 3 size: n MB
>>> node 3 free: n MB
>>> node 4 cpus:
>>> node 4 size: n MB
>>> node 4 free: n MB
>>> node distances:
>>> node   0   1   2   3   4
>>>   0:  10  20  40  40  80
>>>   1:  20  10  40  40  80
>>>   2:  40  40  10  40  80
>>>   3:  40  40  40  10  80
>>>   4:  80  80  80  80  10
>>>
>>> The existing implementation gives below demotion targets,
>>>
>>> node    demotion_target
>>>  0              3, 2
>>>  1              4
>>>  2              X
>>>  3              X
>>>  4		X
>>>
>>> With this patch applied, below are the demotion targets,
>>>
>>> node    demotion_target
>>>  0              3, 2
>>>  1              3, 2
>>>  2              3
>>>  3              4
>>>  4		X
>>
>> For such machine, I think the perfect demotion order is,
>>
>> node    demotion_target
>>  0              2, 3
>>  1              2, 3
>>  2              4
>>  3              4
>>  4              X
>
> I guess the "equally slow nodes" is a confusing definition here. Now if the
> system consists of 2 1GB equally slow memory and the firmware doesn't want to
> differentiate between them, firmware can present a single NUMA node
> with 2GB capacity? The fact that we are finding two NUMA nodes is a hint
> that there is some difference between these two memory devices. This is
> also captured by the fact that the distance between 2 and 3 is 40 and not 10.

Do you have more information about this?

Best Regards,
Huang, Ying

> For that specific topology where the distance between 2 and 3 is 40 and 2
> and 4 is 80, the demotion target derived by the new code is better
> right? 
>
> ...
>
>
> -aneesh
