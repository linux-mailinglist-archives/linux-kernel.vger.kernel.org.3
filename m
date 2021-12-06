Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F62846AABF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352833AbhLFVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:49:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:39851 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352691AbhLFVsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:48:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237357849"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="237357849"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="514938417"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 06 Dec 2021 13:45:21 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:45:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:45:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:45:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b75VW48eFo/7aniJJjCxV/enNTKTb0vhFnpj68SR4xGsG1y8X3UusaKYhcEwu0BXtlBaqchiE4Fq1ulDaIDN21izQXn6+SNuG/aWJmCaF12bbBLBjNbK/2awQOU38DciX3umlSja9h3y/+TrxWpbGJfHdcGUJNkII0NFdSEUskw0t2qDTxa5uKVMSL40t5ISj7OaqSVivjrHOYl2zIOkIKRC2rZ5dvwJe3+ToT1Iw6PjjanXLBlbpEyHjR+V2yRhCrn28grxGhhsZQVqEnNsSdLkglr6Df9Y4A7Fo6HPVZ28MUrFMDx1fHq6J4tYb1/OxDwXbD2fde/1dWnP0dTb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsy7J96UDhkX/jSTdJJus3cEehAhS2IZD7IozhNzKLU=;
 b=jOdZtuDI3TAbqJSOf6Uko5fnC7xLkHnX0/YxiadeOh5VL8BzhQF1AhAXTAO4U1NxIqox3r4t4XX6bnqUdiB3F8Zfr0qtXCtToV95yL/Pjyx527siyjA0izjn55johumwBHJC0K0NyDuv2EyC5K4WWJz1witcXu8V2XL9Pk3zdL58EOlgf5YkrhFZToRmRSOjG/Kq7Pb+NJdEsy3cO3hiBlkUvTJuCG5XzLzsWlg79x5PSgxx3XvI6L69UJw2owKYSFjWNs7JulYYZlkhfHTYbAVurw00ohocS83bEYrcOkSszS2XABd7OcxPxSvZWvAtcdwcVdxAMzVeE9h+3C04ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsy7J96UDhkX/jSTdJJus3cEehAhS2IZD7IozhNzKLU=;
 b=ckxxBtpTRQPldkUINUf/Ephnz6w/rTV+zZCpF3PhOPnX4Qn8tPeyPOMPsNr3sK16M06kZTAN+EGXu7L6C5D2Okc/cAUsLN1fP5wZlAQc74yt3Bwl1EWxv/t/JiA2SgKy/g2s4oOtdXxQ1b7M0ETQGpscjPyndPnavf4SJOAX0do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN8PR11MB3729.namprd11.prod.outlook.com (2603:10b6:408:81::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 21:45:18 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::bcd0:77e1:3a2e:1e10%3]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:45:18 +0000
