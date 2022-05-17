Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C7952AD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiEQVX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiEQVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:23:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D155372D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652822628; x=1684358628;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H7Hga1z8fxhYEgEgA1pcNlM32FSpt3ExQr18F352NrE=;
  b=CeI8Coqn10fxoEmM59M7XkOOnw51QtvaurLr3RO7g2pDEmL9MbBOdJ9d
   yYI9gNBFz4WsFmqELmoi0+wD9XIG7QITV62b7mPcQJqAxLfaVSmfE8QjZ
   FUEwg5rbrMBdyhvW5h4o4eP01Pt9/daE0Jq3CcVBxXdA8duaURpW4ifhs
   Om0Y0AGqJtJLELXmYmbDo52jgX7OpujmUbTczkkocEZuaj5bTX+09CmKo
   neAEUXBAbozhiVs1JPyKyePXr2vD7fn4H5Q6chgogZjWzklRK/G2I5rNN
   FU1NnsqaXtufsDWi7ruoOSOTIJCBAc8BkMXoq6owZo8Ys20JwSalGsg1m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="268922577"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="268922577"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 14:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="569101656"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2022 14:23:46 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 14:23:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 14:23:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 14:23:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 14:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2hfySaW46TRsjfrastoREflSVkRRU2HewJlJUZkNeXR6KBeKRxy8l+gO6176vNZ5hM4ikdfLc+RxkNw8lBNV6q/YbHFi8elqSdtwvOxV5KMymP8bIsKjVWUM7DOk2B4VV6cjwuUCFmxRRdKu1xI0oUN9Dr77//0F0rjstkJZqVkBH0AJ/Y39sZHItfWFeWPDZ94TR/ntL6pADd7/4Ahqd8CSazt94c617P0iCm8nU7yVQ3FYmJ9op8g7KSNY0AooIEpEV4VKIm26UktjFkTs1/7yosROjIFTNuTgnaZOI1gcgpUm1UGzwPR7wovNfzFaYJAKucPunUDYZD5tnxDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrrWPL1nW47+EZU7UhBXGNknLRKr73S/KJdAAfvq4rw=;
 b=g13/JJRyN7LgPmdD2DKJQ61P+RlRAZsAKpeWYf4ul7iwgIRAv5AH51ORpHR4QuZGlvpYSiz9srGfEk1gvte+gfEpl1B7TGR6EW4Its+TEJ6L5ZYrIgiYav1JsIR64cU+78YTB9KFIWgdjwxiwW0+D9+tXmixlIpJK3cGLU9d7H2qIs4ovhQpiKuuEeBI8WWhsBNfhtOk3eHfjEB/Nen5RPqNmKrzR0BVpBE+KsqCF/wgJGqm5TAHjT8pgLOYqKYWSpv2kl6fVwtixiEY3FwFOtKEy/RD2jkaimhLhuMQpI4BXYbJzKOiZ/IhrDZ+UHbrKy/faHqWuULjfKdGZWNR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM5PR1101MB2202.namprd11.prod.outlook.com (2603:10b6:4:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 21:23:42 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 21:23:42 +0000
Message-ID: <7991d014-6190-de87-9310-9b5109193519@intel.com>
Date:   Tue, 17 May 2022 14:23:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v4 19/21] x86/resctrl: Rename and change the units of
 resctrl_cqm_threshold
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Xin Hao" <xhao@linux.alibaba.com>, <xingxin.hx@openanolis.org>,
        <baolin.wang@linux.alibaba.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-20-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220412124419.30689-20-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31cb45c0-cde9-4e5d-06e3-08da384b8461
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2202:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1101MB22028367B4380AC0603286DDF8CE9@DM5PR1101MB2202.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77w67Ss4xYPHdu2zDjABYL3EhHi/Mmzi74Sxrm8360+f2RWc+QPA8sbYj55FVSu7XDgLK63qCvcHI7C1JsZ6EK9EfMdVCfAnewj6UTDRqiiZx4x5KHo6o7GGFjv3wf2ElMs6M0qD1lsVubGhbls8XBfT89cfOCKBkrhVuLJsOCCFvJ2Z27EHt9YiCqpVsdG/oG1aY98iYIXBHIP/PxQ98pENmuZLM7Whe35GW9ytUJ1Spy+hPOP2XJ4ixEmuq1i35yFRUEDQEt3nP9X5kxerTIxqwjXg7VxFrfr03tKPiWaN0rUuIyK150c0F6G9KdSlFpl/qcxH5EBJgGU/dH1hF8pu94bdmTnEruAUKdn1dK1XPJju5MT8uRQxfkULO0gus2Szncj8dttbfdoVNBB/4Gl0O25TeRAbkPrGehyhqU6iVWRclTfUnzi4fUbX4UzBdekukMBBBCmF7Trs8lZccwPysWrvAN/SXVk4E2PXxSJJlAZvPrgLlnCr3J9vjcu/MoXi7IxXiQQYntRt6nGdbD1ljQSzZ8Mqu371PVMsQdSvkrIiAEXEyXGPYkqgMQkIDiLGN/2ATD7NzHXIFIPQ6bllEWp/eOtoTdwhYKh+t6NH2f+ZeB0ADitAt2ZsFLPrCjEe4/JON92VmEDT8gy1sHp80WE/jc4hjFCJ8ggjV2VsOFFYu2K+tw2s0h3peH4CiAOAilod4mApLGmlbN5YqsR8nJEzrRk1cIW4de7RD84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(31686004)(5660300002)(186003)(26005)(6506007)(36756003)(53546011)(66946007)(44832011)(2616005)(7416002)(8936002)(316002)(66556008)(54906003)(66476007)(6486002)(2906002)(508600001)(8676002)(86362001)(82960400001)(31696002)(4326008)(6666004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnArNlVRb0xlcFBZQVMwdUJMUTN0WjNQK0ozTDFxYk1RSG8xOHRwQXR4TmpT?=
 =?utf-8?B?SUk1cFpvbFRBTk9IeXU1eE13S003VjlMY2w0L1Ird2RGZXZFVEVNSzVQUlgw?=
 =?utf-8?B?NStCSDBGZVZJa0I0aCtTeFhOdHgyNk9HTnY2U1pWVGFTRi9WcG1kVVhXenFv?=
 =?utf-8?B?ejh1NGNDbStWVWFSb3VGZlp1aUk0RnRJemp5K2d6L0dhM0gzZkQ5Qk02S0po?=
 =?utf-8?B?UVdieXRlTTBaQ3gvK0FNZm03Z2xHV2hhQ01GTVBvdldiQUsrMXFraFEzdTRP?=
 =?utf-8?B?Zm5ub05LVU1ibXFKbGxVdkxrYUtKSXFTeFcyaEZXUTdRTG1aa0doYlJjK2Rp?=
 =?utf-8?B?S0hhNE1Lc09nTXZYc29MR0c1cnhhMy83bENUZDBqRDcrUGdWeXlRb21ab1BI?=
 =?utf-8?B?QWFvV01wNUFlS2FjREcxbGlFQnM1czhMaUtWb2cwR0dvU2RmTkJyVUJFNXNC?=
 =?utf-8?B?eVB6OUVXV1VJbXFicmtlcDdWZHEySEx1NlF3U09sZkwvNC9pVnFhcjJtZmo1?=
 =?utf-8?B?bmpWMjZMK3N2UUJ3Yzl1RVNqRG9FVStYdWhsMHNpSEVYNTZlVVVSRnMvZ3hU?=
 =?utf-8?B?S09ndDhlSXE5VXNqNmtvNElsWHQ4TUhiSUdwNFErdUI2c0g3MEQ5MzBaZlVW?=
 =?utf-8?B?VjZTTHo4RVY0elNDU0c3T25pSXpJYkNvQ0FRQnhiTnlDRkNnMnhyZXFxQU5o?=
 =?utf-8?B?N1RQbWNxeWY3MGRSaVNHTlJUZVppN1ZOWWN5T0d4cTU2MWZVZkljRFJiZnVY?=
 =?utf-8?B?aitHSnBaZ3UyczNYYW9HQ1dHelFyd1hMWTZkODJZYWtjL0xNb1N1ckI5QkNt?=
 =?utf-8?B?VjZobTNFKzAySnQxSlN4N21NMHZvckE5N2N5Mmlrb0VJeENidHJMY0xkWFlK?=
 =?utf-8?B?VytQeXhTRlJTRGdWSytjWHNMeTd2VHkzVXQ5UzNvN1lPREhOZG01TVc0TUpE?=
 =?utf-8?B?MzBTd0FEQ1NEZDlNSzJDbWd6SE85VjdVQ3l4U0hmSm1ySk9BY0ljZlVwYmM2?=
 =?utf-8?B?bk1LV1E3NVNGWGpGb3N0RUp0NTJMbXJVMmFvaG1zSlNwMDlzYVpsOFpOSm81?=
 =?utf-8?B?SjhOM3ltNEVlbnR1RzU1aHZxQ01pTHpvWjNXbW5OOEVsYXJGTThCY09CVFZm?=
 =?utf-8?B?K2gvaFZrZk56NDFjOEhRNzUvR0Fka0F0ZWJBQXRxelF6bEF5NUdoMGJZbXZq?=
 =?utf-8?B?ZXc0S1VNNzZJNVRoV3gyMG1tZXF4eUVqQWNHOWhZSzJDNmFpVGFTWFYrdW9o?=
 =?utf-8?B?NGlhb2VZQUdDaHZsUDVsK2NTSitaNm0zeE5JMkZTV3pIc0NMbUc2M0FERTdq?=
 =?utf-8?B?c0pTUWxEaDk5bWxZb1IxRmxqTmxpalUwWEhDY3RRTWF4bXgyaHVZVjJKNnRI?=
 =?utf-8?B?aG5nZ3MwMTBuU0x2RERzdWhIdzlXV2MvamhETTRzT1hnUHRjNWY4ZXMzVGdp?=
 =?utf-8?B?SFJwNDcyT1MwZmJweWRnZVEreEt5VWU5MWljY3Z4U0xITE9hNlgyM0I3M3Bi?=
 =?utf-8?B?RWlrTGFmOFpWa1l1L0QyaFhwcjZCaVZhbHR1ekYxTWxZK0hralJPbnhNRUlt?=
 =?utf-8?B?OHlhSjcvbG1FYXZndXVZMVd3d2l0WGhlK00ramExQSsyQy9IanR5OXhobk1X?=
 =?utf-8?B?cm5IbG55L25tMnpPTDM0eVpVUXRIdm1tQnJjRW8zU0ZBbmdCNHhpVEZlV3Y4?=
 =?utf-8?B?OVJhclZUTXkrRzdjRVlBbG9DektHR1QvaHlCNmdXL3JJNVhZN2NrOW93b0t3?=
 =?utf-8?B?cE8zOWgwWTVFcUEwSXFRMTBwR3J1blRwTlllalRtY0o2MnhTZ2U4QnRpWW51?=
 =?utf-8?B?amduYVE3L1dlUUJUdUZ4aEZkSlEvVDFBN0lQOUQ5eU5ZOW1PM0pKeXBvQkZ2?=
 =?utf-8?B?bW9TREUybGsxNUROOGQ2UGNRZklJSTBJVGlMT0RPemNwN2pEV2J3bWV6Qis4?=
 =?utf-8?B?UEk2b3NPQlU4bEZabUgzdDgzdjh6TUU1RVVDckd4cW9kRnhxQ2RNbTBiNkc4?=
 =?utf-8?B?NU1CMVhUZ1VJcmZUeGc5aDhwSnBueStDYkJyT0Y5ZHkwQzMwYis5Q3Y3QTc1?=
 =?utf-8?B?dmlvc3g5amkxSnAySFBwRmt0OHZjWnB2aitJbFBvc3RyeWNCZnFpU1FIajYw?=
 =?utf-8?B?MzliME8rQkdKTTZyb09GSGQvRmVCWVB5UzV4Um5MM3FicVlZdUQvaC93azMw?=
 =?utf-8?B?ZGdQeXd5S3V5SEV4bnJycTlyUXN4dTZIVndwSVBZUm9oa01DYkUwczJrUWkr?=
 =?utf-8?B?Z25YM20zb0tWcCtKdmxNV3kydzZqcVI1cmVpWmV6WEhtcHhvYUF3MHdmVmt6?=
 =?utf-8?B?SmdKdVFsbkpWVVhscDlVT1EvMndib0hjN0Mya2RYckU2aXJ3c1hjZ0FVSFQ3?=
 =?utf-8?Q?Mr+i4DADtBERcNYg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cb45c0-cde9-4e5d-06e3-08da384b8461
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 21:23:42.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsMKUmi9PGsO8PVmwprIeYTeha1St+mmJuJ5y8xBwPUQsNVP9OBre7dmRaM+cFl7+mRen+onZgaqp3HX6MXMu3CBMai6052DT9Au4TwBb6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/12/2022 5:44 AM, James Morse wrote:
> resctrl_cqm_threshold is stored in a hardware specific chunk size,
> but exposed to user-space as bytes.
> 
> This means the filesystem parts of resctrl need to know how the hardware
> counts, to convert the user provided byte value to chunks. The interface
> between the architecture's resctrl code and the filesystem ought to
> treat everything as bytes.
> 
> Change the unit of resctrl_cqm_threshold to bytes. resctrl_arch_rmid_read()
> still returns its value in chunks, so this needs converting to bytes.
> As all the users have been touched, rename the variable to
> resctrl_rmid_realloc_threshold, which describes what the value is for.
> 
> Neither r->num_rmid nor hw_res->mon_scale are guaranteed to be a power
> of 2, so the existing code introduces a rounding error from resctrl's
> theoretical fraction of the cache usage. This behaviour is kept as it
> ensures the user visible value matches the value read from hardware
> when the rmid will be reallocated.

The goal mentioned above does not seem to match the changes made to
the code parsing the user provided value ...

... 


> @@ -1066,8 +1062,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
>  	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
>  		return -EINVAL;
>  
> -	hw_res = resctrl_to_arch_res(of->kn->parent->priv);
> -	resctrl_cqm_threshold = bytes / hw_res->mon_scale;
> +	resctrl_rmid_realloc_threshold = bytes;
>  
>  	return nbytes;
>  }

... originally resctrl_cqm_threshold would take user provided value and adjust it
to the mon_scale but in this change the bytes provided by user space is kept as-is
and would thus no longer match what can be read from hardware.

Reinette
