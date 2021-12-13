Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE222472F73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbhLMOfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:35:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7484 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235358AbhLMOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:35:29 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDBRLHu029386;
        Mon, 13 Dec 2021 14:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vMxkdmiDnbPOvySvNJ8JUnl9Ie8DjCsMAPLE/HtyN64=;
 b=M6Xz7PgpB/O1iMYCAkzFvWnfTkCjGoGOFYwPRp0VjNnt2WRCPn00+PcGOOyFsV0inNLG
 9R0qSWZcbSsOLqzyJ/8SDUnaHl6BFdKJI0tjxJ3alTSxa5dfkbu5+YuhQvjcGyo323mH
 jfyMQ1LnILwFKijqPuJMH81nmgCEUXF+iqpRJI5B7hR52frft8EgwwBLcoGbK2C1ru1j
 hLOQsirJQituZfjjVk6xX8P4hG5oj/Eo/EtJL5MU1+qVaZEcDY9blczdTQceWBOyeUbY
 gmyNh6+7wOahLPo76ITzBpCKpTpGR7Vn52A5aUm9ESakdWldg4wP0NHRy9cHLtc3RsFm hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx5ak8d75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:35:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDEPWp6011333;
        Mon, 13 Dec 2021 14:34:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 3cvh3vjcwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Dec 2021 14:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7YdZnR8+LL/rstFDdKGbDU8EC6T49gV1LL1+1KB1BHGByuxCx7tR+hQQ30b3EytPzN2FT5VIIvjfKjzda01E4kyKQh23vB9h0HoFz2Sxbn83oYpD1VrHxQ8SQhQfdd/15TUSRAwxrpppd5aVa9tnuM3dUnGlV68gIJ8c7zzkGX/LqmmFt4Hhd386d/ENq/aRr55TAB2PicQT0zFtFk6TSQg14R6DBM1/R/wLKsLCPQuvQ5o5/anq33WDHVk1c4NJFtDv9jRp+fUDXVKniB6fw8C3eAYmZg6dOTZOkiO9SXAEGVY+u/L64D/M2U8nFZIPB4Aw1DEO23GZCEIumk0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMxkdmiDnbPOvySvNJ8JUnl9Ie8DjCsMAPLE/HtyN64=;
 b=NzCxmPYySfV95ptQdGpLMMD2coKjdfyAWYaYkQzq3XukYREzJfapGHt8kmdrRp5MNfXdIHGARd0Er4OLHGo5ViXh8vkTKt8B8dSMiunjoqzPVaZcLioRZZwfLcZvIPTegWH6yAYvZ2hJoClYX3sZNzkKG3v01x1HZDQsmPvuNyHo/6vVsA11OFUWSdAiFo9XzOuIgTdSi+ixUlQCtOPaxjeOeS//qwr3Q+kEElwDeF6SirfKZWFoAUVygd5sANIbu2B+1gypTxfyYtIqVkVrNLj97D0ZHlbHZekIiH6iTMSWtJyv315HmmxO3XwalllfMtZG8rdJiXXugjO1luv3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMxkdmiDnbPOvySvNJ8JUnl9Ie8DjCsMAPLE/HtyN64=;
 b=z9SzAldAG46AU6KyltqDQIMLgehJ5uwWmvSxmDwN5y3JmMfaEb/kiIrSgYnoVV6laA95i4SbLAMSPvLcrM2xp+zFSO9oJQ5Gu68y62MApVErvE+IADGDBaAbHsH2YkPPMpcXfGmjZeCOBjXOcn8M7IAmJUw47XOiQe2HCukVILs=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1518.namprd10.prod.outlook.com (2603:10b6:300:25::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 14:34:56 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::54ed:be86:184c:7d00%8]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 14:34:56 +0000
