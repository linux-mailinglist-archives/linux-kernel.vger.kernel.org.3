Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3129473D73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhLNHLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:11:20 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:28028 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231272AbhLNHLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:11:20 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BE770n6032669;
        Tue, 14 Dec 2021 07:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=YbGj6ox5P+dtLh2PkMGLhhf2mUAXbukGh1yHmQjvDCQ=;
 b=aplj8I1ksUbA9k7gPIeDp+pkN5om5sgJzu52DXFue7HOcfDhsS+UydOmnL8FlkNhNDLe
 M81+8vqcLuqEUYpVoVdPDw5shn38ytkZokpGAeHnImJ7VdCe7n2uQjFIddcNX8QQ7g+M
 dhJ/tkL1Be8BmcGg909RcapKU2ufhcS/2zQ2MMhDUQvHNGGgeJM45MJ1hiGPR0whonL0
 RN0c0qVpTF08Hh5LVXpiGwHcL0C7KTBJsvGCtONh+p/L18JtB2E9tXCxEd/XCeLm7pjV
 fLau1gYjd4YU8ZCwiS7RWQr0K1E7cQMuP9P2kw+/lfqk18vVxI5ekwKQZNRdmhu/BJyc DA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cxhsgg529-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 07:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyXKaWzHHyCenhp37eawOwJaeHQ9xcEAcQWyWfLbyGlZyY9X2pGSr/WHYhNG8AdWFsmnkJ8e7dmqe4cHx/L7yakKKalSQX1xVpkKvNLC8PmvFt/yOECmxTPxR5jpLy6xsELOw2Y49TXwcEmX2pwpp4gsneQ7TKlde19k2yhiInTQGWMG13cNz65+wi/EjVJLBXbULxFvEUo/aVy8buEXQxdYeXM5gi/sX5AcMHy3XzpWlZEfVdBsudFdcx0bzGjglI6u1rS2LpAEGAZF410u6jQDxjbpkQK0sjTysQmVkkXZGxAaV38U3YqYcu8gmPTdHPOAomajocNXJ1m355Cvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbGj6ox5P+dtLh2PkMGLhhf2mUAXbukGh1yHmQjvDCQ=;
 b=TaEm9nQ5+MpibpJgzwYbncZg02/VXqLcVODcgLp7JlczkYmEBMY++F/Y0xjLEfkAvlf8lxS/SPwKxbAm4RsbWE4OSrmPJKW6MDF7+xuhR1OuX54htBGjrNa2aFoT/q5u987/UCsDShMTnl3rfu8oqqgkWfonx8zpmMWss2QZDHRcA0tYKWQo6kXkgMDufdBia8iZU+1APM44+aPaUeBenS+hGMcUekdiz0s+nLHYVrHOTPrxt4TCmc3FaOM/CDXeRi2DckLa7nigbDAu+O06bWsFMY8oy7klkwZRhA09ekm0flUPdo9XJ3u6O4Vdn3O7ulBS3zLyHHa81L/ypkhciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5110.namprd11.prod.outlook.com (2603:10b6:510:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 07:11:15 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6%9]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:11:14 +0000
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
 <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
 <2c9f2f34-9dab-4f1b-bc10-48212fb70335@windriver.com>
 <CAFA6WYPfjGqY6GJqLmrhU7CBjBTEYZzuCptHLJe2aEGUM_kOBA@mail.gmail.com>
