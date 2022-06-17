Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B02E54FCE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiFQS0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiFQS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:26:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B366D3191A;
        Fri, 17 Jun 2022 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655490379; x=1687026379;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ld5j4dkK+HBGUFb7nP84S5Sg1cwWkcJ//9RQXH3iXfE=;
  b=KLmCcNcaHc16O1H3os4OlwI0doDxUG6ngyi9cKzpnVpDEB2IC07DsDaD
   Wc6BceBSFVKVnV6QfQSVRtKIHRpB9y1p1zgoq80Wl1up6VhokHcf8LBBA
   5pxU9QvcNp3ph59Fo/0qZuEE9Ix2clOj1e+/Ilu47vA7JkaUl0asQiK82
   tLeB2Gm6Sg7wS8KrZv8jxBZJERARQDHBKL/zvmPpKcgBRTHIkXmsTFhDC
   IIR104Sp8E9o7+jGEyC8rleHxtb05IEUig7RYJZzixQNeogRid470OYE4
   j4MaQ55zOJZurAYRzl0OBRvWy+xCwkJmBWnNWJMI3+WX7oMBJLAibEjD3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278328790"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278328790"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 11:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832134369"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2022 11:26:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 11:26:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 11:26:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 11:26:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrZO5fDi7QyhZehOtwBiz/3MGqur8VCcd0NM7R8zG2cl7wjpXrDMX52SboQDvzP2Fz1Catm/ZBpvyCtrFwBIgu/wx2LJGNoxAYCN6KHND59jc1rj1sNclNH4c4Y2utgnzzLlXfExLZI63LjRJo7+4PG5Sb9LQI0zHczs/e4YVYiKFMLyn2e+n6THBb000vhZoZxZCf3CmRw5sYZOayH4B30x/eV28SLD3BGB/SvA5cH2riXshS/LOUp0jeL6e2idZyM1dzVHRdq9KhgwMGUpDntC6hcd7HMNfIm99gIq1gQNiltkpRZu6dtgkPQ2dCxNl8Jgh+49XZDwOiddSrcIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoW4s+BOE9FchY2IKuoxu6fIyLAz905n/Jh+tBr98fw=;
 b=EJ/x1vo63wRHpfrc2JiiQ1LR5UWKVn+oJfbuaNKtNgT4x78VxdA/JvTjmAmOJTjOimoH8yd2o67trxnldnNYeG90IqvYIc7+02/wGjOJx0dejTAdrF/KTeuFpUfKxO4hdFSUgRJb1Eb0ictd+w0vTDWo7watSZ6H8q7bYxKcFlTbcytWtGF9UUouDjRiGYRflOh2bX2PzR09e1Tid7qGQ8DzgQngc+T+Z4bf+n8NcuxFtbYXf7ZxfKdvDa/V0KDaw+hSOm8OzTZE75HPonzumOn176wwTGx5PkoYvJQVbN17dTFd7oPyLJIXHkVHiwunN7U39gahxfwXuG29sDiSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB5503.namprd11.prod.outlook.com
 (2603:10b6:5:39f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 18:26:17 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Fri, 17 Jun 2022
 18:26:17 +0000
Date:   Fri, 17 Jun 2022 11:26:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <62acc746d01d3_81c5e29441@dwillia2-xfh.notmuch>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
X-ClientProxiedBy: MWHPR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:300:ed::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa8100a9-57bb-4dbb-3df2-08da508ede30
X-MS-TrafficTypeDiagnostic: DM4PR11MB5503:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB550368B437989C70BE4DDE6EC6AF9@DM4PR11MB5503.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXvH23V6aOennBoD8N8S2KThOaE6aQi0UlYZcSTPfxTZIFT8MTC1Au4SDlusARjwThXBNRXOTcP2kUwHzN3/Fk7yY+ZvjaE9ij0cLUNtlh1tvn5vEBMERd8bgg9mARmMiepGPMqb1+rksH95/dIcNgKlgIjG/ot4AVv8VRCEcBwH13JuVgEnhpQB/PLtEMSgzIp2DDxd1DY3pwRDI0d2mSDw5Dm6TFTdUnIAMQ+ivBGaCpzgsh37WG/EAS2ZjH4491gDeEMungfcMtQj9+bQGCVeKkcc+tSlKzJ+P2lQQvxXZyDh5xTl6X0yY1y1OpQXG+pnWu7SqT3bbFoNkfK+HiNxAE+9lNCfn5YOeovF2HPjgPKNmlrnHO0cCGg4XzWdiY6HovGHOPOrpOXIdrp1kNQw/KajyIL898m1PdyKS++5ew+JG5JaZbsTxHa42DVNuwwxlNiiaQppbl46IiOpLt9TEe99t4fIkrIIJ1SQJBURWT9jEf+hebw7tp0YLzwlntLupR+4/9eu9IryuxFytZ1aIc2N3xSW9P9mnbaC6+NaogtDpEoBpqEct8J8x7xOzqxzeBcrdmuB+2W9o4jgs7cWW3MEdNuFwMVpuukoIttemgfMDaMnvsaeMziSxCBBnoHQTdw2xsEV0hm1kS6MjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(186003)(82960400001)(110136005)(6666004)(316002)(38100700002)(83380400001)(86362001)(5660300002)(8676002)(8936002)(66476007)(2906002)(66946007)(15650500001)(66556008)(4326008)(9686003)(498600001)(6486002)(6512007)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0XthpPyP2NRCKNkuDzeEI5oqnrdJ2smOU/OUoCr3vTYD/COZ2nL2lZKxbDo?=
 =?us-ascii?Q?lFS/JmhcemLH1Nhlr2DbXXHgkQlUFy1OTYmL1/NBEjth/XQBt8CaJ5pmdCVu?=
 =?us-ascii?Q?LYg5ZA81ImCFfKoL5vRpVhfiuTrR5f+MpvAhwbrNjPitXYEJ1hA1c1qoR0qj?=
 =?us-ascii?Q?VggeuHG/7/qAoRHWKFyG4I5/690kzbPtr6a0YxjHYTf9VqxZkVvwR30JnKXs?=
 =?us-ascii?Q?nTevWC4zq4BqL2eWa7jUOYz8KIIzedTlWZ8mF7yWUVS6sHbNQs08rVzYZrEW?=
 =?us-ascii?Q?4yvYVvc1FUPlrvV9tlQAiWAKYoXOhbA+RXaPTGBupjIv7sDbbwnZGnJ9oMe+?=
 =?us-ascii?Q?pTq9HCIFkI98CYMgtI21mQg04cOqLTD6lnyEYumEeAQc7+qsl7PmLzji1u2w?=
 =?us-ascii?Q?5mrs/3MtSQcZqzbgG323ASEhD9X6sbHpeAjSyLhONvKfts9Ad2Wd7JQstc4D?=
 =?us-ascii?Q?G7Baovg1qbWqn776kWv+UYH/QiBma3JRX2SPmhfvuoZ65gpLwnbece7Z7hCz?=
 =?us-ascii?Q?n3ToRGtUG+UVCn4mZwrqHVTsr6WH8OqiU8lQBSA12zYsWrKv96MYJ0VO6Umd?=
 =?us-ascii?Q?N65V5K29ALQhDeI4lPmYq9ioIynjWiSgeOhSjgzjq5nXurosAD2fFHGNFSp+?=
 =?us-ascii?Q?9cL7mJl895pfeN+v7JyPOYItUuKAc9N2UPYC8UQEDFnX9IAcIwXbmVJ3MjXq?=
 =?us-ascii?Q?zZvuG4pTLU74qfvPBQxEJiyAFA2Kc/ySMYErtsB0PdKOqw8ERajt0q+AbNTr?=
 =?us-ascii?Q?OFG4y5P5hLtrfsSqHBoMEyOpAjMRhLNO3C4dmQHeZlD34EEFYyff9vvadR10?=
 =?us-ascii?Q?qWhauQQsFdTu97wHlv6KYNfO9/nQ1w/lX+LLDw6E1UqcfUZbWbqvXdhH5qbT?=
 =?us-ascii?Q?nkEHY1EwSYcaAbLGr2e3dBGF46DH202k2BMIDYgOPsUxIxylz2wlbv/QrScm?=
 =?us-ascii?Q?eoG91iH9RchYDYVlLLagEuNyVYsJPzjm0ICN9nHtag+EPPG5CCdpIbM3pXyc?=
 =?us-ascii?Q?rwuaceWBXfdeSnNvTC63BsbltLs60Ebc1zEJiyNUYw/C8Qw0/jU/YePHQ8jx?=
 =?us-ascii?Q?g5FFQBYX+t9Dyz6lhqrZ5fWU2yhe9Krz36vM5WLPokwvDipDqwA3OuRndsOR?=
 =?us-ascii?Q?fWME3R38f0mF7flTfTOTGex2wnJkD6t9WiFm70bPZa8cu8xhKtX7i/SIRDtI?=
 =?us-ascii?Q?VCGlttlfccKVPjMO0vtK6DzFXOUcdnL6MEAemYMbrBEgo7/r27y9rD67MsBf?=
 =?us-ascii?Q?qobCHPJ0185lLapiB2pKT1YTzUC7f8VRwPcT8ZEHYbdolcttrM5/fz9y89bv?=
 =?us-ascii?Q?382J2AT4xg1XMaeEdVfS8QdVDEOiHU+j6Z84KgyH6+Xjhd98r8iyh4O36pUf?=
 =?us-ascii?Q?3X8CnkYfIThV8mfNJu7nrUxIWGUjx8kVJY6TayTidFiUFM5pgOP2VktLWul6?=
 =?us-ascii?Q?szWmY+YUBB11+47Neb+Yl696GxZVSI3Mby2Unl2ahOHppOk5NuBAvcxzEzhp?=
 =?us-ascii?Q?HNj3LZaOxmxKp/wzSPqZlppeeaCebLaUGX8j+ffdMHSVJK5szgSjhF+NwrQg?=
 =?us-ascii?Q?RDx2/YHFntf0ijbqMFGY+oHeXgZTdyYdAEOrwRQov8xkVnhz3Z7kxFu55Emx?=
 =?us-ascii?Q?X8el2g09zjoLxbCs7thTD8uL0+XeR1y04V8uZ8qzg0wv/2ecjjT2h8bKbSTm?=
 =?us-ascii?Q?wCqcjTMyPA/wZCCkerHTMj5XtMR1NWghAGRZfdNNGDigTd7h4ULQKBcFzmWg?=
 =?us-ascii?Q?+FcbjtYbIkb8AbP6ivgY4zrfCHL0/qM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8100a9-57bb-4dbb-3df2-08da508ede30
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 18:26:17.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bAKw5m1YWVjq3fXt8CCXp97Z4IpiNUI5hfj43DzIL08ppcD3xXj9EU/u4tnxQF9we4+T2UyEmVUtkhdh+rjqCGHIvyXCeYnDU+00xAh7g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5503
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices that support persistent memory maintain a list of locations
> that are poisoned or result in poison if the addresses are accessed by
> the host.
> 
> Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
> list as a set of  Media Error Records that include the source of the
> error, the starting device physical address and length. The length is
> the number of adjacent DPAs in the record and is in units of 64 bytes.
> 
> Retrieve the list and log each Media Error Record as a trace event of
> type cxl_poison_list.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/cxlmem.h    | 43 +++++++++++++++++++++++
>  drivers/cxl/core/mbox.c | 75 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 60d10ee1e7fc..29cf0459b44a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -174,6 +174,7 @@ struct cxl_endpoint_dvsec_info {
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @lsa_size: Size of Label Storage Area
>   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
> + * @poison_max_mer: maximum Media Error Records tracked in Poison List
>   * @mbox_mutex: Mutex to synchronize mailbox access.
>   * @firmware_version: Firmware version for the memory device.
>   * @enabled_cmds: Hardware commands found enabled in CEL.
> @@ -204,6 +205,7 @@ struct cxl_dev_state {
>  
>  	size_t payload_size;
>  	size_t lsa_size;
> +	u32 poison_max;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> @@ -317,6 +319,46 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +struct cxl_mbox_poison_payload_in {
> +	__le64 offset;
> +	__le64 length;
> +} __packed;
> +
> +struct cxl_mbox_poison_payload_out {
> +	u8 flags;
> +	u8 rsvd1;
> +	__le64 overflow_timestamp;
> +	__le16 count;
> +	u8 rsvd2[0x14];
> +	struct cxl_poison_record {
> +		__le64 address;
> +		__le32 length;
> +		__le32 rsvd;
> +	} __packed record[];
> +} __packed;
> +
> +/* CXL 8.2.9.5.4.1 Get Poison List: payload out flags: */
> +#define CXL_POISON_FLAG_MORE            BIT(0)
> +#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
> +#define CXL_POISON_FLAG_SCANNING        BIT(2)
> +
> +/* CXL 8.2.9.5.4.1 Get Poison List: Error is encoded in record.address[2:0] */
> +#define CXL_POISON_SOURCE_MASK		GENMASK(2, 0)
> +#define	CXL_POISON_SOURCE_UNKNOWN	0
> +#define	CXL_POISON_SOURCE_EXTERNAL	1
> +#define	CXL_POISON_SOURCE_INTERNAL	2
> +#define	CXL_POISON_SOURCE_INJECTED	3
> +#define	CXL_POISON_SOURCE_VENDOR	7
> +
> +/* Software define */
> +#define	CXL_POISON_SOURCE_INVALID	99
> +#define CXL_POISON_SOURCE_VALID(x)		\
> +	(((x) == CXL_POISON_SOURCE_UNKNOWN)  ||	\
> +	 ((x) == CXL_POISON_SOURCE_EXTERNAL) ||	\
> +	 ((x) == CXL_POISON_SOURCE_INTERNAL) ||	\
> +	 ((x) == CXL_POISON_SOURCE_INJECTED) ||	\
> +	 ((x) == CXL_POISON_SOURCE_VENDOR))
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> @@ -351,6 +393,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +int cxl_mem_get_poison_list(struct device *dev);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 54f434733b56..c10c7020ebc2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -9,6 +9,9 @@
>  
>  #include "core.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/cxl.h>
> +
>  static bool cxl_raw_allow_all;
>  
>  /**
> @@ -755,6 +758,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  {
>  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>  	struct cxl_mbox_identify id;
> +	__le32 val = 0;
>  	int rc;
>  
>  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
> @@ -783,6 +787,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
>  	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
>  
> +	memcpy(&val, id.poison_list_max_mer, 3);
> +	cxlds->poison_max = le32_to_cpu(val);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> @@ -826,6 +833,74 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>  
> +int cxl_mem_get_poison_list(struct device *dev)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_poison_payload_out *po;
> +	struct cxl_mbox_poison_payload_in pi;
> +	int nr_records = 0;
> +	int rc, i;
> +
> +	if (range_len(&cxlds->pmem_range)) {
> +		pi.offset = cpu_to_le64(cxlds->pmem_range.start);
> +		pi.length = cpu_to_le64(range_len(&cxlds->pmem_range));
> +	} else {
> +		return -ENXIO;
> +	}
> +
> +	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	if (!po)
> +		return -ENOMEM;
> +
> +	do {
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
> +				       sizeof(pi), po, cxlds->payload_size);
> +		if (rc)
> +			goto out;

In this case, no need for a 'goto' when 'break' will do.

> +
> +		if (po->flags & CXL_POISON_FLAG_OVERFLOW) {
> +			time64_t o_time = le64_to_cpu(po->overflow_timestamp);
> +
> +			dev_err(dev, "Poison list overflow at %ptTs UTC\n",
> +				&o_time);

This should be just another event type, not an error message.

> +			rc = -ENXIO;

No need to error out, the media error records are still valid.

> +			goto out;
> +		}
> +
> +		if (po->flags & CXL_POISON_FLAG_SCANNING) {
> +			dev_err(dev, "Scan Media in Progress\n");

This isn't an error condition and it should be something the kernel is
mediating in the first instance. For example if userspace did:

echo 1 > trace_poison &
echo 1 > trace_poison_cached

I would expect the second echo to just block awaiting the completion of
the scan media request. I.e. just prevent the possibility of these
commands colliding outside of CONFIG_CXL_MEM_RAW_COMMANDS=y shenanigans,
in which case userspace gets to keep the pieces.

> +			rc = -EBUSY;
> +			goto out;
> +		}
> +
> +		for (i = 0; i < le16_to_cpu(po->count); i++) {
> +			u64 addr = le64_to_cpu(po->record[i].address);
> +			u32 len = le32_to_cpu(po->record[i].length);
> +			int source = FIELD_GET(CXL_POISON_SOURCE_MASK, addr);
> +
> +			if (!CXL_POISON_SOURCE_VALID(source)) {
> +				dev_dbg(dev, "Invalid poison source %d",
> +					source);

Per above, just emit the raw field value and leave parsing values to
userspace.

> +				source = CXL_POISON_SOURCE_INVALID;
> +			}
> +
> +			trace_cxl_poison_list(dev, source, addr, len);
> +		}
> +
> +		/* Protect against an uncleared _FLAG_MORE */
> +		nr_records = nr_records + le16_to_cpu(po->count);
> +		if (nr_records >= cxlds->poison_max)
> +			goto out;

This also feels like something that should have a Linux max as well,
something like:

"cxlds->poison_max = min(identify->poison_max, CXL_LIST_POISON_MAX)"

...where CXL_LIST_POISON_MAX is a "reasonable" maximum for a cache of
hardware media poison errors like 1024.

> +
> +	} while (po->flags & CXL_POISON_FLAG_MORE);
> +
> +out:
> +	kvfree(po);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison_list, CXL);
> +
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  {
>  	struct cxl_dev_state *cxlds;
> -- 
> 2.31.1
> 

