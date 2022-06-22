Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8FF555271
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359795AbiFVRcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbiFVRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:32:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3FD30F78;
        Wed, 22 Jun 2022 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655919120; x=1687455120;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lsmubUdAOEUHHLn1XIgdZ4ZYqRRm6ZQyxNW8eA930jQ=;
  b=be9AawWozdtiTrKo2/EqoiqhTsvZB6Nnjp7hOxwAZEXPFPXP5XD/4rH1
   2VzbOlcj6TfRPe4j3JpIeAC2F0QyTFIDcz+UMAFomSxao6ou6lTg+CBzT
   QN7NnFEVzV7c1b5jCL9aa48hvXxCe4+eoxCiV7JK7g2bh3WdfG3Y4a+Le
   LtgLvxZBFr+8uu7ZrJImBxZx5m7zDRDValKvSWEmmuDLnmmRuLrifmCFO
   3sYTwa6R1tl2OK6POSkGHewpcQqVR0rQuYrw3hzinh8eQXUPH0in70KJl
   ySGJk0yc3g+PkJv9nL97bHfc1xaUPN7x59CnAYc9llioyq36prrfBAkQs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="269207055"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="269207055"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644304729"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2022 10:31:59 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 10:31:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 10:31:58 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 10:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRWmpYqaCTaZsU7pg55Hz1nawJlq8SIkJOeKZK9dMGbXA9S2WX1+3zSD5mhMYd0UaMWJ9qx3qKatOnbHD2uq8lR2ZAe9RZd48HjGBW+vCvzAsYwMbzpz4bYmUL54DNzh19tt8STtvGTrSb7i/LOlYowFfSETIdgJzM+enaqRpHVgTNItcHBCkr/pZsrmupH/mJVGCqcnROk4cjKx87WLfmR1pXUKmAVmTQpTyRSGpUMqcIH3i6Mg7nskJVDrgOUSz6xphp2CIjXtC1fCKMTVL8XuPBOqyQ33IoOJ/OcKhxlSlzC/WdiSOATomcz2QW409BJKV3rsw6+pwVtHx9d3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm0tiC2AXydwL1co/4ni4VEP+0Gcu3TpQimpbkakoPE=;
 b=d1Rb5vzvCcWhOejSxYoqBcQLEjJ3qdKVhwTmwo7LwAdKnsBs8OpKlp9znolj/+mj+sbbXs+jWCHvkW7Wl53EGs5kVLYGcU3cwipetiDcqOnMd/o8Xai3OLzhSe9BUf+ziUpDiNKfeOcFvD8MoTwrE8gFvqFn7XTco/9FGdwJRpn1yGIWXiJ13CCIGh6XV4pJ5fxfLtWrOXQkJuRVZE8e2euVmzqwFDqmaLvD6TRpn6AOCYb9rtYhBA9ugd4/Ng8JfF1D93FWQ4w/0jTr9tNdelsvEJ369GbrY0bRvbloGlm1UaoW+PdQFI5+zi8f3rvpyq6lVbahZ2kenVVvcimqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CY4PR11MB0070.namprd11.prod.outlook.com (2603:10b6:910:78::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Wed, 22 Jun 2022 17:31:50 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Wed, 22 Jun 2022
 17:31:50 +0000
Date:   Wed, 22 Jun 2022 10:31:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] Documentation: highmem: Use literal block for code
 example in highmem.h comment
