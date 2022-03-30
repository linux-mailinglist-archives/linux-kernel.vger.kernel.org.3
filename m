Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D1A4EBB09
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbiC3GtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbiC3Gsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:48:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D1289330
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648622816; x=1680158816;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=1jS6mrvvrk0FhpnC8+5qcpTEmgGUnYdS15XRcziWF2M=;
  b=MMkJrFRvHc/g/yOWDCq/z6MZM+qSxIQVQCkXjm9/IIdMzabTI1jVSymQ
   /Co9CgO6WDHony+UtMq+cdfKGKsm5lBRRhui7zKf+hnN3TmHWb0gKms6x
   4zjrEnhgB8CKBFUxLq3SLldXaluZ6zJEMxxa4M2VhFb6cThDBo37feMht
   4eqneEzD3JlGNIoRAiQrJYDeEEr6P5qHcc2TU5CZjnFn6cTI7Z+QpM0mw
   rIgfwD6o+M2PH1HTAoITGj9iKLhcGC2GyiLl2cbn3G7euTJ+8L6WiSdsQ
   yzvVM1Q9biGq877gwF0SHuUR+vTCZRyQ8NIR9o84HeZFT/Zrmql61InFb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345897091"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="345897091"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:46:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="546726375"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:46:53 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
Date:   Wed, 30 Mar 2022 14:46:51 +0800
In-Reply-To: <20220329115222.8923-1-jvgediya@linux.ibm.com> (Jagdish Gediya's
        message of "Tue, 29 Mar 2022 17:22:22 +0530")
Message-ID: <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jagdish,

Jagdish Gediya <jvgediya@linux.ibm.com> writes:

> The current implementation to identify the demotion
> targets limits some of the opportunities to share
> the demotion targets between multiple source nodes.

Yes.  It sounds reasonable to share demotion targets among multiple
source nodes.

One question, are example machines below are real hardware now or in
near future?  Or you just think they are possible?

And, before going into the implementation details, I think that we can
discuss the perfect demotion order firstly.

> Implement a logic to identify the loop in the demotion
> targets such that all the possibilities of demotion can
> be utilized. Don't share the used targets between all
> the nodes, instead create the used targets from scratch
> for each individual node based on for what all node this
> node is a demotion target. This helps to share the demotion
> targets without missing any possible way of demotion.
>
> e.g. with below NUMA topology, where node 0 & 1 are
> cpu + dram nodes, node 2 & 3 are equally slower memory
> only nodes, and node 4 is slowest memory only node,
>
> available: 5 nodes (0-4)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus: 2 3
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus:
> node 2 size: n MB
> node 2 free: n MB
> node 3 cpus:
> node 3 size: n MB
> node 3 free: n MB
> node 4 cpus:
> node 4 size: n MB
> node 4 free: n MB
> node distances:
> node   0   1   2   3   4
>   0:  10  20  40  40  80
>   1:  20  10  40  40  80
>   2:  40  40  10  40  80
>   3:  40  40  40  10  80
>   4:  80  80  80  80  10
>
> The existing implementation gives below demotion targets,
>
> node    demotion_target
>  0              3, 2
>  1              4
>  2              X
>  3              X
>  4		X
>
> With this patch applied, below are the demotion targets,
>
> node    demotion_target
>  0              3, 2
>  1              3, 2
>  2              3
>  3              4
>  4		X

For such machine, I think the perfect demotion order is,

node    demotion_target
 0              2, 3
 1              2, 3
 2              4
 3              4
 4              X

> e.g. with below NUMA topology, where node 0, 1 & 2 are
> cpu + dram nodes and node 3 is slow memory node,
>
> available: 4 nodes (0-3)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus: 2 3
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 4 5
> node 2 size: n MB
> node 2 free: n MB
> node 3 cpus:
> node 3 size: n MB
> node 3 free: n MB
> node distances:
> node   0   1   2   3
>   0:  10  20  20  40
>   1:  20  10  20  40
>   2:  20  20  10  40
>   3:  40  40  40  10
>
> The existing implementation gives below demotion targets,
>
> node    demotion_target
>  0              3
>  1              X
>  2              X
>  3              X
>
> With this patch applied, below are the demotion targets,
>
> node    demotion_target
>  0              3
>  1              3
>  2              3
>  3              X

I think this is perfect already.

> with below NUMA topology, where node 0 & 2 are cpu + dram
> nodes and node 1 & 3 are slow memory nodes,
>
> available: 4 nodes (0-3)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus:
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 2 3
> node 2 size: n MB
> node 2 free: n MB
> node 3 cpus:
> node 3 size: n MB
> node 3 free: n MB
> node distances:
> node   0   1   2   3
>   0:  10  40  20  80
>   1:  40  10  80  80
>   2:  20  80  10  40
>   3:  80  80  40  10
>
> The existing implementation gives below demotion targets,
>
> node    demotion_target
>  0              3
>  1              X
>  2              3
>  3              X

Should be as below as you said in another email of the thread.

node    demotion_target
 0              1
 1              X
 2              3
 3              X

> With this patch applied, below are the demotion targets,
>
> node    demotion_target
>  0              1
>  1              3
>  2              3
>  3              X

The original demotion order looks better for me.  1 and 3 are at the
same level from the perspective of the whole system.

Another example, node 0 & 2 are cpu + dram nodes and node 1 are slow
memory node near node 0,

available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: n MB
node 0 free: n MB
node 1 cpus:
node 1 size: n MB
node 1 free: n MB
node 2 cpus: 2 3
node 2 size: n MB
node 2 free: n MB
node distances:
node   0   1   2
  0:  10  40  20
  1:  40  10  80
  2:  20  80  10


Demotion order 1:

node    demotion_target
 0              1
 1              X
 2              X

Demotion order 2:

node    demotion_target
 0              1
 1              X
 2              1

Demotion order 2 looks better.  But I think that demotion order 1 makes
some sense too (like node reclaim mode).

It seems that,

If a demotion target has same distance to several current demotion
sources, the demotion target should be shared among the demotion
sources.

And as Dave pointed out, we may eventually need a mechanism to override
the default demotion order generated automatically.  So we can just use
some simple mechanism that makes sense in most cases in kernel
automatically.  And leave the best demotion for users to some
customization mechanism.

> As it can be seen above, node 3 can be demotion target for node
> 1 but existing implementation doesn't configure it that way. It
> is better to move pages from node 1 to node 3 instead of moving
> it from node 1 to swap.
>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Best Regards,
Huang, Ying

[snip]
