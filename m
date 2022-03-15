Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6778A4D9D21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbiCOOOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiCOOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:14:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ABF193C7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:13:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FD4m1T000738;
        Tue, 15 Mar 2022 14:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GPN+vFkDMyvCAN7bTfg4QPhSLxRPxYUM83vsIk3gIzQ=;
 b=dZJHxRwo6oU3nCKLC25asO0mxBTe3m92xBXkxrChlLtyJIhL8f4npcw6SDiaQnKj+q2b
 re556uWbkuBNIsfwdqo70hVs3rEdtxn1ZgQthyvj+k9WNaqlgATY8Q9hJ/GXizXLELtl
 ujewobr0e7cdpa3/CpW6ckmdQ8YUctPFrM3bq5hHmsapyygowcCleFwUShF/+n58gmGt
 hF0mNnNSJzUTX9J7sd0tf4QUc6EJlAYLmO3y+bEKGHxeNeqlN+XChszVqigSOJIxqoOF
 LBJSWVXB+h0iQhYvxQqVLxBez+iaaGLLJ8/FJmDpWSdB07yIX5zTtrx5KXXoZvFrQcJn PQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu3b8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:12:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FEA61p061423;
        Tue, 15 Mar 2022 14:12:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3030.oracle.com with ESMTP id 3et64tpsvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:12:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cilq8x02GdgkEleAq3SzBkjnaBM2jH0737jvJ6NwomzVY7XGUXheSY/iNXlubA/g0PS9C1AVMBqUuPLXcXJQ99oKGb95+KAgzKFJm0At5w5NP9KmZ3wjq0BdSQYcL6B95aMEiOphhqmtAjx3aGJLCs3NYlObx9kbDyEXS0xBdayo91BWUmVxgG2ocVeJ8Ek82StDze7aeDXq42Id16BgwVi7+l2dgDKPKjsPTsPVO49Vs3M3j0V0getDw8ZX2EStq3khm3rKZpqGHiQ8x42vnyLCujZtZbUofEkcEqBKp5KKaDJ5eKvJ/NVVyNxD0wNvdX5PijVhP/GkULoHwHxGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPN+vFkDMyvCAN7bTfg4QPhSLxRPxYUM83vsIk3gIzQ=;
 b=DfXXsBqktoapyM1Ya85v5TOrk/8U1q/cnQ0O5aIzRPf8EWI0MhV1W7cUgJaA9WHZQJwNFCwIO9WrQF2/R4a+BYVeWKIw3ikvDtyoBQX0UxBAB8YNpWMtQc+Li6YbtlAG03kYdCTSq8ynpvC15UEC6ohM6SSbU/a71ZB0kaJ5CvuHGucniSnZDFkdkl11Y7tosjPSuLciT346ENDnwzGlcEdRrzAFufgUh1QZvJs56lf7TfNKT+roNooS3fJb936EAaTgDzAYlsvRBnd2XSVMp3DNf/PQXKUnv0lMVfMORo2QvInKCb/rDWbi/FREuYt4WRPJmjH9q9GAOX9m+KDVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPN+vFkDMyvCAN7bTfg4QPhSLxRPxYUM83vsIk3gIzQ=;
 b=OpYlfeEztMy5OU0HC3nWtA4LuiuvRN7iTDIS/T2OkckjZ2kNmWeWGCT1AMjcyUo8Dpy5pfqv109NMwBz8WuPSccobgv4mr4g5ZqaMZbadC57lbcQxruUuNTbpt31z3pDZGzyGGVdDR4ZoDWC4kEr8dEbcbKXmUY/o36pCLv2iqE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY4PR1001MB2200.namprd10.prod.outlook.com (2603:10b6:910:3f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 14:12:24 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 14:12:24 +0000
Message-ID: <2ca17bd8-fc81-19e2-7a16-e458ce8a097e@oracle.com>
Date:   Tue, 15 Mar 2022 09:12:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 4/8] crash: generic crash hotplug support
 infrastructure
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <1b7405e4-e6a3-56ff-5068-d598ba2f2b5e@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <1b7405e4-e6a3-56ff-5068-d598ba2f2b5e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::36) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e66d4dc5-a850-4b85-5961-08da068dd403
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2200:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB220025836E42C12DBD00E20797109@CY4PR1001MB2200.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Drcl3Fjctq72U9to8N37jRTsJbMYRP79jxDd5ifeLPR8wLroGUwCVeY/5KqZFPewmdDzx3g2RuUQqqeCmoeqoR7l4G8KlPDtmOah0Tofoi01kOjgQxREhcNgu7uwgtwb001c6gP28t8YwF4SiXurY0DWqzsSrrwhqLhy1aNn6SJAamQJzM1Ag1r9dhw7EiNGNWn4QnY3kDrhB+pxNt+yTV5gCQ6xYUmKqtCXA/lbTv+bSx4Mtn2+ZSvK8twxPX0L0Yiv38Q9soNUKp8hZUkCXtrKdA57xXVeDryRgerNpNYG6Sqw/2zc/Rmp43pD5Gj49EidC4azGjfPPRMDG8kQrqMtluJCFNhNJMfCJdgeZASsJAljQnDjZOcjN5RXKWkNM1PfcL6TONOwMlnCgRDAcsKuE4u0F880190/eB4ecM4lxui6GFgnzdpdI6Rjhw2AcXOvz0vowvLVwR2IurdNJ9AWwt1ov4p3G2LnUef/XajB8K207TPGLJDLWicHR+FiNYjT6xAgWk/fWyo76Jp//UUi8dMG5JsuZCiZ49ADPKSSsmP5bMlt3m9NccLGS2MPrhSvE5QlafWFDXXSU730QCFhDV9MUCHAYXVTNn6HOxZmsaluLSpx3VXvCLP2W87tOFlzom4pHIKPIJEnlljnxcd7VlpepXjj8QmYVfIsVuGfmFwx4I3Ary1ahQy271roa2HhE6ktLnkOKvY+74ztZNMQwr/PVLClwQBnEzI8TqYMpqpFZ76qIn0266wXkbs8APYKmj0JKHqxOaze5CWk9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6486002)(86362001)(31696002)(6512007)(2906002)(107886003)(6666004)(53546011)(7416002)(5660300002)(8936002)(6506007)(186003)(508600001)(2616005)(316002)(38100700002)(66476007)(31686004)(66946007)(66556008)(8676002)(4326008)(36756003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS94VVBGNUdEdTVKUGJYR1BOcTZvWFo2M2Zad2tMV0lhbGFZSU94U0RCeGRG?=
 =?utf-8?B?N2ZpbTJGVkRGRzlCejFXZmVWVUNVZmIzWC9oWXlHMUliV0dOc01wcktoaklV?=
 =?utf-8?B?NDgzYVlVR2FobmhCbE5uN2djWDVlUjVIYVhPbEIxUlJKMzROZ1Iwbk4ybGgz?=
 =?utf-8?B?cENzRi9ZSHhGeCtiOHNnR2N0QTIrTTYwaWl5bkdWSW9hdWhQRjh3VzZLaThK?=
 =?utf-8?B?YmZlaVdGSEwrdEl0bDlYTFltTk53T3MySjFjR0F3dTRQWTh3emFJOVQxR1NZ?=
 =?utf-8?B?eDlodThmNUlpeGxJSU9uWnhDaTFFeW4vcUNzWmNqVFRRdGtFZDNuOHZXT2tx?=
 =?utf-8?B?ODJVZTVPZ0NYTTh1S1J0ekIrMnJYalprSnBEbGFjZUcwejlwRmg1TWRkM08w?=
 =?utf-8?B?Um53UUVEMjJ1VkdzZ2VWa1U1d05BTmtMdzJRZ3NDMHpqYUx3eUw1MkRmQlRO?=
 =?utf-8?B?RkpJRk5JTXNzS05EdnpxV3NobXZyZ25wRGlHOCtpQWpkay9jbjBNbklrdjlv?=
 =?utf-8?B?aHJyV2c3d2UvU1NtaXB5S0ZIb0FwckFiQlR3SFlUbDdHd3B1SVVmQ29XN0dN?=
 =?utf-8?B?U0xuYWppQ2tLM0syQWg5Q0dPVHJuckhnOTV3dW01a3U4RkNxdkZRUytNNDYx?=
 =?utf-8?B?ZGQzV3FROU5JdjhKdGRINXFjYXBudmlSU2sxdFViNHJ6MlJVakM4UjBaVkN1?=
 =?utf-8?B?RUhsZzlKM2RpMit0cWZNSytrL2I3TmNTakg1aGN4WFZyNzBXTzRlbGwyUzN0?=
 =?utf-8?B?YVBXT1gxRThpeTNUeUYxQnpuc3o3N0ZqZU1mbzJISng5UXdhN3k3S2FaVnlT?=
 =?utf-8?B?dWY0MDlEQUVkdUpxd1Z1M2kzdGRYNllOaDlYYlhFV3B2MmRVU2JrZW9DaG1B?=
 =?utf-8?B?RjBPWHJaQnNPMWVhMUFKdmNOTmhVaStBYXJmZnd6QnBqT1BHdFphdEJmVFFW?=
 =?utf-8?B?aCtBemNIK1NiTk92bG95ZDU0SEdPVEdEYnNWcHBBVHRlZGFjM1JpckVZakZv?=
 =?utf-8?B?b0dnT3ljSkpxaUs5NFRnSDNVeCsyREJHWFhHVnE1dVY5QkFlS3lscUxZTUpk?=
 =?utf-8?B?WHAzWmJGR0MvdTQvRTdERVNPMHFrSmZOZy9DRURaODFoSW5jcXBvUC9LZ2dK?=
 =?utf-8?B?M3cwMGZVdjJVS1lVdFhlZzZIYmh6SHZhU25NYmRRUVkwRHV6Z1dkZ1V6QUJq?=
 =?utf-8?B?YzNIY05qQmJ6ZnFqVGZRMXU5Y0hXc0ptamQ1Rk5vbTdWMDNFODMxbmJDR1hY?=
 =?utf-8?B?Zk9KTjRSTkJsVVU3dGxaV01KT3lYMXdydk1Kb2tYSElkays1dno5aFo1WFRQ?=
 =?utf-8?B?bHBKNDg5NktUL01WWDllVlFEUFlUcHJYazdPZFZmUUpoY240MU5sWXhFcE1q?=
 =?utf-8?B?K01ESjdiOHNma0JYVCtSZjRsU08yajZMKzlVSmh5bkVweHRUaitGcTJTTGRh?=
 =?utf-8?B?QVU0dE8rQk96MDE4ZktNSEZBQjdQeTBrMitUUEZIajVKZm11UWtCMkpYQjI5?=
 =?utf-8?B?MkJwek5LOWk2TDJ1RDQydXJXQXRtVlRWOE9lejVlZXFMaEtuZWpXVG1KUkdy?=
 =?utf-8?B?YTE0Mkpnb0hUUXpwcHVWNlNMOE5LTThXRHREZ3ZySEVnQnFOckg0OUFqZVgz?=
 =?utf-8?B?NGhwU0dyWFI1dGM1dWs1SzIvakw5OVhxQXVVWnd2RW4zR1Z0RldKWGtWQWZr?=
 =?utf-8?B?eWtCanNxYmtoR3U2MVRGOGc5TXBvUktJVm1MWGdGazBTY1FzOEJ2a0tZYlll?=
 =?utf-8?B?T2hkcndRNnBZbnNTNnp2c3cxSEVrQjVqRDJ2WDM3OVdJMnR3UWZ0VTl2c3dS?=
 =?utf-8?B?bjRrdzF3aVhHMi84NUFjSVVxUFpkL2FteWpPcU9tQVc3MGljUmxBNFZYWnZh?=
 =?utf-8?B?SndrVTVaWUhaRWJrbEE1ZHd4ZXpzTDg0U2sxS2tENUxnUEFXOWlEYVVaMm0v?=
 =?utf-8?B?c2hlRmRRZ0ZuSzVWUGluN0Exc2xTVlJzekxwcDBreTcxQzV0MFdYV1kxOWtB?=
 =?utf-8?B?NTNpOWpzaHZqL1YyYldNZFZ6YlJOZHhSM2dQMk9Cc0htbDdIWVRTeXNxWGJT?=
 =?utf-8?Q?gJ+18R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66d4dc5-a850-4b85-5961-08da068dd403
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:12:24.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epsy+2RTk4N3dfJ70pULSMXIv18/rlm3dz6uiLZZCi/JfjgzzPJvS9H0nUkJ+HVd1MzQU591tcnMbRyKsBT7MSy9MPXVE/9PRfSEmlHRBuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10286 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150093
X-Proofpoint-GUID: EntR-y-qKqx9AuIAOauicsAm0bZT9cHM
X-Proofpoint-ORIG-GUID: EntR-y-qKqx9AuIAOauicsAm0bZT9cHM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/22 07:08, Sourabh Jain wrote:
> Hello Eric,
> 
> On 03/03/22 21:57, Eric DeVolder wrote:
>> This patch introduces a generic crash hot plug/unplug infrastructure
>> for CPU and memory changes. Upon CPU and memory changes, a generic
>> crash_hotplug_handler() obtains the appropriate lock, does some
>> important house keeping and then dispatches the hot plug/unplug event
>> to the architecture specific arch_crash_hotplug_handler(), and when
>> that handler returns, the lock is released.
>>
>> This patch modifies crash_core.c to implement a subsys_initcall()
>> function that installs handlers for hot plug/unplug events. If CPU
>> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
>> handler for CPU changes. Similarly, if memory hotplug is enabled, then
>> register_memory_notifier() is invoked to install a handler for memory
>> changes. These handlers in turn invoke the common generic handler
>> crash_hotplug_handler().
>>
>> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>> the CPU still shows up in foreach_present_cpu() during the regeneration
>> of the new CPU list, thus the need to explicitly check and exclude the
>> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>>
>> On the memory side, each un/plugged memory block passes through the
>> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
>> memory events, one for each 128MiB memblock.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/kexec.h |  16 +++++++
>>   kernel/crash_core.c   | 108 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 124 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index d7b59248441b..b11d75a6b2bc 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -300,6 +300,13 @@ struct kimage {
>>       /* Information for loading purgatory */
>>       struct purgatory_info purgatory_info;
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +    bool hotplug_event;
>> +    int offlinecpu;
>> +    bool elf_index_valid;
>> +    int elf_index;
> 
> How about keeping an array to track all kexec segment index need to be updated in
> crash hotplug handler.
> 
> struct hp_segment {
>     name;
>     index;
>     is_valid;
>   }
> 
> It will be helpful if architecture need to updated multiple kexec segments  for a hotplug event.
> 
> For example, on PowerPC, we might need to update FDT and elfcorehdr on memory hot plug/unplug.
> 
> Thanks,
> Sourabh Jain

Sourabh,
I'm OK with that. Another idea might be if there are just two, and one of them is elfcorehdr, then 
perhaps in addition to elf_index and elf_index_valid, maybe we add an arch_index and 
arch_index_valid? In the case of PPC, the FDT would be stored in arch_index?

Either way.
Thanks!
eric

> 
> 
>> +#endif
>>   #endif
>>   #ifdef CONFIG_IMA_KEXEC
>> @@ -316,6 +323,15 @@ struct kimage {
>>       unsigned long elf_load_addr;
>>   };
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +    unsigned int hp_action, unsigned long a, unsigned long b);
>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> +
>>   /* kexec interface functions */
>>   extern void machine_kexec(struct kimage *image);
>>   extern int machine_kexec_prepare(struct kimage *image);
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 256cf6db573c..76959d440f71 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -9,12 +9,17 @@
>>   #include <linux/init.h>
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/highmem.h>
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>>   #include <crypto/sha1.h>
>> +#include "kexec_internal.h"
>> +
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>>   size_t vmcoreinfo_size;
>> @@ -491,3 +496,106 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>> +    unsigned int hp_action, unsigned long a, unsigned long b)
>> +{
>> +    pr_warn("crash hp: %s not implemented", __func__);
>> +}
>> +
>> +static void crash_hotplug_handler(unsigned int hp_action,
>> +    unsigned long a, unsigned long b)
>> +{
>> +    /* Obtain lock while changing crash information */
>> +    if (!mutex_trylock(&kexec_mutex))
>> +        return;
>> +
>> +    /* Check kdump is loaded */
>> +    if (kexec_crash_image) {
>> +        pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
>> +            a, b);
>> +
>> +        /* Needed in order for the segments to be updated */
>> +        arch_kexec_unprotect_crashkres();
>> +
>> +        /* Flag to differentiate between normal load and hotplug */
>> +        kexec_crash_image->hotplug_event = true;
>> +
>> +        /* Now invoke arch-specific update handler */
>> +        arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
>> +
>> +        /* No longer handling a hotplug event */
>> +        kexec_crash_image->hotplug_event = false;
>> +
>> +        /* Change back to read-only */
>> +        arch_kexec_protect_crashkres();
>> +    }
>> +
>> +    /* Release lock now that update complete */
>> +    mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +static int crash_memhp_notifier(struct notifier_block *nb,
>> +    unsigned long val, void *v)
>> +{
>> +    struct memory_notify *mhp = v;
>> +    unsigned long start, end;
>> +
>> +    start = mhp->start_pfn << PAGE_SHIFT;
>> +    end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
>> +
>> +    switch (val) {
>> +    case MEM_ONLINE:
>> +        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>> +            start, end-start);
>> +        break;
>> +
>> +    case MEM_OFFLINE:
>> +        crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +            start, end-start);
>> +        break;
>> +    }
>> +    return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +    .notifier_call = crash_memhp_notifier,
>> +    .priority = 0
>> +};
>> +#endif
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +    crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
>> +    return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +    crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
>> +    return 0;
>> +}
>> +#endif
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +    int result = 0;
>> +
>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>> +    register_memory_notifier(&crash_memhp_nb);
>> +#endif
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +    result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +                "crash/cpuhp",
>> +                crash_cpuhp_online, crash_cpuhp_offline);
>> +#endif
>> +
>> +    return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif /* CONFIG_CRASH_HOTPLUG */
