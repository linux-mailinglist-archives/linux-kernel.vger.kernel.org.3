Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0645006B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbiDNHMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbiDNHMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:12:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688EFDED3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649920196; x=1681456196;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i31Itq3+QX6wvkcua8Gayai8JJVK/xFYQxC6/o50e9Q=;
  b=mxRzo3dJO1jLlSp8AHwC2lhYljSupeM7e3g8sKzI9QlraCbqgd94K1NO
   cLID8RvnuUKUG7ZzZgi9AcY6YvW1MjAxPs0mTTaDVZTNYI23uGJR7dmYU
   H+hGLZ7HfC4JdJgd5UN7sOzmd3uVEnyLO0NBeiC5Krn3Cyf+jTFDjxDlz
   dCLO6PPRVHPmy7osmn2hul0MF8yRRsxbq+C7a0EaArUZH+8fInTg28XBr
   sXHmccJXyYLnseePswdvot1YflYUV7AsSmjDg7Aa5dGEOdKKmo++9fBx7
   0HD30p3yAa+eJwRifd00JkWMTJzh1UsOdNcN5yB9Jr4TG7pTfiYgDPQDI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="349301892"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="349301892"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 00:09:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="552549964"
Received: from xikunjia-mobl1.ccr.corp.intel.com ([10.254.215.168])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 00:09:45 -0700
Message-ID: <4288cbad49690d7c4eb2b1d705eea01221ab8328.camel@intel.com>
Subject: Re: [PATCH v2 1/5] mm: demotion: Set demotion list differently
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com
Date:   Thu, 14 Apr 2022 15:09:42 +0800
In-Reply-To: <20220413092206.73974-2-jvgediya@linux.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
         <20220413092206.73974-2-jvgediya@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> Sharing used_targets between multiple nodes in a single
> pass limits some of the opportunities for demotion target
> sharing.
> 
> Don't share the used targets between multiple nodes in a
> single pass, instead accumulate all the used targets in
> source nodes shared by all pass, and reset 'used_targets'
> to source nodes while finding demotion targets for any new
> node.
> 
> This results into some more opportunities to share demotion
> targets between multiple source nodes, e.g. with below NUMA
> topology, where node 0 & 1 are cpu + dram nodes, node 2 & 3
> are equally slower memory only nodes, and node 4 is slowest
> memory only node,
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
>   0:  10  20  40  40  80
>   1:  20  10  40  40  80
>   2:  40  40  10  40  80
>   3:  40  40  40  10  80
>   4:  80  80  80  80  10
> 
> The existing implementation gives below demotion targets,
> 
> node    demotion_target
>  0              3, 2
>  1              4
>  2              X
>  3              X
>  4              X
> 
> With this patch applied, below are the demotion targets,
> 
> node    demotion_target
>  0              3, 2
>  1              3, 2
>  2              4
>  3              4
>  4              X
> 
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
>   0:  10  20  20  40
>   1:  20  10  20  40
>   2:  20  20  10  40
>   3:  40  40  40  10
> 
> The existing implementation gives below demotion targets,
> 
> node    demotion_target
>  0              3
>  1              X
>  2              X
>  3              X
> 
> With this patch applied, below are the demotion targets,
> 
> node    demotion_target
>  0              3
>  1              3
>  2              3
>  3              X
> 

With the [PATCH v1], you have describe the demotion order changes for
the following system, I guess there's no change with [PATCH v2]?

With below NUMA topology, where node 0 & 2 are cpu + dram
nodes and node 1 & 3 are slow memory nodes,

available: 4 nodes (0-3)
node 0 cpus: 0 1
node 0 size: n MB
node 0 free: n MB
node 1 cpus:
node 1 size: n MB
node 1 free: n MB
node 2 cpus: 2 3
node 2 size: n MB
node 2 free: n MB
node 3 cpus:
node 3 size: n MB
node 3 free: n MB
node distances:
node   0   1   2   3
  0:  10  40  20  80
  1:  40  10  80  80
  2:  20  80  10  40
  3:  80  80  40  10

And, what is the demotion order for the following system with [PATCH
v2]?

Node 0 & 2 are cpu + dram nodes and node 1 are slow
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

Best Regards,
Huang, Ying


[snip]


