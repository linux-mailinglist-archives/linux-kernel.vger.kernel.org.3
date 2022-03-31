Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06874ED0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352089AbiCaA3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCaA3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:29:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB2A4927D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 17:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648686445; x=1680222445;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=05NZE5gF3aTueVeP9ER6btTWaup1CWxlGpWSxDG8Dpk=;
  b=NmrDNpF2co1a7/frge7qhDgtRBzvfwWHDV3wigT+AqxF3gONTBjt3bCO
   ck24wNmjV5W0wQKYUmRBa1KThV5Zw2uNrCzHSi2QXE6x1R6XuMeFXo1vm
   0+ylBkM+Io7Y/yF0nE+Vf18nbx+4JsAdBTERur4r4SgZXNVVBddxnriRu
   9zggzCdP3hNWi8Ff0q76qD6PMSu5Hdeh8G5+xs/31rzCxmhxEly7JeezM
   aXJYt4lTy6o2xGMYnMKxn1qgXy24IVD6E0gihKZMAs9FZSDJyjYHGQABa
   PBgWn/qfsoXDxlGpD4ZMbVCz2FpZloSi1Q3DG/NwXCzNOTBWWy7akA2d9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241829840"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241829840"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 17:27:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="547066885"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 17:27:23 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
        <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YkSHJMsHMtKzCPhS@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
