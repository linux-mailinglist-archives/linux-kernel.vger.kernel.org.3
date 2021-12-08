Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FBD46D4FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhLHOHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:07:10 -0500
Received: from mail-sgaapc01on2131.outbound.protection.outlook.com ([40.107.215.131]:61952
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234558AbhLHOHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:07:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0RhKSIOY3jyDhVXH/nw+P4ubQ/hAHymchiQLifAcaa2X6fP1OthN6NQmGzG5iLBNkSyKCOVAgOLA9l4WvypUuaSrOxGHI1BRYAGHBuK2043nnCboj9p/c7Te/ImXPGyZZyDZWlylMaygdd+MU6rEqaEOc/b7q+g4SGCG1Z3T3FI5Dx+Alb4fckYZ/pZ1YWXEIO2dncaDIq2SsqtlyGLurmAcYv3AFGdfsu/CEN8okeikOB5h/o9wM3JNntnVSx+rJdI7Sn4XTRPjLYIUSdZiMrsyg8Q8RuPjlFMcaHF9edj3Aj2OEx/OnGinTWHK+VWBRrGMNpeqDpCxpVxFrQyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QACqvXK35GRapg/0GlE17KHkC7RdKAoUCwoHF6Lul5o=;
 b=Y/gGUGhL+Rw0HCuEUzKY9iHDZoRAaq1BS7GWPwK9c2ji9xO5IaGP+S4LzRxEL/2UqTsrb5bP3tRU/B+iYJbzNOFJBoXHfUDBvvY6adUKr2UXlhV11jVX2Wb79Hqi0bY6tyI5uba2OAssd5cn9ebNsNIwl/wkYqLelKS74V1/k6mRO6rdYAkQEOGhm1Bu6XAa48Qyw2L2JAQe989oXpRkWrHqwMC0Xsf/nuFSea7iqfJ9T2ie9seXHT9K5gZSNWu60M/q6tkGMQXgF/Gz3t+6N0ok5SJSIfox++gk01J0ZRNjjMWtXEAuBgDTcXWBQUDG3p6nI6o1drWjGzWsuOZnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QACqvXK35GRapg/0GlE17KHkC7RdKAoUCwoHF6Lul5o=;
 b=DVx6nO4VlpHGnqEqIhg5yUrr34oC833wNJu7/lBzyOvEthLLlvBCGDBaoXiPxvRUNFsW3mpNtt02FaVVniSKuheAMEe8OjBLGmcjEw6CYayaOOPQRLnlGhjtWNXVv8cZyTMzssKclTPMNCYaG9P/eoox69MFIBps6kX3gcJ3oyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB2462.apcprd06.prod.outlook.com (2603:1096:404:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Wed, 8 Dec
 2021 14:03:34 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092%8]) with mapi id 15.20.4755.023; Wed, 8 Dec 2021
 14:03:34 +0000
Message-ID: <a0f8b64e-7086-b23a-acc6-dd3255d33fc7@vivo.com>
Date:   Wed, 8 Dec 2021 22:03:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] bus: mhi: core: replace snprintf with sysfs_emit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Carl Yin <carl.yin@quectel.com>,
        Carl Huang <cjhuang@codeaurora.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
References: <20211208080816.43351-1-hanyihao@vivo.com>
 <AJgA9gCdE-A6eTTRwvPvy4qL.9.1638951289781.Hmail.hanyihao@vivo.com.@PFliQnBjSkxVUVVZSHlnR01Aa3JvYWguY29tPg==>
