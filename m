Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191684C04C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiBVWkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiBVWkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:40:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99312341D;
        Tue, 22 Feb 2022 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645569583; x=1677105583;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2gY5AnKItuyqmCRkgIkLnKBhSSDXNaw4Nr3hrxNX4QI=;
  b=E5tFtH2l8nALMkbBE/+93moPC3i9DaXge/sJF8sTl+W1Y30QdLDWZt4W
   5Z3gkPoTW5tmFKrYwlNM86pqRPlKHoqv+oFwc82VXnMHctFG6ylGEVKaR
   4FZCpI37uKm46XIg7XAwN1NuyUJ45sKUsP6mdxMA3sCPeJc+BuMRbWx8z
   KgiUMEuoovNqV82iHRuErY2Ior1lRWgsEwCuUIVYou6HjHbrWMRwi35c9
   6mXCxvFHAqhHd1mud/VkpiPRtaA1LQxM/raqk1tAk9bHbgCBiEuwABKEs
   khASBN5jY8bR/Tg2jpK8JOaKoD3gw1VS30HZbu86siq4JJmQ8Z66NfVI5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232452600"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="232452600"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 14:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="639080024"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 22 Feb 2022 14:39:42 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 14:39:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 22 Feb 2022 14:39:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 22 Feb 2022 14:39:41 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 22 Feb 2022 14:39:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga2WJbKGnjCT/+r6OiKZr3zrJRdqgb6uXOjsoNmyZIoefVXN5X36jgpUQWwEMbHx4fvM4U4IpTLqomiT2OIT0j4zKYmOUu6SUZ8nWt+ZqjwGfyp+NAnUwA9dASneWuJsdLKxybEVPFj/ZA8RV2NFLoAC6jH1siSAc6T5KVozKywQxHdjMajvmSKzxtIMr4VoAta1OnQzkQ4cFw/Mid/6MFCnSmmobir5+dGa6IVa9yBq5rUjQVCg3QXezzI3owxIqh6eyFwxUVtPxkgln/HX3wzqQ95VoxnRMQ3OFXwGRVUXfU7PpWTFGYkosAE3H5K1j/e9294mv9cXg8fBkwJ/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0ucADrzuF/BXYc3d3FHdQzOp+/AGl3fLiTAoE3K5SM=;
 b=PkeM0mjVfPrXa2lA3Ajj0YO53zDMnBN7MAlsA5rWfTn84xml6tzRNl7Nx7RbDoLwh9xk4gizTickxtSsgIFRK48BHcm+zLzL736+LcHa9mAPqXy7zoGxim6fY4WFMWx5MQnVZsL+9DNMe1nBP8aV6+ztboAUjSYMfqMw963Av0osuzrAuBKRXDP2OxKs93mAOVRLnt82bqeSZSN/oQQUEZ7Pm+QjaOMcL91an67isG0dl3VffC2NARVppGZrCvMttUv/84UxR8aD0K0icC7v0psveXgIlkozn/TrvW0J3uo13+wtYGMcOBXsm7oYaIksD0hIEtGi19VVQmXr8slgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3843.namprd11.prod.outlook.com (2603:10b6:408:88::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 22:39:38 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.4995.026; Tue, 22 Feb 2022
 22:39:38 +0000
Message-ID: <86495779-a9c5-45d5-0017-c491bf6354ab@intel.com>
Date:   Tue, 22 Feb 2022 14:39:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH V2 00/32] x86/sgx and selftests/sgx: Support SGX2
Content-Language: en-US
To:     Nathaniel McCallum <nathaniel@profian.com>
CC:     <dave.hansen@linux.intel.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <CAHAy0tR-64vxtFo4KXiJP_va2=WF++Q6gDaPksNxiaSB5wWvhA@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CAHAy0tR-64vxtFo4KXiJP_va2=WF++Q6gDaPksNxiaSB5wWvhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:303:8e::24) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50325e33-0fe9-43f2-ce89-08d9f6543490
X-MS-TrafficTypeDiagnostic: BN8PR11MB3843:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB3843E80DC57F47C22801E5ABF83B9@BN8PR11MB3843.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54gEw0/iBbvCHlLCagdboDJNqf9oYkAsNnpfqgyKHICmXbiaq0J5dOHwMPw2x5bwWRjV5pMt/AHa0etGBWY44+DBsgcMF/c//1Co+PC7u7+PjpPKTJJzFGG1TZYC8zY547cYc8oVn8znEHsjbsRDbCJ9YDmz1TY1GRi2tXCTAP6LkAN0iCVcJNlGXW+B4PwXgvU4DjyagK+a5mxlyYvbc84xDi7KsuhqTQPERnK3L3IUCUoz+wka7aT7//LFe9VfAxsdvc0qgnmzVIQmwci/OnEjsUfJwTbwZOkl5N+2wQ8lJ2v4mi6PTvPX5o+SB4622tkCigvY4QTW+56tw5sSrGD20IiS+JUUinEMzSMeRDcK/VJymB7Pl4VkJMjcS1Nbduz2bl1d8YIm9styt18hN0MtSdSWmaPcpGkJCqjkRqsoeoVpabB5FzISgabRsZTFWXjjy8PgZYOkI/UvLWlWT241C1rQc1exBtP2VtIwEpQ+xIwIDrjfJ0WcnbaAYUqUIe5YuQVbzWT2TIf/fVoHu++RI3AcTjlisb8B2Osg5je/g8H7NxIQoVvl5AYTRRwipOR/8xPstrAtoNAPniW7e2wlsir9FsXhwSmEcmsR7GiBRUIbLV4XenEr3YOMbtanylx5ec+gI8UXW49HJuOJ8Qg5hnm8JeS50tIATWmRylhH4UYkodwROvavGqCCO6EJijM8FLjjtyYTFGZQANyvyQOOpKOKUZUwDS1WMhieQXgapdHVacVTRkuGytnBVPdZMtiLgK/0CXyxf+jnYQy6ms+pnKhNYkd7cmVGgnVeH8XaFDp/LG0kgso6b9TJf/KrdGguCoJz5PMEOAPzBfelHPTLdE1b5LfLAr2K1SHbR9OG91e3NiUvSGhFMiZu8vK1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(38100700002)(82960400001)(2616005)(8936002)(6506007)(54906003)(5660300002)(86362001)(6512007)(31696002)(508600001)(6486002)(7416002)(316002)(966005)(6666004)(8676002)(4326008)(53546011)(36756003)(66946007)(31686004)(2906002)(83380400001)(186003)(44832011)(66556008)(66476007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJIU05GOVhyd2RJNTV2bk55bmVIRDZCY3ZCRVQwTWViNXFmQVFnL0hJQVVY?=
 =?utf-8?B?QmlaUzY5TnBISkNjNW1OUjl5VmRPTlowWkZtMUJlRVlpYnNlS3JEemdLdG1R?=
 =?utf-8?B?dDQ4bkdxSm5mZkdxMEYzalFBWUIrMW93aXcxSUFiSzQyOG92Y25YU2QyUnph?=
 =?utf-8?B?ZG9MdVVLb0s0Tm1NVEh5dGdHYnV5akVMYlRwNU9CQnc2aDNoMUVvVnIrcFJw?=
 =?utf-8?B?eFcvUHAyYVQwbi94OWFRYWw5WHErU1N5dWVUV2pwcmMyT2RTQ20wZm9aK2lE?=
 =?utf-8?B?cTRqWFFRRkJnWFF6RnpuQjY4SEZuY1h4aDM3WnVCSEpsc0lkNWwyNmRIUHZT?=
 =?utf-8?B?Sk9KbVN0ejJDcnA5ZS96NDA4bXdtenl2MTcwUjlvOHZmTXJOV1VmeThpOTFH?=
 =?utf-8?B?OW5id09NM3ZNNmlJTXl0OEZleXIrSE84UmJ3VEJ0VkFBZGR2WU1SSXZLS2RO?=
 =?utf-8?B?SDZDV29vZFY2MFhibDF3M05IbTN2ZncvYUFxTXpKQVMxOTZTbnJKNlVTZ1VF?=
 =?utf-8?B?UVAwOGR6VUk2Y2RqWXFNN0tmdjkrVW9sc1kzR0toL3hhUzBvQk9Sakt6MXRj?=
 =?utf-8?B?bnErQVhrYktPTmxsWmJ4MCtkSG1QVDhyQ1RLSWc2VnVTdk1VNmpJT3AwYU9x?=
 =?utf-8?B?bHJJNlhNcnI3Z2NYc0dRZnl5SGdwNWhyVytXYUN1YzRGKytnS0hxV1kvZjAx?=
 =?utf-8?B?WE1GUkwvc3ZEK3ZqUHN2bngrWGFicVovdS9JbW5WbkY2WGpiak9iREh6TUdY?=
 =?utf-8?B?a0ZIb3RyQm11elFyanlReVp0VzM4YkJJVkhDZFdjV1VEbG5HWUdxMTY2cFFo?=
 =?utf-8?B?WXVzR1FFMjhQZ1hyS3NDMzZwVExKa1BYcy9QcDN5bEwxM3FKV3RQckFJTmhC?=
 =?utf-8?B?RUpCdzJZd2hwVEVzNWZCSGczSWxmQ1pCTTF0cUVHNkQrYWtSa3Bha1BMUXpm?=
 =?utf-8?B?STZnUjVYc3ZyVmxEcTBvQUU4cy9NQjgxTnRTZzNkYzZ6eTdqd3hDVUxWL1lt?=
 =?utf-8?B?WnNvWm5RajYydFdBS0JiRjVLcUxiOHJQRnhiWityVzJOK2s2SmxwTlB5WGtE?=
 =?utf-8?B?anBLdFQ1VUR2ak16NFZoYTMxeiswSGtKMjE5SlNVSmpMWklGTDZVNndzSWxq?=
 =?utf-8?B?OUJhekZDWDNoUHBRWDhTSi9FQitMazd4c1RkRDJiV1kwZHQrYm1VdFVwa2Y0?=
 =?utf-8?B?VEtuRWVSZC83YTdoZzR1TmZQYURGdnMrR2hwVjY0R0xZUFRzS2NTYmtXamw0?=
 =?utf-8?B?RXZSditQdmM4ZE94Q1BNT3RIUWtrU2FjeHhXamZjbkxkam9MeUFuRTFBd1hp?=
 =?utf-8?B?a2ZVR0hwN0MyUzM5VkxZOHR2Z3p6THJIZnRZZVhKLzZhcThWc21aYldUTXNl?=
 =?utf-8?B?VDlueWViMXA5RUJTWTdqWkd3bmx2ak5SLyt0VTZrbnFEM0tQVkpDc25UVHZv?=
 =?utf-8?B?THZGOU1nNXl0Zk9qaUtacWVJV2JEeS8wanh5L29nR0F1SVp5M2IraWVXY25X?=
 =?utf-8?B?TnpCSTQ5Mm41T3pxWTdrRzZHY2d5QzJsWjlhZXBvWVhDRUVQZDdSWkRZRGMw?=
 =?utf-8?B?NWFYSGNoN0VIcmU2clNKeGhTN0NjV3oyTjFUVFFEeU5hemh3UDZzOGpWNVFJ?=
 =?utf-8?B?UWNkbjVlZVFGSFBReCtlYndrbS9udVRObTlwYnQ4cE5SVHpmS0FUQXJ4U21H?=
 =?utf-8?B?SGIzVmVjNHB3WmpnR0V3U2tla25DZnNnRFlVQnA3WFBjNmhDWC9adkk5Y2FH?=
 =?utf-8?B?STdLcldORVdEOHZuQ2Q3TkJXMkhrWGMrL2xsZ2ZIZWZCOEtoaE96Q0JEbEdR?=
 =?utf-8?B?eTFjUmkzS1E1NlBLWFdFSTRuZWZPaWgyUnhjYlp4ejRaRE1pY2EzS285SUtG?=
 =?utf-8?B?N1dxeVdqR3dWb0tzSmZGVCtyYW84VGhIYndXVWhZaW1hb1lkQnJmTlcydU5N?=
 =?utf-8?B?aW1ldjJhZnFqSEVUWWlKMEJCZDdzcnRuUGlHaVdrZnVJdjBiVnh1UXdNdnVS?=
 =?utf-8?B?TXk5YzMvaEZ4SXQ1V3ovV0NqWjZzeEpHek1VY2JZMnJTb092d1NFZnFRTnFH?=
 =?utf-8?B?akpkL0QxaXFRUE1QUklmekN0WTAzNXB3TDBCbUFoWkg2Y2lGSDRubmpHSW9z?=
 =?utf-8?B?dGFDSXg1VWNNeDlsRUVsekxMSjZtWXM1SkFnVlQySGM4cHBtajFvMEZYdXB6?=
 =?utf-8?B?TW5oWGZqcnF1eGxobEdVTlRVTXpiN3kwTERMaC8vcWtWd1dsRzRiRUdwaGVX?=
 =?utf-8?Q?fd5MzO2vHPKL1doNKdJeedplrJ9rEUvx8WTuh2Tcgo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50325e33-0fe9-43f2-ce89-08d9f6543490
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 22:39:38.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziP5OsCWKSpn46ZEqBSysB2RPzFjo05vQEYrraKiGQoA4GTtHwe1g+rprebYoUEchYyGSGxOjufBtyOikhj/fCXhZqIUf8NpOlQLyyBPML4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3843
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathaniel,

