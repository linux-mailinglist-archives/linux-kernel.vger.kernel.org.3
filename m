Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF224484BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiAEAYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:24:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14826 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233081AbiAEAYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:24:17 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204NiLJq008818;
        Wed, 5 Jan 2022 00:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gz9UkKZkCs0sSKoASTxZUjAugADGM6p6Nio8t2WIEWI=;
 b=fSuPRshGg2I2LN0BbHxftlk7w0g71hXuJ6t9FX/seBnBJ5btnaNFHvjPpM/KGKVTZ1YY
 0B7cyWXJpp1RB3mSWM5zlUEdj9Bh2TPK1kJfSPwUwCawHIb1EEIK0yrz22yy2Gkbgaow
 ET7YBEZQ+j/wF5ckpesLYkji8cZaOpQrqA2tKwEiyFyOUMAMzmQso8tKHk8z4ieBzAhQ
 UozsLsBdQRDUx58P7un+SPtozdZR5WDXB3biQML3kxUujzUqhrnQSSpsnXoqalziNbI1
 Kkp+4xrgyb5gdEe/brhrG2tljfzHsNCkFesE/+wiR2IXRh6aB0qt4rsLoI4FunBfIubg fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4kmcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 00:24:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2050FFmW172180;
        Wed, 5 Jan 2022 00:24:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3020.oracle.com with ESMTP id 3dagdpedmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 00:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBZVGYxt5dRpUbTXggBZTECWgljYVePHs5kBapeeddDn4yWzuWsRfKUo0U+UtyeT8dfVTQ56uY8V/83I3NjWQSGhOLjH+JuT9rIJxstQvQ41H5RAfoQ19ne6BiOZi0daW8TcojXy3ejAilQWMZ1+fCSY/iscLWWgQU5rMtsz9q50G6OoKky6ergKiTT4iM4MkBi9cRRMWT5h49aenbB3dEP8/+4cSuWV1MKiE8onylqzjiNM1KFYR4YUzhmNUOTColuGvQxSsyjbXTma5TEGNnXAOrDSUk4dQth6qAUKaYJXoMPk3hYvoELGoBJvbeAYwYiLyuQmUmmsK6bUC0ICIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz9UkKZkCs0sSKoASTxZUjAugADGM6p6Nio8t2WIEWI=;
 b=bGSTdsN5mWd2yW8QtV1j0GVVpfkuXOlIiYVaNQ2T8+/gU66vI3hhlL35N699XveKZKLw97N7Do+xFBM4famvrxTmCHC4l2FbpiGgFXLVaFt7ox6dRWAm3+YAc6/x4SvNIQSoJ24aWw/VPl4hhsNbXJ0zi6E9h7mLsLWsBTGZb9IIxVhZvfQvIWOYylnGNngj1Kw4UESEQOGABW4vhJBKZx7um4X2JZLpJgkH6bRVIaD9uWFx5MyhWJPY9qI+zj3TLjvLeSYH0R9J8eDpzXI4/WZYIr7LWCWfa1msXhvfh51LDdndHmUAxK3W7WVZe04mX4CIdWbqojnblwys3cg0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz9UkKZkCs0sSKoASTxZUjAugADGM6p6Nio8t2WIEWI=;
 b=Wq+BgNG31mje0/DlRFmkfWzlsWODuOL9kT4rQS/l7bbH44kn2WC+i0wU83eb22bQgePTz2U4POeLclZMb/KU+vOUq6RnRojzg4mY21Lc3bJhvtFGAKnjaO7ow+mIpHLWFy8JSD7o33oZq7eMm/YVisFct0K53xNn1KjndgjcYq4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2744.namprd10.prod.outlook.com (2603:10b6:a02:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 00:24:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d0a:ae15:7255:722c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d0a:ae15:7255:722c%9]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 00:24:05 +0000
Message-ID: <4e811968-4467-daf7-eb59-1e1827371ebd@oracle.com>
Date:   Tue, 4 Jan 2022 16:24:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] userfaultfd/selftests: clean up hugetlb allocation code
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220104021729.111006-1-mike.kravetz@oracle.com>
 <CAJHvVci5sSC-1TEiCBKe8uKQ=0uwCsoBJT_fsG1Rfq6ffy6Obg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <CAJHvVci5sSC-1TEiCBKe8uKQ=0uwCsoBJT_fsG1Rfq6ffy6Obg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:102:2::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e578ac0-60ae-4e4a-27cc-08d9cfe1ae93
