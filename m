Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849ED58D6E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiHIJ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbiHIJzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:55:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBAC220F0
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660038950; x=1691574950;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PDTR8DTqZxu7ItGrwP7JKonq5tQ0aGeaF0jARtn78kM=;
  b=ABLTDzl1WqFde269ZOgNPxFVXwCq+BEIuQIuBC0gRvBzZoRzv/i/5UTw
   Rs/lkA4me1X6Voqmu59a00WjQd530yXG9w7d669TUvDHhOLlgpj8OX1hx
   jL03W/sxfoweEkHNX8E2CD7MSnBj8sFz+KCPX+ooScW6Z6Kt6B1jHo4ga
   RKSpUVfzdueljvUqm34sXKcVMwKKPoSP+PLQWOuyahHXjFwXLlLL35ryN
   fWlQi6sFfFuDD4bGxHwr92CzIC4oofT9clx70v1RlAXVK+BU8umAmuZg5
   S6304ocGrThq45jZ3MpTtvU3H7pEsx3NDRuuwQzDbH+3NFaEyZrNdhhLm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291585544"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="291585544"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 02:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="633270518"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2022 02:55:50 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 02:55:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 02:55:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 02:55:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9fx4FosPL8LB9KR2qAz1H5l65BPriepwtDIL2MGjJFxzxa7ShP5NXZewGUy2yElwL1pSzMefUBWR+5VN0Pq5eyNynZi3poAmM7tl2rDFt+b3dqHjsc7fqiDw4ePbmJ9ItIbdieRpDtjqMUrsb804DEQFqhIdGbsqejCapni7dQGuNFHIlKZqXH5ADJ4kwe0KFsSR0Mk4wu6ifxbgLeyPs2wChR3R7C/k1wTzfvVZwxsBzo1W9x19oe1LXUe1ckobZ8D3sHJzjYlWar6igFxsTvdc0Ycx9H3ka/RThBFUHNysypdIh2sjnXh9mjkpubpv5PhWrfEovqB2Pqi0aevAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1MsrGqztg4CgHZ9ShtYePwVVJLAplZzpxnDr5qC/xg=;
 b=Q92SbZW+FThpljhU3z0l+ZgQkp58q8JYXjqN4f5W84Py+VR89Bsexms+rCXIi+KtrWLz82IPEVQhT49gefUfsAqEYq4SJbqJXlcxn3WhsdS6MoyeF8c8D+sEIR6ICCkd3HUt8xeK+7dpUUOUnnOg01aRI0jxbSk3xntIfQeib5dFk9vd6EKzUeqKIGyHF6sK51d9Axq7Waml6nmYOgPMT9jEw42mB6cSKoVp7WOb9p2+d/1fHfObzrjYScvLHgjB3+G0+75PL3RsQ1FB6f3FaCxqWwYEQHE8ifC5q2KHD9h0qt+6ZcJQ0w1HhvMSFEOF8lHhv9kn34CqTr7+emuLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 09:55:47 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::75e3:4009:a5d1:c3ae%4]) with mapi id 15.20.5504.017; Tue, 9 Aug 2022
 09:55:47 +0000
