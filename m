Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152E652CC26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiESGrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiESGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:47:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D73396AE;
        Wed, 18 May 2022 23:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652942828; x=1684478828;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OlPDbguvYV660WhI+ipu9LuTnUPzf1Pkm9y5LxupaXU=;
  b=RLjQsoOTs7osH6+yfw7+maPHcbv5LMsNBgvR1IeFpVbfOa37SrWHvWfh
   YjxUsTh0nc8jlFgw4smNedDwquBFNsZi+QEa4F0VdK2ydjViop/D4Gv+T
   50ZChV/kzmW+UlYLal7zDt+iTTPsvNoyL/xXIP0WOriy7FDgzstSTMEAU
   7fpGMG3+PpqtqgRPY3gxtu29F4qWnhCfgYzVHdxoqZafSseqDO81er4wJ
   AYZTqrKJ9pHS+ZWxOa1SXYa8wUS9F4RySt9uu6UouAR+ntahIzGensmBt
   pgnNQgG3QsLDypRKASmRlyhoQMD7gmRI+j9WdnA4SQk0LoZt5CXuTeuiI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271747725"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="271747725"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 23:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="570033531"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2022 23:47:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 23:47:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 18 May 2022 23:47:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 18 May 2022 23:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvuczKegH131nW45Ffq2qqRxti7JvAleK/IEsQeq135LVdck+HeJXcDRAIPsv6DpKKE7D2+5z/wMdbqYTohdkl9iCMZM9qAYmXj7ynKFUnsYvOcgc4PAQYfM1gvMcsf8PvGhNW1b7GnRhbgLc4E3FdtcHpXbk0ZrqWipUG4h0zvP2I6HK0YJegIQaqP9LHXN1Q0G26Lj3yOxtAvYC7dotqmOrUjtxdiao/vZ8P/kzDDyHcq33LfwfUz6SzL/VyzP6zXuifoDNYt8AWOqpcFP31EDIjvwjRCueeRUiOKNBAodRRP0KIWv9ovqNTdVv3TMrDf/j0aHBfDY9tkoLLxokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=civEA9BgXWiA9A+rhOK9nGaw8S55P9vnuEzjns2CAZk=;
 b=F4aHddB3OOBbTzKiPMuCfx2B9xKGIN2TI3gcKjlfB1gWeq7YpE5g66jsXRvawtsSS2azZrZF2+k+SW3txxPaL7GBjNzkMinTgBHR5FFbeA6Yiv8P8eAW1KF22aHVf9sZ7GUkEGBJDg67j/EBha4iUY4KPJYpsXeHhN7/BAlgDXVgzxk9WjQeLhmy0Qqvryo8E8sfrzm/YbS/tWwX6BACqJ6PYu9rE/Qnhvwv9p0nZTbez+ZWjwrrmc17qc9Jg1FAi6ZiAVzd2bLKz4eUiKRgOBJ1AlndTJwToDb6zdBS3zPILyNHYYPh2oFupz/xo5MMMI7hcvwcyZs5aD0qm0lpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) by
 MWHPR11MB1487.namprd11.prod.outlook.com (2603:10b6:301:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Thu, 19 May 2022 06:47:04 +0000
Received: from DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b1fa:393c:9fb6:6871]) by DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b1fa:393c:9fb6:6871%5]) with mapi id 15.20.5250.019; Thu, 19 May 2022
 06:47:04 +0000
Message-ID: <b1584fe0-9180-c19a-97c4-689eb3169869@intel.com>
Date:   Thu, 19 May 2022 08:46:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH 04/20] media: s5p-mfc: Rename IS_MFCV10 macro
Content-Language: en-US
From:   Andrzej Hajda <andrzej.hajda@intel.com>
To:     Smitha T Murthy <smitha.t@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <m.szyprowski@samsung.com>, <mchehab@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <ezequiel@vanguardiasur.com.ar>,
        <jernej.skrabec@gmail.com>, <benjamin.gaignard@collabora.com>,
        <stanimir.varbanov@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <andi@etezian.org>,
        <alim.akhtar@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <linux-fsd@tesla.com>
