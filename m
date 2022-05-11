Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA975522DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbiEKHx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243172AbiEKHxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:53:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369925535B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652255633; x=1683791633;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y6KxWAEzk4bO/W0QJvkFbwTLwX4HqHei1J9SDid1P58=;
  b=Y9kdOIfJSEDBYzsJjltoDn6VJDKoiVgwAnSvNNo+yBVLifUMqGxiGMMV
   vkuiikQNNyufdMd+LEY4aYRTiWAEDzi6vZ9pcb07A6eSLiXoCmHHRNHiv
   uVAlTP3IjpehTl5AcmccZsB8Ss6mjQythzFxIC116pqQZ090zXjL2fOrB
   TOw4iuvhHFIPqjSkGpcdCX3ydlZqaNArXCGrlCndouKB62uGJAKNZpodH
   MgwBS7rNpsPEUeqdYWO2C0dYdXbAKqKASx1qg5hHy5mko2PB/0XqN9g7q
   X5sb9UoCeqLv7WDGI9ODj6HYwnOlIidg0/0Veg7u3JpS/fNMrkQGcEYo9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269291623"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269291623"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="602838703"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2022 00:53:52 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 00:53:52 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 00:53:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 00:53:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 00:53:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aimt18Z0OsCFATmjwuGVy8lk6z7BFX3K6TIuGHTp43atPXkQ9FJVuiw9nBTs7X8UC4qOdeQtKgmZoCOC7Lbawz6IELG9DLvw10p60NoC+exn+Jx7mtQ0HxxAvJyJwEwzUAgJ4SZDQB/J8pnF4/q74BeDyVy9aUALfKV5Rg1tjR24oCQx6jwqBLrJEEZzxGHPr+5rGAkc61YpX8LL+eXXdPYr9mWatK5/XLPAXfzbp1cbVAHCMoi9IIekhY/1VAQh6papS7mvabM/OYeQ5RENJRQJHsEv9isKixJC020EAfEULGXKHti06kV5Z7rwbd+hxfm/oMPJH/yahMTLSfLS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yLw0bCx2URDww0C/vokrf6P/J2WI34jM9WcFvjnFCA=;
 b=QUD8ivYvgplSCsgc/b3dPWOcGi2o7iCbSaEa+NL0UhoBqGJHFThlU8VfJZ2FQ9onXbcBmbnoFCNTaodovTJmu9zydOdtWJCMFdKedN+nn1fPjYk8ndg5MiFsx0Uiid4dTMG/bHUO0PqAyp8xZcOB/M9bb2+DqNA5q5RtYNhWJmoWVjXhG0dNncwsDjB1rZDW6hE4AobPmvkaW2DPvdoLxaxSceTquDZs1gCUfo4pmCun2mQFjG87a24gXBxpMZ3+jlXy39jmhmuhGVpzVFx8z4vYTjoIWVV/azls7dbyWAHjpOFpeEShd4rcs/NEQc+4HweZ7o4RoJV0zPXDluD1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 07:53:48 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:53:48 +0000
Message-ID: <7a08a1d2-27f3-ae03-5ed8-91ddae2730dc@intel.com>
Date:   Wed, 11 May 2022 15:53:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Content-Language: en-US
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
References: <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1>
 <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
 <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
 <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
 <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <YnswSZQAfRAWr+z0@ziqianlu-desk1>
 <4e9d67b4d2ed8b4851a93b2a79a04e860d1f36b9.camel@intel.com>
