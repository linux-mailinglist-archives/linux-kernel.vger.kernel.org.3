Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B39852B54C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiERIlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiERIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:41:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FCA4D9D1;
        Wed, 18 May 2022 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652863304; x=1684399304;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TpsCICryPUcT3JfqRs7jrqTjzL2NlM8lKbag+c3j9Mo=;
  b=H6gdIjjcUDyOgyXuGTMZUe68kePA5ykr9R3DJDBUbDlrHPIS068nAFtM
   40kBpNrNla+abe2lRaM2zg/Z5506NWVPoxrMuKgUyhES3QpKXPXgy/3D6
   esid0BEHMdsjbLegys+aHUOTLcv+0sTuJVYe5OdTkEAYVei8NmPa4J7kY
   zbGktoL4xxKJeCBV2OLyKRqHtax1PO48fDx3j/QyonyHJsHMvOItUD2Jp
   3TYOxTrx8yCDOr4iGaEIAmdgoDWJsvIlmTV+7YaH9DDDG9pNIwQTc19Bz
   dAU5exlVMtyGqBbT8p1tXjUJ6EYDDHirQPkXHOwtlUXMKSiOrvBKCl9N9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="334607037"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="334607037"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 01:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="545336200"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2022 01:41:43 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 01:41:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 01:41:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 18 May 2022 01:41:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 18 May 2022 01:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZMkW0UItq8TVa04GPvihnKNiwmC39cY3vNo1uZBe2cyv5S0I6zGQfEOe7xnyYrfHn1XEZklnON0jQL00AqkLnTAnD9RL3Huwjx5Rh3XHhdyt2p56kSKCKqdUBiLqmdTDE8c6g0oa9vTH0ptTf8GKm2M1V8HhKzWXAwFZRxWi7bwpi+yXcXXm97OKzyWtUm8BR3ocTMh8ELRnjdJ4dPSRWqWt9i9UkSZY0Px6iqgFwzSS2nBhdratLi4RczqCBJk+FKEbOpAr2cNsPUHzC3hsZZ/eNZ2WP9fDYTkRdS1wuqJoTgeUxO5J/SDeI4MbGZHBCBKusRxe6+9G4UZaZ2Akw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQaQznnzSpXuIWKHAE2RwrJTXra7XkZS1NaLrtw126k=;
 b=MtSZn/JhZL6ailApWsCZfCtHLvO197sV+/HZgoG/74QC8M0cYGy6muwWTyKYuZhpBaB6pRJwvhHpXY+BDr0zZ8cmE3Sc6S0wtTgKgCE4Y1I8F3u+XyUNpaJsjU2fRygt5HPxO/qBmILZenZj81Cm5dkHII1WyQRq2pD8mK4oLemcOyjwQXvOxP8hn4L8AKQS78RV5uRbZ4FtSC+GVbKtLKlvcmSGSdCrMrqvRRPcYTmyXFvGJEmoiOCxR59cuAmXaguaKHFeBAmiV/0fSDqCvhe+WO0C+Y20lJ8I6n7DHiDlhBHzeA/1lCLSGQxyFnYXDDmufxkP6BLLBiF58E10cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3180.namprd11.prod.outlook.com (2603:10b6:5:9::13) by
 BY5PR11MB4402.namprd11.prod.outlook.com (2603:10b6:a03:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Wed, 18 May
 2022 08:41:35 +0000
Received: from DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b1fa:393c:9fb6:6871]) by DM6PR11MB3180.namprd11.prod.outlook.com
 ([fe80::b1fa:393c:9fb6:6871%5]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 08:41:34 +0000
Message-ID: <002e5ec2-478d-ca10-5a71-5390dfb69173@intel.com>
Date:   Wed, 18 May 2022 10:41:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH 04/20] media: s5p-mfc: Rename IS_MFCV10 macro
Content-Language: en-US
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
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220517125548.14746-5-smitha.t@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0012.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::17) To DM6PR11MB3180.namprd11.prod.outlook.com
 (2603:10b6:5:9::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6581f67f-056c-4c90-ff9b-08da38aa36fd
X-MS-TrafficTypeDiagnostic: BY5PR11MB4402:EE_
X-Microsoft-Antispam-PRVS: <BY5PR11MB440223AD9010E43A3EE9BB6DEBD19@BY5PR11MB4402.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2qXNowjpDVanWZKOHl8dLgLNws2Iw7W+czYhrPXekzuI/c7MIIIB90eIuc81MM561vSBKLMZbRjvwkdobXA5+R020iuYRimUWxVy6rQozQVZ0UsOVqt1H83BLNqjRKXmuMoCcR+rJ8cpmiYb8dRxoATjSPtOXyCeeplHRM7fRI3cK8V0W719qU3Pco4YHRQTq/QE+22la59TJRcmLG4UQHGOPnrXUBALp5JeRJFTOukK5fz/OP7a6RLH6r8To7ctbOSi7k0F0qyrrsxIVoeZYN90yOVUG1uJh7/Ozhqkz+i3QcvrN43h26j54lbq4lU/XoEOfGE3f9dO2+oFr8ZAmm/2CFNXQk8AllEaV0Tt4QHkDxDYE1ObUV25WzKKc5EbvALkyfCMb5YJIeVhJ2saWHINlxQI2Ko4VRI45Il2CUzBSqm9donf7V/OpJ29wYaM2yndMaV7uHYdWlwFd/PbC/qVNfjNAg0ULiB0ZkvUbaW8nUf3YyRz43icl2p4JqtImXINPbpE8oojbf85mBQ98/VBrkM1DFloRf7uJfTY7wDnq8GhFCTQUlrlp8Z1pzJRtvoeWaeobQtHrVjRB5SfkjBi95IAx/vu/E7z1P+uSmhFgH8BUVX7N5nBGlCauB59AW7h9g96RVIapAt0wnB80Oaby8YEkN6xc3SkfOyB3UsrQlyAonkCmK8mfQfHh+3Sb2SbKJh32xhf1Ezu6BXvhnbMKf8dYc95uXvI4LpK0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(36756003)(4326008)(66946007)(66556008)(66476007)(7416002)(8936002)(5660300002)(508600001)(8676002)(2616005)(6486002)(31696002)(26005)(53546011)(6506007)(83380400001)(86362001)(82960400001)(38100700002)(2906002)(6666004)(36916002)(186003)(31686004)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjVENmJ3cTU4djZPU0NlbDA0VXd1Z0paczY0MEM4bUx2MXZpeVhPbkxSQ2VB?=
 =?utf-8?B?YzZlTktuSlo1bGdGUVNpSlprMXNZZDJzdmFKNmhWWVZpb0daVEp1VmxIMzdQ?=
 =?utf-8?B?b1lkRW5pWTJpbFIyYk9JeVJkQTFuL0pLQ1IzY0ZmRHlmaDZuRWhjcWhVa1Mz?=
 =?utf-8?B?N3dtTHRURUVWajJjTWVDRVNOaHdsOXdBcGk1MWJiL3hFZnZEV0ZxYzFnSG83?=
 =?utf-8?B?cHpuUkdBTHU5aS9JQXV6VmhlSERtOVZGM3ZOVWpSNjJGNEhxaVJibnVlSEUr?=
 =?utf-8?B?SjZjN0w4UXVZSG9aZlVCMmpaQzZhZzJFSDhPalU3OEtmdmNLUTBReG4rT21J?=
 =?utf-8?B?d0NVcmRnNDlFb09LQ1RiZ2VnRm03ZmtjOVY5eExRWERoaFdqa1ZxeDlxbklj?=
 =?utf-8?B?SERxcklrMlhwdElhdDcrSW10aW13Yml2YU52bExuMjRpRGRHcFBjNU1VU21E?=
 =?utf-8?B?QmthYzgvdGlMWDVKTldUamhzWDlTbUkyN2kzVFdGT2lzT0JlQTZ0YldIMEpH?=
 =?utf-8?B?a2xzVTR6LzVkak1OamhTYVRRQW9KT0pvMUJBVzlER3pPU0FYZTRsMVpZc0l5?=
 =?utf-8?B?TE9HaTZUZVJLdXFRbk96TytIV1JPYVlFWGlSbUxPcE9rTUZFaWNlb2c2VDVT?=
 =?utf-8?B?eXc2TWo4dFlGZVZFdDFERStqamw1V0NiK1lJN3BqSXV2NnArNGZNU1E0MHhM?=
 =?utf-8?B?dlppa0gwZTFuWWxBU2c2WDlEdUtndXVhblRLYWlhbWJQc3lMdGZ6eUFwamp2?=
 =?utf-8?B?dEpOdUhST2ZpaE4vYmNNSmRIQVhpMWRPNkY4dUF6ZkJuV0JPWlJuenZ2cjJZ?=
 =?utf-8?B?dDBObHNOT3pKVGJUcnc2ZVBnNkZNb09MU1dwVlNwUDFaOGRrSTdLaUpCNlhP?=
 =?utf-8?B?ejVWYXZjZmtPdjYvRVdVbDdhVVNKdEpFcjJLeEM5eDRjdkszajQ0T0haNUcr?=
 =?utf-8?B?MEtsNW8vQ0JCZVVjVGd2RExKbUkxeDcwOUI3RlF5SWJoTWxPTHZWOUJXeURj?=
 =?utf-8?B?TXlDQklGM1VRU2FpNTVCa0tvYi9MVmZHYzZMNEZrY3liblhkbEZCbER2Mk91?=
 =?utf-8?B?dzA1aFNqeFE2eW91SGRTVzI0TmY1eEJLTk9MVGdFZ0JoVmZaT3N5WEYvZ3dD?=
 =?utf-8?B?SFZyWks4NTlwbklTUnZrTWFtQmsyNGdxek0zN1NBK1dSaHJrTDE0Sk9vbldC?=
 =?utf-8?B?RFFjTUdleXdISEd4Wi90Vjhzc3hYUlg4NmF4N2Y3RHplbEszSS9uVlpZVE02?=
 =?utf-8?B?UnNxakZDQUtyc3VSbUlXZlVIL3NzbnBkUHZNbTk3ZGV4cFVYNDFGdmtUVnBE?=
 =?utf-8?B?RDNvblk5NEZVYWZzRWpzclJLaGYvZzBxcTRydVRHejRhU08xT01VZi8reWxy?=
 =?utf-8?B?SWlTWkU0WGZocUFPS3dZdWNXWFVBdzErTW1VcUZaZkN6K0RxazZuTkQrOUxD?=
 =?utf-8?B?VlVKalgzLy90eEVuWEdxQmV6bzFlNlRIV2lNbHBnUDRYNGVsZGZNRFlKT0ZQ?=
 =?utf-8?B?VkZZbEoyYVNGbVZsdW1FWnlISGxzYjMzdWNieW1tRFhVdmYrbXBHdVc4eVV1?=
 =?utf-8?B?S1hVYjA5TDduTW94L3gwcjIzUVkxZFMzVFF5MVVXU1NHUWlkemdSbVZHbWVi?=
 =?utf-8?B?YUN3djYvaWNUdkFDRTNUaDRwQm45dytaeHJPU3F3Q2lKZFJjbXB2NVRaM3ps?=
 =?utf-8?B?a1lSd3lQRGJORnJhTEtSRVNacERmWkVFcUZyWGQ0Mi9jQWFnV015RGNGZ0lT?=
 =?utf-8?B?bEwwN2ZmNGZ4U3ZOLyswa25RSXR0SUFJY0JJTXZmL0ZILzlhSktWb3hHTVhi?=
 =?utf-8?B?dGtXczN6N1czdnd4R3RxU3AvcXZ0Uk1HakcwcXpzcEsyVlcrcEwwUXJuTWNE?=
 =?utf-8?B?RjlTZHdybmJ2aUpNZmpSMTJQSnZiQkFZOVpMd2pSWjBqUWNOZU1YcTZSUU1l?=
 =?utf-8?B?bzZndnpXQ0xMU3BaUXFUNmFlY0t0R3R2NnRnUVdaMHEzdDIrRndmYXl0aGRi?=
 =?utf-8?B?NTRyYjNTeHk2VnR1ME55OExVYkx2NDRrOUJtZmMvd0lrNVZQcXY1MHBoK2R2?=
 =?utf-8?B?UGFUeG9DOFB3cG5ad3dyMFpGUGVRUTVjdXNHWTRRdWxkUkcxWS8wYkYrajlr?=
 =?utf-8?B?VFE4Tk1lNHc2U0xmcWppTDhGN1MvMlFQSE41T1ozSUtCOTJvNGZkM2labHh2?=
 =?utf-8?B?TTBoRjNuWlVzT1Q0ZnlCZ3JmcE5oNm5jU2kyY2hpNjhZK3VOazVvSnFLYllZ?=
 =?utf-8?B?VGtpYmJDSGNkNDlKZ2xQQnN6emJvQk5zeVd3YTY1Q2swdHdsbzFkUGQyNFZO?=
 =?utf-8?B?anZVZmRES0JNSjBhWW5IMFdQbzNlWjdGYjVnOU5QMXFzSElrTFpyR1lxWjlu?=
 =?utf-8?Q?FMKNpRa2rqGaLaps=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6581f67f-056c-4c90-ff9b-08da38aa36fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 08:41:34.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqVZONho5dBArtTHJmOx9cWQZ8Dv4kpCyi3xZpqs0yqtpZmCOrPWJuW+pwAhLCLf6fydgAHWcIm4tMiYTkd0tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4402
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2022 14:55, Smitha T Murthy wrote:
> Renames macro IS_MFCV10 to IS_MFCV10_PLUS so that the MFCv10
> code can be resued for MFCv12 support. Since some part of MFCv10
> specific code holds good for MFCv12 also.
>
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>   .../platform/samsung/s5p-mfc/s5p_mfc_common.h |  4 +--
>   .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
>   .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 28 +++++++++----------
>   3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> index 5304f42c8c72..ae266d8518d1 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> @@ -774,8 +774,8 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
>   #define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60 ? 1 : 0)
>   #define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70 ? 1 : 0)
>   #define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80 ? 1 : 0)
> -#define IS_MFCV10(dev)		(dev->variant->version >= 0xA0 ? 1 : 0)
> -#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10(dev))
> +#define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0 ? 1 : 0)

The " ? 1 : 0" part of the macro is redundant, you can remove it here 
and in other IS_MFC*_PLUS macros.

> +#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
>   
>   #define MFC_V5_BIT	BIT(0)
>   #define MFC_V6_BIT	BIT(1)
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> index 72d70984e99a..ffe9f7e79eca 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> @@ -236,7 +236,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
>   	else
>   		mfc_write(dev, 0x3ff, S5P_FIMV_SW_RESET);
>   
> -	if (IS_MFCV10(dev))
> +	if (IS_MFCV10_PLUS(dev))
>   		mfc_write(dev, 0x0, S5P_FIMV_MFC_CLOCK_OFF_V10);
>   
>   	mfc_debug(2, "Will now wait for completion of firmware transfer\n");
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index 8227004f6746..728d255e65fc 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -72,9 +72,9 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   			  ctx->luma_size, ctx->chroma_size, ctx->mv_size);
>   		mfc_debug(2, "Totals bufs: %d\n", ctx->total_dpb_count);
>   	} else if (ctx->type == MFCINST_ENCODER) {
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev))
>   			ctx->tmv_buffer_size = 0;
> -		} else if (IS_MFCV8_PLUS(dev))
> +		else if (IS_MFCV8_PLUS(dev))
>   			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
>   			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V8(mb_width, mb_height),
>   			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
> @@ -82,7 +82,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
>   			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
>   			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>   			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
>   			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
>   			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
> @@ -133,7 +133,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   	switch (ctx->codec_mode) {
>   	case S5P_MFC_CODEC_H264_DEC:
>   	case S5P_MFC_CODEC_H264_MVC_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   		else if (IS_MFCV8_PLUS(dev))
>   			ctx->scratch_buf_size =
> @@ -152,7 +152,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   			(ctx->mv_count * ctx->mv_size);
>   		break;
>   	case S5P_MFC_CODEC_MPEG4_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   		else if (IS_MFCV7_PLUS(dev)) {
>   			ctx->scratch_buf_size =
> @@ -172,7 +172,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   		break;
>   	case S5P_MFC_CODEC_VC1RCV_DEC:
>   	case S5P_MFC_CODEC_VC1_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   		else
>   			ctx->scratch_buf_size =
> @@ -189,7 +189,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   		ctx->bank2.size = 0;
>   		break;
>   	case S5P_MFC_CODEC_H263_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   		else
>   			ctx->scratch_buf_size =
> @@ -201,7 +201,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   		ctx->bank1.size = ctx->scratch_buf_size;
>   		break;
>   	case S5P_MFC_CODEC_VP8_DEC:
> -		if (IS_MFCV10(dev))
> +		if (IS_MFCV10_PLUS(dev))
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   		else if (IS_MFCV8_PLUS(dev))
>   			ctx->scratch_buf_size =
> @@ -230,7 +230,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   			DEC_VP9_STATIC_BUFFER_SIZE;
>   		break;
>   	case S5P_MFC_CODEC_H264_ENC:
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   			ctx->me_buffer_size =
>   			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
> @@ -254,7 +254,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   		break;
>   	case S5P_MFC_CODEC_MPEG4_ENC:
>   	case S5P_MFC_CODEC_H263_ENC:
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   			ctx->me_buffer_size =
>   				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
> @@ -273,7 +273,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
>   		ctx->bank2.size = 0;
>   		break;
>   	case S5P_MFC_CODEC_VP8_ENC:
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>   			mfc_debug(2, "Use min scratch buffer size\n");
>   			ctx->me_buffer_size =
>   				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
> @@ -452,7 +452,7 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
>   
>   	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
>   			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
> -		if (IS_MFCV10(dev)) {
> +		if (IS_MFCV10_PLUS(dev)) {
>   			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
>   					ctx->img_height);
>   		} else {
> @@ -668,7 +668,7 @@ static int s5p_mfc_set_enc_ref_buffer_v6(struct s5p_mfc_ctx *ctx)
>   
>   	mfc_debug(2, "Buf1: %p (%d)\n", (void *)buf_addr1, buf_size1);
>   
> -	if (IS_MFCV10(dev)) {
> +	if (IS_MFCV10_PLUS(dev)) {
>   		/* start address of per buffer is aligned */
>   		for (i = 0; i < ctx->pb_count; i++) {
>   			writel(buf_addr1, mfc_regs->e_luma_dpb + (4 * i));
> @@ -2455,7 +2455,7 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
>   	R(e_h264_options, S5P_FIMV_E_H264_OPTIONS_V8);
>   	R(e_min_scratch_buffer_size, S5P_FIMV_E_MIN_SCRATCH_BUFFER_SIZE_V8);
>   
> -	if (!IS_MFCV10(dev))
> +	if (!IS_MFCV10_PLUS(dev))
>   		goto done;
>   
>   	/* Initialize registers used in MFC v10 only.

