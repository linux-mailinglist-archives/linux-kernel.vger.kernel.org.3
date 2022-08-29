Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77EE5A446C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiH2IBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH2IBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:01:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CC445992
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661760096; x=1693296096;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1lyOOaLC9ecSAhqtUTvnLeWAKAd844PF0w6j9+fgJ10=;
  b=Sg3Q3MhOVzFbO4OUaK0pUrKONDuV9SauqPt2Xu4GH+I0IE6HeW/J88G9
   VLOLzCNFYrao2R9GWGb//nINCxZDS/Dd/E7vwC/bqrGYTGAmv3LUMfal0
   rcr9DbfxzMkU36vlNKSWhIR/2Pr/DhcJfRSkTgnXrlLgbCxEKJVhHgHNv
   +/0HtJVZ+AD8zPpsOQIVwI0PRaS8VryZHI8zT+b+dR68FNCKbiwGUX9Lb
   dxp3shJG9EG5N90RXKSIDIli+TILTaAattSFf3BYVfoZ5HJy0SuLmIewN
   XtYxg5XgCwqI3pTs/QbdvNLffZfvgSIZ3F0+UUcWKkau3NXYYuwggZXct
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="358801404"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="358801404"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 01:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="588074054"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2022 01:01:19 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 01:01:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 29 Aug 2022 01:01:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 29 Aug 2022 01:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQoGme0IeLonQutt5WJRPZ0jEWhAmPZs/78WAROYA1ltlPAcQV4Sqf4HSfhly0shun6kIGyvOMYUmcNTM4Lxiui+wr7tYejxgbMXkC5ZLeHGCGOs1KrjnENT3F1QDxQcAR490MzA8bg4Z6Pm+OtHd18F6fzM8Nm/rUtKPWxka6T0DwWwFrQvAUlzwJIvwUYok8AkyQOw/shTbg1wzxbSuPI27v4eQ51DLC4HO8zeT+y50cV8MxJoD45hDGkl/qvw5crFunL/S1U8hqgKFLckR6gea2j2HWwudeegRzuicpnwENqLyDT7fSrFMWvd8MxCU1GhRq7c96I1A+rhghwWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2QtYF7cKmqH2gY0EsSQ6f2W8ANNmMdwhSx+6XDsabU=;
 b=dXiW1DRyfizGN4syvxDP75TeN9p107uGAsxQRqV93G2Ob+Ll0+mnxMZ9Mp/WMI6trRSBwCWuMDIRSLLvm50lovCrIgZ2bQkWcv6o8bvY7t6mI4wHYFtsMxFFXKE33TRh8eb7wdWsxZ1DBYHFZr6o6R8ccT/NhSJ4PX7EI6LUziEvmsD5gspNqWRwFfsV7M09IbyV189sM/9JwkDh6rThkijzwFv9b4hkLPzAu+tejUwcOMHvyEzhMxrkBa8su5tSo7YOGwtshv4AhWFwUvlzvEaRLkOsRfcIEPvoSQD8JLZlNU5hknKi7UixzBBiBzQif1VTwRhPpqsvM1cA5wNyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH2PR11MB4327.namprd11.prod.outlook.com (2603:10b6:610:43::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 08:01:16 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 08:01:16 +0000
Date:   Mon, 29 Aug 2022 16:00:41 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: deduplicate cacheline padding code
Message-ID: <YwxyKS3872gW8PaO@feng-clx>
References: <20220826230642.566725-1-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220826230642.566725-1-shakeelb@google.com>
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70d15240-7903-4e4e-27fe-08da8994a644
X-MS-TrafficTypeDiagnostic: CH2PR11MB4327:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wjJgQmtR54Z4cNsF0gsGOsHEA6z4Z4mBNti6kq7HbhB04t9K6M6jJvRrFNGkjKpIRBe97kpiRXEH5V5zjhWEH5MpeVmrgfhrZ3tBLxDeWUntFX8qAcJkhcnuccPu2REBHYAYmCRFkz24Tn4gO+J1Zf1FIsteH2vgllSeuqR8vvvr59tgTNdlv2jIRC+4YcgM1CHcACUhK78mTxz4yAkpcgSyL+lmySDnHo1uz4a2CSRCqRPtpxWeYnQEz1Ve86gEu0YgO2ojqBK6uk8JULdR64jPvfR5Yb5gmQM5r4X7wWQ9YSpIlyQ9TMOmSk3T78lrVrfVQ5HgsGiIkCjRUzANY/Tdu9+Tf0GUqLRtExR6N+7c9JzpLNRPO3UAVWpW6u0uTHidudiySyfI/WXQ12hlQ9caXaIv1rszgIT97l68js9v2G0gRmxgng+qM/JqbSewle/7SBhs8TOWPY+rWMlDxIKNmsTSbHyMWMS2qDF835hPsZEsOFdY8OWkjhioCk+J/kJBoxcxcOX5RitRhSdBl7p6+JLp4c80aQqw4m3JbeRNVzp9amzRL1Kl5REyyKxLxqUWYASUy1/lcQh4Zn3c0qZMLSg4NNHUlxD0wXWa4PL5OZOwU5hhQspMKvbuFq6plU+cZa/csDGk+0gtPgC6mlf24OFWqZHxG0mJbYqI1NvSlmea2ekOFzYP4xhFoEhLQgplHqc4+SmsUNHCWZHHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(39860400002)(396003)(136003)(376002)(346002)(4744005)(2906002)(6666004)(33716001)(44832011)(6506007)(9686003)(26005)(6512007)(83380400001)(316002)(186003)(66946007)(4326008)(66476007)(8676002)(66556008)(54906003)(478600001)(6916009)(6486002)(8936002)(5660300002)(38100700002)(86362001)(82960400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wd9w4XnL/qOqMy7Ngv5nLenVrsCMNX0k+y8wglJfZbZwIiQAoR6BO181R+BU?=
 =?us-ascii?Q?+La9QTp/2BSEZOLLV11vUXMWpBfJUsXQhCkmk0TtJw3pHvSvOYkHh5OPdBmU?=
 =?us-ascii?Q?80zGFd6IpHVsmkOGQdT1T6+axldPS49fjPjUNu3bIyF9jbyCgejIgO10SYii?=
 =?us-ascii?Q?JcKrVEa7gfoA+5ddTlWwVsBga3SwdPF4hxsnhhRk70ExNINcCPxH5FGS0Gfv?=
 =?us-ascii?Q?D8UEmO3nAav/tz+FCET9uTntMtqDImiSpp2qHm0k52QRkdAvkCWiT75gDSeA?=
 =?us-ascii?Q?OMsH4HYxWuAjdjFR+hG79D/IHNl2zfoBH2xtiTj5Ob+3j9xwS3WyAZzLZsyI?=
 =?us-ascii?Q?CDAW+E7Xc8CAt8P5+GCPRYvuDg5oeYMaymeZsV2J7ptNkTKsIr0dLvhSK/4C?=
 =?us-ascii?Q?LWrG5dNRutNhSFKnTgtksGUxHon+HnBW1T8urUzqIqLv8ELo16+WyK4Szecz?=
 =?us-ascii?Q?H3QNRaKhNSzOegb92/uLVebmcOH10Ne3hbjLZjYhZQRkZ5pChYnKK8g46FLu?=
 =?us-ascii?Q?vDfkyHtkcF8785QHkRVU+pojMzpvydlHlNoo7lBnZk94sYNWK7pfrOoTfQAW?=
 =?us-ascii?Q?hFvfLzlhAxdv+uX8EKxxK3H0GcjYlRPDNOxJEf7A1e7sOl9l2lX/PW24US5Z?=
 =?us-ascii?Q?JCvOb40arwsb4tTmoX9VsSm7OWIXZBYcVoCAjzekUlYebFyMLuUCmGogv7wK?=
 =?us-ascii?Q?nfsvQ2zwbm92UKODyuRdxpm5n+9u41sTxy7QwV7fNuKP+KJccQKmuNvIcuyJ?=
 =?us-ascii?Q?Flc0gnChQ5dbAlZbByYjhe7IJuqXMI+VnumWmcpL8apiM60mCaJQUFasWki1?=
 =?us-ascii?Q?FwL0NZQcg0nWzj3RqyutjcodB4cMaDmMeiGilfEZ4L4IM3c1PRDafZ4l/EW9?=
 =?us-ascii?Q?JY3NOuq0Dgkh9fh8fL20fb9/OKeHiucQBLLux0eWefp30UdyLRNjCD1poz+W?=
 =?us-ascii?Q?HKTwuWtEMBbdxvlL0+uQ8j3s5v27oHYhYtn1Y2i45VZGHg4KVTmBiAardqtJ?=
 =?us-ascii?Q?aXxULNH2OgARGhNlL6stNQqJ5NcZdA0kHKC/H8eGeg8PxeIoGM88cAWpcH91?=
 =?us-ascii?Q?dyczOeMazWb14loHhIGQu0z0Ok5dB30rOanore2UEMOykSC8Js+VlUWIu6hz?=
 =?us-ascii?Q?4sYSF3U/EtHLw+jLXqHBVxdGdvuPezGKTb3W7cPpxcKznkW8prOdZWuyUOON?=
 =?us-ascii?Q?8eZZpawOW8NHQ6ixwg1u7QuHmOaOJblmPwZ9cFfUMCIKzOmNdeyTPz8oG+AN?=
 =?us-ascii?Q?nn6xNH1cJ8LHF/STscuNh45mDDhzzCUu2HaaOuIoZSsRDsYv4UM06zbC7kbO?=
 =?us-ascii?Q?CBRN8cDOt8J0lbahQsYqxAxbZKRQVNOG5N1rEVh8t3hm71djeqzYh8cPT11D?=
 =?us-ascii?Q?y/n+/lhXyeWceDg40T3cYn5VbrfHhvZtN3a5+BuRj3m+u79K0mavmoyvvwkT?=
 =?us-ascii?Q?J5yEYFuhoo+X3ZeXUkZLGEMxD62nAp2rrD0bfTAUpWNQJO+1ER6WsTaSIZuU?=
 =?us-ascii?Q?CnUt6ZKENi/eferumCt3FZ+HGeeaZDITFxseq6TwECNpr1h27aa2CrMdBouZ?=
 =?us-ascii?Q?Hxz1P7lvAYE38CNN/4LTQ4gJ412ssEVq7hPREb6X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d15240-7903-4e4e-27fe-08da8994a644
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 08:01:16.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daz8dmqbltcwAdtj23OlFhGlUwxVEv79Pi1jmibdu4tVyxxYjFES5/N3L0GpHX9WQNXLYo5pya6Vbvbw7RXJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4327
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 07:06:42AM +0800, Shakeel Butt wrote:
> There are three users (mmzone.h, memcontrol.h, page_counter.h) using
> similar code for forcing cacheline padding between fields of different
> structures. Dedup that code.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Suggested-by: Feng Tang <feng.tang@intel.com>

Reviewed-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng

> ---
> Changes since v1:
> - add semicolons in mmzone.h
> 
>  include/linux/cache.h        | 13 +++++++++++++
>  include/linux/memcontrol.h   | 13 ++-----------
>  include/linux/mmzone.h       | 24 +++++-------------------
>  include/linux/page_counter.h | 13 ++-----------
>  4 files changed, 22 insertions(+), 41 deletions(-)
[...]
