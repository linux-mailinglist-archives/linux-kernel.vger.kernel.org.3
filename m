Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B995A0335
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiHXVQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbiHXVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:16:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F087C751;
        Wed, 24 Aug 2022 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661375792; x=1692911792;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bdER2PLYb8l2O5yw7w9YGz2oRljQPdCISLnPSfDZowY=;
  b=UIqJSORddhBa56hVkXdLFVvpJMaTZ6pXFhdWdBxOg3WplgpkqHOmq1b7
   g3LC6SXRNEnhq89BexR4DSax+3ihhla2a8v6aie8nUo6gCN8lfJsV63Ry
   r5lS2GFTEmXLyfPHKyIoo/Fm52DMKR59bR+RUcPry+j155PBVukXYUzx4
   ziNNXsCYMViorbnzek7oU4+LIF8OkP0NlxFsknE6FKaGBCik/Y+164NGc
   sp/et4AsxEydvlkhD2Kss3Vh6yS5bMM/h7ey+kFAwC/7uBAth6+qYa8To
   cUPydxt+RwdiTTij6F06j7LtrPhG+LPJHJVJsqesytlQB5v6A+KsB0rXC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291646150"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="291646150"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 14:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="670682544"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2022 14:16:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 14:16:32 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 14:16:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 14:16:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 14:16:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWjLTtgspcG9pF0Bg4opqjKnlY5tCPi/J+z7spA1RpE0P8JQWDSEBzrGz5BPefNoMb06BlBPuK4YqA0j2GdtGQnCFmhKEENV3Rg7fWORVat3f+O+/EofhthgN3lZrY1IFIehJgLwYBSpjxfH+wiKhSK59/Vmg2e5lDxxUBn+vkUHbfsDS6DWE9BqSjjvnSDDdQkXoGoLwfzLIwTlhJiO790nMI9NoktSXrQOcgWuvm2bSMfOcy2ikYiGhcRldFcv+s69kXFAREt5YcNUjtV6v8gwkPpdcnkIRlyfqyeCm9gocKAMTp4ifR5fGdOC1MXNDKF0bCaiAzUFt4BU7Eo0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS42VapdFRmg/JOuMvYEtnqQtpmhhytpI3gpIQy4VD0=;
 b=fsI7/YheI6W4KdrSqh5o+3Z0px0XngKaojeABefi0ufzVBqYE3toh0yo6nyY2k1WMpUlr9ovKdgu4aJQJt0DUSsHW/jTE8cHVZL15HAE6kAAwUVsLj42GxFXwmiCrnqZH6XQAV3imswXDemYwxA32j6NQ/KU1owF70Yny+ChOMj9/+/rN+KE+ubRW9N+a3HCdaFgrjF5kF1Z2sQsa1pXUiIGPl4kNLLQVPjQ34KJJimDd+jr/u4i098JOKiAnboQtCTHLcCNDog2rwYJJ+oohFSK0g+EiTO6AGc+odlx+TSsAT+DCANG81jn2341CcXKjeJU3qw5LqODSm8+16V9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB2713.namprd11.prod.outlook.com (2603:10b6:5:c4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 24 Aug
 2022 21:16:24 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::54b2:2db9:12fb:c006%3]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 21:16:24 +0000