From:   Aaron Lu <aaron.lu@intel.com>
In-Reply-To: <4e9d67b4d2ed8b4851a93b2a79a04e860d1f36b9.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c0718a0-f1c8-426c-42bc-08da3323615e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5769:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SJ0PR11MB57690371E763C847E08FB9CC8BC89@SJ0PR11MB5769.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpMFUEWhoEiqLBTLzDwu3CsOHL94n0w2Lx8p/bIeRaBQjbevFOmOfxfkC7SjSVvbsqbThMWQIjX36BxnfHtr4DfCHYlsfH/b3lEyKXukafierjhtZr9DxT9Nm7JtIHHgI7TaRztZTOE9DSux2hgiggfIzPYHugWNiqDMoNuviCQ0hcuQL0/RvP7YXj8BnpoVY0xxV6+152CKYL6LJ0YxwJNhHD1SIp0ID3c7NMECbmDJ8fHgW9+SZv/AInnmS89zzF0IRKWrieb0RaQYrL+0J6SPtZ0mduSJ293HaO5z5IWlJl5iy7rPhGcG5r3+G6XainMUceUA4a4QBXsuskRlOWp9/tlCSB33DQ/2mB8FXCg7eLT1AkV+EoZU479APOVDBG6Ub67VDaK0hjxq6tqxB69zt78IEl485wSEmr/PQp5HPq0wQkTwAKcOf+fR0x1s7oCEkhnP+ne/70qcjX01eWGHC4FKPoSR6r/7IvRXeduK8JyxA+RAsG3r8qG0A481jLzyrtNlQibQxY+bYJlaQZ6aJeIFO82+d34RxDn3o0i5wIgqb7rHZI3oefgMU+bOsEJqSTdoJKiPYUD7sLyfHUzN6GdE5SEMRMoq/VvDjHqYKd412M91vA8PAiAT+JeUK+ohje/3bwKeupaxYgDUwWpBkXZ9pkRGvxzQyxVEdr2E0lHxFPKpAunV3XP8HBbkInYxkp6o3jdLoc9vzR3KB8UBU3U1EzHTZEegt+zttpA9CTAqjRxVjnANxC84660Iwj5x/8P69EaaYm5LRvmH9/7Ta5LuEtZ1760JeTxmt2RiunByyAa53yLX+xR9d8jb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(186003)(83380400001)(31686004)(44832011)(2906002)(2616005)(6512007)(26005)(36756003)(8936002)(508600001)(7416002)(82960400001)(86362001)(5660300002)(966005)(6486002)(38100700002)(31696002)(54906003)(66556008)(37006003)(6636002)(66476007)(66946007)(8676002)(6862004)(4326008)(6506007)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEtocEgwK0NER054KzFJS1pTVENOUzhKYkkrS2Z2OG1Cdmdmek1ZYzhKQ0pr?=
 =?utf-8?B?Zmh3STRET2V5OU14YTYwUk5lMkVzVzRBUFFYYjNsUFM0aUdmbDQ4dXg1WkNh?=
 =?utf-8?B?dGJvK09xWXQyRmx2dVRrdkZubWxkMzlYdmxZSGYxRFlQTmNaMkExWEt1ZWsy?=
 =?utf-8?B?QkgzMkxvdCtkNC9tb0hNRnFYdm5aRWtZaFFjRjZDNS9WYTZTelZTWkdQWUU0?=
 =?utf-8?B?Mm40bWJPSXZaOThuZ1VGUXhnYVBWTGVaTHRNcXZrWTVJMWJVYUpueSs2aTMy?=
 =?utf-8?B?b0J2Ymk0K2dkMFZ4WkdsYXFyd1FqSHplaDJUZkVublNydjJwMEdWL25PSFJv?=
 =?utf-8?B?bXQ0T3ZsbDJ6M2dhNDEyTDhicm0wdm9qck1QQXRrZm9jdUR5aXg2dXA5eXZS?=
 =?utf-8?B?b0FVMmE0Sitac3hwZlpxaTBsZi9uNDR5dW0wWnZZQzZGN0d6b3JJYnkvZkhw?=
 =?utf-8?B?aVk5TlUrNlJQVk9nSm4xUnZ3cHY4b280KzVNSHF2MDd3cHBOU3ZwemovbFVt?=
 =?utf-8?B?WEhZakl3ckpJUWRYL3cyQmJEaE5zdDNWc1BzRlhaQU9jeEwvMFVwVDJFM29u?=
 =?utf-8?B?bFhJQWQ2VWlEeUx0OUdaZkRYSUFuZTZwOEZjRGxZVWMwK3gvRVhkUmJEbGYx?=
 =?utf-8?B?RzhFWVFGV3l1NkdSeU1YZ1ZjQW16WGwrckl2bDhxV25SNzRvbm9lbjJQRFow?=
 =?utf-8?B?bmJ5RS9PZXExT1VJSytzeFQrYUlEZGIvak9qajNIQWFtNXIzVUd0SjQxbFk0?=
 =?utf-8?B?SVErQWpPZHF0RlBISjdLTDhYUXNMZS9vQ0ZQUGNmUS9FcUJoZGhpbzB0TS9o?=
 =?utf-8?B?V1c1WGh1TkxybHV5QUNyRjJWazJmMTZCcmw1dzNyMkUvamJPUGplRlljbUJs?=
 =?utf-8?B?ZHZ2YktrY1FZUmFyL1BCVVAxazNOckovZlNobE91YklNUjU2a1NoTktwUnVC?=
 =?utf-8?B?SGtzM0wvNGRBYnpLZ1Y5NUtOcDZnZVVvY2NHb3dURGVBZnhGYUsyWEtXVER0?=
 =?utf-8?B?VzNNOTN5dWppeGVqcTYwZ2llVzlXQzY4REhaM254cnY3anpvb3hJUXQ0KzZO?=
 =?utf-8?B?VzhvMS9tQkVQYUl0TXY2NzB1SzdQZ0pnNTdMQnlOVlhOd2c4QVpkZStjMk5B?=
 =?utf-8?B?RHFHbmN3dURxYVNlY1BwMit5QlBPQTEzS2RjaXcrRlNIajhMOEV5RmRVOFNQ?=
 =?utf-8?B?dk1pV2tVMnRLY2FJSW81SldJTm5Zb0t3RTZBbHhEVWUwdENjekJ1NHVNRXJ0?=
 =?utf-8?B?bEVkOGs3S0JtUjRKTzUrbE5Ha2F6ZnUydE5aVzA4T3krZisydUwxbnN5Z2hM?=
 =?utf-8?B?WFhKNlhObjdBdzBpOTFlUHFFWnYvREw0VjVwVUFCb3h5UklhTS90eWVsdE5S?=
 =?utf-8?B?SXpnN0tBMkdFYnJxb0ZtdWxQT01aUlhIalJEMDdFVzNlSk43R3dmN1BISkl0?=
 =?utf-8?B?bk5uWWtvcXN2L01kQ3hiRThFaElkYzdlWTd1b0ZNY3R4Qnp4V21VVC93bnpX?=
 =?utf-8?B?dE82WDRMNjFCRUV5dXdtQ0hpOWFLNmZWYXhIYzBObmZWRjA3NDlSay9MdFJU?=
 =?utf-8?B?VDliZEhZajU3Tm5pQ2FsdlJFbVFZQ1laaW1sMVNvaDZxY25YUE5iZWFRUnFk?=
 =?utf-8?B?MFh4V0VhNjh0dzJwUkhUdEovZWJqWW1IUVVyYk95SW1uS1dpc2NFdnk4eUYz?=
 =?utf-8?B?UG52Zm5jVkVHTTRBOHA1a2VnSTVmOVNjZDU1bTNidDZDNDFHNWNIRHEzQXJH?=
 =?utf-8?B?eEpGY2ZkZE1uWTNUbnpvK2RIczY2Sk1TZ2RrUzdXbnFEOGYvL2xLMDJVOG5y?=
 =?utf-8?B?K1lMaDFZNlRTS3FmdCtqY3hPOEUzZUc0RG0wNWJ2WGJGR01KbU44S2ZRQkdJ?=
 =?utf-8?B?NXExcVVUNy84eHRXZmE5Uk5jN2gwVXhlelduZCtxdWk2NDdRZ2x5Qno5TjZV?=
 =?utf-8?B?Nkp2Rm1vN1lXYkF4WTJkdWY3Wmtvd2JVYU9OMjgzaTI3OFl6eVZSRGFxZWtI?=
 =?utf-8?B?Z0NjamVRWjV1TW5aMndBMzk2aHpVM3RQSWdTblI3d2xPaUpiMk40ajlyV3lo?=
 =?utf-8?B?ejY4WGsyd0R6U3ZyZEVVSjdoUUVnbUZ4SU9ZQmtENE02RkIxc0Fua2NsRnFM?=
 =?utf-8?B?NkRWSGVEaGRhOUlhMVNyUUJUVEg5NzB5M21tcENXNjhaZmlyakJYMnl5RXlV?=
 =?utf-8?B?UjVrK295TjZaZVh6UE10U3k0dVpEQUd2S1pCRjhLd3NldENIblMrQ3NHdElI?=
 =?utf-8?B?Ym1BSjVxTVBKT3JaWjdSSi94YW9MZW0wTHNaMzhVYklBUHgwWlhEWHV2R3lv?=
 =?utf-8?B?SzZ6b29TeVJwaEhtc013RUxIZWQxT3N0K3M3T1BLd0NvcyszbzJwQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0718a0-f1c8-426c-42bc-08da3323615e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:53:48.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpdLnvLPUlueIYZOZiLhlo4gcHDxbvpPHWvVe7X/82HOCfg9Uz49ch8Jutf86imUm8AcMDFwpPjgDkDjG0RwGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2022 3:32 PM, ying.huang@intel.com wrote:
