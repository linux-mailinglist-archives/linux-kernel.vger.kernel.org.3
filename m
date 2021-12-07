Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A41646C26A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbhLGSNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:13:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37008 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbhLGSNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:13:11 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I4Y22021777;
        Tue, 7 Dec 2021 18:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=soimS5RRbYeD9ESvK7Fc/AH5JQLM0uOYQSEJBZRcb98=;
 b=Epz/tV118q8G6EUd8voLGv313c5Iuwkbt9ttG5vfM3UyaWMBa639w4G0VJb7iKFXEAu9
 pHLe1w3JW737TqXTThnzWdIXz4UeNxbIxbcVx6OEXVFDDiEsY/BRUqwcLaH6ZpuW2pde
 8pT7TMF8f2tVNoH6TwPHtBUEyeauduHWzJrQxZY9Cd/nrQm0m5vdIf9SIM+ABQqJnima
 0MkQ1ZakiH0UHlvoHJFIBgagWaqjtv20F2lRUy6KrNs8w2MFHpCBan3j5n7eIHSHfEzm
 IXW71EtzNIILlGFaRoh6xg9dio/akZctNGzZ9vv7ScfFege/zfctx5SMYsukFm2JgWcn sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csdfje21v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 18:09:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I5Bx4173199;
        Tue, 7 Dec 2021 18:09:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by userp3030.oracle.com with ESMTP id 3cqwey3gqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 18:09:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjiRLzgttshcvFgYsfQpvHnfa8Jox48UCmGFxvNBr1lEHAytmoe+HGIsvFnFueR6O/LaWoCt1jsteytMKv5LhGZ3sJqfa8SDxNhvMkWJ+CZLBthPRUmmlqtC3dUNWNCdIEXDOlZUwvsxNwRuTVCF3Lbg7gSbTL9gG8w1BoIxF4CNYn4MW+oJ9Qa7LqWYF5VHdG1wIw1lI6PzACfE6F7DoIXqq9xQBMqA0SZkSVFparhd7lHowapSz1MhG7bzDD6kg03Y+/KSrAzvy342ltBlKOi44viqU8R60IOj33uRy7LP4CNqxXOfBYhJDD1NwF37VDz5qfUzuK5EGt+czHhuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soimS5RRbYeD9ESvK7Fc/AH5JQLM0uOYQSEJBZRcb98=;
 b=aHi0Kwo2Uwk06530+55W/5WtMPQ6vXxutyVEwgc5W8B665POz5xYqWAORoxBHKfSRmUjJsIQmb5H6qx0EXU2RoKYcSwNORdIBJ5YDe9JW8A8zJP4QSLQPQi+HkTF4QVwd8Uxl1yl6VEDYKfKukNkA6GEdBQiiY9IeLee2M095SXPD2sa4bEcY3nwtZt36HwHlkjt85BiTr4SmmtXLPLjuCk1ICdB3w1T+1bqXQhbKpBpQq6uSgwHdREOBNmP+H0lF4OPajn0IGXWvl3tGH0D1JpCFLxt/yvwTndK10wYRlsXk1VRN4diwHWXe4nWXbIp3HCcKCw4ZJjl8c/PgYchsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soimS5RRbYeD9ESvK7Fc/AH5JQLM0uOYQSEJBZRcb98=;
 b=WQUk2Hs1YRU/c/GrQYL+ZaZvVhJQSjfEiqDSZ1W9Y1onYcyd3GBvoRBwZZSXlEakCWwrg0A+SBl+wQsuWSznHzzh4tQ6oqgmYAbb24D+4PVq5pucyAWLJnzD2Hw2KXcHokI+AtXo770JGIkU9SmjoGrTxBF8yyQ9FnMlag0yhP0=
Received: from BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 by BN0PR10MB4965.namprd10.prod.outlook.com (2603:10b6:408:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 18:09:35 +0000
Received: from BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c]) by BN0PR10MB5192.namprd10.prod.outlook.com
 ([fe80::4440:4f39:6d92:a14c%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 18:09:35 +0000
Message-ID: <a3e6455c-b3a3-d98c-cda7-f05f686bd036@oracle.com>
Date:   Tue, 7 Dec 2021 13:09:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/2] Revert "block: add single bio async direct IO helper"
 to avoid UAF
Content-Language: en-CA
To:     Pavel Begunkov <asml.silence@gmail.com>,
        gregkh@linuxfoundation.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1638892302-14475-1-git-send-email-george.kennedy@oracle.com>
 <95ea9142-9f36-981d-a04d-3efded544af7@gmail.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <95ea9142-9f36-981d-a04d-3efded544af7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0186.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::11) To BN0PR10MB5192.namprd10.prod.outlook.com
 (2603:10b6:408:115::8)