Message-ID: <654433c3-2980-41a0-503f-f888d60310e8@intel.com>
Date:   Wed, 24 Aug 2022 14:16:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v3 08/10] x86/resctrl: Add the sysfs interface to read the
 event configuration
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bagasdotme@gmail.com>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166117586269.6695.16560984025494646306.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8d3207a-e2cb-4599-2715-08da8615e626
X-MS-TrafficTypeDiagnostic: DM6PR11MB2713:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvcPK5lvd+lCWj2ikHXXGHOU4FP1/CEJb4lYOnoPHeA+qXgZlqz2yrlbImXYdSG65Cd3slTZ7nesOZnQl2ERF0SkM3DJoM0z4pADHjg0k3si5tB2sstMl51IWMJ1yv8wHO1n9kcHLO6aOjPjrf8TF6ieE/5Run2/eBnNEPs/A+y0CrgvSGpKe2Q5zmF7/mndvvpgVPWo/1v+XXuxaSDi0ylJ09PgXfU2uKFBkGgL2WjBEVZDDpDRY6MewHB/I3vlI4Huo/mBD8N01JdnkoUa+fy1edcM/a87Tk+T6acJlsTkSU4xURAROTXDlEaFN/2sD0pBxTp1CFmhcciomWKrx/G43Z7W/r0s97/5YrLDrqt3U+PJpWlHDZZFfcOrTr0C8LGsVVu12LiGeL/sH/VJXc2hyAhCPd4kMd9SnFmAyHPvvGTG4KQ6HWwT+XPWGU3RNP8DrqZjyOrJKfNIrcePHr/lwxtKPPsZnas0IBNl/AtSCNqyK8l7irZY6H8AksKyR9LD52LMP/rzngUNapybQOsRQxV+5sRk6iJieI1wP1TJErRdo4FIC2aa/6cFKSWthPcnkJt2N+jKCjM+iOdyJ1WYUXwOGVBvXtTHom3cvU8D6kdT4BZmfAMcBdUk1Oei37tT1WMk4Cuv0av+iwrnN333E5fznm2e6Y5TDlB5xXkofQdcEtQwbYXMVpn08wb/UJekQI/96mbkTpwRht0k/Bc6ZJ8/Nwh46QW5kdcv0pYtgjLrnpRthmh/q3oPaatz8U8vvXkbHzdARoaRslzdYHOJFm9gWpzdgmLmTm/hQcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39860400002)(8676002)(66556008)(66946007)(4326008)(36756003)(66476007)(86362001)(38100700002)(82960400001)(31686004)(31696002)(8936002)(83380400001)(2616005)(6512007)(186003)(26005)(6666004)(66574015)(478600001)(6486002)(7416002)(316002)(6506007)(2906002)(44832011)(5660300002)(53546011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhHZ0hhanNjV0hwYVppeFdyUDhNaW9vbVF0VjBZZGNueXQzZUlJQ3JSM3hC?=
 =?utf-8?B?OEZSYS9qTk5BN09ERnVzVHhpWWxrMU9HekRxZ21ZOTFhM1U3SE5Xb0F0aHdh?=
 =?utf-8?B?a0w3SDFTK2N5UzlXbWorZnJsdlVUMkZxd0tjZzFCaTcvMWVDQ05ZZGM3NUlF?=
 =?utf-8?B?Wk56RzhSVllKdnB4T01UVG94ZDJtaUhqak1EZmxHOFN2YTJwQ3J3cVlpWnEy?=
 =?utf-8?B?TDd4YnRRTjhsSXVwNFBkbXg2NHBxTHNncEx2ZXMzWDFCSEg2U0E5T0dNQTQ3?=
 =?utf-8?B?WGo1aGdWbGlTR1I5cnJlMXNwTGJ1dC9ZakRrMEVQZEVwM1RXTUpTekxTdE00?=
 =?utf-8?B?MWVLSXg3dGcraFl3Wi9EMnBwaXQ5RThxY0ZRVDhNcEpvaUdHYlR3S1NMeGZZ?=
 =?utf-8?B?K2JicXcrZ2M1RFBVTUw5MzZ1Mmp2dWEwcGUxYzVrSTJ2QVZqVFpGV3hJU290?=
 =?utf-8?B?NVhyWWUwc2tOQVJYMEtYSHUrOUdBVFB0bjY5V0IrbTdaK3VxeTAwNEIvaXZT?=
 =?utf-8?B?ZkdXR0lwY3JJbWd2OHQvSmhhTGl6NmIyL0tvZHZWMVlRaXpjRXQweGlTeWY3?=
 =?utf-8?B?YkdGQUp2NjhLN2Y5MjBCcEFWalZHRzUzWmFoT3M0Z29CM2kyRUNhTlo1aEda?=
 =?utf-8?B?d0l5aUNFSEEybHdYd2tpVDd3SFpleWdyVDVmRjB2OWVBR3B4NzA2c085Q0Zl?=
 =?utf-8?B?bkVJSzZjTzZqRzVDU3BNUGhpcFpkMlVsdmZlendRSFNCNENtK0FWajF1eU9a?=
 =?utf-8?B?dVFSb2ZJQmU0TE42MGdDa2J4VUdGNFBJZ0FPQnJMaEwva0ZmdDR5NnFHYVJF?=
 =?utf-8?B?SWJadE95UnppbHowUktpMlI5L2lKK1BJMlFuS29oWmNuT1hOdXJMYkQwcTRn?=
 =?utf-8?B?Mk93Z2pVSVdpc0hiUko3MUgyK0FFd2pCdm5rdzJOa2ZNMjhCaEQzVGZaVWlh?=
 =?utf-8?B?eVJiU0Z3RlV2NXdEUjZMMUFBTDdxTXVWWWdGbi9TaW1PVVBSa3YwNERHUWdl?=
 =?utf-8?B?K3hSWmFwVlEyOG8zelpVbCszRWcwZVlaY3AzbHoxZjVaNU5SL0pZa0NpTGpO?=
 =?utf-8?B?VndVNU1wNVVZUHdadCtZSkpGb1hkT0lrQTBLeUJGeHBaTS9nc3pJR0JuM2RB?=
 =?utf-8?B?SFIwQ0hWMnpWVHpPT043dTFLdUYrcm9hWEZlMkt0ajhZcUxVd2tQZDVUbjBn?=
 =?utf-8?B?MUk5Z2RrbEMzbG0xaHJHYkMrZC94M3ZmaXl1YkNZTzROVFF0UWhqaU45ZUF3?=
 =?utf-8?B?b0xmWUZxZ2pjWDhza1VKZkdxZmJScEQ4bW40ZkhlbWZTbVFxbnNXMzQ4YzN3?=
 =?utf-8?B?TFdEaGQ0RHU4MHovTVZjT2ROVElKYTNJTWM3Q2dCUUk0b0h6bGFTbDdNSTU5?=
 =?utf-8?B?Mm5LMGRkVFVRQVVXdTl1NFlOWkcveXZxcm5BZ0VoZmV1KzVwUU13RVNlVG0x?=
 =?utf-8?B?cldPT2NFUVZDQkNZTXNWWGtuUkJsT2NTeVM2RFVGbXZYS1NkR0N4bTdiNVB5?=
 =?utf-8?B?NUYyM29Mc0hZVkw3U3BNUFhkcGxXM3M5YS9uZWk1ZldQSjJGcmVINHVxRHJh?=
 =?utf-8?B?YVZGWDRoUjB1SWZvZm9BK2ZMU0hOQzRjMi92QW5yOGZLNVFqa1lnTmNlTzF1?=
 =?utf-8?B?ejBUWWllQUZveldTNERST09NdnU5MnZsYWFralAxOGQ0QnZDVmZjeCtJOVlQ?=
 =?utf-8?B?aGQwMHhuQ3N1S0dxQ1BSSFdkaW1YRFh3R2JhUkkwNFhlN0VXVElqbVR2OTZi?=
 =?utf-8?B?RDROYzJSTTFaMU85M2RoU1pCc2lzekRmSC9kNG9ZdTgrNjJrU2R4RE9rM2NW?=
 =?utf-8?B?ZUFNTElTUE8xYWVqQ1UvcDNyL2dRUThGQTV5ckRJaktscC9EeXY3YVdJeVJN?=
 =?utf-8?B?b0RQdGdEZWtOY2VpeXNQcUI1ODRMd3QwczhEVXV0RDhma25ORk1PTWl1bWlH?=
 =?utf-8?B?UEVlSzBRUE5RamlFRmE2L3lXbCtKWDYxZnNCUmtKVkpaS3hUMjQ2R2w3cFhl?=
 =?utf-8?B?YjRyM0FnMnNnbXErY2JEQnNrSHJvOUF5QUI3MWxKTjAyVmp6VXVkQUU5YXQ1?=
 =?utf-8?B?RzBVSDNnS1lIb0VGTjVaZlpDOUdXV2UxdEtFYjUxdThCSC9kMHJvT21XSko1?=
 =?utf-8?B?VGxlVFU0TVUvOXRkdmdiM1g3cE5pbEhoMEhBUk1nSVVWdCtadVFvWFBCcDND?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d3207a-e2cb-4599-2715-08da8615e626
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 21:16:24.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+eY6lKaxLfNtKVYXgTNgJ7hzplET5FR2V96jlcrkSFlGlwVCtN6tCuweGRu5rK+5hrkT6WbN2TbX/YlrM7R2BtI5g83O/JDzaQQPy49qOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2713
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/22/2022 6:44 AM, Babu Moger wrote:
> The current event configuration can be viewed by the user by reading
> the sysfs configuration file.
> 
> Following are the types of events supported.
> ====================================================================
> Bits    Description
> 6       Dirty Victims from the QOS domain to all types of memory
> 5       Reads to slow memory in the non-local NUMA domain
> 4       Reads to slow memory in the local NUMA domain
> 3       Non-temporal writes to non-local NUMA domain
> 2       Non-temporal writes to local NUMA domain
> 1       Reads to memory in the non-local NUMA domain
> 0       Reads to memory in the local NUMA domain
> 
> By default the mbm_total_bytes configuration is set to 0x7f to count
> all the types of events and mbm_local_bytes configuration is set to
> 0x15 to count all the local memory events.
> 
> $cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
> 0x7f
> 
> $cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
> 0x15
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |   21 ++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   70 ++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index fc725f5e9024..457666709386 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -15,6 +15,7 @@
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
> +#define MSR_IA32_EVT_CFG_BASE		0xc0000400
>  
>  #define MSR_IA32_QM_CTR			0x0c8e
>  #define MSR_IA32_QM_EVTSEL		0x0c8d
> @@ -50,6 +51,26 @@
>   */
>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>  
> +/* Reads to Local DRAM Memory */
> +#define READS_TO_LOCAL_MEM		BIT(0)
> +
> +/* Reads to Remote DRAM Memory */
> +#define READS_TO_REMOTE_MEM		BIT(1)
> +
> +/* Non-Temporal Writes to Local Memory */
> +#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
> +
> +/* Non-Temporal Writes to Remote Memory */
> +#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
> +
> +/* Reads to Local Memory the system identiﬁes as "Slow Memory" */
Seems unexpected character slipped into "identifies".

> +#define READS_TO_LOCAL_S_MEM		BIT(4)
> +
> +/* Reads to Remote Memory the system identiﬁes as "Slow Memory" */

here also

> +#define READS_TO_REMOTE_S_MEM		BIT(5)
> +
> +/* Dirty Victims to All Types of Memory */
> +#define  DIRTY_VICTIS_TO_ALL_MEM	BIT(6)

Is this intended to be "DIRTY_VICTIMS_TO_ALL_MEM" ?

>  
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 30d2182d4fda..e1847d49fa15 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -254,8 +254,78 @@ static const struct kernfs_ops kf_mondata_ops = {
>  	.seq_show		= rdtgroup_mondata_show,
>  };
>  
> +/*
> + * This is called via IPI to read the CQM/MBM counters
> + * in a domain.
> + */
> +void mon_event_config_read(void *info)
> +{
> +	union mon_data_bits *md = info;
> +	u32 evtid = md->u.evtid;
> +	u32 h, msr_index;
> +
> +	switch (evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		msr_index = 0;
> +		break;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		msr_index = 1;
> +		break;
> +	default:
> +		return; /* Not expected to come here */

Please no inline comments.

> +	}
> +
> +	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, md->u.mon_config, h);
> +}
> +
> +void mondata_config_read(struct rdt_domain *d, union mon_data_bits *md)
> +{
> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, md, 1);
> +}
> +
> +int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
> +{
> +	struct kernfs_open_file *of = m->private;
> +	struct rdt_hw_resource *hw_res;
> +	u32 resid, evtid, domid;
> +	struct rdtgroup *rdtgrp;
> +	struct rdt_resource *r;
> +	union mon_data_bits md;
> +	struct rdt_domain *d;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (!rdtgrp) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	md.priv = of->kn->priv;
> +	resid = md.u.rid;
> +	domid = md.u.domid;
> +	evtid = md.u.evtid;
> +
> +	hw_res = &rdt_resources_all[resid];
> +	r = &hw_res->r_resctrl;
> +
> +	d = rdt_find_domain(r, domid, NULL);
> +	if (IS_ERR_OR_NULL(d)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	mondata_config_read(d, &md);
> +
> +	seq_printf(m, "0x%x\n", md.u.mon_config);

Looking at this patch and the next, the sysfs files are introduced to read
from and write to the configuration register. From what I can tell the
data is never used internally (what did I miss?). Why is the value of the
configuration register stored? 

> +
> +out:
> +	rdtgroup_kn_unlock(of->kn);
> +	return ret;
> +}
> +
>  static const struct kernfs_ops kf_mondata_config_ops = {
>  	.atomic_write_len       = PAGE_SIZE,
> +	.seq_show               = rdtgroup_mondata_config_show,
>  };
>  
>  static bool is_cpu_list(struct kernfs_open_file *of)
> 
> 


Reinette
