Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164595008FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbiDNI7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiDNI7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:59:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB78A674F7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649926630; x=1681462630;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tLaRkQDxia82zDYbjT8YtujxT1/TuK3a5kx+Pr2IB8w=;
  b=m/PgyYMPEvZ9no5PIadxOUr3aqV4/F+T54GRXpNeMm0ni39FmpJLTFVC
   b3hsK2txwsx5Dj53elItDngPry1W/xExKeEO16+Y4/cTB7ZAyyp1PVFnD
   0VWWcOQVRpKWGhVsFxXf0PNz2njRMB+ocZL7HJ5kc3zef4gJ/u6oD5rvb
   JrwLkHW3lw7q9trXlO9EdOyibiXnaNEQSZkv8ZzJ6SkSCtOkVzeHSsNeo
   jItdyrxM6aDi6dEq6B7tKGWeF4UF1et8zLKDfXyuyf+eQ9jbCmX068P+2
   epk4QP9b/2G94yctlS/pyHeBUg89F7B8Ic7vqPWHHS85p84+EK2NkRgHh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262328459"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="262328459"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 01:57:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="573682710"
Received: from xikunjia-mobl1.ccr.corp.intel.com ([10.254.215.168])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 01:57:08 -0700
Message-ID: <d330a8942933e7c0fd4ea35b2c96948cd034aae2.camel@intel.com>
Subject: Re: [PATCH v2 1/5] mm: demotion: Set demotion list differently
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com
Date:   Thu, 14 Apr 2022 16:57:04 +0800
In-Reply-To: <YlffwGJg/RWCYja7@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
         <20220413092206.73974-2-jvgediya@linux.ibm.com>
         <4288cbad49690d7c4eb2b1d705eea01221ab8328.camel@intel.com>
         <YlffwGJg/RWCYja7@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-14 at 14:18 +0530, Jagdish Gediya wrote:
> On Thu, Apr 14, 2022 at 03:09:42PM +0800, ying.huang@intel.com wrote:
> > On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> > > Sharing used_targets between multiple nodes in a single
> > > pass limits some of the opportunities for demotion target
> > > sharing.
> > > 
> > > Don't share the used targets between multiple nodes in a
> > > single pass, instead accumulate all the used targets in
> > > source nodes shared by all pass, and reset 'used_targets'
> > > to source nodes while finding demotion targets for any new
> > > node.
> > > 
> > > This results into some more opportunities to share demotion
> > > targets between multiple source nodes, e.g. with below NUMA
> > > topology, where node 0 & 1 are cpu + dram nodes, node 2 & 3
> > > are equally slower memory only nodes, and node 4 is slowest
> > > memory only node,
> > > 
> > > available: 5 nodes (0-4)
> > > node 0 cpus: 0 1
> > > node 0 size: n MB
> > > node 0 free: n MB
> > > node 1 cpus: 2 3
> > > node 1 size: n MB
> > > node 1 free: n MB
> > > node 2 cpus:
> > > node 2 size: n MB
> > > node 2 free: n MB
> > > node 3 cpus:
> > > node 3 size: n MB
> > > node 3 free: n MB
> > > node 4 cpus:
> > > node 4 size: n MB
> > > node 4 free: n MB
> > > node distances:
> > > node   0   1   2   3   4
> > >   0:  10  20  40  40  80
> > >   1:  20  10  40  40  80
> > >   2:  40  40  10  40  80
> > >   3:  40  40  40  10  80
> > >   4:  80  80  80  80  10
> > > 
> > > The existing implementation gives below demotion targets,
> > > 
> > > node    demotion_target
> > >  0              3, 2
> > >  1              4
> > >  2              X
> > >  3              X
> > >  4              X
> > > 
> > > With this patch applied, below are the demotion targets,
> > > 
> > > node    demotion_target
> > >  0              3, 2
> > >  1              3, 2
> > >  2              4
> > >  3              4
> > >  4              X
> > > 
> > > e.g. with below NUMA topology, where node 0, 1 & 2 are
> > > cpu + dram nodes and node 3 is slow memory node,
> > > 
> > > available: 4 nodes (0-3)
> > > node 0 cpus: 0 1
> > > node 0 size: n MB
> > > node 0 free: n MB
> > > node 1 cpus: 2 3
> > > node 1 size: n MB
> > > node 1 free: n MB
> > > node 2 cpus: 4 5
> > > node 2 size: n MB
> > > node 2 free: n MB
> > > node 3 cpus:
> > > node 3 size: n MB
> > > node 3 free: n MB
> > > node distances:
> > > node   0   1   2   3
> > >   0:  10  20  20  40
> > >   1:  20  10  20  40
> > >   2:  20  20  10  40
> > >   3:  40  40  40  10
> > > 
> > > The existing implementation gives below demotion targets,
> > > 
> > > node    demotion_target
> > >  0              3
> > >  1              X
> > >  2              X
> > >  3              X
> > > 
> > > With this patch applied, below are the demotion targets,
> > > 
> > > node    demotion_target
> > >  0              3
> > >  1              3
> > >  2              3
> > >  3              X
> > > 
> > 
> > With the [PATCH v1], you have describe the demotion order changes for
> > the following system, I guess there's no change with [PATCH v2]?
> 
> Yes, there is no change with v2.
> 
> > With below NUMA topology, where node 0 & 2 are cpu + dram
> > nodes and node 1 & 3 are slow memory nodes,
> > 
> > available: 4 nodes (0-3)
> > node 0 cpus: 0 1
> > node 0 size: n MB
> > node 0 free: n MB
> > node 1 cpus:
> > node 1 size: n MB
> > node 1 free: n MB
> > node 2 cpus: 2 3
> > node 2 size: n MB
> > node 2 free: n MB
> > node 3 cpus:
> > node 3 size: n MB
> > node 3 free: n MB
> > node distances:
> > node   0   1   2   3
> >   0:  10  40  20  80
> >   1:  40  10  80  80
> >   2:  20  80  10  40
> >   3:  80  80  40  10
> > 
> > And, what is the demotion order for the following system with [PATCH
> > v2]?
> > 
> > Node 0 & 2 are cpu + dram nodes and node 1 are slow
> > memory node near node 0,
> > 
> > available: 3 nodes (0-2)
> > node 0 cpus: 0 1
> > node 0 size: n MB
> > node 0 free: n MB
> > node 1 cpus:
> > node 1 size: n MB
> > node 1 free: n MB
> > node 2 cpus: 2 3
> > node 2 size: n MB
> > node 2 free: n MB
> > node distances:
> > node   0   1   2
> >   0:  10  40  20
> >   1:  40  10  80
> >   2:  20  80  10
> 
> node 1 is demotion target for both node 0 and node 2 with this patch.
> node 1 is demotion target only for node 0 with existing implementation,
> however if node 1 is near to node 2 instead of node 0, still existing
> implementation will give node 1 as demotion target only for node 0 which
> is not the correct behavior.
> 
> for both the scenario, with this patch applied, node 1 will be demotion
> target for both 0 and 2.
> 

Sounds good!  Thanks.

Acked-by: "Huang, Ying" <ying.huang@intel.com>

> > Best Regards,
> > Huang, Ying
> > 
> > 
> > [snip]
> > 
> > 
> > 
> Best regards,
> Jagdish