Message-ID: <YrNSASPBivsb60qu@iweiny-desk3>
References: <20220622084546.17745-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220622084546.17745-1-bagasdotme@gmail.com>
X-ClientProxiedBy: YT3PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::24) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bbd575d-5ca7-4d96-0629-08da547516e0
X-MS-TrafficTypeDiagnostic: CY4PR11MB0070:EE_
X-Microsoft-Antispam-PRVS: <CY4PR11MB0070BAC2FCAE54EF6E8DFC65F7B29@CY4PR11MB0070.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnCBbuAp9okIVDI9NlCBOMWD40NjH/JDlB3po2Pl1/DD6B/I+3R2bTvhR4qVqe+kFjV9ndgn1RzFocUJtjtVJJ8WQYJmQ0QoQbCnreGf55FxDASxTFZ3KzMbbULEpc0dlpiGux4+ASlLC9P1f5BGhYqyFjpjDT3zV6rVLxna4KVNMFdzqoEFMuvRgR6u1OLjvbU1XnJZJ1JjyilRtVgayBUbzg2fONq83KV8sbpJxB3ZH4sipVXkm9J5h1qj1fhYs1xZACgBg+KsD6PR+QjoAbdcHID1z34zPBZDCQQ0tq8Qq0NBwpD/Wob8mEzqiTD/iRVVgNEzNBUfWGqEgtqMjHcd4SHg0Pf/sbgmyb1CFdD8AeU+I4/EOaD70TAdbUz7PdgGh2CO55/KAg6LkeXJpucV//mB1OxY7ZH+tUEu78RmOvmzPaumCPdnM7nChCLvTpIx7ri1snYDKGbIEWZJZz2Vh12phLXLeTtRR6F0KBpMKmwksizT27w6aetiFeQv94hgatgvSrM7BTyjHEOF8ch/k+5GZU5amy1/AL/bwC7oel8LklfzU1pIlIhc1I6Jd+ViFpwYDnsprgoAbPvOHwUHfCBk5MYBJ8NleSNboLtm+L14XvOti1Mbl0KS4x+sd8fCfZcieIurNKJMADTitK4aPkRZEXeApmcLmjrZJE8TbeZbQtR7dw8v6PME/Zg5D/6IhYhtpDVcvhfNH8tXTxSEZuo027hTpFjum3XmKYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(83380400001)(316002)(38100700002)(66556008)(82960400001)(66946007)(86362001)(8676002)(66476007)(9686003)(6666004)(2906002)(4326008)(478600001)(5660300002)(6506007)(6486002)(8936002)(966005)(54906003)(186003)(41300700001)(6916009)(33716001)(26005)(44832011)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v99ZMEtEg2S6EssECUEH1HfmLlAd1T9Pd2EamvMJWD4OT7kWYQ0V1EHicWpb?=
 =?us-ascii?Q?qHvH5QAfZcyBU2BjciI3WMWg9YBw4EjbCJ9qzu5BL/w39AgWMe1V+qFk5T6r?=
 =?us-ascii?Q?RUlxQX+oW01eQau704AA1mj7ke+fdtejCYbYinN4FV6Jl1wic5fx8GzYmpS9?=
 =?us-ascii?Q?Xl55jstMJX+TzlqI7qRTLlahZHE+cAtZXlA7tsOG+48mkQdrqPkSqLXc+pXN?=
 =?us-ascii?Q?ufRqxPg3hILuEebZJmtZwLo4/1SOvIiLPLrwhjwb1fKqTWX5pNRu8Ie18z5V?=
 =?us-ascii?Q?/YTmMh4vx0zYqi3bKR/xFcHb2EvRJUDD9UAoH2QIlYa0fAsgaLTdasZMYur0?=
 =?us-ascii?Q?Uk7BAdZgdXyWtobgP3jzpsx0W8EU6JAobSPRXDxO1xkagBn4Pcwsc3sHsBFk?=
 =?us-ascii?Q?+GS5uQ/U/08cZ/kQmcRYC5cOtk/lqKKK5TWYcDbFDarNIEn1I7AWaDROof+3?=
 =?us-ascii?Q?SFXDTKAcCG6fOcjX04mlLBJzP17JlGxpPXBZhZsUAB3BqXfk1Wb1U0rmPo4L?=
 =?us-ascii?Q?+lTSO8XNntQoDU7+Hg5rsSnf3PP5qZr/PBuRfO3+PpvxUQuuMbgjENC4Ex11?=
 =?us-ascii?Q?4hzJfZ1M5eYtsdwhvakVs3TIDHCqwgViVJc7lEcONrr/u00kOJW22agW7N1T?=
 =?us-ascii?Q?p+M+yyu5DrYoQIG8NXaIrM1cMSz536nQ8djZwW/MaYwJXSi5nkXlS0QMRDy4?=
 =?us-ascii?Q?18waAk8uOklTBy5oWu0QJ4yFUVIlgF4VYD+VSDeNcW0QcwKq3/MoQFqIJ0sQ?=
 =?us-ascii?Q?YCR7C1cLNQYUcTnFKHefnZ9lqlKrnab8HJftpz2+AmkCEucIt4CYy0uK3VIE?=
 =?us-ascii?Q?SWXmUUzG/MSuh+CSLrzWfohIcP5JFqi+bSj61SQsDfbVYWREp6XKDTODRbm6?=
 =?us-ascii?Q?Q2qggcI9W4RwFwaMilv1SRdcPEppM0q6RxV2/A25RCYV8OtPpKwaBX/weg8W?=
 =?us-ascii?Q?tvQh8AuoKN8JCOMbo41nwLjCYYlKRkOgINA5xakCyOfzZGuNnxqiARmn/0C4?=
 =?us-ascii?Q?K1ECWMQ/IXUJ6G9ezyc1SpbMXgqR/6PWpKKe3d3x9dsrxsp1kQGRAgPwIIOx?=
 =?us-ascii?Q?9tgtYm3jKBO/g1uou8aUfau+r+POO3OBDin1hwEZ8iWKlsDF854jxHIFh3zT?=
 =?us-ascii?Q?cZI+mEmVx59NF+XviclovJ1sCix4yGXdHsU7K+WRieH4K1154ZvpA4C51ZJc?=
 =?us-ascii?Q?ML9TiewjVahwxP3Y64N25zGNY8FoAfu0Xw2VIwDeYpl9kccgGV+L9iJvsA7X?=
 =?us-ascii?Q?sb46GeYuWuvBxDgFnH0++AaIjpKktnVlhJoO6TLAowB+gXrw/qofojch/7jc?=
 =?us-ascii?Q?7MNEHfS8OfRx/tkyGzD/W5so4ftK+9qkEjJ1pdDegPmRkYJUpcpc2pF7EVXj?=
 =?us-ascii?Q?bIneKOaQzCWlTbGXP9JJx8+uTcieCoE8ynxjhyfY0T8ruNHn9wKjQLpoRIkL?=
 =?us-ascii?Q?uaAWDk4BnmjRjftZkiZNhNofxDGpEvNpW4wd1Krvh+e4Sulovjw4bcycY59x?=
 =?us-ascii?Q?IzvYw+itT4aolEyCwAuBJ7KkKYrNzWJ6xbAnuBrw83IjG2sFkSM0FJq6djKh?=
 =?us-ascii?Q?vfIO23s1mn5aIYI6u/AvlJdta9FRS0CYxCT1E+VaVFM+1p6M9vlCk797AR7M?=
 =?us-ascii?Q?1bf8c2dCBdBrPTZ51H8ScEi3VTp9i3Wve/2BUkKo6MPllGccWiG/cuYB9sRi?=
 =?us-ascii?Q?+3jZfK7Fk8CF7/0kPJPpdD3VBvJp3aBoOVE5ufpcYHAaR6ueZ2cYsVIKHAl/?=
 =?us-ascii?Q?UCD6Sl+8RMmbUNI7Bfq2x0kA9SE77sQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbd575d-5ca7-4d96-0629-08da547516e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:31:49.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7Hv4xF2UBvZDVdu78iKawVx1VQROj1gzIC5YV/1aZZeb19cU4bWOEHJ9faGCrRVX4RQCzynIGNzwdBg547ihg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:45:46PM +0700, Bagas Sanjaya wrote:
