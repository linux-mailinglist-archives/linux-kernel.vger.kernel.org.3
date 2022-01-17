Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1D490C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbiAQQld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:41:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25260 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241125AbiAQQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:41:31 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HGB7MX013442;
        Mon, 17 Jan 2022 16:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7DlJsiJhn++GZSqXQlkR8SP4YoSZS8jeosKD+w4TB80=;
 b=zg1J1R02ewlibeWx30SSlVbvZCa4uZ3vhavXgSYAMsPYB7d5KhFFYGrkep9Jmp28H337
 i21leuheUjA9wa5zSUXqhaZbywquxSfeUMGzADuz6wWIoK4QnxGXSrRuSnEemhxKB5hV
 Vl/YrJi5Cp9H5vV5MGYv3mRk82Hoa0gv5tP9qTVGDFLCcK44JmX6b2gj8wgXp/TqzfQH
 OPvlVGxmoa0FKudh8XfJEBRJoKg+F786fWc//iziB2uBFUOWQdyPInEpCPsRj5akLJ3U
 sP2VXbvIJTqT8EvQZOeKKpfhElaxNBIWdKB2JutKPHkH2d7usgtcsfzAAE1rXBVuhac6 Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnr1xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 16:41:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20HGebDL196087;
        Mon, 17 Jan 2022 16:41:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 3dkkcvumn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 16:41:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTlAVQooGBaCRKbLGWJS3rIzi/QCSdAl0GjcVxv2Pi8FZn+duh8suQOrHyN/+tJXedTMiFZziLi9LESKH3MOa6nRMienGdXSy3ow2ZqZ+K1O8Rmx/ShFzD+Ql4+yVqMeWpmSO+WVqHQCnzinHdwh7curfKYuTqywkbQerwtz7yIKH2yeqZsLQEuB+KU9i4Lglt/N9xVRYEkPMi2Z8kkFevJeiYFvH9CqZ9dSMjtZFxC7PxUqRnMbxS9e/ayQXk1HCWcRYa1RSAep9Yp5Q+ioygCNPWaMXEHUdEKjAGnIzF36DM/5NWaKm6zFH+XIus4r69p6KlX8rWJisuYD77hxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DlJsiJhn++GZSqXQlkR8SP4YoSZS8jeosKD+w4TB80=;
 b=jbklUqx4JtNASz8nDighqH5JN27OF9eH2s9qRFR7VTEfHjbUg1JUoM2hI5GCaXEcCvclSHsnQeze5rUQvqs9C63oLQu6NWu95Y5Go2GzUlCvS8J8cPGbT6AxF3q4acn4GnPVr1d0dL4jYrhbusncICWOW+/cVO1DBQ9Banthq0MJGMBwJYoE00lYmKtp5nrVpNtXH6CRjHUhy0D4jOH0+cjIifjJNHz+HeTUvJUS7ElmNynhtIaGv4T7TvRKUGS+U9cfFOkXJqmfu4fJ0VRJgkAfk3W9K4Webuu5MxodhfvZawEiVwh3KlRJGYc5M6/i4espy58vyLHXjmv4kZGlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DlJsiJhn++GZSqXQlkR8SP4YoSZS8jeosKD+w4TB80=;
 b=BXQgShWpXL/44Tu2W8jLBJKAj4TM/zwiwZxcUDYBXDezLg4fVcJREblel3vijRQIvNjZqgEkXi21vwLFByy1RQGH9vBnUHlTX9dfWZd+WjV2itJe9pS9rMkR4yPCxR9PKyxLafFa+cN8SOaF08A47ozPGyHvpjxgzY89ZydAc6w=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SJ0PR10MB5438.namprd10.prod.outlook.com (2603:10b6:a03:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 16:41:08 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 16:41:07 +0000
Message-ID: <783145b7-243b-b85e-e274-44ef6c0696b9@oracle.com>
Date:   Mon, 17 Jan 2022 10:41:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <87tuf79gni.fsf@email.froward.int.ebiederm.org>
 <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
 <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
 <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
 <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
In-Reply-To: <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:610:20::24) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4799c5ba-f979-47e9-e8b7-08d9d9d828e7
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5438:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5438643F1AAC2001F5F31819F1579@SJ0PR10MB5438.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvhPZIOtZPG5NPnE8XrI1vAeD3gi/CSszwefyqrz5FMF9nMtxObP/UOUYPVdH6KKlb97jH8Sc6zKO4MGvOXEvGPpI0yJJW2lDkOTbSvUgaxc5s2Y8pSLT0pqJ1YqFaUG2N98iyNEooYh9rI6aaD2PidWdSBBGxdVy6NBh6v4un7xE1FBy0lI28PoVS2yorJhspqh3ekKazUvdMfG+/YePiprkPvJ52vUmi/vXcd3u6k5sHuBxM8C/oqLFLQ9VEEBNDIYzmHN2gcbV7rVW6tiF4gPTi7uPHxabjr2WvJMKGzPd4oPqb9FNPPXcy/yzYkjKzg9IFlRe0hJo3DZSvQHKug9ZGtinRCDOyLOB1Iz5fV/y4OUxTJduNbFHZSTuTOIVS0OwdbqySo445Z9m9yGGj2NNs4wzybVYzACIEg7Q13nB94D294Mo2NDF3gCEtIIKxYUOhovFoDKf5uQtYnyjV7435DQsa2KkzI8vbyyl0r+x2dLG48sV6ZzM76ORL7qK7MJesET9Lmm+HaTAe4rHXaKHC0ce0MisitaJsF6rXi1txq0hs6cojeuzb2WFZS1HAIUn6KfGmmBrhusO9UXsivSIITHc2af1sQwKLGrdoTMnkYN/sMqm2AU6yR+1Fa3OJBItgmrb8iuHWsQV9SelTNbYN/w11a5CUnNpNkcJCJapkTXooyQP5PVeRI8cI6Mqo5Gwx9/oPaQDzFeeSj8O62kPWda/Mtt3+E8QEpjq00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(8936002)(8676002)(508600001)(31686004)(4326008)(83380400001)(6512007)(2906002)(316002)(38100700002)(36756003)(2616005)(26005)(186003)(6916009)(6506007)(53546011)(5660300002)(6486002)(66556008)(66476007)(66946007)(7416002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHMzUUEvbTRVbmdlcnlCc0dHWDZ4L291UDQvZjg1TkR2eGZIOWZSU25ULzQv?=
 =?utf-8?B?RWpQQWprUm9vZklRa09UMEJnUE0ySno4RVhvWkhzeVZlWFM1UCttaDRaTUhn?=
 =?utf-8?B?UzBpWUhCTFgyTFp2QVprSzJuak5RYzFrSklPeVhZN0xzWHoyOHZHVlh0QnZE?=
 =?utf-8?B?a2NkOXdiL2MwcWJDM3RyR1NrbGNORVE4bnVDWkFPQnM5R0FyVmNHZGV6YmZx?=
 =?utf-8?B?TE5zZHA2ODF2Qk5EcTRDbEZnMHlmZmNpeUZQL3h5aE96a3dNanJKanl4c0Uz?=
 =?utf-8?B?MmtEWUdYUWdOa0c5cHd5RE1uVkJ0YlFIWHNmT0VpZ3JrOWlvS0VyOC9scW5W?=
 =?utf-8?B?eGlWUlM1M2ZVWDJZQXlNZnpKMEQzOXE1Uk9FOGc5Tzc3NFdFNGRXRXhrcnV6?=
 =?utf-8?B?eEZaL0hrVVdYYms0OXZMSGFJMlpocDhhcEpTL2pHcGg4VlNTZEY4L0lVVm1q?=
 =?utf-8?B?ZW10OGtuVS9mZjdQdTh3RlFNQWw1YUFrdEIwbTIxOUFIUmJERGxqVElPT081?=
 =?utf-8?B?WHZPbllLSDdjK0tTSFN3dTh2aVFYK0JjUGlsVTJwY3hsLzY3VTBRODE1a1pB?=
 =?utf-8?B?YTBZaEI5YUczSCtsajZSa3R6a0JNNzc5YTJzY3NEeVlDL0t5bzNrditRODQ3?=
 =?utf-8?B?UUExN2l5cGc1dDFTclpkTkx3Nm9Pek5Id21WcXhpbTkrTG1mOHFyelJpWisr?=
 =?utf-8?B?N0JUOVNKV29YSVY5YlRWZEgvcVNHaHd2TCtIQmFkUmUrMFRTVENUUWhGR0kv?=
 =?utf-8?B?RkFVY3c0R1d6bkJhS2NxaThaL3NVT091d0ZDTWVKb3pWWW1UY2ZhbHlzRVBW?=
 =?utf-8?B?VFlETktTdm1jQUNodU9xSFBENlV3SDkxbnhlTVlPWGF2WUI0OXh1ME5tUk9W?=
 =?utf-8?B?QUE5dllxbzdhdG44ZFpDZzU4dUptb09YUERwYk0rdFRCTHhiTTNialg0NUNX?=
 =?utf-8?B?UUpHNkN3WGxMeXJDdWQ4MGdDSFhiWnM5cWcvVzc3YkcyTXYxRFV5elZCQ1ZK?=
 =?utf-8?B?OXo3Z2E5Y1ZRZW5CbHpyQ09yaFJiZ0ZWKytFSXA2Y0pKbUlRR29teHByR1Fq?=
 =?utf-8?B?Y0VXSllzanRaZ2M5QjJ6VmwrdWx4QS9BcllESlpsa25QRWRySHFoRElLMnpV?=
 =?utf-8?B?STdTeVFZdlVZbWFidHUyc1d2Z1ZHNXJmUjlMaWVVRSswNGsxNkVKc2c1TGl4?=
 =?utf-8?B?eXRubVRkR0xXUEljUzRGNWNrRjNmUHZnUDNiNEM5Z0hWdmdXbXJldk9INXRW?=
 =?utf-8?B?VmN2aXQvMVhLU3NDbnB6UUV6M1NydGR1cDR1clJIZkFDS0RIbkJ0TlY2c1VO?=
 =?utf-8?B?azdUQUxkL0pDeXZTeG1tNStzd2VicUF0bm1OeUZXTFUrYjNQUUVVVkkzVmJi?=
 =?utf-8?B?d3ByaCs4NWZXRWFjMjYraDE3V3lyTE4vYUIvRStEeWlNd1ozOXYwRTE5Q1N1?=
 =?utf-8?B?bkxMSmVsVWx6MHhyNEpLaUc4Y2Q1Vll3eUpEc05nUFNsblBwZXZjakIvd2Yr?=
 =?utf-8?B?OFhENy9CSlF4Qm1vVUhxZXFxS2t4dDgrejd0Sm1LeWI0K2RwQ2E3dUN1Vm1l?=
 =?utf-8?B?bXptYVhiZ1hIdjBCWEF4NXFyN3dRMllkK2NZdzc4WERRZSt3UXVsVVlyRVVY?=
 =?utf-8?B?eWY1VlF3RDNRNWkvL25pU3lYcnFjTHJSL1Q5R05JUVNTSWlscGlCR3Rra3E2?=
 =?utf-8?B?NlZoTzEzaWYyZktoV2NkdlN0ODZURlVyL0FNZHZ4Q3BpN0hMZWZjTHltSGhh?=
 =?utf-8?B?VzdNUVN2ZXBoaFcxR0FWY2Jlcndibjdwd2o3YUcwbXZQbnZWUVhKK1BJN3JE?=
 =?utf-8?B?TXFsaDloVmFveWM5SUd5aDJ4SHBoemZsa3pCbGJPMi96elR3RkRVVGROdDlT?=
 =?utf-8?B?TDNON1BRc09RaTJqRVU3d0xSTDBBZm10c3YvQldkNFhldlFTUFRZZmxkZy9x?=
 =?utf-8?B?aXR0byt5ZmRFN3FCaVduVWdFeTNiZEp5Y1FXb2RXRTgxMUVFd2ZNTGxEZm1z?=
 =?utf-8?B?RTNodEtKNzdtQVMvSnFlNjIxaFZhT0llditIeWloZFNFeW43dGl3cmE0Wm1S?=
 =?utf-8?B?R3g1N2lPenNSaVBMSHVXbFNPT1ZlaDR2dGp6aGFZRkhQaFFBZUNxVlgyVkFp?=
 =?utf-8?B?S00wZmZEY1R3WTdmYm1pbGo5dnlIaFE4dmtSc2hrRjRXMnNnUG1Ed29uWjRT?=
 =?utf-8?B?enB4TlF2NXd4YWFwb2srNE9vTU5LZ0F0Slc5SzRDck1UVktETks5eFErSWsz?=
 =?utf-8?B?Y3V0REhmUGJUVlF2a1o4b0REdmV3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4799c5ba-f979-47e9-e8b7-08d9d9d828e7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 16:41:07.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0pSGQr+86YHx75uz+WhZboK+uu+hu7104hbqiSoFcHSaF+Ab0VjJcKEFAmRL+aogw4uJYSHsq6xngxIXhvo22Cm+wJLIkVqueIUq+cLuHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5438
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170104
X-Proofpoint-GUID: zAhHgpVAYMxpijbRINins9G22mRdlhSP
X-Proofpoint-ORIG-GUID: zAhHgpVAYMxpijbRINins9G22mRdlhSP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 12:24 PM, Eric W. Biederman wrote:
> All I am certain of is that you need to set
> "args->exit_signal = -1;".  This prevents having to play games with
> do_notify_parent.

Hi Eric,

I have all your review comments handled except this one. It's looking like it's
more difficult than just setting the exit_signal=-1, so I wanted to check that
I understood you.

Here is what I'm currently looking at:

1. I can't just set args->exit_signal to -1, because we end up with a task_struct
that's partially setup like a CLONE_THREAD task. What happens is copy_process
will set the task's exit_signal to -1 and then thread_group_leader() will return
false. When code like the thread_group_leader check in copy_process runs, we will
then go down the CLONE_THREAD paths which are not setup and hit crashes.

We would need changes like the following which does not crash anymore but is not
correct for many reasons. I am just posting this code as an example of the issue
I am hitting.

@@ -1637,11 +1637,13 @@ static void posix_cpu_timers_init_group(struct signal_struct *sig)
 	posix_cputimers_group_init(pct, cpu_limit);
 }
 