Date:   Thu, 31 Mar 2022 08:27:21 +0800
In-Reply-To: <YkSHJMsHMtKzCPhS@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
        (Jagdish Gediya's message of "Wed, 30 Mar 2022 22:06:52 +0530")
Message-ID: <87czi3c6fq.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Jagdish Gediya <jvgediya@linux.ibm.com> writes:

> Hi Huang,
>
> On Wed, Mar 30, 2022 at 02:46:51PM +0800, Huang, Ying wrote:
>> Hi, Jagdish,
>> 
>> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
>> 
>> > The current implementation to identify the demotion
>> > targets limits some of the opportunities to share
>> > the demotion targets between multiple source nodes.
>> 
>> Yes.  It sounds reasonable to share demotion targets among multiple
>> source nodes.
>> 
>> One question, are example machines below are real hardware now or in
>> near future?  Or you just think they are possible?
>
> They are not real hardware right now, they are the future possibilities.
>
>> And, before going into the implementation details, I think that we can
>> discuss the perfect demotion order firstly.
>> 
>> > Implement a logic to identify the loop in the demotion
>> > targets such that all the possibilities of demotion can
>> > be utilized. Don't share the used targets between all
>> > the nodes, instead create the used targets from scratch
>> > for each individual node based on for what all node this
>> > node is a demotion target. This helps to share the demotion
>> > targets without missing any possible way of demotion.
>> >
>> > e.g. with below NUMA topology, where node 0 & 1 are
>> > cpu + dram nodes, node 2 & 3 are equally slower memory
>> > only nodes, and node 4 is slowest memory only node,
>> >
>> > available: 5 nodes (0-4)
>> > node 0 cpus: 0 1
>> > node 0 size: n MB
>> > node 0 free: n MB
>> > node 1 cpus: 2 3
>> > node 1 size: n MB
>> > node 1 free: n MB
>> > node 2 cpus:
>> > node 2 size: n MB
>> > node 2 free: n MB
>> > node 3 cpus:
>> > node 3 size: n MB
>> > node 3 free: n MB
>> > node 4 cpus:
>> > node 4 size: n MB
>> > node 4 free: n MB
>> > node distances:
>> > node   0   1   2   3   4
>> >   0:  10  20  40  40  80
>> >   1:  20  10  40  40  80
>> >   2:  40  40  10  40  80
>> >   3:  40  40  40  10  80
>> >   4:  80  80  80  80  10
>> >
>> > The existing implementation gives below demotion targets,
>> >
>> > node    demotion_target
>> >  0              3, 2
>> >  1              4
>> >  2              X
>> >  3              X
>> >  4		X
>> >
>> > With this patch applied, below are the demotion targets,
>> >
>> > node    demotion_target
>> >  0              3, 2
>> >  1              3, 2
>> >  2              3
>> >  3              4
>> >  4		X
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
> Current implementation works based on the best distance algorithm,
> this patch doesn't change it either, so based on the distance, the
> demotion list is what I have mentioned. I understand 4 is better
> target for 2 but as per the mentioned numa distances and current
> algorithm, it doesn't get configured like that in the kernel.

If we agree on the perfect demotion order, can we revise the current
algorithm a little to make it happen?

Is the following solution possible?

1st round:
  sources: 0, 1
  exclude targets: 0, 1
  result: 0 - > 2,3; 1 -> 2,3

2nd round:
  sources: 2, 3
  exclude targets: 0, 1, 2, 3
  result: 2 -> 4; 3 -> 4

3rd round:
  sources: 4
  exclude targets: 0, 1, 2, 3, 4
  result: 4 -> X

That is, in each round, we exclude the sources and targets in the
previous rounds as demotion targets.  Compared with the original
algorithm, we don't exclude targets used in the current round,
but we will exclude them in the next round.

If this doesn't work, can you think about whether it is possible to find
some way?

>> > e.g. with below NUMA topology, where node 0, 1 & 2 are
>> > cpu + dram nodes and node 3 is slow memory node,
>> >
>> > available: 4 nodes (0-3)
>> > node 0 cpus: 0 1
>> > node 0 size: n MB
>> > node 0 free: n MB
>> > node 1 cpus: 2 3
>> > node 1 size: n MB
>> > node 1 free: n MB
>> > node 2 cpus: 4 5
>> > node 2 size: n MB
>> > node 2 free: n MB
>> > node 3 cpus:
>> > node 3 size: n MB
>> > node 3 free: n MB
>> > node distances:
>> > node   0   1   2   3
>> >   0:  10  20  20  40
>> >   1:  20  10  20  40
>> >   2:  20  20  10  40
>> >   3:  40  40  40  10
>> >
>> > The existing implementation gives below demotion targets,
>> >
>> > node    demotion_target
>> >  0              3
>> >  1              X
>> >  2              X
>> >  3              X
>> >
>> > With this patch applied, below are the demotion targets,
>> >
>> > node    demotion_target
>> >  0              3
>> >  1              3
>> >  2              3
>> >  3              X
>> 
>> I think this is perfect already.
>> 
>> > with below NUMA topology, where node 0 & 2 are cpu + dram
>> > nodes and node 1 & 3 are slow memory nodes,
>> >
>> > available: 4 nodes (0-3)
>> > node 0 cpus: 0 1
>> > node 0 size: n MB
>> > node 0 free: n MB
>> > node 1 cpus:
>> > node 1 size: n MB
>> > node 1 free: n MB
>> > node 2 cpus: 2 3
>> > node 2 size: n MB
>> > node 2 free: n MB
>> > node 3 cpus:
>> > node 3 size: n MB
>> > node 3 free: n MB
>> > node distances:
>> > node   0   1   2   3
>> >   0:  10  40  20  80
>> >   1:  40  10  80  80
>> >   2:  20  80  10  40
>> >   3:  80  80  40  10
>> >
>> > The existing implementation gives below demotion targets,
>> >
>> > node    demotion_target
>> >  0              3
>> >  1              X
>> >  2              3
>> >  3              X
>> 
>> Should be as below as you said in another email of the thread.
>> 
>> node    demotion_target
>>  0              1
>>  1              X
>>  2              3
>>  3              X
>> 
>> > With this patch applied, below are the demotion targets,
>> >
>> > node    demotion_target
>> >  0              1
>> >  1              3
>> >  2              3
>> >  3              X
>> 
>> The original demotion order looks better for me.  1 and 3 are at the
>> same level from the perspective of the whole system.
>> 
>> Another example, node 0 & 2 are cpu + dram nodes and node 1 are slow
>> memory node near node 0,
>> 
>> available: 3 nodes (0-2)
>> node 0 cpus: 0 1
>> node 0 size: n MB
>> node 0 free: n MB
>> node 1 cpus:
>> node 1 size: n MB
>> node 1 free: n MB
>> node 2 cpus: 2 3
>> node 2 size: n MB
>> node 2 free: n MB
>> node distances:
>> node   0   1   2
>>   0:  10  40  20
>>   1:  40  10  80
>>   2:  20  80  10
>> 
>> 
>> Demotion order 1:
>> 
>> node    demotion_target
>>  0              1
>>  1              X
>>  2              X
>> 
>> Demotion order 2:
>> 
>> node    demotion_target
>>  0              1
>>  1              X
>>  2              1
>> 
>> Demotion order 2 looks better.  But I think that demotion order 1 makes
>> some sense too (like node reclaim mode).
>> 
>> It seems that,
>> 
>> If a demotion target has same distance to several current demotion
>> sources, the demotion target should be shared among the demotion
>> sources.
>
> Yes, and that is where this patch is useful.
>
>> And as Dave pointed out, we may eventually need a mechanism to override
>> the default demotion order generated automatically.  So we can just use
>> some simple mechanism that makes sense in most cases in kernel
>> automatically.  And leave the best demotion for users to some
>> customization mechanism.
>
> Yes, We need a mechanism to override the default demotion list prepared
> by the current implementation. PowerVM can have a cpu less dram node
> as well, which infact are not the right target for demotion because
> it is the fast memory. We need to distinguish between memory tiers
> so that slow memory can be utilized for the demotion even when there
> are fast memory only numa nodes.
>
> I think we may see implementations in future to override the default
> behavior e.g. when systems have both fast only and slow only memory
> nodes and in that case it will make sense to demote to slow memory
> only node even if it is far, but this patch is to put the current
> implementation to its intended design 'best distance based demotion
> targets'.

If this is a real problem for you already.  How about implement it after
this work has been done?

Best Regards,
Huang, Ying

>> > As it can be seen above, node 3 can be demotion target for node
>> > 1 but existing implementation doesn't configure it that way. It
>> > is better to move pages from node 1 to node 3 instead of moving
>> > it from node 1 to swap.
>> >
>> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> 
>> Best Regards,
>> Huang, Ying
>> 
>> [snip]
>> 
> Best Regards,
> Jagdish
