Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5654AC34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354685AbiFNImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355768AbiFNIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:41:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7DF443D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655196102; x=1686732102;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fd/lbLyA5AI0yS74VK2NbXXwkzPBzN8ClOqlIpUds/I=;
  b=dJ+DoiUvmGAkVU+QNJp8AGCQqeLGHXGsEGHUrQsPBQduQ455zKpjQ8kc
   0vshLi4QPQQkbCnHh09n6xcFlM2oBFdh7eGjWVAoZoNIKSiPMkSO6fHil
   BdhG5VjMjuT9flmjazriN1CqUldK2+Bbp7T/jFgurd/V2ph1QSMyYb68P
   Wh3hgb544BmJHdd9nTGvaibV0TuLbV739lJSab5qn85O/3IXdweBiSrxX
   8o/LOWwrmNldbNvnhuYk6HlMAWEH5GZ2lQts/PRdmlBKEqL4C5616uTNe
   L53HXHgYtIY4bchlyERC2FL7PplXTp/f8Si6PsGJ7z6RokG1GcCrO1wyK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277333383"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="277333383"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:41:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640222026"
Received: from unknown (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:40:58 -0700
Message-ID: <245802940528e11c879d4b54a9c25ef8497a9547.camel@intel.com>
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
Date:   Tue, 14 Jun 2022 16:40:56 +0800
In-Reply-To: <e1e25713-3c06-5f31-e98f-20faa28d4ef9@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
         <20220610135229.182859-4-aneesh.kumar@linux.ibm.com>
         <7ed1f9f544937b5c82ab380a4977e5ae22a98c43.camel@intel.com>
         <9da3c6ef-ba0d-6229-2188-0956222b04f1@linux.ibm.com>
         <33b42a802a07721c639db99ed208ed43f743bb37.camel@intel.com>
         <e1e25713-3c06-5f31-e98f-20faa28d4ef9@linux.ibm.com>
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

On Mon, 2022-06-13 at 11:18 +0530, Aneesh Kumar K V wrote:
> On 6/13/22 11:03 AM, Ying Huang wrote:
> > On Mon, 2022-06-13 at 09:05 +0530, Aneesh Kumar K V wrote:
> > > On 6/13/22 8:56 AM, Ying Huang wrote:
> > > > On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
> > > > > With CONFIG_MIGRATION disabled return EINVAL on write.
> > > > > 
> > > > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > > > ---
> > > > >    mm/memory-tiers.c | 3 +++
> > > > >    1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > > > > index 9c6b40d7e0bf..c3123a457d90 100644
> > > > > --- a/mm/memory-tiers.c
> > > > > +++ b/mm/memory-tiers.c
> > > > > @@ -105,6 +105,9 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
> > > > >    {
> > > > >    	ssize_t ret;
> > > > >    
> > > > > 
> > > > > 
> > > > > 
> > > > > +	if (!IS_ENABLED(CONFIG_MIGRATION))
> > > > > +		return -EINVAL;
> > > > > +
> > > > 
> > > > How about enclose numa_demotion_enabled_xxx related code with CONFIG_MIGRATION?
> > > > 
> > > 
> > > IIUC there is a desire to use IS_ENABLED() in the kernel instead of
> > > #ifdef since that helps in more compile time checks. Because there are
> > > no dead codes during compile now with IS_ENABLED().
> > 
> > IS_ENABLED() is used to reduce usage of "#ifdef" in ".c" file,
> > especially inside a function.  We have good build test coverage with
> > 0Day now.
> > 
> > To avoid code size inflate, it's better to use #ifdef CONFIG_MIGRATION.
> > 
> 
> For a diff like below I am finding IS_ENABLED better.
> 
> size memory-tiers.o.isenabled memory-tiers.o
>     text    data     bss     dec     hex filename
>     4776     989       5    5770    168a memory-tiers.o.isenabled
>     5257     990       5    6252    186c memory-tiers.o
> 
> 
> modified   mm/memory-tiers.c
> @@ -710,12 +710,11 @@ static int __meminit 
> migrate_on_reclaim_callback(struct notifier_block *self,
> 
>   static void __init migrate_on_reclaim_init(void)
>   {
> -
> -	if (IS_ENABLED(CONFIG_MIGRATION)) {
> +#ifdef CONFIG_MIGRATION
>   		node_demotion = kcalloc(MAX_NUMNODES, sizeof(struct demotion_nodes),
>   					GFP_KERNEL);
>   		WARN_ON(!node_demotion);
> -	}
> +#endif
>   	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
>   }
> 
> @@ -844,14 +843,19 @@ static ssize_t numa_demotion_enabled_show(struct 
> kobject *kobj,
>   			  numa_demotion_enabled ? "true" : "false");
>   }
> 
> +#ifdef CONFIG_MIGRATION
>   static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
>   					   struct kobj_attribute *attr,
>   					   const char *buf, size_t count)
>   {
> -	ssize_t ret;
> -
> -	if (!IS_ENABLED(CONFIG_MIGRATION))
> -		return -EINVAL;
> +	return -EINVAL;
> +}
> +#else
> +static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
> +					   struct kobj_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +		ssize_t ret;
> 
>   	ret = kstrtobool(buf, &numa_demotion_enabled);
>   	if (ret)
> @@ -859,6 +863,7 @@ static ssize_t numa_demotion_enabled_store(struct 
> kobject *kobj,
> 
>   	return count;
>   }
> +#endif
> 
>   static struct kobj_attribute numa_demotion_enabled_attr =
>   	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
> 
> I also find that #ifdef config not easier to the eyes. If there is a 
> large code that we can end up #ifdef out, then it might be worth it. 
> IIUC, we might want to keep the establish_migration target to find 
> top_tier rank and lower_tier mask. Once we do that only thing that we 
> could comment out is the node_demotion sysfs creation and I was 
> considering to keep that even if migration is disabled with a write to 
> the file returning EINVAL. I could switch that if you strongly feel that 
> we should hide node_demotion sysfs file.

Per my understanding, we can enclose most code about
demoting/promoting inside CONFIG_MIGRATION, including
numa/demotion_enabled sysfs interface.  In this way, the code size can
be reduced.

Best Regards,
Huang, Ying

