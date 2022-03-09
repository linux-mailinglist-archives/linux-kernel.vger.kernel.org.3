Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05024D255F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiCIBJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiCIBJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:09:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0214CC87
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646787115; x=1678323115;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=rTewoYY5iGutquVo0W7aUnC1d1O9Xf62XUlk7Bo0QUQ=;
  b=GYVAVapQiDYTUgv/rnTsr7PnNCcG9BAhC6/xMJ3F82g0X87L+Iweofc7
   zr5j9jsWGahnayF85wKx1QLanKCUbl1B6dTRSeu7lS2LLQ8vJnLXOhCl0
   sCU/o5dX4A9Mcdf+3whjnDYkbgvvVotB4Z/CA3BQf9w6Fmg5aM4j3GCu4
   u7j+meckmwi0QoZZYJEs8vvm58mMVYm4p8pCaZy9Mo4/ToycG2M7d3KeI
   3yNnqhgisTrIYN/hWSEllZTrnJIhS9bk7A07yoA7Ei93bHodVjZs2g2Yn
   jC2ibZPnim4AD1wruuxeUNZwEjP0UQZJYo8U9emqgfvw6T6XTLk+zSIKL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254790602"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254790602"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 16:29:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="537793799"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 16:29:42 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
References: <20210721063926.3024591-1-ying.huang@intel.com>
        <20210721063926.3024591-2-ying.huang@intel.com>
        <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
        <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
        <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
        <87pmnb3ccr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YicvnkVODh5qbxTC@localhost.localdomain>
        <86383ac9-e5f2-1a2e-dd19-02e39714a3fd@intel.com>
        <Yiem+4YbComC0EGC@localhost.localdomain>
Date:   Wed, 09 Mar 2022 08:29:40 +0800
In-Reply-To: <Yiem+4YbComC0EGC@localhost.localdomain> (Oscar Salvador's
        message of "Tue, 8 Mar 2022 19:56:59 +0100")
Message-ID: <87k0d4ge8b.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Tue, Mar 08, 2022 at 09:07:20AM -0800, Dave Hansen wrote:
>> On 3/8/22 02:27, Oscar Salvador wrote:
>> > @@ -2043,7 +2044,12 @@ static void __init init_cpu_node_state(void)
>> >  static int vmstat_cpu_online(unsigned int cpu)
>> >  {
>> >  	refresh_zone_stat_thresholds();
>> > -	node_set_state(cpu_to_node(cpu), N_CPU);
>> > +
>> > +	if (!node_state(cpu_to_node(cpu), N_CPU)) {
>> > +		node_set_state(cpu_to_node(cpu), N_CPU);
>> > +		set_migration_target_nodes();
>> > +	}
>> > +
>> >  	return 0;
>> >  }
>> > 
>> > @@ -2066,6 +2072,8 @@ static int vmstat_cpu_dead(unsigned int cpu)
>> >  		return 0;
>> > 
>> >  	node_clear_state(node, N_CPU);
>> > +	set_migration_target_nodes();
>> > +
>> >  	return 0;
>> >  }
>> 
>> Yeah, those callbacks do look like they're reinventing the wheel.  This
>> is a much more direct way of doing it.
>
> Then let me play a bit more with it and I can cook a patch unless
> someone feels strong against it.

This looks good to me, Thanks!

Best Regards,
Huang, Ying
