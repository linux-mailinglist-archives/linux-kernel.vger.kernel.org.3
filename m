Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27558AA5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbiHELyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiHELyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:54:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA1277543
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659700488; x=1691236488;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FetFw5IdBLxxCCjN7AotjZEbXk90OvFjK8aC+xggjZk=;
  b=G9ClZ/1E9imNJxgjpY1xdyYlSTucMRZQshSj8zvywcqU1TO902FkoHZh
   UkVjEMDrggsnHY81pw7Jp5z8+2QrrmNiXu4bNRevI5Ca/qKJwGkJ/V90y
   A1pmcyH3urUp8Yp2KBkunArxPoii+/abW/pliKBMnl+IqPFBlGHFbF4WO
   urmu09EKRwiaGVFbvq+N2qxCEakJdIXenbXCsIESdx/0GJ/GV6cSdAwKC
   m0yawJaz5CrlVKUcsAKJPPLxGRkzAcMIp7azIMEsylDUwq1Q0UuDJkKFb
   6k57jVlGmRg05JPp8ZtkG3BjyLFr6/ywjAEO9DQlodOGIljvrReFEsWsE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="376479854"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="376479854"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 04:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="662958733"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 05 Aug 2022 04:54:47 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 04:54:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 04:54:47 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 04:54:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwtA/8qSmKDU42i0fhyZVq/LUIYCexRYqupU7TtWhgRYOjzTkvcdIU8LFjTZaMaubPQwyVBsFVwt+523FR+ro7SL0IUruEPfOK/PcXl6Lh+zIGeHi+OJ0Y56C3+8pRh8i4aEaOwy9d7eTxROLtvCugcJ5vmIZzeZX2H1m4Pe1QkohsRubAMylIyOo18ckeeRRIUKXoTBkj0us8J1tY3OqK3QSVocs/FOSvkAv16l7N5xGJTQLxLHgZroeervyHgHasXd+Nm/95//fDLynejx88ifhI4qft7leWoc9QCp8hrB+soTxbCbZR+tYalIYIO5vKlEob1d+nDOiWBKnku8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgO98e9jvO7td660GqNsief/4C42QBueDjSszD5qs6g=;
 b=jLHQU1kkY4naitcmHbn2qMFYMhVTDxcJmjG/I6x9X4hPPh0k1+MrlUjTISFNIdfzqkFhOlGY4LWvb8HZfDvgqOybCtld8Nzy2gXpi68HFqEUfc3zM4KK+oYUwS2dpeuk3yDBKkLktwdHVNEO6qr6jtvMka/ns2m4nzMgr606YXjHqWCev/keu8lNKLlUlxsvnsGJbqvzSB9poE568/XOFPs73ZUQ74DJmSHOIw5kT0wgZfmwgHS9iC/RGrzbk/39VI8pY/C9+6pwhsCyPuDoBF2aV7BIDQ0XZAq6cQwMBBXqxFlsSpv/+sbgPIWQcjCjvCSkn1z5sGeVu+AdGo3mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR1101MB2214.namprd11.prod.outlook.com
 (2603:10b6:910:19::10) by SN6PR11MB2558.namprd11.prod.outlook.com
 (2603:10b6:805:5d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Fri, 5 Aug
 2022 11:54:39 +0000
Received: from CY4PR1101MB2214.namprd11.prod.outlook.com
 ([fe80::99c6:6f58:a40f:1ba]) by CY4PR1101MB2214.namprd11.prod.outlook.com
 ([fe80::99c6:6f58:a40f:1ba%11]) with mapi id 15.20.5504.014; Fri, 5 Aug 2022
 11:54:39 +0000
Date:   Sat, 6 Aug 2022 03:55:18 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <dave.hansen@intel.com>, <len.brown@intel.com>,
        <tony.luck@intel.com>, <rafael.j.wysocki@intel.com>,
        <reinette.chatre@intel.com>, <dan.j.williams@intel.com>,
        <kirill.shutemov@linux.intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <ak@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>
Subject: Re: [RFC v2 0/2] swiotlb performance optimizations
Message-ID: <Yu11pu7GwmV0Bf0V@gao-cwp>
References: <20220718012818.107051-1-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220718012818.107051-1-chao.gao@intel.com>
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To CY4PR1101MB2214.namprd11.prod.outlook.com
 (2603:10b6:910:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d24120d2-ec23-450c-ddb6-08da76d94692
X-MS-TrafficTypeDiagnostic: SN6PR11MB2558:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1IpChUNTvCC6REy7RLYOGcqAAnCLfaezgedWyYJned7WwVum/TllJbJzimUBFgYvlr/MPdeGCTsL92ILI/SP62AEWxrCdX0tlnO2CbNf2ZBdNzC0Mv1GglEJdeki6kEOBknWOqfUMoxqh6C0o5aTklHQGZ0ObHMw+Zm4q4o/iTBBir6WzRs55ZUQiMI4TJVQ9E0wuPJKH6dJz9FqbyHxmRroubwt/MQApX6obRoXUmeHxtAWbUnqzd04HdcDC7QGEcuFYHnk2en9CY+yA2vdChc3MjvX8EaGqVN0YkeJvOIPHvdUi8zqCbRn7speqVChgQblUPjnmi0Vy3Rd1DSNMKiCaji2PG+bITtVi/8EutXSMXtLNkrxI7IAhl/s+7ktz+f+irtflBb0cdJB9cWzLdC7fLlCT8qqVm1hOWX3q2EZvzhSrF0WZ7fYYFYuDJOJNf82BJwWzO4k1j8YE3LkhIzvkLDyg+pxjrbvFSQBsg+zR9EhaatcmDhl4n3m/s9C4Ee63jh+Br6oMGngDjClrQOOuStkg1bpR9F1Y0LFJObD4gWDZIXRFNz1EJwT+gMyV5ZrHpMmY3LIx/dsya3nyOCLitxHrShSoi/ApDSf0Iqeyz9CZeO1LuxVo18Izc7Gik+UGY2/xEoSvTJvUGsrgTM4XpvcBZhhK0DIiu8glE2xb2vZBBLcokW+i/6exTllhx3Cqe5VfcJbhqCDpnookqBNjhfvL+fps9+3SEtzP35NWwlFQjgDhTR0kk90HTl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(376002)(396003)(346002)(136003)(83380400001)(8676002)(4326008)(8936002)(5660300002)(2906002)(186003)(33716001)(66946007)(316002)(86362001)(38100700002)(6486002)(44832011)(66556008)(41300700001)(478600001)(26005)(6506007)(6512007)(6666004)(9686003)(82960400001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hgETw2IWAXBHbEK2HUa/bZXaWrChyF9vg5T3gbdfnghUP5VGHf+vmboQhFI+?=
 =?us-ascii?Q?tqtlYREhXsu/M9B1DO6prXOPnb4g+IZjW4JyREoL+dLt6Q5wbXDzMQbJN0AG?=
 =?us-ascii?Q?HdaXebPeokbmNZYyy3jO7eQs6reziE1aWtjbxxIwaD9cjoTNtobts9BFjKhs?=
 =?us-ascii?Q?k4EaQHibePGgUKnotSUBbrHksHY4i5AmKUeLrgYLQqSCuxXc2xvgo2aNdqEv?=
 =?us-ascii?Q?J++C/bpOlLW1iE/2+ZHKmwihSfIAQlSfe2FaBL3YgmYApZH65dSs0hkTmXU1?=
 =?us-ascii?Q?OEyFzulCXtYQ3gl/pITdNfarVfmdeiMkhPsB9HOcK6B2CIem+CyEuet6GHlu?=
 =?us-ascii?Q?8UGK1xZ8AZ/7bLQ/vqyEjmZtfridlLoYh6mFyAgV9rCMMmyxIAumyXhv1pYY?=
 =?us-ascii?Q?DJ9eRFP+qERibSJgDIE1/rxEI6ksWpzXC8J2H58AJh6LavuG2pn+UqFmzIZo?=
 =?us-ascii?Q?+LbC314AgBsB1RY84aF46oHFSZsCAkGgX0LFfnq1NUc34RjwOH3vVzk2m72o?=
 =?us-ascii?Q?AQlgnhJQdkNihoZfgalmtEX2M6pkNLg5SuPnM+wcanNBFhibrb8BshnlILr0?=
 =?us-ascii?Q?8sb86a0zZnu2lQFhtFaF8AToBpM7Tzc7jHiQZzI0gI6pNJohetqfTt2vmoLS?=
 =?us-ascii?Q?zziIdPHaj0FR/7Hmkn6o6a18nCSG4pEGe2HBmT71B6dlEGyshv399EmM7qw+?=
 =?us-ascii?Q?Gzcq5tBMITTffLkymglsbUjyLFYKTpMunAWc/QPs+CRLjmS5VLY8SpMaqjjA?=
 =?us-ascii?Q?kQMN4Zl0YxqULC6diEk3I6hM/fxmfZ1Fb/yhT3ltO/pdZMzA8fa9Mp/mY2ql?=
 =?us-ascii?Q?96JZFkD3QGPAEFBlWVV7dfkmKVT+4nX0HSH5ZAxkPLXSsTSjk0Grrc1LzX4O?=
 =?us-ascii?Q?qRF4/Za+bPuUeCBaINkzyUYEzsit1x6KGHFxqMDeZTtLJUuWNnyT3e3j75+S?=
 =?us-ascii?Q?v02ZA/DDtdhT7OskbuZnaU32EjCCD0joZfhr7xZ6Z6XhMnjDeQp8szyg3UYm?=
 =?us-ascii?Q?s5O5unyumcoGTp999aMT6yU1VTB/wU6mPFC9DbEK8kjQSmmsUmLweifCp6hz?=
 =?us-ascii?Q?XDGRXKbHdBsSZK9Rxvq9M4omDsuV8xSlt0KmeIW5dB3h/H2/FkfWpbalyYH+?=
 =?us-ascii?Q?Esnei/21Ek2jftQT2SrogJ3amBZQWsF4cgVCENaYN2Cf42llaguFbiui2Gs4?=
 =?us-ascii?Q?phH9j7cRc9Ui7pFhEGL/eJv6y4p5iHlRTRs1YXmDNTb41NVabycJzz9TDgt/?=
 =?us-ascii?Q?0g7YfLxiuLzMJO1M2cHvINwU5YaVXRbl1fsCb903v/2Bd/HXfmzryvZcjv9z?=
 =?us-ascii?Q?WjEpuyTXTIgaP4ZEFdkxkwRqsgjOvI+hjqpQwiHqWCWHw0ATB4qYEBRtqCgF?=
 =?us-ascii?Q?7CDHujEkwaWCQWnQxr8XZgj0RT0hZU8KD4cpRBhJpur9xwTOumVTVSS+N37r?=
 =?us-ascii?Q?kYJjBhP0HbehO91PA2ywqf5woSrKyUCHMvchKcnsqWhVUw4gLEnuPEQMytW5?=
 =?us-ascii?Q?5fpmJsTUY+ATA9JndCl4MCee/qXkMZkhd1PBiophaJOf9fBMvhTvF28sWPM5?=
 =?us-ascii?Q?RZDlF0Mfvndy85teCIvV+M5wMP1eWBd7FTke0MMW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d24120d2-ec23-450c-ddb6-08da76d94692
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1101MB2214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 11:54:39.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mm3KgHf0C72oiWQfJHqFEfBfjOLin16vu+PfKs+gDeF6haIni6EFZlZ6mTxBoyE7RczAUgCVrsLmfrFNFKEpoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2558
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. Intel reviewers, comments and suggestions are welcome.

On Mon, Jul 18, 2022 at 09:28:16AM +0800, Chao Gao wrote:
>Intent of this post:
> Seek reviews from Intel reviewers and anyone else in the list
> interested in IO performance in confidential VMs. Need some acked-by
> reviewed-by tags before I can add swiotlb maintainers to "to/cc" lists
> and ask for a review from them.
>
>Changes from v1 to v2:
>- rebase to the latest dma-mapping tree.
>- drop the duplicate patch for mitigating lock contention
>- re-collect perf data
>
>swiotlb is now widely used by confidential VMs. This series optimizes
>swiotlb to reduce cache misses and lock contention during bounce buffer
>allocation/free and memory bouncing to improve IO workload performance in
>confidential VMs.
>
>Here are some FIO tests we did to demonstrate the improvement.
>
>Test setup
>----------
>
>A normal VM with 8vCPU and 32G memory, swiotlb is enabled by swiotlb=force.
>FIO block size is 4K and iodepth is 256. Note that a normal VM is used so
>that others lack of necessary hardware to host confidential VMs can reproduce
>results below.
>
>Results
>-------
>
>1 FIO job	read/write	IOPS (k)
>vanilla		read		216 
>		write		251 
>optimized	read		250 
>		write		270 
>
>1-job FIO sequential read/write perf increase by 19% and 8% respectively.
>
>Chao Gao (2):
>  swiotlb: use bitmap to track free slots
>  swiotlb: Allocate memory in a cache-friendly way
>
> include/linux/swiotlb.h |   8 ++-
> kernel/dma/swiotlb.c    | 127 +++++++++++++++++-----------------------
> 2 files changed, 60 insertions(+), 75 deletions(-)
>
>-- 
>2.25.1
>
