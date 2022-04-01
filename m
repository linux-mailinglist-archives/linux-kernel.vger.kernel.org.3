Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E44EFCEA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 00:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiDAW5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 18:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiDAW5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 18:57:07 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7457810CF17
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648853716; x=1680389716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KkvcoLHqX8MU9ENONyle9dYUUe+T2XfHV/rbBfgD+h0=;
  b=WtmEQyb7J8Rj+TEHrQmK6v35sDynCPndobRatkV7aSwhedUa+F8b0WZy
   ui/YOIK7V2bCHD4Ut0cATGFcuz+hqbFVJbrPCdnjDJib5R+F/tdfvNZLy
   7uiygcEQ33qUqquOt848uRafPeIZDhq1xjzinYHK+uad1zlI1yMHVSgW5
   sQ7fYrOOHVaxJ5hSFRZpwCVkxmv3yd512P+1tgUf07TQIC5QsMZIv32nX
   CKyiAAg8FMwjyX65rp1Z3ep5WENdEw3DY7pRj52EaSpSze/qLJ62ln80d
   LNi5aPYP5xYF3DN5xk174+7rRvzNABeAiBrCvWJJrXjtM8PxanaOYbb/4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="320946601"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="320946601"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 15:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="640683858"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Apr 2022 15:55:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 15:55:14 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 15:55:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Apr 2022 15:55:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Apr 2022 15:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZJ4P7c01lxS/FKKXOlmbQbTP4c1n5AHZ7th0UOtdGMB3otHKyYI3i4w0B/aho7ORTNfk65LsX83M0wU1ImF6qLtWJw4nuxNSLxZy6akdzqzh6Ilo7fm8jPtede3IQehPnPnG0DvvRo68NtT/Hls8k9a9402EgsoFqdRO/LR+XHmn4FhxLKmEvyhCT3Y4IdhBqmyDdd1Qww22X0f3m+cnAGZ2VAbUhF/Q/Wzo7NLKzk2Cvsc1r999kfOzmMD3bHD7KQGDVdLs6sRUGI96hx33meYxzcUmVQXI+UQdq9cs34UDJxUlttEdG+uppG6SvzJM1wmATII7DrwbkMWEIPGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3kgjEECgg2RHF7HWwfKFxz72pVz1m+kx9jhcOc5Etk=;
 b=oeNmtgp7qyCnwYuZmSCiF4fIsGjQ2sK4uOI0pCTFNk7F+tD8ci+Q6Cm1vz8RHkKAdoto3q71mAiKNhtQuHClv192HNoKYbIiH8+rh+zaAXzbIYsi8OOHOCsWMuJcSzb82wFGmsSScQran40tiepKnhQgAAQYyiM0kDta4U0cKKNeD7cuFGyud/Lbnt9tzqbZkVvhK3OkYI5srr/sqtg90N/XCJPDEMN2UhRgYHVeG11TsfSAGNeMGVWBQJTXFdpf7HD+uXQ+y3GhdAZ9jxoCdeTEVSJB/3aNl9AhqH55zaWDUxU/YUluHSxmWb44EenRiqfFKxHJXIe0iEs8EFsSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by SA2PR11MB4859.namprd11.prod.outlook.com (2603:10b6:806:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 22:54:56 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.029; Fri, 1 Apr 2022
 22:54:56 +0000
Message-ID: <91a43681-524e-c12d-612d-259e51bde12c@intel.com>
Date:   Fri, 1 Apr 2022 15:54:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-8-james.morse@arm.com>
 <01651414-9d4a-409d-9db7-b4b6dde72829@intel.com>
 <d49bdfad-df5e-77e1-4834-266dcd1b9055@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d49bdfad-df5e-77e1-4834-266dcd1b9055@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:303:87::23) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9b75515-dafa-48fa-5171-08da1432a416
