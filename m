Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF464F433C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386159AbiDEUFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572960AbiDERaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:30:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF29918389;
        Tue,  5 Apr 2022 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649179698; x=1680715698;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2qqGdqCAW7ljyQ4wNx5VhYD+7JWCv32Wi32w4rc3rxk=;
  b=FKvPUSlMMoWy3gaA1tLnxMCi6mt1yBxfSqFXPZ8GGrBE7mTkcVlY2sg0
   cOUaDUg3JFACIZHGa7AdXjzxUzHJsKk67wboeAkVph6qpn6RnurOJA2Jt
   kvOkpb6Cym57aCpj8tyc5CTdJX7U1+Hj0AZtMkwsfadMZW5mjdHcA4ncr
   QmWpPeBBzN93O0w3/nEblK7H8Q9mZ3i9JGqU+xRpkHqXBcKVgdxoairit
   GGVZH3kciNc88uLK0ThOqxratBFzDkL5R5DawVP2gqkLaAlC+cVFQ7Y/n
   SFAbzi/VvzPR9ZnJNsMQodPQMDW5wGYw5TAlDGSUnCFZOfGFYszASGutB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="347257136"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="347257136"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="523547421"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2022 10:28:16 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 10:28:16 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 10:28:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 10:28:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 10:28:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6X/99SHazn4NP49ojRL4EpyqMVMMR/Y29/KlcmCBRVjyjJixriQ2ItYqpOZS0dfn5aS1xn4OG8Ujfxs68s3x/huxSJ04YkpQAjFC7tyL5rz5gLqQMa5lhWBlaC/8bQrVnrH4u2cUghF6mQH2NDUfIbRCJW1P+KakICg/Mw5Iq6lJ2TEKAGzRPdDeeqBGlxk7Q2MLEjn9nl50V0DQ6QuKIVbPeLAQjCUbUkTFdCURhXIjGQKHnGn8sVn01SFklBIC2BgaZB9hCwzrd5czeRKvvKkGFINFQwqLEQSVH8+DtgUB0HWqNVbjk/8cDYHIHj4NzSv6feERGjnUPpsMm6jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUmHlNDzs++GeYHSdl+HTovozEVEj+A8u6bMSVBUoBg=;
 b=eTKIQG4SiUbbzkJzLX+xzNkXMYb3VXU1FNxHq5IrAzCsV5MWBkUw88ODD/5Vfa9J+PSa1z+j+aeGJnwRsE4rrHIUJjsBP8xLupOhYcLxhAjzqByJFnojAmTp6P3Bnv43NRiWE3NtqGCF6jlwzYeag2DdUGt8NnJeX5wPuBylbr5E/baMmALUz8IWaTBT9FQrxDQtc9z0B1r7qC8U6668dtprkuPjcGjYh2d+H5oFHyjnkr3hlVIQXC3Y+8OMU3UbTl1t4b1hO+b+y7HkJf7RjFKIAAxi0zSOCi06wCtzH225TDqhj+GPfwDNxvxl4ciZ/GFkz6T2HZahbfqJCcexqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MN2PR11MB3933.namprd11.prod.outlook.com (2603:10b6:208:13d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 17:28:13 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:28:13 +0000
Message-ID: <5ea8d567-5d82-6815-013a-70f4e3f913b9@intel.com>
Date:   Tue, 5 Apr 2022 10:28:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH V3 21/30] selftests/sgx: Add test for EPCM permission
 changes
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <b2304ac0322d945b4bfdce36d3aae654f6ed35a0.1648847675.git.reinette.chatre@intel.com>
 <Ykvpi6HRL9cLorw6@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Ykvpi6HRL9cLorw6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c63edc-1c6c-4b12-db30-08da1729a984
