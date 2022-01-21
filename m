Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40872495FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380804AbiAUNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:49:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62226 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380768AbiAUNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:49:32 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LDDmQx019670;
        Fri, 21 Jan 2022 13:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fAlnr3JdOxV3cPb5o/kYG7CAEUwfRehU5QUsPCS/DN8=;
 b=OZvIsqmAfoafM6QPE4eVQlRBJR5oGt7UA0VyvIxUpc17gRX9/+2oLwgDER2zCnYtp9YU
 8cleT3lCDDgoI97i6t4YXWXOeNTJZSHXsvi/689nH4facXl1/iqUW6MZXB6zPoaEYJL4
 PVcsnIXW1/WbV9njFaAUIT6Mhek3WbCfsBNrjh/EVHHeqUokmFx98Z9lythTvvD4uwHL
 IZhTK10lVhb0XKKmdYEanPh6TBtGBPiXOQUpUDdowAMVkz6hjj9I+bnuFUGpoHjAkVQc
 4T9e38ucVWSLWRje8LjKY4v+WBjlA7QGGSYX4HmOrjFYTNKndRXPrACsivIyq02YccEU +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhyb9be2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 13:49:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LDeE7E173900;
        Fri, 21 Jan 2022 13:49:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3dqj0n060u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 13:49:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT52zotyAE3i62lv9sFu5PZW00mf2Zu7UcpX8PHYBgzkbGszWR56RpNZdDuLcSsfaxhGXCJCRYIAL58v6dMMQN/4s+UgmmM39pV1BZtrfbjIbVNBkfh4exiNDVV+NXpTrZwALIBl48UIogEzlW7IyjWvNB91fLAldc7NGVUXk3/4askg6dH9vBu8iqrqna5d3esp+SkgnNyAj4OCcmkTDNM30uIAr+24Ye8gWgliPvo5w4peogSqwquIEFv3vNMZdbmvFDcocMK3HuKEZSTs0JICjirj7kSRQDO95P1F9IajiGSEkfr0ienlsPRB6zLdNMdhgruQuVfswTdjVcPt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAlnr3JdOxV3cPb5o/kYG7CAEUwfRehU5QUsPCS/DN8=;
 b=EHdEfJZIQTDjD6DNLoadEzLuo1wErprswZerhN1Nb2MzK8D+b2vRSFh7yHY6TBZCsBtO56N+h0C1scxr8394NI/6jzQAhNRb19y0KHbx9+XG6dkDmuzsgTOSEq24aHR+KQFbP9bycMmgMYB5GwpuUZvo9u5c8E/VwJaFzcusUCw82Q5coZpfIoY2fUcIEMR0QJlUMf3oUXtpVijzTOUgQnpuECxeI7hfzd2529jSG+Na2YlleW9HExy2IfKV1H5GGO66fOWyE/hGqPqQj1H3CcRqU7go99nUz2KyDoGxOw5Bz6UFbGiqMGgAngAk8k3DbqI69yX3JVcRRuusIyUxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAlnr3JdOxV3cPb5o/kYG7CAEUwfRehU5QUsPCS/DN8=;
 b=NQ6/HBRoablPaXNdIOEhCktX53juVd4F3gv9CaLiiVicXmZvBZVwzuYUZI8AOao/hPSTKuvpv7IEWrqWd7cdqK1vh1uDFIYGTuzQy5nWYNdvFnCSojW3Vr4qQs1oTzWwvzEYORyPtBUWHsOOP/WhgMxwrDReul291a47ONv84Bg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 13:49:03 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 13:49:02 +0000
Message-ID: <8af14bc9-7aab-433b-f741-494b3857226f@oracle.com>
Date:   Fri, 21 Jan 2022 07:48:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 3/6] crash hp: definitions and prototype changes
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220110195727.1682-1-eric.devolder@oracle.com>
 <20220110195727.1682-4-eric.devolder@oracle.com>
 <20220119082645.GA6349@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220119082645.GA6349@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::46) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a815977-593f-4b7e-00f8-08d9dce4c8ab
