Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B5A4C7AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiB1Uqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiB1Uqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:46:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824222B06
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:45:51 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SIJH9t010133;
        Mon, 28 Feb 2022 20:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1wKjj3LnwUWytX/Ia3WLTLQfLa8LC04ESZNTlgZQOEI=;
 b=lC23NQlfrrd2pQnPdQAMEo1ip5xVwnTTBzMrvNwsHbDRbEIA6k+Vo9FNwUscGpQ5RxmR
 4Yk+pcJ8BKquIojX+INN7yGzEiCoS9RBmKm4bj0GFYAz0XkXmqNQ4K9FxvjY4GLgaXJE
 2MdsZdJt9bJER5dmIYF+zOuC4hr1Dv8NFSLe9kiTwLXuLEfS2YC3XrbhT4lZPQuUeZv7
 g2H52LWkf+5O/pd0U5gXE6AQ1QeDaAIrcZZFps9ydqDfeX86PcGmx1oVl0E2/wzWC0rd
 XabPSSpFe6lVr+s9pbVR4/QpBT7pNnry+2Y9WznKgmdOIqnRBvr4Czm2+/2KxfjTYZuw jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k40tdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 20:45:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SKjJ2q068547;
        Mon, 28 Feb 2022 20:45:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3efdnkh3jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 20:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpKw0++e5B0dNEPyH7Ij5zOB+b3A+7sUBoDQfxv+gJlaBbeZdcjflq3o8M9dZ5SwLJvD4w63QUyDurorhCQUyB+A/BWOX8bkh3lLJYWPUeUgGGJ+sYn6mJrEy90oAWmT+zKAJv5mg14OjnmM1fsc7qg29DiAyeP4bUw59qW2F3xjLrj44D3tTORlZGUOpCTIwnY5IwHIowglret4OwiadRuXcAeCNRSUXmXuf8y+VOT7Ch+4BJ48m4gwsOp6sbk7tJLW+Cw/Nls7KKS6aeaF2fT5wMZ9nV06yqCQnp/nmEqASafUtUyOyA1O04eeoMzJFf1A+5z8k6ZvFMLRt2rHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wKjj3LnwUWytX/Ia3WLTLQfLa8LC04ESZNTlgZQOEI=;
 b=daihD9HgHpQRln8mgDRIpiRm9KdEukG27Wu+tQ4X72b3r3O8cHZjWoXw1zBlE3tI6E6uNgXUqIniCG95U/eletUytI0D1Vz/YUrGD/YEbsVtCfWaUqDNu6JvySsWEyBWAoh9RZnaRkaMG2xF4BpH2utStHqfeXMwvl62lg7n31I8uYjM8kuEwOXv9dyYVoecKaaJ7bfkm6L0FMBCB0RRzGia7mgFM3AupMVu8i43Spvs/XjTCUBb33V1YVChcKHKzl/Zz2q1LbIPiKUhAtZhiR0Qb5mQdehsx+bkGTSSdeQuItUB/E427cTHpnkXR8pcZFdis2o62Vx/HgBNl9zgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wKjj3LnwUWytX/Ia3WLTLQfLa8LC04ESZNTlgZQOEI=;
 b=gvg/icPTVj6ajSdzWaQsobNHRSbsr/fLzbbWE4waZ0y9857yyckHteYRxdv2jpioGSbwP+7TqcBd3qvHXdYJgHv+XXulKYhjI6WjbTUL4OA6qb+kJ8AiJoA4XGus+W5lAkH2+/FNW9kzKW2eUqAYv1BkuGCp/9eQkE4oAINDYYU=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MWHPR10MB1999.namprd10.prod.outlook.com (2603:10b6:300:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 20:45:17 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::6d20:6694:a16:56f7%3]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 20:45:17 +0000