X-MS-TrafficTypeDiagnostic: MN2PR11MB3933:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB393346374B567830D8B0F83CF8E49@MN2PR11MB3933.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBSTqh/HBv5QiKW6rDp0pEWtkCj4EjZ3nf2XM1YF3Nq6xLV+c7KZYAbOy6ILmLqX1COtZI8PP5wPjCQ2laW4P2SN4rmCMrcCHV6VQ7FutPgp/WIqlZT9En3Ftd/G1KXiz8q2qH4aOFD6FKLwytKv8l+AsCCWg+G4Ei+xbDfHgkt8vRw95xaJTmVb4ImobuKglg1cYaBHOYXNtPylgRwEXuCGLJ2aZ0rIHkVX5WGXNBqqAmqJRvhyNH8rJyHdqJpGAj970ouqgaIZtoUbFN75ND3/SsOO5CeuJ5B4h/qnWlasK1vM+KetDvQSCwLBsqykqbIfunqda+vV8FWttwdOOkv4WOoBfvzPe1MgUXKdcopDzebxHDCV4G8Og7ZHATKmguk8BZ6fo6O/c3mOMILwteCblfRARDkFS0Jx6hW385G/h7ivC3LISHQExG1CK3Rc0l7hNJi3NJqvmkIBze3asv1vZOac79UdtIAFXqNruqEt8AGvXrnWdRo9JGzkmzTZZLxrx0sS097xVDXgVgARMDZ3DBV7r2vrgvd0CJ6Zh/eF1TAa9kN8mjnWCPOkgZ+ECyE9sxQLZmpkla5VtVB88rBvBm56rH3j+s9eeH4ffHfXO19CKfXEx3o5Daw+6k7EGcloDcN0GtKxWFjkkgl2RsImTp2SPQErF7ce4OBs92+P7N7dzk96MWSIuZM1OJqOIZzbhR1TPYrU0KtvApHzXd7IGVgzGjzYHNBEbG7I6xfSS5uRIlBCYmIhUrPf8JNYxIcInLUqT3oi6VM7GqM/cED69x+DFoAvX+i0IsFBmgcT2soYiQ8POhanDHCuePJxOmVSzJaNN3zSvFc2sUnEMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(6916009)(38100700002)(316002)(4744005)(66556008)(66476007)(82960400001)(31686004)(6486002)(66946007)(508600001)(4326008)(8676002)(5660300002)(26005)(186003)(6666004)(31696002)(7416002)(2616005)(86362001)(6506007)(8936002)(36756003)(44832011)(53546011)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkdudTBQbVF1L2VJYUdRUmZCV01ZVFBTVnR1ell3UC9DN3FXNlJoY0pwMjBn?=
 =?utf-8?B?L0RwQ2tIL25ZMjZYSWZOZG1FcnV3MXVmMGxCL0t6TTNvam9VdVp5bjl5VXhq?=
 =?utf-8?B?TER2VkNCcFNoSFRXY0w1aWVLRllkSFJYTlZOY1RNcE9NdEtWQU9zRy9lVVpw?=
 =?utf-8?B?NW5KcUUzeFUzNjd2S0w1d3BhQnpKSW5FWXRUenlZOWF0QzZBbXRrUG5idUhU?=
 =?utf-8?B?ZzRhc3dEVGhzSVh3elNaVE40dUZyWHd2NmVDV0VKcjdISjFDRVJxbE1udmc2?=
 =?utf-8?B?SnlUQnAzakZDUlBISjBINjNYa2l0eXRYS1dFRFZuWlZ1TXArVXREMTlETE9r?=
 =?utf-8?B?TFlYaDQ1ZGhwSTFjMGNHWnhQRGtyN0FETzZWdCtNaDQ4NlZhZ3Y4Z3N1N2tB?=
 =?utf-8?B?RmRyY3FkRDI1OEJjK0FtYWxWSUxCOXhDVjNocGNURFM3VERwYldLaVVJVEd1?=
 =?utf-8?B?am9MYTkyVklDc3pLYzRQdnBiblFMUGR5VnNiZjJvQWQ3ODVWVXphTkllZ3Bv?=
 =?utf-8?B?OWJhVVJMT0lpZFhEUFBEMzBsd0MwRitrSDRxcHRoTVM0UkVnVG8yZnJZSnd4?=
 =?utf-8?B?ZWsyQXZqTWhyaFVpb28yRStRZ3k3cjAxNytubHdJMGEzTkZsUW1udG5BMnI0?=
 =?utf-8?B?UTl2c3o1aEtYUTlUSE5lSmdjUlZrUDFZRVRueHRHZnRhSDVwL3FsV3BxOEt2?=
 =?utf-8?B?RGoydHdJRklneXFLUUkrZGpnTXhwZVJYWmdSZktESGhpcWV3U0RCWjN0QjRI?=
 =?utf-8?B?a3BDekpvWVBvWHJtQjRXR3NXbU9RMDhkczlHZ0x6S3M0eHRsQ28zUmFGTGhE?=
 =?utf-8?B?ZU5ISEdSbFZMVXIzUElta1BUaktsdk5RUXlXdXJ2enJlMUdaUVdkR2UzZ1hS?=
 =?utf-8?B?UmFTSzJEQ0lUVzFBRVlCbm1UZXltUGgxdzV2bVU2WHdKM0Rxb2VZTHVHRUxI?=
 =?utf-8?B?cDFxSFY1eW1RUGlUcDU2RGkxaVZ1WVJTV2F1NzNEZ0xWUmg5aHFNL3JvcElP?=
 =?utf-8?B?UGNxUEpQUXFzR2Z0dG9ncTVoMWlWR3JQdEpROVNPenJhYmdqY3BsUHF2ckJG?=
 =?utf-8?B?Wlhja1kyUlB5Z2hwZzlkWFdtS1QyV0gweko0QVIvek1hRHJWT2R3RnlrVVNF?=
 =?utf-8?B?NWRLaG5vS05pb1FkSmhzQUJQeXZNNWZBMTVWb3p6aHdNbFNDalB0UXZ1NnRi?=
 =?utf-8?B?QXFpSi91bmtBNmxuQWJYdThvUlpnbnBkczdIU1FPWlZ3WThTQm83RTl5ZC8y?=
 =?utf-8?B?SEVXYUs4L0N1QWZSSGlyMStDN2FTMitJNUFEVUt6blBDWlRDdDM5a0ljY3B0?=
 =?utf-8?B?anNvZ25SK2QyQUVVdTB3NE1yOGdtanh6OCsrN3pzTGZzNk4wUmtUcXBsTENH?=
 =?utf-8?B?TWpKV2l4am9yazlWcWJIb3duSWw4V05tMlo2d2JibjFtaGtSOXQrakJIVzYw?=
 =?utf-8?B?MUtka3o0Y3BzeHlmdnFNbEJvUjNmcEkyWnhNOE1sWDgzNG5wdVBpWFN0MHZs?=
 =?utf-8?B?SS94Y29zOGpFckJmbENaTGYwUit3WGZ5UFpiYVE5MEowdHd5TjJhcGVZQmxL?=
 =?utf-8?B?TmtlcHJFUElMUFlqcGJSdS9RQUVKZnVuZ052YkpuYVNYSzdvdUJUUFBiWkM1?=
 =?utf-8?B?LzBIQ2lnNCtITjZqeFNrRU91RWdqWTNlTm9jSzhpTVVRSzVaLzlJQTcwcGJh?=
 =?utf-8?B?NFhVZnJ4WFJrZkl2Ryt4SDcwdVhWYi9kcDQ0azZIMld2a3lldXpYZTBtbTZp?=
 =?utf-8?B?R0tSTUd0Y0RicW54MEdTY2gwdTZ3MzdaM0VwVUhKNzRGalkzZGFMNVNpVHA1?=
 =?utf-8?B?M2RlSjhtKzZhY3JWcHpObkpqV3FhNXB1TUkxOTlmOVJHaENPRGNSNTdWaTht?=
 =?utf-8?B?N28zV09vZTIrbzRkZHI1MmM1dlUyWnVzWHh5aVhGN1VMc2wvUzVZb294cHhI?=
 =?utf-8?B?RWdZV2ZUVUhycWRYV2IzcGFVZ1VIVGhGUkgwYnVMTUMwa1B5MXBVaWUrTkdl?=
 =?utf-8?B?eVdDUXVhaWJhRWkxemFHd0ZTK1VUc1lPUTZNUVV2ditjNU1mVzQ4QnJTMHlF?=
 =?utf-8?B?NlhvNW00bGp3eFJndUZseXduZVk2TkVUbGo2VmV6bDJOdkVpUURIb0h3bTJZ?=
 =?utf-8?B?aVJZM2ZQaXc4ZEtHVnMyZEkwb3ArTmxmQmlHYUhRcGNYcEMrTHgzN1hhUENW?=
 =?utf-8?B?Y1Q5SFFXdEpTMzltTEFRUEhIbUxkOUdBZTJkUHFXZXp6NUphK2xKelBCR0E4?=
 =?utf-8?B?SFM3bUVOdkhlTnVqVnlqUUd5a3NtZFYwMVpoMzVaRmVidXpJNTFWTkR2ZndQ?=
 =?utf-8?B?dHJxSExPbndIUkk1a3lab3Z4MXR5RlFXNjNFNDJnMHB3NlNQVm1RYnU3SjhW?=
 =?utf-8?Q?u40ub6WIiHGN1hbw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c63edc-1c6c-4b12-db30-08da1729a984
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:28:13.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByZVYM0RAtZ8FH6sVSTXvEqWKUzwAR/Mh/WY91vgod1F7cx/4WC8B0wHdpqHwLTTBOfWUZX3i1fqRBOdGWNBQNPay7T9cfhewDfi3dUcylc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3933
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 4/5/2022 12:02 AM, Jarkko Sakkinen wrote:
> Lacking:
> 
> KERNEL SELFTEST FRAMEWORK
> M:	Shuah Khan <shuah@kernel.org>
> M:	Shuah Khan <skhan@linuxfoundation.org>
> L:	linux-kselftest@vger.kernel.org
> S:	Maintained
> Q:	https://patchwork.kernel.org/project/linux-kselftest/list/
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> F:	Documentation/dev-tools/kselftest*
> F:	tools/testing/selftests/
> 

My apologies. I'll add the kselftest folks to the next version.

Reinette
