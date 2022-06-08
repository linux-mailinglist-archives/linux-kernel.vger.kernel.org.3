Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF787542AC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiFHJHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiFHJEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:04:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7353B0928
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654676666; x=1686212666;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ExKBbSfCOtpswNsSsOMGnKwgFVvsSYdnSKk9OuhGdxo=;
  b=DyBgs++NHiKbmWA4m5SxSdGl5CePJydZCQhiyyxX2jbweNnbasi7xaE2
   mGx5QHr4mxwnp1gvGRLGZ3suA8/TxC1qHKQidwYh3BPj2HFm1S15gHP/R
   sx08NhjbVR5FqqUiGEhY26++0BRFgW4zZd81PEbRIKvde04Wvt4AQZiJS
   QsPZdyYYwignmtfiHXzRm1eQS1SyewPIE0t9PtKMlzQJU2HrjFsyAA0uL
   XmgYO4tv7DXFnVD6VOzP+jELFJFibZfow6P+SCrK2IFwGvGXtLgr1DL1v
   WHbddWorBL2eQ4nd2RxgWN1Ql0zmPsVIN6J5If3JDkMwmv66X7yCAX1f0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="259977181"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="259977181"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:24:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636671615"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:23:57 -0700
Message-ID: <06d04b6588b43ca010ec78ce0dee8127193f5562.camel@intel.com>
Subject: Re: [PATCH v5 6/9] mm/demotion: Add support for removing node from
 demotion memory tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Wed, 08 Jun 2022 16:23:55 +0800
In-Reply-To: <81956d2e-0bfe-78ba-5ad0-f6c388c2190e@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-7-aneesh.kumar@linux.ibm.com>
         <a0a70b517bf1da920dca6082afa3fbc6aba77a67.camel@intel.com>
         <81956d2e-0bfe-78ba-5ad0-f6c388c2190e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 13:50 +0530, Aneesh Kumar K V wrote:
> On 6/8/22 12:29 PM, Ying Huang wrote:
> > On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> > > This patch adds the special string "none" as a supported memtier value
> > > that we can use to remove a specific node from being using as demotion target.
> > > 
> > > For ex:
> > > :/sys/devices/system/node/node1# cat memtier
> > > 1
> > > :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
> > > 1-3
> > > :/sys/devices/system/node/node1# echo none > memtier
> > > :/sys/devices/system/node/node1#
> > > :/sys/devices/system/node/node1# cat memtier
> > > :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
> > > 2-3
> > > :/sys/devices/system/node/node1#
> > 
> > Do you have a practical use case for this?  What kind of memory node
> > needs to be removed from memory tiers demotion/promotion?
> > 
> 
> This came up in our internal discussion. It was mentioned that there is 
> a need to skip some slow memory nodes from participating in demotion.

Again, can you provide a practical use case?  Why we shouldn't demote
cold pages to these slow memory nodes?  How do we use these slow memory
node?  These slow memory node is slower than disk?

Best Regards,
Huang, Ying

