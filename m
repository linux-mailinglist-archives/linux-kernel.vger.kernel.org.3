Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2749D0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbiAZRcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:32:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37166 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243759AbiAZRcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:32:50 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QFoiVC029667;
        Wed, 26 Jan 2022 17:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UD3bb4+8DgrI5m6A4dc0RXugjId/dI43wWCjREiJYtw=;
 b=lnBapU7K/LbKCdnvChPmThKElPZPwqRh8GhAPS+j5reij7/fk0M1n/SbxPS+QKEXiElI
 E2VFnrQETLGHoAKaDY0Ucr//vm2mY0YZ7A+xZ2ZQHZTWjDLgasfJuaaM0deA0L2WT6PV
 K5LBCk1sQv3Mmx7BuAzwKNWr07s2FdRTCTDGice2ub2s0WQODeyqFM4oCqL3rA51TZfc
 NDNoDfp23wfshby5Fku3t7PdN2pryPwUpIeE14bUrA4SnPYeCzV3Yn5N+YbcuRJUAnkz
 IBv9G+AFctaAlb/E7V5h9CUdPhFp23sWSQnsUlMT2AAdJ4MBueqkF3L/pATiM6pPT/rC 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfpk2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:32:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QHVK5o145810;
        Wed, 26 Jan 2022 17:32:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3030.oracle.com with ESMTP id 3dr7yj6jwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:32:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOmAQucZP2LcsYJgo4hT91aCmIyEB6S4YhKCiGCe55uiGQU+tshdEXWghUSGk+V5h6ZbPGauYpGkZFSHDz79Kk6tg5Fn31wFQyxfzzHN8Z3MH9zTHcJT1bM8zyj2gdxVH7e7gSlDZz7xtVp6T9Dyv/edsOsIzqOtCvW2FgrovVbyYuaLd4OJc6poifRkvcTcwsEfwQRH3VSiiCHXpAdoPW/mZK2QoXnqu9kJTvd9l6b3of6ODqSYRz/I2VbmmfmBiwUqksN6z/AzW83OTXRcoAgzESQP8dOwBmzlyVrf78UsSxIxHM7yUOTyLRfPHRv2l6pT01jD19H5/h9O1EGwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD3bb4+8DgrI5m6A4dc0RXugjId/dI43wWCjREiJYtw=;
 b=WtvcxJOI6dx3C/Gevc33plZ/LBRNvOQHO7nCk4mCUFsKa4MmilLWawEwWoBob7C60ydU8Y4FgVdHDF6/GtHQfxQ/fLYPpWzbdxOIpwWFVTPABODekXLT2el31xhU1yYGWVU3UHGyz3BzBqWUg3EsCHywS0iBV/ViFSInZEq6hVNHhNzd+BO2OHEw0zt3EuJmNwJUiCmayQndLzSSAungn6HEwUQhm6TBgbKMTLVHnFPHP8W4M//PiJwB14oMXdnODlf3KNNv9w/uzpyLGxJLdQDEsd2SkyBNbTVkkh6NJ+fFj9Xjo3rX0mBmubCPqz5TRJQfwUHxe6CtumsHPtIa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD3bb4+8DgrI5m6A4dc0RXugjId/dI43wWCjREiJYtw=;
 b=DCFrvCMZPR6XCsPklf4JEnCCdIznSQOBOFsI4duKwxsjvswxPdOmy1sxsKXWXqlxUEAIW2bCzT/EYaCRLbW3YpKqSh/sn5ZHN0mC5Pl1E8wPmuQnsYgAn1jw78ckQFozvsdxMQp3kfQ6QVq/GHJH0xFR/RvNt5sjJ0OBXDxrYU4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR1001MB2175.namprd10.prod.outlook.com (2603:10b6:301:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 17:32:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%4]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 17:32:17 +0000