Message-ID: <0522af41-59db-e621-69de-ad64dec3a5d6@intel.com>
Date:   Mon, 6 Dec 2021 13:45:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH 14/25] x86/sgx: Tighten accessible memory range after
 enclave initialization
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <luto@kernel.org>, <mingo@redhat.com>,
        <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <seanjc@google.com>,
        <kai.huang@intel.com>, <cathy.zhang@intel.com>,
        <cedric.xing@intel.com>, <haitao.huang@intel.com>,
        <mark.shanahan@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <66da195d44cbbed57b6840c5d20bb789c06fb99f.1638381245.git.reinette.chatre@intel.com>
 <Yav2ckVPrHSgCw/5@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yav2ckVPrHSgCw/5@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1401CA0012.namprd14.prod.outlook.com
 (2603:10b6:301:4b::22) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR1401CA0012.namprd14.prod.outlook.com (2603:10b6:301:4b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 21:45:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d129361-125c-4c8e-8d3e-08d9b901b1f9
X-MS-TrafficTypeDiagnostic: BN8PR11MB3729:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR11MB372901B312270B48D5C26263F86D9@BN8PR11MB3729.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P16Che3FxdGkFKKFMskxb1T1l/1lc9O6uNHANns7ycy0kaG+Pr9sqaBSZiWkbtSi9Vdb5ZJJpYM8GEFli/BVQ8PJKroFgZ6Yt6gyBrW8dM5iEj8glajm0Tx7HcuZNY2xgxONJkjPKbcPsG1Pqs2ZmpBEsdA0MIYybvXdoqolSXVIR2/Ze4qNf1gG92fn57keH5u92Is4upoWIPMepGdN7J364TIUgvO7zxHLjIdnLO+azO42N5tkyfWci5Ie47lDrW6Tg+htC+1hVNIwRIo8cwcmr0YXJF12q7BXVfp7iBW2V9vt95cgbAPI01m3SdYdJi7qxrNfrIJKxzEi55+sl2c8ZqCASifC0zsYDZcXJCuIuXxTpzwNKFnxRZqAaZnx/axHMKy70EFuy+dZBltjaiFP2qetXDkNz9U/5we2lCR5YKS/fUObaSdLmeCGpeR1HZGbnmfZfsE26RbLufUCOVBUesHOvI2D/zpgVNTkmsBdGO/zQot3cJ8qGQosAO2VWyhX7W3GzCqCBCF9fOjTf927YHi5p1HX380ZeMrK2DBsxdHfVB7mHVx7TGWOKALQ6iCMROpmOg172iCr5vDKPbOs2nbjXVDggG3MJkwmy87gZyxLeHAYEtDxzSZTS9b24cPPkOrKwjWKmdkOwW5yQc09w408nqIsTq2PU82eYSIln+jCP/XsjFBIys22ycWghsDmIA8edEeBMv9M/Bkz/kKGmvH3KjxhJCftyNCjOLYd3Sr8Tl2zVG4rBoD5EP0O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(6666004)(4326008)(38100700002)(186003)(5660300002)(36756003)(31696002)(26005)(31686004)(4744005)(7416002)(86362001)(6916009)(6486002)(44832011)(508600001)(2616005)(956004)(66946007)(66476007)(66556008)(8676002)(53546011)(2906002)(16576012)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNVR2hXaFlPTXhSOVY1Y1NKU0lmc2FQTXBjaFE1aWNOY1J2cG5mUzZMZmYr?=
 =?utf-8?B?bUJPTG00ditjZGpJLzVYRktRZEMzY2FqTnpmMjVsU01US1JWbVBsVWZTZUc2?=
 =?utf-8?B?MVdtRDlPZXRsNWtQZitiVjBrTkQyZ21hNzVISU1MU2Q0T0dlS0JLTGtmTHgw?=
 =?utf-8?B?UlB1OFg0NXJPMDJkWUxqY0pOR3ExelhsMU11UjRWdEtzRmRxdzFlU21UdWlS?=
 =?utf-8?B?ejFnL0FxSmJXTmpja3pCeWNLS1BDTnZ0cjdNMStqeXdZOUVsWnlQazY1QXpy?=
 =?utf-8?B?ZHl1RHAxR1VxM2pqcGRwcjBhUkRia1NTakJlc255b3pKNVNRM3RIZWQzWU5K?=
 =?utf-8?B?WFBXMFFUajBPNzFoK0Y3dlRLSkZ0VlNMaHlmcWwxL29ldUR6OWFCM3g3Y0J2?=
 =?utf-8?B?d2M4cWRyUmIxbEdYSmR4RzY3MllqRDdid1cxQjBzM0pHaUpCYzMyNWpDKzEx?=
 =?utf-8?B?MHZiY1FOS0M0WXRoYTQvNTdFdUN2dkV3RCtxWStXeldrVWhIU0pCV3REb0pv?=
 =?utf-8?B?ZkQ0YlNMRlRMZFpuMUtHTjNRRzJDNmlSZUthRzhUbkV3WDR4L0RHMEhJeHpn?=
 =?utf-8?B?T25BajNtZFZ0dEZQK05MOE41U2djNjBEbm9hQmo4Y0granpkRU1aVGxCOHB3?=
 =?utf-8?B?S3BoUTBLek12bVhDakhYZDJNeGlvbFVZd0xQbnIwdFcxQ1A3MTI4V3NjRmJu?=
 =?utf-8?B?TVJTWGswTEpxUHlVR2lJWTd0RUNIbTJ2eXBxWVhYNWxCc0NuZkJyRS84djNR?=
 =?utf-8?B?a2RjYXRjMW5DYzNQdTRmcG9iYTE4blV2bTVuKytlYVhITFBZTzQrMDFpeVQz?=
 =?utf-8?B?TjdybTc4TzNzUmxvYVNncXJGbWt0TjlTaUxqRTFscVlEME81MmZkTWRPcUwx?=
 =?utf-8?B?MTZyQjNFcWpFSHNZL2RPalBVY1pHUjdEcGFNcGoyeDFCU2lEZDRVMHlNa21S?=
 =?utf-8?B?dkg3RjVnTUFjYmo1THIzK0N6U0hXMjR2MVZRWk95c1RUTjNzM1dINXFQVkpR?=
 =?utf-8?B?RS9NOEU4dFBJS1dDV1cxWG1mb1dxS2NKT2FBc29INXJ1b250dFZoTlQ1dmVo?=
 =?utf-8?B?N2dzbDI5cjlqNkduRmdtcUNxMHNOZUlUbm03VWpHYUMzNW1kQW5ZMFdZdUo2?=
 =?utf-8?B?SWVKOU5zTVN5S0pYS2kvOXgyVFNBQmNvUkdPaUI5N1JuWTdNU2NzOTUvamRC?=
 =?utf-8?B?emVLTURFRVcwZjV3VFBmOW1wNENBUUxBK3pRUDJVT0hqY1ZPOWExSkZDMEd6?=
 =?utf-8?B?R0lzR1dGM1BPNUxpOUk5aHNCQWlwUW9Sb2pjNmVMWTB0cjdlZTJYRnVzTHZH?=
 =?utf-8?B?V2tORVZLRFhrdXlPZnZ0MFErQ3IyRTFwTHFkSVppU1pCK3VZcUU5NXdKOTky?=
 =?utf-8?B?WHBQT0ZUQmRaaFFZajBGaGFqcVY4SUhqcUphc3BjVElZampWNGNncmRiU3R0?=
 =?utf-8?B?bmZjNitrTE95eExyeWxCSjIzdEVJUHlYRXZmNFE5OVlTNTBjNk1qZ0NEdEFU?=
 =?utf-8?B?MHI4MjZobURRMWFlenBMOTZtR09ocnVQTmh3RktFYUNySXhKYVF4ZzFzTzIr?=
 =?utf-8?B?Q2s0UHp6MVhsVDkrOGU5aitTcXloaHYzWW5FQ0VURk5EZmRaTVRpT25vMFlB?=
 =?utf-8?B?dk5naFlIMWxxYThua0VJc3NrRUp6WWVXWm5KUktNU2ZQMVVCbGkzTmhLT2Jh?=
 =?utf-8?B?RzlMUTY2Q1FuZW9lZ0IwSGlDeDFhRm0vN0sxNldvaE8zRlM4TExJNTBJSHVE?=
 =?utf-8?B?KzBGU3hnbXprWHdCeWZCZTgwdFgxMmlsclFDZ0NnNHIrdFJQbWFSbURzdzdH?=
 =?utf-8?B?ZmxmLzMwWFFoRDVxS2xJT2xZMVNWN0diWkk1S0puY29MS2Y3Z0xxdWtiNWdz?=
 =?utf-8?B?ZU4xdmoxVVpzQUk4dDJiakRGVU9Db1BaektQZ1JZNERMWHhpVjdCYnJrMGVF?=
 =?utf-8?B?YU12azZNVCs2bTcwSHREQkplMWxXWkZ3TXVnVlk5RXhRQ0RUL3piR3REMklQ?=
 =?utf-8?B?eHplamVSd3RrNTVldkhYL1ErRE9KRFA0OElIV0pUM0tBQ1QvWlJYZU4yMFpF?=
 =?utf-8?B?WncwVzloUHJJclhTOGlFdW9PS1owVjdKSXpucEZqQURLSXRDWXVNYmxLOW1M?=
 =?utf-8?B?RzBhV2lOUmFVQXpIdVI4OWtWOWdzN3ZsZnBpYW1sN0dvbzAreW1venhlcHkw?=
 =?utf-8?B?MjJDNEdoaTkway9ObGthWTM2cFFvWmRCRXVGVGQvTXAyV0dlM1lrUUs2SS9v?=
 =?utf-8?Q?89odcQ6a32feiQRGuRYsxvmb1zGI3jF/vPqcgr+0XU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d129361-125c-4c8e-8d3e-08d9b901b1f9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 21:45:18.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh1O+//fn7n1HEXEDeNz+14A2GZXaXSS4EpTtrZSe3xa3MtddClQqejkjIzqgSnffxlqBUdUPK3ciujoTVx9sGEn9GU+YsWBW3TRTV7PmqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3729
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 12/4/2021 3:14 PM, Jarkko Sakkinen wrote:
>> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
>> index 342b97dd4c33..37203da382f8 100644
>> --- a/arch/x86/kernel/cpu/sgx/encl.c
>> +++ b/arch/x86/kernel/cpu/sgx/encl.c
>> @@ -403,6 +403,10 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>>   
>>   	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
>>   
> 
> Please write a comment here.

Would the comment below suffice?

/* Disallow mapping outside enclave's address range. */

> 
>> +	if (test_bit(SGX_ENCL_INITIALIZED, &encl->flags) &&
>> +	    (start < encl->base || end > encl->base + encl->size))
>> +		return -EACCES;
>> +
>>   	/*
>>   	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
>>   	 * conflict with the enclave page permissions.
>> -- 
>> 2.25.1
>>
> 
> Otherwise, makes sense.
> 

Thank you

Reinette

