Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F11A542B09
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiFHJQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiFHJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D89736B52
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654677307; x=1686213307;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXuZA38WFCYOEgp/TFGPUQWDuJ5qHdPuNcs8ycMRM54=;
  b=VWccGwKeVU4FfvlyOydrm/ZilSvE0M+CwpGyTrZtL66R0syzZjVcs8BC
   hZhFj4eoATCWXO24XBnGCCFhD4L+L/ZygWs6NSLc2Wqb0uVxFEYfijj5W
   mIchqBclzXOTaRHRMumwGEtUQCvtNYnbBaRs0WTpVzuo0g7AixlHGLOvE
   E90uqVDQbabRBuaWKLmWshjvvR+bkmf0v5dq3t3E/BhCZriYMMTz4Z+6x
   HlxCaViwcS1mh9HLxG/Gpb+n3fdJz2gXOKqrzHMjX/suiGe9NaUKqt0Iq
   vuoQWuWsqlewoe0mt5UvaoGndOsSxl+E6M1M3/IKaP3x1XjmvpBd6IdOW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257249466"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="257249466"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:35:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636677405"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:35:02 -0700
Message-ID: <65b77f7f89361144602dce208ba4cb32387cf330.camel@intel.com>
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
Date:   Wed, 08 Jun 2022 16:34:59 +0800
In-Reply-To: <d695354e-4e7c-e0cd-603b-b585d80d5caa@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-7-aneesh.kumar@linux.ibm.com>
         <a0a70b517bf1da920dca6082afa3fbc6aba77a67.camel@intel.com>
         <81956d2e-0bfe-78ba-5ad0-f6c388c2190e@linux.ibm.com>
         <06d04b6588b43ca010ec78ce0dee8127193f5562.camel@intel.com>
         <d695354e-4e7c-e0cd-603b-b585d80d5caa@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 13:59 +0530, Aneesh Kumar K V wrote:
> On 6/8/22 1:53 PM, Ying Huang wrote:
> > On Wed, 2022-06-08 at 13:50 +0530, Aneesh Kumar K V wrote:
> > > On 6/8/22 12:29 PM, Ying Huang wrote:
> > > > On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> > > > > This patch adds the special string "none" as a supported memtier value
> > > > > that we can use to remove a specific node from being using as demotion target.
> > > > > 
> > > > > For ex:
> > > > > :/sys/devices/system/node/node1# cat memtier
> > > > > 1
> > > > > :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
> > > > > 1-3
> > > > > :/sys/devices/system/node/node1# echo none > memtier
> > > > > :/sys/devices/system/node/node1#
> > > > > :/sys/devices/system/node/node1# cat memtier
> > > > > :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
> > > > > 2-3
> > > > > :/sys/devices/system/node/node1#
> > > > 
> > > > Do you have a practical use case for this?  What kind of memory node
> > > > needs to be removed from memory tiers demotion/promotion?
> > > > 
> > > 
> > > This came up in our internal discussion. It was mentioned that there is
> > > a need to skip some slow memory nodes from participating in demotion.
> > 
> > Again, can you provide a practical use case?  Why we shouldn't demote
> > cold pages to these slow memory nodes?  How do we use these slow memory
> > node?  These slow memory node is slower than disk?
> > 
> 
> This was discussed in the context of memory borrowed from remote machine 
> (aka OpenCAPI memory). In such case, we would have a memory only NUMA 
> node which we want to avoid using for demotion.

Thanks for your information.  But why shouldn't we use them for
demotion?  Because it's too slow?  Even slower than disks?  Or some
other reason?

Best Regards,
Huang, Ying


