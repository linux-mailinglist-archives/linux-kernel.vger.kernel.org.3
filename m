Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81D14C955E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiCAUG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbiCAUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:06:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381E70CC9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:05:44 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221IsEDg030556;
        Tue, 1 Mar 2022 20:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rRHGJ2JOVlE14ZAYTJfHAou9reiMJKy/41X/KLYHdNs=;
 b=LcpPJAZDnxULU2eDIiuwcNVJhmU8DVBAiPm1+iZNotIgioBl1DBWVMDlD9l8CvJc+Vne
 YSDqi6k42VtreFg6reywFWfgEcpeToo4e614+gS8oHD6VMkEjwqQS/FmEmiR4YZXWfxb
 5DcBJ3wun2/2XVGuPwbIft4XqABS1p7w1fMNwGcCA2Q/r1wL86crgoJgm5uyTwDAan2P
 zaB9oSCyRwjOtm89HCl04LbAwiD6HLE9jLo6CSQVvREvZReXfSoNqRAZy2sq8RYQUHyR
 4ph/31gFzjVQidj3dPEQCEdCHlAnMwQJEpnLHy/57gGVJka97Uzgw75l5HKKAnV+K8lE iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k43vyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:05:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221JtGkg167541;
        Tue, 1 Mar 2022 20:05:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3030.oracle.com with ESMTP id 3efa8ep3bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB7YIInOy3yArGNezk+cBxmKmaKoiw1OCYqd2KlCdM0IyzwYn/xTGy0xdTnVNpQyrEWjQiE79kWqEYGug9SubwlY+mNthBQFGEmpkQiNnXfyL8+CbVZ3MJTv4oVL65ArcLuZlDpHJv51BIqFm4JFYuoxTQKaLParUMF1h8UDzKu14MELN3lxplYBUZTwVqJINwX7xwQSTGGy39Y51vWz3Gz7hP7Ve6FC53NTe9tWDOAP+NmID2qJQhn4YkHfWBrO4PoFyu7EI0T0TRa6k7LrLLBzfhH1I7snXJiyICrEoC24fApF0TEEFpLoKkN85L47Ue1Gw8zgMKy2kq94eNzzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRHGJ2JOVlE14ZAYTJfHAou9reiMJKy/41X/KLYHdNs=;
 b=cAwpwa3QZB0uno4qxezu1W0YVVwxx3jokEoaIUCCUpBGB3ON4vQ2lk749itPce8YpHVvbhZGm7o/TnB8nAT8ZoJEfFYoxM1b9IptcUBrI9YwYDa88GX0I2Gw4dYZnoeSSDM3qR5Q4ijqd+KxRmO0WQF2k/jQ9BGTARifua9Ezlgptmx0QovPwtEOoU9STCPSpPDe50raf2YcC/2i8eDNYAC9K0OlL+SxMWQ1mNo2nzWzOXIBY63GlY9J9n6HU/VVD3HgNP6fklU9HwWho1F4al9wBubtsbX1+mivad/Ok6hMHF79KHag4mWPdb92a2KXWzJV54zYkIvuGM2gJiyBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRHGJ2JOVlE14ZAYTJfHAou9reiMJKy/41X/KLYHdNs=;
 b=axV5zjaElD6Wpb5xHsBf2o51ocjQvSDdYo4QhZaTOyIYFEbdXysz/lhS/G8XdOfZIRGs6Ewq365XgnTSFBTFVXbT9eml6B8XeIwfcT4/CifHlykTQ+OAvzsgmR5r60NWfFYGkp1HNb5VKkFjVjCum2p2TniA1+Zb22zQRfm7MfA=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BY5PR10MB3875.namprd10.prod.outlook.com (2603:10b6:a03:1f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Tue, 1 Mar
 2022 20:05:21 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::4d07:86d6:8830:347f%7]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:05:20 +0000
Message-ID: <daf2cc47-4cad-4b6f-fdf2-f75e1f3e3cb3@oracle.com>
Date:   Tue, 1 Mar 2022 14:05:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 04/10] crash hp: prototype change for
 crash_prepare_elf64_headers
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-5-eric.devolder@oracle.com>
 <YhWuElhbF4GslSfq@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YhWuElhbF4GslSfq@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:806:126::15) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28182408-f2e9-42e9-2d25-08d9fbbed010
