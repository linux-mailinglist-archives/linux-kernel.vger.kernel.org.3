Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7482C585CDA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 03:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiGaB6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 21:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGaB6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 21:58:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA912AD5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 18:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659232714; x=1690768714;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H5H5/W6OQjHzsDGg4Bb2mG5+78Qf2xYRUiAkiOEsggU=;
  b=YDqr/BWCy8lz9esJPA7//fBq67FJN/zj5Op979SRdMuMeoEvFMqKWtIm
   F1pl5psHfMxoWirzGcX+MxVgfKEAGCeXpPGFozEopdw20skFycH2Rz2h2
   kX/7dgjd9C++VMkS1MXGOXa/kxlWxOmAIgvWRMPDo+zf0X2RvXTTAxOUt
   DF1drgk9tJ4xpY/FmzNJik9ca6fLXo5t24oLhzGfy9H9YG/HPCugHPJ6m
   okUE5VAQyGKs0Bg5Vud/n9mSGNdbktqhwqlsYDPoQe5g3oDkmP/YfNpYb
   iokVjccx4+ubcXY7xfU1zp5OYOpHVLXxRMiuxQDU86R5mqvodRuNgI/Vb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="269341627"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="269341627"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 18:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="660712408"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2022 18:58:33 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 30 Jul 2022 18:58:33 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 30 Jul 2022 18:58:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 30 Jul 2022 18:58:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sat, 30 Jul 2022 18:58:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3yKv7YTChKAH/JCVDZmqoAy3kqgeRIEUIo1GKYLGSaJhop5luH2W0JXNzIyQXV6cw7dfjS3t17GJMUh3z3V412uSTQqM/jQIboTHawts3JygOLz8c48OtZybYSUXwOdD9bJISrQdEuetTZjmG2abx86QAVtQdb3+UbsF2jgQpsrPhqI6o/KpexJx56lWpFMJOBWPpx2YCKYSBJLWLT5vIYcFA4hb9uOMZb/o3aUA+DOXHYGJQJ++hfyZ7pnmkVfeOLsa6cmybfXLO47z57jOQokcv9Q+EcpGFq5lM0LMMPLAzY7EoaZFFwVPpQnm1CNa98fsY+mV55E+OfVtqFJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFDnam7NCDi/uGtD0l73Xf7DRZgBXrdcYN9cbV+r2Wo=;
 b=Z3sGw9wfctwbR6iCrP1AmhgjIav/beQYksn7MjDy39hIiON9bd7AmDuiyiE7zPLc5MXcYkDotn5bcwLl96H5HylRt4uLbly3iW0JKcYAr023G93nB0Q7oE7vsKIGUHVYuOaFawVT64qVB9amvTGi/QBy20HnylUjuSVUHF/fEeoO0R8iZrd2b3WHrAI+JX7UwbhZvH63yP17Rq9gfaJIEeGju4/Gk15DEw6oN6RTaeFNnSZFrlq38z2Wz26LlxHmv9S3J0lNZZVpJTh11les4H+oS8E8yDXqn7ADHjpIBEkd3MRWZAYh4GE0Ncm+IB4Ukwa0uBjvWk65/uDzwWFvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BYAPR11MB3655.namprd11.prod.outlook.com (2603:10b6:a03:f6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Sun, 31 Jul 2022 01:58:25 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::1168:74bf:ff5d:68db]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::1168:74bf:ff5d:68db%7]) with mapi id 15.20.5458.025; Sun, 31 Jul 2022
 01:58:25 +0000