MIME-Version: 1.0
Received: from [10.39.208.49] (138.3.201.49) by SA0PR11CA0186.namprd11.prod.outlook.com (2603:10b6:806:1bc::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Tue, 7 Dec 2021 18:09:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dba2f6b4-e5a1-44cd-ba1b-08d9b9acb9fe
X-MS-TrafficTypeDiagnostic: BN0PR10MB4965:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB49654D93DDA5F6BD198A31E9E66E9@BN0PR10MB4965.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjnSqY5vjbZltF5Ln1SG3bgPLklFvE3CBcKe/qIOXpS6s2gJNY+uulQAn3qmdLEBWtOuaHr4ayS/eyaxR0w56uCNNU7W+u8bdfdsiY3YF8jf4+0U8IA+nSjUfjEvfEEW62AuG+FPOfYN1c2dyw+aUsFDS6qE6/LK1N++7WlMgqxHChOl4EPaZ6Jf/nW5AAuwnGRzhRil1RaKfzUDPA79xE6TXxy3llk4z04lcbHRU1yeflJwSwKPi7QnOlZmG6XIyoITMnlfXmdFGu9fXduCl0YWawxJHYcC3xhAMFZVZQdkQTVo8QQVG23FISCchObeDVfiE4IWqwRyoHNHkO2uqTQ7WEdxKz1aWbuLOhlNHx7hEKZ3SsG1LmA7M5563km8VXfVdUab10xmGWOOAAhuBt5Hs3xRi59khHQQ7YcDg44BWZ6D2w5wbU/v0BgAX/OEogiEQ0tRXeT6LPFEDNYVSMsXa/SgOdNw5dmmvaxRuPOxY3duHwt0XXYDP4PEaxmtBf0Vqoh23kPeTeXGWd1jKP262hbDD7dZvkNyhZvgd7I0Kx2oR+niuQUbIS5NT//pQW+lY/cZVhvLheTyAhmHNi8W5Bq+q2HXQy68FYvUidUsiztW4oD2Ef0Do0v6mDndQaN8KkM3e7/t9DyL2xx+V2nUiIc7cGEcIpH88t3BNtWv1UScEwySg3hQnsWvpBv1wifjxzmkBCud7JNTJryvd36SL+Vjt1VG7PdTuwe4NfMMzxxukBLytukPSFEMu6+ldys2KPrqwgrXxOdk1W8O0VCQsJYgvTY5DpR7EZ/8n6SkBFyfME8XN1wwwqds+rMs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5192.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8936002)(83380400001)(316002)(26005)(66946007)(38100700002)(8676002)(4326008)(30864003)(66476007)(16576012)(2906002)(44832011)(186003)(66556008)(45080400002)(5660300002)(36916002)(956004)(36756003)(31686004)(53546011)(2616005)(31696002)(6486002)(86362001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJLVE9kUTVEYkRqN3M5ZitJa0lDdHV1Y25COVdGYVhKbmlRNmRYc0c2eFdV?=
 =?utf-8?B?T3VtTWJoZjlzR3c0NTZCQkdXbFlrZ0FmcTViK2tJOVNHMHd0dUsyRGxOM2Nn?=
 =?utf-8?B?VCs3SXF5NzJUUmcwZC9IRE1yM2JSemF2MURrb3Yxa0JhYWNYYWRyUUludmtj?=
 =?utf-8?B?TkN3c1NHN0IrTE1TdENwdnBWNG5KZTN3TGlycERYU2UvMkZQYVkvRDZKUEo0?=
 =?utf-8?B?S0tucTJGNWh4ZlF2N3Y4UVZBdUVIc0ZNYXRLZDFZZEY1eTFRdnNKWUFsWjJm?=
 =?utf-8?B?emVNNC9jRTh5MW9zYmRvVlRJTFBRbklNRGNsd3BraGdLOGx0QklLckprNWdm?=
 =?utf-8?B?OC9tN1JJK0w1K1RuZ3hLRVMwOU5BUEVHUCtrT3RkNWZpY3ZRNEI1WUZOcnA1?=
 =?utf-8?B?Y1YvV28ycVVKMkVwY216N2F1WUt1SkRLc3RsQjB3U2FxOFFiYlNYNFdncE1i?=
 =?utf-8?B?aEt2Q2ZYSU1XbWp5MWFad0picVg5c2hlUm9BNGYvSjcrV0wxdXZoSmFLdjI5?=
 =?utf-8?B?MkVjRktheXZjYmVuS2xMNmFPQW1UZGNNcmNNTGJhS3FmcDRIRmtDV2YreHFr?=
 =?utf-8?B?MXM4VjNzR2lZL2VzWUhta2trMjlUbHB0WXQ2K2xoSzFCeEJyZXBoUDVncWtM?=
 =?utf-8?B?SmF6dG5KbUoyNVhzVUd0cU15M0picW1PMzQ3bUJhUVd3dTBrMWZwZVM3M1Jn?=
 =?utf-8?B?dUdLVmZ1TC8wWUZVVXBwQ0tHN2J6N3Z5TmtMVlZJeDQyQmh1OERUMTJxUElw?=
 =?utf-8?B?WGthMXJockVLeHZ4ajJtVTJzSENDSG5rN21UZ1p2OUtpbW1wS2tSR0l5aHEy?=
 =?utf-8?B?bSt5SGg3Wm1Za2lzaUhJajJQMFhGcXJrUUdSREdOTzFGS25zMFVnVkt6dU4y?=
 =?utf-8?B?SSsxV1FTSFN4MVpIdlFDWkt4QkE4clR0eURTbXV0a3QzU3hiZnlERXF0Kyth?=
 =?utf-8?B?dEtZUktHOXdrczVndHpyMTJrZ3c2TWt2RlZkU1V2cnZ0ZWwzWGd1c0ttaG82?=
 =?utf-8?B?bWtTM3pTVDRjUU1jZDVnTWVjT3N0NHkrUWVvZkgvWFZZK1AvMklpTkdqa0Vm?=
 =?utf-8?B?dlJyZXNrS0xXZ3R4NXhKTXd4VDBTNWJKQUZJVW9STVJKUzJpcWNlV3hmNkdQ?=
 =?utf-8?B?MEdyaFc5SlRKb1dZaGxLVHdxYndBL0h5Rk5sZUE4VEhPeWQ1RVpDbWxzQU5C?=
 =?utf-8?B?a2ZBYUlsQ1I3bHBTak01M1ZCcEVLR1R5UU9GWHBhdFVZRW9QdHcvM3cyUHN4?=
 =?utf-8?B?bzVBZk1vNE0xRHJVRXZZM21hT0NEYWR4NlNCUmxvS0ZaVXptWHE5b2NFZkVW?=
 =?utf-8?B?bEJseUlMYmM1RkhSeXByM1I0YXJWQkh3OVpXQXFqdnJCVDVmZ0tBQURGNEE3?=
 =?utf-8?B?SWtISjhjTUNPMFM5QUlYQk4wRWh0ZWdLeWk1Vy9BcUt5d28yQVZ6N1ZDTmVk?=
 =?utf-8?B?a2ZOaWlqVXBSbm56eEl6T054Ui9rVHcrZVZURFNXaGZUMW8yakJ4a1FaRUVj?=
 =?utf-8?B?N09vTkphRkhWK3dNRDc1SktZZEhndiswNTc5K3ZQNURlSE4veEpvTk9wckd6?=
 =?utf-8?B?N3JFT3VHbVdXSHBhOVBjK3NDQmFaYWhDMkoyeVNiR2VSZWF3dkh6cEFOcUZS?=
 =?utf-8?B?UnN3S3BjKy9OK0dXdER2S2dLWFpTT0JnemZ5c2lwcEdPTEgwMjFTOGk0S0VF?=
 =?utf-8?B?amlHTkVQRUMwdHJPMzcrZFRoUXViWDBaWEVYbUNPd2FKY1luVXNEVXdiWW9D?=
 =?utf-8?B?dzF1a1p6V1JGL1g1UGFvUllaa2VYT2FsZ1BhNHFPcUZCVjdUakdubkdmMTAv?=
 =?utf-8?B?SFI0UDJBTjZpQ0F0WVZkVUcvYU9TWmRsMkdjUDNpaHRzOVBpSndGcTI2SlFI?=
 =?utf-8?B?SUVoUDduSzVOOWFoeTBUMW5HbW4rMjcvWTg0QTllc1pZblhMUEtndlluUTZo?=
 =?utf-8?B?a01BcmFDYkhkM3JZL0Q1QkNJZENhVHRQVXA3c1dOVzZOZk5TKzIzNEIwalJE?=
 =?utf-8?B?d01oMVJ5bU5kRngzdnRNVlcwZ2habzZtVlVZRHpwRmV3YXhYbElFQmQyRlBH?=
 =?utf-8?B?cllLWDdGWCtRdlNZeFl2d0tXeTdlYzFTR0tBRlBINjNCNEhnZWR3dXJrQ043?=
 =?utf-8?B?dVhZM3NBcjVrSnlhSGM0c3AxWFU4azJ3ajFEQm93clpzY0U5WmxiWm5iR1Aw?=
 =?utf-8?B?ZWxZbmZEQzRkS0hBK2tLcjBqZTV3aU8zTUxpRWRXUW1ocHRGYy9Yeml5ZjN0?=
 =?utf-8?B?VlRReHVoOXZnbEczS1lYQmpHOFR3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba2f6b4-e5a1-44cd-ba1b-08d9b9acb9fe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5192.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 18:09:35.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doHA3pLiXAju+/vVDS6AofsO94WTAHr/XI+UGNpLINRNB4sVMs4zw3KEy5y+hzQLoo4WHT7CNlTo7iZ4V2s2JSTAsTsaNx54RLMfi8r08j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4965
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070112
X-Proofpoint-GUID: F8-2pwo4FlvMw9UFGkxuhIeGNFp1-mWT
X-Proofpoint-ORIG-GUID: F8-2pwo4FlvMw9UFGkxuhIeGNFp1-mWT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2021 12:36 PM, Pavel Begunkov wrote:
> On 12/7/21 15:51, George Kennedy wrote:
>> git bisect shows that commit 54a88eb838d3
>> ("block: add single bio async direct IO helper")
>> causes the following UAF: KASAN: use-after-free Write in io_submit_one
>>
>> Tried to root-cause the issue, but need the patch submitter's help in
>> coming up with a fix.
>
> Hey George, thanks for the report. Do you have a reproducer?

Hi Pavel,

Forgot to include it in the cover letter. Straight from Syzkaller:

#ifdef REF
Syzkaller hit 'KASAN: use-after-free Write in io_submit_one' bug.

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write 
include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_fetch_sub_release 
include/linux/atomic/atomic-instrumented.h:167 [inline]
BUG: KASAN: use-after-free in __refcount_sub_and_test 
include/linux/refcount.h:272 [inline]
BUG: KASAN: use-after-free in __refcount_dec_and_test 
include/linux/refcount.h:315 [inline]
BUG: KASAN: use-after-free in refcount_dec_and_test 
include/linux/refcount.h:333 [inline]
BUG: KASAN: use-after-free in iocb_put fs/aio.c:1161 [inline]
BUG: KASAN: use-after-free in io_submit_one+0x496/0x2fe0 fs/aio.c:1882
Write of size 4 at addr ffff888027c338a0 by task syz-executor873/15100

CPU: 2 PID: 15100 Comm: syz-executor873 Not tainted 5.16.0-rc1-syzk #1
Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7860+a7792d29 
04/01/2014
Call Trace:
  <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x89/0xb5 lib/dump_stack.c:106
  print_address_description.constprop.9+0x28/0x160 mm/kasan/report.c:247
  __kasan_report mm/kasan/report.c:433 [inline]
  kasan_report.cold.14+0x7d/0x117 mm/kasan/report.c:450
  check_region_inline mm/kasan/generic.c:183 [inline]
  kasan_check_range+0x18e/0x1f0 mm/kasan/generic.c:189
  __kasan_check_write+0x14/0x20 mm/kasan/shadow.c:37
  instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
  atomic_fetch_sub_release 
include/linux/atomic/atomic-instrumented.h:167 [inline]
  __refcount_sub_and_test include/linux/refcount.h:272 [inline]
  __refcount_dec_and_test include/linux/refcount.h:315 [inline]
  refcount_dec_and_test include/linux/refcount.h:333 [inline]
  iocb_put fs/aio.c:1161 [inline]
  io_submit_one+0x496/0x2fe0 fs/aio.c:1882
  __do_sys_io_submit fs/aio.c:1938 [inline]
  __se_sys_io_submit fs/aio.c:1908 [inline]
  __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f43c5504289
Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 
f0 ff ff 73 01 c3 48 8b 0d b7 db 2c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffda542ba68 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f43c5504289
RDX: 0000000020000400 RSI: 0000000000000001 RDI: 00007f43c5c14000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004006f0
R13: 00007ffda542bb50 R14: 0000000000000000 R15: 0000000000000000
  </TASK>

Allocated by task 15100:
  kasan_save_stack+0x26/0x60 mm/kasan/common.c:38
  kasan_set_track mm/kasan/common.c:46 [inline]
  set_alloc_info mm/kasan/common.c:434 [inline]
  __kasan_slab_alloc+0x71/0x90 mm/kasan/common.c:467
  kasan_slab_alloc include/linux/kasan.h:259 [inline]
  slab_post_alloc_hook+0x55/0x230 mm/slab.h:519
  slab_alloc_node mm/slub.c:3234 [inline]
  slab_alloc mm/slub.c:3242 [inline]
  kmem_cache_alloc+0x15a/0x2b0 mm/slub.c:3247
  aio_get_req fs/aio.c:1028 [inline]
  io_submit_one+0x122/0x2fe0 fs/aio.c:1875
  __do_sys_io_submit fs/aio.c:1938 [inline]
  __se_sys_io_submit fs/aio.c:1908 [inline]
  __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 15100:
  kasan_save_stack+0x26/0x60 mm/kasan/common.c:38
  kasan_set_track+0x25/0x30 mm/kasan/common.c:46
  kasan_set_free_info+0x24/0x40 mm/kasan/generic.c:370
  ____kasan_slab_free mm/kasan/common.c:366 [inline]
  ____kasan_slab_free mm/kasan/common.c:328 [inline]
  __kasan_slab_free+0xe8/0x120 mm/kasan/common.c:374
  kasan_slab_free include/linux/kasan.h:235 [inline]
  slab_free_hook mm/slub.c:1723 [inline]
  slab_free_freelist_hook mm/slub.c:1749 [inline]
  slab_free mm/slub.c:3513 [inline]
  kmem_cache_free+0xfe/0x310 mm/slub.c:3530
  iocb_destroy fs/aio.c:1080 [inline]
  iocb_put fs/aio.c:1163 [inline]
  iocb_put fs/aio.c:1159 [inline]
  aio_complete_rw+0xa0f/0x1010 fs/aio.c:1440
  aio_rw_done fs/aio.c:1510 [inline]
  aio_read+0x352/0x4a0 fs/aio.c:1537
  __io_submit_one fs/aio.c:1830 [inline]
  io_submit_one+0x478/0x2fe0 fs/aio.c:1879
  __do_sys_io_submit fs/aio.c:1938 [inline]
  __se_sys_io_submit fs/aio.c:1908 [inline]
  __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888027c33800
  which belongs to the cache aio_kiocb of size 176
The buggy address is located 160 bytes inside of
  176-byte region [ffff888027c33800, ffff888027c338b0)
The buggy address belongs to the page:
page:00000000dfee8ade refcount:1 mapcount:0 mapping:0000000000000000 
index:0x0 pfn:0x27c33
flags: 0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
raw: 000fffffc0000200 ffffea0000714400 dead000000000002 ffff88810649da40
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888027c33780: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
  ffff888027c33800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff888027c33880: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
                                ^
  ffff888027c33900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888027c33980: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
==================================================================
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 2 PID: 15100 at lib/refcount.c:28 
refcount_warn_saturate+0x111/0x200 lib/refcount.c:28
Modules linked in:
CPU: 2 PID: 15100 Comm: syz-executor873 Tainted: G    B 5.16.0-rc1-syzk #1
Hardware name: Red Hat KVM, BIOS 1.13.0-2.module+el8.3.0+7860+a7792d29 
04/01/2014
RIP: 0010:refcount_warn_saturate+0x111/0x200 lib/refcount.c:28
Code: 1d fe 0e 02 11 31 ff 89 de e8 db 75 04 fe 84 db 75 9b e8 02 75 04 
fe 48 c7 c7 60 57 53 8f c6 05 de 0e 02 11 01 e8 a8 32 7a 0a <0f> 0b e9 
7c ff ff ff e8 e3 74 04 fe 0f b6 1d c4 0e 02 11 31 ff 89
RSP: 0018:ffff88801885fc90 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff816856a5
RDX: 0000000000000000 RSI: ffff888026f78000 RDI: 0000000000000002
RBP: ffff88801885fca0 R08: ffffed1020f27911 R09: ffffed1020f27911
R10: ffff88810793c887 R11: ffffed1020f27910 R12: ffff888027c338a0
R13: 0000000000000000 R14: ffff888027c33890 R15: 0000000000000000
FS:  00007f43c5c0d740(0000) GS:ffff888107900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f43c5c14000 CR3: 00000000247fe000 CR4: 00000000000006e0
Call Trace:
  <TASK>
  __refcount_sub_and_test include/linux/refcount.h:283 [inline]
  __refcount_dec_and_test include/linux/refcount.h:315 [inline]
  refcount_dec_and_test include/linux/refcount.h:333 [inline]
  iocb_put fs/aio.c:1161 [inline]
  io_submit_one+0xfd2/0x2fe0 fs/aio.c:1882
  __do_sys_io_submit fs/aio.c:1938 [inline]
  __se_sys_io_submit fs/aio.c:1908 [inline]
  __x64_sys_io_submit+0x1c7/0x4a0 fs/aio.c:1908
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f43c5504289
Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 
f0 ff ff 73 01 c3 48 8b 0d b7 db 2c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffda542ba68 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f43c5504289
RDX: 0000000020000400 RSI: 0000000000000001 RDI: 00007f43c5c14000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004006f0
R13: 00007ffda542bb50 R14: 0000000000000000 R15: 0000000000000000
  </TASK>
---[ end trace 8c5b816eed9c8016 ]---


Syzkaller reproducer:
# {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 
Slowdown:1 Sandbox: Fault:false FaultCall:-1 FaultNth:0 Leak:false 
NetInjection:false NetDevices:false NetReset:false Cgroups:false 
BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false USB:false 
VhciInjection:false Wifi:false IEEE802154:false Sysctl:false 
UseTmpDir:false HandleSegv:false Repro:false Trace:false}
io_setup(0x3, &(0x7f0000000040)=<r0=>0x0)
r1 = openat$nullb(0xffffffffffffff9c, &(0x7f0000000000), 0x24080, 0x0)
io_submit(r0, 0x1, &(0x7f0000000400)=[&(0x7f0000000140)={0x0, 0x0, 0x0, 
0x0, 0x0, r1, 0x0, 0xfe00}])