Message-ID: <8e3e4716-22e7-8684-394c-b5a457906975@oracle.com>
Date:   Mon, 28 Feb 2022 15:45:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/1] xen: fix HVM kexec kernel panic
Content-Language: en-US
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        joe.jin@oracle.com
References: <20220224215049.2845-1-dongli.zhang@oracle.com>
 <9de1059b-6b48-e2c8-60bc-f29b42b217f7@oracle.com>
 <36014dbd-e63c-cf49-dafd-2d7a8b84db5d@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <36014dbd-e63c-cf49-dafd-2d7a8b84db5d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:806:120::34) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b4b2d61-127c-4e75-d85b-08d9fafb3a83
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1999A5401E0512596C8AF1A28A019@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IB0KzyDtqkq+i5vFBqTvNjT1fYbOMUPLtKSp4Z/JmXS9fpFU0ekslLjaGvCcOE76YcNOOpX2b6rvkonIqhBWaEMUIU9Y5+hByte+hbjO1xtTr2aphtVFS+xKpOZllc2dBLLtmPj0vM6sw4fcwraZ2l+PDrO94QqSjAVNGZflTy5GBSIQj/x0VZBOE/AdTR4bhVrV2hRCXL/Mwi7+Qd/3xbXWanv8gaT8bcwJ4JLExpOma01/B+FQ9hesxqwY09LDeyvsRDtS79yQaPP37Wq7TCOaDeK9Gqf58lAZGnruGor29G63bc9T2Sl98+05YAkWaWT9eilc9iYChCsM1lWQTiDZQdHbjpKdftjqEudNK85K2yeO1JenRZiO62xqvKxB328wuXrrjUXFxJiMruGYHLXaVpXB/lYLnQrzwr04HYzBxbk6YaL1udM3nxjX81KiVSGM7N+h35fqs/B7IPKB3A434UsXBIEFPZ0cnC7jh4wJ1a++yL/paO22LYAkcEr3XnM2sswOHNto6eQPKXg9ZiOKqlnmb9bMXBT5lbM4Z6GG0cn8P0qpKS29uQ0rr2BDWVL061/+fyQ9zPVAKU0iyXRLmCJdAO5odrVsszp9DT6ZUFAW0Oa/x+i36ol09IOeTpP5IPZlfT4FCIpP6G0kBB2e0/2DbDz/MPl6vyes2Hcl8gar/3elX0hpmPYUyw7atWC5KtT6O2YepBQno+3GhpOlM6xmypijSsxbxSBezrlGe+YP8iRQ5QUkPQJ6KUg6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(38100700002)(86362001)(5660300002)(31696002)(44832011)(7416002)(2616005)(6486002)(316002)(26005)(186003)(6506007)(6512007)(107886003)(31686004)(6666004)(53546011)(508600001)(36756003)(4326008)(8676002)(83380400001)(66476007)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0ZtUVVSZDFLeUtXVFRjWHBBdVppbjVZcWpTVitGaHdva1pVN2JObEtnbkg4?=
 =?utf-8?B?NW9udGovcUIxcVNQOUtmTy9PMnpIbCtveTJtakVUczhlcmMyLzBQdGFoeEdn?=
 =?utf-8?B?NjR3OXE1bVZrUnMzcG1oK29BT0xzQzlyZXRPQzhOa2xTRzdueXI3QUt1SHEv?=
 =?utf-8?B?eEtXV3VBelhEQlR2cXJ2TTE0bkFCeDBzb2NvTFRNdDgwR2dCWFNJL1VLdkxU?=
 =?utf-8?B?MWRHRUMyZ0tkZEJpMTNJdHg5Z0QwMlpIUDBRQkxrSElzV2g3S2x0czFFalUv?=
 =?utf-8?B?aVM0Q2JuWlo0WWN5bmRiRDZBYjMrb1RIOGJqWlFvcXgyRDhrVXVRMWd2QXlQ?=
 =?utf-8?B?emx2NTlRWDRFZGd3YmxKWFVBMWpuMG5Oek1zZzZjL2pzQ001bzY3aXdQNnlO?=
 =?utf-8?B?bjdvZUdLemQ3TlAzdHV6bFhGNEErRWxOVmxOd0xETWF1Tk9FV2Q2Ri9HRmE4?=
 =?utf-8?B?WUJLVlh3OG1Zc0ZYWkcvSW92M21GWXlnY08relcxTG82RkFLeFF1RXRNSi81?=
 =?utf-8?B?TFhGYlY5TVhaajJZaW05dWdyZnYvN09LUWFBaWt2QUsxQ0hzbTVpdEU3MmZZ?=
 =?utf-8?B?ZGNCamV0UE9BajQvN0NXRUZkMUJ3QVBlK1ZEVmkrMDlJbHhwZHk0b1hONlND?=
 =?utf-8?B?OTJaemoxNnpHZjZXSVBpY0pLM0JpekZyTmlDRjJjUmZWRnZFaDJNK0R0Q2xw?=
 =?utf-8?B?WkJIM3pQRmYxTmhIWUF2Y3VtYzNVc2RtZ2ZSYmtNc1JHcE5NV2hZMVRWUm1r?=
 =?utf-8?B?Z3l4QXlRMWJJOWZmeUZPWkJqbnYvbWZxSC92TE9ZYW9sRU5PSG9hc0k3M0hx?=
 =?utf-8?B?VTJIRW5MRjdZb3Y4SVJpdlcxVnB0SWdhTEJBa2lGZ1dqcWljbFFHMzhUdTJD?=
 =?utf-8?B?UEtQelJINVc3UHFOdDlielh6ZldTN2Z0TlBjdkNKOXhjWHZVcEtyak9qOHlP?=
 =?utf-8?B?VlArenBqUUJ3N2VDVUFYUzgyVXZWaXh6enlaREcyM2NGY0JsRjRUZzJWemQw?=
 =?utf-8?B?MWsxc0hhSjlnQ08ycDVvOTFWalFYczlJNkxLamFpcW5abUVydjFWNktsdkFR?=
 =?utf-8?B?QmFpTUxDcExlUnMzcVlUeHd1amtKeCtFZWRqbXBySWFJUFlHQjhNbXRoOFpF?=
 =?utf-8?B?Y25lU0FvL3puVmpkWkM0SWRacHVtcG4zU2o1cG5YbjVEdUxmMXczcVg0dVMr?=
 =?utf-8?B?MlpzajdXMkRhN1NIZ015S2RPNXpScENIcHpDU0ExSVVvYzd2bWZRNWhKLzA2?=
 =?utf-8?B?N2xnYVo3bG9jQXQxNTJYUURqOThINDIzV3k5aHVKSUhhQ2RTYW1IR2pOWHRh?=
 =?utf-8?B?Sm1OQ2g4VWt4R1hrdUNsNDdyM1pEOGt0d1ovYmdqbjIzRXU3YTlHTklWaHhM?=
 =?utf-8?B?S0xxbEtCcGVnTVhDL2xDdWtNU21BVG9BL3dlYTVKK2grOXY1MG9vMEZYOTdi?=
 =?utf-8?B?eFFhMHhYZkdtWXZEYVIwMVJQTm5pa1V1SldacW5RMFVoZ01NRmIzV2xFYWE2?=
 =?utf-8?B?QkZsaXNKdjl5dDRveWt6UlNQNms0c2tPOFFaS0oyZnd5N0tJZzhrd3k1TW5n?=
 =?utf-8?B?ZXZhRnJIWFA0TjFWSkhYV1U5TkdjN3RueDZWVWUxWk16NmpZUDR6MjZzVXlW?=
 =?utf-8?B?dW02eUQwWnJZbnN1Wkpwd3VYWGpWSEZtN3IrdTVISTFFYzJkUlRkZ0NGeVpk?=
 =?utf-8?B?elMzTHVaSVdhZFpLNnVxUHR5bElmeXAxRTJUK0U0U3RFL2Y1Vit6OGtXeFJJ?=
 =?utf-8?B?NVU3NHpGcEw3cHpSLzU0YitqODZtMHhFOWdLNFR0bTZVcHJLeVlKMEVrbmoy?=
 =?utf-8?B?dXA4NE93TDA1Q05oNTVQdlViM3l1RmxpMTByc0czbGhoRlU1YktHcVlETTJQ?=
 =?utf-8?B?QW9WNnc0alpvNFdHL1Z2YlBtNks2ZkJOcjNmV2tyV3RvOU81ajdVWFFmUUwz?=
 =?utf-8?B?bE95dEZ6ZEFFcW1URGZTeFBnM0FReUpSQU9lMk13RFc5d1pQNGttR0JIWkUv?=
 =?utf-8?B?U0w4Mkx2SjR2R1VPOTJpTFJobVd1OFNFQ3JiQWRNRjBqelBlWHhXV2I2Q09J?=
 =?utf-8?B?L1FuWjRzRzhqR0JFZ3N4RU52QTZud2l2SlhZYnAxcHQ3aGI1bVA3K3lsejhy?=
 =?utf-8?B?ZTJQMTZjWERyYjdsK243b2tpbU1MYWs0Y25GVXZlWGp5SFFvdFdUSnkyTkxH?=
 =?utf-8?B?ZkpRU21QNk5pVzNVVDE3emgrZUdKOVFSVlJUU2xlSFpNbm0vWEt1c2luQW4w?=
 =?utf-8?Q?TkGTEYnQIyKWn6E38fjz+Ewm8RJjbM77yNjsac6Kns=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4b2d61-127c-4e75-d85b-08d9fafb3a83
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 20:45:17.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6IHEUtWpBtFsXlTcvByx0SHxwtzSVVbZ7lhxcSPEi16aAwjp+7zH2a6GL31ogOMnzw531dmx1dajwF+oAk01o1lKd8rLpMMeT54uvP1SU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202280103
X-Proofpoint-ORIG-GUID: aIpQspA_c5pa9-fSlnkase4cvay-cBy2
X-Proofpoint-GUID: aIpQspA_c5pa9-fSlnkase4cvay-cBy2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/22 8:17 PM, Dongli Zhang wrote:
> Hi Boris,
> 
> On 2/25/22 2:39 PM, Boris Ostrovsky wrote:
>>
>> On 2/24/22 4:50 PM, Dongli Zhang wrote:
>>> This is the v3 of the patch to fix xen kexec kernel panic issue when the
>>> kexec is triggered on VCPU >= 32.
>>>
>>> PANIC: early exception 0x0e IP 10:ffffffffa96679b6 error 0 cr2 0x20
>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
>>> 5.17.0-rc4xen-00054-gf71077a4d84b-dirty #1
>>> [    0.000000] Hardware name: Xen HVM domU, BIOS 4.4.4OVM 12/15/2020
>>> [    0.000000] RIP: 0010:pvclock_clocksource_read+0x6/0xb0
>>> ... ...
>>> [    0.000000] RSP: 0000:ffffffffaae03e10 EFLAGS: 00010082 ORIG_RAX:
>>> 0000000000000000
>>> [    0.000000] RAX: 0000000000000000 RBX: 0000000000010000 RCX: 0000000000000002
>>> [    0.000000] RDX: 0000000000000003 RSI: ffffffffaac37515 RDI: 0000000000000020
>>> [    0.000000] RBP: 0000000000011000 R08: 0000000000000000 R09: 0000000000000001
>>> [    0.000000] R10: ffffffffaae03df8 R11: ffffffffaae03c68 R12: 0000000040000004
>>> [    0.000000] R13: ffffffffaae03e50 R14: 0000000000000000 R15: 0000000000000000
>>> [    0.000000] FS:  0000000000000000(0000) GS:ffffffffab588000(0000)
>>> knlGS:0000000000000000
>>> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    0.000000] CR2: 0000000000000020 CR3: 00000000ea410000 CR4: 00000000000406a0
>>> [    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> [    0.000000] Call Trace:
>>> [    0.000000]  <TASK>
>>> [    0.000000]  ? xen_clocksource_read+0x24/0x40
>>
>>
>> This is done to set xen_sched_clock_offset which I think will not be used for a
>> while, until sched_clock is called (and the other two uses are for suspend/resume)
>>
>>
>> Can we simply defer 'xen_sched_clock_offset = xen_clocksource_read();' until
>> after all vcpu areas are properly set? Or are there other uses of
>> xen_clocksource_read() before ?
>>
> 
> I have tested that below patch will panic kdump kernel.
> 



Oh well, so much for that then. Yes, sched_clock() is at least called from printk path.


I guess we will have to go with v2 then, we don't want to start seeing time going back, even if only with older hypervisors. The only thing I might ask is that you roll the logic inside xen_hvm_init_time_ops(). Something like


xen_hvm_init_time_ops()
{
	/*
	 * Wait until per_cpu(xen_vcpu, 0) is initialized which may happen
	 * later (e.g. when kdump kernel runs on >=MAX_VIRT_CPUS vcpu)
	 */
	if (__this_cpu_read(xen_vcpu_nr(0)) == NULL)
		return;

	...

-boris