From:   wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <3c130368-6933-55cf-eb05-431f326c5be8@windriver.com>
Date:   Tue, 14 Dec 2021 15:11:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAFA6WYPfjGqY6GJqLmrhU7CBjBTEYZzuCptHLJe2aEGUM_kOBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:202:16::21) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26091265-fe3f-4c45-6c8c-08d9bed0ea51
X-MS-TrafficTypeDiagnostic: PH0PR11MB5110:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB511050D0A8FE2375E2C4660295759@PH0PR11MB5110.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a69gnABOMIp4fEMg4+VQr4X4rQYr3q9ezGj/p6dyzfMoeY6TEnQSwEYcPM93MEJDfsSS7qa7eFzujLkfeE3FBR6Cd6affYaZjBk/fUG+5Q2KPT5TSPpsiBYePTQeLWTdKBgVW7EbONBEsari48m0tbSoedLkOV6MB8eZeb9uQY1LrrRD+fZ1HjtHm3mSvUqV5z+bBfmTAFNuO5r48DwUg8zdg9dhbD8GBXbhuFVOPZZcyeTnIeU5HTC2jm7a45c436/vk+woc6BYmnIiGZVWZgNfEiw9mj7jgT4FoAE2DzxCdU8kfJSXYVQjiiiG9AtUvYSRa7fbHAorjbpBhfkpghj2//iu4+zyBZsqevTlr74xtFFiZO5TYgecMbI+VyXSe8IpSef2gPbU3yokR0JMJ5QafHJnp8q7rI0kSJomdiqlSrEtOJs0s4df++7uIg95dBTQwT/jtzGL8Q8dB9H84M3GIzgglEHkbYcs8LIlkP35yoW0fPoC+5vAwwV4E2rH2httkePeIi6Pf8J/Jaj5RtvILpO4j+9z69Miom4PbmDqbBRdy+d8H0m9VXAePcvCbLYU9tWOEXWtWBNrhH2x1KFlilRfWIlE91wqvv/thikXB50Jv9v5S0fPSHToSQUG+GhC8fvk7tTr2S8CPd5L29ASbPxn3Zj9AnDVihNnArobUkSIrTQat9n/6UWM+AQI2RyHhx39umb2xOeDe3GdGvT+PKpwzwYvXAVWQdSe7IyEOTZ3cxW/xQ7vLAbj0PtHDm4+tU5f8wJpMaOiVFyxFtuQaaJDULWLFEBl3MCpw8RX7vhdWt9hEJJPpuidbupOnbC3pJD2uAhmk6d4p1d2t/UCX6UeGFk584iO1wp/3ekuqOvbz/PGDHJGMf1Sb2TzLan8o3ODKgZN8xAvGUM3cnRGlVAe52ucFuj5IOLFr0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(38350700002)(66476007)(38100700002)(4326008)(53546011)(54906003)(83380400001)(8936002)(26005)(52116002)(966005)(6512007)(8676002)(66556008)(66946007)(508600001)(6916009)(31686004)(5660300002)(31696002)(2906002)(316002)(6486002)(6666004)(86362001)(2616005)(36756003)(186003)(43062005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG5qZVdQM1lQUmN0K01CYkVmVWc4SlJaV2pRVWtRZEF4eVVzVTFJSDQ2eTdz?=
 =?utf-8?B?VDRCeG4rZHBpRFlBTndraTVGbmtMVTk5WWM0T20yTHJrVmpUV2xwNS9tL1Zh?=
 =?utf-8?B?ZU94cUQ3cmdyemdiV2EzR3lLdHhrNmxsYkxqOW82d2gvWDNUZ0drd1BPMDJL?=
 =?utf-8?B?MGZsRTk5bUswUlNkZTdVa1l6NmtWUm1DTU12dHNNMGdiUzBMQ2NmWitKTlFk?=
 =?utf-8?B?U21ISFFLaHkrR2FHOGM2WTVwbnk1aHhyY1VMZi9FQ1RqS2NaKy9DV1d0WEEw?=
 =?utf-8?B?ejBBY3loOUFtVGU3cXRZRENMSEJINlhSNW0zbHBXd3Q1QXpteVhCbjhjRXNB?=
 =?utf-8?B?VGNBVkJHRVVoU2VvVG9YeDlHUUFOT29rY2t4NDJHajcydXp0SGZoUUdseXdy?=
 =?utf-8?B?QzNvVHpNQU9OUGFiSy9obERRaXFJZ3hIYXNOZXMwNHhFbzRndGZrYWlBUW9F?=
 =?utf-8?B?VjRNNTNXdk1tdXAzSmpvWGw0N3VvRS9HVDNTY0xxMTRTUzhuNXF6NDFOYjBq?=
 =?utf-8?B?YmluNGVOL2twbDgxT05neUFRNHlnNXNhd3RwL2RxMkhXYUhqTkJycTRDNjVz?=
 =?utf-8?B?QngxTEtUUDFHSU50WUV4TUdQZElLd0dHYjlHR3BqVlhqL0J1VzFGWDJPRUE0?=
 =?utf-8?B?T3VmQ3JLYVZCMWRuTDFnTVpJRWhXK3hxMlRvUFdidlVtL3I2eEh4RTVoaTMy?=
 =?utf-8?B?S1V4SVMxOFZmc2RsYjhIUE1hV0kyY1FZSC9peWFYUEExNDJ2cVdURUNWVmxK?=
 =?utf-8?B?aEZRVmJMZEtWSktwYjR2YjBINTVOb0JmRFBkb3EvOWpXNk1CWEFmYUxqUUlS?=
 =?utf-8?B?eFdvYnpWWnFYQU13eDA0ZHRpYnR2VUxTcXdHeTlRT2grWnpxNFZSV0dpRGlY?=
 =?utf-8?B?SDBPOTd1TStRcTk2V080emk2akcrZ21PdmJYODdYV1ViTGowNk5XWlAxekUw?=
 =?utf-8?B?RTgwYUtQcmxSamJjVEZvWFRnZmx6VWVHTkR6UVk1eE1DMmVITGNodnowdzFp?=
 =?utf-8?B?TEdqOUliQXZqckVIS0lFMWRDRkcrQlVUcHJGTjluMUV5OGNiKzFMaWduNlVu?=
 =?utf-8?B?TUtLR3NYSU1MOElTMk5pKzN3U0JuWWU3L0VkdG5NemcxSGhpZmlNTGVxUHAw?=
 =?utf-8?B?VUQ4ZE12bkFKVXRrTURYYVVuV1R2ZXM0dUdWd05FUnhrWnBjRlkyRGdUd1hp?=
 =?utf-8?B?d3FhRWduaGFEb0FKd3RVYllnaTNLZ3M0R0dsWk1TNm1aOWZZQ3lqVW9oSGxk?=
 =?utf-8?B?N25Vd1ZkUkN6WUlEc2NDMHlrVDNBVzJuc3hJZms3SDNZWVhTd1JFcGl0b3c0?=
 =?utf-8?B?emFJOGEwMExmeFFUL0tzZEo0ei8xc0R4VklOV05JbGR2SkFjK0V0SjZNSWZO?=
 =?utf-8?B?YW1JQ2pZNXRBRXdOQWFhRGhML3pDcllsV244K1paY2ROcDZBbXhRRWRDS0cr?=
 =?utf-8?B?dDhxVFpmZlJ3aE5NZ0NvQUJ5NnoyZVByNzRWTDBTQkNlWlpWWDlTSjhpeXI1?=
 =?utf-8?B?RjVYTC9yekxpVlBOWWJzbkxJOHhjSldDTXBBMGtTQWhHZXg5bFVWV3YrNklQ?=
 =?utf-8?B?ZWtjNzlGSFhDYkNkWFREVnh5RUFQTzZ3QkwrOUNmbzIrbWNiVG9xR1dZQ0V5?=
 =?utf-8?B?VElmUHlZOXNWekpuRVpyTGsxMUVpTEx3a2xTZmMxMDVJK3BMcVBVNjNOL2V1?=
 =?utf-8?B?U2l6c2djcG5JcHVPNi9Kd28xQTBteGc3LzFCdTRMdzRMM2hHcllJT05idlRh?=
 =?utf-8?B?RURaYlNWN0hDbmdrUjA4Q2ZhRDBUZ3lPc08rYW1DZTQxWE9FcTJNK0NSYmFN?=
 =?utf-8?B?RGxJUmQ1elBPaHBtMUlRNDNMK1RHN0ViWXppYmZNVWlkajVBWEJtakUxb2dE?=
 =?utf-8?B?WFV5R3pzY1Nldkd2TXJCSDZZc0tSRVdBU3FTbjVQU1RWc0lVMWhBU3FFR3NX?=
 =?utf-8?B?UTZTWXViUTRhZHMvWHlxSXFHUDU3VnV5TGJJdVQzRXZkYmpkSmxMRE8yczdl?=
 =?utf-8?B?aXNxQXN6cjI5SGpWT25sNkE1RlEvKy9lOVdNYUt5dWNpdVAveHdVelYxTU8z?=
 =?utf-8?B?NGZ5UFpzOW1IMGdBYjAzZGwvMzJhTkpsNHhSTFp1ODJPeDdWeXhwRzYwUkdC?=
 =?utf-8?B?OWxoUWlaci9Hbi8yVUhOZE9zanI2YXYxbmpwMHYxTzdTMHJpeThUK3MrY1VS?=
 =?utf-8?B?RUlvK0t6Vnl5NmQ0YzBoZThQWnRiNjVFMFQ3VHJLaFZ1WmliSzRNSVBVdW5j?=
 =?utf-8?B?RE5nSFdrV29OY2k5RWs0di9pc1hBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26091265-fe3f-4c45-6c8c-08d9bed0ea51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 07:11:14.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqMe6aAw0lqzn9AeJJQ0/A00qFgcULIcDy7bOsfXyX7k60uL4RkxvzRDt4ZUCh7GDjlVgiumD7zrnDBLHoqzP+Cv5IrP1F9rnc+cw/O1rao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5110