X-MS-TrafficTypeDiagnostic: BY5PR10MB3875:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB387511765ED45DFA5CA7380F97029@BY5PR10MB3875.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSnuEmAveOd23dzT5sIrenP1Y79EkDpSefaxhQOCC2TGi9WDfbtNdYu6T8YzFnb/X1gSsByLxIPrm9A6LODB8we1O/lO4K8KJz+RC03CDbXv663YGO02igXoHWdLop+uDkSHqMMikpa3m1RWYwWrzrxfkQFU6Yu5TY/zGPbztdKgRX1JxfpKnBu65xIOZitbx4n3qWcyEYkyw1QUXq5AUY9CUFH9uDQr8XN7GmhalbeflKeBOUuis0Qgw4Uu8av1yQBKE5PWGpZ2eThNsheNGzo+SbtnY3dCzhAiQArQ96lCmxYfoEirWME5fv+2gVnQw4ZmRb/X5L8aKEedrVNLhS8cyudQmlplU7ml7ZzR6NasBuVPJ/0K5jSImpAAw8W/YL5tcd8qa8MhBl3AkBncWwO+sghUD/UQhbzPIZypWjM6ajRyVu0L047U6EPd2LraVGZpDZpfEacG0roeHvZUJWemJO3llFv65vTyGg1PsDsMt9whOP26JWo72lwMx6d/NT8vgp8Z3oEW0j8blumSGWu1FZTxFuUpuywygwgxLOsTiCMboh3Q0cgi3tN64mJoI6jWA+ebj/lGNj5rKLy+5GX7ePXIunCsWfbbkC23iMgI9fuAmlH+XjRXSn4fx3mOZVzjc+8ghF3vkGJoTnNjVVQJlsJ8OS0X96jUf5PisAMLa9c3XgsQetfoFHchEceDRjr8QOWqHE5emhIdSxnOX7mXET+O0+dBcfIjnMQuOIpwEE509L/ZcWLml++iP9Cv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(8936002)(31686004)(6486002)(66476007)(66556008)(4326008)(8676002)(2906002)(31696002)(86362001)(7416002)(508600001)(36756003)(6666004)(66946007)(5660300002)(107886003)(6512007)(53546011)(6506007)(38100700002)(2616005)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJRR3ZyVjF4U2FyUjN3V0J0YitEZFVsbE5DT1lFUlQrL0IwcTNacWlraW5Q?=
 =?utf-8?B?dWtybnd5VW4wS3JTcVBzc3ZveTM4YThVWW5UT2NvS2lnYjUwTkNyMDM3MDRK?=
 =?utf-8?B?Sk1PaktrTnRZRlhISG9TU0dWcFg3eFBsQUsrbkVDMmo1UlhZOG4rNktrVzgx?=
 =?utf-8?B?TVhaM3lvRU5KZXU4YkZpeGcxbGpIZVFpNlYwTE1CVnAvMVhFcm83NWZ1ek1P?=
 =?utf-8?B?bnZ2dXVOTjNWU294UVZiSkpQYVZaTHozVktxUTBMYUFDOElpLzBPbGZxc3hY?=
 =?utf-8?B?V0JsZjYxVGhiam53UXlySGF5YjlPVExlNExycS8wdm1SMGRMaTA5UStNRytj?=
 =?utf-8?B?WHZpSDR6cUpPdFhsdytRU3M1TkVEVkRMQk5aZ05Rb2kyOXA4akgva2d6TmZ3?=
 =?utf-8?B?SldyaUErbDQyTndXdzV6NmlaRHdGRzZyQVZUTlFEcUtOK2lKbEJYVEJnOWNs?=
 =?utf-8?B?V1UyVHNXbVFFT09lN2hMWjh1M0xDdkNxMlV0UkFsRjRMV0h3SnF2RVhKUzFJ?=
 =?utf-8?B?ZEhtbHg4R1NUajE3NExFYnp2a0plODBLTmZucjY5NTgwWWcwVVZwZzFMOXk4?=
 =?utf-8?B?WU8zYTZLalVicWRTZlFNMVk3cVhtRkZPNGMycDhiamtwUmU0TmFZUXc4Mmt3?=
 =?utf-8?B?by9iU1BJVlRXZVNEWmdjWkliSHBaL3I0UmFEWWhGaEV0emE5Zy9hcnlVb3RI?=
 =?utf-8?B?KzUrR2V5dWI4QllaTE5JQUttVGdvdFJqSC9VeEMxaXo2bWR5aXU5Q0kyaHRH?=
 =?utf-8?B?bTF3VUF4WVVHdHM5YXZSQlJJRTUxYnpZL2ZtQjVkVkxvcHNzL2NPN3VtL1pn?=
 =?utf-8?B?V3IyenFLOThMcEpjMnNFRGg1TzBkZlhwaHA2ZHk2Y1kzZ2hwT1RJdnhXRGNS?=
 =?utf-8?B?Qmd1Znc5d1I3Q0VYVlhhMTZQbjVJVWVxTHVwQ3lXQSt0RVRPYlkvNzBCY1Zq?=
 =?utf-8?B?dzJRdm9SUnB4cmE2cmZpV2MxaDlsaEltakdnTWpSMldLSHZUVytWd2FPbUor?=
 =?utf-8?B?Q2NzUmJzVDlSRTJ6R09yS0ZGaEhvYWtOditQRnJXa2VCOW5nVzhyYnRxOSsz?=
 =?utf-8?B?N3JjMXk1WUZiNmpWODZxUW8zMkFybmJiVngyNy9WZjV2Uk9QdHVjOVc2L1Js?=
 =?utf-8?B?MXdSRlJBb1hTRmRRd1Z4RW9IejJwUGlhUitqOVlRTzJraE4wZ3JWN3h6TUVF?=
 =?utf-8?B?QzdMVmhhR0FPRDlXeHZBK3FFdTlSaldUYnk2Q1F0ZExwQU1jNEI1Q1R5SE9P?=
 =?utf-8?B?eFZlZm9lTHBBSDViWXl2c0sxR3JtaEVwZ2t3THdlcUFsc3JXeTNNYnZQd1Yv?=
 =?utf-8?B?ajlUMFVNUTNwR1U3T1owMVFXc1RWVzM0ZUJNYkZnVUF0N29yYTh4V0EvSkVG?=
 =?utf-8?B?OWp5ZldOdzJGaC82TDVuaXlVVjlrQnc5cDZxdnh1eVZnNXFXUUpuOGJaV3hk?=
 =?utf-8?B?V0phdzZ5VzhrdzJVQkU3TU8wWFNOZUtKN2tUMnl2TWFFVzBiR3pWY0VCRlNv?=
 =?utf-8?B?ekxQVXlIVWlhL20wODNXYlVJa3NpZXkrSTA4b011bzVlRjRNR3ZRNkNnM1lP?=
 =?utf-8?B?dk85Q0FGWWlqT0ZYRWVXdG40R2lnUE5UWlluOEMwM3dDQUdlbGtnTERqYVA2?=
 =?utf-8?B?ZFRydzNQalhvVWg5SzBRakZpZ1l1OUU2RCsvNDMrZENGQTBrRk1rNWMwbEJD?=
 =?utf-8?B?bHdjOXpkZ2VvSVp2SHMrVUlhTmFTRkVXcS8yM2ZENEFuYjM0S1JrSUw5M2Rj?=
 =?utf-8?B?ak5FaHJZZnZYKzRORFdiakQyS1VKMVk2WHM0bVg5eTVRSjR3MW1kZERkTTY1?=
 =?utf-8?B?ZG04MG51VnhxYzI5bGc1bU1sVkRBMExrYVV4Ny9YMDE1U2JKSW1GMm1qQkNP?=
 =?utf-8?B?eFAycU9aR1J0ZmdUaXBpZHZHN1l2ekxxUUc3ZUp0eFdPRElreGZ0SWJLdXBZ?=
 =?utf-8?B?VCt4OHhLbjh0ZlltM3dtcVhoRmJlM0VyMDZhVGZxYzlzUnlLRE1vdnFybExu?=
 =?utf-8?B?ZmxvU1RhY2UyTVRaRG1aRGEzM1R2YmJjaHhKRHA0ckFYaDd6eDYwbEhFdkpR?=
 =?utf-8?B?WWxYWmVCcVZVSnJvYmQybm1WQmhZTThRUG1hcG5HdVY2MFhNTWZkblUremZC?=
 =?utf-8?B?WndFOWhUc3JJRkhxTWwyeEEyc3pmMEtsVFNSR1FXRzFWdTVSQm9acHhJR1Rk?=
 =?utf-8?B?TDlmNGFmbVRzNnpPNE1EK3BtZzM4UUE2T1ZvSUxUZFRiYnFqU09oS0lDdXh2?=
 =?utf-8?B?c2Y4UlovRWdyNURabTBFelpQcUNueXFLUkZaOVZ6V3d0d3dma3M4V2I0a0xI?=
 =?utf-8?Q?CWb7eubTxhDnVGDx9D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28182408-f2e9-42e9-2d25-08d9fbbed010
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 20:05:20.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pd6lDfhgr8YQ36WuA64I9aj+2Dv7wVBJCT/G8RxsO3YyGgppJP4bmRwQnxqz0WT/gBSDJtgcWnwdd7O9Rxf7tU/SBdL4p1MEyML8CVjVwX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3875
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010100
X-Proofpoint-ORIG-GUID: VF68498RNUGgB9mBlEw6ykUZp8i9XdwE
X-Proofpoint-GUID: VF68498RNUGgB9mBlEw6ykUZp8i9XdwE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/22 21:46, Baoquan He wrote:
> On 02/09/22 at 02:57pm, Eric DeVolder wrote:
>>  From within crash_prepare_elf64_headers() there is a need to
>> reference the struct kimage hotplug members. As such, this
>> change passes the struct kimage as a parameter to the
>> crash_prepare_elf64_headers().
> 
> One more sentence can be added"
> 
> "This is preparation for later patch, no functionality change."
OK, done!