> On Wed, 2022-05-11 at 11:40 +0800, Aaron Lu wrote:
>> On Tue, May 10, 2022 at 02:23:28PM +0800, ying.huang@intel.com wrote:
>>> On Tue, 2022-05-10 at 11:43 +0800, Aaron Lu wrote:
>>>> On 5/7/2022 3:44 PM, ying.huang@intel.com wrote:
>>>>> On Sat, 2022-05-07 at 15:31 +0800, Aaron Lu wrote:
>>>>
>>>> ... ...
>>>>
>>>>>>
>>>>>> I thought the overhead of changing the cache line from "shared" to
>>>>>> "own"/"modify" is pretty cheap.
>>>>>
>>>>> This is the read/write pattern of cache ping-pong.  Although it should
>>>>> be cheaper than the write/write pattern of cache ping-pong in theory, we
>>>>> have gotten sevious regression for that before.
>>>>>
>>>>
>>>> Can you point me to the regression report? I would like to take a look,
>>>> thanks.
>>>
>>> Sure.
>>>
>>> https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
>>>
>>>>>> Also, this is the same case as the Skylake desktop machine, why it is a
>>>>>> gain there but a loss here? 
>>>>>
>>>>> I guess the reason is the private cache size.  The size of the private
>>>>> L2 cache of SKL server is much larger than that of SKL client (1MB vs.
>>>>> 256KB).  So there's much more core-2-core traffic on SKL server.
>>>>>
>>>>
>>>> It could be. The 256KiB L2 in Skylake desktop can only store 8 order-3
>>>> pages and that means the allocator side may have a higher chance of
>>>> reusing a page that is evicted from the free cpu's L2 cache than the
>>>> server machine, whose L2 can store 40 order-3 pages.
>>>>
>>>> I can do more tests using different high for the two machines:
>>>> 1) high=0, this is the case when page reuse is the extreme. core-2-core
>>>> transfer should be the most. This is the behavior of this bisected commit.
>>>> 2) high=L2_size, this is the case when page reuse is fewer compared to
>>>> the above case, core-2-core should still be the majority.
>>>> 3) high=2 times of L2_size and smaller than llc size, this is the case
>>>> when cache reuse is further reduced, and when the page is indeed reused,
>>>> it shouldn't cause core-2-core transfer but can benefit from llc.
>>>> 4) high>llc_size, this is the case when page reuse is the least and when
>>>> page is indeed reused, it is likely not in the entire cache hierarchy.
>>>> This is the behavior of this bisected commit's parent commit for the
>>>> Skylake desktop machine.
>>>>
>>>> I expect case 3) should give us the best performance and 1) or 4) is the
>>>> worst for this testcase.
>>>>
>>>> case 4) is difficult to test on the server machine due to the cap of
>>>> pcp->high which is affected by the low watermark of the zone. The server
>>>> machine has 128 cpus but only 128G memory, which makes the pcp->high
>>>> capped at 421, while llc size is 40MiB and that translates to a page
>>>> number of 12288.
>>>>>
>>>
>>> Sounds good to me.
>>
>> I've run the tests on a 2 sockets Icelake server and a Skylake desktop.
>>
>> On this 2 sockets Icelake server(1.25MiB L2 = 320 pages, 48MiB LLC =
>> 12288 pages):
>>
>> pcp->high      score
>>     0          100662 (bypass PCP, most page resue, most core-2-core transfer)
>>   320(L2)      117252
>>   640          133149
>>  6144(1/2 llc) 134674
>> 12416(>llc)    103193 (least page reuse)
>>
>> Setting pcp->high to 640(2 times L2 size) gives very good result, only
>> slightly lower than 6144(1/2 llc size). Bypassing PCP to get the most
>> cache reuse didn't deliver good performance, so I think Ying is right:
>> core-2-core really hurts.
>>
>> On this 4core/8cpu Skylake desktop(256KiB L2 = 64 pages, 8MiB LLC = 2048
>> pages):
>>
>>    0           86780 (bypass PCP, most page reuse, most core-2-core transfer)
>>   64(L2)       85813
>>  128           85521
>> 1024(1/2 llc)  85557
>> 2176(> llc)    74458 (least page reuse)
>>
>> Things are different on this small machine. Bypassing PCP gives the best
>> performance. I find it hard to explain this. Maybe the 256KiB is too
>> small that even bypassing PCP, the page still ends up being evicted from
>> L2 when allocator side reuses it? Or maybe core-2-core transfer is
>> fast on this small machine?
> 
> 86780 / 85813 = 1.011
> 
> So, there's almost no measurable difference among the configurations
> except the last one.  I would rather say the test isn't sensitive to L2
> size, but sensitive to LLC size on this machine.
>

Well, if core-2-core transfer is bad for performance, I expect the
performance number of pcp->high=0 to be worse than pcp->high=64 and
pcp->high=128, not as good or even better, that's what I find hard to
explain.

As for performance number being bad when pcp->high > llc, that's
understandable because there is least page/cache reuse and this is the
same for both the desktop machine and that server machine.
