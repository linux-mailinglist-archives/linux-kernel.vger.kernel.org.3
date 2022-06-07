Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0D542364
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392491AbiFHB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588736AbiFGXzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:55:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FF18219D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654645202; x=1686181202;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZjlOk8azHhDHFFrQPq91H0uTrw45sF8jDpP42SnJxhM=;
  b=lr1Tn8qWMU9rVd+Y42dc5t+H5lKvlNeyVICMqarzwZPpO2UNVIhtPXCi
   79zW43Whu5c7soS3d9uBslqzX64TLAfYwKJnKg4WWWR2WIp/DKtl8pSGA
   azDKKYjZR+kcgMMSiSUdv7HPfqD97oLuzYn7t2pwmos6PWHe2GxU/+wja
   ltnqALFa0wgpRpicPVlr5Xug4sEnd+ijXl1iiMTREyMPV3+8qQfnAk/tP
   VPSBfk6UY6sNdXayCJ6sqMbIxeD4appM4N48SevpqhzEEq2xAz9GY1JS7
   ZD3HH0ftbPv0w9XMUFjdZl7RhuVyIR9jTgNdazUP22hn1ZU6ZrsMOZ9uC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="276801993"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="276801993"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 16:40:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="579810172"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.8.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 16:40:01 -0700
Message-ID: <0c2fac38720710aebe2b667807c647e8a5aa5441.camel@linux.intel.com>
Subject: Re: [PATCH v5 6/9] mm/demotion: Add support for removing node from
 demotion memory tiers
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
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
Date:   Tue, 07 Jun 2022 16:40:00 -0700
In-Reply-To: <20220603134237.131362-7-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-7-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> This patch adds the special string "none" as a supported memtier value
> that we can use to remove a specific node from being using as demotion target.

And also such node will not participate in promotion.  That is, hot memory in it will
not be promoted to other nodes.

> 
> For ex:
> :/sys/devices/system/node/node1# cat memtier
> 1
> :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
> 1-3
> :/sys/devices/system/node/node1# echo none > memtier
> :/sys/devices/system/node/node1#
> :/sys/devices/system/node/node1# cat memtier
> :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
> 2-3
> :/sys/devices/system/node/node1#
> 
> 

