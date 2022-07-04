Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC092565DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiGDTRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiGDTRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:17:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0C96351;
        Mon,  4 Jul 2022 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656962219; x=1688498219;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cfR/lMwjXMQvAQVDIBh45jPUNzL3PPKWxvCOD+XM0Do=;
  b=iyEMtso+U4gtSI0OalN2i7y7Mj5P91GE5iCyy1B5qCb/SG3uAHa+KU7B
   E6/Iik3vKeyDYYUJxkxfYY1ooWmAdHYB28MZD4SrNor5UHL+Y0t0RvVFN
   yPSIRmq744nyyE+r62j5IMUXny92b+od3cug/B8EBR6ss50Y2yg0c5Qig
   vxW5E3Q3RzggtIrGdQQ7lSWlgTWS2wVUvtApvguu08kbaREVx52JNYosf
   Es/4xjKXBdiYptZ7CFdBeoV2nhs1AkXtXwzLP7tSVMpZHx6Xqghp3GvjX
   E3JZ4oZ6f1rFVtZGYW/ONCmQktJP/gub5LV7J9P9g+i1PkBsXgzRgahTJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263609302"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="263609302"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 12:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649734301"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2022 12:16:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 4 Jul 2022 12:16:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 4 Jul 2022 12:16:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 4 Jul 2022 12:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmLk721ih6gk4UXRhuX9ELxPfX2Q1s6jDPvwayyiT8zL3nFz+FvAFxiQ+r1J4ryryAdQRmaTgjJN4+kEvLW6u6D4icj5c2lYn4q+1JuzfTl3BvJjsdBK6EnNhjHWD5qrNOiJ52ZkZACOxDzh2lnnSGkEd5LqsoY9Jis/WJA1ayTNYT+rUuqkpk8ryRvZBcVgez+CDxY8EFkCnpO8DZIyhVid8k4nb4U6m9iBpsUea4Ya7GNK/Rhk3kq39wpKhf+9aOwTADt9AKQJAKR5j9Y1ZxggmewxgCB7Qltf+yNW0GHlbT+V6vMBwav6YsgSJHDD+BENYdq0EGuTCTMZtBTbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvYlkuRyfrpUHKIUy+vmMM3Wpr5G5Wr81W8VHlCVijs=;
 b=bDyw4NBW7FDY64E3bbCYhdsjWWAXZj67B/q7+VuipOlNyVHtNsJcsR7Ke9IbPazu1bzoSvfQFvNdA0JcE/vAxmeJsqlWhruO21sP6pwRPXq8B/24YyV4glHSIj66NAswXrvjrYW9Yu/nc1snImYiA89fUlsFVVnapv/PS6f28c6uAm7E6VxWp2T7eRsjSIp6FW/Jr7uNig0vb1OH19j74Jnvk9nEY1731uS4ZQ+D64OKoLGrLCfCSef5Jnc7D3Wo6tFplk8dLXajCz679zzuOajXIN9hFksXePilXQlavyWkzYJG7Z5zBKAg47l1C0TxofK0nTmjA8pLX4wTz+7EFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM6PR11MB3004.namprd11.prod.outlook.com (2603:10b6:5:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 4 Jul
 2022 19:16:56 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::71c3:7185:c877:74e%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 19:16:56 +0000
Message-ID: <453e4f5e-fd04-5aa4-3e2f-f9296e11abab@intel.com>
Date:   Mon, 4 Jul 2022 21:16:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ACPICA: Use swap() instead of open coding it
Content-Language: en-US
To:     Tan Zhongjun <tanzhongjun@coolpad.com>, <robert.moore@intel.com>,
        <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>
References: <20220704140614.39763-1-tanzhongjun@coolpad.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
In-Reply-To: <20220704140614.39763-1-tanzhongjun@coolpad.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::6) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b44755b-7695-415a-d177-08da5df1c277
X-MS-TrafficTypeDiagnostic: DM6PR11MB3004:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DasU7bGN+K6h6hsFk0LcNEJJt4XiFMTG3CfA8R5Lb1qO5LDZx6aoqdf2pMcpfCa1oszYpphoSwLNCu7php0ATBLJy5SFpbAAT/BcOc9tVbAtOtxxLBt+TLe/0QnLJcCl83fYVI7y4UEJajQX2VwyA9dL42lFfOvkfQ+/jFOL6CmR9/pS0o0mb/LDcv0JF7eahJlgqUE3fjCTzNP7pGhos+MAQcNWo5b3/joNMb7104faRUbHu2juj25R8QrvXTgdvXQ5LIJysx3vxzxPJHcuX+Va20XJh3N/h/mt04ZMixU7uPig/t+2mUA6aTFeqq/z40iI8ENrE/ln4xdwA1JGP8Uj23Z6XDnk53VljsuE4v1Jdi+UFCB50oTfYFEwcnbiJuv++/4DPo3LvrYiXPtb5FeRzHfXKxiqICionWiNU7RqObT/cHJF7L8fwGBTcGnDixjuLWVdfRj1BmL2IBKxVnjF8BQOyNrVnUqnCsPoqHg/uts30FdEormJZ/VQDyZP1P0NCXMd27PMQ0XI61LWkIuIa4A6g57ydxliiE2BI6UVZVDRTGeL2yFjypxySvx/fxKvsXULiBp+9ioJqi8IaK69yDMPD72rKxrIZy5qm01o/lP+cLGi46IMfIdGdAoRWZQuHKlvK13BxKT8Lpq4MhqZIKqf8k2NdAKWhQN+e7R1dpHLSW1ahyvtmsFW0Nph2mHxUyK64exkFD1jPjl0Hh74le6qLSAHqacxnLGV6/TebrQ08QvrKxGj84XBCVoN3hXmch4a2mDnzOL+uPi7k6aKpi1Pj9yWO8HOpej7oI4+O6BPYChuAy0nD+CtAaScLTgcE0kzeKYojsHR/tENTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(31696002)(8676002)(478600001)(83380400001)(53546011)(66476007)(6512007)(2616005)(31686004)(316002)(186003)(8936002)(86362001)(4326008)(36756003)(6486002)(66556008)(66946007)(5660300002)(26005)(2906002)(82960400001)(6506007)(6666004)(38100700002)(36916002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGoyZDV1K1dWRVRXWmUwc3dkdXFYdThxd0dyVGNCWVp1RjF6SVF5d0NsU216?=
 =?utf-8?B?VE5uZVl2RWRnT2ozeHlqUXpWNEJ4YnJvZzdsb3Bhd3pJWFFmVWdmV0QxOWJU?=
 =?utf-8?B?R3I2U2d4KzRjVk1kTFhQUnErWnVYdG1CS1FEeDdSR3V1a0REOXJoaFMybC83?=
 =?utf-8?B?SERqalFLMjE4c2xiTDlCUTZ1OGp5N01QYXRRdnFZSFpOVnFnMUN4WjZZK1Jw?=
 =?utf-8?B?OHFYTzdLNFFhbXNPSzZSYzRvSWxzRkd5dVgrY25IUFo4c1VOT0x1OUFIRFNu?=
 =?utf-8?B?OU5RVnhLMUxXL0hSR0lnQnUwUVA2SUs3TThBL21zTk1kcHRQdzNMMFlacENI?=
 =?utf-8?B?cVBaLytEeWZTK0YwVTRtT1FsMFhsU0NmM08zbDhWL0h2MXVSVjc3a1ZjRXZ1?=
 =?utf-8?B?ZnV3aWdUcGdOVEpwZWRJWDY2MnZtRmNONDhGMkx0T3dkaTdteWVMbzZoYUdK?=
 =?utf-8?B?WUtOdUhBaHZhN2hHNXRQRzY5SnNEREd6YThNbkZLWm8yeDJtcmYyZ01GL3BW?=
 =?utf-8?B?UENhVGJrTTRycFkzUkRhc2JudHRsc0dHVDRZRVZ1U2I5bHB6SUVaNnF6VVRF?=
 =?utf-8?B?WGRyM0g0QUozL2VGcWpWOXFic0hOOEZ6TzUxa1RrRG5TbmUwUFFkK2Q5TDd1?=
 =?utf-8?B?MVZJalRKdy9RZi9rWEV3T2FuWlpSWUs1cUFIMGlPOHJPMlFSL1BuakppNDgy?=
 =?utf-8?B?T3dOM0FyZFpoNkdsZkhTK3EzTlFLY0taRnRaQXdxalBXNjB4aE90SlZOT2Z2?=
 =?utf-8?B?KytWcnFXVFZSUFlZOTYzSy8raEhseTBmT3FlanY2YVpuYlpxQ0Zwc2MvTytP?=
 =?utf-8?B?Q3N0YW44SjJHK0NkOWNFOXlxb2VrL01lZXJZYkhrVlJvZ3puQ0JKUjlTcVNW?=
 =?utf-8?B?Sy82ZzJxQ00rVEdRQkxyYUlUcWp1Uko1YTJNL0xYSkRSUWptanQwOXI0aFM5?=
 =?utf-8?B?VCttSi85M0V3OVdOczRGNmVFTFB5UXh0NWpXZ1NoZC90eDRjbisrZ3Bzc3J6?=
 =?utf-8?B?ek9NT09EcGIrQ2ROK1BSeUdOZFk3dVRiZGJoaDREbCtJcUxiZU1BOWh2RHAw?=
 =?utf-8?B?OHJxVnlNRWZLa0pTUlBxZTgvUWJwTmpmTHZSWFloVWFlaUQ2SGt6S0dnb1JQ?=
 =?utf-8?B?QUJNSllqMnlIRzZwODQxbFJiUldmUGlhTStnWlVuVUpGV01iZUFkK0RVTkxy?=
 =?utf-8?B?cHN2bnVBRlhGSHRIZzMwNHdtOFZwRTNZYlNGZWpCVGhUQWZEbkk1dG1WaFow?=
 =?utf-8?B?eW1mQmZLa1pINlBnUmsxMVFUcFFyaEh4Zk4ydFEwZjU0djdPSXhsWEtITlNq?=
 =?utf-8?B?UU8zMWtxTzBrYzd4TWxNY09Vb1RlcG95NTZIY05YcVB5UHdPRWgrSHVmSFFn?=
 =?utf-8?B?N3NPZmhZeTJrTDNuRnRFU1NabHJIblZUM1NwVkwzY2t1MVRiejR4bXlIejkz?=
 =?utf-8?B?cGk4ZWFQVkZQRjFMcDNvWVgzMWN1OFFBZ25TUnQ1MzFFaWZmUHpjS0lnNzRa?=
 =?utf-8?B?VUNFdkQyRnM1ZEFNSFFPcnVwYzFwVjlodHZYbjl4b3YxL29UWXI5VlJ6V0lR?=
 =?utf-8?B?dndpQUtKSVpadkNBZkIyWmhNeTdIOVlrUnJIRi9BRDFYcENqU0tONVFaZi81?=
 =?utf-8?B?RmpOSUUrc1J6Y0ZOVmdkQVFwclFjampnOC9jTlg1UjJCdVluQXMySk44ZHF0?=
 =?utf-8?B?ZFRCamRFbXFTYXpKUFlYbjVwd0xiQ1YyN212SHpJVElLYWFaOFpqTVpjMGhm?=
 =?utf-8?B?Vi9FQUtxZXJJdU9udDkrZUhlUjhZS0xIRU5sZWNsZDBFQU9ITFIvakwyMFhQ?=
 =?utf-8?B?c0tlVWFzUDBodXJqQ0tmUmtZTU1ONFFHSVVaTnhuanZSaXFyc2dBRUVUb3lQ?=
 =?utf-8?B?SnVHT3lPSDhuQ0tSQXVXUTFqNkg3cmhVUmNWdDk1blhrQUZQdk1zenFwcVZE?=
 =?utf-8?B?anZoS1djSy9qU0E0TFRGQ29kTXhaMFlOUDdGZzdBSG13VXBqMkVGZmw1R1JW?=
 =?utf-8?B?UTBaQzhFaktMelVlOXdTMFNWb0R6aDB6MmtvM3BYanRzUHJCYmF6UFN6dU5Y?=
 =?utf-8?B?TE5pRmhKNWZqTi9QcUtIOW1SUjYxNVVObG15NGt1Ui9tRHgvaGxPR0F5VXJ6?=
 =?utf-8?B?MHBEWlNZRDF6R1phMnFxNER4VjNCTytFM3hkSEVwdzlZUGNXWWpob3pCMWVu?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b44755b-7695-415a-d177-08da5df1c277
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 19:16:56.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wo5Ad8SKwrjrUaJPs6OHO6mEQR9Nu14SanYWe7hvGgz1H0LBqn7Yks/03NTnaXJusNwqeTGSMLav1nAjXmEPnFqrbWODw4UbmtQK1DQgS6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/2022 4:06 PM, Tan Zhongjun wrote:
> Use swap() instead of open coding it
>
> Signed-off-by: Tan Zhongjun <tanzhongjun@coolpad.com>

Changes in the ACPICA files need to be routed through the upstream 
ACPICA project at github.

Please submit a pull request in there.


> ---
>   drivers/acpi/acpica/nsrepair2.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
> index dd533c887e3a..3735ba06ea16 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
>   {
>   	union acpi_operand_object *obj_desc1;
>   	union acpi_operand_object *obj_desc2;
> -	union acpi_operand_object *temp_obj;
>   	u32 i;
>   	u32 j;
>   
> @@ -892,9 +891,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
>   			    || ((sort_direction == ACPI_SORT_DESCENDING)
>   				&& (obj_desc1->integer.value <
>   				    obj_desc2->integer.value))) {
> -				temp_obj = elements[j - 1];
> -				elements[j - 1] = elements[j];
> -				elements[j] = temp_obj;
> +				swap(elements[j - 1], elements[j]);
>   			}
>   		}
>   	}