X-MS-TrafficTypeDiagnostic: PH0PR10MB5795:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5795077DC778C19D9BABB70D975B9@PH0PR10MB5795.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6B80pM5AV0Y8U28mLWWRoyEaAR/6OQKCM90ka8O/Hrx7OlDeS3ohT2PtndRt8yzObD/jAZ9BWJ867ghNVbdS+rkV+QH2DD/4g7pU7yT42gUvwoIqD2x/WSmDeqwefYy2pwTo5B6Kg9NvhlU3YAcNdk7A7j76ZD8rzTgGLOs0CIYc0ess2Ca1wq/rlc5REXkEJG0gjXkSyrYbRdbOeI5f3fnf6+qrTsgRxXzFZ496J5Y3MAVQvdY04SIv96IYaaSHGsbfkwjs9GUOz/AWuzF5MZFTY/yh0sZJyKx5UAs2nIx/R7q7Lz7iY2nxL0Rvew9QX9N+OIz4irg6qyZdp0IUTIhA18WEeM3BCTE8VSqu11dw0UBi1uRE8cjCpNKnj+ajTBm33yARh8r5rUey1YlmfHW3+bfKjMwWxR0/wfyShXaMThuym+8vlQixUm0IMOvpbTz+hJHncuy1RwqjYppvB/F+jWwAtWSy8gKhpqpxs/ThFjgPUwXhrhbTXA68iS41ad7Pmpn3mOQ4nCQ3pTOsRGDfrZHhm31Bvpn54oGyqoZHuPLOVN8ua5BdAnyuZ8iejJI0hRQOMAVHoC/icGXp8/Cf2XDNl48lm+SC2ajdef11WffIM9E+fxVrZh9AvRdpA4k0z43T+i7xh8gGiGjjT0Mc4E5F99oznJ7WiMmchZjQwrw3dJ6GhtAJul3vnavYXVXbTVQ/1eZgfurb+68b+vl0tj2wyeOHIHqxaaOFpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(2616005)(66556008)(83380400001)(508600001)(8936002)(316002)(107886003)(4326008)(38100700002)(6512007)(2906002)(31686004)(66946007)(8676002)(6486002)(186003)(7416002)(6666004)(86362001)(66476007)(6916009)(6506007)(5660300002)(36756003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXYrOUVQQ2Y1TW1KODlDS0V1RmxZcmpXZ0RqekhUbXNnSTM4NGNQZWYzZUVS?=
 =?utf-8?B?aXZvMzdPZWlJbVVicFJmTTcyeEJ4Vjc2dFFlNlRPZEJPWEtscmpqUS9wVDRO?=
 =?utf-8?B?UHo5V2JOVzhXdTJ4b0U3UnpiU0NrMVc0ZkVhZ3ZaekNiSVlCaW5zR00xdUJM?=
 =?utf-8?B?WEhBM05nSDViYmUwdjBQZUlvSktjalhHY2JwS215UnBiNVk3aTJSV1lXZ2or?=
 =?utf-8?B?VFV5N1Jqb0dyT2lmMnRqTEhQWDE0bnNzQmxZczFDNU15NzNhNCs3WFdXM3lx?=
 =?utf-8?B?RVRjWjRBYXlZRFpmQWlXdWZUYmJlZlQ3WURRdUVMcFkySjBPMjJPSXRUd3FO?=
 =?utf-8?B?Tm5URGVCSk9mMnBaM2l5MXZFNisyb2RiVEo1ajB1SFVZaEltT3NIWm8rSDVT?=
 =?utf-8?B?VFdNREZaQ2J2aTVkOGxHT0RUVlR4bUtjeEtMWVowNnRyL0hCcmdkQVY0bVhN?=
 =?utf-8?B?aFlqeXM1NnNLdUhqL0RydWJkLzNVYnIzQXVha1JvaTJkWHpXdGdsY2FrTVlx?=
 =?utf-8?B?WHZudEtJVHRUWGEyVUIyT0hYNEJVcHdZYmJnUGl6dlN4WWlqSG1CN1Q2ODY3?=
 =?utf-8?B?TGJKVUFVR0NwbVE5c0lmc3RWSjhYMFMwcHBnYjM5OUdwK0dxdFl1STRhYzdw?=
 =?utf-8?B?Z3R2UEdjZnczRXI4WUROWGt3QXdIRHFKZ0c1dmh0RS9rc0lzTWlmYmlaNVVZ?=
 =?utf-8?B?YjdReFE2amlXVE1seWIyTUlFYTdIMXNhRlFBYnRzNDdyaHRIU2ZvZWtTay9N?=
 =?utf-8?B?VzluOUNjT01PN29vMmNhU2VYZW9aampoRXVudEE5VGRLUDNET0t4TSs3akdL?=
 =?utf-8?B?SDg3QWFsUWZZdUQ0ekt6Zjk4ODVXZmdkV3NvRWV2TWhrV3RqY3BTYkxJVDlV?=
 =?utf-8?B?aFdqU0hDQjJFU0JzTFhNUGV3TlV6QmQ3MGNja3BWN1kxUVFOUEtBZ2grRGpM?=
 =?utf-8?B?QWpVYnBHRjh2S3p3R2FsUzUza2FQTjBvdVlmQ0hMY1FLaWcveGRHVS9Vbjgr?=
 =?utf-8?B?dTV3TmIrQ2NlT3pSNGp1ZUo3VEhyc1lVeDdwbU9DMmRqMjNrTUduNlBab1N4?=
 =?utf-8?B?TVNBS3N3WjM0Uk9EaHNDN3V0dDNiVGs4THYzL0hNemVVK29CWkJjRk5mVmpx?=
 =?utf-8?B?ZTRaVUo0cWswQTBRcmdiREs0OHJrU0lrd3lCNkVXVC9WdlczTEVLZnl1dUpK?=
 =?utf-8?B?cFFDdEZlVU9JaFNxeUpVTEd4YklzTVVsUzQydUcwaGlYZHpZa1YyZ0lPR2RE?=
 =?utf-8?B?dDdFOGVKcGVFc2NDQ3h2bDA0YllvZnlMaUhDbEZRd0w5WVNIZkQ5NzVMV2x0?=
 =?utf-8?B?d2dkamZkRmNQYzdpY084SndTeEVLcEorSThQdmRjM0RzRDRyVWRoOWVwSVRi?=
 =?utf-8?B?bjQrSGE5eDJjQ3BGUTRscmd4OFRHRTZHdFNMRXFjL2ZnQnFKekl1UDdURXhJ?=
 =?utf-8?B?REo1ZmRLY1NyU3VCZ0VQVldRc0xpb255blI5UkJOenJMcUFTZjNlSmdXQjU3?=
 =?utf-8?B?cHl1dWdiUU51Mmwwd29DVzdOZmlwZFdGODR4cGUyU1k5SEVSQWFNZjFwV1FX?=
 =?utf-8?B?VjdCNG9tRDdpbnIwWUVQYzZuWmhhdzFjUHN6anZGSjZ3SkJtZElTR1BtYUpx?=
 =?utf-8?B?WERVYWNyZjJaUkZEcXlPZVB0bGFpaU92eE15ZnA4S3Vud2JGcmI0ZHI3L2M2?=
 =?utf-8?B?SXg4UWczREZvOFNhaGtWZkpNazJmbTRCODhXUzNDNFVSNm4wVnU3R1dQN3NJ?=
 =?utf-8?B?MlVuaTBLWEpnZGhEaXVhbmREQ08vb1NtTTRxL3lvK1gyTUkzTWlNYnhBTnBn?=
 =?utf-8?B?a3hYVFNLVG9ZaGJ5SWx2LzdieEpReDBQQUx2RG8xSnBBY3NVaVZmeWk3YXlK?=
 =?utf-8?B?UlZld2Vrb1I4ZFBtTnlkOXl4VGZqM2ErYmpML0IyUG4vOVVib29ld08rbjlU?=
 =?utf-8?B?OGRhQmtHMXcvVkdDbDFMZUEyU3ArNkpmUXdSU0lBTEczQlZYS2QxK1JkVm9s?=
 =?utf-8?B?aWdJcklCVm8wcFFIZ2Y5bE9YZHlwdUVWQ1ZGa0RZb1VmRWcrcVB3Ly9mZDlW?=
 =?utf-8?B?NkRvWGpsMGhFTGtVbHpWSUU2WW5wMmo3RytBUmZNSXIxazBmSjNOMzdnY1R4?=
 =?utf-8?B?WEhPcmlNdkJsSGoyS3U1TENuR3FvbUJZU3d3SzBCbzA1emlZQklUKzFiMk01?=
 =?utf-8?B?TmtxeU90RDVWMlFrTS9BUDR5NGpic3ZMNjArVkJ6T0pEdVFaT0lnNDhLZU9S?=
 =?utf-8?B?ZkViR3p3cmtiNWczZG9NcHE1eWhjTUpRT0p6aUpFVU9VRUFZa0dmbkNiYmRx?=
 =?utf-8?Q?qNLQ/uDWrzV94YQL70?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a815977-593f-4b7e-00f8-08d9dce4c8ab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 13:49:02.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sM1CTWUFHG3rfhagVqENG8b7FcZR273OWhFRSaZaoTS0cTGcXgrPo5QDSvdRTdPZ39NqOrb35XFcFXkKbB8ByitI+bamLAjlxDgbiwyiWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210092
X-Proofpoint-ORIG-GUID: SQA4RxXOMBVJJmozamBj0PcXqvx81osd
X-Proofpoint-GUID: SQA4RxXOMBVJJmozamBj0PcXqvx81osd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,
Thanks for looking at this. Inline responses below.
eric

On 1/19/22 02:26, Baoquan He wrote:
> On 01/10/22 at 02:57pm, Eric DeVolder wrote:
>> This change adds members to struct kimage to facilitate crash
>> hotplug support.
>>
>> This change also defines crash hotplug events and associated
>> prototypes.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/kexec.h | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0c994ae37729..068f853f1c65 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -221,8 +221,9 @@ struct crash_mem {
>>   extern int crash_exclude_mem_range(struct crash_mem *mem,
>>   				   unsigned long long mstart,
>>   				   unsigned long long mend);
>> -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>> -				       void **addr, unsigned long *sz);
>> +extern int crash_prepare_elf64_headers(struct kimage *image,
>> +					struct crash_mem *mem, int kernel_map,
>> +					void **addr, unsigned long *sz);
>>   #endif /* CONFIG_KEXEC_FILE */
>>   
>>   #ifdef CONFIG_KEXEC_ELF
>> @@ -299,6 +300,13 @@ struct kimage {
>>   
>>   	/* Information for loading purgatory */
>>   	struct purgatory_info purgatory_info;
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	bool hotplug_event;
>> +	int offlinecpu;
>> +	bool elf_index_valid;
>> +	int elf_index;
> 
> Do we really need elf_index_valid? Can we initialize elf_index to , e.g '-1',
> then check if the value is valid?

These members become part of struct kimage, and when the kimage is allocated, it is automatically 
zero'd. Wrt/ elf_index, 0 is a valid index, and so it needs to be qualified. I initially had used 
-1, but that required code and was fragile as I had to find the right place to do that. Using the 
boolean elf_index_valid, the problems with -1 vanish, and for free! I also found when examining the 
code that reading 'elf_index_valid' was better than 'elf_index != -1', more clear.

Let me know what you think.
eric

> 
>> +#endif
>>   #endif
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> @@ -315,6 +323,15 @@ struct kimage {
>>   	unsigned long elf_load_addr;
>>   };
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b);
>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> +
>>   /* kexec interface functions */
>>   extern void machine_kexec(struct kimage *image);
>>   extern int machine_kexec_prepare(struct kimage *image);
>> -- 
>> 2.27.0
>>
> 
