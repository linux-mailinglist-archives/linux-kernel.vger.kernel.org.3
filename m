Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD2B500680
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiDNHDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbiDNHDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:03:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7627125C53
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649919653; x=1681455653;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8xWog9zGW+mcEtivSRwiLZXS7DeB7rdKhN8pS3VC9/s=;
  b=DXaAbevdn2IJssDbpRMvhSik0vl6LGuoxFwjeVn54F0pXm6DShSdNOMS
   OzccBIogYlojcp5XtY64CgHC1Cvzr7kIQlMNlX1qB7gycpAN0usah37In
   sjwWkQv3ZRmwl5JSLfWRyFkkI9az/eQiS4vf+7Wpm2tlnH2Wp2wAxOFM9
   tU5Ql710YVWJ0v7Zg4NxczwTBf/Ay78Zw3uDoliYux6kThoQ2PBd7QWoS
   VglfvJZ6AqbxljJtyqbnmp0h01om/5O27isyxA0qwxSouns0eCAuH3q7R
   ZQuSST0sq34dSnhCF7TtmD7CiBbpD4BDowJNdgp9COKjJvg8g7E06kXK1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244749827"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="244749827"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 00:00:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="527278543"
Received: from xikunjia-mobl1.ccr.corp.intel.com ([10.254.215.168])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 00:00:50 -0700
Message-ID: <6365983a8fbd8c325bb18959c51e9417fd821c91.camel@intel.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, Yang Shi <shy828301@gmail.com>,
        Wei Xu <weixugc@google.com>
Date:   Thu, 14 Apr 2022 15:00:46 +0800
In-Reply-To: <20220413092206.73974-1-jvgediya@linux.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> Current implementation to find the demotion targets works
> based on node state N_MEMORY, however some systems may have
> dram only memory numa node which are N_MEMORY but not the
> right choices as demotion targets.
> 
> This patch series introduces the new node state
> N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> is used to hold the list of nodes which can be used as demotion
> targets, support is also added to set the demotion target
> list from user space so that default behavior can be overridden.

It appears that your proposed user space interface cannot solve all
problems.  For example, for system as follows,

Node 0 & 2 are cpu + dram nodes and node 1 are slow memory node near
node 0,

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

The demotion order 1 is preferred if we want to reduce cross-socket
traffic.  While the demotion order 2 is preferred if we want to take
full advantage of the slow memory node.  We can take any choice as
automatic-generated order, while make the other choice possible via user
space overridden.

I don't know how to implement this via your proposed user space
interface.  How about the following user space interface?

1. Add a file "demotion_order_override" in
        /sys/devices/system/node/

2. When read, "1" is output if the demotion order of the system has been
overridden; "0" is output if not.

3. When write "1", the demotion order of the system will become the
overridden mode.  When write "0", the demotion order of the system will
become the automatic mode and the demotion order will be re-generated. 

4. Add a file "demotion_targets" for each node in
        /sys/devices/system/node/nodeX/

5. When read, the demotion targets of nodeX will be output.

6. When write a node list to the file, the demotion targets of nodeX
will be set to the written nodes.  And the demotion order of the system
will become the overridden mode.

To reduce the complexity, the demotion order of the system is either in
overridden mode or automatic mode.  When converting from the automatic
mode to the overridden mode, the existing demotion targets of all nodes
will be retained before being changed.  When converting from overridden
mode to automatic mode, the demotion order of the system will be re-
generated automatically.

In overridden mode, the demotion targets of the hot-added and hot-
removed node will be set to empty.  And the hot-removed node will be
removed from the demotion targets of any node.

This is an extention of the interface used in the following patch,

https://lore.kernel.org/lkml/20191016221149.74AE222C@viggo.jf.intel.com/

What do you think about this?

> node state N_DEMOTION_TARGETS is also set from the dax kmem
> driver, certain type of memory which registers through dax kmem
> (e.g. HBM) may not be the right choices for demotion so in future
> they should be distinguished based on certain attributes and dax
> kmem driver should avoid setting them as N_DEMOTION_TARGETS,
> however current implementation also doesn't distinguish any 
> such memory and it considers all N_MEMORY as demotion targets
> so this patch series doesn't modify the current behavior.
> 

Best Regards,
Huang, Ying

[snip]

