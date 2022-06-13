Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF54F547E21
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiFMD1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiFMD1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:27:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED09212614
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655090823; x=1686626823;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQsTX5D9o+QT4TiAmxzoHdqWMATpMDAE+jjECvuubgs=;
  b=i5REUEhbbUIR+lZ7T/DHmfC+syHmOyorMx3EgZzS2VOPK+jAlHa/kMJE
   k4oNQIel1VHUjna9UC+JVqSPHj4JVbQDm5E/dN51p9Oj04Qgq4+tQIA/T
   wvTdeCxd8cYn27r7Ib4MGTOU13ITn9ccGx4VPFLCn5H2DD6jNIMljmbHi
   YM5Pge9+Hvn0nJtfQ8NsGgAPSioAkjqBmJGt+gj9TO15R9oKFkKW51HsE
   HoybwBVMcO+bhEMJg+ACuQSAEeQ1HINcz/UyibQPJvpYl7+uyQqQG3u14
   SMTfmi56PeVyx4QCsZ6jLFPzc3in2r+BVhgs6FrlQ3ENiH+RLpFoMOgYB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="276921243"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="276921243"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 20:27:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="611571882"
Received: from xinyangc-mobl.ccr.corp.intel.com ([10.254.214.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 20:26:58 -0700
Message-ID: <7ed1f9f544937b5c82ab380a4977e5ae22a98c43.camel@intel.com>
Subject: Re: [PATCH v6 03/13] mm/demotion: Return error on write to
 numa_demotion sysfs
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
Date:   Mon, 13 Jun 2022 11:26:55 +0800
In-Reply-To: <20220610135229.182859-4-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
         <20220610135229.182859-4-aneesh.kumar@linux.ibm.com>
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

On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
> With CONFIG_MIGRATION disabled return EINVAL on write.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/memory-tiers.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 9c6b40d7e0bf..c3123a457d90 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -105,6 +105,9 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
>  {
>  	ssize_t ret;
>  
> 
> +	if (!IS_ENABLED(CONFIG_MIGRATION))
> +		return -EINVAL;
> +

How about enclose numa_demotion_enabled_xxx related code with CONFIG_MIGRATION?

>  	ret = kstrtobool(buf, &numa_demotion_enabled);
>  	if (ret)
>  		return ret;

Best Regards,
Huang, Ying

