Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2F46C424
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbhLGUIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:08:38 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50490 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235966AbhLGUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:08:37 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I4cZ2023471;
        Tue, 7 Dec 2021 20:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=diK0kao88wpVGjFjrMOPLHoOgCY1Ox7T/SXdENnEm9w=;
 b=raaHvZaFfggyxEdf7YZOBBnicMy5rBDPpxRIxSdxCTs7JRFT+tkiXh0pJQDg3cguSdQD
 2UHZmLTryjFcfkepOxioFwW9SrAQtU2b6WhDsKPwqKpLIcXNHH6oObj5nbSFrHnOkdfm
 eXyIOHj0jxQy1zzNenO1PoI96RyPdg2cwCyz1gpwzP12IKfX/uu0JPLePT72KNKv1nuW
 RqJT6ME3fHJkrQmXFwIC0dbkAdYAXHPgoRAvLBw7CfcqzkwmexN79WUyybHvOQn5i2qp
 s9HFoHBRFm7MBSwuof1zXL0WLhdVVRe6fjGrAmKqyPcTi3csUiRgl2wunC99IswqMGiU qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72ef0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 20:04:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7JjBSU137995;
        Tue, 7 Dec 2021 20:04:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 3cqwey89fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 20:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAUg8sp19o35wk8ta3T7wGzttq5/3cZDD5L9ax5BfZPU5k1SHORZEfExwgWtI34ekr7b1IZmWlPtgvYuDohf1/NM3p+YoTHxsJ7Qjuj2W8qly26y5qiw43qgurnzuer00QQ7XY8aNqHCzPjYW247USSaOSuBT2pyHqmHWEGc5PyQOzM8yCvibOv9CStxWYgiBjNOuLcir48w8zbUd+Bo0xey6AZTUOlTBGduIEZc52xqjwwKpVaprp0zeTkrhDhqeuys5HzSetyAZdaYUD7IvBcwU+6Jwmu6QuV1qsAKb5bU0DCfb2A9fTe5r6/lmzFdfDapsAafgRhXQ3VmmScX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diK0kao88wpVGjFjrMOPLHoOgCY1Ox7T/SXdENnEm9w=;
 b=fLPytHoudd9Wx8MM+vX57lQtrCDUmXvH9JxGBEUsypXoO3ds5WxL9ElyFit75QXHYRKyO1/Hv8E8B3uNZimIQJTZ6sNStMgFho2lnrVp01MLgtBpPi8PFHJvbvQdrVP6YQ3iUyxr616Ta9zT7O52Pu4UJQbDz7ibBcV1v3mwpAvbsQ1rfJw0ri5DbHSd5AbynoscNpEC8fx/7py5Y4Gd88e3aOr4Ii2KmRgeMQ0ePGJOz7PYQod0v2ipMXvC6Gda8z+Hnzrd8sgJ1pwJSsg2VOkxBm8M/mQnqCwuavTBmxWkbWanhSYCWpOcUO9YVL1LfAQ1KbfiblwUzgq2V93qwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diK0kao88wpVGjFjrMOPLHoOgCY1Ox7T/SXdENnEm9w=;
 b=H7y//WOJG0qOZ6jtZ2ezZ4/ffzUtjaWomI1pFaqcY0sssyATBbNJMZ7nor83wQB5VeASNXKCximGNoV+Q4k8PeVvGdZDlXiIIMFJ01zpx6D1t4IX4+3OAdb6tAeQvvJ2TWzAMoUHY60wz8S6tdsp4vG/WuI4QEw5JgxH/BWS3UI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR1001MB2351.namprd10.prod.outlook.com (2603:10b6:301:35::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 20:04:43 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 20:04:43 +0000
