Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF91543B43
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiFHSRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiFHSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:15:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7663CF66
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654712128; x=1686248128;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vpePlkkr31O+12oQPMGrUPgWXPUGbY6W3sgTE/Dq26M=;
  b=Zoh89d9hbU2p3iEu+36XAK7EqGCm16FVz/+rxiEi1KceuShJp0fE9WX4
   5ENHxktXQSCfT1GSd4X7a33Tvlh++Lhi7QO2gQ0wXYTX+3bDDMbZ4/u5q
   O8YPv6cv+nOF3LUC9dGSsU+HigGMcv1FMwwTh9NDzk+FBuWEg90QRD92E
   fLpzuyISLnBjZ2Wu90eAHWrsa6qGxjmqTMB+XAFB9TgalJw74oxb1+uG7
   TggKE3DR2atvDsX/IVYhedZvqXiGy/gYvcQ/fHJN5a+/PI8WvC+sXMT9G
   ttR9zgLrxwmaYymazbwJOp4eq4glNtumfzaW21jAyCVQxwv0bLyI1CHHY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277822160"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="277822160"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 11:15:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="580180635"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.124.119])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 11:15:27 -0700
Message-ID: <6096c96086187e51706898e58610fc0148b4ca23.camel@linux.intel.com>
Subject: Re: [PATCH] mm: mempolicy: N:M interleave policy for tiered memory
 nodes
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
Cc:     Hao Wang <haowang3@fb.com>, Abhishek Dhanotia <abhishekd@fb.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Hasan Al Maruf <hasanalmaruf@fb.com>
Date:   Wed, 08 Jun 2022 11:15:27 -0700
In-Reply-To: <20220607171949.85796-1-hannes@cmpxchg.org>
References: <20220607171949.85796-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-07 at 13:19 -0400, Johannes Weiner wrote:
> 
>  /* Do dynamic interleaving for a process */
>  static unsigned interleave_nodes(struct mempolicy *policy)
>  {
>  	unsigned next;
>  	struct task_struct *me = current;
>  
> -	next = next_node_in(me->il_prev, policy->nodes);
> +	if (numa_tier_interleave[0] > 1 || numa_tier_interleave[1] > 1) {

When we have three memory tiers, do we expect an N:M:K policy?
Like interleaving between DDR5, DDR4 and PMEM memory.
Or we expect an N:M policy still by interleaving between two specific tiers?

The other question is whether we will need multiple interleave policies depending
on cgroup?
One policy could be interleave between tier1, tier2, tier3.
Another could be interleave between tier1 and tier2.

In the current implementation we have one global interleave knob
defined by numa_iter_interleave[].

Tim