X-Proofpoint-GUID: xfYnns3Znh3RgZL6On9FpX7r4s-DxPM7
X-Proofpoint-ORIG-GUID: xfYnns3Znh3RgZL6On9FpX7r4s-DxPM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_02,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/21 5:04 PM, Sumit Garg wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Mon, 13 Dec 2021 at 14:25, wangxiaolei <xiaolei.wang@windriver.com> wrote:
>>
>> On 12/10/21 5:38 PM, Sumit Garg wrote:
>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>
>>> On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
>>>> +CC Jens, Etienne
>>>>
>>>> On 12/10/21 06:00, Sumit Garg wrote:
>>>>> On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
>>>>>> -----Original Message-----
>>>>>> From: Sumit Garg <sumit.garg@linaro.org>
>>>>>> Sent: Thursday, December 9, 2021 7:41 PM
>>>>>> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
>>>>>> Cc: jens.wiklander@linaro.org; op-tee@lists.trustedfirmware.org; linux-kernel@vger.kernel.org
>>>>>> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
>>>>>>
>>>>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>>>>
>>>>>> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>>>>>>> We observed the following kmemleak report:
>>>>>>> unreferenced object 0xffff000007904500 (size 128):
>>>>>>>     comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
>>>>>>>     hex dump (first 32 bytes):
>>>>>>>       00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
>>>>>>>       60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
>>>>>>>     backtrace:
>>>>>>>       [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
>>>>>>>       [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
>>>>>>>       [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
>>>>>>>       [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
>>>>>>>       [<00000000c35884da>] optee_open_session+0x128/0x1ec
>>>>>>>       [<000000001748f2ff>] tee_client_open_session+0x28/0x40
>>>>>>>       [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
>>>>>>>       [<000000003df18bf1>] optee_probe+0x674/0x6cc
>>>>>>>       [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
>>>>>>>       [<000000000c51ce7d>] really_probe+0xe4/0x4d0
>>>>>>>       [<000000002f04c865>] driver_probe_device+0x58/0xc0
>>>>>>>       [<00000000b485397d>] device_driver_attach+0xc0/0xd0
>>>>>>>       [<00000000c835f0df>] __driver_attach+0x84/0x124
>>>>>>>       [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
>>>>>>>       [<000000001735e8a8>] driver_attach+0x24/0x30
>>>>>>>       [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
>>>>>>>
>>>>>>> This is not a memory leak because we pass the share memory pointer to
>>>>>>> secure world and would get it from secure world before releasing it.
>>>>>>> How about if it's actually a memory leak caused by the secure world?
>>>>>>> An example being secure world just allocates kernel memory via OPTEE_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
>>>>>>> IMO, we need to cross-check optee-os if it's responsible for leaking kernel memory.
>>>>>> Hi sumit,
>>>>>>
>>>>>> You mean we need to check whether there is a real memleak,
>>>>>> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_ALLOC and until the end, there is no free
>>>>>> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, wo need to judge whether it is caused by secure os?
>>>>> Yes. AFAICT, optee-os should allocate shared memory to communicate
>>>>> with tee-supplicant. So once the communication is done, the underlying
>>>>> shared memory should be freed. I can't think of any scenario where
>>>>> optee-os should keep hold-off shared memory indefinitely.
>>>> I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
>>>> the config file [1] and the commit which introduced this config [2].
>>> Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
>>> RPC shared memory remains allocated. I guess that is done primarily
>>> for performance reasons.
>>>
>>> But still it doesn't feel appropriate that we term all RPC shm
>>> allocations as not leaking memory as we might miss obvious ones.
>>>
>>> Xiaolei,
>>>
>>> Can you once test with CFG_PREALLOC_RPC_CACHE=n while compiling
>>> optee-os and see if the observed memory leak disappears or not?
>>>
>>> -Sumit
>> Hi sumit
>>
>>
>> The version I am using has not increased the CFG_PREALLOC_RPC_CACHE
>>
>> switch, I checked out to the latest version, but because of the need for
>>
>> additional patches for the imx8 platform, I still have no way to test the
>>
>> CFG_PREALLOC_RPC_CACHE=n situation
>>
> Can you just try to backport this [1] patch to your imx8 optee-os tree and test?
>
> [1] https://github.com/OP-TEE/optee_os/commit/8887663248ad

Hi sumit

I upgraded optee-os from version 3.2.0 to 3.13.0, and the kernel did not 
detect this problem.

I have not set CFG_PREALLOC_RPC_CACHE to n. This should be a problem 
that occurs when compatible

with lower versions.


thanks

xiaolei

>
> -Sumit
>
>> thanks
>>
>> xiaolei
>>
>>>> [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
>>>> [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
>>>>
>>>> --
>>>> Jerome
