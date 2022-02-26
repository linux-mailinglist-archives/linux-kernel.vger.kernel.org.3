Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C274A4C52FB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiBZBSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiBZBSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:18:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79C37A37
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:18:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PMoCJA017475;
        Sat, 26 Feb 2022 01:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RhEiP+/Ax28z9eZZ/auAHLTVRUyLy3kmKT/2fDdzMDQ=;
 b=CXN2CIFls9Mn65PXGueGTjBoC9sRmuOEDKIv8ds4HQdqWTEoZvoU/X3oRfGTcD4Q/ky5
 CVQyk1/G0zfZCE23YHLlac2z2Iv81yxx806fzaQn700+XBsQlZnxECQj9sYva5EbGR04
 l5/pS5hzwUrOwPHp/L+4XNxukUyrAx2T2Upr8fULaySNtpG/bs7Zx9citeqdWDOihFO6
 ecKQ4qJSasxGKNghVIyASWUUK4ylYVPdJR+AGsXu36pzj5NACYYFGyjat05G+6KKQNFg
 WfYUnBY23GZxTaq4L54/BMNrll1qzyAOHo1iNVIiNBqHwklk6OHAMOBJw6mf5ScdaEmp AQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexa8td7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Feb 2022 01:17:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21Q1H3Ei059710;
        Sat, 26 Feb 2022 01:17:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3030.oracle.com with ESMTP id 3efa8a8dra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Feb 2022 01:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcfZGPma64bbSGUfeJDod6NxIvFWiCQufrLc78Dq4u6+p0A2g+Dwr1iDPpKlXGgRdzmlc6RYaTBGXpT3nZGKsrWKnNa1/eZGlMPrlvMP2o42XK9vCThielhAPILi5x1Zvvx4KGndH9tZxB/VTLZhzVdWaCKSUPOiVZZl+L236+7bidQV4nLDSg0HvDuCSsdTiFyUMnp4FI5OeFuXn+kh+emutJ/4djEmUCUru/WsJSVZx9Skl1d0fd5FZYqEH9TfebBdSRGHMI9Nw+d5K6cOEEDfy1NkZbDdGFkxhxOQ+MrH132CMuoG+4OQF9kLPCjonN/q+RfSgsKmtJ6koETLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhEiP+/Ax28z9eZZ/auAHLTVRUyLy3kmKT/2fDdzMDQ=;
 b=an2sERoeq5TUkECbBmT97dLW3DHobz3Qx/q8uRQR05UaNiIwgZaZM2EXpJiPRRBIxOWZ2GLrujkwwmYm+hXPDvGfGKw7RHB8WQCY4c+GX/0dtsC0wBDisMCfr9n/xSxpPy7db5Lg5bvXMJmD9/ttK9M7ov/bfdZKa891pQx3P4qG1g5G30+oTlkTybhps1IJyLwByzogz3gU6DjgvSdzwX6BeyMQNVsPIuNJ0ul9h2PnqXAvqi9rx+VsKHKF/YBvyXjhzJheZv4cqORaxah7rTBXJvsuE+cOtBGKs0hy12aYdVmAsCRDH4X4DIw5aAYOWteeFfUou444y/9a9AvMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhEiP+/Ax28z9eZZ/auAHLTVRUyLy3kmKT/2fDdzMDQ=;
 b=nwjes+WOpWZGLimQvaAbgM5zgYcZKyzZX+Gr7DpY1dsIO8OweXzknoJjfvzYrvErGj5Y7V3NBOkjX2Zmjxxii2QXLblXJ3IYV+QdLLyORjlu53enzsI31Kle9lK6Z6UCf8H3dG6SEibHDiL7UKgXJu6dCfCpRwnvfVpdQS4kb6E=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BLAPR10MB4994.namprd10.prod.outlook.com (2603:10b6:208:30d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Sat, 26 Feb
 2022 01:17:41 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.5017.025; Sat, 26 Feb 2022
 01:17:41 +0000
Subject: Re: [PATCH v3 0/1] xen: fix HVM kexec kernel panic
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        joe.jin@oracle.com
References: <20220224215049.2845-1-dongli.zhang@oracle.com>
 <9de1059b-6b48-e2c8-60bc-f29b42b217f7@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <36014dbd-e63c-cf49-dafd-2d7a8b84db5d@oracle.com>
Date:   Fri, 25 Feb 2022 17:17:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <9de1059b-6b48-e2c8-60bc-f29b42b217f7@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0002.namprd02.prod.outlook.com
 (2603:10b6:803:2b::12) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6472d60f-0872-40bf-9cf4-08d9f8c5c8c3
X-MS-TrafficTypeDiagnostic: BLAPR10MB4994:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB49942B359DE5F6F7439EFED9F03F9@BLAPR10MB4994.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HV4UygS7YV1SYqxLCXefJw27fmQoA9ajV7vSkTj74nK7J+87cwaek6R2bg1G9n9hy1HhiBcRwppCBmBGrYYkOqkdv4/Sw7IHaq/eNHD0705dKVC9hk2FxAJfawrepdYhn4MYNO4PkOoFqGy4LssLlFsnukGAn30VqAkepievhr2x4Bcy6nSoSWQsA9yslmEjn6lBPyqeaVVyRFwB+qDp7/ZkwbDkwTcd2w4/IFIdOL5cadmdF528Ceh2m69tD3wa2QAtNfSiP9lEwLVBp13Evc60fmK/ChNNmobQ7WOTFzCSOaT4frVP9A/+t5jMyE77nQ1SeLlZXBerCoi9z3qVKqwhr9G0AvIEdYBYodmfFAESkFoPh0eN4ABwq0K6Kg0jOCgJMnSK4dbFcfca33eLVTL6nLD0W+wbncUFQ56iB8+SC+ALqOYE48oESpJ5+BufbUqayOsAoqDbWz4FN8vrFR4Eh4/tVr8RmLYvbtmuJh5hqBcAKFV3ztECGC11ymK3+P0Aj263flvBs6NJ7qr/Yv/NHQn/Gpdsa6qI+ZUO3PBSnjrTsN2vugUC6fzh1QVoA7tfcab6rgJJu8Yg72y7D5sZ/j1thPvY23sClRKwxyzZujV9QIcbWgSv1gOZKgCZIkdtNNPxupBeqqSV2lbzlcI7m2lsSPC39kPjWbtEcl3BLPT3AosWkYhPSyIjJDKi8P2j+LDGnNDAHZUhJsd4fAaFcavNWcNiHtDECSeDHxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(36756003)(2616005)(107886003)(6506007)(6512007)(186003)(8676002)(4326008)(38100700002)(5660300002)(44832011)(7416002)(8936002)(2906002)(6486002)(31696002)(86362001)(508600001)(66476007)(66556008)(66946007)(316002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MERKSGJJVy9VdFVpaERtM3ZOOHJWNjNHR0hJRnR2aUN6dDgwaEVtcGdRZnZM?=
 =?utf-8?B?V2hZNUMyYVRjeW1Vb002ZTljSWEwZjAzR25SNWdUS3o0cjgzck1EZWJFOGYy?=
 =?utf-8?B?UjNxWWlVTjFhNE9kSjJzeWgzYnlSMUgrQ0pFMkpBU1p6RHFPVTFaTUpTUzN1?=
 =?utf-8?B?aEVMTDMvVURHWmtJbC8ralE1VkF2ajZrcUh4d0dES21oNzJyZ0RIS1duTGFs?=
 =?utf-8?B?VmNBVnFvK0gwTENhVUxjUTZ6WVFqdGdXQlF1VjM2QVF1eTVTMmpaczRmeHVi?=
 =?utf-8?B?VEpoYVVQSFhyR0ZGZ0xKSzgyUDRQSkx6bm8xMzhOR016NEkyMFJJalM1bmVm?=
 =?utf-8?B?S0sxa3VMa2dCU2Q3YWkvalc3SU5hQnVlMk5QRDRhVGVMQ0ZJQS9odjB6TEhr?=
 =?utf-8?B?bTNURzFwWGc5N0Era1p5eW9obFlTRHlZSERUWHdxWlpCUDdxb3RUME45UEI1?=
 =?utf-8?B?dFZDWXcrclVLTUl1NU5oN0MwVXhMZjR6TklVTGR4RG9Ta1E4Ykx6RGN4ZGNa?=
 =?utf-8?B?ek55Q29TZ3QvRXJ2RE5VV3kxazc4YmcxR3NEMVlFWTY5Q1d3eGtoQnFTbUJ2?=
 =?utf-8?B?RjJSbU50Y0QzeFdwN2J0OE5ta3FEa2Z2a2QrWWI2R0hwQml4VW1OVGE3aUpN?=
 =?utf-8?B?cC9xTjg3K2FPVC9UdDgxa0NHRFZSTDRxT0xLbE0rb0F1cjJab1Y5R2EzUits?=
 =?utf-8?B?ZXdiNWxWN3V1bWN0NUxmTDdTUE9QdldKQ2MzRDlLaXNzMWl3eGdVTXE4WGpU?=
 =?utf-8?B?bWFFeHpEdjQyZnVidHhZeDZpa0RNV3k1SXZMd3pZOC9IcEtyRGw3ZU1tUGNG?=
 =?utf-8?B?c09BMktPVXpyaC9tWlJxRzI2di9TUGlFazRnVUhERExDN0l5QmlXTVJHSUh3?=
 =?utf-8?B?U1R1OUdiWjd0T1FWMmdObWZ5bnp2L2pmcVRzMVpRWTE4WXZoWnU1U3lkNVcz?=
 =?utf-8?B?NWlBOEtjbHdVYVpmN09VQTJGdnl3QUx4YTNvYzBNMUx6NG1IdHZ4NUtJTlpl?=
 =?utf-8?B?c09NcWJFbXVGaXlpK3I2QlZ2bi9vQlZ5eDlVUUVhV3Z5ZnVMTS9jYnpMY0dt?=
 =?utf-8?B?ajBjWlUvNGQ5L2RSWE1McG5RczdDbG1xWmhiRjRSS3BEdHpoK1MyVTQ4bmJM?=
 =?utf-8?B?L3dMK21sQjgxOTdlNEJma28yWE5qSFlieEZNdWF4eHQ5QU1QN1dWcUhBWjYv?=
 =?utf-8?B?UDR1Mk84VFhKWlp2eUZITnQycGFpY2xnRlRqb2QyUDZaUDFibjhXR2dUbmhP?=
 =?utf-8?B?R0lkT0cwRXBiYlN2VGxzWmIzdFQyK2JUNjJWQ1NSYkZEdEI3bGRMTFlHbTNI?=
 =?utf-8?B?c240ZmhiMmhCSkhFUVFFRkhMQ25QRm5QbGMwTU9FN0NFTlNiNnNCNkpZY3Bm?=
 =?utf-8?B?NVZPOWErN2tDMGFsWVNzNkkzN1BmWFVydENkQ2F4UzFOcmNpaWhHbHVnbDNw?=
 =?utf-8?B?amNtb2I1UzRxcTdLZW95dGxVWFBzTG1mVWFxV0MxOStCL3IxWnRxb1dKWXhN?=
 =?utf-8?B?c0wvbHJNaXkxTEpXWU4vcDR1MGxRazBTeUZsQ09hN0Zwak5tK3NTTDgzNHlT?=
 =?utf-8?B?RFRkSm9MVXBFWHdhUm1tZGl6Wlc5VG1MM0JoenpwNXBCZkgvbGFtZWJUYkRV?=
 =?utf-8?B?aGQzaHJxN09uWC9YckxlTjhWSmg2UmdvWmdtdHV6b0h4bUlFNG9kRDVpcVEv?=
 =?utf-8?B?QXFmVTMxRnV3Yk54amlBRmp1NXM4TWFLb21YR1pkMVp2OGFQUUNIWHRWUTZl?=
 =?utf-8?B?WXJ1cFlQNXBXS1Y5eXM0MVp5T3pUSGtOMm8zd1M3ZDFGYVZNajVPUi9VMkkv?=
 =?utf-8?B?RFFrOXduVUhNTGRwVjE3UC9CdVFmdkhHSTJ4Rk9Ub0xVSHcrbU1zeDJjQkp2?=
 =?utf-8?B?MFRsa0prdXl0eitnb2ZHMmliclJQL24wUkg0UVA3bzY2KzZjMmFOaHhaNjJ4?=
 =?utf-8?B?dis4K2x4emd0dGhoZDREeTQxei9PbGlaUlpyaFdTYkV0UlhoSGRuSkxrNjE0?=
 =?utf-8?B?TWJDV0RHNENGc0RIZnl3bTRtT24wTSt2Y25meVVwTzZERnZLRlVFaVVHRU9F?=
 =?utf-8?B?c3RVWU9HQmY2TFRGZ3VXcHlnTTdTZVBBM2ZEKzJHYkgvSlhGY3hvQWpXK0Jz?=
 =?utf-8?B?MG5Wd3hhaU1YV0ZxWEhHdmlLZ2ZlVmt2dDNMZG1YY0RYYkFTOVNCbmU5YVpG?=
 =?utf-8?Q?pEG6V9U1hNzauE4d6qviYC4CROS4siRtnLJT2h7hcgIA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6472d60f-0872-40bf-9cf4-08d9f8c5c8c3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 01:17:41.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsjV00Ru4beszjnmAgas+Oi6RmDnDuIMVkoP7z3SHMiLcwRlBkQ/t3j6GTu/No6yJeoh05Mb4JZ4Ybye/ppNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4994
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10269 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202260008
X-Proofpoint-GUID: jQBbHsh6YXPabCjHkWNcA1QZQrgYC3m4
X-Proofpoint-ORIG-GUID: jQBbHsh6YXPabCjHkWNcA1QZQrgYC3m4
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

On 2/25/22 2:39 PM, Boris Ostrovsky wrote:
> 
> On 2/24/22 4:50 PM, Dongli Zhang wrote:
>> This is the v3 of the patch to fix xen kexec kernel panic issue when the
>> kexec is triggered on VCPU >= 32.
>>
>> PANIC: early exception 0x0e IP 10:ffffffffa96679b6 error 0 cr2 0x20
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
>> 5.17.0-rc4xen-00054-gf71077a4d84b-dirty #1
>> [    0.000000] Hardware name: Xen HVM domU, BIOS 4.4.4OVM 12/15/2020
>> [    0.000000] RIP: 0010:pvclock_clocksource_read+0x6/0xb0
>> ... ...
>> [    0.000000] RSP: 0000:ffffffffaae03e10 EFLAGS: 00010082 ORIG_RAX:
>> 0000000000000000
>> [    0.000000] RAX: 0000000000000000 RBX: 0000000000010000 RCX: 0000000000000002
>> [    0.000000] RDX: 0000000000000003 RSI: ffffffffaac37515 RDI: 0000000000000020
>> [    0.000000] RBP: 0000000000011000 R08: 0000000000000000 R09: 0000000000000001
>> [    0.000000] R10: ffffffffaae03df8 R11: ffffffffaae03c68 R12: 0000000040000004
>> [    0.000000] R13: ffffffffaae03e50 R14: 0000000000000000 R15: 0000000000000000
>> [    0.000000] FS:  0000000000000000(0000) GS:ffffffffab588000(0000)
>> knlGS:0000000000000000
>> [    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    0.000000] CR2: 0000000000000020 CR3: 00000000ea410000 CR4: 00000000000406a0
>> [    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [    0.000000] Call Trace:
>> [    0.000000]  <TASK>
>> [    0.000000]  ? xen_clocksource_read+0x24/0x40
> 
> 
> This is done to set xen_sched_clock_offset which I think will not be used for a
> while, until sched_clock is called (and the other two uses are for suspend/resume)
> 
> 
> Can we simply defer 'xen_sched_clock_offset = xen_clocksource_read();' until
> after all vcpu areas are properly set? Or are there other uses of
> xen_clocksource_read() before ?
> 

I have tested that below patch will panic kdump kernel.

diff --git a/arch/x86/xen/smp_hvm.c b/arch/x86/xen/smp_hvm.c
index 6ff3c887e0b9..6a0c99941ae1 100644
--- a/arch/x86/xen/smp_hvm.c
+++ b/arch/x86/xen/smp_hvm.c
@@ -19,6 +19,8 @@ static void __init xen_hvm_smp_prepare_boot_cpu(void)
         */
        xen_vcpu_setup(0);

+       xen_init_sched_clock_offset();
+
        /*
         * The alternative logic (which patches the unlock/lock) runs before
         * the smp bootup up code is activated. Hence we need to set this up
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index d9c945ee1100..8a2eafa0c215 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -520,9 +520,14 @@ static void __init xen_time_init(void)
                pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
 }

-static void __init xen_init_time_common(void)
+void xen_init_sched_clock_offset(void)
 {
        xen_sched_clock_offset = xen_clocksource_read();
+}
+
+static void __init xen_init_time_common(void)
+{
+       xen_sched_clock_offset = 0;
        static_call_update(pv_steal_clock, xen_steal_clock);
        paravirt_set_sched_clock(xen_sched_clock);

diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index fd0fec6e92f4..9f7656214dfb 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -69,6 +69,7 @@ void xen_teardown_timer(int cpu);
 void xen_setup_cpu_clockevents(void);
 void xen_save_time_memory_area(void);
 void xen_restore_time_memory_area(void);
+void xen_init_sched_clock_offset(void);
 void xen_init_time_ops(void);
 void xen_hvm_init_time_ops(void);



Unfortunately, I am not able to obtain the panic callstack from kdump time this
time. I have only below.

PANIC: early exception 0x0e IP 10:ffffffffa6c679b6 error 0 cr2 0x20
PANIC: early exception 0x0e IP 10:ffffffffa6c679b6 error 0 cr2 0x20



The sched_clock() can be used very early since commit 857baa87b642
("sched/clock: Enable sched clock early"). Any printk should use sched_clock()
to obtain the timestamp.

vprintk_store()
-> local_clock()
   -> sched_clock()
      -> paravirt_sched_clock()
         -> xen_sched_clock()
            -> xen_clocksource_read()


AFAIR, we started to encounter the issue since commit 857baa87b642
("sched/clock: Enable sched clock early"). kdump used to work well before that
commit.

Thank you very much!

Dongli Zhang