> 
> Otherwise, this patch looks good to me.
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Thank you!
eric

> 
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/arm64/kernel/machine_kexec_file.c | 6 +++---
>>   arch/powerpc/kexec/file_load_64.c      | 2 +-
>>   arch/x86/kernel/crash.c                | 3 ++-
>>   include/linux/kexec.h                  | 5 +++--
>>   kernel/kexec_file.c                    | 4 ++--
>>   5 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index 59c648d51848..7dbafb42ecf2 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>>   	return kexec_image_post_load_cleanup_default(image);
>>   }
>>   
>> -static int prepare_elf_headers(void **addr, unsigned long *sz)
>> +static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
>>   {
>>   	struct crash_mem *cmem;
>>   	unsigned int nr_ranges;
>> @@ -67,7 +67,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>>   	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
>>   
>>   	if (!ret)
>> -		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
>> +		ret =  crash_prepare_elf64_headers(image, cmem, true, addr, sz);
>>   
>>   	kfree(cmem);
>>   	return ret;
>> @@ -96,7 +96,7 @@ int load_other_segments(struct kimage *image,
>>   
>>   	/* load elf core header */
>>   	if (image->type == KEXEC_TYPE_CRASH) {
>> -		ret = prepare_elf_headers(&headers, &headers_sz);
>> +		ret = prepare_elf_headers(image, &headers, &headers_sz);
>>   		if (ret) {
>>   			pr_err("Preparing elf core header failed\n");
>>   			goto out_err;
>> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
>> index b4981b651d9a..07da6bf1cf24 100644
>> --- a/arch/powerpc/kexec/file_load_64.c
>> +++ b/arch/powerpc/kexec/file_load_64.c
>> @@ -797,7 +797,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
>>   		goto out;
>>   
>>   	/* Setup elfcorehdr segment */
>> -	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
>> +	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
>>   	if (ret) {
>>   		pr_err("Failed to prepare elf headers for the core\n");
>>   		goto out;
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9730c88530fc..9db41cce8d97 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -265,7 +265,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>>   		goto out;
>>   
>>   	/* By default prepare 64bit headers */
>> -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
>> +	ret =  crash_prepare_elf64_headers(image, cmem,
>> +				IS_ENABLED(CONFIG_X86_64), addr, sz);
>>   
>>   out:
>>   	vfree(cmem);
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 13c238c2da48..b11d75a6b2bc 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -221,8 +221,9 @@ struct crash_mem {
>>   extern int crash_exclude_mem_range(struct crash_mem *mem,
>>   				   unsigned long long mstart,
>>   				   unsigned long long mend);
>> -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>> -				       void **addr, unsigned long *sz);
>> +extern int crash_prepare_elf64_headers(struct kimage *image,
>> +	struct crash_mem *mem, int kernel_map,
>> +	void **addr, unsigned long *sz);
>>   #endif /* CONFIG_KEXEC_FILE */
>>   
>>   #ifdef CONFIG_KEXEC_ELF
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 8347fc158d2b..801d0d0a5012 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -1260,8 +1260,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>>   	return 0;
>>   }
>>   
>> -int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>> -			  void **addr, unsigned long *sz)
>> +int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>> +	int kernel_map, void **addr, unsigned long *sz)
>>   {
>>   	Elf64_Ehdr *ehdr;
>>   	Elf64_Phdr *phdr;
>> -- 
>> 2.27.0
>>
> 
