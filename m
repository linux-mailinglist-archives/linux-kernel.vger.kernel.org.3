Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443EB48A09A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbiAJUAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:00:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8220 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243444AbiAJUA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:00:28 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJm3fQ026277;
        Mon, 10 Jan 2022 20:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1/cBwEyxzBAZuYwYak2+WLtK1Vg+5laevXqHW1ewcMg=;
 b=APLQxe3P6w6/mQEHWdNrxYMRr/ZfLHRu0RSD+hVwhHaMQ8TX5Gf4V56bHujC07VFjDou
 pjpFLU1WlXBNKPgdYvVipEKomY1B/Hrk8W28OZX9gzGf7FPIaVlISQcTz39LgU4+q5Lk
 c4zLB1n2SIW9XATkI0uMSXfTU3DQan7mzlLN0YT44pvvpZKniu7Yyrt0b3s/Y5QL4Jpz
 8TcX5p4M6HZ0Uwq0uQ2GVLz0BSGzjLbpGY49kARsLczZtfo1WTmR7VmQprAy9+Y/293Y
 h5UiuD3ODGfSzwPVJsap8Qt/d45RzomnwmGxuRITOmYeERvDFG+PYJhLhkPhNqqONwtr Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nh0v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 20:00:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJtvUf110327;
        Mon, 10 Jan 2022 20:00:02 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by aserp3020.oracle.com with ESMTP id 3df2e3rcyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 20:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksikzuZHEsUjfb5xP3FnY3BuBRpiwDb6f9NgFgKZzAclWg2suMshkUeXgvMhZ0PAsZFd+fyK5hb0Hw1tDWSQVrAaMw0TQ8ChlenTuwZ1/nxGnSYZ7i7m5klouz+NgBcB2EDV6hw/xQv47z/GITKEL0aFpKZq/n8ihOAL/9iNVjkFmqZyzpTVQhqjtmGy4l5lvWKRelu2eXUMwm5Ays/jwkyl6AmZl7xRcLJEvPrZqetsEev6uU/nJlRUW4EyO4V8i60CQqGxXIsigozlH1S2+3ESCwH9a2OHa8NSG3LtkrnIehgYCWCc74T3LYefgv5c4GEUrYLHkw/EaSeV+CpH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/cBwEyxzBAZuYwYak2+WLtK1Vg+5laevXqHW1ewcMg=;
 b=d7KFNsbOUdPW/7tKLkZRiui3WBa6paCUZBGWB2wU5N+bKsICuc4eljII5wmsghd/tu/Otvh/0WWjB7fDxNRRlVP2wf4n85YdcRMeGjBPECua1TlC/P9GKSM1S0PbrCTV2eJEVTDjmzUelyBZIJszW/KS01JNchZbP9Pb4dex7ZETe59SYW/YMgGL9ihQrQaVFt1Zpln8EawQiN8sw4YxRAAuYPej1FmNirv5wSWoDD3l1zAON0htxrU2hFsR6B8OEcf415oergmQWnUIi+qLwFveOitvatrXnE+FYeM8aNaEi1mrU599iqSfolO3IOIZuv2P3UOyTut98zAwU8qz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/cBwEyxzBAZuYwYak2+WLtK1Vg+5laevXqHW1ewcMg=;
 b=iRotXC3yqSJWF9krjCQ2GGO1SdRcRbVJ7ERtQY1A1NDOJqSbZ7gMN/DNVBnSJXlwGLet6xTUHEuMJaFW3WecGXkeM5TzegjiKUgzrkVjs40PpL6epLacK/kJwZBF5KLqIofOoQiiQ8j0BF15iDw123GuCrzX/61mExUk3BePnA0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO1PR10MB4737.namprd10.prod.outlook.com (2603:10b6:303:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 20:00:00 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 20:00:00 +0000
Message-ID: <0da0387e-d16e-1e04-4260-46e3da46ba7a@oracle.com>
Date:   Mon, 10 Jan 2022 13:59:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 0/6] crash: Kernel handling of CPU and memory hot un/plug
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20211207195204.1582-1-eric.devolder@oracle.com>
 <d2d301e2-62df-512d-058a-a9b890e12dfb@oracle.com>
 <20220110080456.GG2731@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220110080456.GG2731@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0139.namprd11.prod.outlook.com
 (2603:10b6:806:131::24) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51e880f8-995e-415e-4e74-08d9d473c885