Message-ID: <acbaf339-2fd9-5b19-06e8-62e66c324dc6@intel.com>
Date:   Tue, 9 Aug 2022 11:55:40 +0200
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
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <Ys2EFtNVL8ZALQ5Q@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36aa4c08-3ee6-4bcf-2875-08da79ed5559
X-MS-TrafficTypeDiagnostic: BL1PR11MB6052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8bSfWx7a2nRJ4Bi3L/EXKqvtGY+GZ3qO2U6KHoKMvBT/16MYGa/RTl4GUpG+2Adxyv+snWu2HMtsPpbKS/F84YmB60Xou6Ut2QgCK10Nh0OhQtWnzAxLM1ZE1aKHkqc5rQMBjX53S4HY012mF7rmJeEPmHhjXwV6JyiE9URuyJdP9Mz1GfwyTHckgCyg35TFdGHcg+TOvxj08L+IJq7ps1sQ0oDyZJ9w0p3eE+wBSy183u8IANga0NQ3tAqJPCtzCMRCiFTnAIB2UjhryURVzIzVBIZqn40Co92ZqmcwFKQpy8A+c0vRDdDQMza3dv32RMHimLVZ2H8ggFkX9C2Vr8DL9O9Zf+JP99YXKYi1FjIzQBlo095SEK3RMvglYI1dDb4goYLvcpG5lrzVypOCOfIze+52WpmI8CJjw6J/iMLzCBNl9EYWzp6yzQ8wW+1HQ4EFqTAtNQ67PMy2bEBrgh7TG7KXk/dpmiZAjgPgu2gQLc/NmR7ORJdG8PjxGRDptXidshVS/yBnrktEcrgKqZgomi8Jnu9XiABRA5wsPcTcNPWfgs9PETnp5uNP2hPTPx5uaaTF8Rlviv2F6REFMVPvHtGoZzIw903FifCoMc65x8K238sRMr5Qy4V9NpOhUwsGmNdFfMLrsMMxKTFGj+88nTJ+YNTCH7TYDzArhHMLfnhcS9Op8Lp12nicxPTxvIyVK0f6GN8njx19Fijdw1kpijahC32sJNRpXHgrJW9njTTrhG5o7IAKHCL/cdUZm1d3i7O4lucwtRP2/UVWngFvshNpEEPbdRmc1LXQ7xC26gD02QxW2Dw2sy/Lc+rsMv/T8lCA1hGvZ0qVHcmYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(26005)(6512007)(6506007)(53546011)(186003)(2616005)(82960400001)(31696002)(86362001)(38100700002)(478600001)(66556008)(66476007)(66946007)(8676002)(8936002)(31686004)(36756003)(4326008)(44832011)(6486002)(6666004)(7416002)(316002)(54906003)(6916009)(2906002)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNYc1lNS0YrWmlYN25vYkhLRmpGWWszWXJaNDZqMHZUN2FTQlZ2Q0pSUmQ0?=
 =?utf-8?B?OGFHYUR4OURDbDFzN1M2NG80eVRkR21na2I5blp2RFhqUFdwNU5pOExQdTNB?=
 =?utf-8?B?S01Ma2lTSE9ZY1N3WHlmN0NKS04rZVVNOTBaUFVaN1lCWC94QnZUSmFadzFG?=
 =?utf-8?B?TkpGMVdpNkkwMkJteE5NcnpqK2h0M3QzZTFsTWpPdkdtMDRXN3lldW80bnhE?=
 =?utf-8?B?UDNQMVBiMDM3MW5lN2k3SEVmb1VwN0hwYWhWVzdhRE5RbFh0b040RFN1YW9Q?=
 =?utf-8?B?TnpBR2dWQ2hCRlF1UEcrOGpxSjk5QW1rbHRVMDAwaGgwa3ViVzJQVkZxcWZx?=
 =?utf-8?B?VFQ2RkMxUG9iZXZWQkJZNGR5WlB0Kyt2MnlodzdqTlF5QndnQTA1TnVuSXZW?=
 =?utf-8?B?NHdxc3M2dFBSQWNoQkN4dUJxeWlJMUp6OE1lTms2cDRhWTF0UEY0Z1R3dWsr?=
 =?utf-8?B?K0F0UUNSQlgxR253NHdiRkRuRWZtVXk3QTF4aU9HYmVEVHFBUFk3b1lMQ0pH?=
 =?utf-8?B?aCtsWmpkMEduQ3QwUCtiMG9XT3ZuQ1dqdksyNEtPemNXMlYvdWZCWGZXVEla?=
 =?utf-8?B?Q2lXNndXeE8zL1IzbUo4TTA3QWtYOE1YbHFTRXRITEhtd00ra1E1RVZzQU9N?=
 =?utf-8?B?cnhKeVpIZFlzbTNyMVZvcitOREY4aURGUFEzcUNLdmhZM3dLREZROEFKRlp2?=
 =?utf-8?B?ZVMwZ0pNRFJxL28vaWxtUGdWZExMT25xbzRURkViWGI1VGtabWVOUWN6NzNX?=
 =?utf-8?B?MS9LYVlPY2cxSmhpRit3WFFLbUFDREk5V0RwZTNjU1VDMndBbjB4dmdpVHZ5?=
 =?utf-8?B?TnN2d01GL1N6Z0d2TnJyRHNwTHNqSXY2ekswTTg1aTlBYWZSOTdJM0lkdVRu?=
 =?utf-8?B?MnRGMmhiSU1ZZU1sT21RVndkaVJqbDh6RDRadGRMR0IyVlpLRXlLQVMzWXB1?=
 =?utf-8?B?b3ZncFNEeVRRRmo0Z3dSRDh6cFkzdjJwT2VIc3NRTmZ4am04QXZBU0VyQ085?=
 =?utf-8?B?R3pxVHdWM1JJY2tVOUpQZUtqUi9QTkVBVUloTG5PUnFRRjZ2UnJISnlUYWM4?=
 =?utf-8?B?R3NkQUpiaUNZNThLK3p3bXFSbytnTzJ4WjFOV0E0VkVWNXVKTDBqUzlwTFFU?=
 =?utf-8?B?YmIrdDhMM1JJYktPVUV4U0JjaURTcFVVZHdaazQ0bExMS3d0NFNsRWJNc1Ux?=
 =?utf-8?B?M2RvMm1DaWRSZ0tUT1pZYm9NcU9JNG5CbStCaGxBRzJWRkVWWVlqdFV6ZnZW?=
 =?utf-8?B?b1ZrRHdaN1B2TXhWWDdBaGJxcmEyT1ArOEt2eS9kd1VQNkx4cGZQMi80TkdJ?=
 =?utf-8?B?VHVVWHhRbFMvUEluL2ozS3NJK3ZmZjRTS3ducUpkTHFBWjVtSnZ3TzZLeW80?=
 =?utf-8?B?cXV3RFVZenEraDJaWmlrbDBtMnhKd2E3Vit5ZW5hS1NoRHpzRFc4eW5sVE5J?=
 =?utf-8?B?TmJVZmo0dmU4QjBXV0FSbjh5UlBjVk9ZbFFZajZMU0ZKbFY3NEZjR2ZHWi83?=
 =?utf-8?B?TzNiQ2NZamtBUlRYT0dkTWtTVmllcXNLRVM1TlRDcXc4ZDdsUGltVlA4NzYy?=
 =?utf-8?B?WklMVzZxZHVkUzBHUlErOTZQUStESk44WElCZ2JkSlArSUZmdnFwL0hWM3pq?=
 =?utf-8?B?S2Ivazg1bE9HRGN3alFjMEE1a3JjaTZ5QVIzMThpN0lpZmM4QnJwV0Q4d3VO?=
 =?utf-8?B?bG5jZGk0d2NGUUlyWkVvclp4aHlSWUJJOVRFWmdPTUZBeUtTMGJqN3ZrNGY4?=
 =?utf-8?B?WkFQWWxYbzZMTlNKQTQ1L2V6QWpJWTlBSEYrV2dUakNTblFYSCtuSy9kdHlY?=
 =?utf-8?B?U0VtRXJQWmdhUXl3SFJad2xuQkZlVU9GZ3ArcmR1QlJra2M0ajVmTG9ldVFO?=
 =?utf-8?B?eXBEbU1YVEYrbjlBalB5dDFCQUoyK3lRdlRudVNvQlZFY3JGdzdEVkNvQTR3?=
 =?utf-8?B?RmRhbDMvbThuSlN0aldZRVhmQSs0N0UweWNOdmxYSld1YXJ2K1YydE00NFVY?=
 =?utf-8?B?NHp4akJnMDVDc090YU9QQkgzNFYzUlJpSDE4bDh0eFVYRUdxZmdrZFN6Tllo?=
 =?utf-8?B?eSsyMXVUUXFUQXZJbGtNWW9FaVArRVFlOFRKZy9EZjZOSkQzbzJVRHZsVURN?=
 =?utf-8?B?VUJjRGhTUXowcUZJY3AyT3NXZ2pZdU9LNGhSaGlhWFJ5bEdac05PcG1NWk1n?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aa4c08-3ee6-4bcf-2875-08da79ed5559
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 09:55:47.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzbLn0jR/fGzEL7igidMjsnhR4j/wJwQE7oikk5ZmB1fI93ctDZjzRq0EjUdcZmg6ae1UsMEORNgJChMfL7u0K0Qn/R0jP2JI0yVlEabTKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-12 4:24 PM, Andy Shevchenko wrote:
> On Tue, Jul 12, 2022 at 03:51:04PM +0200, Cezary Rojewski wrote:
>> On 2022-07-09 10:42 PM, Andy Shevchenko wrote:
> 
> ...
> 
>> I still believe that casting blindly is not the way to go. I did explicitly
>> ask about int vs u32, not int vs unsigned int. Please note that these values
>> are later passed to the IPC handlers, and this changes the context a bit. If
>> hw expects u32, then u32 it shall be.
> 
> What you can do is probably utilize _Generic() which will reduce the code base
> and allow to use the same template for different types.