Date:   Sat, 30 Jul 2022 18:58:21 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Message-ID: <YuXhvZPImkeCt5sN@iweiny-desk3>
References: <20220707231550.1484-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220707231550.1484-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aff7b0a5-84af-435b-bca6-08da729827de
X-MS-TrafficTypeDiagnostic: BYAPR11MB3655:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hryTpIr4RltdBVYEXSS/8DghY0Ksx0UtTJm8GLy7DFzq39kvimTJNzsW149b5XXbHtM/Sidgao7JpC+Xk7yi7Qfp/vFOgDJ8m3+0ncYXQapwI41Tt8ZsQw59ArTESHcVWr3pHLy/MbVY23/AJh1UFMxCkxHi5gJITC/Q9vFn9LWpui043gv5nmhHkLXsKb6IkQaUVantGq+k320yDQ5rkz9CtgVUIh/zYvGz7EqZo+keSq+aQ1nzrhCD+iSUt1/u4S96iPnUkZOWxLWZrX8q7WSo4Y1bSCT7sodQElQZ1qQ9Wj53OzAMOzNXh6FhZHV0oYLQp9JtX1uVQo/Cu9ZKP/c1vlRkwewkU9Uy6Hq/vXJ3jfnoOrOSqcHBStmQZXsBjKBq15Wwsq1Hpidf220eCeqCRW94uhxILcYND8VE/ELsN1yBBjVPa36H+m4lDC9iggcIE+t4L+8a65G+650GLwFQSkLhp+1hZxEm07uptK4NomWY7YEg7Z209jR70/gUIcKGv/mq2JTAKvusohoMYN5B5Nhs5BF7/mdCVEv8miXFCBMxtiJYVaVgCzM39WzquA00SBZ80PQUGJKfvznAt6cQ7vE4wTKRtxQezJ43XCZJYqpSbqEwh9F9awpG612OsPhRVSpNhj6Cjc0pEl9nFBZ+I/mSzQXP2sQzi2RcFow+O0UMHkgGdigGBCCbjywcABUFfC98v1+quUdrKxPNyPJYWZy2QdZEn21z0JgjvxSO84mTUdn+gzP1T5bsYRYd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(39860400002)(396003)(366004)(376002)(41300700001)(86362001)(6666004)(38100700002)(478600001)(2906002)(6506007)(6486002)(33716001)(6916009)(5660300002)(44832011)(9686003)(26005)(6512007)(316002)(186003)(83380400001)(82960400001)(8936002)(66556008)(66946007)(66476007)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgkZwWJ7mxbzmGip6R+ZT9RvPwZcMXsAJCAEx5Gl/O379gfeLUUlAwDQWkR4?=
 =?us-ascii?Q?POZcqs8WcqUPXQTJQt+rB/9H+a1YrEl8igelsGffwryO4R+NASoM09T1LHPA?=
 =?us-ascii?Q?zi/jgcBNweVik+bGK+g+gk9z152ybAnsXLvgJO+cp0YTe4j3G7Hod6+pwBG/?=
 =?us-ascii?Q?5QNqdeLqa8a9Fn5i6e/lS/rtTwwS/26JcFnkl35OJWWRdzAdmyBommSjrIpG?=
 =?us-ascii?Q?AVefl392PB78wz2enTiUWA0nir4Eib6XHeedwo/iZvM6+vQdlKUbs8RoPda0?=
 =?us-ascii?Q?1aP1zyGklvEfgBLXdxrybSBtxwfp1iTKUM8O8Vroi9kcfdQg+egLEG6PVe3G?=
 =?us-ascii?Q?xp9bH7dCo7POkUCqp9oVXUbGkoVAXZbYbMcsBXjcRHbhgILS1EYCklFHowAE?=
 =?us-ascii?Q?tP3DZYI/SuIcUF6W+GEjV5YCQEgA4W/jBWOBI0vIPxx5e3dSmExZjuPN+U8L?=
 =?us-ascii?Q?QBn2JEpf4e0b5sqCOA95VMn51RWeUceq8OdTj117RDXBY7RVVtz3xxDLk93r?=
 =?us-ascii?Q?gNb9br/+/haRACxS9fgihKafByPhgPc35BPlYn851+dVhitHPBJP2iHl/fo7?=
 =?us-ascii?Q?qXvbbcpQTOQwFUINn45wvSHHqvC/CXTDAzo8GhtXPBqi3KLDoyqv2AVa1m6U?=
 =?us-ascii?Q?9vbQNk//qwwya4oRZ8pXpfp0gtbB/yCxrGtR/clmsVq5TZwNllYF42yttstA?=
 =?us-ascii?Q?fXkhjlG1Gdx+hBHzmxYUBSq7IhAumHhamO2Z+lcW8ED5tsgGK8bYnqEZ0xf6?=
 =?us-ascii?Q?JLwRCagFaojwydbQnEUqfd5UWm8a8WSuaWDCKe4evUoUeQM16JYxgYeEgu2d?=
 =?us-ascii?Q?LMabBdBO4NW5zLkPf7QZu6c+1bYrchP+z3YvAfDql7rC7d9eHxntHG3OpHP7?=
 =?us-ascii?Q?f70fAzoonuRduN8dQH9fo3xNQqOHx21S7bx4edeGTMHNqsSzWWNMqV77D02O?=
 =?us-ascii?Q?oQ5UKu5I/kBeRy2Oej7RKaQAu/Qw0MR6o/LcFK/jRqSLo3j7NzgmrNpNlIRo?=
 =?us-ascii?Q?a49org3WQS1UQ2HGATXMp0GwBw93FG8wV1NJ9yRgveOPO1Q6tl+1xh2xzYxO?=
 =?us-ascii?Q?sKXqCyG7Kje2WmejMQQYieCe1tnW8aqREFovYuM/cxOPO9PvN0HrUQj4WfSG?=
 =?us-ascii?Q?SwJ5/nyA8fLcHW1BgMCU50zGQqKLynPQqjhagrpZA7eApBY4VUy15rv8+2K+?=
 =?us-ascii?Q?ttEu8wGm2f49VH4fKlA2mh0V0hC1pvCet8kSXlpqtL/dWGPEWDidSOtVgHFu?=
 =?us-ascii?Q?nXO8+yndQUnJA4kxGJ3X39SOFbN+5O/vIAYSJy5WUHnWIvMzyDmXcwGZCSdM?=
 =?us-ascii?Q?t0Ne5eoylAtB+qnaDhiGJIPH3L1WP85ukaagJf/lND4OFCKCrTuEpn9i+tBe?=
 =?us-ascii?Q?q7kxonRZWyU5v+crGj2aeBMx7HCKU8BEsuKNW3ggF5Avrsr8elGWif1dZoZj?=
 =?us-ascii?Q?hx6qypU5Bq9OPeSAj9KnpsnvPCKv6Kdip0NBo/A3pGqYIPO7uJOzufOQNmuH?=
 =?us-ascii?Q?vKE0N/ijaEOy8aHGRKEtd+jjDr3CUZKO+4hY7uYdB+/w+IswBz2kDLpAG0F3?=
 =?us-ascii?Q?tZEI7tvLt9TidO1O7boEo2L4OCmmm3Uos/wHEMpD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aff7b0a5-84af-435b-bca6-08da729827de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 01:58:25.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqHsjGsB6rC0cgP6GhO6XPLeSslcQAp5a5r5OGmjYrHAjiopYaEj1g/vOfA7odZPPqG/5yXgRHMBDTSb1M/YkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 01:15:50AM +0200, Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().
