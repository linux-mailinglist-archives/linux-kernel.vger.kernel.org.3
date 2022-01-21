Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF3496074
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380913AbiAUOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:07:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57242 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350747AbiAUOHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:07:45 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LDE2af013573;
        Fri, 21 Jan 2022 14:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=leuVWPXECSAdKSvfCFOuPcYBzq6zHVk5ZSm7cGnxw1k=;
 b=atqdvG7uVpzjj0+IOR3xLnK7hpwKcUggtgEO5DYg+zWOYwtBq7TJENXGWmiZbXy60GnW
 3ICSLM2PifOlF4/uDAJFrJkmUsDpiyKb2Z5QF/Nzc78xDf3uvgPIkkVVD5wKIiB5hzNO
 iOHXLojWpYteRksW/krPWDIJ0sRcfEHUzqO5Ut3/VNnSuJ/nEC0nE5xVLA+2DjIcttVu
 84wpYxLnMOs2YTH6OfTiPnSW57zO+DfA9mYSbzXBuKVDigJZ+6+cPStQYhrACxZxWTwb
 CtNQUniAGLQOcN2RnXmqspNH4Kg4r3Oo0ZVSJkWVop9gPyCx8oayXNboU2p8JJfnIP/D 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhyksdbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 14:07:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LE0j3x162085;
        Fri, 21 Jan 2022 14:06:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 3dqj0vxj8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 14:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrmVGQgc1uox/tEX70tI6JVyuMvAp6MyzJem90vv3r4hlCj52kBtTreCmoeb6Ms3X3LINLqyPLxPVBadq34aFCxOrybGX9iy2MTXfcsJvmar5qYgOy2IpmCMBcBfoOYo2/gTelurJ7ptWLxbWKY7YZiMIc6XIESYHlIjh6x63dcpscISvN3u8k3pptUge5oxCu2DtqRgZFB9EQ0qn6kJz6z+L8+rnJ9Y2SDt7zX3MV1IfCgpxSo5zAq3IQ2Kc4S5lt/pDzvauLyriMQ0yHSKvBacWfGVwUm8lAWftms8IV4P1WTznZR2HF1F++JvDjRZNSRyF5d1l7Y6yuXrekmILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leuVWPXECSAdKSvfCFOuPcYBzq6zHVk5ZSm7cGnxw1k=;
 b=R5iXXvmGs9vEWMsC+61scS4Ez28tFo/+sCI05odVQxoLU1Bv6EswC5VaUnprw4f1RoMOP5VASo0SSds/FbNdhG2kyEswDggLw/ovrszI5zBMDAuljhnqVqepVG5vTV94+CffnD2beBrv4bXjbb0Yu0xb3SROt7UhKXcr1KbtoC4tRV+EIc3SPybRCi2A8gDrzjYR95Xqm54SBWLTduxPgZRviWaAy6Mi5npXTC71MzzEel3yN6VHX+UFHloZdc8f0n93vXr0br1FtA6TwN+hQLloCyUiVaE+iQTYiH6x1hBc1lja88xVwR83oTSPMnxCx1yn3b9+3RelcAIdLt9WUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leuVWPXECSAdKSvfCFOuPcYBzq6zHVk5ZSm7cGnxw1k=;
 b=PLviHVL7B+t1RPx4X/khMOlhVgY3GbvsTXccJkWOZLDTOa8jrWOpl8CVS9lChtk6gbUoxOIDNFsax6Y0caAWmEzBsrwWMyUNN2cEu8Jb6bNek8KUXonGxAQrAdOtBs36jfkM+h3ixjxYrmzzRGsvgP/w9hUtTVeY70kO1YTHQlU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 14:06:55 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%4]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 14:06:55 +0000