X-MS-TrafficTypeDiagnostic: BYAPR10MB2744:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2744E9108235D505B92DE70EE24B9@BYAPR10MB2744.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8UyMA9m33xAHurK9XuDEin0YWKcQYxQI5OeabgubPeSwLaE2mEhATDLHtwgLX0xPNtFemw8IUIAOQYLrsCiWGFqc9lrRLMxsJ5IZi1bMK0MCM0UHoP5G1ddMAt4h6InQpoJwQYGZj/c9IHVh3ixr8aFRUYegVQSbvpJRHiOenvltrtRH8w5/uy8rciTNCoxRSJQ3HxPnjv49hU85aXf1r7b/LL6h8xz09ZpGm9pOtlk//xN70yFCKm74i9YgTodmHZizmxqzRHpQYMqDNG3sDy4e4rdZ7WTos6tuTIatc6ppzwjmyZ0MTD/0TpBVybfufiIZAA7lbmX4syLj+Ge3NKPynxVHRWpEx3KOKpaIalK8jHTJwZLc2xNAFbQnJY/OgbHunun4Fr9fuuujCfnPtUW3iFyA2K07Ax3Kk524F3LulZBJyQ+NbU54lF4x8LmmAH1lY+zWNNhhdiwMUvAJ3on7nQGPfyvOit1+15RhbCrgo+nbxZVFUPRXLJSSo51JYuA3f/5uYMe7cP4DbgLX6CBKc2yiTklYBC2v6BQWxtKYvf4eae8bDDP1R549cpV+W9HkzzjjRUzGFIGeHChZXFBHqwTDZFZGP62JUNELUF1oLNe5T65/Sy6R89z6NVvi6AJ49LYCu0DYne1K+XTi7ZBqY6WwSFqvp931hpGgAAEXQj5PAcA+b5lBOug4CO331RYfClUkR1xIKnxTK+ul2eenIL56cqTZu9rKSpuMMQjkecY54oss74IJlGCmUNw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6666004)(316002)(4326008)(38350700002)(38100700002)(4744005)(2616005)(186003)(6512007)(86362001)(66946007)(44832011)(53546011)(66556008)(52116002)(2906002)(26005)(83380400001)(8936002)(31696002)(5660300002)(508600001)(6486002)(66476007)(6506007)(54906003)(31686004)(36756003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWhlSUxhM3k0WHV2ZkFKVk94Q2U2YTF6NjM1bG5sNERuNlNMQ2NFWU5NajRI?=
 =?utf-8?B?NTVudzV2VjZJdW53WHF2WExUOC9VMnVsRTFVWmtuNnZYRzJRWVJlTk1sNUNL?=
 =?utf-8?B?ZS8xVlEwS3Q3dUp0aVBoV0JuUjFEU3JNbzFHY2d2U0NPUUpoZ29iSDUyZHRJ?=
 =?utf-8?B?c3NCR1RqVzhsdUs0RFpNV3NucWJOU1g0cXV4SUJMNDg1cElmTk1mdjQ1WXBX?=
 =?utf-8?B?UU9acHZnUHdOMmRpalZpSWZHM1FCZ3ppVjBsVkl0dTRoVHZ1UUo3d05sK2pL?=
 =?utf-8?B?VEVCczRzODcxZHh0R0FVYy8zL3lEY0gwSWwyY0MvMGRIV2RkbFB1c2t4cWN5?=
 =?utf-8?B?eEJMSk5JdVBoRm5WUFhOT1NxU0hnRXVrT1RRNHN6bXdkb0ZyQ2dWS2ZVOEV6?=
 =?utf-8?B?VGtNMGlHaTFhZkFqT21pY2srSVp2MmxIbCtYYU5OamZPKzliTW1CLzN3VWVr?=
 =?utf-8?B?bDNRMWRQY0JNWHJQYWxLR3c3Z0JXendMS0phbzBsNGJMdTVMTlE2ZzU3SVIw?=
 =?utf-8?B?U3FGelM4czhzWGpKNnNiMHAydGxaRk04YytYVG0rRnRraTdwa2toNk9jNksz?=
 =?utf-8?B?eGZ0T0VVQzdDbFg3UlFiR1FsTjM1QzFOeFVkekFNcytCbGFwNEphS1JLeUx1?=
 =?utf-8?B?eFJ6YmpiOEdXdjhqTFVadG0xczkvLzZwZm5VazBvRU1rbWFNOE85QWJsc3NW?=
 =?utf-8?B?Yng1bEw0R2J4RHlkTThoMjFuT3VLNlovR21MQWRQQzN3bmxZM2RRYU1SSE5L?=
 =?utf-8?B?Y0ZZbFlGUmF4RTcvQXEzVVdTTFJLcTIxVU9IaHR2U01DSmJxay9SUHk4Zktk?=
 =?utf-8?B?WHVmWmhza1I1Qm5WQWkvbzRJZm5ZZHlaQlR5d2I3UFN3ZnNvNU5zRUN1V2V3?=
 =?utf-8?B?RWpVeEdQQnpmd1NqcnZUdlJhWnArNG1Ja0F4V1JnNXN4ejFVdm1nTEJiY1JR?=
 =?utf-8?B?TENFQTZySnBnZXlyQkt5QlBoa3ptbHhMUXp2aU9CSUltWmVNTnhtaVlnZWhX?=
 =?utf-8?B?MnJEM1FubXZxaVFjZ09tV29VSStwZ2dKMzNsZVd2R3creHd4M2o1M0dES0ov?=
 =?utf-8?B?TWNFaXFJb3lVNHFwRU1UV3NxbENVOGcrWng0Nyt2MlhkcXIwVWlrbEVzTVIy?=
 =?utf-8?B?bkEvU3BJT0NSZjhycCt0S0J4SzlFRDRMUjRCYVdXMzNoSk1udWo1My9qMjZ1?=
 =?utf-8?B?UGhxRWx4YnhlMG1hb3FTODhsT3d2U0Yyd2lrcFdYbjVMZFNzNEtuUGJPQy9K?=
 =?utf-8?B?RHg2QkhKWHd6dE11Rm9JVFA3Y0xDS0JNZEt6bCttN2FVajdTeWI5OXRXLzNT?=
 =?utf-8?B?V21sTzc2WmEyMDJwOUtkenY1Y25MZVBIcE9MMFVQK3o2TUp2OGdmWmZDQ3Fp?=
 =?utf-8?B?RlhiSkYxTlBpWlFPVEdPbmVrS0dWVEZncmlCY0hqWi9ya21HTmNLblFMY2h0?=
 =?utf-8?B?ZElwL1poYWZnRmZicCs3L2h5VW1NdnFGN1k5YVJqRklwRms1QzVrNVd3NUl0?=
 =?utf-8?B?Y1N3Zy90MEs3STRMRXZtQ0VLSVlvdjZ4NE1qbHVIdEg4NmREcmJJZVZDbTB3?=
 =?utf-8?B?cEhnZ2dSTmpHbnU5d09vblIxOEx1WFY1QlF1R2wxSGhhT0dEdVJSM2NuM21u?=
 =?utf-8?B?SXMzRGVvbEdNUjFQNGFyTk5MOTJaQWNhYkxSWDYxRjFxSzB3cnRGYzZCSzhM?=
 =?utf-8?B?Nk1ZVk5HL3VmaFRpRCtyczUvMjlTenNVOVI1N2lqM0RvbGg5dDhPOHBYYkg0?=
 =?utf-8?B?LytUVldveitUN0g5TEVJMDB3SnhPRnRhWWphbHl3WFpHN1YrZFhHLzJlVXlC?=
 =?utf-8?B?VG9FT3dHcEgzaU5OYnVJYlZ4bzJKVUo3dUNjZ1FEcm9nWW9RNEdVaEZFd0hj?=
 =?utf-8?B?NlNiaFJKYTdFbmpuRkVlWlRHSmVELzMyeVNKZTZ2ZnRKTDhNTEduSzZsdFhl?=
 =?utf-8?B?MnU4V3JNb0tySDhtb2NoQ2d4VHlmS1lQQnhITEhxcUtiUW5MTUs0WThYSVpV?=
 =?utf-8?B?QXhPdzJLUkt1L2k1bjBSK1podmVaOEZUOTY1SW14eVk0RXBwbUlpeERBL2tj?=
 =?utf-8?B?aVhLeEsvcTNka2k0a2R2OThzVExEUmtvc2IwQTkvSXl1ZWVnN3hhUlYrS0VY?=
 =?utf-8?B?c3Mxa3ovNHNKbjVXY212TGZLRmxQMjROTDc4WjJyTUxmbkhhdGgvSnBSV1VY?=
 =?utf-8?Q?hURP2g8+RaBTrIRPCy/V3PE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e578ac0-60ae-4e4a-27cc-08d9cfe1ae93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 00:24:05.5293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ+bC0rfHU2NM294J5JPmHgqGNtbiBfTdCyTpKowRZ2fN9gkvpPqmYuqZkhuFvuJ1FyUOfRP+Qq6Rwebx9OynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2744
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050000
X-Proofpoint-GUID: hzUgrL-vsup_0pHTsDhwlEp7xR9Ueytm
X-Proofpoint-ORIG-GUID: hzUgrL-vsup_0pHTsDhwlEp7xR9Ueytm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 14:35, Axel Rasmussen wrote:
> On Mon, Jan 3, 2022 at 6:17 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
> Looks functionally correct to me besides the one style gripe,
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Thanks Axel!

The userfaultfd test is not so easy to follow.  While looking at this, I
noticed that we skip the mremap() testing for hugetlb.  However, Mina recently
added hugetlb mremap support.  Unfortunately, mremap hugetlb testing fails
if enabled.  I am still trying to determine the root cause, but would like
to eliminate this special case if possible.
-- 
Mike Kravetz
