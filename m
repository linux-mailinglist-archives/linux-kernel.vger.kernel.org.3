Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3182149630C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378788AbiAUQmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:42:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52812 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351500AbiAUQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:42:08 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LGMawd005573;
        Fri, 21 Jan 2022 16:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IPUIySZWxvr0uUhJHNHki+lVcmTMPsUwyncZCFVXvPE=;
 b=YiTNwoLCUsk2KWXzQicLvR55cufAlMdo7N0DPISqY2xy7/39alZXQwe6ZyxjsqKx6eon
 zY43b1cSqlVs6Q6D56LFtUT5GIVFl3R6e4PsfJQWUP/UmZgt5X7H8oy83UFTNY2BEW87
 vOqvNN2rr9Pzn5rzhCvkNBJGoSf7p2rLNcMYybb5YQ0wUMqcvxuTA2e0w9eEGh6sDsml
 uQEpEmOL3txkA54/5BS9vZeEbRYVMhHhrU9bmGbXHV+Ckw9sWco0iuZyBThCW0b/siPS
 3wT+Jv30GFdUpRMs93MYWBUx0lKkDLW5k5PSpX6D68iT0GbvYfYzaBfpD+PDHmKuqLMX tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhy9swq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 16:41:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LGKiXX085491;
        Fri, 21 Jan 2022 16:41:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3dqj0w5wua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 16:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6bichvqGduMVwzlFIAFXQ3yxGRzns88cqO7rplgbqf5/+/9iRgn3ojmsefQx+cv2yfI8Q7UfeZnotzPrHAuMlUqqnrlKFNBHcoM+HaX8cHyGdYHSO2HA6KJvj0hpPGIu8PHNyp4VktSpaQhbtYeoxKu4UHptQzyUwKq/ytEXdxt85PezBO1MYlhx/V4OlpSWP/4+weCRdLC5l4J3Kdm0OLnNjtEhggSxriPMYZU1gLsyavHTya9KhRkW3ySA6tAITLKyO1Cknhakhi+rTSdkM018yEChlsX58gbpzLbo7q88QtjIZ9P+Cr+vjx4StOaWWZZ5t3jTfOyvtIIPK7g4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPUIySZWxvr0uUhJHNHki+lVcmTMPsUwyncZCFVXvPE=;
 b=kiEoLa8aIM2KOi4VEHEZPE0Deq8T5+e30MndCJOFrdWCMIQYewqRSsPJL3VB6a7QHLqFQgRvuDNe78aMPpMwAW8+o7G1RyzhT9Ijcv3LH/qe76l3mz6krwrM8cBLiExzxmI0uamWNWowoBgl92WMYg4wgZ+weP+TpSOjZQp1cKgOckJrOoey4Hevo0geIzGj4jG8O5qxF4ttrAc1kcmFcLSdeAsbf0kLsbqfNaDEzmMrXO3t9qyNPAkPrm+j/DTOf7mpJPAJHBrjDksd79vuds613B+MjkyMUiDWWb0oKxHTflaT/vrFU1raHq//cJzPJRKl8t05bcB6yvcFTQxxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPUIySZWxvr0uUhJHNHki+lVcmTMPsUwyncZCFVXvPE=;
 b=YhPELdC5H/ZB7WTchSxvyCL5uGTl1PXGt8lphKnbwSnU1ybtSNyyeKg8b0w9hQvcAAffLgyIk4jKpAE7p8pS0fAeQxH7Zju5wgXdcDipJu2kjEv7LtI96MGu/CBBZfgBAmPzreLazSY/O2cJDMW/e7hTyASjDx14uLyyqDuaPEI=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BN7PR10MB2740.namprd10.prod.outlook.com (2603:10b6:406:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 16:41:43 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%7]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 16:41:43 +0000
Message-ID: <0ec88ae7-9740-835d-1f07-60bd57081fcd@oracle.com>
Date:   Fri, 21 Jan 2022 09:41:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220121010806.5607-1-21cnbao@gmail.com>
 <YeoW4CMiU8qbRFST@casper.infradead.org>
 <CAGsJ_4wv144TUSQPNOnHnmNmJrXe4Fn8d14JeAJ5ka-S+dRxRA@mail.gmail.com>
 <YerHceldiYXLk2DE@casper.infradead.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <YerHceldiYXLk2DE@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:806:a7::20) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8267221-8209-4f85-e870-08d9dcfce7e3
