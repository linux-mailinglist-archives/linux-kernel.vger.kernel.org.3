Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39277547EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiFMFeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiFMFeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:34:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D4512AB3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655098440; x=1686634440;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/TIkaE5l1WeJcJM5zEjR0mrwq7QJSRWRIniuYy9P52s=;
  b=McLVqxosXxhglfCEojSyO3hO+i9u2XGWz52CNH9AM+ya8vS3vvWxRa9i
   aKGUTPiTDBjVQlWw1XJI3iI4Cl/Y9C6lRq0VStXuC1Ag79PyRgcB6krUy
   Q/cdninbKrMok11nEzkPlWNgze/IXBEexNn+zMQhQqRemv3pdBpd7qPyv
   5AgU5MynHtWgBOxOkl1AGPJOerTa4yc/sooTYNxklAy6wan940sLsYxZA
   5prbaZl4khg29dUomnbViXiZQqajAXTIupKbrEeAYqg4GHT7LJ0PZKgCs
   DtFsOz5orus+BlQFaQcsIzOM47Zp4Pu6s2CXpt15MgKrJevRPNhKPXfZy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="258609584"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="258609584"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 22:34:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="587598034"
Received: from xinyangc-mobl.ccr.corp.intel.com ([10.254.214.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 22:33:55 -0700
Message-ID: <33b42a802a07721c639db99ed208ed43f743bb37.camel@intel.com>
Subject: Re: [PATCH v6 03/13] mm/demotion: Return error on write to
 numa_demotion sysfs
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
Date:   Mon, 13 Jun 2022 13:33:52 +0800
In-Reply-To: <9da3c6ef-ba0d-6229-2188-0956222b04f1@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
         <20220610135229.182859-4-aneesh.kumar@linux.ibm.com>
         <7ed1f9f544937b5c82ab380a4977e5ae22a98c43.camel@intel.com>
         <9da3c6ef-ba0d-6229-2188-0956222b04f1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-13 at 09:05 +0530, Aneesh Kumar K V wrote:
> On 6/13/22 8:56 AM, Ying Huang wrote:
> > On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
> > > With CONFIG_MIGRATION disabled return EINVAL on write.
> > > 
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > ---
> > >   mm/memory-tiers.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > > index 9c6b40d7e0bf..c3123a457d90 100644
> > > --- a/mm/memory-tiers.c
> > > +++ b/mm/memory-tiers.c
> > > @@ -105,6 +105,9 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
> > >   {
> > >   	ssize_t ret;
> > >   
> > > 
> > > 
> > > +	if (!IS_ENABLED(CONFIG_MIGRATION))
> > > +		return -EINVAL;
> > > +
> > 
> > How about enclose numa_demotion_enabled_xxx related code with CONFIG_MIGRATION?
> > 
> 
> IIUC there is a desire to use IS_ENABLED() in the kernel instead of 
> #ifdef since that helps in more compile time checks. Because there are 
> no dead codes during compile now with IS_ENABLED().

IS_ENABLED() is used to reduce usage of "#ifdef" in ".c" file,
especially inside a function.  We have good build test coverage with
0Day now.

To avoid code size inflate, it's better to use #ifdef CONFIG_MIGRATION.

> W.r.t leaving the sysfs file visible even when CONFIG_MIGRATION is 
> disabled, I was thinking it gives better visibility into numa_demotion 
> status. I could switch to hide numa_demotion file if that is desirable.
> 
> > >   	ret = kstrtobool(buf, &numa_demotion_enabled);
> > >   	if (ret)
> > >   		return ret;
> > 

Best Regards,
Huang, Ying

