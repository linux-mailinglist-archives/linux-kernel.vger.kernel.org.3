Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48994F4F57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837517AbiDFApx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573264AbiDEShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:37:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF69167E3;
        Tue,  5 Apr 2022 11:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649183746; x=1680719746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MT6I3YPSEwldDLUU27GJKPpq1nHc5eQLHgerA1jxmFA=;
  b=NWG6icWj2VZA3Kyax0c799/cFsztqQM8S7d65yZRIGSJnvyYnXZzSnx6
   I+RQoFO8MVGFq2LGO6m5M5v1mi0BjIqTQv2YgnNcWwBbBa3QnFxxDjaYA
   IXuJ93Sse/wI9E+b1yaBbdRN1n7RUMcBWfBKWX04uoyn7nBbWlMbDxx0J
   msr9SGnDDhjNallbR3vhvG8zOy17kKaQQvwtu8LPUGr2Y8LaL1WFt2g1k
   afBbaXFpHHa2OyQivWKsG/H3GoLheVjpwiAFVmqD1cpuLcFUDYicd0Fvs
   RJJS/NRAnpCSrdlV6rX4yrk16bd3AU8FsJNfBMgXHgQvIqXIyboxg5zzV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="242976148"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="242976148"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 11:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="549174274"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2022 11:35:44 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 11:35:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 11:35:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 11:35:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 11:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6G7KGQ+hTGZTdLsdMvC7PaPRABYKAtKdyPlTsX0PX5bQ3nUcKx79GYuzV3yIDgQ6ZwDonimtqpZ3WrbnhkJYF46vUrgan8yL4Y+bezCP7jp918wkQURk/fCNkje0ZY2fUcf7m2JTAdAEatsXw4EdlL3CrlhJ+7bvHJIQwPyuMje9tQQ9axodiNxqLf03Ra8Xp6urN7T0iqpXr/2E61D5Pu5p7RlallRPM638eRgKB/V4GSozWEXdLX7uyA+VheZD0N57onXTmXsZnFrS3q/0uJH+v/HSfEP/T4/DP4t9+GC2DjekI9wRNeRg4/WOpF+dMoQJv/KcyMyvQgPyw0R9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PtstC5LjuRvDhiUMBF2T9EIgJjTIwrj1mMH5YLAWYY=;
 b=PSBz7bUZNtWWh24WNGQsSv36ct3py2hf67Mtq0mhlCC56zQjCKdoFSO6A1mbOIENQSmDkNv6cDDwOFao28zpza+UPAbiOBHgo03p40QldUPo0+QaHC1MhPUqo49DsgeSp3Hgoah9Odp/jtXYmOq7IRZIYv3EnHwH+5RbPETWz5oiF7S/Il2lfJZRA2hofzDWYqw7GFzOujgKOiExAfFaTyWEbzhNcIhYXxSDqcftEdDtks9LUEJylKpBhKik+8XBnHooiNXFQIVEsbwgdrvsEBJSJM62uhP29n/4HcYAyN81fx6qarPRgOQvW1y4RVby4wg88ka2RhDOtlezQl1pYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB3875.namprd11.prod.outlook.com (2603:10b6:405:80::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 18:35:42 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 18:35:42 +0000
Message-ID: <a78166b3-4e99-89c7-c435-d42bd94e9536@intel.com>
Date:   Tue, 5 Apr 2022 11:35:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH RFC] x86/sgx: Simplify struct
 sgx_enclave_restrict_permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.rog>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220405151642.96096-1-jarkko@kernel.org>
 <76c6e673-71fb-1068-0114-c3eea93a2fd4@intel.com>
 <13a43c8d9e9d103009e652e7e8ff49e6844316d5.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <13a43c8d9e9d103009e652e7e8ff49e6844316d5.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:303:b7::18) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504ef9cc-bccf-4b46-a299-08da173316e2