X-MS-TrafficTypeDiagnostic: BN7PR10MB2740:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB274086EBBDBB319D8028B3C8865B9@BN7PR10MB2740.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RVF0sVgvM92VEZnlcmAezKAcGCCWrHmhfgLKNXgzfyAQEjiQA7wJVmtliiObYhIyxpTBcDkMW0fmO9pd/lJP0OvgmgKXzjHy520Iy52M5YaeGCiJYB3U7D6kPs+heMpQZfzItz1TsIfKXWE+RmFq21qLrpmju5d6CYRHG/Mitsn8Y37hGH6uXkvSVrctpP9gf5YpNApQwq/ReShBEZBShuB4xwLJO4sw25eMYE8RYzp03jf1s5ZiDVO3dEXB3XuHo8oiwHqPv0zYNNJVNR763rLmArlwHqY5mXlOuIhDhxavZYjVEt/O6dGUB7tcnBvCRMUmVA1ndZTtxbvQtSZaXwLWnxRZcCwLuyZvPCEmshm/qjvIcz2K8nV7IhD18xyH2M0aVo9yEMACxtvXlPcrxZT9fb/z8F3YspoUwqhgNlLheMQMwJYUMiB7dImKgr5IAjEc4eVP8I1E1JIL3pn2fked1br3/qPAB1EOqQwV+CFrE0T8UtyT+9YxPLzF4IFnIOu2UFpd8uksJACf6kuzkKn2xv2dXd7I7vpZyVkOHo/4uhp/EYTUNU+T38lKukaOWe0ciMLyczhmAFv+mW+6Z3OWnksvpw5IMn6w9mCytgg7wKlyY3Ci9Eiyo2nSwSseH0DYDcA4n1BFYlz6GGjRVVItCuYJKdJNFYsy6apjseJo2h5TaRNbT80fYyQhfynnU90hhCeWE2jJK4tbH46tW+m72MsJRQWdWXM7D0yPZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(6486002)(66476007)(54906003)(5660300002)(508600001)(66556008)(83380400001)(86362001)(2906002)(6666004)(44832011)(31696002)(6506007)(31686004)(53546011)(110136005)(316002)(186003)(7416002)(6512007)(8676002)(4326008)(36756003)(66946007)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNOSXN5UFRBYTBXb0hGcDN3OS9iMkRteWVUZmNnMXpRNFAwT05PRklNTitr?=
 =?utf-8?B?cm9hN1pWWnkrM1FXSXZlTDd3NVpzOHl1OTAwT2lRTTAvcitYRnRQdldhMUM2?=
 =?utf-8?B?eHlPQ01kMmNQaVo3VVJVRDBHZ2lzTTRGK3Y0OENhMXR6UjJJQWxlMHBhdlJ0?=
 =?utf-8?B?cGRVa3hpYnNZR016eS9raGI3VjlLQWMzeWNLL01Vd2M0U3ViZ091bFhqZlJ4?=
 =?utf-8?B?ZmNBUnlybEljd29CbEZ6MS8wUHBxeDRUKzZlRkhVbUhaM2RUdEpXOGFabjhu?=
 =?utf-8?B?N282QVR4TU1WbjFOREpDTWcxYlRSLy8wMjlINklaYWZlb0Z4bUhxWDR1bE5C?=
 =?utf-8?B?YjFtL1VVZzJOSDFZL2FsTXBOeEphZldhamdDdXZtTHExWTNPUkJiY2FhWU8w?=
 =?utf-8?B?ZWJqd1BXSXFEVnltNzJOMkNkZUZpdEpSMzJIZXR3ZzlhRzZXcTJRNTJzT2Fa?=
 =?utf-8?B?azZRRHhOaFJncUFGd2d3V2pLbjJWcndIczByK0lCanFESzROYmFmOVhoUEgw?=
 =?utf-8?B?VFJTb2h4ZWd5ajJSdkc4QXlBQXo1OVNsL1NCTm4ySTBRTHRGTGt3MEZCa2N1?=
 =?utf-8?B?elNGU0h5NnR5eWhiMktFcHg5bVJrTTNrRUpGLzNlaHE5cGxaMGttcGJuZk1y?=
 =?utf-8?B?dDV0b3YrdHJSazFNcm9ZMXJieG1GZnZYUHJiS3QzTVRWYjM4QTZlUmMwMlE0?=
 =?utf-8?B?QUFvYytqaW8rMnZPOXhjMHRzVzhiVTVEdzJ6RUdEdUpidmV6MHBTSStnU0g4?=
 =?utf-8?B?ZjlOMXIvYitiNXRySmlFdG1pNXI1QkN1cDltVkt1TzRSQXkzRUw4YkVHQlZR?=
 =?utf-8?B?ckhYTWlsK0x3a1VXREpUWkVkSEJTdWZOSUJZeWQ4N1ZtTERzZldCR3hvMkdE?=
 =?utf-8?B?U1JXbnZncWg4aXcwcHVLM05IZmJtRmlhMkZoRkpTRWY2RENoWStsa3pDTlhj?=
 =?utf-8?B?NmhVb1JIR29jOFFlZm01cGRoazVUWDhXVy9mZ2FjSXh1UThJV05EYUFyREFn?=
 =?utf-8?B?bG5JZjA4bUR0SkVOcThNMjZmaFhVYndzNmdleEZBdUJrNzFXaVpzOElKbitK?=
 =?utf-8?B?SlNib0pwVXRFVEFRUWZCV0t5M1YrTGc3c3FhL3Y5QXl3SG9hcTNhaG5kVSsx?=
 =?utf-8?B?aHl5Y04xL3BnUzNIRHljUzQ5TWlUUUEwaVkxV2E0dWcwclB3NWFzTnM4allo?=
 =?utf-8?B?aW1OYnRkQ2dhT0pTaC85dUpicWFQRUVxd2lRMGxWbTBTcHo2cUUwSmg1Vm9h?=
 =?utf-8?B?cUFWeFNnbjV1dTFHOTllTWVKeFlxYlEvR2RzdndIS0RmRFlDbmNkckdNSGk0?=
 =?utf-8?B?dFJPYmpEWWQrblBFSmxUMHI0aXdVTkZxQXltMGJPWFMrNzdJQmpKeGhqbHl4?=
 =?utf-8?B?VTh6aUdySDFNTVlwV3NkSnVZNzVyR0VjR0lPNFJyVWVrY1BxM2hwcjIrT1Nj?=
 =?utf-8?B?NTYvU3JlM0xqN1Q4U3dEK0V4clBpRGNkTGttMFIreG85RElkTGFLYnFiWUcw?=
 =?utf-8?B?Ulh3dUpzUjJVOTA3dkFBTUhvanU4eElKYXo3WVhVN3ZCU25leUlBY0xoeXh1?=
 =?utf-8?B?U3NQeXpKOExoVnpzY3dQSEJSa2FodlRxbkRma2x5SXErN1FHdlltd3NtckI3?=
 =?utf-8?B?KzI1eDlrMnZtS21MS054cEFlV0Q1QTBDbWhpVW1HMUtlckVrS2d6MUN6WCtK?=
 =?utf-8?B?MmFpWVJyZ0tjaHlDbEdIOFErY3prRTlZdzBZa0prR0RhV0JrUzFVclpPekNk?=
 =?utf-8?B?SmlwMXdkNjVHSERGMHYzSTVnbWV1TWg4OWFRNzc2MndpaCs1UW1tMWFreG1N?=
 =?utf-8?B?d0toRlZCUnBqaFJtWmFOTURubXJTeFZ6UWUwQUs2V0lvQnFjcHJIVUhuUjI5?=
 =?utf-8?B?VUh5UUp5Ry9ueDcrRWtLcGhTS3M0VzF2UW9CZ2ZYQU43blNNVnNyT0VjaVZU?=
 =?utf-8?B?WFVkMU1hMlRidGVsK1cydUEwQUVlY2lML0JlS2gwT08vRW5ZY0FsQ2xoTlh5?=
 =?utf-8?B?WldEVEQrT2tVbTJWMEZrZFRiUk1JM3ozVWdBQThPRGFhRmkyM3BkdnVnRGFW?=
 =?utf-8?B?dytaMzIxdWJUdG02ZUVUaTF3RGVVQjBkYXl6YXpDZG5WUi82TDVNZFFXaUpV?=
 =?utf-8?B?cG5jSmpzQnV0MjVWNm5iNXNLSWl1TSt3REc3eHM3VmFRWWRDUjJpOG9nT09W?=
 =?utf-8?Q?ls12CA3QJEtk7LycRmBspPcmUB+x7jjcWUCPqxgGzgzA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8267221-8209-4f85-e870-08d9dcfce7e3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 16:41:43.1228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylUcDH9Lx8HuDrvHg5Z9SK5es8qeSN5CxKXuounNvnGilQal7p1B1GXt4F0GOkwcYfJ96tszd1Sk9x99wiWhRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2740
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210108
X-Proofpoint-GUID: d6AorjG1RveRva8QsJlA_RCOzbPLoc1P
X-Proofpoint-ORIG-GUID: d6AorjG1RveRva8QsJlA_RCOzbPLoc1P
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/22 07:47, Matthew Wilcox wrote:
> On Fri, Jan 21, 2022 at 08:35:17PM +1300, Barry Song wrote:
>> On Fri, Jan 21, 2022 at 3:13 PM Matthew Wilcox <willy@infradead.org> wrote:
>>> On Fri, Jan 21, 2022 at 09:08:06AM +0800, Barry Song wrote:
>>>>> A file under /sys/fs/mshare can be opened and read from. A read from
>>>>> this file returns two long values - (1) starting address, and (2)
>>>>> size of the mshare'd region.
>>>>>
>>>>> --
>>>>> int mshare_unlink(char *name)
>>>>>
>>>>> A shared address range created by mshare() can be destroyed using
>>>>> mshare_unlink() which removes the  shared named object. Once all
>>>>> processes have unmapped the shared object, the shared address range
>>>>> references are de-allocated and destroyed.
>>>>
>>>>> mshare_unlink() returns 0 on success or -1 on error.
>>>>
>>>> I am still struggling with the user scenarios of these new APIs. This patch
>>>> supposes multiple processes will have same virtual address for the shared
>>>> area? How can this be guaranteed while different processes can map different
>>>> stack, heap, libraries, files?
>>>
>>> The two processes choose to share a chunk of their address space.
>>> They can map anything they like in that shared area, and then also
>>> anything they like in the areas that aren't shared.  They can choose
>>> for that shared area to have the same address in both processes
>>> or different locations in each process.
>>>
>>> If two processes want to put a shared library in that shared address
>>> space, that should work.  They probably would need to agree to use
>>> the same virtual address for the shared page tables for that to work.
>>
>> we are depending on an elf loader and ld to map the library
>> dynamically , so hardly
>> can we find a chance in users' code to call mshare() to map libraries
>> in application
>> level?
> 
> If somebody wants to modify ld.so to take advantage of mshare(), they
> could.  That wasn't our primary motivation here, so if it turns out to
> not work for that usecase, well, that's a shame.
> 
>>> Think of this like hugetlbfs, only instead of sharing hugetlbfs
>>> memory, you can share _anything_ that's mmapable.
>>
>> yep, we can call mshare() on any kind of memory. for example, if multiple
>> processes use SYSV shmem, posix shmem or mmap the same file. but
>> it seems it is more sensible to let kernel do it automatically rather than
>> depending on calling mshare() from users? It is difficult for users to
>> decide which areas should be applied mshare(). users might want to call
>> mshare() for all shared areas to save memory coming from duplicated PTEs?
>> unlike SYSV shmem and POSIX shmem which are a feature for inter-processes
>> communications,  mshare() looks not like a feature for applications,
>> but like a feature
>> for the whole system level? why would applications have to call something which
>> doesn't directly help them? without mshare(), those applications
>> will still work without any problem, right? is there anything in
>> mshare() which is
>> a must-have for applications? or mshare() is only a suggestion from applications
>> like madvise()?
> 
> Our use case is that we have some very large files stored on persistent
> memory which we want to mmap in thousands of processes.  So the first
> one shares a chunk of its address space and mmaps all the files into
> that chunk of address space.  Subsequent processes find that a suitable
> address space already exists and use it, sharing the page tables and
> avoiding the calls to mmap.
> 
> Sharing page tables is akin to running multiple threads in a single
> address space; except that only part of the address space is the same.
> There does need to be a certain amount of trust between the processes
> sharing the address space.  You don't want to do it to an unsuspecting
> process.
> 

Hello Barry,

mshare() is really meant for sharing data across unrelated processes by sharing address space explicitly and hence 
opt-in is required. As Matthew said, the processes sharing this virtual address space need to have a level of trust.
Permissions on the msharefs files control who can access this shared address space. It is possible to adapt this
mechanism to share stack, libraries etc but that is not the intent. This feature will be used by applications that share
data with multiple processes using shared mapping normally and it helps them avoid the overhead of large number of
duplicated PTEs which consume memory. This extra memory consumed by PTEs reduces amount of memory available for
applications and can result in out-of-memory condition. An example from the patch 0/6:

"On a database server with 300GB SGA, a system crash was seen with
out-of-memory condition when 1500+ clients tried to share this SGA
even though the system had 512GB of memory. On this server, in the
worst case scenario of all 1500 processes mapping every page from
SGA would have required 878GB+ for just the PTEs. If these PTEs
could be shared, amount of memory saved is very significant."

--
Khalid
