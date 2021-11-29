Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9344620D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347496AbhK2Ts2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:48:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46194 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378839AbhK2TqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:46:13 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVDEU009070;
        Mon, 29 Nov 2021 19:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yc/yOokkuhLhJQ/1wRaJ7SS4otqqfhlW6I0U4q2yvDo=;
 b=s1FTLrZMITQPVHvQCfQQ/1OoAuFcZ+iKlQnt2RvL/5mqo1SOxqqMtSS6c1yHzfhIotqm
 ZciUO6gPaEQYmv+Be8XZ28j26NY6m6ChPkRVvnIrkFHaxm7i9Tb889kYyg7/CSIxZg2E
 Fb/il+brnjA5wscCUjgGSg/UaktsxGKHdDdOyLiLgUrWRHObqj7grOpP+v+XkuV22bQr
 fokvXUIGr1tGdba84J0T5O0N51IpAfXXMrWazHidKluaYKcP4/8cX6NMEX7CzF+Kp/pW
 yHt8VIOU0XJa31/MZ5hZ0SQi6BxZi2+sfgssUbspvWfvttTaOtZZAmEi8YB6kR2SYrHD NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9ks3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:42:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJa438056573;
        Mon, 29 Nov 2021 19:42:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3cke4n17ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h32+oIViL+lx5L5frv0MWjbW0DsFZVZ5/4rqXIjNBxrIC79VFf+4KrJXPt2tZvPLENt4cbE+z7rrPlZq1u+hp19NZv7rxBGWrScHPXwN3pBZltqX3tvd++N9BsrFP/8CG1x3E9pxPNbLLroOBP9x7JV8vmCTWmEoyYeDSLa/nvKQOHK3Ao2e9cBviNo5Wyf3/qmJ/BwTUuaqR7UWuj9VqP1muUUM5y61nqW+CqO/SiNZaIh6D4FA5hVrVs3Kp3gqghU3597LofOUVT+dU9DTVEtn8cgBdP5xQxCLx7wGfUjz1qdDZ5wuG5CSrZulyjWJpl5E2nfKqk2hk09+4aewvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc/yOokkuhLhJQ/1wRaJ7SS4otqqfhlW6I0U4q2yvDo=;
 b=kdz3CIHr13XQRGLky3gyAQJnr3dhHKipooRysIcyqXqbjpgMQu1nZQ8Jv5zDw5CUf7HgB24UlmDEsd5se0l7gBYXcjPyQhuWEB77nJe1CVjr/76TtSQQa1UitLWhO15HImxmZQhUAa366Cq8U8bM9/1+iNc/7q7ZRhtQw0cuRxNQaEFbimRU4YYi1REJbvd6WLmpjABXeU6sK/f4rYFd4TD0qjNwZwcGtB7WhyOe3iHMMzDuGM5tHE704S7ZGzt/lFU7oaXGzE150SZSeRDtCUJlZWecNM4SKPYoFTcs3eWB6lH6m5bGzXqRUvRnC9EDoukDNUlvA4C/4/F2p18L3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc/yOokkuhLhJQ/1wRaJ7SS4otqqfhlW6I0U4q2yvDo=;
 b=RISuvXNySVATr4rAvzLN0/n4Lbi4/e0ss+jedKOb8tuNid+HbyABSxB0tbwl3EhjVFE3CkZ2w6dkRaFkOxRRWRU44lSrwOY4xMQymRkSuRxBKXlqFo+nenD1ylI7/Fclca6SDNwGVQ5BnkPfYiXpZl/TxdjM9T8S3GzG6H9Kwys=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1599.namprd10.prod.outlook.com (2603:10b6:300:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 19:42:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 19:42:17 +0000
Message-ID: <200f923a-d196-7475-99e3-63ff3e73b28e@oracle.com>
Date:   Mon, 29 Nov 2021 13:42:13 -0600
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
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20211118174948.37435-1-eric.devolder@oracle.com>
 <20211124090227.GA8026@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20211124090227.GA8026@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0053.prod.exchangelabs.com (2603:10b6:800::21) To
 CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from [IPV6:2606:b400:414:8061:221:28ff:fea5:27c8] (2606:b400:8024:1010::112a) by SN2PR01CA0053.prod.exchangelabs.com (2603:10b6:800::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Mon, 29 Nov 2021 19:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76816a94-4dbb-4be8-bbe1-08d9b37059d3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1599:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1599A4661AEAE68E3429C07297669@MWHPR10MB1599.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hFXKLkKbENRkQ/gAObZz3gL7zTdGSzlp1Of5k9Ekx71gXYzPwpwr22iXumeRU54iOIVuD+NNB8nEoh+klvX0/zZHw96cenSGc6D35YumrqA2ohnU16lbIyYqFF7WJSGlrP0oObiqQ9RnHYFeLiQFd6rcPFRhvLdfFMOE+FBCOsb0Rp8fot1qJd1fqHmcJxwAZivPVKofxH0fBNZv/2xj1l3myY/h7TU8vCkoASEpsVOK9FuWwELAdM/amBZcNozau4VExpYs7osPrI2BwkoWzVMX2eB+HmPBkbtGvmTMTI6PdmW3R0aJbz6NABiOZJ8J0Xx51ebuhh9NawFNJjiMDYdKT6yyhbGfz38T14CIUvU2NtGOBxHA1nK+MTxFWouujD9l2oSk4WQzWOzBNT94y2geDm2AzFwLVNrC2UC8g9GoE4/be+IgAYpodBf4aE6PKHn89FlV5aOj0xQxjE+Ht8PbZNFnjmuNIJOwB0n8CjG3i5HxAtOoeOyyYdo63w2g4yfmfJAZuUoh4JUF7fQgN+EPnx+Qm8lvcXd5ABqsynsK82Ovs6Z3Eog3ar+tzWWlt12O0lC0aGmTktuW66G1yX3GDOlPGOrG3okzmfOR/qWq/tmIHCEphQQUi6lkclKGDD/zKBOyBjXWyOZWR1XID1ZIS24HcSkIohwoOA/38I1ggI7AOd2NO4DW3ayddog76jtr8Yvt7adOFcz4nLqrjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(316002)(8936002)(38100700002)(66946007)(66556008)(66476007)(6486002)(2906002)(7416002)(86362001)(31686004)(53546011)(186003)(31696002)(5660300002)(107886003)(36756003)(508600001)(2616005)(83380400001)(6916009)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnJtWFo5dXI2RUFhWUpYTWpCNUc4eDV4dVF4WjNwZHlvejRGQTE3c0dwcVJ4?=
 =?utf-8?B?U1pkQzZwZEJOOHI5bU1tYmhFUHlCVXJFa0pEUFJvTzFaOTVnUE5KZlk4ZVRp?=
 =?utf-8?B?b2dpWnFQcFlmZjIwUXpPMmJMd281TjRrUG5IcTF1SFhZSG4vTUV2UDc5NUN4?=
 =?utf-8?B?WkdmM1YvY09oZkpIMWdXSDBzZjBieDFFSnVFNmRkcjdLWFg1UWhJaUpXdHpM?=
 =?utf-8?B?MHNRd09lTEJHLzZ0ckRxNTRuYVkrakVPam1pUFMySndhNFF1dStwZkdDWHAv?=
 =?utf-8?B?R2o2NkphazdrSVhDa0pOZk9WdFFKeTNrdFVYNmNCZXVUQVhkK2xLdU10Slgw?=
 =?utf-8?B?RHNiM2F5dXpSMGxIa0l3S09nNlBwN1Z2bEl2NjdWY2lyUlZZNzg3aHpsSFpO?=
 =?utf-8?B?UU5BbGpKbHZ3R0hJU0dTNVg1QVJzYjdkOG1MZWlTYS9Ca2tvTGhIVW9jVHo4?=
 =?utf-8?B?RXlYT3VUVXFScHNOb2Q0RFR6THU5dlBic1lNMlZia0dGTHo1elo1b0tjUEx2?=
 =?utf-8?B?OTBoMytiL05NOXRiRmRUSzBMQzZlVmtmbm1NRmZ3bklQa1R2ZkJORFZTVXBn?=
 =?utf-8?B?VFpGVXFCdVc5cHA3cktSZVgwbzVJM2R3UFMxeTdWOFh0OVNvVk1JVVZwbVpN?=
 =?utf-8?B?UElDNUI4NlR4VzE2cjg1U1didTJySEloWHFwQXJDalB6aDNHSVhPUi9yZ1h0?=
 =?utf-8?B?ekhabEN4ZmQvV3ptNUliOHcwZTVLOWZOWFNRTGlRcm5IM0Z1K2JjZk9BUjJx?=
 =?utf-8?B?ZHhSZ1lCVU5PdWdrSGRHWmZPS0R4TGVERnRTUHNKeHBFNUFIQWtGUy9NeGhT?=
 =?utf-8?B?d1dCVFlBenovM1hraTlDMTdSVTV6ZzdGM3UrN1pZQWxJYnVWYUhET1F5NERm?=
 =?utf-8?B?dmVBRXU0WTVjcWRBWHZoRE8wRzBvbUh6UVVoSWFxY3g5aGJCaENhYlFzUUp3?=
 =?utf-8?B?V29HUUpNVS83eGwvcDF2QWd5bDA4K3JXTDJleTVReE5JenFsWEEvRHVTZ2Ji?=
 =?utf-8?B?c29DMGhjV3FCRkQ2dUtZTENpSFhxdlBGaEp5Slk2cmo0TTJpbTZpdjErU2dr?=
 =?utf-8?B?NFlQZU1NRVZjQ2JzQkFQR1BwbW5lRGJERGFOQ05od2wzZitGQVdEMGVma2Vm?=
 =?utf-8?B?WkpDNWdsbC9ja0dPSDhHanNOa2NrV1pTcnVOM09VTEhVc0luSmt0SjFtMmtX?=
 =?utf-8?B?OE8zbEM3ZXVPNXJrR1Rwb1dFMGRBZ2V1TEpWK2VXUkdRc2JRemNmN0pRakNl?=
 =?utf-8?B?NmdFUWZ5OFZscmpJb0JUeCt2MStLSmdkbmxPYjFOdW1YdnN3aHk5TUYwUUh1?=
 =?utf-8?B?bTlxcVVHYXI5OW1IKzJDVTQwS3JwWDYrUXJGaXdra2FVZ252UnNuT3FrK0NK?=
 =?utf-8?B?c1cwdVlsSm9zbGNLVlVPM2U5aFVnQ2xZWHBCdDNOZHZQbStRSmJVY0Fxbkcv?=
 =?utf-8?B?VWpka1RIeHhReDZEUnJ6L1pSR3dVOG5VeFVtZWlUdXFsb294ZGM3dXUrRitQ?=
 =?utf-8?B?dmNXV2VZK1g5L1V0VVREK21tSk1NeGZkMUJlbTByS0VkR0M4ZWJDNzZkalZN?=
 =?utf-8?B?NjRWaEhFcWNSdFU1c0dFOWZSVW0vTm5mS2dYYkMzRE9sM3RhZHdma05QQTA3?=
 =?utf-8?B?by9QNTc1ZThqcCtZSE1waGRNd3pkckVpNkFaVmF6SytVbkR0enlCdE9kR2xZ?=
 =?utf-8?B?UG81UmZ0K1lrdG43Z0RsOHVnK1NBYkJJM1lCaVBibWNKYlhTcmFHMXdLeXF2?=
 =?utf-8?B?aHd0SExhMm4vaFo1QWhaMDdKa1hPc0w1aXQwRU1iNCt2bVRCcGJnTFFxWU4w?=
 =?utf-8?B?UnV4V2xVejQweXFROHpMOHUyL1hvMG9Obyt6UmFwS05PNnBtUmhDZFUzZVJ3?=
 =?utf-8?B?WjdMN2JsMHJrdC9wS0wxT3lKYWltWEJuNjRua0doWHBGazlrRnhWWFQwdlg4?=
 =?utf-8?B?MnFDd2pWaVhkQUQrRVdmWmRDT1hHcG90MUFZTHFERitqVXMwMVo1dFh3eHJH?=
 =?utf-8?B?MEY5aVplb1JBeVA1Y3M5T3F3ZFFLYXc4R3lqNk4ySHRuMkM4Q25KWm9iYmU2?=
 =?utf-8?B?Tmpyd0h2MGFDSHhQa1J4enJVZ3ByMDFNUUdUYk5hZTlTMUlsOG1nUXl4WGZu?=
 =?utf-8?B?dWlDSVdLbVk5RktiQ1JKakVXWnFTamNpMzlSdmVETnZEQUZ1WXFXUzcyTDdU?=
 =?utf-8?B?Sm9mV3pFSHNHek1zTlh3TkpqeVhuYWg5SjRCcnJyZFllblJYVERwa2N2ZmhB?=
 =?utf-8?B?L09EcWtoeWI4bnVtaFJiZ2wxbmkrSUFQTUNvbFV1S1FkOGpXVFlDLzhJbXNn?=
 =?utf-8?Q?a9nAU+31SgoldiXtGS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76816a94-4dbb-4be8-bbe1-08d9b37059d3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:42:17.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7SWsGR/xehlDssEapTlxJX2n9lqJI0hxtlwE6mXXlJU8F/hbndhyreo7j//FvcR18cnYqBYPNvvi/va7RdBB9beYOaj2xn5h9Hu73X2FjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1599
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111290091
X-Proofpoint-GUID: UmMEw8tJ5lLpxTzfVjkwWiochReNnOWK
X-Proofpoint-ORIG-GUID: UmMEw8tJ5lLpxTzfVjkwWiochReNnOWK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, see below.
eric

On 11/24/21 03:02, Baoquan He wrote:
> Hi,
> 
> On 11/18/21 at 12:49pm, Eric DeVolder wrote:
> ......
>> This patchset introduces a generic crash hot un/plug handler that
>> registers with the CPU and memory notifiers. Upon CPU or memory
>> changes, this generic handler is invoked and performs important
>> housekeeping, for example obtaining the appropriate lock, and then
>> invokes an architecture specific handler to do the appropriate
>> updates.
>>
>> In the case of x86_64, the arch specific handler generates a new
>> elfcorehdr, which reflects the current CPUs and memory regions, into a
>> buffer. Since purgatory also does an integrity check via hash digests
>> of the loaded segments, purgatory must also be updated with the new
> 
> When I tried to address this with a draft patch, I started with a
> different way in which udev rule triggers reloading and only elfcorehdr
> segment is updated. The update should be less time consuming. Seems
> internal notifier is better in your way. But I didn't update purgatory
> since I just skipped the elfcorehdr part when calculate the digest of
> segments. The reason from my mind is kernel text, initrd must contribute
> most part of the digest, elfcorehdr is much less, and it will simplify
> code change more. Doing so let us have no need to touch purgatory at
> all. What do you think?

Well certainly if purgatory did not need to be updated, then that simplifies
matters quite a bit!

I do not have any context on the history of including elfcorehdr in the purgatory
integrity check. I do agree with you that checking kernel, initrd, boot_params
is most important. Perhaps allowing the elfcorehdr data structure to change
isn't too bad without including in the integrity check is ok as there is some
sanity checking of it by the capture kernel as it reads it for /proc/vmcore setup.

> 
> Still reviewing.

Thank you!

> 
>> digests. The arch handler also generates a new purgatory into a
>> buffer, performs the hash digests of the new memory segments, and then
>> patches purgatory with the new digests.  If all succeeds, then the
>> elfcorehdr and purgatory buffers over write the existing buffers and
>> the new kdump image is live and ready to go. No involvement with
>> userspace at all.
> 