-static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_signal(unsigned long clone_flags, struct task_struct *tsk,
+		       struct kernel_clone_args *args)
 {
 	struct signal_struct *sig;
 
-	if (clone_flags & CLONE_THREAD)
+	if (clone_flags & CLONE_THREAD || args->exit_signal == -1)
 		return 0;
 
 	sig = kmem_cache_zalloc(signal_cachep, GFP_KERNEL);
@@ -2194,7 +2244,7 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_sighand(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_fs;
-	retval = copy_signal(clone_flags, p);
+	retval = copy_signal(clone_flags, p, args);
 	if (retval)
 		goto bad_fork_cleanup_sighand;
 	retval = copy_mm(clone_flags, p);
@@ -2277,6 +2327,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (clone_flags & CLONE_THREAD) {
 		p->group_leader = current->group_leader;
 		p->tgid = current->tgid;
+	} else if (args->exit_signal == -1) {
+		p->group_leader = current->group_leader;
+		p->tgid = p->pid;
 	} else {
 		p->group_leader = p;
 		p->tgid = p->pid;


2. Instead of #1, I could add some code where we just set
task_struct->exit_signal to -1. We could do this twords the end of copy_process
or after it has returned, but before we do do_exit. However, hat will have similar
issues as #1 during the exit handling.

For example, __exit_signal will call thread_group_leader which would return false.
__unhash_process would then not detach the pid and we would later hit crashes due
to the task_struct being freed already. I could add code like above to the exit related
code paths, but it gets messy like above.

3. I thought I could separate the leader detection from the exit signal by adding
a flag/field to kernel_clone_args and task_struct. But then I get to the point
where I just need a check for USER/VHOST_WORKER tasks in exit_notify which is
similar to the patch you didn't like where I added the check in do_notify_parent.
So I thought you might not like this approach.

Note:
We can't set our task's exit_signal to SIGCHLD and get autoreaped like suggested in
another mail. The original idea for the do_notify_parent was we wanted the behavior
that kthreads have where they get autoreaped on exit. kthreads get autoreaped there
because the threadd task that is the parent ignores all signals and so we hit the
parent SIG_IGN check:

        psig = tsk->parent->sighand;
        spin_lock_irqsave(&psig->siglock, flags);
        if (!tsk->ptrace && sig == SIGCHLD &&
            (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
             (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {

Our parent, the qemu task, does not ignore SIGCHLD and so will not hit the code above.

4. Maybe I am going in the wrong direction and we need kthreads. I could add a:

if (!is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)))
	inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);

to vhost.c or to kthread.c when some new arg is passed in.


What do you think?
