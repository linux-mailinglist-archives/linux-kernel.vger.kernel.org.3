Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA06C4C8049
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiCABTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiCABTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:19:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA731519
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:18:59 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SLkxb7009931;
        Tue, 1 Mar 2022 01:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=78X/H5zf90bXeuGJATSx0g0BM4dbFOBb56DOWNT6poM=;
 b=vj4y2GLKHWy81FJz36bhh/UVuVbTktjpQk/GipJ8030YUrPbDFFnXAuLkp81pFinaVA8
 QlfOVTf/8iJY0ifl0H4tjLlp1neLnYBIO8pWIWeAYks/xTuUFBNyU1D7RxjrvZLYdtP2
 FYfzlyLb5qjhUqu/vnZWt3Z+Q0tpMS9kmqt3R7QRXp3/6XTWKP2pvnAHbSaAVs1ql7KO
 rmb4jWKzCsutKEjRrSKmrvnx4Qgi5J7mDo/UcDio+2CEhlsLUyZUOSYohJQ7wz+qrh/B
 cdXq8IrkkR53wwE8D2ZpxgX62/0merFgqWHvliUMJL4nVecPpv5VxiIWXQu98+91dEW6 zQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14bsb68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 01:18:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22111ICX172697;
        Tue, 1 Mar 2022 01:18:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 3efdnkq9m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 01:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXlyH51NZgdK5KZaemroAOne0FGq38YGpd+k1eZ0q13+3jHwkDU+vys24zSHMtHPXZYW/sRyq8xvODGm9aCxaf8zt9J++UlLXLKhHU3ZJLwq5Jp8zCuEuo5SPzaYareOSr4TePEPhLkRCuQA6NdUBvdQ8N65zqKWVyA2yynaH9pw21x6YafPn56CC+GPRDX/XJbz2aGfzI4kq2FUdCkElPCPYw35aUeXq49jgbE7x+BYb+G0pMmT3+l9SNflSt0o9jCvNU7G88Nw3kPQrgcf6Oj6jOl0hzgNO3p8RCDLPN1R+MjKxmHjH6sR3JwJ2eV/St/zLCNXyIF1BvHycpiihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78X/H5zf90bXeuGJATSx0g0BM4dbFOBb56DOWNT6poM=;
 b=OEaQyMXyU4aNN05K0kCc3JblpEEtw6wADCUdRail+gitWE8MzXqdo2IsYoPP1AA1K7cx+IrtU476KNXYhZubp0FzAzt147ZrhB2j2ZKWnsklJxgud3qhLcCZwwJP0XpzgDecT4VOVGmrvMP6q2BGymGvPHmbh09CNRF5DHS2un1LCOL8a35S2MkXLIhSimnFJj1AZM7NwVHYPdihUn/4ceAW+Ygi7vBmz2rrlTKMb3bkAF0R1UDYmpdc7EtmTnaD5cWw20MX7jIOaaWm5t0S3HwzJ6H05d6cnHmpHJYKJzKx34kZiGDXTWbZpZCuAQf3IXrZmLbRxnUUqBeGLzaWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78X/H5zf90bXeuGJATSx0g0BM4dbFOBb56DOWNT6poM=;
 b=pOhkbwi7ujYP+dwVimCD9/W5xMVwO94nF0m/i148CgtBW/w5iqK7KblqoX9sMJW+aAM8uU1ZP+AdrKdGNAp8AtW1QJMgxcHq5AYO/lJGGzelvXG4bz2QCEM4DZ778hgVRt4y4s8Kasa9+G6NKdBjxGjVqocLFyHrdxLiosnASWE=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by SA2PR10MB4668.namprd10.prod.outlook.com (2603:10b6:806:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Tue, 1 Mar
 2022 01:18:21 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 01:18:21 +0000
Subject: Re: [PATCH v3 0/1] xen: fix HVM kexec kernel panic
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        joe.jin@oracle.com
References: <20220224215049.2845-1-dongli.zhang@oracle.com>
 <9de1059b-6b48-e2c8-60bc-f29b42b217f7@oracle.com>
 <36014dbd-e63c-cf49-dafd-2d7a8b84db5d@oracle.com>
 <8e3e4716-22e7-8684-394c-b5a457906975@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <a6d64481-cb70-d797-fafd-b827288f7e53@oracle.com>
Date:   Mon, 28 Feb 2022 17:18:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <8e3e4716-22e7-8684-394c-b5a457906975@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0065.namprd05.prod.outlook.com
 (2603:10b6:803:41::42) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 218b4bb7-e483-4edd-36d2-08d9fb215fb2
X-MS-TrafficTypeDiagnostic: SA2PR10MB4668:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB46683B00FC468371E1EB612CF0029@SA2PR10MB4668.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2LTV73bT59bOkRP7wM/mfyHzFCM+XGfXNPI+epPYSs1qCf3jGmUUM8SVBsNJnd5CGOVuIqnXVFjzjE1Mm5FZOnuSxxTao8LLf16ZPFNkFRT0cLIm+bzXu2wC/vj5tC6BFbDQd79ssLX3KWO74xxJ+oHbqgarWkwSBAgS1xSPEqZWEdVgIc6T1hx0p10z2SlI7feyJGlOJvlUE5vL3i1duNTPPHNwUie/ey1eh8fvh/tChpIc/kjEmV9vNZ1Vjco79QZMOGOzzZUT9oqXHROyOjXN/PMTcAXdu916jgr0CL02ZNqHGe+Ydzbo3RcTiy7/q2X0cNIbX1KaG4O3zAiYoAHWMNB0+D8g6TEJr9sZ1UYK+L8E9J0smceOuHHPVAMsvft1N+OEkERzXsyghF3DuJrrMoOTP+Wc9EI0KG2bzzvfDi56bc/uHPjFJ/L6C2G8Ax2QJaiIQoRFV2COcwPYrcOrsKqw4Aj12XXk9K/yXeiRCo3y1oTL3AZ5MFqF6PM0vmRVuzInd8wdQiUizGx+G5gWSZgYU/WLKGhkF1QSxver6I5F5CcSFcNTmthfgYowUCfD8NcbN5VCn0U4zqCx1OY7MHdOYzh+akA6EPryRLOAQTfWO/1URRDcJqd5Vi9ENhdZzJGukDj6FedQXOrZ9Psc/2vkOQT+kVKHsfm5RiEmXuzsLtVkqIyfNgbiqa30aaUPXJfGHnwvcYCFeDpgySWpXsh5kwbz+N30ktuh68=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(36756003)(53546011)(6506007)(316002)(6666004)(66476007)(4326008)(8936002)(66556008)(38100700002)(66946007)(6512007)(107886003)(186003)(31686004)(44832011)(7416002)(31696002)(86362001)(2616005)(2906002)(83380400001)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG1YRXNVNTdoMGlQS1Yvb3lsYTJnZEV1UXZHekFFT0lLYkdlekR5bEYxcjQ2?=
 =?utf-8?B?Y3pxTjVlci9zSS9qRkg1aUl4NW1rUUgycEpnSlVyRFJZMmFyNTY0SGxYd1ZI?=
 =?utf-8?B?dmdoMk5wL01kSFRUYVpyZ09iRkxwWVFtQXpRYm9tZTB4ck0xdVJucHJJQTQw?=
 =?utf-8?B?bXhFdVd1YW1DMVpuNW84RjFsQi9OVnpjR2NRSWhRUmZZNXVlSVptdm1ScWRa?=
 =?utf-8?B?VXNvRWlzdGdXeUR1Z3VqdmFmMzIzUWlFUDZ5eUovcFpPcFd6aWhOWXFnODRJ?=
 =?utf-8?B?UVBCbUVDRmlWclFNS0lXd1FsUSt0MlNPblViY1lNUURmRGdkZmRzSUR0K1dM?=
 =?utf-8?B?ZzcxamlJc01tQ3huWHRHUkhsY2dOQlVhWW04SU9IbDVUZE5oZUZmWlpZZnFZ?=
 =?utf-8?B?SWN6VkVYaCtZc3pDd3FnRVdTQXo4OEhKOGdZS3Z0R3cwRDBGczhXd0ZhQ0ps?=
 =?utf-8?B?SWpjM1QvUzRSNzB0alMwVlYwMk51R2s4NDJlZlZualRXVVBUQkZVVmgvdXZw?=
 =?utf-8?B?WHNGamlLWXRrSUR6YWdTdm5rZkR5a3B4OXdqTlA2blNRb0JrbjJBcFF2cUxQ?=
 =?utf-8?B?elY3UVJ5S2xXQ1pEZ3NlOHRFNmt0ZFp2UDJ4VVBlb1BzcVdHeDE4dGI2ZW05?=
 =?utf-8?B?TzRvMEdLZDNMK2FiZTdDRy8xMlVXbjQ2ZFVPZmVQSmZBVmNtVVhSUDg3akF5?=
 =?utf-8?B?ejRTd0JSdHBhQ0x1WklKa0MreEloa2QrUkl0Q01qdlc2RVhCcFVTaEF2akll?=
 =?utf-8?B?QnR4cFZOUmloS2lxdmVYNGs4K3pGWHZpbUgxNFl3dWVMZkxucVlDUzVqT08y?=
 =?utf-8?B?MGM4MHp5dHdib1kyWkZuazM5ZzJNakZpYzRtRlNtYy92OUJFMG1iY1lReGRY?=
 =?utf-8?B?VFJPMktUL054YWFuTS82VjZvM1V3QTNiUmptaXBhUXhBQ1REcmpmcm52VEJx?=
 =?utf-8?B?eGl3Q0VhMzJjSTRmd2djN1JYaE9CQk12cnBoOElNZTM1L0ZiM0pLc3I5TmM3?=
 =?utf-8?B?Rm9SaENlYVpwMTB5K29IT3VCYU9ZTDZxeHF3cUt2bit0eG9nTXlMblJ1QTZz?=
 =?utf-8?B?c0hjZHFsbTQ5UDJRbmNDRFdWSHowbG1FNXdkUEo2d1R4U3loRGhmeWxwdXl3?=
 =?utf-8?B?NGlSSUFscTZRZTJRZ29yQW43eHhLaVlNU1h4NnQwVjlEYkwrai9mbHVGRThM?=
 =?utf-8?B?WDBGRytGK3FUQWNTZUhpeVNQcXA3Y3doaEY3YmJPeUxYMHIwbU5OMThYV041?=
 =?utf-8?B?SDQxOHpzWXl2U2dDenpJcTE5bXpLOHJXQmt5ZnZsSUpZZXpxV3JEUHl6WUh2?=
 =?utf-8?B?U0Y0MWdBU3AxdU1GMUIxa1Nod2FXOUVrKzkrb1I3MGFGOFpEMXNjaG9SeVU3?=
 =?utf-8?B?TVVnaS9GcC9CQXJhMzZCdXU0N3VCQnUzNDNGM0ovL3ZsZEVLVWJoa1RFUytu?=
 =?utf-8?B?cGFsWERmNUdIa3FOUVB0U05TZ0ltaHlRUHgySElWT1ZHL3VBUmN6UUd4ZHAx?=
 =?utf-8?B?QmJwYjUzN1pvbEhMdHRXVkRsOVd5ZUxlOTlsUjJrdUF5N1pjVnJtNC8vSlRu?=
 =?utf-8?B?YWNCRzZRTVZRVEEvUkI4WDNXZEFmcVpkc21Xd0FXMC9JTG9WbmlnRXhBRUph?=
 =?utf-8?B?UXluMWE0amp1MjhlZnVwVVB3SWNIWXJuWGEyMnhWdmhrQk03V2ZCWXNYVDFW?=
 =?utf-8?B?TjAycU5mMEMzRzVpcjB1aytTSDJ4QUN0eXVlalhRL21RWGRlQWF2TlJPZ0Rm?=
 =?utf-8?B?czl5Ty9JR2ZIVE5KTnd4OTBWdHJHUFBJK1U5YnVrZFZ3SWhJSUlmdHRyQzlO?=
 =?utf-8?B?ckdIZ0I2OFhjOFgza0F1NzFsa2dEcEdHaUwxcE1wSW5mbmFySVA1SnhLWkI5?=
 =?utf-8?B?V254dWxDdUdSMWh1MFVjZUNFcXpJTVZ5K2hMZ0RMTFM0NjI3Yml1OFFaY01R?=
 =?utf-8?B?c0c1alN6Zk5FUzR6M3NoZjVRRGhNenhYU2J5MHRHdVZGWVFPT0pQcnVUSFh1?=
 =?utf-8?B?ZkQ5VmhuK3NOUm9uMGszYWlNQ21Mb2tVb3pVQU9hQjNlcFlCaDFsQXNhbkQz?=
 =?utf-8?B?ZmViSUZIZHNFYndhNjNqYkI3RFNjSGVPOGtvYUpHSzJxZ3dCUllXOExTeVpL?=
 =?utf-8?B?RlEyem5wZldxUmRYSDFMUGNiQmdoc2FjVlNUcU1LenhQRWxTRUw2NzNCWjZI?=
 =?utf-8?Q?oEaEdrV83vA78ICePxSs3fQfR5NfeuYYsZ/6JMzFVwgN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218b4bb7-e483-4edd-36d2-08d9fb215fb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 01:18:20.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DCWVz1lP4ZFydBrgWksfL/fsd2QPZEOY8EUt4lo5olFCqF/JD3+NkRjnn1XPsg71A3Y9bxAzymihL7/mMu0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4668
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010004
X-Proofpoint-GUID: o5g6Jbc0krjkzoho8xAWDaq4ZliYCjiN
X-Proofpoint-ORIG-GUID: o5g6Jbc0krjkzoho8xAWDaq4ZliYCjiN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 2/28/22 12:45 PM, Boris Ostrovsky wrote:
> 
> 
> On 2/25/22 8:17 PM, Dongli Zhang wrote:
>> Hi Boris,
>>
>> On 2/25/22 2:39 PM, Boris Ostrovsky wrote:
>>>
>>> On 2/24/22 4:50 PM, Dongli Zhang wrote:
>>>> This is the v3 of the patch to fix xen kexec kernel panic issue when the
>>>> kexec is triggered on VCPU >= 32.
>>>>
>>>> PANIC: early exception 0x0e IP 10:ffffffffa96679b6 error 0 cr2 0x20
>>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
>>>> 5.17.0-rc4xen-00054-gf71077a4d84b-dirty #1
>>>> [    0.000000] Hardware name: Xen HVM domU, BIOS 4.4.4OVM 12/15/2020
>>>> [    0.000000] RIP: 0010:pvclock_clocksource_read+0x6/0xb0
>>>> ... ...
>>>> [    0.000000] RSP: 0000:ffffffffaae03e10 EFLAGS: 00010082 ORIG_RAX:
>>>> 0000000000000000
>>>> [    0.000000] RAX: 0000000000000000 RBX: 0000000000010000 RCX:
>>>> 0000000000000002
>>>> [    0.000000] RDX: 0000000000000003 RSI: ffffffffaac37515 RDI:
>>>> 0000000000000020
>>>> [    0.000000] RBP: 0000000000011000 R08: 0000000000000000 R09:
>>>> 0000000000000001
>>>> [    0.000000] R10: ffffffffaae03df8 R11: ffffffffaae03c68 R12:
>>>> 0000000040000004
>>>> [    0.000000] R13: ffffffffaae03e50 R14: 0000000000000000 R15:
>>>> 0000000000000000
>>>> [    0.000000] FS:  0000000000000000(0000) GS:ffffffffab588000(0000)
>>>> knlGS:0000000000000000
>>>> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [    0.000000] CR2: 0000000000000020 CR3: 00000000ea410000 CR4:
>>>> 00000000000406a0
>>>> [    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>> 0000000000000000
>>>> [    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>> 0000000000000400
>>>> [    0.000000] Call Trace:
>>>> [    0.000000]  <TASK>
>>>> [    0.000000]  ? xen_clocksource_read+0x24/0x40
>>>
>>>
>>> This is done to set xen_sched_clock_offset which I think will not be used for a
>>> while, until sched_clock is called (and the other two uses are for
>>> suspend/resume)
>>>
>>>
>>> Can we simply defer 'xen_sched_clock_offset = xen_clocksource_read();' until
>>> after all vcpu areas are properly set? Or are there other uses of
>>> xen_clocksource_read() before ?
>>>
>>
>> I have tested that below patch will panic kdump kernel.
>>
> 
> 
> 
> Oh well, so much for that then. Yes, sched_clock() is at least called from
> printk path.
> 
> 
> I guess we will have to go with v2 then, we don't want to start seeing time
> going back, even if only with older hypervisors. The only thing I might ask is
> that you roll the logic inside xen_hvm_init_time_ops(). Something like
> 
> 
> xen_hvm_init_time_ops()
> {
>     /*
>      * Wait until per_cpu(xen_vcpu, 0) is initialized which may happen
>      * later (e.g. when kdump kernel runs on >=MAX_VIRT_CPUS vcpu)
>      */
>     if (__this_cpu_read(xen_vcpu_nr(0)) == NULL)
>         return;
> 

I think you meant __this_cpu_read(xen_vcpu).

I will call xen_hvm_init_time_ops() at both places, and move the logic into
xen_hvm_init_time_ops().

Thank you very much!

Dongli Zhang
