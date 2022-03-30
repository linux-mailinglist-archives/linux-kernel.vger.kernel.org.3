Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38864EBB34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbiC3G4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243480AbiC3G4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:56:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7FFC6EC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648623260; x=1680159260;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=VDubrcJ+t/HcriuuOM+0EmGnOACs+PPtNfGVh1oRR0o=;
  b=h7iHS1AFga/UTygm+M1L4Rs/RmYnd7PZaqaOTrgkfzmiZlUm7/e2ViXU
   ROfd50g5v4YJ0tniRDaN9j8UQztryh6AMnOLt2gZmiNgmDlr2zep3ojBZ
   1TRqh1Ck33HsXRYByPd67DItUWENpC7e0mcZXaWo3OFE29hpko+m3AEM5
   atW3Top9vgYf3d4Ay+iK6PSTo3BHXVEKBfVHwnd1NMRzGyZSBXHQe1iIG
   MaU6MYgc7QjMLRx1oUBHf5/vLXYCe5rz9v+2pJf55AhlLnuoVgF0IehZ+
   GBg9EUlTaHXbs5WKrucYsxjjCoNtE7U2RyYnUvTyZLIWXfkiPMBlZfaFN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284367738"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="284367738"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:54:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="565342016"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:54:16 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
        <b7d1ab3b-e92c-d3aa-72cb-b80cc1a61e85@linux.alibaba.com>
        <YkMR8OY779Bcri3I@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
        <784aee91-6a01-6e67-389e-1e1883796894@linux.alibaba.com>
Date:   Wed, 30 Mar 2022 14:54:14 +0800
In-Reply-To: <784aee91-6a01-6e67-389e-1e1883796894@linux.alibaba.com> (Baolin
        Wang's message of "Wed, 30 Mar 2022 14:37:35 +0800")
Message-ID: <87lewsc4mh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> On 3/29/2022 10:04 PM, Jagdish Gediya wrote:
>> On Tue, Mar 29, 2022 at 08:26:05PM +0800, Baolin Wang wrote:
>> Hi Baolin,
>>> Hi Jagdish,
>>>
>>> On 3/29/2022 7:52 PM, Jagdish Gediya wrote:
>>>> The current implementation to identify the demotion
>>>> targets limits some of the opportunities to share
>>>> the demotion targets between multiple source nodes.
>>>>
>>>> Implement a logic to identify the loop in the demotion
>>>> targets such that all the possibilities of demotion can
>>>> be utilized. Don't share the used targets between all
>>>> the nodes, instead create the used targets from scratch
>>>> for each individual node based on for what all node this
>>>> node is a demotion target. This helps to share the demotion
>>>> targets without missing any possible way of demotion.
>>>>
>>>> e.g. with below NUMA topology, where node 0 & 1 are
>>>> cpu + dram nodes, node 2 & 3 are equally slower memory
>>>> only nodes, and node 4 is slowest memory only node,
>>>>
>>>> available: 5 nodes (0-4)
>>>> node 0 cpus: 0 1
>>>> node 0 size: n MB
>>>> node 0 free: n MB
>>>> node 1 cpus: 2 3
>>>> node 1 size: n MB
>>>> node 1 free: n MB
>>>> node 2 cpus:
>>>> node 2 size: n MB
>>>> node 2 free: n MB
>>>> node 3 cpus:
>>>> node 3 size: n MB
>>>> node 3 free: n MB
>>>> node 4 cpus:
>>>> node 4 size: n MB
>>>> node 4 free: n MB
>>>> node distances:
>>>> node   0   1   2   3   4
>>>>     0:  10  20  40  40  80
>>>>     1:  20  10  40  40  80
>>>>     2:  40  40  10  40  80
>>>>     3:  40  40  40  10  80
>>>>     4:  80  80  80  80  10
>>>>
>>>> The existing implementation gives below demotion targets,
>>>>
>>>> node    demotion_target
>>>>    0              3, 2
>>>>    1              4
>>>>    2              X
>>>>    3              X
>>>>    4		X
>>>>
>>>> With this patch applied, below are the demotion targets,
>>>>
>>>> node    demotion_target
>>>>    0              3, 2
>>>>    1              3, 2
>>>>    2              3
>>>>    3              4
>>>>    4		X
>>>
>>> Node 2 and node 3 both are slow memory and have same distance, why node 2
>>> should demote cold memory to node 3? They should have the same target
>>> demotion node 4, which is the slowest memory node, right?
>>>
>> Current demotion target finding algorithm works based on best distance, as distance between node 2 & 3 is 40 and distance between node 2 & 4 is 80, node 2 demotes to node 3.
>
> If node 2 can demote to node 3, which means node 3's memory is colder
> than node 2, right? The accessing time of node 3 should be larger than 
> node 2, then we can demote colder memory to node 3 from node 2.
>
> But node 2 and node 3 are same memory type and have same distance, the
> accessing time of node 2 and node 3 should be same too, so why add so 
> many page migration between node 2 and node 3? I'm still not sure the
> benefits.
>
> Huang Ying and Dave, how do you think about this demotion targets?

Yes.  I think the demotion target of 2 should be 4, as in my another
email in this thread.  Demoting from 2 to 3 makes no sense.

Best Regards,
Huang, Ying

[snip]