X-MS-TrafficTypeDiagnostic: CO1PR10MB4737:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4737DD3B95FF06B72D17751C97509@CO1PR10MB4737.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CZI7RL9UqSJnDSIKW2lh6RJWe0LGP2cfNd5L6CfFWcMBFIpfFR0VuVur0PTZbsSsuuG9HKp2XYD48yHFCX+NK8iZ5sZp6BXMrisSviH6oGC5cYZPWF2VT4cOu2x4ww57gfX0vz4z0SQoIJWcbj/SEOdUBwMPAxepxD6MCKHR1ohbAQOtfHDKwlOyqkOpqQZN7oUT1nsiwN9LXu10yLaFKZvTyrYBhCzaamoYqXLWo5hpK+m4YmZn5Xprotj6cmw/Srh5K0TZ/GD7N2l1tYvvXrdWoINFLoVDO5Op+6tDnM0bUmW6ee5q80C3U1ILdudo9EsjBb3/wnID//reQiSoo2D//QsNOh1fiea/dNQVR36cBA3o+cPeazzHDUdAOy2NPK7ruG9H60sLTmmSF2hlm0Yzc3l9aV7bGxwqCpJHZ56vYb+ISGSq159mqqMWLbLMDxVhZt64C05csm4f+WKjKIpCnMNj7ga5DvQ8CXwP/5ujK/GMzXa6bW0lUd23IlakZ2lvY23GnhIDgen20e2xPGNKMxBFGlTnTMcL6OXAHdAZkzQ4ZaVY1l+YWnUnt+oEk6K2NQ8LLxdzDHotQdIAsybIHOkH/5981OgaLANRvZpwDVRGS2xtSw0aPum+nbeqnWzxphM9u/+xm9oyNTIt5WDYM5UZJfZNT1p0YFyXp/yDci4i6SHPIE16wqX4lx/lmK7XFyK8QyvDH0+PYpzb5zN3XtDK6ShwNaNKVPI4K0t8XI/yljYTl+QYN+i48pW3cKN6tGUjM2Pxle6vZH3MFORlYhVUZ18wGE7tdYYzriexRae7dSd6454q2vYZiqPygVnPSFoBshRMAsGyjGI2+7qZz5ot4o05CQO2WY+8Ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(7416002)(508600001)(31696002)(6512007)(8676002)(5660300002)(36756003)(83380400001)(2616005)(4326008)(86362001)(107886003)(966005)(8936002)(66476007)(6666004)(66946007)(316002)(2906002)(6486002)(53546011)(6916009)(66556008)(38100700002)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9hcG5SZkluYzJSSC94QTh2T3hjSlQxY2FRU2FLeUdPNUI5UDZCL21yQWFl?=
 =?utf-8?B?SERMcG1UNkp4cDE4VGd6cDRUdVArYXNwc2NDM2ZUY3ZWaTIvVHo5N1NwbTdW?=
 =?utf-8?B?dzVFNVhlaWpiUm0zeGRSTFE2SXM3NVlVWDVXREo3UXlZNk8wYVhoYU9HS1J1?=
 =?utf-8?B?TjVXaHZOTyt6MDdsWUpUaVNJU3dINlhKc1ZmdldScS9naEl1eUwvdmcrUUZs?=
 =?utf-8?B?MlNoNlE1OVVpNGp3V1pUSkhkNmpSNFY0bmlHaEhOd2JrZlBWZGpIY0RvUHRD?=
 =?utf-8?B?TEk3Zi9nbGZSdXlmbCtid3c1V2lIRmNTQkNEbVdXUy9aejg1cnRRY0hiQm9a?=
 =?utf-8?B?VVZ3dVdtUHJoZ1FqRk5UWE9DbC9FTEgxc2dqekE3KzdnOHEyelNNcG1QMWVC?=
 =?utf-8?B?cXdqUGd5U1diRzdQcUtScDZsZE9QUC9rZWNjMi9HL1ZQYVFBL2l2UXFJc2RV?=
 =?utf-8?B?T2ZHN0R1YnpTSjV3WDJTeWJUaUtGK2xPYzAxYzVTc1NIZkwvUmk2UkprL2J6?=
 =?utf-8?B?K01JYUdpZkFwelFoenZvTGNxVTZQa3IxSzBmQWdIenF3Sng4R2JpZEd0cCt6?=
 =?utf-8?B?bk1aTklLMXBJb2loai9ubllzNnMrMUE2M1F2cDBZKzd6NkduU2JEdWhzV2lF?=
 =?utf-8?B?ZThWZEtNdEZZaU9Ca0M5K0V5OGw3eUFOeEc1S0FxQVIwZHJ0ejJaRnZ1bWlS?=
 =?utf-8?B?WUtzWlNHWXpvc0hjeFpMRnNZcFlmcXhpQVp0K05mREY1TTFWWlEwL1YxbitB?=
 =?utf-8?B?bWR5VEloczR2cGF2TnFNaitGQUdEcE9hTEk5WUlUNXB2UFZOQThrN2xkeTNx?=
 =?utf-8?B?ZVZTL0VVTndaWFY4QkZJS0YrT3Jqa1JMaXVGVFBSS0l5dlA2VEl2UE0wcDhq?=
 =?utf-8?B?TDRwZmdMU21UQmwwbngveUFGOC9PNTlPdksyQ3R1bmVrMGFZSDhkMGNlbWJW?=
 =?utf-8?B?Mis1MUVraXRJdFpJUlFpSWI3QTY3Z2lHWTJacC9lTU1tZndZTytNMk5td0dI?=
 =?utf-8?B?alBRdkkxcmdOSXlDYmlFNmFmbnE3RkUwa2pxYWJLdmlybktLdDZYOWMvL3Ax?=
 =?utf-8?B?dy9laFovZEVVem9rTlBDTERsT3dySDFEeEt1UGthQjNXNXF4Qm1BSHppZGVZ?=
 =?utf-8?B?eUI2bVlIbWp5N1NiS1ZrVjFlSDB5aFVDSGc3YjdnY3BWQmlLNDgrWGxUOUsz?=
 =?utf-8?B?WGlwUHJqKzEvcHEzVzVuSTc4Zk1tZFoxSjdma1ZyQTlVaEx2Q2NFZGp5MEZi?=
 =?utf-8?B?TXZMbC96YkpvaFhZajN1Zko2VG9mbDVVVjQ2MDUyMnc4aHVxNUw4dWZuYk5m?=
 =?utf-8?B?bjhJbzcvelFXN2ZxQzI0K0ljTGVraTUrbk1pdFhDeC85TStNNWQzY0dtWWhv?=
 =?utf-8?B?SmhCQjlPTDJCcEp3WllUZlNURENZTG5aU1I0MjNYdVJWbVFGblhXSkdsbUNq?=
 =?utf-8?B?MnltS2hxSFl2RCtnaktNWEtlSU1TRHZYTVNMK1B4clZiSFp2U28zWTBtWXBo?=
 =?utf-8?B?NjZzRnNyRE5PSDhNU1p0MW5Vc0tXcWY0Mm5PdzhpYnJURzhVNE9pN2lCZlBN?=
 =?utf-8?B?ZTJzb012MWRmTkpHMjJ5d1JlVWoxV290U2lzZmtEaTFCU2dDZm00U3d1bHlx?=
 =?utf-8?B?VGFXYnpockhmaTEwZENobXlpaytnbHZTS0ZpRGQvQVlya0tidkhSVUhuU0ov?=
 =?utf-8?B?NUpvdmYvUE4vZEZTdUQ4bFZGTkJ4L1g3Q3k0U0NtQzI2MkNBZlR2Q3Y3Rldu?=
 =?utf-8?B?eUYxbS9XZ1RNMXkzM3JyY0ZRMU01eTVMQ2Nqc0pHT0dvc1hROElacUIxdUkz?=
 =?utf-8?B?WVNONTFLUk9RbUh4bDQ2aXpIUHkxUkVEQzRjLzBEWFpwcjZ3NjJadmNDU2JD?=
 =?utf-8?B?eUt2RVVSaTZyS3M2Vlh5Uk9JVVNFTzdTK1ZmSWpCdjhYR0E0eGpiMkgzNnho?=
 =?utf-8?B?aUtNK0VxU3dFZzE4Y1Qzc1JZS1B1d2xBNldmenp0ZUpIK2xSa25sZEk2WDRT?=
 =?utf-8?B?L0dRclVDS0JTRzFUS3U3UXN1N1JlQWxlUUFIVEltQXFKcm0xay9QSmhoeUFE?=
 =?utf-8?B?QUlFWUFuajN5QWo2Z2w3czBiZGN3YjVpZkJGN2luejFySjJlR1hDU0dpcXR1?=
 =?utf-8?B?TXIyTDBmYkxQQ3Y4ZHlnWkgxcUYyeXNhY3NCNU9EQlhGdkVkOEhibXVmTmpP?=
 =?utf-8?B?K0t5cHFMSHQvZnQ2Z3VtK0txUGJxRWFiVXAzQm5VOTRDcGZYdlNieFdvcFB3?=
 =?utf-8?B?b3dlYWVHYy8wVFNJb1dGZUo4c1RSNWFNWGl6S1lTbUhiVjB5VU9ab0RvdTJS?=
 =?utf-8?Q?vJEjWltt8V91ZbEdOg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e880f8-995e-415e-4e74-08d9d473c885
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 20:00:00.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGHRgKChCcvZ7PIHGgc4yG03+Qbunq6BNQdBDTMu7OcBC8GXqdbnQNlb8kBuJ1GuLDFMYp2XUFnwmKJe4YzQLLDMmJIsholBpOVvNDcqW8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4737
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100136
X-Proofpoint-GUID: mbQ7h5s_ZXPA-bIcuip8sNk_54Tih1pO
X-Proofpoint-ORIG-GUID: mbQ7h5s_ZXPA-bIcuip8sNk_54Tih1pO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/22 02:04, Baoquan He wrote:
> Hi Eric,
> 
> On 01/05/22 at 08:25am, Eric DeVolder wrote:
>> Nudge...
>>
>> Fwiw, below is a working changeset to kexec userspace utility that allows the kexec_load
>> path to work similarly to the kexec_file_load path of this RFC. With both the following
>> userspace kexec patch and this RFC, both kexec_load and kexec_file_load work with changes
>> due to hotplug *without* unloading-then-reloading the kdump/capture kernel.
> 
> Thanks for taking a try on that, and sorry for late response because of
> somethings at hand.
> 
> I will review this v2 round. When applying them, I encountered some
> conflict, could you please rebase these on the ltest 5.16 and send me
> a tar ball privately, or a github branch is also welcome. Thanks in
> advance.

