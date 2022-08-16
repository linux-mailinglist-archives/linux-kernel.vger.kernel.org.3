Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34DF595745
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiHPJ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiHPJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:55:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788D172FFE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660642171; x=1692178171;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k79iK598j2yZFmkIg6nwv4xvC+z9QDE3cc1rjqCmYX0=;
  b=nfQGoTQdgpmJxpo06iYO28N59isElQamKv9dpU58hgt05LhR/gDzx630
   WMKu4eYC0twVndoTg+eRTmBnrTckUd6KWiG0OpryaaJqKitKkROIcczCR
   StaXafhRcXwggctaWvRkw8P5AtPvMskxiQmREsRjG2UAxMYQczXh+/O6i
   zwgPMzVpaLDLq3zu7JvP0oGFs9u8LUBjv24CLf9XAUbv7RPWv6h2sOgAt
   4fRWjYHWyGjTn77cxZZD4dqY9ij4tXeQnpysdB6nPLOekQKv2t0h7iaQy
   8/yKp/gXX6O4OtBwLIDBpF/4eWf3cwqjvXu9UC594BbKcrloTQlaEIvWZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="272564892"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="272564892"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="603459243"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2022 02:28:56 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 02:28:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 02:28:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 02:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9ojSYRzFibr3yZ758LZytRhtVaAaqpH+XTZGFacDF8c5J9cjCneEUIaOViUbth1hyUYo0s+Nm0cULhXI8TVizMVZQ0vdEgsY2WcVt51ILErThTPZNTdfD/0EBQlNWwWITNpdsJ+vsc7Lg8xRzCVHS7h1nwJOGk7RYBU5gAstru8moRSZeLSMEsvJfzZ5rovL5ZFPdcGetyIWv619r9Or/CK+KdiOxCGFKTMvFxYV7upEjA0fZjsg71UzlbYdbXtqEeHxZy6Rbpn7B3d2BTz46a2skzybt5EuVkGImaN4uRVUJ/B3jB9ldAwKWEH6WUZvc6fm3gpYxo43V1J4FI4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX/YEyrG7VsFO0RqIqwhkG/aoJGv4LbyF6fC1AWii3M=;
 b=SsnphHjHYBcKpXXg3mdbb4c84qM+7589xIzSt7Ur8gIKptp/1HWHat2F+8pQg0Zde5LBq7gTe49ESwjwofKHr/lDCXQ9nd3jGfBMkmYH3bmkDJOMghTYr7l06CUntD0rafC3z23E20lCrecV2MwLNUZ4r07V35UaSIidJdWGuA862h+AZF/Z47kAaDdfzPWKu9slfH1u8dVsAbhUoGwnwcMdjfvFdLzLl5KgCWPFkek6bpMVgH9ICKzTLGOVOeeX2pcQSZRFrROe2PGxS8urT2PGyE+Ar6h/9q1btErXJEtvBjNov2G0Gax8PrJV1J0nP1LwW0TSJ9VU6NPgpBTwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 IA1PR11MB6491.namprd11.prod.outlook.com (2603:10b6:208:3a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 09:28:54 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 09:28:54 +0000
Message-ID: <3f9402d1-6dc8-5f64-dfce-3fb895b80bc1@intel.com>
Date:   Tue, 16 Aug 2022 11:28:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "ALSA Development Mailing List" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com>
 <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com>
 <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
 <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com>
 <CAHp75VfvN-iJTpgg6JeKhOqJLhtYSieo7d7SOCBoUu-81FtSqg@mail.gmail.com>
 <c19ed4a6-6a96-b4a4-0f5a-7ca1dba925d1@intel.com>
 <YsnoH64cKCT7gndw@smile.fi.intel.com>
 <2c6a4a61-e6c8-0487-8d29-dc3fbb90bbe2@intel.com>
 <Ys2EFtNVL8ZALQ5Q@smile.fi.intel.com>
 <acbaf339-2fd9-5b19-06e8-62e66c324dc6@intel.com>
 <CAHp75VcVEEUYf2YZLVMby_v4fNpA0upAB+YkWwrPxqV9R+-YZQ@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <CAHp75VcVEEUYf2YZLVMby_v4fNpA0upAB+YkWwrPxqV9R+-YZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::17) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a486df-9aeb-4902-10b2-08da7f69bc94
