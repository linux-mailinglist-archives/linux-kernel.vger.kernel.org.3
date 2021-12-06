Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4EB469519
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbhLFLle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:41:34 -0500
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:21121
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241994AbhLFLld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:41:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR4Vfn5tI0Jx+06U9jg8p3Q/k4IragzVxJEe9X8On/BV6MlWeYjYdzjbMv8CgfHpvq7sr4Z/Z0Pyno1+GRLN0oeS1Y6PpQSh/87ls7HvOPQSJlJP3nyHW1xSyWIjCkRp8Xo7bdcaa/tY0amiXc0+C9Un8gz8Rr1fmuMOFhoojsbeL9KjR6DY1d9aFijGC59cslxkHAGXWtahBlbL8lqE19iUBh/Tll7qyZLCadlUsnxHzwbWmje4+qzAV4DMDI0LpVW88oGoEYzgp8fM4Yd9LR+dTxPy9p2DVKnjXy4IoxBTNkC6TUTHhhMLy7QFFraitM+hDzKoTp8PemhkUqDMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hKFlVOvvAEUMYYqHC46rGoO2yr2jaX6XD3Mf4IFKz8=;
 b=oWJufrn6wwzSY59WI185iSiqIaPlYiXMD2dzEiuWmNFN2L5ROr+Qna3m/09cMfEcfff/7nzsoqQa66PVWkuO4kv4FmOnby3F67PVYdyTrbEp7b24xT5dugl9YbdIiTaDHl9Kp9AFmASWWNM7pVgbBPrQe+etuYgkgVBG4ReEK18pZecI4F8EVKQjF8ODbE5LVW5t6O8sZexlgQTZUH8OzwwdMFHtc9IUUK+I0FwK9WtCKH8t2WHvsD9b0WNXFV+fWWAZTdzg8bmPbaAE1n3Kcabb6vLKDcgLfFAnEcpO6fe09oM2CoDOEXaoE40hvDjpPR2H1/4eSbMF7szIB3EJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hKFlVOvvAEUMYYqHC46rGoO2yr2jaX6XD3Mf4IFKz8=;
 b=a+WsUo70tF3Mq0bTszBdNCTh/WpvDkcxXEIi73TrE5kVo40fEMr4FNjMgGvfuRub/Kyo2lwlfhFOvZBH2KfKkT8IiDCaATcUiqOYyz/i9dsNuPbYzOFosgCWpdLtioUxDBPvtV7iYh4QX2/fd9HkEbeNbpoLLzINew1p/w3hq7GtsplQVVrG5NVuCF2Le/5fuLXZ7vI/IMMsLJ3WcLFOjhQlO8v3753mN5CqDKuCbUnxIUMTTDCyd5g8TNp46tvZKCx45Lsf5pWrRYKtBQYbneOxEe67P4vFB7YyYG+8o7uwLvAjaB+NrG4GS6RFAWHb4xtxlSe9HdGlgCC03Skkog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 11:38:03 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ecac:528f:e36c:39d0%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 11:38:03 +0000
Subject: Re: [PATCH] reset: tegra-bpmp: Revert Handle errors in BPMP response
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211112112712.21587-1-jonathanh@nvidia.com>
 <3975fcc5ebc31761d513f1961ee054f5fe76431c.camel@pengutronix.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3c3c9bf9-4276-1eec-af65-143f97bcd620@nvidia.com>
Date:   Mon, 6 Dec 2021 11:37:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <3975fcc5ebc31761d513f1961ee054f5fe76431c.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0074.eurprd09.prod.outlook.com
 (2603:10a6:802:29::18) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