C reproducer:
#endif /* REF */
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

uint64_t r[2] = {0x0, 0xffffffffffffffff};

int main(void)
{
         syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
     syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
     syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
                 intptr_t res = 0;
     res = syscall(__NR_io_setup, 3, 0x20000040ul);
     if (res != -1)
r[0] = *(uint64_t*)0x20000040;
memcpy((void*)0x20000000, "/dev/nullb0\000", 12);
     res = syscall(__NR_openat, 0xffffffffffffff9cul, 0x20000000ul, 
0x24080ul, 0ul);
     if (res != -1)
         r[1] = res;
*(uint64_t*)0x20000400 = 0x20000140;
*(uint64_t*)0x20000140 = 0;
*(uint32_t*)0x20000148 = 0;
*(uint32_t*)0x2000014c = 0;
*(uint16_t*)0x20000150 = 0;
*(uint16_t*)0x20000152 = 0;
*(uint32_t*)0x20000154 = r[1];
*(uint64_t*)0x20000158 = 0;
*(uint64_t*)0x20000160 = 0xfe00;
*(uint64_t*)0x20000168 = 0;
*(uint64_t*)0x20000170 = 0;
*(uint32_t*)0x20000178 = 0;
*(uint32_t*)0x2000017c = -1;
     syscall(__NR_io_submit, r[0], 1ul, 0x20000400ul);
     return 0;
}

Thanks,
George
>
> One spot I don't like is how errors from bio_iov_iter_get_pages()
> are handled, will test it.
>
> diff --git a/block/fops.c b/block/fops.c
> index ad732a36f9b3..211f44974d1e 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -342,7 +342,7 @@ static ssize_t __blkdev_direct_IO_async(struct 
> kiocb *iocb,
>          if (unlikely(ret)) {
>              bio->bi_status = BLK_STS_IOERR;
>              bio_endio(bio);
> -            return ret;
> +            return -EIOCBQUEUED;
>          }
>      }
>      dio->size = bio->bi_iter.bi_size;
>
>

