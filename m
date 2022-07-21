Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6757D714
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiGUWus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGUWuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:50:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C985B1F2C6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658443845; x=1689979845;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PSZhEuOAqIq6yGhsR3NpTKMh1lewZDlmPAVmYQG7u4o=;
  b=QkBsfl70mv5FaWyjEvCxg6EMJiejrI6Q8iDUraCYZ5rBDu398FOehptX
   VAlE/uN0xMfI6Yd5xIXsCYCqn1v1OC4zfItf4TfFWDsPKNTILlJBAJsa4
   lhyNmcac9YjROAR+Que3UU/xtudKeTntHM/LpSr3nrQ43Zop6TNgs7SRx
   wqGVNiAvIWhKSEH4U7frRBjvcfZnVGici/9w1WvfZKPA9ejyiOKgVTNar
   FLJM+YtSlemeukKP02UXEEYEqNhJaYlUE8g8BGWKoruhPk39c4G94SvjE
   YobqJsObOpB57HdWi+FJMfE0tdJp/VW/vHBIzs1aJB2CRVruLasm+eNDN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="373489397"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="373489397"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="631354281"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2022 15:50:45 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 15:50:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 15:50:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 15:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYn2BBYu3NjnnDZGjWntXJ4dsS5SG7G3GuopJzNCcmpySpZLYOeveLDwWqYymk8SYO0aCBxMfMyDnBChIpGGZ8bBEX0zm3CzgdE3OXi//8O+eR29yn7s+eY/MrNHmTDhdvLLHWCHV+Q6ijhN96ILFgy/3R1RlGNlWSeIDJMWsrMuL1766sO9ssIMkjiayVs7juozUtDMLlYftHG6TYPiw5p5Mddaqf7Vjv9sJnSTihXx89qDO8j1Qm8kMXcYx2TwcIkhVyYB1UpcI8zqpdvjZFNMBx58nTd91LjWOTDNlIrvIA1B0xqhTGcUvX0cTMMUeP3/RdGveTQ2s4hFPaapcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cZSH677DaQ67zWslxoFcHCiOFBd0ePqnKYvA9RDOvg=;
 b=EnV7pZrXwfW+tadSd6MyKE1TXx8/IJLX/WaOExBL6O3oWYP46fb5z6gqO+FHN+6ca8GiRLXPPbTSyOJkpPd6TeqVfTqci4d0fmG8iLBVsAVieGh9tj/Dp8oYIUWQ2iC6XAc4eHRjBYAfnG/ipuy6PfZ3JmtKsBq93D9n2xKLCUeWc3VrJ8kPjlkT+47znqmpO9m+iBF22mVBWEBEvqBqBA6uP7L+u/czcdn0YKo4S//Ab7iwDSfvAoO+CRbDs/Km1/1rKe1e9MJhohjjAY+7SxHkB7EFcZc7S6s1n5cjoj17PxB9k1om+qpwkIwyXH/J/XigincuP47a39FkOEVgcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SJ0PR11MB5867.namprd11.prod.outlook.com (2603:10b6:a03:42a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 22:50:43 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%6]) with mapi id 15.20.5438.017; Thu, 21 Jul 2022
 22:50:42 +0000