X-MS-TrafficTypeDiagnostic: IA1PR11MB6491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oo8eD5KR0WWPrJoh2POvOLLl3paJxt8na6xpme9FUZOgaCweXsD/XPsp+9dOtwKxwnwbk4gktniXqIqNTs9ABAIHL8lI62alFNR5jbAZAHWHb3eN8UnKPU6aTJSu62UD0RGBgHeCJ/mh1ygSpfND1DBuNcLsbGv3k9ZIweBGaazi+Upws5NjM7yGA3NWcwMoN5MgPUoqTYrM5GkF8Ca8Y7hV5r1ZJ6QcqI9cA2UFeaGq9zC/lRicyUZAl38E7fLGI0B1jOJlW7nrPybdChZuZTOl8xirZ3OZstJadw9mLYb/1Cl7NaGIPARByxXLBAwWC6HULvAVkBnQhJZV2Nqr8+6aHwkyhqe7RlIPpQC9WsKmPijXsNEEvUOZbP+Q1R4BbkjOUFCXSDSRcJk+b3yN4QMnNUps4tJEMMjjvJq3Y8XUKYMFEMa3lo54+fbkwuoXRV70OdMC8DXzo0daUN3hygun9Jty+QiawXceDb4wdTT2601EEWSMmP/sLsrgnV88HthiSe7pj0vKFWUWmMxnOP0fNEPKqS5t+DJ8FKoe9W2r9uK3AACl9cy7sd6+KupBTxrD5cFj2492rKuMWRi0mB+nZ87hCw4mtJrTCYfHgrApQ0y6PsccAhCkwCEonvpZNWbfYpMQDs4RfqP3pkHb4bJZXdkJH2KR+lSXMkEN0hQk0JswIy7vjKgDS8NMB4NXszf2fh0pRiU3+fbgAVO66rmHUJQTpP8XKv46eqaFlIvB4eKx2J5/yNPfLsMXZjFPKrGvT1yJzObrvgvgL5avsIzqf91BTACsiV+AVrTHLjcv4qBzh1juXKkGs6qJse4Fy3mOE+liklGisCBBfjt3bFMep9mBiICdcddh3XervQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(39860400002)(396003)(346002)(38100700002)(66556008)(316002)(54906003)(6916009)(8936002)(4326008)(66476007)(86362001)(66946007)(44832011)(31696002)(5660300002)(26005)(4744005)(8676002)(6666004)(82960400001)(53546011)(6512007)(41300700001)(6506007)(2616005)(83380400001)(478600001)(966005)(7416002)(186003)(31686004)(36756003)(6486002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVuUHVGUXdJUlpKdDR1NHBWb0l4K0dZL3VIeG85L08xai9vd1gzSVRXb1Aw?=
 =?utf-8?B?ZU8yV0plQURvNTlkT2RaNGNDQTRRZE9Sc1FoUTl5djYwdEl6ZC80ajJGMDB2?=
 =?utf-8?B?dTJKOEZnbThaSS95WnlCR0pMYVNDNWNNOWkwNkVEcHlvSmdJdXhneGY0VFN1?=
 =?utf-8?B?aXBROVVJV2tiUkF6M3RDVjZFbFBPUGNzS1ZzYW5lQUljNEFUMDljbW13RFhw?=
 =?utf-8?B?SXZTZkhQUEUyYVFRaS9zT2NPNS9hVVlsOVduOHNNWGxzcmVLY3VTWkdzUXRD?=
 =?utf-8?B?Z3VaZE13ZVBMMGMrQXI2Vm1wamkxS25kN2tEQ1dkbUNjbXJZWFlUYmRvaWtz?=
 =?utf-8?B?WE5KKzdGSm5Fd0hlU1MxSGJPRDAybHdINkRJMEwvQWxXdnFaUkFURVFJZk0r?=
 =?utf-8?B?THRBc2syQVhFc05NWENQSzFoMmtOT2hjVmJOalVKNHR5d003Q0Z3cjJuaVZ4?=
 =?utf-8?B?LytlakhoQ1l3RmJyR2xnaUtCWmlQcHVQMkg2ZmFXN2I5LzJkR1VFcHh2QXN1?=
 =?utf-8?B?bmJEZTdYeFJKbXZFRGExblV2cjZoTzN3QnFpbVBYbGRzNzRGZWl0L1VyMEgw?=
 =?utf-8?B?SnRKUSsrSnVDUTRZMElxTmdnMG9EMnJJZU1WOHlGQ2dIWVZBOWIxeGxWTFU0?=
 =?utf-8?B?TitpWjgzd0h1enNZajV3eHZtN2gxWk1iL3pxTjV3VjJ5dFdMZ25hWVpicEty?=
 =?utf-8?B?N1daZ3J2M08yQTdEaGtqUGtLR3FGcHN3S2ZRQWFwMlY3ajVmSEdiUUdxR2hp?=
 =?utf-8?B?RE9Oczh2QUJ3WTJORUR6c3ZSRlBSS1lZSUprMTY0VnVSREFLVDcyL2Rhek5k?=
 =?utf-8?B?RGxnYUZpR3ROQ2ZuTHFSNEhoc1YxenQ5aXNVUktnUHZ1QmxKT3duVHVqdGF1?=
 =?utf-8?B?UThITVNCanIyWi9UU2Z0eE1abmh6b3RLb3YyTXdlVGdhbGxoL1NZZ0VPekxp?=
 =?utf-8?B?YlB3bER1b05uK2JWVzUwSVZmRWJ2aGtpd0t4WjVsMEdIQzRIOHhjay8wZkRF?=
 =?utf-8?B?b0dFdUcvbGllM2NhYnBRdlBHcHU4cVBJZTB4YVFGU0hDZ29rcEpuNjhvSktS?=
 =?utf-8?B?cndqeHhLK3duc2RTMFBFZEMwN281ODFPRXZzUmJ6YURpYmdxODNMRXQ5QURq?=
 =?utf-8?B?amZMQW4wQ05ZUzRmUXI0dStxY3VDYmdDRU1PcmtZQm1YeWpPZ2pyS29LVVVT?=
 =?utf-8?B?KzAxbDFLYzMyK2tkZkZndVphSFMvMEgvU1gyZE5DR1M3S2hpSWZhR25hTit1?=
 =?utf-8?B?OXA4OW1BNWF0bWdFeTYzOS9objV6cmo3bzl6SHI4RjIrSVJ6OEwzMFlLUW15?=
 =?utf-8?B?NGZpaHQwQ0ZEcDRoZzd2aW8yUEx3WXVDU1ljYnQyVW1DMUJDZUlIcElHWXRB?=
 =?utf-8?B?ai8wb2IwTENoUkp0RVI1VGJ5TXh3cW81VWFBdUdvWlJJNlN0NHVaeEVGQ3NB?=
 =?utf-8?B?dXRUZmZiVENEQytDTjVUNmdXSTBrV25zNDZXWElxOWZYVjBmeENPb3lhRlJC?=
 =?utf-8?B?MlN3N293RGRmVGZaZ01nYVZSalF2cHIwTk9JSkx5M01qbGMvZjNxTEpLbXF2?=
 =?utf-8?B?T3dHM045bnBFY0Y3dVFCYTN1S2NRZnIrWGFwUEZnQ05sckZxVExYamxpV2lL?=
 =?utf-8?B?MS9TV0wvVXh6emRGeGY1QUVmT3dwL0Z0Y29NMnpQdmdhN2hYc0dnNVJnbUNh?=
 =?utf-8?B?aXdiYzBaay9vZzRSZHY4Uml2SXhoMEdOM2swTVBmQW9lMjdmT1hxTVB0MFhn?=
 =?utf-8?B?S1dSa2N4RG1BWXZIV09kQlc1N1U5RGVnMVpDM3lTWm9CRTFRZ1B5UXM1Z25k?=
 =?utf-8?B?bzFoSmFvRmNIVUt6QmRySjEyUzFVcFEzKytOMmNuLzhaOHY2am1lZ0t3cXZR?=
 =?utf-8?B?T2lMRnJaYktZVjVQS3JDZDkrZnBobmNnY0RneEFnZGZKL2RmblR2bSt3U3c3?=
 =?utf-8?B?NzNRMmthUUUxbTN1N3k0elJwdk9mNjdOK3hXbG9vbW9rUzQxZ0RxVTNzQjFr?=
 =?utf-8?B?WkdsWE9FSi9Wc1VNTVVKMHp0RWRkdXFGL1d2cWtYZGN2RDhvN3RSMjdGMk4y?=
 =?utf-8?B?d0RRcVlrblhjY255TWxaeDRFS3htcVVlcU1YdFdDTmxLRVBSK0tKM2ZYYVBC?=
 =?utf-8?B?V2dxbDhONlh6MjhhOUFQemlEbk4wSUZTNkpjVDdnZ3FBN1pHcHEraXB4czNL?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a486df-9aeb-4902-10b2-08da7f69bc94
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 09:28:54.1439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fk75CaFhPwsfx6dUd+zK05D+aJJEjO2oaOUcEZgH7aO/h7J+6KYYUC8bkfoCxa5yRj4O92KwQnVhG5t/92hCLYgdJCnmkczSRocceQ4Fc6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6491
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

On 2022-08-09 5:23 PM, Andy Shevchenko wrote:
> On Tue, Aug 9, 2022 at 11:55 AM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:

...

> 
> I guess this may be simplified with memdup_user(). Otherwise it looks like that.

...

> (You don't use ppos here, so it's pointless to use
> simple_write_to_buffer(), right? I have noticed this pattern in SOF
> code, which might be simplified the same way as I suggested above)


Hello Andy,

Given the two major suggestions (memdup_user() and re-using 
get_options()) that had a major impact on the patch are both provided by 
you, would you like me to add any tags to the commit message? I'm 
speaking of Suggested-by or Co-developed-by and such. In you choose 
'yes', please specify tags to be added.

By the way, I've provided 'the final form' on thesofproject/linux as PR 
[1] to see if no regression is caused in basic scenarios.


[1]: https://github.com/thesofproject/linux/pull/3812


Regards,
Czarek