On 2/22/2022 12:27 PM, Nathaniel McCallum wrote:
> 1. This interface looks very odd to me. mmap() is the kernel interface
> for changing user space memory maps. Why are we introducing a new
> interface for this?

mmap() is the kernel interface used to create new mappings in the
virtual address space of the calling process. This is different from
the permissions and properties of the underlying file/memory being mapped.

A new interface is introduced because changes need to be made to the
permissions and properties of the underlying enclave. A new virtual
address space is not needed nor should existing VMAs be impacted.

This is similar to how mmap() is not used to change file permissions.

VMA permissions are separate from enclave page permissions as found in
the EPCM (Enclave Page Cache Map). The current implementation (SGX1) already
distinguishes between the VMA and EPCM permissions - for example, it is
already possible to create a read-only VMA from enclave pages that have
RW EPCM permissions. mmap() of a portion of EPC memory with a particular
permission does not imply that the underlying EPCM permissions (should)have
that permission. 

> You can just simply add a new mmap flag (i.e.
> MAP_SGX_TCS*) and then figure out which SGX instructions to execute
> based on the desired state of the memory maps. If you do this, none of
> the following ioctls are needed:
> 
> * SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> * SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
> * SGX_IOC_ENCLAVE_REMOVE_PAGES
> * SGX_IOC_ENCLAVE_MODIFY_TYPE
> 
> It also means that languages don't have to grow support for all these
> ioctls. Instead, they can just reuse the existing mmap() bindings with
> the new flag. Also, multiple operations can be combined into a single
> mmap() call, amortizing the changes over a single context switch.
> 
> 2. Automatically adding pages with hard-coded permissions in a fault
> handler seems like a really bad idea.

