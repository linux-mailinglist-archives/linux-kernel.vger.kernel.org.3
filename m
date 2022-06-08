Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AF854284D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiFHHpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiFHHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:37:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541221A881D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654671574; x=1686207574;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5IH10Oa/APIbHxnd3+1jfus6BwIkyJBYQzSYhAxYXs=;
  b=IaIZj7+lCPcvs9HRHSw6MFMaB8kHdx9HDJdCSR8TTzKothoWD2k6uHuh
   yvHbJLXFGdcc9fto7aU+OdL/5Y1ydOvepV7c8Ks6LIwZAf2q78aTxY/nk
   muxUY8bAXNL9t7l7PLWk0P4jHmv/mg13ZVJd0T4IJKWRdYPXAqCuPVpuQ
   CJDvo9jQukxcaGkNcfO0NS20DgOl1MSJouvl9OJp2RuCGdtWBVrZsNU+2
   xqPUijlLVor2e42TE5lLvOvx5vxZALVw9sOU1BhJQx2xIn2Dud2RwDVtT
   8OmloZPh+nD1u/r/k1Nlo8XNGXFwTxOEqx7aykiuFwbKovkCvzgCwaAIS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340892742"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="340892742"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:59:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="584688344"
Received: from xding11-mobl.ccr.corp.intel.com ([10.254.214.239])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:59:29 -0700
Message-ID: <a0a70b517bf1da920dca6082afa3fbc6aba77a67.camel@intel.com>
Subject: Re: [PATCH v5 6/9] mm/demotion: Add support for removing node from
 demotion memory tiers
From:   Ying Huang <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
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
Date:   Wed, 08 Jun 2022 14:59:26 +0800
In-Reply-To: <20220603134237.131362-7-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-7-aneesh.kumar@linux.ibm.com>
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

On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> This patch adds the special string "none" as a supported memtier value
> that we can use to remove a specific node from being using as demotion target.
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

Do you have a practical use case for this?  What kind of memory node
needs to be removed from memory tiers demotion/promotion?

Best Regards,
Huang, YIng


[snip]