From:   Yihao Han <hanyihao@vivo.com>
In-Reply-To: <AJgA9gCdE-A6eTTRwvPvy4qL.9.1638951289781.Hmail.hanyihao@vivo.com.@PFliQnBjSkxVUVVZSHlnR01Aa3JvYWguY29tPg==>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from [172.22.218.34] (218.213.202.189) by HK2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:202:2e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend Transport; Wed, 8 Dec 2021 14:03:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d10e652-15cc-44e8-4a66-08d9ba5385fa
X-MS-TrafficTypeDiagnostic: TY2PR06MB2462:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB2462A0CEDB1929C4C451A0A1A26F9@TY2PR06MB2462.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiGXdRPfuX0mYpID/6n9kXzLKcxlvF6CRQwDues+fCT7xVsFH0mGUBXB/YxlerOSmtXUR6htCKsBuA41dnThkUlFldbxS8Hh7BjXAs1YG7w9FSU0yLlxaif3Hv2HNisEG9uM9R4y3vb6lVY10L+QSrFjdTV5p6EUrR7ru/DxUAtg+LlFNX4Q0zAHG1tHWtC3Cv7LhawahGez/RIFYQQEhESCj7dARRCeyNmEKk7ovbZ8saKg3b5RltfYYf577VzT9FiEwXP94ZEvOr+VfXXK37s2A+CG2phICqgvYmq43BLonuqFgTmluVOkdUSl/K4lQYUc/VwuLTN+eQTRmK1LVp99oaH/VQgNIh8cN0I1jsaNt2uODg/QPklj3SJSvR+d67/isGhspgWCI3qUKtS671E6Oyoadew8U9ff2GO8WTCDZ6HGtXi+e3vVqVppLYyLGv/jGDGXdnNZpzAP9unt0a9awpu9t5eL9qqEhvH4RaUB91FYopQs+KD3wIhUa5FOiSev33vAr/PCet03MUCOO9NEM03G55+EgtqVLoecdU5YudhXEEfPsGzcwmoJ7gf48I7VO3WJ9V0gB+o9058oWFyBFvGZBz5xTCgwhmqi0AChdLP8FN6DiAH3z7LDe37M7/ILh1dny5PcpZ07VMzWFBKUDBae23WNgkNo3VrbCZL94QQKlEi/0Bpis2PYTFlLZqaWTpTkIrBcRxmbWG4Zz0uBl0BgTm6SdK68ltnIAHrRXDA5tA6LCvALkxBV23aVcMmAHZiTHGUC6Ly/Q3DuAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(186003)(508600001)(107886003)(83380400001)(4326008)(26005)(16576012)(86362001)(6486002)(7416002)(316002)(54906003)(5660300002)(6916009)(38350700002)(8936002)(36756003)(2616005)(8676002)(38100700002)(956004)(66946007)(52116002)(2906002)(66556008)(31696002)(31686004)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0VmWTZsQzdwa25KWmgyMllpOTViNW1jQWxKQWVsbWJVNENiMmk0bUkwRll1?=
 =?utf-8?B?NDZ0U1NHRU5IR3VJMXFscjZONjd3S3hwcmYyMzRta2JnZXZsclFiNUpNVnVL?=
 =?utf-8?B?VHdXcUl6MHQycDF3Mjk1UHIyZVU0Vk5uY3I3UTdzZnYzQUlWaW1zMnJDeGs5?=
 =?utf-8?B?YmxEY3c2NFRxZWJwUjlxTlhYYU9ybTUxNjc2RDFwNWdzVXdnUU50NmM4VHhr?=
 =?utf-8?B?WkVPOS8vUGdvRklPVGQwVW5qS2l3eFVIbHJIWmJhNE5VcUp0SkpLZXpuNDZQ?=
 =?utf-8?B?UzRrd1BLVDl2dGFHNTBrZ2V3WGtyMjlWejFiUUNUNUxwVkVWYytEdHZ6ZTZ5?=
 =?utf-8?B?NENoSEpDSExVWjRDWE90RVFkQ3JLYVUrYVEzcnRmODZyTklzdTNpTE5HYURm?=
 =?utf-8?B?bXExcnRhZWRqMGVXVjlCQjRjNlhvWVJqWjhYUGRJRFhicWo5TkdEVCtBblc5?=
 =?utf-8?B?MFprSEJMMGZNdnkxNXJNVkI2K1V2T2JhVzZSVjVzWlJuZHY1NTFFdTE1MFJT?=
 =?utf-8?B?RDZZZ2d1aVFLVC81YUtpTmUzTTJpaHl1MkdiR1UzTVNreHhnOXRzejRUODZv?=
 =?utf-8?B?bWQ2RG1ZcXpTZ0FuamZOcHB0bktTTkNDUmNBUkY2NlI5S3dodVhQM0VncmdT?=
 =?utf-8?B?NUorYmNjRHppMC8yaGtXQWlSOW5UYVJCd1p0WXRIb3V6dkhYUDNTWWpPWklT?=
 =?utf-8?B?LzVoM1UyaVVIZkhLT1UxdkF3dW5ZUHQzZE45cGxocEVLQkF4aU0vdEpMOTd5?=
 =?utf-8?B?WXZnMTQ0b1pyOHNMR2o3RUN4ZXNUb25NYytmL1RSZ2swN3hFckIvcVE3M3hm?=
 =?utf-8?B?eWFaTHNZZ2V3bTN2cTAyUnhrUmxpOHZBTXVYaGZISnJId1laMGpMUGJDTnlN?=
 =?utf-8?B?S2sxcFhmdE02emtkcFBaQmZoVjZHeHNnOHlNNW8rL3BIdEx4Ny9qdi9Xblpv?=
 =?utf-8?B?K2gvZ3F1REJxSGF2b2ExeVN0MXZDOUh5OUxTVERxd0lJS0t1bnJ3eXVuN0dO?=
 =?utf-8?B?RmU5eVBNNjNQMlErTFJmdkNSMnJQWkI2b2dibFNnWmtaZnBIUjQvQTNocFNC?=
 =?utf-8?B?WG44T0FlekF2cEJYOGhCcnR3QVlCaDhEVFUrdFZPdG1oMi92cW05N0VWL25W?=
 =?utf-8?B?WXRXTjhYQUVyR3I0V0wrWFpVSkJYbCs3UUJKYk85NlBvcVI0L3VKb2ZMNzNz?=
 =?utf-8?B?K0dCSDFLVWNmRVdJYkozYUpjYmlKV1FtN2x5bUdpeGZqd2RpZis2Vkwwc2RG?=
 =?utf-8?B?NUpXMk0xaEdMWTlQNW5RcW80U3NRbUdlR0VtQ0tUZndkUzc5b0t2TFBUVzBr?=
 =?utf-8?B?Z3kyb3hKTmNBZ3E4WW5EVVJOT09XcTlhZGVRZllEMENmU1pFZGlMSjdlSkho?=
 =?utf-8?B?T3h6cUI4R01jS1k5eEtLZFJYUDRDRGNwR3pJM3JtZk96WllxekEybVRwYWpQ?=
 =?utf-8?B?NGJMZEdFc2dvRmhHc3ZiRTBtMjVxdVZ1SjRLZHJLVUN5WDZoQkQrNkhvaU5x?=
 =?utf-8?B?UlhmeDIwU293bnJpQTJKdDN3WS9QYkRSaCtxNHgvMUlaeFBRZWhaTTJQaW44?=
 =?utf-8?B?V3VFZ3daYlF2K1Q1dHkxdFBFa1RRTXB4MFByL2twUUVOVDRsZXBRZXFUUTdZ?=
 =?utf-8?B?eXpDWDlpSGxRUVhGa3FBRUFnMjRZbUVFK1lWVVhyTXFjU1NBNS8vdzdxTXkz?=
 =?utf-8?B?OS9pd2p1aGRJK0xKQVhPM2xtWnhmSStXMkhXWEZVcWNXNExZWURwN2Q3ZDlI?=
 =?utf-8?B?MFpBM1JvZlZJTWl5VVdJUjZGTS90eS9tSjI5UDEvQlVWZ2xpZGVtRDF5MlVm?=
 =?utf-8?B?bHY4MXJaVzhPQTBoT3pRSXdQTk5yNlZtOTZZWllhVlZ2ZWV3eXhQOFN1cGdG?=
 =?utf-8?B?RXFkSmdDKzNVWE1wTXlobXdMa29VbW90dlgzTVQxNkwyUnZkbEhjMjdHZzNE?=
 =?utf-8?B?QWV6Ykd5OUF3WE9yK2lFa1AwWUJVSlBkM1pXeDE2Uzk0ZzZrTXlucWdpYnZT?=
 =?utf-8?B?Yk1KVXYxUGtOVTN3M0ozSmE3V01OTUpvbDRWVy91NW9HS08xQ2Y5clRLTlFt?=
 =?utf-8?B?aW5EVW4rekgyNERUamc0R09remVNZDJaYS9PTnk4M2lUQXlhNndmb205dWR4?=
 =?utf-8?B?dktMUUx6MW83RzN1S1JEdTZyTHlTYXJGblpZQ2gzSm9ubnBqdS9KMk9EK2I0?=
 =?utf-8?Q?kY5T9TMgz96E4/PwzoIh+5o=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d10e652-15cc-44e8-4a66-08d9ba5385fa
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 14:03:34.3774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6hl6Nn2f/v4iIJP+xtw/iPsCUqJXXAAMAEJi/s5hjvQQyQ8vgcxKqH03vnI7Y7JBTR14YakaqPMQ4tAH0R8uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2462
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/8 16:14, Greg Kroah-Hartman wrote:
> On Wed, Dec 08, 2021 at 12:07:53AM -0800, Yihao Han wrote:
>> coccinelle report:
>> ./drivers/bus/mhi/core/init.c:97:8-16:
>> WARNING: use scnprintf or sprintf
>> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>>
>> Signed-off-by: Yihao Han <hanyihao@vivo.com>
>> ---
>>   drivers/bus/mhi/core/init.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
>> index 5aaca6d0f52b..a5a5c722731e 100644
>> --- a/drivers/bus/mhi/core/init.c
>> +++ b/drivers/bus/mhi/core/init.c
>> @@ -94,7 +94,7 @@ static ssize_t serial_number_show(struct device *dev,
>>   	struct mhi_device *mhi_dev = to_mhi_device(dev);
>>   	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
>>   
>> -	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
>> +	return sysfs_emit(buf, "Serial Number: %u\n",
>>   			mhi_cntrl->serial_number);
>>   }
>>   static DEVICE_ATTR_RO(serial_number);
>> -- 
>> 2.17.1
>>
> 
> Why are you only changing one function in this file?  If you realyl want
> to make a change like this, fix ALL sysfs show functions.
> 
> thanks,
> 
> greg k-h
Because "sysfs_emit()" is "scnprintf()" equivalent with "size" parameter 
equals to PAGE_SIZE,So sysfs_emit can only be used here in this file. 
And "scnprintf" is better than "snprintf" because the former returns 
number of characters written to "buf". So I think we can use 
"sysfs_emit()" instead of "snprintf()".

Thanks,
Yihao