Received: from [10.26.49.14] (195.110.77.193) by VI1PR09CA0074.eurprd09.prod.outlook.com (2603:10a6:802:29::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 11:38:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cfb70ec-3ea1-4e96-c662-08d9b8acdd34
X-MS-TrafficTypeDiagnostic: CO6PR12MB5441:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5441ECFC175C0C0464032D5AD96D9@CO6PR12MB5441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bhl5lPFOVNXcLcfZPRvuG9rgC5G86CWtwrNui3dNy/DT/uUVav819x3Hra1Itxc2Wyjj8jauWb6TQcAOcPEA85aAMIQH3bZU32fQvwG8nfImrB3Rt+bYKIbBbnFLz1R+OlsT3i2Eh0ZImw890+T4LVaHov3+Y8tlGM7WYN14xJj8L6BvgcvGovNuF8pNgbh88RfLDHQ2oM2+Fsd8xV/dPphDW9uuC6QdohgdcY1VWEG7PBp1NEm446sRA2ez8RCww39Wvt08Wof1OykfLgCEGwjZ5dBJMbg2uvC9cQVr74rXj9nfQtJQfqe2F+WZJ6SRcVIJsUQLiuhQgTr+THom2tKRGgjzA5DZrhDsoVDuwHtMeSELzDz0Fji21eQW7t9skssvpLC1xBXZRHQ5m2B2oDWDFueDlj6Y8VUsPfSd87zQasbxlydg12BjXOsnQBZ0C2FTu0zIPK/mUuOp6hux2xVpUVgCF1H9ybxJfcIwu9ccNeArEgAgkBQbWB0CJC6t+DzH9RCQzaDLgXfTPtj3SNLpCgwHSKpszPg/2JlvtK6tePlvc/uGzDZxjOITe9Ff6MwsVuhavVUGRtDh7zG+4QlVS0//cHh07IGCiL7DR1/PkfMDzfwBeCtpKN+bhSlSpPgbvba2bwksMlfkS1cwIOJN06MQ306psa2Dy+qe9+5xeRS6BLiuDDRVqvDzjsSNbNPAoZFFUZkFVE8PQZaRP90xfRRRqliy2tvcrh8ze0wwmvbbBHlkInyIBV7vVwG8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(4326008)(16576012)(53546011)(66556008)(6666004)(66946007)(66476007)(31686004)(8676002)(55236004)(5660300002)(110136005)(316002)(2906002)(508600001)(4001150100001)(2616005)(4744005)(86362001)(956004)(31696002)(26005)(8936002)(38100700002)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5lK1oxRGFnSU1EcDRMUEEvUktwWk55eFE3WklYNG83ZGdGU1RhVTZsVEl6?=
 =?utf-8?B?dXQxd0tpdSsrRXpKU1Rya1VuN3FNamc1K25IQXV1YjNSeStEM3pOY20xbzFv?=
 =?utf-8?B?enQwQ0FwcEFuWHFrQ25SVXdQcXJwUFFzQTRSMUtUZ2JINlZ3N0cvazAxdklH?=
 =?utf-8?B?bjBmekJtdFdzK0V0dGdMb2ZaQXFGc1VuU2ZnWklPQVlhMkwyM09uem9SZzFt?=
 =?utf-8?B?d3JpUG9sOGlDc1VBcUhTWnhCN3d3QkxyYnVCdVBGNDE0d2FDbFM3WDFyaTQr?=
 =?utf-8?B?cnRYdzhaV1paWDVDbTlHaVF4ZnA5WFgyRTZIVGNncFJHZUZQSnpReWNuMmhO?=
 =?utf-8?B?K2ZKOCtIVFVYaEdjeW80eW92eVFuYWt2eitWcmU0aG1laTV4UUs1ZVlIUFFG?=
 =?utf-8?B?ckN0dnhMSC8zYk0vc2gxMlhzb09JbkNOVXo5S3hqODIwbmJTNFFtNlhOQldL?=
 =?utf-8?B?V3hCV09hdzZuQjkzc0JNNHJnVHBTQWNrRUFCdG4xamtSUW5jUjh3T3hZZkRF?=
 =?utf-8?B?bzhKM1Mzc1JSdWZDb0JjZGE0K1ZLRnhDakRHV2JONTFYVzY5ZzQ5ZFd5d2FF?=
 =?utf-8?B?dEorbDBmTXlZV2tKdHlvTU0wajhJUTRkOU0yZkZHeUx3VmZEM3BBUVcyRVNW?=
 =?utf-8?B?alc5Y2w1SjRZZjVIMjRsT3FoRXpKdWE0c3lyRUQ4RVVNVW13SEs2YmJTZi9Z?=
 =?utf-8?B?Tk5WSXF3WFBzVk1zT1BhRnhneHA4ZDZaMEE4VUJpUVRlSUhHaVhqMW1mM3lQ?=
 =?utf-8?B?YTlha2Z6eUdoTHIrTWJCbjVPUFBxT3ZOblhQYWRQTFB1T09QYU0yUFNycmJ2?=
 =?utf-8?B?eDdUWVZnR1ZQRUlsQTlGY2hQZnJHQVRWcGYzWmRTTFQ3YjREa0FpUFFkekhy?=
 =?utf-8?B?cWVGTlFlOXZrZzhFWlJrT0RjaGdKYnBDQUNJNDd2bzMzRlVuL0xKSGpKNVd5?=
 =?utf-8?B?U21NRGVhTWZENU9GbHBNNEtVV0Z4aE05eEFLRkZIenFLS0R1V2FPcEd2Qjc3?=
 =?utf-8?B?WVFkMjJCRTdWOVlVbE42T2VidUx0K2crL3EwZnNnOVA4MjhVV0g5QldVYWY3?=
 =?utf-8?B?VVVhaDYva3gwM1YzYU1lbFJCbE00TnYwNldhdjRiTkR2c2J4NkxLZCtTMkxy?=
 =?utf-8?B?amVwWmFBYmE2NmI5b0tmQnU2WGorYnJsZkd0cllydFZQZGc2U1d1bFhDRFRK?=
 =?utf-8?B?dGxUV2NxWFlqWml1c05CKzhBalk5MThhTEdwck41a1VHSU9xTDdmeWFSYWw1?=
 =?utf-8?B?Q3FuQlcxcitMNE9EQ0JOK2NxT2RpMXdpNjVJYmhtczYzMjYzQzhOakRQUTdT?=
 =?utf-8?B?a3ZCNDg5dFZCOXJWZzdvQWF6YS80SHNmaTNUZGxTenRkMVcwZlRmaGN0K0FU?=
 =?utf-8?B?VVQ2aml1aXA0eSsvN0x6eUYreDkwZmgyOXlvandWMHpuWkdpMEVBVnQ5K2JH?=
 =?utf-8?B?KzRvMUZwYm81dUIxanQ4M2xCd250RzdpSjJ5dlpXbUNlTDZnT05UL1crdHFH?=
 =?utf-8?B?eVZ2WjJDRTRCL1ErdjZEUWFvOXhoWmlCU1MrNFdPdlpWSkptOHdwZStCWGdh?=
 =?utf-8?B?NVE4akxrb2RKcjI3MnFpSUozdVc3YWZKZnpJZXVNakFvUXlibjFEYko1NXl3?=
 =?utf-8?B?SDN0WEhYNXN3NzVYTHV5Znl3WEh1LzYxakptQmxvMGh6c2tKNWd6K1pXWXJP?=
 =?utf-8?B?TzhMdmdlZStoOHBLT1dNYU43UTdoWWdBaHVGcUhvbkRlN1NGZlB1cW9aL0x4?=
 =?utf-8?B?Mk9idlZOMlloRjB2M1htSFN5SFBaN3dacVI1YnNwdGYzTCtkNnZpRllnTUpT?=
 =?utf-8?B?NGsvMkNrcmx4eVhpMEtxU2ZiYkpSZVRuckNGTDFSMzZuNzNicEFvaGtQOFRW?=
 =?utf-8?B?bmt1alpxOGhISUsxcGRqZXJqR3ZHbGhxMW03bDJnOUVLbmRna2NYUGdjWTBh?=
 =?utf-8?B?Sy9KamxQUzFwVFpsV2tGVHlVZVdjTThaMkdIWEgvRkZXV2pJOXpQTmNySXRk?=
 =?utf-8?B?TFZyb0JYWTRUcU5QRFRta1FWaHk0MlBvVFN2ejBtQjZxOCt1aVdwRE5aQjBY?=
 =?utf-8?B?SjhLbzk5VTgvRFhwcWxmY0dMOGQ1emh0QVJmaHpCRjNER295OUFkNEtESnNn?=
 =?utf-8?B?MHZDbCs5a001QjQrVklSNmE2U0N0bDgwMXJVTkE1bHArV0Q5dFQ3Rk16aWpz?=
 =?utf-8?Q?blNPzQo5vkEBdQWUJ1XSulc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfb70ec-3ea1-4e96-c662-08d9b8acdd34
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 11:38:03.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjxLxN0LMMx8rx9G9VOnBZegWFylSGNvMRV3eWLnV6hLnDamyGuqgjQgGPzIql+UDK3/0HM0b/RrolZBBR5yDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On 17/11/2021 16:23, Philipp Zabel wrote:
> On Fri, 2021-11-12 at 11:27 +0000, Jon Hunter wrote:
>> Commit c045ceb5a145 ("reset: tegra-bpmp: Handle errors in BPMP
>> response") fixed an issue in the Tegra BPMP error handling but has
>> exposed an issue in the Tegra194 HDA driver and now resetting the
>> Tegra194 HDA controller is failing. For now revert the commit
>> c045ceb5a145 ("reset: tegra-bpmp: Handle errors in BPMP response")
>> while a fix for the Tegra HDA driver is created.
>>
>> Fixes: c045ceb5a145 ("reset: tegra-bpmp: Handle errors in BPMP response")
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Thank you, applied to reset/fixes.


I see this has not been picked up yet for v5.16 and so I just wanted to 
check that you are planning to submit for v5.16.

Thanks!
Jon

-- 
nvpublic