Date:   Thu, 21 Jul 2022 15:50:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Message-ID: <YtnYPeH8enERkI4V@iweiny-desk3>
References: <20220707231550.1484-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220707231550.1484-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::8) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce8b3964-fc41-46fd-2be4-08da6b6b70f5
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5867:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sc1982GBVSMiPQKE5PLnys+1fpQ0+iCX0goYw85mmWFArGn3delvCmpPz/+KEu4K9miC2jQ4icxk+XeFTROYcAVadEAWtd7hguK5/2UgA1Ryz3EG7HpGCC5lPcK046YrUkNyULplPco8GbBXCo0ZvxFsdSP/aZQpcdr22QkKYyZ6P5Q2LPcXAfr+rCTzPy924pNdaB4sDjF8cb/zoHMorwEzKFrGoNitw0KKziPLpk8Yc9lighAfjFfc20fP2tdA4OIdPzFuR4cPCyjUOmdmzVeBcVS9Kh2ImFuN96Gn9Ya4WXl83iTwtLTvMYsrzv2trDsAq6+t1FyfmRUlZFcKi72trBwuDB2S9lI5O/MABPacjoRnc4v5yYCCxSrAwp69HVi8PHerWYg66ogRjkQ8Y2KCM7r3ySxMnFPTDxvr9GzLWaD2bSja3HBpSENEGAwf7IO2ei2W8frY9fBGl8cxvzltOH6JLnD+e/e+We+ChIWi3bzt5s76NtKndOge/ntkH1V96GMtoalcHpeHcTgR2Kh0CbrIdMadjWWRXLYeH0AqQ3q5BtJLB50GYxvW2ZNUPEtfn2UcDjzrndzV6Ca3y6OuFJJFXbgKnIQcfylaJCCrj6NTTjm4b0pbVN9qFGdA7MaLbAVNT1WZJPYR+j0wzDvuwQhZ5oEcZDEf5fycjfYI+XbnA4wpcXxDMwqGN59nJSuux+YX62VYjrpv1FwYn/LOwEzQ1aFZH7njfUhAICaMTo+3p1/jKoeuwhtEgzzW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(396003)(366004)(136003)(6486002)(41300700001)(82960400001)(478600001)(6506007)(26005)(86362001)(83380400001)(6512007)(316002)(6916009)(186003)(6666004)(9686003)(5660300002)(4326008)(66476007)(33716001)(66946007)(66556008)(8936002)(8676002)(44832011)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ni8OKC/UDbWQ8ii3YkGEr//be4UL64XNA0WLddsZvyRKHQ6kvEGxcTaAMQ/F?=
 =?us-ascii?Q?hhP7qErNU8uj5Cx01RIM8fruXxgbK+12EFQEZWpiazZ+f0XN0jsxZsQAiUAD?=
 =?us-ascii?Q?POnuBPVOYkxDSsYFtNnpH2nedqsaBgLMqg9a00C99NePacwphYRAyX5GLZsc?=
 =?us-ascii?Q?EjBkZi7QCiOTXSdZGaiKjtVjxWGy9eFJS3R1BQd1btpy1WAhwr6w72I6mvv+?=
 =?us-ascii?Q?YM4zqRuGzuzHqvfANqGCEAT13/ZZUGyYr9wYPU/WaWBRLXQiz6jvr5Jybvxe?=
 =?us-ascii?Q?MbDFDW9WDIw1Qi+GMezUsWwRfk9Z/5yNg1M5jTXEVPGLvnrWSOOiSo4GA2kM?=
 =?us-ascii?Q?jCStnYVhC9X9J8Ldy/Pw/EbpUWyaMXTyFE4TeqCFSAb0V9N5RaTMMroUMWl0?=
 =?us-ascii?Q?56RN9w0a+g2ja1mGwuiG3lrQGcJjI/pTr8kPDRiueiLmHfGrbWwGUT5i1+Wc?=
 =?us-ascii?Q?vFjpaBkvmsHULytGEWtM2ca5/VTSuvXhC+k0EwCN0vGSuQvnZD/F3sQnq38s?=
 =?us-ascii?Q?t6WgywWYsDExeFEJJoKGqJ0I0O9b2tb1qB/iBDkRWSqViE1O6YtTJXs3mCao?=
 =?us-ascii?Q?sC6YxXXTUCM71qVTLjAQmxlVCzkKEID/dJk6gix3vK+qb9YHzvKjBihISZ4v?=
 =?us-ascii?Q?Py6Ave0m/chokWjKA4OuukHMTRHQ9ZBj1ShmpzAD6lkmfMMSHkkvjyX84c8y?=
 =?us-ascii?Q?+G+R8HmM4WmLXahXKsK8+hpwtHgWp2tz/gQBJrNnzTzDqNfrXoLIGmKOulev?=
 =?us-ascii?Q?8an29HxnDe0Bj0xr5LIEb6BFf6N0j/YMTwrYgf/TJJ2z5F6/OvaYgxAhZdRB?=
 =?us-ascii?Q?JVsHlo6Ky+Y68SF4zV4z/sMh7laSpDVPzQJaxIph7HzPxjfEfJwAgWi4k23m?=
 =?us-ascii?Q?QvVbWgWht7uvDenhR1MBNNvkmdTZPIKL5cOjEqcfpSYJqKGKVyq4/t5Ucvyd?=
 =?us-ascii?Q?ev8HmhkfpxKhP8m22RL2zlzR1E/ZNeF8gydvWqdkkseWjfjCnqYsu0sQmeU+?=
 =?us-ascii?Q?lAO1Rxjb/dUVTY4eql9E1s2NdSp+16Y2PJdZXG4sZSXriFiyqnGwFd9GKmgS?=
 =?us-ascii?Q?+aRkV9TGLyLsyoeTWxhywpiKGyEYCNQ0Ikz1gWwSuUBY7NocVaGF8RpkEddq?=
 =?us-ascii?Q?ENzz/L/ZXw8oKtlwexeS01xSbgUWKAqgOzbRvpYO1eqG0itC2s52kX4o3QjT?=
 =?us-ascii?Q?/8jXRI+Q8n1x20bY4OK6F54PU2K8Y08U0SfgxVcghhduHwVzLtTNugBibhgm?=
 =?us-ascii?Q?znyU0nmWSGOv3baKoVE0qc3p17YLkdggaFyk0+lDMxQaWbY6vSJNmm9bJoVe?=
 =?us-ascii?Q?2rqPLuDYGnfK9d74oBFR3AEF5BaJtCcaexWuBHsNePctfcQLipMw8/jW/VgF?=
 =?us-ascii?Q?nH5try0bQg/ZFapZa5PqxA6sE9D/VW8Y4OpS8ut+BpoeVi9ciR9pW/lx8GIa?=
 =?us-ascii?Q?5pN7bbnpYx6QsllQwEOanylCuuGkMyBJFAqjoe4LeaIwx4gTCFAWsSRQSC86?=
 =?us-ascii?Q?3RH08Q3B1fMj4XDMcAeTbbYAZcvrydIk/ykvOz/Il9OG+0UDWlSq1TIuK98Y?=
 =?us-ascii?Q?Quwd2bc4jcYkYGRLkchk+E0yDXtMiTUpccj1ZOf5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8b3964-fc41-46fd-2be4-08da6b6b70f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 22:50:42.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZvhq19puYoP+P/zatWTlLQS/4jDU+WVMLj4Xw44kUR1KaVupM5Xxe0H90K7hmhEN13ZtU8v2tRIHmrzVaNdjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5867
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
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
