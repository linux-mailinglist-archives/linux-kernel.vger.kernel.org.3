Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511065A0F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiHYLn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbiHYLnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:43:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029CD9F0F0;
        Thu, 25 Aug 2022 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661427803; x=1692963803;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=tYG7WhfDi49Qt6vYSgp3uYShnGTRn+X7NAL+bBNRm8c=;
  b=C8hqtsQjY910L1h3IfwEP1KDpg810BkX1FxFfYvnOZ80263XYRlk1b5R
   nx0Zcbn96GV3ldS/u88DD1s+NMqRyjx+jF2lQ5DGZc3hQ7IVEXpC82P3k
   DNnRpBr4+fEr1D4LlGPnarTUgiZAAtDuW8w7cCe+/zeuTIpsYImY1qqga
   4B9S8aGCQXLLYd+zRpomOAOp8a4ewWTuQQtWyu4kwXeHVTP0R2gu1arzW
   RwGz6XjFfYRVtBfMF/JGaio7ZKmckdOhjtRRRKSumAJSjr9D2zThxQdz7
   Td9SJBXh+npkczVfvVQIzxEcQJgrnomncm9gNKRZyHOdxzLtKM51JeU9h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="295497277"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="295497277"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:43:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="560996613"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.149])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 04:43:05 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH RFC 2/2] checkpatch: warn on usage of VM_BUG_ON() and
 friends
In-Reply-To: <b1103c81-0c56-0e9b-711c-246e431db151@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-3-david@redhat.com>
 <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
 <b1103c81-0c56-0e9b-711c-246e431db151@redhat.com>
Date:   Thu, 25 Aug 2022 14:43:02 +0300
Message-ID: <87y1vch7ll.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022, David Hildenbrand <david@redhat.com> wrote:
> On 24.08.22 18:52, Joe Perches wrote:
>> On Wed, 2022-08-24 at 18:31 +0200, David Hildenbrand wrote:
>>> checkpatch does not point out that VM_BUG_ON() and friends should be
>>> avoided, however, Linus notes:
>>>
>>>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>>>     no different, the only difference is "we can make the code smaller
>>>     because these are less important". [1]
>>>
>>> So let's warn on VM_BUG_ON() and friends as well. While at it, make it
>>> clearer that the kernel really shouldn't be crashed.
>>>
>>> Note that there are some other *_BUG_ON flavors, but they are not all
>>> bad: for example, KVM_BUG_ON() only triggers a WARN_ON_ONCE and then
>>> flags KVM as being buggy, so we'll not care about them for now here.
>> []
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> []
>>> @@ -4695,12 +4695,12 @@ sub process {
>>>  			}
>>>  		}
>>>  
>>> -# avoid BUG() or BUG_ON()
>>> -		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
>>> +# do not use BUG(), BUG_ON(), VM_BUG_ON() and friends.
>>> +		if ($line =~ /\b(?:BUG|BUG_ON|VM_BUG_ON|VM_BUG_ON_[A-Z]+)\b/) {
>> 
>> Perhaps better as something like the below to pick up more variants
>> 
>
> Trying to find more possible variants and exceptions

> CI_BUG_ON(
> -> Bad with CONFIG_DRM_I915_DEBUG
> GEM_BUG_ON(
> -> Bad with CONFIG_DRM_I915_DEBUG_GEM_ONCE

These are hidden behind debug knobs that we use in our CI to
specifically catch "should not happen" cases fast and loud. Should not
be a problem for regular users.

BR,
Jani.


> So an extended versions of your proposal like (ignoring do_BUG and handle_BUG, people are smart enough to figure that out)
>
> if ($line =~ /\b(?!AA_|BUILD_|DCCP_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/
>
> ?

-- 
Jani Nikula, Intel Open Source Graphics Center