> When building htmldocs on Linus' tree, there are inline emphasis warnings
> on include/linux/highmem.h:
> 
> Documentation/vm/highmem:166: ./include/linux/highmem.h:154: WARNING: Inline emphasis start-string without end-string.
> Documentation/vm/highmem:166: ./include/linux/highmem.h:157: WARNING: Inline emphasis start-string without end-string.
> 
> These warnings above are due to comments in code example at the
> mentioned lines above are enclosed by double dash (--), which confuses
> Sphinx as inline markup delimiters instead.
> 
> Fix these warnings by indenting the code example with literal block
> indentation and making the comments C comments.
> 
> Fixes: 85a85e7601263f ("Documentation/vm: move "Using kmap-atomic" to highmem.h")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ira Weiny <ira.weiny@intel.com>

Thanks!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>

> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v3 [1]:
>    - Say "C comments" rephrase (suggested by Ira)
> 
>  [1]: https://lore.kernel.org/linux-doc/20220620083649.18172-1-bagasdotme@gmail.com/
> 
>  include/linux/highmem.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 3af34de54330cb..56d6a019653489 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -149,19 +149,19 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
>   * It is used in atomic context when code wants to access the contents of a
>   * page that might be allocated from high memory (see __GFP_HIGHMEM), for
>   * example a page in the pagecache.  The API has two functions, and they
> - * can be used in a manner similar to the following:
> + * can be used in a manner similar to the following::
>   *
> - * -- Find the page of interest. --
> - * struct page *page = find_get_page(mapping, offset);
> + *   // Find the page of interest.
> + *   struct page *page = find_get_page(mapping, offset);
>   *
> - * -- Gain access to the contents of that page. --
> - * void *vaddr = kmap_atomic(page);
> + *   // Gain access to the contents of that page.
> + *   void *vaddr = kmap_atomic(page);
>   *
> - * -- Do something to the contents of that page. --
> - * memset(vaddr, 0, PAGE_SIZE);
> + *   // Do something to the contents of that page.
> + *   memset(vaddr, 0, PAGE_SIZE);
>   *
> - * -- Unmap that page. --
> - * kunmap_atomic(vaddr);
> + *   // Unmap that page.
> + *   kunmap_atomic(vaddr);
>   *
>   * Note that the kunmap_atomic() call takes the result of the kmap_atomic()
>   * call, not the argument.
> 
> base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
> -- 
> An old man doll... just what I always wanted! - Clara
> 