Message-ID: <cf834659-3d8c-7ab5-ccd4-c877b0b9a2f0@oracle.com>
Date:   Wed, 26 Jan 2022 11:32:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 6/6] crash hp: Add x86 crash hotplug support
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
 <20220110195727.1682-7-eric.devolder@oracle.com>
 <20220119102323.GB6349@MiWiFi-R3L-srv>
 <280485c9-4612-892c-0e3e-9e8b09e60cf9@oracle.com>
 <20220126091243.GB6588@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220126091243.GB6588@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY4PR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:903:77::24) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c739450a-c3bb-49b1-e525-08d9e0f1cc2a
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2175:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB217571191E5D1FE10F73A3DA97209@MWHPR1001MB2175.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXhBmXo7o1irXNdJfMEpPjmQVEMjj3NaWaz5HBYU/P9AsJzG+hkm+sDTYm9jYOKeBopnLzLNnTpLLxmhbkXS5nbO1zcvBogmCbiI9UlO1dBfWXSDlj9fl8FOHDM2WUGm+yylw0+2aUI9uM5q86g4PJNZJouVjHXZtD9MEEV1rrwODvzNuD/BFouCEzsZclzqHnco5WybsPJQtw8f8jdmzzuRSaTfonS4Si8Sifyu8XS5ep4zaAsQiEO9eyqbbSNmo2uN9Z7fbzFMHrQOuFvKctS/qnfFK0cjr5uPXkitImBDLcZQAYjftKEPR+SXfgTUEk9yq5poYFy+A5p7wM3GDZ62087KVL00jm0QNH5AnCGSlvlxUdJg2YpvUHxB+2+8M0BXiL/79u8htl1tQhsd91isAxLAz5gdh0q3zoXc3N2YShc5obqHKrb9cT1w0fv3pajE+X5M8KeWZ/shenrPyiJuavwU0zfNUS1Q7+fgw87mQwLJaSRZS4ykX+38KVJSceP5r00FygMmYOwvLBB9UCkI4KYzSonT8LMAXOFjAFMZ3op3JLhiXCAipOhKFXI6zG3h5eILsR2subHpDf2qhaaflGP9hgT30/0uYBbf4S7Ph5EdRL60u68nCMHRJrLCx3k9aSr31VBokWQ8Ao5eHQCPouwbXEG4zrEm4U7DbtDFXXlhB0h38UB5Idt04lxnBoLVP7K+SyM2lutsXBTPJhun2FkaGEJEYEZq9l5QVF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(6916009)(7416002)(2906002)(5660300002)(31686004)(36756003)(6512007)(107886003)(6486002)(83380400001)(2616005)(6666004)(86362001)(53546011)(6506007)(186003)(508600001)(66476007)(8676002)(8936002)(316002)(38100700002)(31696002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHQ3aU1Yd29EclhsNC9yZ0pJVHpqRkdZNy9XVlAraStDTThpUUFvT0p0U1pi?=
 =?utf-8?B?bFRsUGd5VEpiS0trRnp2eEtYaDVaNkJmd3gvdHE0UWtjNFc0TFJkc2w3cUk4?=
 =?utf-8?B?MXFseXJKVytQOEx6WnkwYldiV3ZNVFFzOXlOc0NvK0xjK1dQRVNaVFAzK3ZV?=
 =?utf-8?B?bFBQSG1Ya2VHbTUwTy8yOVV5dTBoUlJUVklvZTlEMWxoZVQ2T0tsdEYvbExZ?=
 =?utf-8?B?WER5akQxQlFLbzBqem1wOCtCVlRPWndpMFVSMHJCb3dHUmpXSHJISzlMR0Ir?=
 =?utf-8?B?Q0djOE5RZTY0RlMyTWJxYjh0SGZDMHMvYzhINGxDSzBJRWFXaE5kNzFNcnU3?=
 =?utf-8?B?NWE2a3c4R2NJRUlTL0puaEV5MThEUDRwd0ZobkphdFBTY1JrT3hmUWFKR0VQ?=
 =?utf-8?B?K3JCSXNZUExIbTdlUlBINUpiRi8rR1pJdDc0Z1BpaDNQL0NrWXh4V00zOG5L?=
 =?utf-8?B?LzVKdEpwY2hOcnlicW0yd3IramlMUWNuamtWWmY0ZEVHUUh6d0hLNFQzY1c5?=
 =?utf-8?B?U1VRYjBDalpTWUcySCtnTWR1TlNXRU5FU2tsbU5RN0ZJQlVrOEZWMFRlNWtv?=
 =?utf-8?B?ckdaakUyT1ZQbWZnSlZ3MnJzNU1xRHJzdU1zaEUrQ0Zhck9YMVVmeWZNYkxy?=
 =?utf-8?B?VXlEajBucGEzNi8yeHRRa2JHdkhjdWVGZER5N0tTTDk0RzA4bWhRT0crc3hs?=
 =?utf-8?B?OGdZLzBLZ2VDZW5tMW5DWnJvVGMwc1FVMFFvT1RqdE05endTd2laL0d6azlx?=
 =?utf-8?B?VDA5RHlGYld1eDJkcDhNZkRUbFJnMFZBaXM3NjJTRzBvK0NRbkJ3OWJnbTdt?=
 =?utf-8?B?MHdKWVBOL1ZIS3lvUGl3L0cveDdhQk9sSXl1VnpSVnkvNTVhSnBSYW1mWEt3?=
 =?utf-8?B?K3FPTlR5aDc3WGlWaTJ0bC9qWDRTbUJCMm5najlyeFRQSnUwTFRkWkJZengv?=
 =?utf-8?B?Rm5KRDd1bFI2T0NsV0FIQnFkRnd2WWxVbC8zNWNpNGN2VTNMVjJMQnRkc2NR?=
 =?utf-8?B?S3lZOU9kWnFZZEViUEpGYTl5cUNxM0tuRGtBQ3hBc09iUUlkRWhweEdtSitv?=
 =?utf-8?B?UzRiLzFPR2o4cVhrY2w5aWUwTFRvVzN3azBMd082K1hrQ2pxSXh2OUJ4VHQ4?=
 =?utf-8?B?b0tNVFM4ZUtrTXJiMytaendrQXVuUGsvS3Y5U243QkQ3QTM4ME0zTlVpMDlK?=
 =?utf-8?B?S3RjU2pZeWxOOVhxSU1VVHlCeE1SUkFSNG0wLy8xZWxOSG1NWXlNR1dac1h6?=
 =?utf-8?B?akIyQWNVVFowY3Nob1QxM3dsRFA0YWlVbUlBY08xT3kvcmN4dFowRDYzdTZ6?=
 =?utf-8?B?SUszSEttZUFDNTRKS25KeE54bGQ1SDZOWTdFT1ZZVTd2NDJsQ3crUkRhY3JO?=
 =?utf-8?B?aS9zOERjcWlnRlRPMUN6VW1GdzdjbW5tMEc1UThaN1JxcnZLVlJTV1Q1NHdI?=
 =?utf-8?B?QU5QTldybE9JRUM5bThQVVJqTmh1aUtZMG9tV0hnZ2Rvc1hOd1hRNEJhTFh4?=
 =?utf-8?B?am1XbVRVbGJJVXVrU2VtTG9ldlJOWHhwVm9DRG5CcGhVV0ZCT21jNjdWN1gr?=
 =?utf-8?B?RXVhelArbGNSYlhCZEZRM0NleU1FbE00TDcrZ2lKV21haWRGZkpjNTJqRWs4?=
 =?utf-8?B?OHpnWllhd2dLL1ptZ2J1STllSnh2UW5TM3hBbS8rbGltakxEelBDVkxWZ2JH?=
 =?utf-8?B?Rkc3SForYVNzbmZxM3VtY2szYkhxMnVXMHFKZTFmcXBtZnd4V2pOaE5PSUdo?=
 =?utf-8?B?Sms3OUgreTZ4QWlCRExIbG5rWFVjYUl1OGUyUWpDRXlHZFdBUXdPenR4Vyt3?=
 =?utf-8?B?S1dLejVJWjNIQU5jRlp6bWdnMzZmR0lZTHNzMEhMVkJBMUZXMVAxbWp4REpy?=
 =?utf-8?B?TFJFYlhUWTlmckRrdWNmRDMyQW9OYkVvc2c5SzZEZnVpY0toSVN4QnVnemt1?=
 =?utf-8?B?K3dQbkg4YXlkcFEyb1p3T3lyam1WOUV3UzJXRGd5Z0NQZTNJZ2xFSzdTVUhQ?=
 =?utf-8?B?MmIxaDhHV2ZUUzFZeEhGeGhqeTZmblUwdFRqQ09ObnljZDEwUk9nUHFadktO?=
 =?utf-8?B?SE9aRFoyS1dmMUdEVkdlM1dTOXIrb09heUdzZ3MxQW80MG9iNFhMVVZsZzlM?=
 =?utf-8?B?bkh2WFd1cmU4MHpHbTlhWnROUlhYRjh1R08rOU1NSkQwcVhUdlZhckIyNEFj?=
 =?utf-8?B?b3kwOHpTd1hZNFVUMnVYUmpJMU94b3J1RFpHNGNwK1pZTzBXbURET3h6dFJO?=
 =?utf-8?B?eFhMdm5VQjMvTU9HOWNuZysrUWV5VC9OcFpkV293NFQrRkQwNFNTVWV5bnBr?=
 =?utf-8?Q?WnyFDjkREAMgO6ZfeA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c739450a-c3bb-49b1-e525-08d9e0f1cc2a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 17:32:16.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bArVa8F7lAlzDAq0EYzIyWtUOZ+4J7kvxInl3Ix+CgWJDBrpaoVCEWURQT06ZjBqK1yFIbt5DAYdcvsYKPCrE2tLMXn7UxOrYT6MTMRwsn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2175
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260107
X-Proofpoint-GUID: P063KoPtxvQ_It2bK1jY-sDi9dXHHyv8
X-Proofpoint-ORIG-GUID: P063KoPtxvQ_It2bK1jY-sDi9dXHHyv8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,
Thanks for looking at this! See inline response below.
eric

On 1/26/22 03:12, Baoquan He wrote:
> On 01/21/22 at 08:06am, Eric DeVolder wrote:
> ......
>>>>    arch/x86/kernel/crash.c | 138 +++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 137 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>> index 9730c88530fc..d185137b33d4 100644
>>>> --- a/arch/x86/kernel/crash.c
>>>> +++ b/arch/x86/kernel/crash.c
>>>> @@ -25,6 +25,7 @@
>>>>    #include <linux/slab.h>
>>>>    #include <linux/vmalloc.h>
>>>>    #include <linux/memblock.h>
>>>> +#include <linux/highmem.h>
>>>>    #include <asm/processor.h>
>>>>    #include <asm/hardirq.h>
>>>> @@ -265,7 +266,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>>>>    		goto out;
>>>>    	/* By default prepare 64bit headers */
>>>> -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
>>>> +	ret =  crash_prepare_elf64_headers(image, cmem,
>>>> +				IS_ENABLED(CONFIG_X86_64), addr, sz);
>>>>    out:
>>>>    	vfree(cmem);
>>>> @@ -397,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>>>    	image->elf_headers = kbuf.buffer;
>>>>    	image->elf_headers_sz = kbuf.bufsz;
>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>>>> +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
>>>
>>> I would define a default value for the size, meantime provide a Kconfig
>>> option to allow user to customize.
>>
>> In patch 2/6 of this series, "crash hp: Introduce CRASH_HOTPLUG
>> configuration options", I provide the following:
>>
>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>> +   depends on CRASH_HOTPLUG
>> +   int
>> +   default 131072
>> +   help
>> +     Specify the maximum size of the elfcorehdr buffer/segment.
>>
>> which defines a default value of 128KiB, and can be overriden at configure time.
>>
>> Are you asking for a different technique?
> 
> I thought to define a global variable, like
> 
> /* Defaults to ahve 128K elfcorehdr buffer which contains 2048 entries.*/
> unsigned long crash_hotplug_elfcorehdr_size = 0x20000;
> 
> Then initialize it in crash_hotplug_init() if CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ
> is enabled.
> 
> Seems using the config directly is also OK. Let's keep it and see if
> other people have comment.

OK, I will leave alone for the time being.

> 
>>
>>>
>>>> +	/* For marking as usable to crash kernel */
>>>> +	image->elf_headers_sz = kbuf.memsz;
>>>> +	/* Record the index of the elfcorehdr segment */
>>>> +	image->elf_index = image->nr_segments;
>>>> +	image->elf_index_valid = true;
>>>> +#else
>>>>    	kbuf.memsz = kbuf.bufsz;
>>>> +#endif
>>>>    	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>>>    	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>>>    	ret = kexec_add_buffer(&kbuf);
>>>> @@ -412,3 +424,127 @@ int crash_load_segments(struct kimage *image)
>>>>    	return ret;
>>>>    }
>>>>    #endif /* CONFIG_KEXEC_FILE */
>>>> +
>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>
>>> These two helper function should be carved out into a separate patch as
>>> a preparatory one. I am considering how to rearrange and split the
>>> patches, will reply to cover letter.
>>
>> OK, I look forward to that insight!
>>
>>>
>>>> +void *map_crash_pages(unsigned long paddr, unsigned long size)
>>>> +{
>>>> +	/*
>>>> +	 * NOTE: The addresses and sizes passed to this routine have
>>>> +	 * already been fully aligned on page boundaries. There is no
>>>> +	 * need for massaging the address or size.
>>>> +	 */
>>>> +	void *ptr = NULL;
>>>> +
>>>> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>>>> +	if (size > 0) {
>>>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>>>> +
>>>> +		ptr = kmap(page);
>>>> +	}
>>>> +
>>>> +	return ptr;
>>>> +}
>>>> +
>>>> +void unmap_crash_pages(void **ptr)
>>>> +{
>>>> +	if (ptr) {
>>>> +		if (*ptr)
>>>> +			kunmap(*ptr);
>>>> +		*ptr = NULL;
>>>> +	}
>>>> +}
>>>> +
>>>> +void arch_crash_hotplug_handler(struct kimage *image,
>>>> +	unsigned int hp_action, unsigned long a, unsigned long b)
>>>> +{
>>>> +	/*
>>>> +	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
>>>> +	 * is passed to the crash kernel via the elfcorehdr= parameter)
>>>> +	 * must be updated with the new list of CPUs and memories. The new
>>>> +	 * elfcorehdr is prepared in a kernel buffer, and if no errors,
>>>> +	 * then it is written on top of the existing/old elfcorehdr.
>>>> +	 *
>>>> +	 * Due to the change to the elfcorehdr, purgatory must explicitly
>>>> +	 * exclude the elfcorehdr from the list of segments it checks.
>>>> +	 */
>>>
>>> Please move this code comment to above function as kernel-doc if you
>>> this it benefits the entire function. Otherwise should move them above
>>> the code block they are explaining. For this place, I think moving them
>>> to above arch_crash_hotplug_handler() is better.
>>
>> ok, I will do that!
>>
>>>
>>>> +	struct kexec_segment *ksegment;
>>>> +	unsigned char *ptr = NULL;
>>>> +	unsigned long elfsz = 0;
>>>> +	void *elfbuf = NULL;
>>>> +	unsigned long mem, memsz;
>>>> +	unsigned int n;
>>>> +
>>>> +	/*
>>>> +	 * When the struct kimage is alloced, it is wiped to zero, so
>>>> +	 * the elf_index_valid defaults to false. It is set on the
>>>> +	 * kexec_file_load path, or here for kexec_load.
>>>> +	 */
>>>
>>> I think this kexec loading part should be taken out and post after this
>>> whole patchset being accepted. At least, it's worth to put them in a
>>> separate patch.
>>
>> This little bit of code that identifies the incoming elfcorehdr is all that
>> is needed to support kexec_load (and the userspace changes of course). I'm
>> happy to split as a separate patch, but I would think that be maintaining it
>> with this series, then when it is accepted, both the kexec_load and
>> kexec_file_load paths would be supported? Your call.
> 
> Hmm, at first, let's split it out from this patch since it's an
> independent action to kdump. I would suggest we don't carry it in this
> series. After this series is done, you can post another patchset
> including this part as kernel patch, and also the code change in
> kexec_tools as user space patch.
> 
> ......
> 

OK, I'll remove the bit of code that supports kexec_load, so it can be introduced
later coincident with the changes to kexec-tools.

In a previous message you mentioned making changes to the order of the patches,
was this it, or is there more to come?

Thanks!
eric