Hello,

I've spent some time analyzing possible utilization of _Generic() in 
context of get_options() but in my opinion get_range() complicates 
things enough that get_range() and get_option() would basically need a 
copy per type.


If Linux kernel guarantees that sizeof(int), sizeof(unsigned int), 
sizeof(s32) and sizeof(u32) are all equal (given the currently supported 
arch set), then indeed modifying get_options() may not be necessary. 
This plus shamelessly casting (u32 *) to (int *) of course.

What's left to do is the __user helper function. What I have in mind is:

int tokenize_user_input(const char __user *from, size_t count, loff_t 
*ppos, int **tkns)
{
	int *ints, nints;
	char *buf;
	int ret;

	buf = kmalloc(count + 1, GFP_KERNEL);
	if (!buf)
		return -ENOMEM;

	ret = simple_write_to_buffer(buf, count, ppos, from, count);
	if (ret != count) {
		ret = (ret < 0) ? ret : -EIO;
		goto free_buf;
	}

	buf[count] = '\0';

	get_options(buf, 0, &nints);
	if (!nints) {
		ret = -ENOENT;
		goto free_buf;
	}

	ints = kcalloc(nints + 1, sizeof(*ints), GFP_KERNEL);
	if (!ints) {
		ret = -ENOMEM;
		goto free_buf;
	}

	get_options(buf, nints + 1, ints);
	*tkns = ints;
	ret = 0;

free_buf:
	kfree(buf);
	return ret;
}


Usage:
	u32 *tkns;

	ret = tokenize_user_input(from, count, ppos, (int **)&tkns);


as a part of fs/libfs.c not lib/cmdline.c. Is such approach acceptable?



Regards,
Czarek
