Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E38A4CC7F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiCCVYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiCCVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:24:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18CECE901;
        Thu,  3 Mar 2022 13:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646342593; x=1677878593;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S/KwrJbu2OY4ntGg5Wm3B3inMX6kh41HB+6Wxm7AJvE=;
  b=V6a0ceBeHMILLm4MyAes1dZsRDTFIox6dMCa0LbrEVqfllxHdal/u6Ls
   0/YLXbdOV3J1B1z5TNdbDXRroj21MvdBabJhrnE09lDE3oWWMJ8EOP43z
   mBqXShVorb/UFgDVajleRtv7/KIcNPozk9ZnSrfOx7s4YpoyWF1PaHR4h
   HImzBEYTaVBvNYqfYShV/fZE/I7XE+6iGchXRGnbVQ8CXtJH70ACRm6YA
   P5+2CZa8cRIEekXJI8L+eMIlDvWvvx3lzhImFT66NSHh5oen0IALSr1D2
   aHWsOIGpnfpV7uvrvwdh5CBZ/DUffnvFDut3pu59TUhRIZFGSEmNrjVQl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="340248540"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="340248540"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 13:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="576657629"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2022 13:23:12 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 13:23:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 3 Mar 2022 13:23:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 3 Mar 2022 13:23:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUI7Ut5heOez+p8X8aNP9ll580mpNivO149dcV/aXDrikwW10ulD04LGtEkPf1YkNrshb9aumMSMS7H7tpgXm9AE1RB4eGOywU+2ZsFGxcDHhNRyD/F0LOz/VdxI1oYxn7x9NsJht/W3kUgMHZTwLgvgo0mNR712hnS/2H1CGHvjRAQHTBVLMX0/vGL4J+v9DqCyuP4lx1ZbvLQm7/taSmizhqS9mXHMe4kK592awzBr5T30NAULUWCL2m8pB4OEtXsWp/Lq4k8BfgzieXrq6Flq0c3hy98GQCjuLYdlbUOtQVBbZiOiaEoj0fubaG7Gxleci9lYfn6hov0TBf9yfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QVjmpnN63P7azjab12k4Lun7GFN3Yo6u6gJqdBsVsI=;
 b=K3Z9FTgUCfSz82UmueHZuP4JL/ePgCra5PLJL1QGZdtUwC0x+OUbjBf49UGjrtGKveCaMQ+Mxy1VfcSncskTg2XxFU3rQbclgHFYipMWV7oPS0rXlPF8Jd3UQk+6tl7//zW54ZT57AyO8pEuj2CtMHqQTkbFPkH95ns9nzdm7w9nhMR5zGfQan9vBzPvNYJnUg5I6SPFX/AhMTcrxaXZNQRQoxHux+F299JtXDf4FUQL7bTh0sLlM6VTGJqTmL6FuULSKFsmYPfT/x/gDSf35CXaU94mbZGM3LnN24aLeNZKIW7/HycFpYN13kLqo8wJ/j6xNP3Nro4xciYZyGuSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM4PR11MB5439.namprd11.prod.outlook.com (2603:10b6:5:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 21:23:07 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%5]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 21:23:07 +0000
Message-ID: <19155cab-ecff-a8a6-f724-98c4535642ef@intel.com>
Date:   Thu, 3 Mar 2022 13:23:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi> <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi> <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com> <Yh7Q5fbOtr+6YWaS@iki.fi>
 <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com>
 <op.1igppyk9wjvjmi@hhuan26-mobl1.mshome.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <op.1igppyk9wjvjmi@hhuan26-mobl1.mshome.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:104:4::25) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121deee3-3314-4537-0dba-08d9fd5c023a