References: <20220517125548.14746-1-smitha.t@samsung.com>
 <CGME20220517125601epcas5p47dfcac0c5e0c412eb0c335759c51c941@epcas5p4.samsung.com>
 <20220517125548.14746-5-smitha.t@samsung.com>
 <002e5ec2-478d-ca10-5a71-5390dfb69173@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <002e5ec2-478d-ca10-5a71-5390dfb69173@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0043.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::20) To DM6PR11MB3180.namprd11.prod.outlook.com
 (2603:10b6:5:9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c06a66-12dd-4be5-4a07-08da3963625a
X-MS-TrafficTypeDiagnostic: MWHPR11MB1487:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB1487579A816EB0EAA1CB710FEBD09@MWHPR11MB1487.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLqOPEqx5kcdqNNjmFf5GAlitoKnxUx2wqw40CaxCEVDZ5mV33NQG62g7N3pQT+VoolH6pI6tnoBK25iEMh2YSewLsoieOJNq5PrYBFPODi6t8G3SC2OtM5CAwLarwL5Xhcd3378Bd0oRw0U4vuPYNa/EyVOa4+gcd3s+n2nh53WrHi6fHQ6mfVqoP0wJ2zXS7Z2celd30bRbrOP1QCca2Y/o8CmuaMf1P/B3Qg6aFzfuQ8D+l9z8Vb+tpjFetkid/59fq1tC8o+LT1uHjm1jo/hFB3uu3nIInJUArNISueTh8IIDv8/pUOO07NhaJSb+zerqn/jdbKOhlHBt49Vfl6afrdjbhC9VVzAn8PD1QAjD0lohs+mlhxFmPpmspfHHp7lrqV7Iv5SObU9UyvArUG7G3Mp0mU6ijuSm3YdGJwqiYkk0BEoryUWTin+Q/Q1lo3ht3V7qP+aGc93pMDSGzv7BjqRZoDPeCOEt4Cn2UYQ58LU6gilBjvhMKgcHx8hB0y+rctU2CCQj13ru7LGYgeaHKyCxAGIHO2CJxgexFq8KJ8eT5C+ieqEu7B9/ENZzrsZwHuJNYwP6aLxDiz5bGpITCAF8I5Yq2pIjYZCdOGQ3laUVUoLAZoZJLU7lgL1TGO69FP8StXrXZ/zMiSf9o5H81xEP4+QdAOxnuYvm0ciqM4ywo+I2109Dut1e9XFBFpT02yTRUnfdGve+/Ca6N67vmmLkw12fW97qfEHVRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(6666004)(82960400001)(66556008)(66476007)(6486002)(2906002)(36916002)(5660300002)(508600001)(8936002)(38100700002)(7416002)(44832011)(36756003)(2616005)(186003)(316002)(26005)(31696002)(6506007)(86362001)(83380400001)(6512007)(31686004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lEZE5ZcXhGci9ySWhRRWozTW9UNlhJaVJEOVNTeUI3K3Qwd212eDlMM1FY?=
 =?utf-8?B?ajM1dTBCNkN3bHdmSmdvWTZYQkpFZ1doMHl5RnNocTJOWHh5L2hOcVV4QWg4?=
 =?utf-8?B?MGM1UTE3OE03dDBucWRCajFIeXZySUkrc2lTUzVpQU9wVE1JMGIvbjhEWXJt?=
 =?utf-8?B?S01KRm9FZUNNTytpK0hleENENklscUdMcVgrbUZxdGlWa1pZMDVEY1k2M21n?=
 =?utf-8?B?RVRmeW9OeU5maGZpM0VWbDE5a1dKRDN4aC9HSk81TVNnMWZNQlhBckJlMUcz?=
 =?utf-8?B?ZGNnK0hhcHd4eWNUaUhtR3p6M3pBclhyc0RmbW1wWlRYWWZxTmEzdlRsR2ti?=
 =?utf-8?B?SDJyVzZJTHVrd2JhU3BPRDN4TlVhTURoRVlhSTRwRi9xWVg1bS9zeGl6ZjFs?=
 =?utf-8?B?a2NJb2RVOE91dXROQXp5N0IvVW5hQ2RnQlVab2V2cmFURWVmWTZ2QzJLaysv?=
 =?utf-8?B?ZGo4N1RjRng0ekYyUDJzdFVJRzJ1UENUWFhUaGQrMFJGRVhubnhCT1dqQ2N2?=
 =?utf-8?B?ZnViN3ozalNmeDJGZ2NRTk11dHErYWlEVmJ1UUNHSU5iQWpMblpveVVHZE0v?=
 =?utf-8?B?VXlkcEJhS3ArR3pISkxCam5ubWtHM0tYUnBiQVh4Q1YrWHE0WUFHdVFDaDMx?=
 =?utf-8?B?TzY1Z21MeWJBbVFiUzJuelNZM0lYRkdEbW56Zmp4Qmdjd1QwckdFUzJ2MXhH?=
 =?utf-8?B?MC8wUFFWWGUvbWNXTWRMSG1NMUV0Uis5NG8yOE9LMXJhcDBsVUl6NitpVkk3?=
 =?utf-8?B?ZXZtMzdqbElZMG80S3hidUNxUmRuSys5ZUVJZEZ6aWozNGFkZms1OWVIQzBt?=
 =?utf-8?B?djJSTUdSM2VOQm5Db1VUMzhTaWh2ajNMNGRhcjBrNHl3UVNjUUt6cUhpR3NK?=
 =?utf-8?B?ZWRyYTUvYU80MStuNUViZC9PRStvTDRoZGNWaWN5YW1SdWJSN1FhbTA0ajFn?=
 =?utf-8?B?Q1E2QXhWREhSTFhIekVmKzBYWnBTaHBKU1lBUFJqMzFNYWxvQ1JLTStLR3N3?=
 =?utf-8?B?K0QvWG5iOEhZYW1Yems2MTZyeXl1VG83KzFXTXRHeXlhSkUvQkUrRm5OMTZn?=
 =?utf-8?B?SDNLMWlQY3VxVUZzUVZMYmM3aXNjTitqMGd5TjFiMHJ6ajVGdEFONkZKV3pC?=
 =?utf-8?B?cFdnS1U1WVVrb3FLWEN1cXM2WG83WUQvU2RZdEZjTnF6eHRSOG8yT1ErSmpO?=
 =?utf-8?B?N0trMVkwZUIvRmFjbm85Mnc2MGh0WmdNMllFT29RY3lYbTFydVdPaTVaeUVo?=
 =?utf-8?B?ZDlFQmVMa01SdmcxMmlHRmhnVlV0OTg0blVHUDY1Q05lQkl0OWVjdlZmblNZ?=
 =?utf-8?B?cVppR243V3kyWEtxL0E3RXBxU09vMC9jcE1Ca3F0bDg3VE9RenRDQk8vQWRl?=
 =?utf-8?B?ZUtsYTU3VGRzRHpSNW85cHI1a0ltZUpNUjdrTnU3dWN3b01hT3laQU1Qamhx?=
 =?utf-8?B?ajdFdmlENUhKL1hTNTBhS1hWMW1KUUl3Y2N5OWhlLzFEeDY1QUZ0OHQ0TGlD?=
 =?utf-8?B?Szc3V0YrcHNrSTRXVzhXMUVNeVdqNThGM29pVXFJR0dLZTJ6WkZYK2VuRGJC?=
 =?utf-8?B?dVROb1FEa2FxeHVMbmVzZDZUQUhWd0xITmQzd0drNnVRSFpKNmNNU0FDVlFt?=
 =?utf-8?B?N1o3ZVlZQVZaV0ZNSm5Ic2hJcFo4TS92SklCOGk0Tk10QmR1RHhCSUVtRnU4?=
 =?utf-8?B?dk1LamVPQTRhRmd0cUlnZi8rQ1VIU2JhMGlZTnA4S0hTMHprWnRRbHB0clhw?=
 =?utf-8?B?M0JLOG44SEUzWWxZMGppVkFVSk5ZVktHbjNCTUlUNkkwK1Mwamw3MHgwWEx4?=
 =?utf-8?B?QWFsMHBBUVpJTU5FWEtkOWk4c2sxeGtIQS85c0ZLT244RlN0NW5uSTVNOHNm?=
 =?utf-8?B?UDI5bHdzbjQ0MG1MU012enpIYkVrbkJVY0swd3lYd0x6MzR6SW9XMmxSVXU5?=
 =?utf-8?B?RnphcU5aSko0d2tOenRwT20rVm53VkJma3FRRlg2NkJQOVd3Tmlhb3dlZVhU?=
 =?utf-8?B?NmswR09CV1BKZHo1VHlnMHNMRitkdis0QVVSU0YzdkNaNExRSVNybFRITDR0?=
 =?utf-8?B?cVkzTTJHTkJWZ2dEcEwrbXAweG1wdXNleFVlRTRRVzVPSldzUUdhMDAxNVgr?=
 =?utf-8?B?T3dCc0tJUTRkK1ZtWk5EL0s3K3REY2ljcGRQS1EyYThPT0ZrSCs1ZVB0U2o5?=
 =?utf-8?B?U2RValI4eEdyNEFhNjFiWlA0UEdsMXZkRWl1NURjRkFNcld0cHZQNFN4bzZG?=
 =?utf-8?B?aEpNajJtSFc0aXE3bmlzYlAzMTI1UERBNzB0bE9TR3U2V3k0c3ZiQ1dwNWt1?=
 =?utf-8?B?ZWJXQ2hqVmtuaGRhT2pkeVIySHhIaitKTU9tT3JZSzVQSDhVTUpLc3d4b1R0?=
 =?utf-8?Q?IFHzbYOrZS26YH1s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c06a66-12dd-4be5-4a07-08da3963625a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 06:47:04.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a53JVYlNMLU/YVT3zpw5cxP6v5UcU0hTD4I/zdemRIx2vK/b7rH2ymxM6m//DS03Pen82/RO2doXiaKYM9AVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1487
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.05.2022 10:41, Andrzej Hajda wrote:
>
>
> On 17.05.2022 14:55, Smitha T Murthy wrote:
>> Renames macro IS_MFCV10 to IS_MFCV10_PLUS so that the MFCv10
>> code can be resued for MFCv12 support. Since some part of MFCv10
>> specific code holds good for MFCv12 also.
>>
>> Cc: linux-fsd@tesla.com
>> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
>> ---
>>   .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  4 +--
>>   .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
>>   .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 28 +++++++++----------
>>   3 files changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h 
>> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
>> index 5304f42c8c72..ae266d8518d1 100644
>> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
>> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
>> @@ -774,8 +774,8 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, 
>> struct vb2_queue *vq);
>>   #define IS_MFCV6_PLUS(dev)    (dev->variant->version >= 0x60 ? 1 : 0)
>>   #define IS_MFCV7_PLUS(dev)    (dev->variant->version >= 0x70 ? 1 : 0)
>>   #define IS_MFCV8_PLUS(dev)    (dev->variant->version >= 0x80 ? 1 : 0)
>> -#define IS_MFCV10(dev)        (dev->variant->version >= 0xA0 ? 1 : 0)
>> -#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10(dev))
>> +#define IS_MFCV10_PLUS(dev)    (dev->variant->version >= 0xA0 ? 1 : 0)
>
> The " ? 1 : 0" part of the macro is redundant, you can remove it here 
> and in other IS_MFC*_PLUS macros.

Moreover the history shows that IS_MFCVxx becomes IS_MFCVxx_PLUS, after 
next version, maybe you should use the new name, to avoid this renaming.

Regards
Andrzej

>
>> +#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
>>     #define MFC_V5_BIT    BIT(0)
>>   #define MFC_V6_BIT    BIT(1)
>> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c 
>> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
>> index 72d70984e99a..ffe9f7e79eca 100644
>> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
>> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
>> @@ -236,7 +236,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
>>       else
>>           mfc_write(dev, 0x3ff, S5P_FIMV_SW_RESET);
>>   -    if (IS_MFCV10(dev))
>> +    if (IS_MFCV10_PLUS(dev))
>>           mfc_write(dev, 0x0, S5P_FIMV_MFC_CLOCK_OFF_V10);
>>         mfc_debug(2, "Will now wait for completion of firmware 
>> transfer\n");
>> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c 
>> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
>> index 8227004f6746..728d255e65fc 100644
>> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
>> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
>> @@ -72,9 +72,9 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>                 ctx->luma_size, ctx->chroma_size, ctx->mv_size);
>>           mfc_debug(2, "Totals bufs: %d\n", ctx->total_dpb_count);
>>       } else if (ctx->type == MFCINST_ENCODER) {
>> -        if (IS_MFCV10(dev)) {
>> +        if (IS_MFCV10_PLUS(dev))
>>               ctx->tmv_buffer_size = 0;
>> -        } else if (IS_MFCV8_PLUS(dev))
>> +        else if (IS_MFCV8_PLUS(dev))
>>               ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
>>               ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V8(mb_width, mb_height),
>>               S5P_FIMV_TMV_BUFFER_ALIGN_V6);
>> @@ -82,7 +82,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>               ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
>>               ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
>>               S5P_FIMV_TMV_BUFFER_ALIGN_V6);
>> -        if (IS_MFCV10(dev)) {
>> +        if (IS_MFCV10_PLUS(dev)) {
>>               lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
>>               lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
>>               if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
>> @@ -133,7 +133,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>       switch (ctx->codec_mode) {
>>       case S5P_MFC_CODEC_H264_DEC:
>>       case S5P_MFC_CODEC_H264_MVC_DEC:
>> -        if (IS_MFCV10(dev))
>> +        if (IS_MFCV10_PLUS(dev))
>>               mfc_debug(2, "Use min scratch buffer size\n");
>>           else if (IS_MFCV8_PLUS(dev))
>>               ctx->scratch_buf_size =
>> @@ -152,7 +152,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>               (ctx->mv_count * ctx->mv_size);
>>           break;
>>       case S5P_MFC_CODEC_MPEG4_DEC:
>> -        if (IS_MFCV10(dev))
>> +        if (IS_MFCV10_PLUS(dev))
>>               mfc_debug(2, "Use min scratch buffer size\n");
>>           else if (IS_MFCV7_PLUS(dev)) {
>>               ctx->scratch_buf_size =
>> @@ -172,7 +172,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>           break;
>>       case S5P_MFC_CODEC_VC1RCV_DEC:
>>       case S5P_MFC_CODEC_VC1_DEC:
>> -        if (IS_MFCV10(dev))
>> +        if (IS_MFCV10_PLUS(dev))
>>               mfc_debug(2, "Use min scratch buffer size\n");
>>           else
>>               ctx->scratch_buf_size =
>> @@ -189,7 +189,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>           ctx->bank2.size = 0;
>>           break;
>>       case S5P_MFC_CODEC_H263_DEC:
>> -        if (IS_MFCV10(dev))
>> +        if (IS_MFCV10_PLUS(dev))
>>               mfc_debug(2, "Use min scratch buffer size\n");
>>           else
>>               ctx->scratch_buf_size =
>> @@ -201,7 +201,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>           ctx->bank1.size = ctx->scratch_buf_size;
>>           break;
>>       case S5P_MFC_CODEC_VP8_DEC:
>> -        if (IS_MFCV10(dev))
>> +        if (IS_MFCV10_PLUS(dev))
>>               mfc_debug(2, "Use min scratch buffer size\n");
>>           else if (IS_MFCV8_PLUS(dev))
>>               ctx->scratch_buf_size =
>> @@ -230,7 +230,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>               DEC_VP9_STATIC_BUFFER_SIZE;
>>           break;
>>       case S5P_MFC_CODEC_H264_ENC:
>> -        if (IS_MFCV10(dev)) {
>> +        if (IS_MFCV10_PLUS(dev)) {
>>               mfc_debug(2, "Use min scratch buffer size\n");
>>               ctx->me_buffer_size =
>>               ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
>> @@ -254,7 +254,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>           break;
>>       case S5P_MFC_CODEC_MPEG4_ENC:
>>       case S5P_MFC_CODEC_H263_ENC:
>> -        if (IS_MFCV10(dev)) {
>> +        if (IS_MFCV10_PLUS(dev)) {
>>               mfc_debug(2, "Use min scratch buffer size\n");
>>               ctx->me_buffer_size =
>>                   ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
>> @@ -273,7 +273,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct 
>> s5p_mfc_ctx *ctx)
>>           ctx->bank2.size = 0;
>>           break;
>>       case S5P_MFC_CODEC_VP8_ENC:
>> -        if (IS_MFCV10(dev)) {
>> +        if (IS_MFCV10_PLUS(dev)) {
>>               mfc_debug(2, "Use min scratch buffer size\n");
>>               ctx->me_buffer_size =
>>                   ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
>> @@ -452,7 +452,7 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct 
>> s5p_mfc_ctx *ctx)
>>         if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
>>               ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
>> -        if (IS_MFCV10(dev)) {
>> +        if (IS_MFCV10_PLUS(dev)) {
>>               ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
>>                       ctx->img_height);
>>           } else {
>> @@ -668,7 +668,7 @@ static int s5p_mfc_set_enc_ref_buffer_v6(struct 
>> s5p_mfc_ctx *ctx)
>>         mfc_debug(2, "Buf1: %p (%d)\n", (void *)buf_addr1, buf_size1);
>>   -    if (IS_MFCV10(dev)) {
>> +    if (IS_MFCV10_PLUS(dev)) {
>>           /* start address of per buffer is aligned */
>>           for (i = 0; i < ctx->pb_count; i++) {
>>               writel(buf_addr1, mfc_regs->e_luma_dpb + (4 * i));
>> @@ -2455,7 +2455,7 @@ const struct s5p_mfc_regs 
>> *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
>>       R(e_h264_options, S5P_FIMV_E_H264_OPTIONS_V8);
>>       R(e_min_scratch_buffer_size, 
>> S5P_FIMV_E_MIN_SCRATCH_BUFFER_SIZE_V8);
>>   -    if (!IS_MFCV10(dev))
>> +    if (!IS_MFCV10_PLUS(dev))
>>           goto done;
>>         /* Initialize registers used in MFC v10 only.
>