Message-ID: <39bf5406-430b-83c3-c8ff-234cdc107007@oracle.com>
Date:   Mon, 13 Dec 2021 08:34:49 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v17 10/10] kdump: update Documentation about crashkernel
Content-Language: en-US
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-11-thunder.leizhen@huawei.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20211210065533.2023-11-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::35) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73a9cbff-9aa7-421d-ddd0-08d9be45bb8f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1518:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB15189FC258839613DFA062FBC7749@MWHPR10MB1518.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZV7toYOWH7K0qZm4V65dP/haDJqiSIBaG49rpmutTV1BAVOgtg037xolZfk360hZ4xdhQglMsGMrpDGKh3UKO0D6aiJaT+u7YZaumYjYCYW/r3YQ0EJf1MoCxwfxDuB4pPNsYc3Mf658l6GXQbSbQtb/UiSfLln1dDLrtGQ/+LwyIPlxNHWBGTF2bYYnt37LVi0IKhQQRaxOPsJ9fz4+jT083GRL04RBQvYpDJrEzjLDrmR2xSfZWfkW04T+3SXzEtfcokTBkITvB3uLriuVyh68yisCsEktGWEiu0DBSHG+MSAUt4WLqKfGG06EjlPq3xYWNLepGuzq3MjHkFKO3nKhr5sNftztPfRPxfLNiqvtm3zGdf95BLLiKrq6VPZAehT3po3WhbR1XPVjRf0XerXeWC6BXgm7UmnGER8T8UP3lwEG9UDqbV5JcZ3xHI4SF+jmHbu+A+qvNhgWwaJoDIFjHz9eof5iZmNYBSDEdlW1h7rQ7WK23oiciCzQGzFfZ7FXN2xyU1SzDTOAtQ3/cSuxhWxz8wpUYSjqjZNpC0X6RRrF8Cp/wRms4JKyBvCieBIU9ZUoOeyySq/WDyJdE0bjFh/NhHhEeWmCvbR55UOeYPg9hoMemFYhHM9/IcBaJlkUhP3H70YKtB/opKiA/yniFX3i3ScdAdrQ+yh5Ok9rJW9IsSQ+URVoTm/nrGyZTfvXCFCNbvg5Ckyyfr2JCRd7rqhEVNXyk9K2N+Z/orc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(6506007)(54906003)(2616005)(2906002)(26005)(9686003)(5660300002)(6512007)(6486002)(38100700002)(83380400001)(316002)(53546011)(36756003)(31686004)(66556008)(7416002)(6666004)(186003)(31696002)(66476007)(8676002)(508600001)(921005)(15650500001)(66946007)(4326008)(86362001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0RSNUdqRVUvWHFQTDFzN2lYdHRVNmNqQVNSbjk4Uzh2aktMTUR2am5pR2Nt?=
 =?utf-8?B?SncvRXc1SGdjNVNJVnJMQ3ZBQmlSNmZkU0lhampDdzBpdE96MzRvVkJQVStN?=
 =?utf-8?B?TUY1ZVFhT2ZiS01wVlYvZ0hKdDVsUGgxbmZScXZqVXlCQlNUL3dtckVxU040?=
 =?utf-8?B?eG5pS2U0cXVuSDJOUjBIaFVuSmJQV3pON0tKekhScStqR0Q3K2FjekVDK3Vn?=
 =?utf-8?B?OCt1bndrNVpKc1hFeG1ndndyb1hUSlFYcWZadUZPOEdUTGVwTERqQWZUSHNw?=
 =?utf-8?B?ZjhSUjJmTXZHNWEzYVZmaXVvV1psaXI0ak1PU2MwdjFPQ1YxeUVZUzJocFJU?=
 =?utf-8?B?dHI0d2lGZFN6N2NobThWZUZXejBJMmkvSEZMcXN3STl6Ti9reU9LNXFhOXJ3?=
 =?utf-8?B?K2ZoNkNWZE5EY016T1JRbzJQL1UranFwTmlsclVKYzFUaU5KU3lrWjRkcGht?=
 =?utf-8?B?NTZzcnRySG9hMldaQnVnS3I0TXZWd21WNmtTWDFwYkZZbDJiY1VGVk04cFp3?=
 =?utf-8?B?SHhKSHRqa1Z6cEVoYlV1V2RhYkQ0WGZNMkhXNEFjeFFiYWdkNGI2MzhESEQ5?=
 =?utf-8?B?cTRZeGVBSjZ5WFRlaGNNZVF4cFVJNEtIODVsSHRoSmJRbXQ4WDBYOGUwU0cy?=
 =?utf-8?B?TEhSZ1o1N2Q3OVJ5ZmQ4SVJZUENHcVg3UGE5RUt1a1BYa1ZhbzhScmxkSmxi?=
 =?utf-8?B?MTZkWVZJVytOQ1FrcWYxQXozbnY0OG1rMUtTQkphYU5nY3FRUVdYTWhaY3pF?=
 =?utf-8?B?MzEwbUZHVHdhMEI5NGRqZWZGZGpFb3JmS0RhUzlTNVo1U1JMYUJaWWo1OUFM?=
 =?utf-8?B?bW8rV3FmVndGb3Q5V25jODZNalVVa283enFpbk5VVVExb3B0MjM5b09uVEFM?=
 =?utf-8?B?RTlrSGpCc3NPWUNtKzliVVFCVGF0cTE5eXQxQitoRS9QUHhFcW0zVWNhSjRO?=
 =?utf-8?B?bFhkZXVTbi9mSzMzWWRJVzd4VWxJNHNuUTV0c2d6QTFjSDNVN3UzTjRuTlA1?=
 =?utf-8?B?NWdkM3J1cnkrcVRUYkVNTUZBOWdwbzVuS2l2dW9QalBsWVNOK2F3bGZ3dFZl?=
 =?utf-8?B?VEl1Y2lMKzJrQVpwZ3dVaDVxSlpwRmhLYURjVE5XbzR5VGpYNHFDZzFGYkly?=
 =?utf-8?B?K3pKanI0TUsrd3BrWDlRSWpJTTNpb3BBNGtoZjhIa2o0TXFXZExBYnpFSTBp?=
 =?utf-8?B?ODhUMno0WiswS3NRNXVPakwrejJjZjJuM2J2d05GVDRVYXBjc2RTYTM0ckJU?=
 =?utf-8?B?RldIL1hvT2h6NWRxZHhsWWNMRkpOMjFob2U1bDY3Z3Q0Z1BpQ3FhZUlEV2lD?=
 =?utf-8?B?cHZYZXFiUGhVYVU4MjVvSk9zWnJCSnRySktoWlAyN1I5M0ZLOWJSUXpudEFM?=
 =?utf-8?B?ZmtCYlpTRjFNWWJKRng0UzJ6RXFCSDlYMmU3Qzd5UDAvRUttS3UxR2c1R0ZQ?=
 =?utf-8?B?MHRhMGFtaUZJaWNyd2NWdjc3bXc2bXhZaFFKWlRtc0pQSnN5M3hRYTIreUtN?=
 =?utf-8?B?Y01mcFpoUGU3QTdiMGcyMFFYZEZwWk04LzdrZTIrc20yQWNJa2Nxd01MNmJT?=
 =?utf-8?B?VDZEYndndlA4U1l2Q0pIZ0hwTmp3QlB2b0RjTEZEU1puRWRFYldDbkQ2S3F1?=
 =?utf-8?B?Yk5ZUkJLb0FxOHlmY1VzWVB1RnRYOERmK3FHK0dDL1liTE5uY1lKMHdrMzRn?=
 =?utf-8?B?SFdZZmIwME5JaTFUSlJraDdnODBnMjdNS2htN2d0RzFYWGIxOFpkUmpnR0dU?=
 =?utf-8?B?MGFTeWJaSWsrekJVYTZJYkppNm8rTEVkZ3NRcE1jNEgvSWFLNmh1eDBBbEtZ?=
 =?utf-8?B?WVV4WU5zQUw4UlNyUTZRaEsyb3BlY05VTU5mcXhtYWZXYkl0Unp3YW9lTjBy?=
 =?utf-8?B?Z01Dbm93cEVkR20zOVQ2K3dNMFowUHc1NVZ3V1loOWpLVHRRVTRoVXBGYWxX?=
 =?utf-8?B?d3d3L2dDanVYN2RPYkJ2bDFhZ1NmVkFiOURHblJ6T3diNU9PdWxpcHJxdHVl?=
 =?utf-8?B?NjRielVyUDh1Zkl5YzZKYUhBQXQwVURrS1VlaTdCZHJGWDRlNWlHaHpTckd4?=
 =?utf-8?B?TnJnQ2tVYkg3YWVOekNvelROMXM2WU9KWDErS0JFMWExMFE4RFFRemZPSzY4?=
 =?utf-8?B?ekN2ZXR6S21LeDVWQ0tjSkE1ZXQ2ZUwybjNSc0tRdWYyY2d2V1Jzc1diWmxY?=
 =?utf-8?B?MEF5ZTdIeHZ0d0VYZTh0Y2pwMG9OczRRY0ViN09IbXVmNDZNSkdwQklzNWRn?=
 =?utf-8?B?SFRGVWF2QXVtMWU3SVJvOE9BR3pRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a9cbff-9aa7-421d-ddd0-08d9be45bb8f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 14:34:56.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ousdSOX711jSpXdA6uCGSR6brvI5f6zsE4JkyfXl620hhN268EPI02LKoLh78tdQIRaqDiTdaE978vNtwy2KwSwl6HLoiAOm5sh5yMCxzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1518
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10196 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130092
X-Proofpoint-GUID: NAsmR6Ou49q34PS4kj3o-Sxohbh4lUHx
X-Proofpoint-ORIG-GUID: NAsmR6Ou49q34PS4kj3o-Sxohbh4lUHx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 12:55 AM, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> For arm64, the behavior of crashkernel=X has been changed, which
> tries low allocation in DMA zone and fall back to high allocation
> if it fails.
> 
> We can also use "crashkernel=X,high" to select a high region above
> DMA zone, which also tries to allocate at least 256M low memory in
> DMA zone automatically and "crashkernel=Y,low" can be used to allocate
> specified size low memory.
> 
> So update the Documentation.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

  Acked-by: John Donnelly <john.p.donnelly@oracle.com>

> ---
>   Documentation/admin-guide/kdump/kdump.rst       | 11 +++++++++--
>   Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++--
>   2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index cb30ca3df27c9b2..d4c287044be0c70 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -361,8 +361,15 @@ Boot into System Kernel
>      kernel will automatically locate the crash kernel image within the
>      first 512MB of RAM if X is not given.
>   
> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> +   On arm64, use "crashkernel=X" to try low allocation in DMA zone and
> +   fall back to high allocation if it fails.
> +   We can also use "crashkernel=X,high" to select a high region above
> +   DMA zone, which also tries to allocate at least 256M low memory in
> +   DMA zone automatically.
> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
> +   Use "crashkernel=Y@X" if you really have to reserve memory from
> +   specified start address X. Note that the start address of the kernel,
> +   X if explicitly specified, must be aligned to 2MiB (0x200000).
>   
>   Load the Dump-capture Kernel
>   ============================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9725c546a0d46db..91f3a8dc537d404 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -783,6 +783,9 @@
>   			[KNL, X86-64] Select a region under 4G first, and
>   			fall back to reserve region above 4G when '@offset'
>   			hasn't been specified.
> +			[KNL, ARM64] Try low allocation in DMA zone and fall back
> +			to high allocation if it fails when '@offset' hasn't been
> +			specified.
>   			See Documentation/admin-guide/kdump/kdump.rst for further details.
>   
>   	crashkernel=range1:size1[,range2:size2,...][@offset]
> @@ -799,6 +802,8 @@
>   			Otherwise memory region will be allocated below 4G, if
>   			available.
>   			It will be ignored if crashkernel=X is specified.
> +			[KNL, ARM64] range in high memory.
> +			Allow kernel to allocate physical memory region from top.
>   	crashkernel=size[KMG],low
>   			[KNL, X86-64] range under 4G. When crashkernel=X,high
>   			is passed, kernel could allocate physical memory region
> @@ -807,13 +812,15 @@
>   			requires at least 64M+32K low memory, also enough extra
>   			low memory is needed to make sure DMA buffers for 32-bit
>   			devices won't run out. Kernel would try to allocate at
> -			at least 256M below 4G automatically.
> +			least 256M below 4G automatically.
>   			This one let user to specify own low range under 4G
>   			for second kernel instead.
>   			0: to disable low allocation.
>   			It will be ignored when crashkernel=X,high is not used
>   			or memory reserved is below 4G.
> -
> +			[KNL, ARM64] range in low memory.
> +			This one let user to specify a low range in DMA zone for
> +			crash dump kernel.
>   	cryptomgr.notests
>   			[KNL] Disable crypto self-tests
>   

