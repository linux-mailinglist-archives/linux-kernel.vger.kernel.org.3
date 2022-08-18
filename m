Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B0599186
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242136AbiHRXy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiHRXy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:54:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC6B9583
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660866865; x=1692402865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l3Rr7WnRMv64juZu6T2qfDn8juhhkIfth6CoeWmZChA=;
  b=kyuz9x0V7UomSn8fbb77ZTY3lEc63sFYhULggQAaJyZodmJfLxnHbrcU
   ndrLsRwepFBhs5rRptTDAAtONIsEgz9XpeM63xsPytVLsN2VSO9VddJtB
   wBD+QXHuuRHuoDH3wmSkSNLjbSnHPhnMo6vd33t11FUe2mMFaWGb8ZEy8
   7cXygNCK9QazL2+B5fOYrFU7HkP2eHpY3GfN6ycFL7DQyN0GtyaL+CywN
   bMca/BhePCWPlBMcPQJMnGHU2rgvMUvZpiO0CxMY4gw1RmvBft5sGKWPh
   xEcgVSvRcK1FKnz8AqnmJY1RA58FFkYRqMEjc/dE+L+fcv+6s6EUURvxt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="318919812"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="318919812"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 16:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="853590293"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2022 16:54:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 16:54:04 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 16:54:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 16:54:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 16:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7JMikfuW2Am7pKQxzjGekAhJXyVUKAzdIY9GTE4daMDcpYzI+oUm+JfD4L/jg5zEiexo/81/ukEM6fQmpqXt0XoedKy7Zss4zP9TWNaO+QEuFSmKh6BS5Su/ILo0cK2sE85NmYOuToZvmNkZ3R4Tv2mahaEMoU6sEcYgVGk6tWAIVei4lnJdQ/6cWkw+u/scdHisUKQJhUZgrNYbVXlULGPXSxIAKqQbTRHu8bQmL2CiYt7mLPMC29CsqJwQbxziXmi2lq40gdRI+C1gWymNgHTg8FCIC5pypvRd5um36Y96qYHanWVVg6b9sdUN1w8rBOBGbpZAXJ9wBJ7PpNpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dmwg2ECESFT5kTXB2ealv4aamW0VW1Pd4c5GYBRLnXY=;
 b=MZrvUAUY8ZhGQLB5LikEPEsW4CSbTCF0sIaSGBveHLXC7wa4xtl6JXXnRedJqL+veleQAb2bHAuJ7WlZZdkpqP0ldklCMXkiyMUxS7Z8wH41A9kpMmFKR4uVwo333PJ+JJ0ebCWnFV2TwwKnD50P0avP8zdzwoDBe0uXfeh3+9cyccrsXxsP0FKQGnyl7i7fpodtmr5uePza612O8T19hKGB9UYU2Ps49y8UjcBVJFLi4z2ytTC8Raa9o6UIdGGnBh5ul1jCCBSCXS4uYFBoe8MwVlO4fpZb1yZ9dxmFQrejCSfxeniOJ0MHJT5Zm367+pIROYymNZER31KSLSLbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB4938.namprd11.prod.outlook.com (2603:10b6:806:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 18 Aug
 2022 23:54:02 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::fcda:4c77:5786:209c%4]) with mapi id 15.20.5546.018; Thu, 18 Aug 2022
 23:54:02 +0000
Message-ID: <924c974d-b6f9-04d6-399f-31f4ddfb3f44@intel.com>
Date:   Fri, 19 Aug 2022 07:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 4/6] mm: hugetlb_vmemmap: add missing smp_wmb() before
 set_pte_at()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220816130553.31406-1-linmiaohe@huawei.com>
 <20220816130553.31406-5-linmiaohe@huawei.com>
 <D8C00BDA-160D-40CE-AFBD-9488F85E76CE@linux.dev>
 <ea67ab10-667e-f361-b80f-dafb13da4808@huawei.com>
 <0EAF1279-6A1C-41FA-9A32-414C36B3792A@linux.dev>
 <019c1272-9d01-9d51-91a0-2d656b25c318@intel.com>
 <18adbf89-473e-7ba6-9a2b-522e1592bdc6@huawei.com>
 <9c791de0-b702-1bbe-38a4-30e87d9d1b95@intel.com>
 <931536E2-3948-40AB-88A7-E36F67954AAA@linux.dev>
 <7be98c64-88a1-3bee-7f92-67bb1f4f495b@huawei.com>
 <3B1463C2-9DC4-43D0-93EC-2D2334A20502@linux.dev>
 <7fa5b2b2-dcef-f264-7932-c4fdbb9619d0@intel.com>
 <C6F3DC27-4819-43A4-B884-DD3D03A2DF90@linux.dev>
 <7408156a-f708-5e73-d0a2-69b1acca9b96@intel.com>
 <15DD6DCA-39BC-4EA2-984F-D488E94CC4FF@linux.dev>
 <615c8ec8-6977-2ce0-f049-d2ec1619245c@huawei.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <615c8ec8-6977-2ce0-f049-d2ec1619245c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9eae6b3-bea1-4851-3ccc-08da8174ecf7
