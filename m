Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267AA54C01D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348636AbiFODXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiFODXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:23:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE97E25594;
        Tue, 14 Jun 2022 20:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655263381; x=1686799381;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n6pA5nG36A5uWhFKRPnfN0u36xa30DWd5scpCp8z/dM=;
  b=SVfDTOSlYQ2rGJ7TFNHcF5nbw6smJ15t+ZOm0ghVk9PEV2cN7eV74Iv5
   hO0S7PoohvWYhUPwAX3xtBut6+kv/FPTA2RX8w0tnR0XoxgNhdYzaOk7Y
   3DdkAwjO3MP0dhBf69HJpM/Rt0CRtx8KkCydRMZvEcMljx1ev80G8JA77
   CSR9iuQ2lAgiQWa/x538xzrL1+cqjbsyfdBwcLQ13qderlXoBZtQjBYUq
   RCnkLwGf9WrycYp75UaVAljX0GRlV9LL9YaqSbabuuBis1bMEoAiQpbkI
   qVI/GfxAO4wxyYhKmLMtoQkKLC4AmkXcpflJxPr/dtnXKahh7BsIwxAE8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="304243044"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="304243044"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="674244151"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 20:22:50 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 20:22:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 20:22:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 20:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnxM/hN5HauXMCz48T8YKccmkrpxAtgpUb7LqaTgsyul61/qe6iHqeYicoeJb9TuEs3oKzU3iRj/BQjlWXdXkbhl1cplt57cv08Z0HL4kU6jktol76jxLdIsRwcX35C6xoe+/zn0oC3BYlfUMf/9rw/9kYKyi1yz4xZ8oOQr4/IzHAvijEJPxwTL3TLLStlCpr5ke5wR0dj7Ip16l/iuUVI27efGL1SU1WYwdCYFm7EmLZKYnhxn8XcyzO/kzSxxHPT2s5JG4LhaU9Bz9xMdg3Zg3v0zVaLmWzvd487SjQYah6Z7EKvM3GUhG34fx1ttDcBCSvyasHIJVs8QZpbe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyoNsYrLBksixaMqnrmjHj9Udn4fFhvmxKHU1kJIIqs=;
 b=KRtkAvdgDCc4PeNqovYFONzj9pG/aYIoIXIxciqJKyskGQoz4odkGhmFURKv3PaaKgSPw80mrqRtad2YaiqUgPeLHqQ5FXXxKkiJeZQB6nudo2vaAwXQ5RP2W5Rzktd+1nX+LD5q8Ppyp64Dfe3ol9rFeOInlzm0Rn9U1bYnmyia+VC8IlTLLKXzjPVfj/zh8LH5zO1uCmECcdHQcDTBHLIFAZ/VZwr3oUUiswQT34neqgEqEUKE0uzFM4uR56Zm9fFLaNKHK4FV4aD6H7ii4yVBk/mcB4Ze3GeCigz1a+aeT9yPTCnD9cKe1TfxvZogaT/kqHG1GR+kM+0y5rq72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM5PR11MB1500.namprd11.prod.outlook.com (2603:10b6:4:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.16; Wed, 15 Jun 2022 03:22:46 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 03:22:46 +0000
Date:   Tue, 14 Jun 2022 20:22:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <YqlQgbDUTJ6k9UBY@iweiny-desk3>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
X-ClientProxiedBy: MWHPR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:300:ef::14) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6b02bc2-b2b2-4d74-dfb4-08da4e7e514e
X-MS-TrafficTypeDiagnostic: DM5PR11MB1500:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB1500965349FA31EBF630E920F7AD9@DM5PR11MB1500.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMcipbrO7xdrusxHTUL/a7x1VHIRvfOMlhK5Sp25x1Bf0jLGtXt4Yco7h1QAUVbtq9iE8sO4kkk4My82uyd0Fwrj4RqZW5xBjGse8dkJswOJW0lD8o6q04SReVMeWVenx3mnJULoXvRKzSWg3ojl5CxyYM/MzJ0c3ecXYPPNRLqXLxg64epiYlRPU2VP/HZcZa7FkGWK4Zbdm6BBaWbBNILedbXmUMywDseLSwoP865HGIwAYSI4de4ZzaGeWQPrKxIQ06G7OwoLTrgR6tbolEbbTSamqHOgZIovCFWkh46bc5diHKmojeT2RmceMkjy08jRWMOFY28TaE7e0xMW6T1dj53gvWHpgKs7+Fq8dC1qOmJZ/ggfXiqmmzgqmPSFOolSsBfKSogVYo6MmwtkN/dL/Zuk9poxWBSJKQCtKwmde5hJqdLS9KmxWmZcnB7rSJjJgljsm8W7/FrzB6fLkH8S42Habl2DE4EwOHUX0+TsXjNCERIPSR1Y4itNAfqI3Vd0wV59DxzD5/Fzs1A4sObQ5EqRdiH6DItCntL/HprIEpnpw4572gHRweVw6UujAFAmAQBF4S4g/9l8ebNFRHEJFMsyLCKkoSgabXi04cHXPPL9tBanu6Z1TJER+7iyqokM47AXbTOZCeqaPSjoVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(4326008)(33716001)(8676002)(34206002)(54906003)(5660300002)(8936002)(44832011)(66556008)(6636002)(86362001)(15650500001)(508600001)(66946007)(66476007)(2906002)(6486002)(316002)(26005)(6512007)(38100700002)(186003)(6666004)(6506007)(83380400001)(9686003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KtHcYz7zzMEkKiZMBd9/LYAMosem49PJjofk8e+WK1v13ny3ZW2/I745x6qL?=
 =?us-ascii?Q?4eKQpAL+MYB0dR1zTm2zHQrqdMpRK0fDqRWtA0lI0sRRAHlisVQVZ5c4KFVu?=
 =?us-ascii?Q?2cbTOMbyajsGRdrlcRMySJoLNMlFbL1jCzHcTO67kEnOuSsNzJ0iNDk824uY?=
 =?us-ascii?Q?0C3U2DFj6yNC8jIcFWJZOb0tBmtjC2H3U+pQR1YShlOxXld7IJXR1b7fqXly?=
 =?us-ascii?Q?2s1rXhqsMvIM1CiWkDgTrtNcdNmyNSfW4c38aRulYLcLRSqLGyIJhzqvfHwA?=
 =?us-ascii?Q?hk9eOZjj3jBtb5NSbjtszbvnb01KlSVpncJRrirJ3xJHE2LbHiWzs4N4kFsb?=
 =?us-ascii?Q?rkRudwEgmeE6P0ulU8pNwNtSxYScUsrgseRPoWr+NOj4+0X0HhbUhgaBQMf9?=
 =?us-ascii?Q?ugBgvnBbS1cljmJP8koIg07HaHE/pGSnDWWr8JMUDnTDswiP8KO6CJDppa5w?=
 =?us-ascii?Q?7h1dSNej3+tqc7TkofDLTkfPaMr/vPHOzyd1Nmncs+eaaXh6iiiI8k1CsSxl?=
 =?us-ascii?Q?U9uzYWAQBJBxFoF0m3WaLRuUrDpFz42AbNn1CIIOKjToTWRMKrq6stjrBkh6?=
 =?us-ascii?Q?EMY8ZnB/b+xlRsXNBE33RDGztdOo2wTtUyCcl9omjAKd858qH8TYXAsLo8aC?=
 =?us-ascii?Q?4KPsxyLVhoNIyk6/Fi+DUk5GCG4Cw0+b4ZHqLNw5amMcJ+TPdBrgK9VJUf/M?=
 =?us-ascii?Q?m7h0+jIbC39t+Ys0OGZXwF6o7Al78V3wyn9Lzg4yE77OsGJosnr1rp4ku45R?=
 =?us-ascii?Q?enXAWG3YvqLCwpRmfKW/rDN8oSl81Y7D+KQbsq6QDxKdalUY2/UcDxmvrwbn?=
 =?us-ascii?Q?wNviGyVDcY4eMh9Oix7VYXGBrCBS5Ou7dxsB3mwUKlWfq8usqOwdl/KWBWhN?=
 =?us-ascii?Q?MK2vRYtaqNIF34KnK0nI5U6r6/zct4SC3HYgRHbRzXJHqu6I459CLXXLcRit?=
 =?us-ascii?Q?Eqga37RE8mhAz2LF59DftfZBeobp7IL8FRBdO1S77GWxZVzUOMe0j76uRWcd?=
 =?us-ascii?Q?kMKgY2+z4+ewu1W3wMOBoT7NLuEjNi5j8n24G1+sy2eezvejBqKaWdmEeloi?=
 =?us-ascii?Q?qUBOeThRM4kdUVN2hV41IYUcmRjYqOTvuZzMK8Hgl1PSO9rYXbQgQApLv/jo?=
 =?us-ascii?Q?bvsqPR0Rs0Dr9+Q8qBo2iOyZth2fwyvOPOB2p75iw8zb+Q+vl3Pe+I9IuOEL?=
 =?us-ascii?Q?nMFXu1wliQgf68zGZ8URi859CMHYV670EZmffGpaRLIKGMc5BWs5CTyHKcYL?=
 =?us-ascii?Q?iteiTN/n+wJylh6JLIgsgnfnz9x6jJhFn73n1m52zFfQrW7TmIuAfGC4TqVJ?=
 =?us-ascii?Q?FfIXYftFxkhLQVQyXeNHP385UrdnKMnJjocMpEwcAyr1txb2H6LZVebZH9C+?=
 =?us-ascii?Q?wDTj/aQ47T0SO+14VA8YYnmD5qTjAWwDMeNdG2MG4VxnScXI4IcCqnNNNFba?=
 =?us-ascii?Q?g5m6uTOTQHjJhrjhSIZBGvwrgBaXKkKzEal9qxMszxShJ3JxkCrZ4kqQitE5?=
 =?us-ascii?Q?aI75MMeC6+p6AEyEASUl2FCwGqXqqo5BYGB6Yuu13viK/YJdfnoDcN+Iankc?=
 =?us-ascii?Q?Jf7ylHKtTHCtYUC0iBT4N8i+hxt2ksHjBAdYOEdw7GMzcgSvHPNbChDL3JYM?=
 =?us-ascii?Q?1akcJnSamTVZNJ4kjdiKxAoK9cW+Eik2O1/JnzN+Yhz7Cir0+d3eKtpSw+o/?=
 =?us-ascii?Q?+tEMjKKvCGsq1rN1DO+8+q0qsele8W3budTopPPSlmfhJMwpjorJJzRC70gC?=
 =?us-ascii?Q?w6EmGs8DRly6ddR8KJtZRIaNh2XAAhQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b02bc2-b2b2-4d74-dfb4-08da4e7e514e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 03:22:46.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpet4ic9tRUwoiFmS/DP1Npsk1/0mJwUjnvyEpBeBSzi5etJzKZPmiq6hnGtJatFAOH54sEAp1JpSCKJGirGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1500
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:10:27PM -0700, Alison Schofield wrote:
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

Does not match the member name below.

Ira

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
> +
> +		if (po->flags & CXL_POISON_FLAG_OVERFLOW) {
> +			time64_t o_time = le64_to_cpu(po->overflow_timestamp);
> +
> +			dev_err(dev, "Poison list overflow at %ptTs UTC\n",
> +				&o_time);
> +			rc = -ENXIO;
> +			goto out;

I guess the idea is that this return will trigger something else will clear the list,
rebuild the list, and perform a scan media request?

I'm just wondering if this loop should continue to clear the list and then let
something else do the scan media request?

Other than that question and the above typo.  Looks good!

Ira

> +		}
> +
> +		if (po->flags & CXL_POISON_FLAG_SCANNING) {
> +			dev_err(dev, "Scan Media in Progress\n");
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