X-MS-TrafficTypeDiagnostic: DM4PR11MB5439:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB5439A49F363A7315C098D1E4F8049@DM4PR11MB5439.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHUkEUH+R7rQV8H8+i42nP8MqnslaX6bHLLva7tM5VZngfxfbUBnosBUK9iGbLjhzrpiZeTLJgNzIVArjzFQIUAjRMZfRh/aqWEwlxdb3xFjrwl7P9ia4CA3Unik1m22u7PAdHjq2izBf0j/a2wsfvZfpkRnNBQAg7+xgX5pePIoCq9VONpieICvzW/rbjIsqcOkeFMluuEFuFbKUtu1TtTtp/rqZ7Vf6xMw9NYWzvr7ZvWHMxPeE+3na4Sf0gLAPPfKKZYKG8xTukFGk8gSpsWpylx8O9A0uofbVoNXoP9hIWbZJT5C9mbcFJAfovz4qQD6BD8MTmgqHx1NgcK5TOco+9Od2DzMIBNeT8BcJAFM46N+ApAsLBc9e/Dhpymokc87U/4l7QutdLjcFthIrbn3o48LSbdAiIsOrEbNtphOw4r50JyY52bWSVxLiU6u5eDJidssK4RnW7dQ1ebeecOCrCC0qZcs89d1yowEnLLapA1v5Xobs+qSwgRKNMSDKRNZgzj6XdgLyVS2qYmUwAho41xHsPkRkD6r1qHAb8w0PXIjkXDdCNZ5cDbUJpxxOaZ6bhTQ8Uii6fK3YisHqlGxCOiC5qUvK+VQTXnSG6yAe5zOpT2M/DuNoGU9FKNitkswjfLjPL2NxRdJs1HgnIfR1vM7j/zxMDkOcDOyBAInDyPquQSw74O6QPwXS5WN1cXzUGSUr0naCZD+YFhYsXu0yGUoZvkGkXr6rb5ifuG8J282fV3os5920XLJYjz0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(2616005)(54906003)(44832011)(7416002)(86362001)(31686004)(6486002)(508600001)(36756003)(31696002)(186003)(26005)(5660300002)(110136005)(316002)(6666004)(66476007)(66946007)(66556008)(8676002)(4326008)(38100700002)(82960400001)(6512007)(6506007)(53546011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tWQmZPTGVuODBFKzB4dGloSDd4R2ZudURrdU9pOWRVK2VhbndoYWFzMVN5?=
 =?utf-8?B?TUEvaHNJREQ4dkF3cGNWb1N3N2wwTHBmZzVKcFhiNlJVOExoRUNpVWJ0L0RM?=
 =?utf-8?B?d1JlVmt4bmJqOC8zU1dMMHpkaWtvK1ErTzRhRnFDQkpmMEpLakMvYlFOQnpO?=
 =?utf-8?B?T0FnWU55eGNSb1dCcDRLc3FHV3VmWWN3enVhL3NSZzc1MlN5MTBNRGVjREdr?=
 =?utf-8?B?MkwzTWhoclA2SUdxeXhrK1FOS2hIaTFqVGgra3l6ZExSMTJiM01QbGJxSmpC?=
 =?utf-8?B?eHo4bkhkYUM4bWN2Sno4c3g5ck03dFBZeElUVnFNYmhEZkJLeE1Oa3lNQk5W?=
 =?utf-8?B?YnVycFpiUzZMNTY2N1dldi96bWIrS3pwdUJ5NGVUbk1VMlZDa0ZRVTZHTEdE?=
 =?utf-8?B?ejRMWDFQQkZzVy9vaGFFeldHZEFzTUpidThhd1R5RTVvMkJ1Q2c1ZFAzc1ly?=
 =?utf-8?B?WHdCWmxvSVBRMko3YUxyRWxuOUlXVHZGcGx1bGdzeXRHZ0dENzErOUFFclZL?=
 =?utf-8?B?Z2Y2OC9PQVJoSmJ4MmgrZ1JWNVhFTkxnaUJkWHMyNHF6aGFqSkptNlhDV1BQ?=
 =?utf-8?B?MjVScktieVRGdFlycmx6TmtDUVVGVUgxblJTTGg2WnBQSUpCZ0xmdFpSQ243?=
 =?utf-8?B?dFpjUm5lUU9FcWRMZzkzcnZkbHU3cjF1MUo4VlJoQk84bU5aNGVscWV6OEpC?=
 =?utf-8?B?OGU1OVZFYksybEhVVmxDRGx3dHUrR3l3dXpKZS9ibzNpVDNHaVpxSWsvMWhV?=
 =?utf-8?B?TTBCYzU3bEdPQTc0eWJ4SVROSTZjY05aMy9NSVlRWnZBY2FZbVBTR0lCazlC?=
 =?utf-8?B?Q0kvdkp1YWdXalZTUFVOcmZEaEJVZDFsWXRQMGt4YkZ3cUptb2JWUzZ6b2Va?=
 =?utf-8?B?Ump3MS9EMEFjNlRPQWc3Z3BNdFdsMmlNRU14VllOR1RLWEpWZnp4K1FXWTd0?=
 =?utf-8?B?am1wUDlmakkzS0tzQXJNOWNOcVpFTmJDcm5wZlg1M2hzbm1YSzNGUHFCTFNM?=
 =?utf-8?B?Ymk3eDZHeXVvdVNKK2ZBVC94blRIbnFWQlR1Q29XT1ltNnppTFVYU0M0SVFM?=
 =?utf-8?B?RnZzTFNiSEY1RG80ZUhGM3RJWDB5bU1jdCtqcFhnVTQzWngwbnZQcEhQbVlh?=
 =?utf-8?B?ajlqQlZQRS9lNENTdnpYYmpEcTNpM2JzWEpNSVhDeGJoK0xzNkNBN1dxb0Fz?=
 =?utf-8?B?TlVNMUVOYnRabGM3cWxnNzAxbEdBcXZ0bWpIR3dtcnR0QkxKaHFsTE1FSVNS?=
 =?utf-8?B?cnFadWV3cHE0a0VhRVhMQ0UwS0NCSVpLUkcwSUJ3cE04aGxiMG5oNE1ZeTNk?=
 =?utf-8?B?MmFKK01JZk9YVkV6NlkxUlBtZWx5bCs0M1lTRVhlc0oyWElLTUFaandZRllV?=
 =?utf-8?B?MWZTWVQ2cm8xTENYbUlHWlA0L3lTcHFMWklsK3k1bE1QZTNiUGxnS2JONmI3?=
 =?utf-8?B?QjRLOEczQ2xnUlF0bDYvTkp1Wk9qUEFLbHluMlYzSjd0a2t0dk03UUR0T3BX?=
 =?utf-8?B?VzVjVjBGTzVtY29CVVRRTTdPWUtXZ050T2VwakhScHRmWmFoOVFSdzBEVG16?=
 =?utf-8?B?Ym5PelVrdHRhTVU3cll3ZGpyeFN3WmdtZlZqdURsT010KzdOblN3aS81TEtK?=
 =?utf-8?B?Uk12WHhvVm02RnIvWmdsQ3lhZlNPZVk1b1RxcXF4U29iZldXcVgxTDlqWFh2?=
 =?utf-8?B?RUFZVEV3VkFGcCtPRVZuQ0dza3E0R2NkNmVHaWc3RWhmeHNqRTJocUlnYlhu?=
 =?utf-8?B?ODNEdUloWXZaMXhic0Q2a1ZuTWJIOGpSRDlva1FYSlFjWFlZM3E1SjcxYXRy?=
 =?utf-8?B?WnpBWVBmWXkvQ2lMdTZqejZTdEhLN1p0T2N0ZXhCME9SOGoyQWtZT2FvU0pM?=
 =?utf-8?B?dzgrUEV1TGxRQllzQVVlTHpJK2lPOUZyM1hjb0xFamZ6djlWK3RmdDRuaEpy?=
 =?utf-8?B?cE9ETGdLNURDZlRoWWZVb0ZsM1BQamM5OCtMeFlKU0c3T09MbTJ3Zit2ekZx?=
 =?utf-8?B?d0VPOW1hNk85LytRZWdxbjN1VkNLbU8xQlZiMGNsc09CZ3VLUXNBa0hpemNl?=
 =?utf-8?B?OERZbTR5blJHYVJlRDdPbEd4cUdPeWR6aG9wQk53WHpSMGNqaW94SkU3a2Nw?=
 =?utf-8?B?Z0R1M0F2dDMzWWlRUkVLaGxRNlhCZjhoSHpHeHh4eG9wdnlhOGtsSFRGVExE?=
 =?utf-8?B?M2VOZ3ZZc1JIWDFVRzNQMEx0QUZRRVZLVFZEbTFFcHJMbjRLUGxwalU3cFNO?=
 =?utf-8?Q?m68WEUH/k2YCMdGDbXeV6hnoaxUFqU9DmBfOPehzqo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 121deee3-3314-4537-0dba-08d9fd5c023a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 21:23:07.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuAoJyVKaZELSjAxRY6RjGWrbX5MQWw+sKMwHsxXcB3w9vFBxXxjzcH7iSdZYGJyDqC6QMPEzLj6HjNwZTIucPrAlCFoFinNebUXYZIW5y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haitao,

On 3/3/2022 8:08 AM, Haitao Huang wrote:
> On Wed, 02 Mar 2022 16:57:45 -0600, Reinette Chatre <reinette.chatre@intel.com> wrote:
>> On 3/1/2022 6:05 PM, Jarkko Sakkinen wrote:
>>> On Tue, Mar 01, 2022 at 09:48:48AM -0800, Reinette Chatre wrote:
>>>> On 3/1/2022 5:42 AM, Jarkko Sakkinen wrote:

...

>>>>> I think the best way to move forward would be to do EAUG's explicitly with
>>>>> an ioctl that could also include secinfo for permissions. Then you can
>>>>> easily do the rest with EACCEPTCOPY inside the enclave.
>>>>
>>>> SGX_IOC_ENCLAVE_ADD_PAGES already exists and could possibly be used for
>>>> this purpose. It already includes SECINFO which may also be useful if
>>>> needing to later support EAUG of PT_SS* pages.
>>>
>>> You could also simply add SGX_IOC_ENCLAVE_AUGMENT_PAGES and call it a day.
>>
>> I could, yes.
>>
>>> And if there is plan to extend SGX_IOC_ENCLAVE_ADD_PAGES what is this weird
>>> thing added to the #PF handler? Why is it added at all then?
>>
>> I was just speculating in my response, there is no plan to extend
>> SGX_IOC_ENCLAVE_ADD_PAGES (that I am aware of).
>>
>>>> How this could work is user space calls SGX_IOC_ENCLAVE_ADD_PAGES
>>>> after enclave initialization on any memory region within the enclave where
>>>> pages are planned to be added dynamically. This ioctl() calls EAUG to add the
>>>> new pages with RW permissions and their vm_max_prot_bits can be set to the
>>>> permissions found in the included SECINFO. This will support later EACCEPTCOPY
>>>> as well as SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
>>>
>>> I don't like this type of re-use of the existing API.
>>
>> I could proceed with SGX_IOC_ENCLAVE_AUGMENT_PAGES if there is consensus after
>> considering the user policy question (above) and performance trade-off (more below).
>>
>>>
>>>> The big question is whether communicating user policy after enclave initialization
>>>> via the SECINFO within SGX_IOC_ENCLAVE_ADD_PAGES is acceptable to all? I would
>>>> appreciate a confirmation on this direction considering the significant history
>>>> behind this topic.
>>>
>>> I have no idea because I don't know what is user space policy.
>>
>> This discussion is about some enclave usages needing RWX permissions
>> on dynamically added enclave pages. RWX permissions on dynamically added pages is
>> not something that should blindly be allowed for all SGX enclaves but instead the user
>> needs to explicitly allow specific enclaves to have such ability. This is equivalent
>> to (but not the same as) what exists in Linux today with LSM. As seen in
>> mm/mprotect.c:do_mprotect_pkey()->security_file_mprotect() Linux is able to make
>> files and memory be both writable and executable, but it would only do so for those
>> files and memory that the LSM (which is how user policy is communicated, like SELinux)
>> indicates it is allowed, not blindly do so for all files and all memory.
>>
>>>>> Putting EAUG to the #PF handler and implicitly call it just too flakky and
>>>>> hard to make deterministic for e.g. JIT compiler in our use case (not to
>>>>> mention that JIT is not possible at all because inability to do RX pages).
>>
>> I understand how SGX_IOC_ENCLAVE_AUGMENT_PAGES can be more deterministic but from
>> what I understand it would have a performance impact since it would require all memory
>> that may be needed by the enclave be pre-allocated from outside the enclave and not
>> just dynamically allocated from within the enclave at the time it is needed.
>>
>> Would such a performance impact be acceptable?
>>
> 
> User space won't always have enough info to decide whether the pages to be EAUG'd immediately. In some cases (shared libraries, JVM for example) lots of code/data pages can be mapped but never actually touched. One enclave/process does not know if any other more important enclave/process would need the EPC.
> 
> It should be for kernel to make the final decision as it has overall picture of the system EPC usage and availability.
> 
> User space can provide a hint (similar to MAP_POPULATE) to kernel that the mmap'd area will soon be needed and kernel should EAUG as soon as it sees fit based on current system usage. Or kernel implement some policy to avoid #PF triggered by EACCEPT, for example, if the system has ton of free EPC relative to the requested by mmap at the time.
> 

mmap(...,...,...,MAP_POPULATE,...,...) would be most fitting and
ideal since it would enable user space to indicate that the pages would
be needed soon and the kernel can then prefault the pages. This is already
desirable in the current implementation to avoid the first page fault on
pages added via SGX_IOC_ENCLAVE_ADD_PAGES.

Unfortunately MAP_POPULATE is not supported by SGX VMAs because of their
VM_IO and VM_PFNMAP flags. When VMAs with such flags obtain this capability
then I believe that SGX would benefit.

Reinette
