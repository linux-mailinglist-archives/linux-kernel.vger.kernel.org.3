Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDC470B23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbhLJT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:58:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46418 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239911AbhLJT6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:58:48 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJb6ID006386;
        Fri, 10 Dec 2021 19:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QhOfM802WU1ACJ4VlDvtUjjhOqzCXiEbTDhBca4wVb8=;
 b=cU/ZzBlfhVtMgnU2hl2WFCVEiNYPXPK0xf0sRolZTBuXhmIYyHNA+K747ojfNmSnNtBc
 BkFFnu3bNdivNLeYAkarxDfC9GOn5HDmcqJ9w5TUdQjjgD/Kj32rb1MhfoBLi12+/aaf
 dMUaJntIJjVzlFwqNrvtcJ2T35YGzhCbG7xtm23touKiWGURjp1zHoHV9iquxI6BoVYe
 plkmzRRclI3rg+7JG2Iwn7X/2iVnFmn7ntfdZHYY/uY0Nsdq+UCWzaji63d4aoKLa93D
 +2VXnFOT2e/iWIWzeQv2jq+pni7wvvjBTitrxdnjeFi0m0Uobxdvh+u8xKI5DXVlYUf8 VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cva9y8fx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 19:54:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJjbAk069832;
        Fri, 10 Dec 2021 19:54:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3csc4y4sab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 19:54:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBi/sKXckbANmpxaAhzBWQppKiQdAlYx2mIkZsGkgBE0pYacZ1EhUjZCb8PVLBtU8yf9Z9pghK2atkUhmUZJF+SgUbcogOzWUxoPCV1EEk7en1ijpXuR3czTvw2+E50iLq3sUVnKG89BBinMN1g7gqVVkoswwiriHa8cmTOytkWvazugv2/UoErDkEl9OlnJuQU5ITvIfOZ84j6jRybdvlLwmzL6C/nNWR2xseJzWEusy9Ie1ymqZGBWu+Xd4yW9ZTHHQWPcagK8N76UQSn29/Ng3MBo6VMIGf7jriu9gOGJdalz1sy/9brTwFSJyk3jjmsE3NByv81zusdn/yMt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhOfM802WU1ACJ4VlDvtUjjhOqzCXiEbTDhBca4wVb8=;
 b=IYJNSc4fTn8SZvRxQjJmA9UsErvMX7JMYepammS4dd5HCLjyxDXep+vZqKPdv87PYtabJjcUAFERExPY4FNtoLaYcOGgfuFsZZVTKU2gsaBasWJ/SN7y4WPd+p5AUyQJJBP5cuz85/fVHrUJIQBUN+qU2+maPabtOG0Sp/S/iNSDfVToTEgw5nnE5JOSHYYQg5hp9c054XC0Va5IR+hXr1Xzd32wEcUIAGwTJCwag9xesbxby6X/VDLtG1CCFCp9kFcH9gRPyRVAxYLf2WudJ7mQQA1d9T0PPFQ0n0hfjlFH5E7RWcyV49fmo3GFA2Drw+I87vHPKJYV2ueSBW1mvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhOfM802WU1ACJ4VlDvtUjjhOqzCXiEbTDhBca4wVb8=;
 b=Vh4Bx6V1zp+to6BL6flZGOJPzcollCnGz38XyTnoD9WBcO6eWGfKlz8+yISJ0JtLS6reMg8dM4NyS16SPglDGE74BuwJEUFWaGQU3Sov0VpBPzCEBQubiFEfyszBdmygRiJazxT5XKOAsLRUONAcFkjg922c0LjFGXwg0O3kpsE=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1967.namprd10.prod.outlook.com (2603:10b6:300:10b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 19:54:19 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%6]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 19:54:19 +0000