X-MS-TrafficTypeDiagnostic: SA2PR11MB4859:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB4859B492D44C374D022EC9EFF8E09@SA2PR11MB4859.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nY6vJ7GBx7ExJINEaehsI+f+alUCwgMQ6QDrWd+l47U08Gw2d38sTHAp+fWA26/n0BVUiLOmVgfiBmNxka0uoEVi+71slakTTCrSRLujwgFb/x9s00Shgwm0aok5p5egSipAlZxjy2e+BMWNustcD+9BodykcRF/LYd6nUsclYv+5pd+BVkx6t63waJrNBqA8EhscyxW611c2PWu2CbKNvirpximY6Y7m4WuqJ5WVAOiHCUYz7QgGLaogfQadROCzDODCw25btAordnN9yih5c3L0jndaedsai9gl/UzUZvD1tk09mOboG/Kph9231izmHnCT2Pa7P/PISTF75OpT3UdfStQMmd8Je0+MgcFCigJt+TMJPcKGjfhUUaZiAGQYtpgJ3IWJTnVOFvMB7LbuEnhZIVtEqVbewvo5xtYmUvjHw+uVxIrAKOKuutJK8APPuOK0fLc1Axb+jMj65PyhGNt68rGD9iTol3UTqCoMX7uMREQ++yhXZA60yBwWYwaZozTZQMjFYD1ErUQx8gikEaASxsmoj2nmbY+/niG8LPdXyUDR/I0oQejdvRh0hccWuuG5L1FVZ/Xs2ZruWeUqM6eiGnbQWAK4uNdbIYV2bF+VDqthyZ3z9A8SbkMAYxdrosWoXVc8H6w+VGl9Maka2vcsjOcGkBL2HBCHtxIUF5bOEoNHhwLKLnHLCY0m0jwVwGnvzw1EpS3h30cBxP9UmRGbDBMh/4Q0NYtV1J7aTA7y9+x8vYW0FLcVS28DmdL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(36756003)(54906003)(53546011)(316002)(2906002)(6486002)(6666004)(6512007)(6506007)(31686004)(508600001)(66946007)(86362001)(66476007)(8676002)(31696002)(38100700002)(5660300002)(66556008)(186003)(44832011)(4326008)(26005)(8936002)(7416002)(82960400001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2pINWxjY3hQUEJLYzJJU2NVMFpqcGEwdTVCMW8xL1FqQ3dIYjFNV0poQmJa?=
 =?utf-8?B?MWRBVHhOMjV6d1hPemJSMi9qZ3YxeXNnanNLWkxDakNnNG50SlFLZ281ZlR0?=
 =?utf-8?B?a1ZzSktoOHRJbFlLUGhaMy96VVgxK1VZUDdnLzBjMHpQWDQvUUppS0tWdXI0?=
 =?utf-8?B?MzJQcnAzNGQwM3p3L3kvdnE5cDMyakxSOWJiL2pLb3lnVEpTS25aZ05HWkVw?=
 =?utf-8?B?TnpCOUMyRWdMdjcwNlZlVlV0b1cxZlFUZnRBbXkxWHJVcGc3VFIvaU8wdWxV?=
 =?utf-8?B?YUFwVFZacGw2bzNZQmduQ3hLMEJVVkxJaFJoL2NwUmU4S1hZcDlJdkp3Tm1s?=
 =?utf-8?B?RVlIZVdVQzJ1YkxPOXFUdTBIT09hUDZVM0F2aXljQ2xGTDBWN3NQd1gxTXV2?=
 =?utf-8?B?MEZMb1VDZHZwTVo0ZW9kTTBxV3pyYTRxbmROa1pGRTFHaldWbmo1ZlJyQkJD?=
 =?utf-8?B?R1RzdWtURDcwb1I3cWxMSmRLbndkMEtPNm5mNFJSUXBvNnBDYmJsYWFGWGRo?=
 =?utf-8?B?cERHR3NRbkxoQXJpcTB6d3NYMis3TU1sNG42UnB1ZVZORnhFMVRsTXZ0VnFq?=
 =?utf-8?B?TGJCaFJzVDBmQkhkbU1ncUl5QTFkbWVEdW1KcDRnTzgyTTRINHpJUjhidnZh?=
 =?utf-8?B?c2d4Ump3czBhY1N0SW9vSDlUWlZzTmFMUXkxeGl5ZkFFSmIvZi94VUwyV1Vx?=
 =?utf-8?B?YVhYMkdFdGFtNEJ2SUt3cmthUzQzMlJVMXF0SXlQYVprMHNSMXFuT0JDYXJZ?=
 =?utf-8?B?RkMya0dZdGI1akpwcFMyR3d0RVhKbkF4Nk5mUmFrZ1htbUkxNVhRWkhud2Zs?=
 =?utf-8?B?bjNVaEZnQlB5dERGODZTOEhrVzY2QXBDeldWS2F0V210ajY2NTdVMWFXdzFm?=
 =?utf-8?B?K0Q4NVl3cldCL2RLN0YycTBmcWxSaElGT2V0THhHVTlweXAvb0s4NE9wNlZ5?=
 =?utf-8?B?YjczZU1Ca2NtcktTd29uTkxXN1B6c214L2R3TzIwci9NRnlDY2NjK0ZxZHNH?=
 =?utf-8?B?NGorSHg3TFdrQ29kS25wMU5GSXMxa3pvNjZsRTFzSE1EZ2lSZ3c2eXRTelQ5?=
 =?utf-8?B?Q290eitYNUwrQTFkZ25lbTBweUpNOVJxYlcwOUJHN2ZWMlJMb1N2VWE1dndj?=
 =?utf-8?B?R0RqY0ZIdnk4NE5xZHliZi90cisxS1hhWkxnbHM1SmRQZGJnOHhqZUNVUXgw?=
 =?utf-8?B?NGs5V0dvMUJwNnVVTVdSaS9TZ3B5dXJkVjlYSzFpUTM1Y09YZVZnQ3pScitx?=
 =?utf-8?B?MTd0ZFpTelVPZ1JKTk44NzZxVEFuWU9FZVpqVER0SDV1Q1RDWTlZRUVWUHlR?=
 =?utf-8?B?dEIySTBvaGlacElleHJ0SlFzZHdoVkdsbjkxRzdYbmp4VzUwT1pjeCtVVzJV?=
 =?utf-8?B?aVE5a0R3bDdpR1NKS2Zuc2FPRi9xZnRoRlNqUi81UlE1bmNPWW1aN25ZMHNl?=
 =?utf-8?B?WFArNktxQmx2SWVOb0FFRnlVN0pDUGh5ellLWGdkTHRrWXhyMUxrekdQNldy?=
 =?utf-8?B?emc2WXdqc1ZYV21lZ0ljUFU0bDBRNUhqUzltVXM5cjJQOGdyTzlTZUVqSHNZ?=
 =?utf-8?B?T1Z4V0VlWGJSakduZllaY1pSZ2ZRVFp3MzJra295elowZVo5amo5MldHYlVC?=
 =?utf-8?B?aWlvbE52aEdZTHZocE1BVy9pZUV1VS92N1M0ZGVZMkxyQVJVeWZRc2xTK3Zk?=
 =?utf-8?B?Sm9IbFBQQ0szUVV5OEZURjJUUVlabVl3dk1ncHUrTzBQbFE0Z3B1dnBML1Zp?=
 =?utf-8?B?TEJqNEJvQjJnL0tuS1pUK2wxYXN1N3dHYkk4bStIbmhBSm4rTU45QXJWNzla?=
 =?utf-8?B?UGZ2ZTlvTG5OTVZkZmoxalViTEVTVmlCL2FNcitEMlZieDRVK1dKVzJEQ0Na?=
 =?utf-8?B?QkdzTWNLa1UybGpKUGJBM0xqcWhpOGxFTU9hVjYwVEs0eERFdzhvdFc3MXZY?=
 =?utf-8?B?N1pTWEpwU3M3RWNsOHAxaHNyc0pLU3RocHBObkZHMkFFYnEwejh0d1k5RDJT?=
 =?utf-8?B?Qk5hcVV1TkI1OHFWaE5NM0xiSy9lbzRZQVZTcUxWdE15OWxLbVJEMFprbEEx?=
 =?utf-8?B?MnNURUFZa3FEck53S2I2RW1iUDNHMFhXZDZZTHFUcXk1cEN4ZldtSGgxaC90?=
 =?utf-8?B?WHMxUVZGY05zOEdrR2tUNDJYUnRkNEZNZC9zTzg3Skc3UTkyQzY1RzhzaCtV?=
 =?utf-8?B?VWFJU09kekNucXVxL3VBdlpheXhldXJybXZWRFJ3d1JSNXEvR2ZDZWx5MDJX?=
 =?utf-8?B?bWxzWVNSRmNzL05WNTZkK2ZkL2xXN3p1UDQ5YXNyejlCMzdnZjA3UWNxVmtJ?=
 =?utf-8?B?NmZSK2xyWk1raFFpdVF5ekZaNlExenBXTTRwZzh1eG1JR3dKVXFPcmRGbFli?=
 =?utf-8?Q?BI6EJhrMMJ1pFcZY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b75515-dafa-48fa-5171-08da1432a416
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 22:54:56.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/bm2wrNL7W6G/nbbMW/qkoLA5sF+cEf8A339RbIUnvF9GkAQTUx78pvGFfIQ3HV0NG9n/fqWFJnZ0+pje6jGZyUvNRQByCZV10fYnuKRno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4859
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/30/2022 9:43 AM, James Morse wrote:
> Hi Reinette,
> 
> On 16/03/2022 21:50, Reinette Chatre wrote:
>> I tried out this work and encountered a null pointer de-reference that
>> seems related to this patch. After digging into that it is not
>> clear to me how this is expected to work.
>>
>> I encounter the issue just by attempting to mount with "-o mba_MBps" which is
>> the way to enable the mba_sc and exactly what this patch aims to address.
>>
>> More below ...
>>
>> On 2/17/2022 10:20 AM, James Morse wrote:
>>> To support resctrl's MBA software controller, the architecture must provide
>>> a second configuration array to hold the mbps_val[] from user-space.
>>>
>>> This complicates the interface between the architecture specific code and
>>> the filesystem portions of resctrl that will move to /fs/, to allow
>>> multiple architectures to support resctrl.
>>>
>>> Make the filesystem parts of resctrl create an array for the mba_sc
>>> values when is_mba_sc() is set to true. The software controller
>>> can be changed to use this, allowing the architecture code to only
>>> consider the values configured in hardware.
> 
> ...
> 
>>> @@ -3309,6 +3344,12 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>>>  	if (err)
>>>  		return err;
>>>  
>>> +	err = mba_sc_domain_allocate(r, d);
>>> +	if (err) {
>>> +		domain_destroy_mon_state(d);
>>> +		return err;
>>> +	}
>>> +
>>
>> Before the above snippet there is a check if the resource is capable of monitoring:
>>
>> resctrl_online_domain()
>> {
>> 	...
>> 	if (!r->mon_capable)
>> 		return 0;
>>
>> 	...
>> 	err = mba_sc_domain_allocate(r, d);
>> 	...
>> }
>>
>> Thus, the rdt_domain->mbps_val array will only exist in those resources that
>> support monitoring.
>> 	
>> Taking a look at where mon_capable is set we see it is done in 
>> get_rdt_mon_resources() and as you can see it is only done for RDT_RESOURCE_L3.
>>
>> get_rdt_mon_resources()
>> {
>> 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>
>> 	...
>>
>> 	return !rdt_get_mon_l3_config(r); /* mon_capable is set within */
>> }
>>
>> Based on the above the rdt_domain->mbps_val array can only exist for those
>> domains that belong to resource RDT_RESOURCE_L3 (if it is capable of monitoring).
>>
>> Now, looking at set_mba_sc() changed here, it only interacts with RDT_RESOURCE_MBA:
>>
>> set_mba_sc() 
>> {
>> 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>>
>> 	...
>>
>> 	list_for_each_entry(d, &r->domains, list) {
>> 		for (i = 0; i < num_closid; i++)
>> 			d->mbps_val[i] = MBA_MAX_MBPS;
>> 	}
>> }
>> 	
>> Considering that no domain belonging to RDT_RESOURCE_MBA will have this array this
>> always ends up being a null pointer de-reference.
> 
> Ugh. I'm not sure how I managed to miss that. Thanks for debugging it!
> 
> That loop was added to reset the array when the filesystem is mounted, as it may hold
> stale values from a previous mount of the filesystem. Its currently done by
> reset_all_ctrls(), but that function should really belong to the architecture code.
> 
> Because mbm_handle_overflow() always passes a domain from the L3 to update_mba_bw(), I
> think the cleanest thing to do is move the reset to a helper that always operates on the
> L3 array. (and leave some breadcrumbs in the comments).
> 
> 

I think this points to more than a need to reset the correct array on mount/unmount ... or
perhaps I am not understanding this correctly?

As the analysis above shows the mbps_val array only exists for rdt_domains associated
with RDT_RESOURCE_L3 but yet mbps_val will contain the MB value provided by user space
associated with RDT_RESOURCE_MBA.

For example, following what happens when the user writes to the schemata, would this series
not attempt to set the user provided MB value in the rdt_domain->mbps_val that belongs to
RDT_RESOURCE_MBA ... but that array would not exist for the domain since the resource
is not monitor capable, no?

Reinette