Message-ID: <280485c9-4612-892c-0e3e-9e8b09e60cf9@oracle.com>
Date:   Fri, 21 Jan 2022 08:06:50 -0600
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
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220119102323.GB6349@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:806:120::25) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2fd4aed-fa8a-40a4-c91d-08d9dce747cb
X-MS-TrafficTypeDiagnostic: SA2PR10MB4587:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4587EBCE3EAC5F1E8A1C26F5975B9@SA2PR10MB4587.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3cfT29XT+vJsSA7/OWIPInDZJkjxjkUy53xSWtF4vypnU4gN1nC8elFD9QiQvCbew9hn5p6M/7F33pwtw6We4/cRIrjWa/T0uLAw4QFA8E4ZMeVnnPPzjrvafWCNX/ul6RfanXDIIv8xCiR8aw0uE+fqrglGZNY/2OPAuYrIAAGcJT1nV/HQLNNodN/7Odp83u8rm2+hIi6bBSyxscULh50mgLPEyb+a8pkkIAbKaJrb5ylDX5AtAyv8zE+MPlkoowyXsPk3twGjNvTIroZ35bJ3BXZZyVKp7zRCziljcpHeLmenSGbaFNOMARbSpIGrl/GFvImOIKEByjn27amLXJFX6U/8/IoHVu1oMZJzE+sL7dEgLRoGoU5oBuyB2tVfCYsTKRQwM60udKNii3NR+OdqJoU+VmXmTy8nVmf4XXtFK3WyPiq5ACIXuDvrHnWNroshhVOexZP5FjhelUep8YF3zS6vQoDYTNm8e7/eXq7q08fZ/pTlXL6ut5U7xyaNl36vi8UaexM28EiU8+xlO6U4oqvq7clQPEva3kohHP4uFqFn/Zf0CHdPX6wJHcnRp0xL1PL+/5FOlmJsk6PrOp9TMsW6ojCBvuBiJipsANnzTpIXnj9O/0KB65F/YUzNIuNQKaKa6PvHpBteFtt3Ru6CiMAzyzGxGOYGg52TigRMzYGUOjGXs4RyPoe85Gg9OVkpZ3PaXNrQFrxmOPIhIbh62nKQsRDVdWbyiZMs6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(36756003)(8676002)(83380400001)(31686004)(6486002)(6506007)(107886003)(6916009)(7416002)(53546011)(86362001)(186003)(8936002)(2616005)(6512007)(6666004)(66556008)(2906002)(508600001)(38100700002)(316002)(4326008)(66476007)(5660300002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZvVGl2Tks1UmlZNlBMUzEzRS9CUkx6aklINmNOWEg3Q0xvMXJOOEErZ1Jy?=
 =?utf-8?B?b2laUUtNMnZDWlp2OUttZEQ4bGoyUW1oZ1FwUmxvTFl1Y2x2WDVXMmY1Y1ls?=
 =?utf-8?B?RDBKdm52ajhaZG9QY0kvUmVZdVZ4NUhDcEhrR3B5dk9tdU9KLzRHdjJramps?=
 =?utf-8?B?MUVPS2FGR0NHbkttMEszMVpQalFRNVJvQWFUcWpyZ0Q1M1plVk5PalhkMUZ3?=
 =?utf-8?B?RVpzOFFNc1dwUFp3V1MvTloxb3pWTHBsWHQzRDZXTGFsQzBGTHVEWU1TRmVk?=
 =?utf-8?B?S1BrNnNVQytVdWx5ZXlXWUhzQzhiNmRDcU9ORm5zRW5vOEJwMDlhaS9KL1BK?=
 =?utf-8?B?NzZoQlhad3dMYVVtaDdzdUNpSHFMZy94L3VjRll2azVaajJiNmdMdjc1eXcx?=
 =?utf-8?B?STdaa2lKSGFRa2s0MWpaNzdCbXZJWkVZQTBMRXhWamVrcTNvUFljbHZpNGV0?=
 =?utf-8?B?T0xSL3NHQ0RabDBmUlJ3d0V0UDNBTEI5REo5MUJVYldTUmplendSS2IxZ0hj?=
 =?utf-8?B?aTVBdHNkQ0g0ZHVHTkRZUVZsTkdvbHpyL21WMG5aWXBOUlF5NktlRXI5dkxR?=
 =?utf-8?B?OC96bitiT3ZvNXRkSk9LRG9mV0gxM0tyYVFJOU02Ui9CcWxUcXE3YU1RMXR5?=
 =?utf-8?B?Sy9pQWU2TXF5RkVFMUdGYVNIQnNUcU1rTThDZ2d4eG1MNGFCRDdYVGVIN29u?=
 =?utf-8?B?NlBZeXBoQ25KenUzSVZDQWJVL1ZNTG1UdFM2YUorbDZVWkkwbkpJUlRpSndu?=
 =?utf-8?B?ZHl4bW53SE41NGxsajVhQ2tFekhta29DZVRhSncxb3RUWFVQa1NKUjBVL2pT?=
 =?utf-8?B?R0I3QzFxTTIwMWpaN1hDWkhwdmhCVllsTUR0YjJxVFJ3dTRzVks5dURvV0pt?=
 =?utf-8?B?UStmSEwxTE1oeDR5dEc2MEFuSFE3c3FZMGRaOHNibXdKSmtySU5qZXU5RnAy?=
 =?utf-8?B?dHNnMi9XOFYrdElybkgrODBxdVNXQ3RZVUREZHJUOEgyejFSaGs1NGduZ3Nr?=
 =?utf-8?B?VElHS3REN1dJbTFvU1BmNHdHcUhvMnFLSGltQXE0WHdhRkt5Vllia1pjbHNp?=
 =?utf-8?B?OURlSUtzcFVUS3hPWjAybWZNUFFTWjJVR3JjOGpwdjFyNXYwaFpxQTg0QWhH?=
 =?utf-8?B?UmdNVW1zOHdrVHFyMW9pS2RJWkVrdnc2eVExa3ZvMkRJZ0R2a2VMZFdRdmdO?=
 =?utf-8?B?VkFsYkhqRFF4MjJBa0dRaVZXd0xDZklIUHd3RTRicHRZUDZnamc4K0EyY04z?=
 =?utf-8?B?aEoybDFtZm55ZGl1dytsWTc0ejFmL2NCc0tsVkxpanpMTENTTjEvbllDU1A5?=
 =?utf-8?B?RW9JKyttWEJSWGRFY3VRejZ0UU1uaHRmREk1SFZQVmhlN2o1YVhyczRxNS9W?=
 =?utf-8?B?NlNPc09ZZ0ZISVBpeXJiVWFZZXdocjJsRnpCZVU4VDA1VGNlL0VwOERENkJC?=
 =?utf-8?B?ZUpxUmFFb3Q5elZSbjV0UHBsTjNXUkcyUSs0RlJNWnNFR3NXUHF6a0xXVlRp?=
 =?utf-8?B?N09pZnVHcjBLQjMzWUZ0MkdQR21kc3ZXZmYzUzh0THk1S0JqWGVwSENNWVFp?=
 =?utf-8?B?VHdlaERoVTkwQ2ZWTTBMcWl5V3RyYUtqZ09vNHpFeTFvNzdRY1huYXBsdS9J?=
 =?utf-8?B?ZGU1Q1VrWWVTd2MrdnZLWGs3TS9sL0hLRVNJNTVxSHVsSnhtdU5TWU1ZQk1Z?=
 =?utf-8?B?cElWN0JpNDRCWjhKVjNFTmNyZm1KWE9VcGVkYkxZcnVIZ3ppQ0lIcVdLcVZj?=
 =?utf-8?B?OW1mRFBxKzUxbWhZN1VJQmZsbjk2cFBRcHdTWHJuUi8xLzZERGEvcDRTam91?=
 =?utf-8?B?MXRZeEdjb0pZM1ZWNUZicTFSRGtZUlNPQ295YTdxclRWOWduTi9kTWJxUERM?=
 =?utf-8?B?ZFFZRmxHNytrcWM4emZBaW52bGdtd1p4cXZkTG1oeGRBeGY5ZjdhWkRXcVFz?=
 =?utf-8?B?SkxKVXVnKzRXOE1QUHVmRXlINlZuRTZxYXV5MDc3ckNqUEZhZlcyREx2c2Va?=
 =?utf-8?B?b0pQQmFvMkc1Qys0TmRWdjE2UmI4TmJFbkF3N1drNWpscnlSNE55allleE81?=
 =?utf-8?B?T3ZJNjNuK2l6WXVCVnd6djQrTFVQbCtpUXg4dHdqMmZhTzlRb2FLZU5rTEJO?=
 =?utf-8?B?SWhwK0pLZFhTS1ZidEdOU05kTFRvMHM4cG9FbnF6MW9HS3JzenlMOTNTWFNK?=
 =?utf-8?B?LzBXa05kL2NaSzNxenBLd2xtdE45djRTaGMyYldZOUFVZXd6YWx2TW8rTENl?=
 =?utf-8?B?ZzVnZ0VUN0FEbXZ1U2wxT3VvMU1sUEpzY2hvemd6NTV5anBOcVhITHFCOHkx?=
 =?utf-8?Q?1hNXIXtWVcasSvbkWO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fd4aed-fa8a-40a4-c91d-08d9dce747cb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 14:06:55.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syCXdjwLbjjIiPZv37bBrTvIwvkichOnVO7+ga7hp7Scx2bHTKbGfobOukoIkTcAEeJyiuoSLZ1T1i3w49p1IPPZES8uvffTTx11NnflRCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4587
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210095
X-Proofpoint-ORIG-GUID: caOT5hmmvkXD8rKlWcWFDvAT6AplgG7U
X-Proofpoint-GUID: caOT5hmmvkXD8rKlWcWFDvAT6AplgG7U
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,
Thanks for the feedback, inline responses below!
eric


On 1/19/22 04:23, Baoquan He wrote:
> On 01/10/22 at 02:57pm, Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and if no errors occur, it is
>> installed over the top of the existing elfcorehdr.
>>
>> In the patch 'crash hp: kexec_file changes for crash hotplug support'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.
>>
>> NOTE that this supports both kexec_load and kexec_file_load. Support
>> for kexec_load is made possible by identifying the elfcorehdr segment
>> at load time and updating it as previously described. However, it is
>> the responsibility of the userspace kexec utility to ensure that:
>>   - the elfcorehdr segment is sufficiently large enough to accommodate
>>     hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
>>   - provides a purgatory that excludes the elfcorehdr from its list of
>>     run-time segments to check.
>> These changes to the userspace kexec utility are not yet available.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/kernel/crash.c | 138 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 137 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9730c88530fc..d185137b33d4 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -265,7 +266,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>>   		goto out;
>>   
>>   	/* By default prepare 64bit headers */
>> -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
>> +	ret =  crash_prepare_elf64_headers(image, cmem,
>> +				IS_ENABLED(CONFIG_X86_64), addr, sz);
>>   
>>   out:
>>   	vfree(cmem);
>> @@ -397,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
> 
> I would define a default value for the size, meantime provide a Kconfig
> option to allow user to customize.

In patch 2/6 of this series, "crash hp: Introduce CRASH_HOTPLUG configuration options", I provide 
the following:

+config CRASH_HOTPLUG_ELFCOREHDR_SZ
+   depends on CRASH_HOTPLUG
+   int
+   default 131072
+   help
+     Specify the maximum size of the elfcorehdr buffer/segment.

which defines a default value of 128KiB, and can be overriden at configure time.

Are you asking for a different technique?

> 
>> +	/* For marking as usable to crash kernel */
>> +	image->elf_headers_sz = kbuf.memsz;
>> +	/* Record the index of the elfcorehdr segment */
>> +	image->elf_index = image->nr_segments;
>> +	image->elf_index_valid = true;
>> +#else
>>   	kbuf.memsz = kbuf.bufsz;
>> +#endif
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -412,3 +424,127 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#ifdef CONFIG_CRASH_HOTPLUG
> 
> These two helper function should be carved out into a separate patch as
> a preparatory one. I am considering how to rearrange and split the
> patches, will reply to cover letter.

OK, I look forward to that insight!

> 
>> +void *map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +	/*
>> +	 * NOTE: The addresses and sizes passed to this routine have
>> +	 * already been fully aligned on page boundaries. There is no
>> +	 * need for massaging the address or size.
>> +	 */
>> +	void *ptr = NULL;
>> +
>> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>> +	if (size > 0) {
>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +		ptr = kmap(page);
>> +	}
>> +
>> +	return ptr;
>> +}
>> +
>> +void unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap(*ptr);
>> +		*ptr = NULL;
>> +	}
>> +}
>> +
>> +void arch_crash_hotplug_handler(struct kimage *image,
>> +	unsigned int hp_action, unsigned long a, unsigned long b)
>> +{
>> +	/*
>> +	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> +	 * is passed to the crash kernel via the elfcorehdr= parameter)
>> +	 * must be updated with the new list of CPUs and memories. The new
>> +	 * elfcorehdr is prepared in a kernel buffer, and if no errors,
>> +	 * then it is written on top of the existing/old elfcorehdr.
>> +	 *
>> +	 * Due to the change to the elfcorehdr, purgatory must explicitly
>> +	 * exclude the elfcorehdr from the list of segments it checks.
>> +	 */
> 
> Please move this code comment to above function as kernel-doc if you
> this it benefits the entire function. Otherwise should move them above
> the code block they are explaining. For this place, I think moving them
> to above arch_crash_hotplug_handler() is better.

ok, I will do that!

> 
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
>> +	unsigned int n;
>> +
>> +	/*
>> +	 * When the struct kimage is alloced, it is wiped to zero, so
>> +	 * the elf_index_valid defaults to false. It is set on the
>> +	 * kexec_file_load path, or here for kexec_load.
>> +	 */
> 
> I think this kexec loading part should be taken out and post after this
> whole patchset being accepted. At least, it's worth to put them in a
> separate patch.

This little bit of code that identifies the incoming elfcorehdr is all that is needed to support 
kexec_load (and the userspace changes of course). I'm happy to split as a separate patch, but I 
would think that be maintaining it with this series, then when it is accepted, both the kexec_load 
and kexec_file_load paths would be supported? Your call.

> 
>> +	if (!image->elf_index_valid) {
>> +		for (n = 0; n < image->nr_segments; n++) {
>> +			mem = image->segment[n].mem;
>> +			memsz = image->segment[n].memsz;
>> +			ptr = map_crash_pages(mem, memsz);
>> +			if (ptr) {
>> +				/* The segment containing elfcorehdr */
>> +				if ((ptr[0] == 0x7F) &&
>> +					(ptr[1] == 'E') &&
>> +					(ptr[2] == 'L') &&
>> +					(ptr[3] == 'F')) {
> 
>                                        Is this for safety checking later?
No, this code is here to support the kexec_load path; the incoming elfcorehdr has to be identified 
in order to make changes to it later.
> 
>> +					image->elf_index = (int)n;
>> +					image->elf_index_valid = true;
>> +				}
>> +			}
>> +			unmap_crash_pages((void **)&ptr);
>> +		}
>> +	}
>> +
>> +	/* Must have valid elfcorehdr index */
>> +	if (!image->elf_index_valid) {
>> +		pr_err("crash hp: unable to locate elfcorehdr segment");
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources. The elfcorehdr segment memsz must be
>> +	 * sufficiently large to accommodate increases due to hotplug
>> +	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +	ksegment = &image->segment[image->elf_index];
>> +	memsz = ksegment->memsz;
>> +	if (elfsz > memsz) {
>> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we are all but assured of success.
>> +	 * Copy new elfcorehdr into destination.
>> +	 */
>> +	ksegment = &image->segment[image->elf_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
> 
> The ksegment and memsz have repeated assignment.

Ah, good catch! I will correct.

> 
>> +	ptr = map_crash_pages(mem, memsz);
>> +	if (ptr) {
>> +		/* Temporarily invalidate the crash image while it is replaced */
>> +		xchg(&kexec_crash_image, NULL);
>> +		/* Write the new elfcorehdr into memory */
>> +		memcpy((void *)ptr, elfbuf, elfsz);
>> +		/* The crash image is now valid once again */
>> +		xchg(&kexec_crash_image, image);
>> +	}
>> +	unmap_crash_pages((void **)&ptr);
>> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>> +
>> +//FIX??? somekind of cache flush perhaps?
> 
> You might mean memcpy_flushcache() on x86.

Thanks, I'll look into this and hopefully use it above.

> 
> 
>> +
>> +out:
>> +	if (elfbuf)
>> +		vfree(elfbuf);
>> +}
>> +#endif /* CONFIG_CRASH_HOTPLUG */
>> -- 
>> 2.27.0
>>
> 