Could you please elaborate why this is a bad idea?

> How do you distinguish between
> accesses which should result in an updated mapping and accesses that
> should result in a fault?

Accesses that should result in an updated mapping have two requirements:
(a) address accessed belongs to the enclave based on the address
    range specified during enclave create
(b) there is no backing enclave page for the address

> IMHO, all unmapped page accesses should
> result in a page fault. mmap() should be called first to identify the
> correct permissions for these pages.
> Then the page handler should be
> updated to use the permissions from the mapping when backfilling
> physical pages. If I understand correctly, this should also obviate

Regular enclave pages can _only_ be dynamically added with RW permission.

SGX2's support for adding regular pages to an enclave via the EAUG
instruction is architecturally set at RW. The OS cannot change those permissions
via the EAUG instruction nor can the OS do so with a different/additional
instruction because:
* the OS is not able to relax permissions since that can only be done from
within the enclave with ENCLU[EMODPE], thus it is not possible for the OS to
dynamically add pages via EAUG as RW and then relax permissions to RWX. 
* the OS is not able to EAUG a page and immediately attempt an EMODPR either
as Jarkko also recently inquired about:
https://lore.kernel.org/linux-sgx/80f3d7b9-e3d5-b2c0-7707-710bf6f5081e@intel.com/

> the need for the weird userspace callback to allow for execute
> permissions.

User policy integration would always be required to allow execute
permissions on a writable page. This is not expected to be a userspace
callback but instead integration with existing user policy subsystem(s).

> 
> 3. Implementing as I've suggested also means that we can lock down an
> enclave, for example - after code has been JITed, by closing the file
> descriptor. Once the file descriptor used to create the enclave is
> closed, no further mmap() can be performed on the enclave. Attempting
> to do EACCEPT on an unmapped page will generate a page fault.

This is not clear to me. If the file descriptor is closed and no further
mmap() is allowed then how would a process be able to enter the enclave
to execute code within it?

This series does indeed lock down the address range to ensure that it is
not possible to map memory that does not belong to the enclave after the
enclave is created. Please see:
https://lore.kernel.org/linux-sgx/1b833dbce6c937f71523f4aaf4b2181b9673519f.1644274683.git.reinette.chatre@intel.com/

> 
> * - I'm aware that a new flag might be frowned upon. I see a few other options:
> 1. reuse an existing flag which doesn't make sense in this context
> 2. communicate the page type in the offset argument
> 3. keep SGX_IOC_ENCLAVE_MODIFY_TYPE
> 

Reinette