X-MS-TrafficTypeDiagnostic: SA2PR11MB4938:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c56GBgzme1CSNjg+ATClYXfE+0YCgIfsYvPKepXiuo6duLy5SiFUaJ5oQ0POkLV3N7CSPauDd3TBdn7wLqCUCxZ3F0GVP9WXSAIFpn9goKCzI7y3XMMAlpr4qRMj7jnTenMW2v6mT1xieNIGdf3g2afdLHq174kuq2D37M1KtEytwOE//pBCJOqWNjWsJ5BjJa6ZyF6fYTsfZyiz3y+eLs1evjDKPRx0D+Mxnidu+C206W5k3bSQMOlcg4c0jbjOxsh7ao01ZZVetAPTMJ0PAERJreYnSNxO2qQP6ug5mpwJsp6c/vw2gii7WuIPE/v+vOgdc78QJxuCC3X4eXFPSk/uaRpGzMUrTQixntnzBnZP70edDW+XigZsyf8MnbklRVSIOG0nDZn38wg+HJPe09FAj8HjRIxfAaRz7vFWLN2a2cZj3LHjQ4mAcYdMkTncB1OX+QgijSklrfZrg8kFkbMjAJhx/rGYtbX4Ioos6UPp4xdpkl1QRiUTyId8uonZSoPE167De/2EAdp9JWO5dll/jwhFsLukE+Be7bqeTNPfTLTZYXxvky1IJSU5k8k2+9cMNwLiFkaa9mYsFbpm5BVCGJnhjByK7dalTYqQc8LqpCelRXTLy52v0AN2aYSTl7YLG28ibNynGiUFW8SN+NzUJrwA+y6dydnDBR28jX4ziY9FlhmntrAf2ojAvxwWKLk342O3TzRUZMHLWCij2lhTF97MhooLzzGnKJ5FknjT2f0saWvZ8EQxnG1rN1ge0HDIRBFA5jHIULD33M6o++DByq7cEDTvWa9EXNpC4Cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(39860400002)(376002)(396003)(186003)(2616005)(83380400001)(5660300002)(4326008)(8936002)(41300700001)(8676002)(66946007)(6666004)(38100700002)(82960400001)(2906002)(36756003)(53546011)(6506007)(6486002)(6512007)(54906003)(316002)(110136005)(26005)(86362001)(31686004)(66556008)(478600001)(31696002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9sdmRWd0p3R0xIRWdkNWZoN2ZvWU4zY2JTZnZZdjZOVHlTS1ZXcGt3dTdV?=
 =?utf-8?B?cnVjb2cxU2lVbmNrNFVNVUdmSHZtR0dwWVc5elFndExiWEZNTDVFc1g1Q1pP?=
 =?utf-8?B?VDNNRTBiUXdwVmk5NnVQdVpYQ3VvY0plcjhpcy9pOW5keWtveTRQUFBKREk5?=
 =?utf-8?B?SGQ3eW42NlU1aXNKaGJ3aStoYXUvcUlRSUhsV3JLNXl3cGx6cTRrYzJJWm55?=
 =?utf-8?B?MklZVE5vWkNpOXc4UUtrRFZGeEZLbGk1N0g3TXYvR0ZOTisrWStLcDdFMlhw?=
 =?utf-8?B?QlBERDMra2NPcXdrQk83VGtqSDI5cnZJV1lCdVV6cmRONjJjNC8zb0tVSDV1?=
 =?utf-8?B?cmFhQkZJTzJLQXh1blIvN3FxdnVDYWpOTzdyRGhRM3g1WjRzTXY2S1JmaVFO?=
 =?utf-8?B?RU5wOHJTN0dKa2ZDWUE1YUxhSGxqWkNjTkVlUnA3Uzd3dVRvQzNmSFAycDcy?=
 =?utf-8?B?cEo0Uzlncm52cC90clVoTE5ZM2x4L3ZheUVMWEVSVVBWTko2TUF0Uy9KUlpt?=
 =?utf-8?B?WWVVbThObGZMdWVpSXJIdmZWNi9KV1psc0srRHk3VHp2eG1DTkJtUHFVVHVi?=
 =?utf-8?B?ZXNmMTNWWVgxaUswK1pXRzZtK01zanluL1ppa0h1TkpvNmJEMjBDQkt4N0Jo?=
 =?utf-8?B?UTRQSHgzZWdNWFF2RTY1dGNzNG1BNmMxdXhMUG0wNzRtQ1ExTjR1eTUxbXFj?=
 =?utf-8?B?RVVaUjFCTnJwZmpRWFlSL2lOZ1FXSEpvQW5HRCtKTjlGZHpmYmZwTTlrMkFs?=
 =?utf-8?B?SU1iMytFbHZHeC9CbWdQdDNsZmQ5N0JOaGdQN3hNdVpHdlFieXc1VDJ6c251?=
 =?utf-8?B?c3l5Z3ZTSlhjRVlYSW1WUUhHZndGdzZibVVEQnpmdVRXeVpycU13K2xTRTZn?=
 =?utf-8?B?K2pFanNueU03bmRBTkJCTlFGVHljVjlhN2pQNGMweHdvbnE2OW1oODN6RHEz?=
 =?utf-8?B?bWJ3SXhpSXowcW9XWmd1NFZ5Z3NhYXVScHNDV05oYU5IOFcrZUJyeE9kbzla?=
 =?utf-8?B?WUl3eUg4dzZPcDZ5QWd0ODNSVk56M2VoWllYR1UvdzVIWnJRL2VLMExDYlJV?=
 =?utf-8?B?S2pCR0Y2TkZneHNkSVgrOUhYTmgzYWVXRS9YZ2NyQnhSaTJSZTJuc0RzSjRt?=
 =?utf-8?B?OTJBSGIwczlQa3kxTGVCOXpybWFwUFBya2pqMVdMZ041SHpUWTRWVUs0Q1NM?=
 =?utf-8?B?OHFoRkJ0TVk4TGMwMkw0VTRaWVdmY2lPOWJEalVTcE05NjJ5TU8zNlNINm9L?=
 =?utf-8?B?OXcrVGxnTVdiN0FadEtZOGJIMFA2ZGxxMnlpdjVVRHRiUUtWS0lSbVlLUTUw?=
 =?utf-8?B?QnBNcUFLSllGb0hGTFMwREtyMG5vaGV2eXp2OU1rL1laT1UwVjVUNERhcG5o?=
 =?utf-8?B?T3NEa3FhL2ZPc0hYU2dEbFlNWVNYcGltemp0R0hUZDJrNVlZNk82Z2hKemha?=
 =?utf-8?B?UWlWeTF3RmtOTDNuZXhsQ3dub3FQYmd4dnVQdEU4TTkxNlR2WXFxRk9wWW9N?=
 =?utf-8?B?UDhhd0FzM1FXb0I3QWQwMmg0QlJMMHRtMnF1VUNpVVIreDBhSmFxZ1lseE9p?=
 =?utf-8?B?RCtlZE9IWk1jQ1NtYlljQjdtNlQ5VmF4ZHh5MnFqRWlkUDZzeE5OUkpUUzFR?=
 =?utf-8?B?TVV1Qm5qWmI2TmlpS3pxL3RiR2tCYmZOQ3NNR0xNdFRMQ1RoOVM5aDlrd0pO?=
 =?utf-8?B?cnRMRXM0SnVFOE5WSkNwbmNBeDJRZXhveit4QzlZSzl3dTMzNzFGRTdReTlZ?=
 =?utf-8?B?aWhmd21IZTc5bk0yRjhTN3JlZHA5alNLRGQ0aWRBT1dTSFZwSVNjU1gvbzNQ?=
 =?utf-8?B?d1lqaGtKaE13ODJkTnJ6VThndkhKWlRxaitkd1gxd05zdndMT3VKVkFGTVpx?=
 =?utf-8?B?emNKM29uc0g0NnRkS3VBRUJNbEhIbFAwb0Y3RnZWbGtjanlTV2FheFBnMVRN?=
 =?utf-8?B?SE41SXU1Y25remtZNncyaHdSY3dPa25aUWVKdWlMTGRHRnJENVBuVGhXNUxB?=
 =?utf-8?B?clB0Y2d6S0RkZkVETXdPYmpmbWNCZGlEMERiZmMwL0hVa0tIRjhFUFJlbHg1?=
 =?utf-8?B?dnc1SWtKQlB4YVFoTTZTUW50ODk4ejZueEhQSTkzS3BteXZFdkh0MkxzNVZz?=
 =?utf-8?B?M2cxeGtEZlJPaDVuL2lzcld5czBOVmtVMFhkUG1wYUFTOXpremRzeWtVbW1V?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9eae6b3-bea1-4851-3ccc-08da8174ecf7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 23:54:02.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2+KZJVuZvyvQysc2RbpSoRLa68mGJb/MMAA04ftZ9Xkvf6HtAlRSdkw+eSt8qD5o0XdtuvoZWT0IKfCpszylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4938
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 8:58 PM, Miaohe Lin wrote:
> On 2022/8/18 17:18, Muchun Song wrote:
>>
>>
>>> On Aug 18, 2022, at 16:54, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>>
>>>
>>> On 8/18/2022 4:40 PM, Muchun Song wrote:
>>>>
>>>>
>>>>> On Aug 18, 2022, at 16:32, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/18/2022 3:59 PM, Muchun Song wrote:
>>>>>>
>>>>>>
>>>>>>> On Aug 18, 2022, at 15:52, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>>>>
>>>>>>> On 2022/8/18 10:47, Muchun Song wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> On Aug 18, 2022, at 10:00, Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 8/18/2022 9:55 AM, Miaohe Lin wrote:
>>>>>>>>>>>>> 	/*
>>>>>>>>>>>>> 	 * The memory barrier inside __SetPageUptodate makes sure that
>>>>>>>>>>>>> 	 * preceding stores to the page contents become visible before
>>>>>>>>>>>>> 	 * the set_pte_at() write.
>>>>>>>>>>>>> 	 */
>>>>>>>>>>>>> 	__SetPageUptodate(page);
>>>>>>>>>>>> IIUC, the case here we should make sure others (CPUs) can see new page’s
>>>>>>>>>>>> contents after they have saw PG_uptodate is set. I think commit 0ed361dec369
>>>>>>>>>>>> can tell us more details.
>>>>>>>>>>>>
>>>>>>>>>>>> I also looked at commit 52f37629fd3c to see why we need a barrier before
>>>>>>>>>>>> set_pte_at(), but I didn’t find any info to explain why. I guess we want
>>>>>>>>>>>> to make sure the order between the page’s contents and subsequent memory
>>>>>>>>>>>> accesses using the corresponding virtual address, do you agree with this?
>>>>>>>>>>> This is my understanding also. Thanks.
>>>>>>>>>> That's also my understanding. Thanks both.
>>>>>>>>> I have an unclear thing (not related with this patch directly): Who is response
>>>>>>>>> for the read barrier in the read side in this case?
>>>>>>>>>
>>>>>>>>> For SetPageUptodate, there are paring write/read memory barrier.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I have the same question. So I think the example proposed by Miaohe is a little
>>>>>>>> difference from the case (hugetlb_vmemmap) here.
>>>>>>>
>>>>>>> Per my understanding, memory barrier in PageUptodate() is needed because user might access the
>>>>>>> page contents using page_address() (corresponding pagetable entry already exists) soon. But for
>>>>>>> the above proposed case, if user wants to access the page contents, the corresponding pagetable
>>>>>>> should be visible first or the page contents can't be accessed. So there should be a data dependency
>>>>>>> acting as memory barrier between pagetable entry is loaded and page contents is accessed.
>>>>>>> Or am I miss something?
>>>>>>
>>>>>> Yep, it is a data dependency. The difference between hugetlb_vmemmap and PageUptodate() is that
>>>>>> the page table (a pointer to the mapped page frame) is loaded by MMU while PageUptodate() is
>>>>>> loaded by CPU. Seems like the data dependency should be inserted between the MMU access and the CPU
>>>>>> access. Maybe it is hardware’s guarantee?
>>>>> I just found the comment in pmd_install() explained why most arch has no read
>>>>
>>>> I think pmd_install() is a little different as well. We should make sure the
>>>> page table walker (like GUP) see the correct PTE entry after they see the pmd
>>>> entry.
>>>
>>> The difference I can see is that pmd/pte thing has both hardware page walker and
>>> software page walker (like GUP) as read side. While the case here only has hardware
>>> page walker as read side. But I suppose the memory barrier requirement still apply
>>> here.
>>
>> I am not against this change. Just in order to make me get a better understanding of
>> hardware behavior.
>>
>>>
>>> Maybe we could do a test: add large delay between reset_struct_page() and set_pte_at?
>>
>> Hi Miaohe,
>>
>> Would you mind doing this test? One thread do vmemmap_restore_pte(), another thread
>> detect if it can see a tail page with PG_head after the previous thread has executed
>> set_pte_at().
> 
> Will it be easier to construct the memory reorder manually like below?
> 
> vmemmap_restore_pte()
> 	...
> 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> 	/* might a delay. */
> 	copy_page(to, (void *)walk->reuse_addr);
> 	reset_struct_pages(to);
This should be correct change for the testing. :).

Regards
Yin, Fengwei

> 
> And another thread detects whether it can see a tail page with some invalid fields? If so,
> it seems the problem will always trigger? If not, we depend on the observed meory reorder
> and set_pte_at doesn't contain a memory barrier?
> 
> Thanks,
> Miaohe Lin
> 