X-MS-TrafficTypeDiagnostic: BN6PR11MB3875:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB387520757558D19F229FF096F8E49@BN6PR11MB3875.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPvhdmQ9yjFCeSLvE0l9GkyN/Zp6jolVv/64sBzaMEW5mWcaVlWWhmZlqCsHp3ulhOiTPj29x90c8wF50TV6kdhKBtK1E6sBGl7IOw05JfhWivCVLpzJXBxwG76eESZHMcoHsF5D/IwfvbquopUh29zFAFHujaiNcXTJ23m025zzylNOX3aHl3hdwaPKU9rBOmXgZywzL2vJhwkf6JQWgvHDMDJ9F6LElfmB60XxoRXKVxuf6V5KzK5bc04BQC57sBO3M7u3EpssqSsZlGTNWqNkse07tV23Z9J7Ol51MuhLQliKDk0xELV2zHZC+Z2wr01ndSFmxVlvxyge1+OHxn+BxIB2/QJ6N5An8RzUxM33hjGeJbfate/Q0emL/pgHTy1AC153pd/hcOz//RBwMbpLSqHlbUuKdyjicINl9p1wjOFSarSK9VQTqZNH30xh7ZYau7rHgpRrAduUwQZ264Qsd92nlSB4kiXMBYPeGRQ8PdJrb9k9ft877658JEgTaeKQpT2t4qeQaphwkTPOYR6l+mCJK5xueV1aQtecL+TZk5SOKCEQ9V9IjLUeTtMajhnY+Pg3VScioNFdKn/koVXnJfciYLCTsuAjaMAG0TSIhbh+FrRoO/O1cdhq+Q0n+hIsBciTDx1ocf0B4MBU49HFbPpaFBTA32JpR8fDr5nb8DKSCVPP9fY7v2JuQSY/Ks+9bk2L25vlRjUdbDRWrhfg7sgXz//5xb1HaX5p60yek8P99RZiq/2kkCrUiWPW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(31686004)(2906002)(38100700002)(31696002)(86362001)(5660300002)(54906003)(6506007)(508600001)(4326008)(82960400001)(8676002)(6486002)(36756003)(6512007)(2616005)(316002)(6666004)(66476007)(186003)(44832011)(26005)(66556008)(66946007)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHB6RkpTa1c0ZnlIM3YvUWJOczBVMlBZOC9TbnBpQkdqUXgzaXgwWlNacEc3?=
 =?utf-8?B?OUlDcXRuNGo0QnJ0czdhcVlvRW5sLzdKbzR3MzJ0L0kxRzBQbXd1dVRjdklJ?=
 =?utf-8?B?SVBXYlhmVnJzc1JpQTJzT1k4VHRLWGNXYktNUTVVN254NHUwT0N0djc3b3VU?=
 =?utf-8?B?ZkxQTnJsWGVPeE56bmgvUkt1M3ltUFRyMWFramJ1RVpvNERzeHVXZGlLT3dD?=
 =?utf-8?B?ZDhsa3U2b0dRL0JqYmtsN0w5SWFEWE1sMml3YzdQWWhnMk9Ua1I3Qk0wSFZn?=
 =?utf-8?B?TCszMDk1bWQ5UnRLZlJFMGxCdWpuNEdwYkVTcXJiZ0VqQ2N4ZjNHbk5xUTJQ?=
 =?utf-8?B?OWxIRFdVZUpidk9UNXk1QXFmWkJZM05LRERMWVBHcU5ndTZwaXMvaE4vc3dG?=
 =?utf-8?B?aWh6LzJjOVZSeVZBNHFReEQ0U1VsZW04d09iWVhEb1pRNUtweGpqR3cwSjQ2?=
 =?utf-8?B?a0Mrd01mSzFXU3NhNGtaelllOGNzQldGRGlGbU1Na1F2cDlzOGJGSkJKMGZI?=
 =?utf-8?B?VE1tZnNkUk04NlM1MklZK01ESHUzMmlwd0lHeFZoaEZUUFVCSWpESlZtTjR0?=
 =?utf-8?B?S2NUTStac2QwTHc4S0RRdTJtbTJaMWxDeFZ6SVNJVHhRT0Y3TkVuWDJQVlNU?=
 =?utf-8?B?bEpObjVoZFI5Qm9ydGFlbGVueUJITTBPb2pJQWQ2TXNxcXRpU1NZUzF6YjlT?=
 =?utf-8?B?TFU2dmxRT1k1eGdielMrclZocG5icVJ0QnhvaEU2aTdvVStkOXJ2cFl1dnh3?=
 =?utf-8?B?T3ZOSm9IRmMxdE1OUWRJdm0xb2JuOXpRQm5xU0hLOXZTU1k5Vjl1cXlHOUdG?=
 =?utf-8?B?Z1RZOU9rM2lpTVhZdmVJVDIrUXBxZU1GZjlBOTY0bU9YZE9nV3NwQzhHOFNO?=
 =?utf-8?B?cW1oZkU2S1VDMCtGN2ZBT0VlZWU1elFNTkova0pwS0xETG1pRHE0VXprK3ds?=
 =?utf-8?B?REhnRHFON3VWcWtNTi9FanlKbFkyTDRVZTV4NHJuNmhXYXBEWXZEVXMwUkth?=
 =?utf-8?B?blRyQi91N0w2TEFPS0JUVDFBcmtpSFF0ODQ0S2xsUkRnVFdDT1dJbk03Tmxy?=
 =?utf-8?B?Wk1lVUVhOUx2bDF3akUvbENsanRTdXA5Z3ZkaTdidjBWN2grQk5hMzNEL29M?=
 =?utf-8?B?U2R0Ukd1OHhuMzAxeFE0ZFdmaVNxU2FFRW5oRlRKd2ZrSE5JM2hUZ25lbTFV?=
 =?utf-8?B?TmN3cm5sNXBWTUk1NEdlSVBrVnJ4bnZXWXFnVmE3aFJDRlVKQ3RkNnhpUlNX?=
 =?utf-8?B?aTlTd2JXQVI0MDBsS1JKam1Zc0ZQanRPbEFncXBtR0ZqeFJTeHVScnpDcnBa?=
 =?utf-8?B?b3A3cUxNTncxZ1FiKzY4WUVXYUhjUW8wUDBxcC9vY200N04rVDJ0TkpNREsy?=
 =?utf-8?B?a0RZSEVQbkMzNXd3RGM3Mlk1S2JMRmoxekNXRDVnSnN0MitYZ2J3dGdCbjZh?=
 =?utf-8?B?Szh2SDR4bmJrTGNVajlycWZpVjFTVlM3RGl0aXdySlVRdTVHeGFvWHBFZUZx?=
 =?utf-8?B?R3JPcm9zTWp6UXhMc1F0TC8yTXhpZzZMSTI4dWdueWdkenNqMjNtYWpLTEov?=
 =?utf-8?B?Y0ZBZ2w1TXNvMTdOMCtkVGtGQ0FTSS9hSDZBSjJQUFFjcU9jWmN2NytBdVIv?=
 =?utf-8?B?WE5tT2N3Z2V6THpoOTFZN3FHUE5Fd29uMGF0cUJOTStLTENsK2RiNFlEd0xE?=
 =?utf-8?B?bnRXT3FKamw2SEpqY0s3WjVmR1NhL3h0WGd2Z0thVzJZRGxtRmsrdzIxS0Uv?=
 =?utf-8?B?SEN1cGVBdjhBdWRhbkZrMG5XbW9lZWVrSFMrK09wam5aUjlMOEV0ZjJCMm5T?=
 =?utf-8?B?VysrK1NyT1M4MmJuRStuL3ljbU9YWXhMaVQydU1TT3ArYTY0R3IxSVdUM2tW?=
 =?utf-8?B?eWZjNXhMTXMxUTlxUHBPQ0lCNi9hUUxkanc0aitCdFZvTkJUSzhUVVRRb2kv?=
 =?utf-8?B?R2lLWXhPNDV4d2k3amFidWRQZzdNaG8wdXhkRkU3a09lV2VKZVFhU3F3YXBE?=
 =?utf-8?B?K2lhZXNYZnlWbDdya2tzeVZOZThZVkkyMDN1ak9yZTVCWmZmWWJ3NmJpd0NI?=
 =?utf-8?B?cVMrcFQ5TURIZ0pEVy9wVEdHME8rOXhkbU5pZDU5OHpQU1owVDZxeXBOVC9w?=
 =?utf-8?B?d0JYaE1wa05CdUFabWtMcnBOejFnaDhsekk0MW9JS3dWWUJ1UEdVUHlxd2Vm?=
 =?utf-8?B?V2Mvb2xydDUvVTJFSkI1NzlXd0F2U0NNY01Td0pSc0VsMXBFR25hVDFTaEVC?=
 =?utf-8?B?cGQyVStFQzJCRWVWNlpHUXd0azd4QkRzNHArRzd0K2FkQlZXeGx2UkZ0MjN3?=
 =?utf-8?B?TWpsazdCck50WGJVMlN6Zjk2R3duajRtZUNvTHA0K3VuYXlmU0dxbGpzMUtO?=
 =?utf-8?Q?6gTjNAukjpvEHoDw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 504ef9cc-bccf-4b46-a299-08da173316e2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 18:35:42.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oh2m3K3MUYoebY7/3kHW0sTtATCV8unDiuwQACKfUpu3ucGPOBAGFHcwUX/cTby7OZeWaSMNlHMXSGkRZjRgv17N5G2KI3YQvzWZHhln+y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3875
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/5/2022 11:30 AM, Jarkko Sakkinen wrote:
> On Tue, 2022-04-05 at 10:21 -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 4/5/2022 8:16 AM, Jarkko Sakkinen wrote:
>>> The reasoning to change SECINFO to simply flags is stated in this inline
>>> comment:
>>>
>>> /*
>>>  * Return valid permission fields from a secinfo structure provided by
>>>  * user space. The secinfo structure is required to only have bits in
>>>  * the permission fields set.
>>>  */
>>>
>>> It is better to simply change the parameter type than require to use
>>> a malformed version of a data structure.
>>
>> Could you please elaborate what is malformed?
> 
> The structure that is accepted by the API. According to SDM permission
> changes are done with a structure where PT_REG is set, which gives
> -EINVAL. I categorize it as a bug.

I assume that you are referring to this line from the SDM:

IF (EPCM(DS:RCX).PT is not PT_REG)
    THEN #PF(DS:RCX); FI;

Please note that the above tests the PT bit of the EPCM
entry, not the PT field in the provided SECINFO.

Reinette