Message-ID: <9e5a712c-2304-0721-64c8-991dace19b6f@oracle.com>
Date:   Tue, 7 Dec 2021 14:04:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v1 0/8] RFC v1: Kernel handling of CPU and memory hot
 un/plug for crash
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        akpm@linux-foundation.org
References: <20211118174948.37435-1-eric.devolder@oracle.com>
 <20211124090227.GA8026@MiWiFi-R3L-srv>
 <200f923a-d196-7475-99e3-63ff3e73b28e@oracle.com>
 <20211201125903.GQ21646@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20211201125903.GQ21646@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0203.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from [IPV6:2606:b400:414:8061:221:28ff:fea5:27c8] (2606:b400:8024:1010::112a) by SA0PR11CA0203.namprd11.prod.outlook.com (2603:10b6:806:1bc::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Tue, 7 Dec 2021 20:04:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81ce9a23-f5e6-49d3-7c67-08d9b9bccf27
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2351CFF343703F1EF44B1736976E9@MWHPR1001MB2351.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rW/B3AGjMc28GsJr5/0+6vJkWZ61RU2IgBWoeQW5bgk87FkJeNMZH12gbUrzFVkyB5jHik6idDG3Gh1LioIEe8BzTdnyxFBmPZk9rWNxwV6DuOuUrJElfCt5Xk9zM/XEyAXuw0h1Wa3pvDdOApmSN+TzRoIvcYDAPxo1K7xm74eFkn56PXLSCYp3/0NCupvw0f8+AyFkltQ3L7TPSl/fqsgydxUnxtE2VX6rcSld9JLs2HUQob0AFV7CAftF0LSPctwMTVcaYwYvoJIcB652IJ88fxRmtS618f8v1k6TlNQ9hAYEsPOqDwv8IVmoo1j3EKoxeHpkfWFT61hhybWDWN3aScBOTUOB/8beNBrtcbD8TbomMf9lge4BJNXzcxl391fN1tllAffkQ3B91xPwUfX0wqFlqIitSUCn98AX9c/aVPMXevCqIPU191GZ2pqEU4AGVmoTtwCvr8AhtyVC1R+ikWU4P32m75kaWP/8fySRmtats7ZitPzy89avYqdM14Og5hSesPITz2ggGMAx2izs5KfeWTSt6zp0OX3endmQn4cl4BCuy/XbTfA0Je18AE87JaksGMZpDuft8IFKr4mQoI9BWNyTLF8eHFSRVsoOde3Ia5D/mpGyjLZYxxoEx412cy/IjvbpXa/hl2UtzKx2WCGg343a398AVFhnAlGuHNTuQTNkUu/YUArwqpDLJol905KVuS4eNT0OXq9YQMcr69W6yoPOrKimLzIESRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(4326008)(66946007)(31696002)(66476007)(83380400001)(66556008)(6916009)(508600001)(186003)(53546011)(6486002)(2906002)(5660300002)(38100700002)(31686004)(2616005)(8936002)(86362001)(316002)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODljalU2OXVKSzVzRDI0Z3RUTndzQU1DS1pzMEg0R2tqVlpTUWQ2eTFmdmN1?=
 =?utf-8?B?QWpVREZEbVVoL1dueWVEY28wbGJHSW5kUm1FMDNRQy9sZFVCV25CZFJGclcv?=
 =?utf-8?B?K20ySWJMWmJhRnNDcGVvSGV4Wmk0bE9VbWROZlR1ZUxhdmdqTGMzdFdsYzFw?=
 =?utf-8?B?QUhveCtwVjZjanc5eE8vYmxTODBEVUFId2o0SlJIcjdQNmZTVEdsb21YTUho?=
 =?utf-8?B?QXBuMmpEMXdna0VHbk5lN2FIbXlmdlgxeHBIRHNJaVAvVjZPYTF3N2NkbnI4?=
 =?utf-8?B?LzU4RkRveXBaWEF2OWxONUtSbldpc3RzR3RKYytjS1BHc0Y4NmFYdk5aakNX?=
 =?utf-8?B?M0lRM1VaaXVKenlqdmRiR25Wa1NrcENxbGlxMTRoMmpLL3kwVTRDMWtQenM4?=
 =?utf-8?B?UFZaZ0ZTNHhwVzJ4UThiMmVPcVFwbmVNVGlvdHc4V0hjamNBaW5TT2RqWkdW?=
 =?utf-8?B?TE5JT0RuSHZHUEwxZm5uMkZzTjIxeSsyYkRkWUFKQk1zVWV6TXczcXU3T2FF?=
 =?utf-8?B?K3hlN0ZNTkRMRUQ5LzdrVXl0VitFcCs3a0ZzRG9VWjVIcTR0aFo2U3JtdE9K?=
 =?utf-8?B?OGdJaFNBMUkxU0dFeUMyaGhOZ082ODFTSEpZbGY3cE9QSjBzMXJHSzM5MWZW?=
 =?utf-8?B?Q3RDMnAwcDJNUVp1YnZQMG1xUm40ZHg2dUt1SlkrZ1R6N2RrQjFPVTdLS2JS?=
 =?utf-8?B?cSt0Y3kzSnJQUGUzdlJrYXl0STlOOGJ4RURsOElYbEg3K2VYZS81aFJHQVBx?=
 =?utf-8?B?aHdhczRqK3VROUkwVkh2bTVsMldKcGRuajFpUCs0c1FqeFRmNVFSajFtZits?=
 =?utf-8?B?VTl0WkNoUkd1dmlXU0U2ZXNZT1pJeTkxU2x0bXBzN1dXQTFrbVNtbXVWcUY5?=
 =?utf-8?B?TjdoYjB3RDVhSG4vNE5BYzFhMHgweTlhUkVPeHJLRHJHZmg4ZmFIRVB3Q01p?=
 =?utf-8?B?OUJsNlNiR1ZBVlhBTUFWcjJyQ0dOSEZQUDlBWm5vRHMzM0VTdGpGNlUxOHRs?=
 =?utf-8?B?V1lwQ0JvYnBJZWNRYnEyUjBJU3c3TjJwRklUYTVTWHVaaThyemlENGI3N1Ra?=
 =?utf-8?B?RlJCVldBSmV0N083Qlh3Znpybk9IejJWd1J1cW0wcXowNXhidVFQOEowN0Vz?=
 =?utf-8?B?WldManBKb0pDRFlKZTVGbDRlamZEbWlvbXhFU1BlS3RvdGVVS0F0ZHhZMHlJ?=
 =?utf-8?B?ZlIzd0ZnMVdwa0xheHBMajVHSUNja1k1djM3b1hUVEZscFMvN2pubHR5MHVh?=
 =?utf-8?B?RytuKytsL2lOdWVrVzRyN2xURldaMitEcXNUeGlDV0Q5d3kvaWttZmJtbjVv?=
 =?utf-8?B?eGIwQmxIZklsU0ZjL1UrUjlXRWs5YmVQVTYvSjVFcVFNY0Erc3ZwWit2ajBp?=
 =?utf-8?B?QlRJaVMwSnVQSGtMZTg2L2NYdGFxcFNNVGxYblZhdkJTZm9rdVdZTkV1aElk?=
 =?utf-8?B?VlhGN1FVN05XZG13WnRqYUpJcFdmWTluVWJsNGxkb0tCbEZhQ0xyL2ZxZ2dP?=
 =?utf-8?B?aXo5NzgwYmxrOEt4VEFqOXRkaXY1RXd2NHVNclV4eENRYWg4RG9Ya1lTRWRn?=
 =?utf-8?B?NUpmNGs4RUNSZ2UwU2I5NHpaWkRkSVF0K3NuQmdTaEh0TENPbXdSYTR0Z3Vz?=
 =?utf-8?B?YlRBNnVleWxVdFNyeTF0ZUsvNlJjVjFXcGpoTkdnTXR0Um9ycjQwZ2J1T214?=
 =?utf-8?B?elU1VHhTMHpLaUIvd1ZpSzBaUzkyQWdndThBaG5rMklpWVZualJ1U3JOemFa?=
 =?utf-8?B?Z2MrTURUcGs1ZGJtUlhYQmxkNnRXQlVJV0VTanRHa0ZYa0tXbFNXQ2FEZmRl?=
 =?utf-8?B?QzFHNmJPajlnbkdHazhkQWVWRHdXenRzSEZ3TUpmYU5laS9GcEVQNkFaYW11?=
 =?utf-8?B?RlVJaTJaVDZlZlI1NzNDTkpad1lZVWFuSW8yYmZ0VDdrdmdvaUlRNkp2TEtX?=
 =?utf-8?B?WWdRQ0RLbThHMERXUVRxQzErMGJJSU12T3JHb0pHUVVVbXQ3bHhqRWZyS2Uw?=
 =?utf-8?B?NEtRSk81ZlpvMEI5U3VTT296YVc4VEJJUzg0bVNUUlJyMUF5MXlESDlRVUJK?=
 =?utf-8?B?c3k1OWF6bGxKelltYS9iZXdQbmJ5QXhWcXhRdVN1ckRGaFhVRkZYM3YwMVBG?=
 =?utf-8?B?TktFZWZTRWE5YlB3N0RwQmZYZ08rTUJZWVVZSWU4cGFxVW4yR1BFUDROaENz?=
 =?utf-8?B?REhYRWJkOHQxV2o2L1N1WVNpQ2NiSmhPQXEyNHQwcW9nT3MwWFVuT3QyS1F0?=
 =?utf-8?B?V0dzU1Z3cUxxbHA5VzUrM3R1T3Z3MGNhQWd5SkZ4NWlyMFZNbEkxSmp5MWhL?=
 =?utf-8?Q?tonRvOd3hUMjQ16V4t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ce9a23-f5e6-49d3-7c67-08d9b9bccf27
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 20:04:43.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M97726ZGBZjT7RqyO+O5hHbiifHTev88UxTR2KMRmCLheC5A6dwj+gbY6J1RcTsGoNik0JbAADHzLvCtMFUSGBIZ6KzjYjmyqQgIpUUL7do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2351
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070124
X-Proofpoint-ORIG-GUID: gongwrwGq-U_hcc20hqNt4ee8wpgIJ9-
X-Proofpoint-GUID: gongwrwGq-U_hcc20hqNt4ee8wpgIJ9-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See below, thanks, eric

On 12/1/21 06:59, Baoquan He wrote:
> + akpm
> 
> On 11/29/21 at 01:42pm, Eric DeVolder wrote:
>> Hi, see below.
>> eric
>>
>> On 11/24/21 03:02, Baoquan He wrote:
>>> Hi,
>>>
>>> On 11/18/21 at 12:49pm, Eric DeVolder wrote:
>>> ......
>>>> This patchset introduces a generic crash hot un/plug handler that
>>>> registers with the CPU and memory notifiers. Upon CPU or memory
>>>> changes, this generic handler is invoked and performs important
>>>> housekeeping, for example obtaining the appropriate lock, and then
>>>> invokes an architecture specific handler to do the appropriate
>>>> updates.
>>>>
>>>> In the case of x86_64, the arch specific handler generates a new
>>>> elfcorehdr, which reflects the current CPUs and memory regions, into a
>>>> buffer. Since purgatory also does an integrity check via hash digests
>>>> of the loaded segments, purgatory must also be updated with the new
>>>
>>> When I tried to address this with a draft patch, I started with a
>>> different way in which udev rule triggers reloading and only elfcorehdr
>>> segment is updated. The update should be less time consuming. Seems
>>> internal notifier is better in your way. But I didn't update purgatory
>>> since I just skipped the elfcorehdr part when calculate the digest of
>>> segments. The reason from my mind is kernel text, initrd must contribute
>>> most part of the digest, elfcorehdr is much less, and it will simplify
>>> code change more. Doing so let us have no need to touch purgatory at
>>> all. What do you think?
>>
>> Well certainly if purgatory did not need to be updated, then that simplifies
>> matters quite a bit!
>>
>> I do not have any context on the history of including elfcorehdr in the purgatory
>> integrity check. I do agree with you that checking kernel, initrd, boot_params
>> is most important. Perhaps allowing the elfcorehdr data structure to change
>> isn't too bad without including in the integrity check is ok as there is some
>> sanity checking of it by the capture kernel as it reads it for /proc/vmcore setup.
> 
> Well, I think the check has included elfcorehdr since user space
> kexec-tools added the check. We can do the skipping in kexec_file load
> in kernel for the time being, see if anyone has concern about the
> safety or security. Since agreement has been reached, can you split out
> the purgatory update and repost a new patchset with the current
> frame work to only update elfcorehdr?

I reworked the patchset as you suggested and removed the reload of purgatory.
It simplified things considerably.

> 
> Any by the way, I think you have written a very great cover letter which
> tells almost all details about the change. However, pity that they are
> not put in patch log. In your patch log, you just tell what change is
> made in the patch, but the why we need it which is the most important part
> is not seen. Most of time, we can get what change has been made from the
> code, surely it's very helpful if patch log has told it and can save
> reviewers much time, but it's not easy to get why it's needed or
> introduced if not being involved in earlier discussion or any context.
> And as you know, cover letter will be stripped away whem maintainers
> merge patch, only patch log is kept.

I've tried to place more information in the individual patch commit messages,
or the code itself.

I just posted v2!

Thanks for your interest and review!
eric

> 
> Thanks
> Baoquan
> 
>>
>>>
>>> Still reviewing.
>>
>> Thank you!
>>
>>>
>>>> digests. The arch handler also generates a new purgatory into a
>>>> buffer, performs the hash digests of the new memory segments, and then
>>>> patches purgatory with the new digests.  If all succeeds, then the
>>>> elfcorehdr and purgatory buffers over write the existing buffers and
>>>> the new kdump image is live and ready to go. No involvement with
>>>> userspace at all.
>>>
>>
> 