> 
> With kmap_local_page(), the mappings are per thread, CPU local and not
> globally visible. Furthermore, the mappings can be acquired from any
> context (including interrupts).
> 
> Therefore, use kmap_local_page() in kexec_core.c because these mappings are
> per thread, CPU local, and not globally visible.
> 
> Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
> enabled.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
> v1->v2: A sentence of the commit message contained an error due to a
> mistake in copy-pasting from a previous patch. Replace "aio.c" with
> "kexec_core.c".
> 
>  kernel/kexec_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 4d34c78334ce..6f98274765d4 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -814,7 +814,7 @@ static int kimage_load_normal_segment(struct kimage *image,
>  		if (result < 0)
>  			goto out;
>  
> -		ptr = kmap(page);
> +		ptr = kmap_local_page(page);
>  		/* Start with a clear page */
>  		clear_page(ptr);
>  		ptr += maddr & ~PAGE_MASK;
> @@ -827,7 +827,7 @@ static int kimage_load_normal_segment(struct kimage *image,
>  			memcpy(ptr, kbuf, uchunk);
>  		else
>  			result = copy_from_user(ptr, buf, uchunk);
> -		kunmap(page);
> +		kunmap_local(ptr);
>  		if (result) {
>  			result = -EFAULT;
>  			goto out;
> @@ -878,7 +878,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  			goto out;
>  		}
>  		arch_kexec_post_alloc_pages(page_address(page), 1, 0);
> -		ptr = kmap(page);
> +		ptr = kmap_local_page(page);
>  		ptr += maddr & ~PAGE_MASK;
>  		mchunk = min_t(size_t, mbytes,
>  				PAGE_SIZE - (maddr & ~PAGE_MASK));
> @@ -894,7 +894,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>  		else
>  			result = copy_from_user(ptr, buf, uchunk);
>  		kexec_flush_icache_page(page);
> -		kunmap(page);
> +		kunmap_local(ptr);
>  		arch_kexec_pre_free_pages(page_address(page), 1);
>  		if (result) {
>  			result = -EFAULT;
> -- 
> 2.36.1
> 
