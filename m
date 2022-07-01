Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496D956397F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiGATEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGATEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:04:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592AF38BC3;
        Fri,  1 Jul 2022 12:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656702250; x=1688238250;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C4cCwg4S0SMOPs+pELJSSaw16DO+Hsd6My4HtNCrciA=;
  b=c3aBxKXS9sYy5G2LRipRdrb6q6tJgoIrUzNMwyC9GFsNQCZ1MZSGWMy7
   eTYZzyfgIfqPphv8/kFwgKY+OoP2vGKUTfoTsOUvPN2bnF6RvApNfiIFA
   N7ndMrHORdUhgqAhDKJP4crMXbpn4SFpKw7UAh1CNz4wBWLSaosLfyLAL
   fc43VyTsnYb7xK279rquCBWPDyPbLq9L8FvJy3xII4UIQ1iCpCKMcxrs3
   EU9SzVpOYuWbA2DW4wd1s9fSHeou6Qh+umU6tfKjbgEPcB9KvXaIOc3cL
   L8QcrntuKTvXfvBXqzRSCV31MiEh7E1yRnL4lXJxfnbxLXTxO2CNuviMK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="283454792"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="283454792"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 12:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="566446896"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 01 Jul 2022 12:04:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 12:04:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 12:04:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 12:04:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUWke1/o/zmk8mP9MQHUkc1+g6YJiNUZ6uXc60hrM6smdr7QlbvHgrFmP6rmTMoZ+hpOYQMpYhoapxs8yGJXFecdgIsTpxR1o+bSIyWfSnlnvt5Ir2AW7PAifQdd42MiBt5mjgj729iZK13YQY8HWvNf/igR7LWpXmhMc+dc8i/wLfalFCH/IQm1xPjvF2axfwOBl60l4bJxdnT2JyAjPXqon0iTo17kolt64pe6bKMMAO9EsDXxIQIhILs1f7kYxL6ApekZQFnj2hmgixz7BpXLfaW4sBT2Ov12/k/CVrQt5mhcemnKF/wMBsO94ig1jhxrUkg3vzZ63+EVk1U7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRkDdaCSlg+G0pvNVUv49iQDlykNoM1QM709ZlfXkVk=;
 b=R/Z3IYS5EfCLWkc6n4pXL2GOFqYyrS2xI1BJd5qgG+vZiJv8l8TWsWH49y5aVFo7w3eQxw74PXawEkpQRYjWXdpMwrU5VP+E8PhO5tm6hMz4HM40D6Wn6z4c7g+o/B0OXaU/AA0HFIUkEcr0pOGDwMKak+S5SyQOt4bZvAk9PDCSS/0StyvO3KBrGGPVMQLi2x+91cCPKr4o7vMS3+NZzG6jVw0r8SxV9ZeaNWpROvLT5Gmscf9VvzObnG+qEuuxKTLYLdl6zSSooy6r9tPlrFJZzA0kDs/wfBwrVPlybxPqsqMts3Zq38MJpAapU3yAqNcYj/azQ1vfUIfyptsc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CH2PR11MB4342.namprd11.prod.outlook.com (2603:10b6:610:3b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Fri, 1 Jul 2022 19:04:07 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 19:04:07 +0000
Date:   Fri, 1 Jul 2022 12:04:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jan Kara" <jack@suse.cz>, Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Theodore Ts'o <tytso@mit.edu>, <ecryptfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ecryptfs: Replace kmap() with kmap_local_page()
Message-ID: <Yr9FIKyHWi930QBd@iweiny-desk3>
References: <20220628184950.2045-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628184950.2045-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 707889a4-cf06-4088-2a15-08da5b94796d
X-MS-TrafficTypeDiagnostic: CH2PR11MB4342:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7b1xTFTC7EgXA6BTCwmohAnIGxbfiu3g3Un6gDeMeFk8qYLsWM5WVDm/WVwOw1xnjRhcoBTnWNS6Xj3fVioOufHmkzfgn3Xg0rbSVSVj8tkzr4ngVYM+IgRy2RK8SzmbNsssi4TnOQ9ysioOdnX7WqSAwKOlFao0CYEL3qv8jtDuZSc+Gn+22kair3dyizbmawvth8381I+HykoHXm9wfD5zfMMD1zuMQrEIvDYrHeB0ow0Zi+A3CM8p6/2k05zFjivxKCGscU/tbhHYu0MfC/s+49BhKazWzmaXc/GBVqxzjtjFXK2jR2KxvikHJvlFV4ONMUj7OEggWb/hrMmOPb2N9qFIBXALKeuUdZ0Qr+kL+jlasVYgXvb+6eZQeHvXx3GzO7+y1fm3XS3BP2KMalndQD39TMS57M/IPFzoWlinbNHMtmypLz8xAgO5TQwyJNYiCal1VIHbSNdj6cKpUElTn0NHjrjpPF3+Z59amYiyUx5VOW47sUuM/qruYujCUkzdhoZ6A/tREcZWusNtLOG2FF+BHtsJaiR1UL8mj2U467pnumnpT6Ratsym98Ihtbn8YczvObFADsP4460dItEFvnpuu7ZlSTdWA0HzqfKt1536I/nMkVhh9HyUeBpAT505XyOfIqjPmVNH0+fPcVAfZmjP0y8kaNT41DdsNE1gq1uChCGI4cBV6JieqOAVrET+70aL7x97oX2LJlktx0YfObnmcCRiQDsCIBvZf0LyEWZVUmIbkMYs/06PA+rQ4vM/XqH0HF2WHqLE7KhHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(136003)(366004)(376002)(346002)(39860400002)(6512007)(6506007)(186003)(54906003)(66476007)(8676002)(9686003)(6486002)(5660300002)(41300700001)(66556008)(86362001)(316002)(4326008)(66946007)(82960400001)(6666004)(8936002)(2906002)(6916009)(44832011)(33716001)(7416002)(478600001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ry6sP7vJ/6uP5wYkW0YCb8tuCpIWfLi8m9ldQR1AM83RJCmZnJoKjW8krtLF?=
 =?us-ascii?Q?5B9/8SUMh/xnDwnyfV6KgR6IHL048HrxGQkYfEhCJW0GMze4qMtxrUu5XVWt?=
 =?us-ascii?Q?YXfxYt67meUlZs1/1PTw7/hGiK9pkCerb+do2he32da+E8N0FvGI/Gij2Tsn?=
 =?us-ascii?Q?J4CQZZSPRosnIE6/50GZ/idUER8sYqiOyiooVrjPXYoCQt0kdlY+cPwDrsVn?=
 =?us-ascii?Q?8lywoejWRiCh8xrbSEA7Y8vHm3LEresDFqWZuSi0TK3tDY5BFgWwepafLCz5?=
 =?us-ascii?Q?hjVEJDZdhYndHrgl1n8BrkES7mpRm1vmQWFCSpk8sooBShQ+4ZcUBCDPph7L?=
 =?us-ascii?Q?F+BZIWPWN4bC5q4+dH17nZkeR7bM/MBfuZv4LzgvdF9UC4SCcBrQQqn//+4T?=
 =?us-ascii?Q?qaF7rf1LwvfH/0RjVBQZiXe0hmveOeiHx9SWOEWfu5RcFZAtNeqXYkSKpx6Y?=
 =?us-ascii?Q?ummmPcPuZPsIt0ED5/1ai+aAgdvidjCfC0aR4Nd9fxCrVj/cfTD9HNYxTq/7?=
 =?us-ascii?Q?tfbuwJKTylwvqzgVd8BFCK+cWskpQ9Ikkrou+gaKu2JHJEDMjROfozI8EdVi?=
 =?us-ascii?Q?PFmHTI+5N7HGzxoc8OcgauGHm11jkHJ/mao5sAjMXjuUJYsXzT9v6vtYgDYP?=
 =?us-ascii?Q?S+w6zBLmEA7ZqavvetjdxtzgJcInfTRilUHnQYD4DPkWQbdVehmK4r5f5usZ?=
 =?us-ascii?Q?ZVY+TJ2Z8KW+sqKPZStmOnH4bcDugPRIe40qD2qkpsER3i3Pytu3mlFvV4Ub?=
 =?us-ascii?Q?SpKz5PUEQ2zSKMbz1V5PhJdNOL/7eWfapaEZDZkAeSr91xlOWhcWd1WmqWYv?=
 =?us-ascii?Q?UUpZpxeYVp2i8t/BfFNUtKFO97rX6+MEbCmwmNjMTotvm7kqJ9xEtKR0cBL8?=
 =?us-ascii?Q?O+werPK9HYhmCqmQkpmDphNJf9b3Z/IuzNc3E5Vx6ERQG8WeSkElIszIkccN?=
 =?us-ascii?Q?ya+7gw9cU7/A9NaGWzupygFT701CBeJcyFUvaOt15URtv8ZGGt+eyJ29WoIh?=
 =?us-ascii?Q?X9kszxUImalmH7c/kw4RngdtT9Rrmxw0xNUHgT4CvJIOYhNVMaINIl4MBole?=
 =?us-ascii?Q?ktAhqoGLdGytmbwKaBmHDUiurdSMwNTJkNUQjThRDdhv+jtzDNJjBroSCpkz?=
 =?us-ascii?Q?8E4S2h60PMhKYkelucoEqbrkgxnoOzW90vTjA3CwueBRnpn93S+9VVffADZ6?=
 =?us-ascii?Q?h3oeR30CMHGoZbUX6xaWh1M5HdABXtvGoRQbw9b8LGDdfO15EZdfnqAlBVgQ?=
 =?us-ascii?Q?A3tTjmTsj9ATklAUO3zvyhTgM6Fw1zvhWXy7hacAyrMab0ZUi9V7CdQTVrnC?=
 =?us-ascii?Q?vKrXfbty8vp33adZy0K4sBMKKKF/boF8uX6uF/gIKzuN+eV+Y8ZSolW3Mwej?=
 =?us-ascii?Q?FyLp2s5W0ClTbgj7mbxGH3X+I1S9rweWF0/KiB6Ft7GLJ8X92GYN15J0D6Qg?=
 =?us-ascii?Q?bPnqGm5AMv59gMbEGeYgMTWzrt3unklK0z5l6pwiPeaVhgUVqCd+m5p1P52Q?=
 =?us-ascii?Q?hIuqHYAq4KrxicSHN4y+2zjloSoUk1Ted07fsxxV4ow6sVh8ip3ffGrqGDgq?=
 =?us-ascii?Q?W0G7lnZxnkOMAZa4eWUE5RgKhQVnHsgr/ILZiXHSoWUzJMXQUafp8UnGhPpq?=
 =?us-ascii?Q?Ku9aghPt0c0CvUwzAwmiE/AA+SyjzVxl1uzKVDmhYKNU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 707889a4-cf06-4088-2a15-08da5b94796d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 19:04:07.8237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3qBshjEobkKBz/NSNWxA9rTeOxTlEII2vAtwExRK+EzA4LRWBLh3nN0MiGXYbILlYaftUOodGSdYSd7oFhXqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4342
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:49:50PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> With kmap_local_page() the mappings are per thread, CPU local and not
> globally visible.
> 
> Use kmap_local_page() on all calling sites where kmap() is currently used.
> 
> The mappings in fs/ecryptfs seem to conform to the prerequisites for
> easy conversions to kmap_local_page(), however I am not familiar with this
> code.
> 
> This is why this is an RFC PATCH. I'd appreciate if people familiar with
> eCryptfs could test and confirm whether these conversions are safe or not.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/ecryptfs/crypto.c     | 8 ++++----
>  fs/ecryptfs/read_write.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index e3f5d7f3c8a0..03263ebcccc6 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -465,10 +465,10 @@ int ecryptfs_encrypt_page(struct page *page)
>  	}
>  
>  	lower_offset = lower_offset_for_page(crypt_stat, page);
> -	enc_extent_virt = kmap(enc_extent_page);
> +	enc_extent_virt = kmap_local_page(enc_extent_page);
>  	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
>  				  PAGE_SIZE);
> -	kunmap(enc_extent_page);
> +	kunmap_local(enc_extent_virt);
>  	if (rc < 0) {
>  		ecryptfs_printk(KERN_ERR,
>  			"Error attempting to write lower page; rc = [%d]\n",
> @@ -514,10 +514,10 @@ int ecryptfs_decrypt_page(struct page *page)
>  	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
>  
>  	lower_offset = lower_offset_for_page(crypt_stat, page);
> -	page_virt = kmap(page);
> +	page_virt = kmap_local_page(page);
>  	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
>  				 ecryptfs_inode);
> -	kunmap(page);
> +	kunmap_local(page_virt);
>  	if (rc < 0) {
>  		ecryptfs_printk(KERN_ERR,
>  			"Error attempting to read lower page; rc = [%d]\n",
> diff --git a/fs/ecryptfs/read_write.c b/fs/ecryptfs/read_write.c
> index 60bdcaddcbe5..5edf027c8359 100644
> --- a/fs/ecryptfs/read_write.c
> +++ b/fs/ecryptfs/read_write.c
> @@ -64,11 +64,11 @@ int ecryptfs_write_lower_page_segment(struct inode *ecryptfs_inode,
>  
>  	offset = ((((loff_t)page_for_lower->index) << PAGE_SHIFT)
>  		  + offset_in_page);
> -	virt = kmap(page_for_lower);
> +	virt = kmap_local_page(page_for_lower);
>  	rc = ecryptfs_write_lower(ecryptfs_inode, virt, offset, size);
>  	if (rc > 0)
>  		rc = 0;
> -	kunmap(page_for_lower);
> +	kunmap_local(virt);
>  	return rc;
>  }
>  
> @@ -253,11 +253,11 @@ int ecryptfs_read_lower_page_segment(struct page *page_for_ecryptfs,
>  	int rc;
>  
>  	offset = ((((loff_t)page_index) << PAGE_SHIFT) + offset_in_page);
> -	virt = kmap(page_for_ecryptfs);
> +	virt = kmap_local_page(page_for_ecryptfs);
>  	rc = ecryptfs_read_lower(virt, offset, size, ecryptfs_inode);
>  	if (rc > 0)
>  		rc = 0;
> -	kunmap(page_for_ecryptfs);
> +	kunmap_local(virt);
>  	flush_dcache_page(page_for_ecryptfs);
>  	return rc;
>  }
> -- 
> 2.36.1
> 