Message-ID: <db65cd76-e2c0-4d35-0dcc-d9f8c164f77e@oracle.com>
Date:   Fri, 10 Dec 2021 13:53:59 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v16 00/11] support reserving crashkernel above 4G on arm64
 kdump
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <YbDnwol20HrRl4uL@arm.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <YbDnwol20HrRl4uL@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::25) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [10.175.61.118] (138.3.203.54) by LNXP123CA0013.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 19:54:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ede8be2-ac24-4aa9-f148-08d9bc16da7a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1967:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB19677EF2A6B4BA7184526C82C7719@MWHPR10MB1967.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DK4nIdfnmQWBwYavXwgIfPK+2783LEYK/DUgmD41BvStJmrozUDm8nzxGuGc38sXft6KbD91uMeZYVKdnIRA93qbo+hMOKtd/X1FrAHXRO5wSIsN7c9AA/0Xr46UgGc30vJARNzWftbVLCNTD6PK3Z+YmGuGn4pO35kdExVSa7CxQrnLkiaNBQkPHCLCCqC5QsZNYhRExCZKtmorIUYO2TQtRm8WH7b9E7dNWy8AjnX+TW+5awCn6EsX7bnkXyP0QS/XoPwMMfFJ08xdcC+y/BATPdWSCKWCyQ6Ms3JRRKPrJfIW3zdFoSxsclg4Naz9QspYBfw7bGb5QH9DMsNWLDxLgFaM75jKEF8WTblq1Me4sw6wsdEZMSjbOa+Hj0Q+Et15iySOys2vNxKmU9Bfvkg8xMkrZ3+THXMXUFJCUrM1L1lMqkI89D6ERM214k7jgIufku0r0uFsXMuTl2qCnymr4QQBby4rifo2FJOgYiOX5J3dWGQQTaXUxybIfTrVmuucqJQSbppHKhTDYGuD4MgNbA6cOrV0QCHd7/5HcXhFpD8UgyBOczG7xLgEM7YMFEE1l00213Y378mUEj/R6Ypb9dro3w4eprmc3UYlpiZ81uIEzASZSK/UFlMfwC1/ALjrmmlIG3hgmNukGK9zEYa9OeToWE0b+oBtFCVKG293ziOW1JgxorZNmLymmCH5/DL2pwTTQuIYkOd/RzVFKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(31686004)(110136005)(36756003)(7416002)(31696002)(86362001)(53546011)(38100700002)(83380400001)(4326008)(6666004)(508600001)(6486002)(9686003)(26005)(956004)(66556008)(66946007)(2616005)(66476007)(186003)(5660300002)(8676002)(8936002)(316002)(2906002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGx2WTBjVldUOUhPRlFnKzVrM2RqYWVSdW1qSW02VlVHajZkT3VlZDBUWXZR?=
 =?utf-8?B?R3JYaVB5cUxCVGRVRkdDaklqWWJHTi9oTUVnbHk3MlZMNGFDNlErT21UcXpu?=
 =?utf-8?B?TG5uWGRrSm9WSStJNDdKWDc1dGhkTlBkSHNBTkVuSUZsaHZ4UFpJRlM4NlhL?=
 =?utf-8?B?cCtHRzFQODJvODd0akttRW94WXExeFlNVjZ5bHhvVTJNNVlNVmdtVXNkTWZJ?=
 =?utf-8?B?U3hSVEpmZk1LZmhvUzRRLzNjMU5ZUTNSbVNFMlhGT25GRDJpeThJeGkwS3Jr?=
 =?utf-8?B?TVZPdHJtL0t2UUNMaURmVTJXMnRSRnE0RTJZdmFwTHkyS05GN2NSTmFvUWtm?=
 =?utf-8?B?cmc2NWhZNVQ2ZGZ6L0lEdDRqSnZ1OHAwbU50TzhPMnpJOGxqamk3cGhXS1Iz?=
 =?utf-8?B?RnA2ZUIwZ2trTVpvNHdvTWpZL2xxWlZQZUdTNEVVcTZZa05xTUN2aEEzaTk5?=
 =?utf-8?B?S0tEcDd3UU5XSkJnRW5GNVJnSEhvVzlFVEtZaWFWdy9RbWJabjNoZUpwYW5t?=
 =?utf-8?B?L2orSGhudjBpazNQbjdPNWJ2MDc4eEF6QUZxVHkwaGptcHRMT3UxNXBwcXJM?=
 =?utf-8?B?MGV5aTZuVU42d2NqSkN4WHVmQ3NFTzdkbHJvTk5WNHNhMmlnNEZNeG5KVXVB?=
 =?utf-8?B?Wm8wQ3d4MlpCNWFoWkVSYXdiSmdtRndsbks3Qk1TZVhBQWp3UUlWUjVuSHlD?=
 =?utf-8?B?VG9IdFp3ZVNJRlNZYkVld3VsaFZ3bjdPRWNkSUErUUdyNThaTk9qbDNYQWZB?=
 =?utf-8?B?Mm12NHpFYlAwcEkxZ1JBWExGNnpjMnVybHFOUkdTOW1nQkZLNTQzZ1R5MEw5?=
 =?utf-8?B?VEZRYnRwdExlYy9tSGRMUzFUemt2N1g2ajVIUjR6RGwwNjBoWWptcEJieC9P?=
 =?utf-8?B?ZlkvSmF2Q2R5SkQybE4vTU5PSXI2ZGxOZFZoUWIxN2w2blg2b0FZYVZPL2l6?=
 =?utf-8?B?NTF3cWFka0s3THpoZFYrTTNQZ3NoVjJVMFhHcElsdll6RzVhUy9PZWd5K2V2?=
 =?utf-8?B?WVZKeEdOT0JLdWYvTlcySzhMaVFYV2tSdVVZSDcvYXYvVmdQbWwwNEo0Tm9O?=
 =?utf-8?B?VWlFZk13aGRoNG9UT0VLOWtJNU0wY1N2OUx6Z0R3aXRPT2ZWT2dTd3Y5Nm9w?=
 =?utf-8?B?VWFVcE0zKytvUXF6Sk1ibXZyd1NMRkVKSWg0OW12ZFJwN053WmRySFZnd3hX?=
 =?utf-8?B?dllMdUdwdlFEZ0dWbm5kMGVrUTNUbGlUUEVlZVFQYStLNkJBQmI4dkpTQllV?=
 =?utf-8?B?M0sxU0tnSkMxeTJwbEhaNUo5RUlaLzJaMzlBU2JmNXg3VEhSMlVHSDZaRkIx?=
 =?utf-8?B?Qis5bWdUTklwWmZmNjBETXJvcGJxaElUQ3Q1bThjbTN6WWtiRWNVVzhFeFQv?=
 =?utf-8?B?YStSczkySGU2WDRRdUcwbUJhM2RhV2lETEZaazkyVUgzMmRON0xVN045SG1w?=
 =?utf-8?B?eHhOMVA3d3psUTMxRmhqR1oxdDJFOG52OCtncWUvYVZKY2ZqWXozL3ZxK0Jn?=
 =?utf-8?B?clo5N243eG05NHd5V1lqYjRnWFZHZmRJRmFUQ1V5dVVNT2RtcS9abzVvWmhz?=
 =?utf-8?B?NHhVSzdIWkIxNGxJZmFTZldJRHF1cStQM1h1RTJGK3VMOStVejlSc0hJRU9q?=
 =?utf-8?B?T3hVaFNSckNTMEg5c1hQNW0zMXBIT3VjZFNpRUpFanFOVXkxVCtMb24zbEkr?=
 =?utf-8?B?S3FoVk9TZ3RhTWpMbXRFSVBsUXdORmlSRnk4RDVkcE1NcHZhcGpwNmE5aTdz?=
 =?utf-8?B?OS96MkhpS0p3MVJiMFBxWHhtenRLRklSYjM2V2U3cDBDcnBITmc2R0toRWFk?=
 =?utf-8?B?WlN6c21XTVBUcFU4WGVybXB0NURlMUxRTjQ5NDdxb0pHeWxwcm4wcFJIcUdx?=
 =?utf-8?B?bUtaQW40V1dOMWxIQkdTWGtvNDBha01hWCtRYzVtQ0gwNkRmTVlCWDd6TitU?=
 =?utf-8?B?VEhRaTJsSCtNdkN2VW5kWEpGZUlhc3lWMEZRN25NKzJEMHY4Z0Z5bFpMSno0?=
 =?utf-8?B?R2p2Wk5pVWdmZDh5NkdBWEU5UmJ4WTNNbXpKbGh2aGpqT2VDNExTTGs3Mko0?=
 =?utf-8?B?bUxGc2c5RkUrVVVWWEZic1hkZ3lxeDM1NHZha0R1L052Q2QwNlBCaXd5TVJr?=
 =?utf-8?B?QkVCN1BaRURwUi9SQW9KR0FpcDVwWmN6ay84NzlYUzN3SHhlaE5yNmRMQWty?=
 =?utf-8?B?a3hPQmw3Z2VCNHc5YVFwbnphSEpDV0l5VE9zQUo1S2JPWlNHZ0M1aW5CT2xo?=
 =?utf-8?B?TlE3Wmx0N1RMVHpkd252NTE5ckJBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ede8be2-ac24-4aa9-f148-08d9bc16da7a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 19:54:19.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONfGw6CAIEobK3CrZRf1y7S5bdkzBQkci+tMeCu1jUXJ+SvOuJ8kTfofzAJj2R6OfS6b0JZRVLrQD7gQST+s8QwIZO2NDt5/E6EwVpZPSF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1967
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10194 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100108
X-Proofpoint-GUID: i7eTLgqqph8KsA8GrfFnIkm99tmc1qPY
X-Proofpoint-ORIG-GUID: i7eTLgqqph8KsA8GrfFnIkm99tmc1qPY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 11:13 AM, Catalin Marinas wrote:
> On Tue, Nov 23, 2021 at 08:46:35PM +0800, Zhen Lei wrote:
>> Chen Zhou (10):
>>    x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
>>    x86: kdump: make the lower bound of crash kernel reservation
>>      consistent
>>    x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
>>      reserve_crashkernel()
>>    x86: kdump: move xen_pv_domain() check and insert_resource() to
>>      setup_arch()
>>    x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
>>    arm64: kdump: introduce some macros for crash kernel reservation
>>    arm64: kdump: reimplement crashkernel=X
>>    x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL config
>>    of: fdt: Add memory for devices by DT property
>>      "linux,usable-memory-range"
>>    kdump: update Documentation about crashkernel
>>
>> Zhen Lei (1):
>>    of: fdt: Aggregate the processing of "linux,usable-memory-range"
> 
> Apart from a minor comment I made on patch 8 and some comments from Rob
> that need addressing, the rest looks fine to me.
> 
> Ingo stated in the past that he's happy to ack the x86 changes as long
> as there's no functional change (and that's the case AFAICT). Ingo, does
> your conditional ack still stand?
> 
> In terms of merging, I'm happy to take it all through the arm64 tree
> with acks from the x86 maintainers. Alternatively, with the change I
> mentioned for patch 8, the first 5 patches could be queued via the tip
> tree on a stable branch and I can base the rest of the arm64 on top.
> 
> Thomas, Ingo, Peter, any preference?
> 
> Thanks.
> 

Hi,

If you notice the trend over the past year , some of additional review 
requests are because the submitter had to rebase to the next version.

Can we get this acked and placed in a build so others can test and start 
using it ?

Thank you,
JD