Baoquan, thank you for your time and interest on this patch.
I posted as v3 as I incorporated changes from David Hildenbrand and some other minor tweaks.
Regards,
eric

> 
> 
> Thanks
> Baoquan
> 
>>
>> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
>> index 9826f6d..06adb7e 100644
>> --- a/kexec/arch/i386/crashdump-x86.c
>> +++ b/kexec/arch/i386/crashdump-x86.c
>> @@ -48,6 +48,7 @@
>>   #include <x86/x86-linux.h>
>>
>>   extern struct arch_options_t arch_options;
>> +extern unsigned long long hotplug_size;
>>
>>   static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>>   				  struct crash_elf_info *elf_info)
>> @@ -975,6 +976,13 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>>   	} else {
>>   		memsz = bufsz;
>>   	}
>> +
>> +    /* If hotplug support enabled, use that size */
>> +    if (hotplug_size) {
>> +        memsz = hotplug_size;
>> +    }
>> +
>> +    info->elfcorehdr =
>>   	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>>   							max_addr, -1);
>>   	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>> diff --git a/kexec/kexec.c b/kexec/kexec.c
>> index f63b36b..9569d9a 100644
>> --- a/kexec/kexec.c
>> +++ b/kexec/kexec.c
>> @@ -58,6 +58,7 @@
>>
>>   unsigned long long mem_min = 0;
>>   unsigned long long mem_max = ULONG_MAX;
>> +unsigned long long hotplug_size = 0;
>>   static unsigned long kexec_flags = 0;
>>   /* Flags for kexec file (fd) based syscall */
>>   static unsigned long kexec_file_flags = 0;
>> @@ -672,6 +673,12 @@ static void update_purgatory(struct kexec_info *info)
>>   		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
>>   			continue;
>>   		}
>> +        /* Don't include elfcorehdr in the checksum, if hotplug
>> +         * support enabled.
>> +         */
>> +        if (hotplug_size && (info->segment[i].mem == (void *)info->elfcorehdr)) {
>> +			continue;
>> +		}
>>   		sha256_update(&ctx, info->segment[i].buf,
>>   			      info->segment[i].bufsz);
>>   		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
>> @@ -1504,6 +1511,17 @@ int main(int argc, char *argv[])
>>   		case OPT_PRINT_CKR_SIZE:
>>   			print_crashkernel_region_size();
>>   			return 0;
>> +		case OPT_HOTPLUG_SIZE:
>> +            /* Reserved the specified size for hotplug growth */
>> +			hotplug_size = strtoul(optarg, &endptr, 0);
>> +			if (*endptr) {
>> +				fprintf(stderr,
>> +					"Bad option value in --hotplug-size=%s\n",
>> +					optarg);
>> +				usage();
>> +				return 1;
>> +			}
>> +			break;
>>   		default:
>>   			break;
>>   		}
>> diff --git a/kexec/kexec.h b/kexec/kexec.h
>> index 595dd68..b30dda4 100644
>> --- a/kexec/kexec.h
>> +++ b/kexec/kexec.h
>> @@ -169,6 +169,7 @@ struct kexec_info {
>>   	int command_line_len;
>>
>>   	int skip_checks;
>> +    unsigned long elfcorehdr;
>>   };
>>
>>   struct arch_map_entry {
>> @@ -231,7 +232,8 @@ extern int file_types;
>>   #define OPT_PRINT_CKR_SIZE	262
>>   #define OPT_LOAD_LIVE_UPDATE	263
>>   #define OPT_EXEC_LIVE_UPDATE	264
>> -#define OPT_MAX			265
>> +#define OPT_HOTPLUG_SIZE	265
>> +#define OPT_MAX			266
>>   #define KEXEC_OPTIONS \
>>   	{ "help",		0, 0, OPT_HELP }, \
>>   	{ "version",		0, 0, OPT_VERSION }, \
>> @@ -258,6 +260,7 @@ extern int file_types;
>>   	{ "debug",		0, 0, OPT_DEBUG }, \
>>   	{ "status",		0, 0, OPT_STATUS }, \
>>   	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
>> +	{ "hotplug-size",     2, 0, OPT_HOTPLUG_SIZE }, \
>>
>>   #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
>>
>>
>>
>> On 12/7/21 13:51, Eric DeVolder wrote:
>>> When the kdump service is loaded, if a CPU or memory is hot
>>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>>> and memory in the system, must also be updated, else the resulting
>>> vmcore is inaccurate (eg. missing either CPU context or memory
>>> regions).
>>>
>>> The current solution utilizes udev to initiate an unload-then-reload
>>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>>> outlined the significant performance problems related to offloading
>>> this activity to userspace.
>>>
>>> This patchset introduces a generic crash hot un/plug handler that
>>> registers with the CPU and memory notifiers. Upon CPU or memory
>>> changes, this generic handler is invoked and performs important
>>> housekeeping, for example obtaining the appropriate lock, and then
>>> invokes an architecture specific handler to do the appropriate
>>> updates.
>>>
>>> In the case of x86_64, the arch specific handler generates a new
>>> elfcorehdr, and overwrites the old one in memory. No involvement
>>> with userspace needed.
>>>
>>> To realize the benefits/test this patchset, one must make a couple
>>> of minor changes to userspace:
>>>
>>>    - Disable the udev rule for updating kdump on hot un/plug changes
>>>      Eg. on RHEL: rm -f /usr/lib/udev/rules.d/98-kexec.rules
>>>      or other technique to neuter the rule.
>>>
>>>    - Change to the kexec_file_load for loading the kdump kernel:
>>>      Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>>>       standard_kexec_args="-p -d -s"
>>>      which adds the -s to select kexec_file_load syscall.
>>>
>>> This patchset supports kexec_load with a modified kexec userspace
>>> utility, on which I am current working to provide separately.
>>>
>>> Regards,
>>> eric
>>> ---
>>> RFC v2: 7dec2021
>>>    - Acting upon Baoquan He suggestion of removing elfcorehdr from
>>>      the purgatory list of segments, removed purgatory code from
>>>      patchset, and it is signficiantly simpler now.
>>>
>>> RFC v1: 18nov2021
>>>    https://lkml.org/lkml/2021/11/18/845
>>>    - working patchset demonstrating kernel handling of hotplug
>>>      updates to x86 elfcorehdr for kexec_file_load
>>>
>>> RFC: 14dec2020
>>>    https://lkml.org/lkml/2020/12/14/532
>>>    - proposed concept of allowing kernel to handle hotplug update
>>>      of elfcorehdr
>>> ---
>>>
>>>
>>> Eric DeVolder (6):
>>>     crash: fix minor typo/bug in debug message
>>>     crash hp: Introduce CRASH_HOTPLUG configuration options
>>>     crash hp: definitions and prototype changes
>>>     crash hp: generic crash hotplug support infrastructure
>>>     crash hp: kexec_file changes for crash hotplug support
>>>     crash hp: Add x86 crash hotplug support
>>>
>>>    arch/x86/Kconfig        |  26 ++++++++
>>>    arch/x86/kernel/crash.c | 140 +++++++++++++++++++++++++++++++++++++++-
>>>    include/linux/kexec.h   |  21 +++++-
>>>    kernel/crash_core.c     | 118 +++++++++++++++++++++++++++++++++
>>>    kernel/kexec_file.c     |  15 ++++-
>>>    5 files changed, 314 insertions(+), 6 deletions(-)
>>>
>>
> 
