Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B73B4794B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbhLQTRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:17:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40348 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235907AbhLQTRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:17:35 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHGXtnA027776;
        Fri, 17 Dec 2021 19:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d0TFOMFv8dxG01rJQp4drUaupPlzT89PH9sQ22SAG+0=;
 b=HUndmENenvkmubfk0Mropp5C8mhZ6y0jnTjxjT9tgY36uCwokHC/knGq7ou3uULLRqR0
 jOwRp9ix/GCT+YeMgkVSKyXXxm9Cd9y1Gm8vzj/vLvj+u0Ol5PNZNyspUTK7U4MTc+eA
 Kvfu/zNoC+cZcCvc4VmE+Ol0Tl0Xf5/Z50ouVC4BXMXBdlVVyOLtC0CBH6mO2xy/ddCS
 EmUKXZ4s5isrNHT3fBZnUX5N1SowGZrNWpwf8qeZU0fEWTXot8fJx+oK0//9XkqG0lxO
 WeTKyWdmo0ZIc5UavlkXaUkAPTdtspV5ayaLG/rRLU6UeUl5XUyJpNXUfEFXYHqCU3En jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmbpmen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 19:17:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHJGeRq034451;
        Fri, 17 Dec 2021 19:17:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3020.oracle.com with ESMTP id 3cxmrfa09u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 19:17:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNC4MWN9/YbAQpahy5CnYfI409V96D2BgZoXluETtxahAe+MXxtn95ER8DyU3jhibIgpFNbtHHEm4R5BeprUsyJqhWL6gAPi7tk9qIYsEpMrJ+fo0FyrW096Ac0/2qNTO+I+L+V49DS9etVKmhAyrHZnGcaWXahq0ase269TH5xonBRVPkNR0S2sXK2wLdAzV3qc0jhmqykKnwJdim8qnfTxNqXCsFdUH3cSoWqX59lpWGZehkjKDtK/7UJCLAB23vMJ6QQPHkD69QCN9Me1tgL8Jmjwoy13EDiFe3N+Lw9vajumP0U5/VzCdVzhaFT2V5pa0TybY/BJTO6z2iwm2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0TFOMFv8dxG01rJQp4drUaupPlzT89PH9sQ22SAG+0=;
 b=jQjnyghuiOoTywsxw7tq37Aqq+EM0kzp/OH/E3y2zFKIiA8DrevX+rd/VXWIcKX+3v33xc/4U5RBPUzBzvZQDkZbBcml3P5QQ9EyBjMfATZSZc7Y5TlfGPDTpM1fUnv27fbA1tCIHMiHSMaN5JJLVP0gBNRVPS7T97dMJo26sRGGIk49J/xIrukoscgIUYiyZLJflnIXHWwpzhgXf5kkKut0GbNbqb4Z6MAVUjTUOjVTenw5RThkBMyHfx1nClgSJr2q6hl+bU6uFqjKgr7kaFXk4L7K9DRMOwgeGBciQsAMOWRFloq5+Xe3B6LqKiyqkbH1Mgb4pXius2sfLOO1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0TFOMFv8dxG01rJQp4drUaupPlzT89PH9sQ22SAG+0=;
 b=jbJ7lerKwoe3d+12MglEQcMFH+eLavMyvTCPKPsaP6UW7AS20lhHNociCJ2CXKA3DHoQIvMrf1fa4kT/VxCdJaF6dge6d+N1/tmog+w/K//iMAejIMfESrmWddcHez/DAxy1qNnBBn0gTzlaYWxOBxhC9tOiHzvqFO7QHhLRGTY=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4157.namprd10.prod.outlook.com (2603:10b6:208:1dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 19:17:14 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12%4]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 19:17:14 +0000
Message-ID: <c6308cae-837d-1a77-cb93-6c9ad4bcd714@oracle.com>
Date:   Fri, 17 Dec 2021 14:17:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH V4 0/6] xen: Add support of extended regions (safe ranges)
 on Arm
Content-Language: en-US
To:     Oleksandr <olekstysh@gmail.com>, Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
 <1428a0be-b80c-f996-1f72-6545dd66c1bf@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <1428a0be-b80c-f996-1f72-6545dd66c1bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:6e::9) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc54b8c8-ba7b-4393-703e-08d9c191d55c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4157:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4157AFF5005A5EF31771E26C8A789@MN2PR10MB4157.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPB8NBp+f+thuIKY3YU/g3AurSLPi5BrWsuZJeXtPR9H4syKDPIWshAAMEwXohJBinv1zGpth+9PFBd8ST0GvbJyIkwNo/eYpz29SNxLXEH3HhExbwUckdrwB7AvZmBPzIguaVQ2pI8mLfoUK1Unsof5R2fAHYsGWD/2gaWKJiU2kHAefaXR+WBBiFzyY46dJmlkrdTpVDQiUnHC1IrXWsyS6/kgaZ/muc8v6s6DyUes+vaUIISEj7kIm1a3jISGQ3ZVZekb00HrKPR+eitgF8NXf1CqR2ukwlOvAtUqFRw3IjwkF8K8T1F1hJYBrWuI2dwKv0NJGxyMJmAcPWrY5UzU23Qvl4g9asIKbZtagNw+z2xi6PNXzLVdk+JyJeI3wWEcXZMSmG5/4GI1qNXoxa8jLXCetxn6XLi4Q93ZWGC14POQcnqHMhFybTljt+vAjKq2NGGuS4LHrvf4mtBspXcZXtsGHcs4cFEGwSspp72UQ0J59o/U00pEugwTOw5xGUx/QAHx0W+RRiRHlvEjZavIHE6bOXRtCbW0LICcaYnxgEb32zDOncHxnYJ9EE52ponQZu9b9x43YVciTpk8FT0QkZQ05x3jy5m3szzZCPygb2swC+GGP83SDMLfEo3bXPRpZgMF/bWYrDOa5OEC7aSafrUtB7GSzbyZ0d0NXPTYSSZvT19600kLNmU+RKQOxMY3O20mmIsp+Jfnz+jh5foMWq5+5dOk/d0H0G4by5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(8936002)(6666004)(558084003)(86362001)(44832011)(2616005)(36756003)(6512007)(38100700002)(6486002)(8676002)(186003)(54906003)(31686004)(7416002)(5660300002)(508600001)(2906002)(26005)(110136005)(66946007)(4326008)(66476007)(66556008)(53546011)(6506007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVlvZUEvNHNqZWVjdndvL2NtYmNKc3g2L2Ficm9LdFd5UUFHUHNIMElBYnhq?=
 =?utf-8?B?SGRBaVVQeFg3b1Q4RW9idEVvdlBRWmowT0IvUnAyRGZ2YWQvYmtPcWRCVjFB?=
 =?utf-8?B?WXFkYWV1N0Q5T2JWVFhiQk8vZ1ZhdC9acjRXaVF4TmRMQWJqdnd3akdoNFJs?=
 =?utf-8?B?Yk5jKzJrV1JMOGY4OVNkVC9Ua1cyMkpDSVVBUndMRDBoR1RWcS9ZWTQ1ZFYx?=
 =?utf-8?B?LzYvSlhUY3ZHclFKaW5xenlGSWEzV1VGeWlCMkVHV3RjeENGZ21YbjVMSDVv?=
 =?utf-8?B?RE9nNVZkR2thWndnSXM1K3hMWmFpWTVvYXpjQ2xKemZMU25JRjZoYm94bnBP?=
 =?utf-8?B?NW1YS3dyaTJBUWFkYWY4bys1MlgzeTRQRmVYeHJJeFlHbHQwSFlsNC9sejNx?=
 =?utf-8?B?eXJSYlBCT3RrNlQzdHdFT1k3Tms3ZTRFcDRndjBlQVo1TVZaTmlDYi84RUVp?=
 =?utf-8?B?SWMxaFJJeFUzL2lUcSs0cld1K1lLd3lTOGRnbktmYlE4a0svcGJZYjE3aVdE?=
 =?utf-8?B?dCtCQVp4aUoxUW1DZ2YvRkRpaVYxSjBVVDhzLzlVbDFvNXJuZEhsM3FwZW9U?=
 =?utf-8?B?ZjExZXFFVWRsaGtGZC9vTnlmK3BBTUIvV2E2UzY4b2wxWE9mR3ovQ1dzbkZz?=
 =?utf-8?B?ZmFVMHZsb1NvaGZ6ZXpvTHF3UFR1RloyZi80d3hLS0tCcDdBMjJuSERiQlBX?=
 =?utf-8?B?eXBKTm4wYm9RS1dlUFg5N1kwOTJJSGtYb2hLVC9HSXZzYWc5cmpYWWlBQWR1?=
 =?utf-8?B?UTF3WStkNFlVWnNURW9mQmNnOTQvV2NjL3JwSWMwWXlUNjRiQ1J2TURqQ1Bt?=
 =?utf-8?B?a0VCTGc5cUNoT3orVktxVXc0SnhjMjF1VDZBWjFsejN0ZmVWN200bGJSYjZs?=
 =?utf-8?B?bC9RMDdzdXlFUzVrSllsdzhOQVpsRERYRHlPaU1BbEhzRmZGdnUyTkw5UjJ2?=
 =?utf-8?B?VStvaXpTcDBmOUZ5dThRSGVQTlJTUjhwWldHUjVNOW90MjNVQ05UMWRaTXo2?=
 =?utf-8?B?YnV0NlBrM0QzMGxWMzlLdWxZWjBiQzFDUXJNeGFralp5OWh5YWNEcThwMysw?=
 =?utf-8?B?b0ZFTFA3UEljZjN4N2RVUVFrOHdKRURZSlA2RDFlT2p3ZTVRRDdGdk5YTjRh?=
 =?utf-8?B?akRrN2kxWFVuZlBoVFd4bW1UbG1ybG85Z3JjVVF4UnlIcG5Ub1FyWFBEd0RR?=
 =?utf-8?B?WG5laUg5UlE3SXk5L2NvS3ZnZmlTQUV3UzNjeERIaVQzVW1TVHJMNzUvRTVT?=
 =?utf-8?B?VTJOSVovMWtEa093Zm9pNURRdW5YdVExV2RGRFJLdVl6cVpMTERabFlVR08x?=
 =?utf-8?B?ZHNKR2dwMU1hcVh4MW9pRENyRHY3WU1lV0JPem4zWExMWTkxMDc2TVdsVmtj?=
 =?utf-8?B?MElEU1lLbmxzaEp1Uzhia1pYVS9XcFZzWVV5Tlo2TGZmeDB5bE54SE4wM2VW?=
 =?utf-8?B?TW53dGJOc1NUOHpsY0JaTmZrZVQyczJpT2xVcm51NWpVeG9oempZejRQZ0VF?=
 =?utf-8?B?NTljU2swSTNkbDdLdmFoT2tYbzlwRUNVNFJsbFlLdEFjNHlpeEpMSTI5QnVt?=
 =?utf-8?B?aXNmaXVJTWlJV21UbkQ0MnlrTGRoazNxNUIyTzVXYW1vdzVwS0tTdjRHUmg5?=
 =?utf-8?B?cG1JbXpaWVNIYTZLcmFmOFNDOFQ2L0VvYTZNWXlLVW1vKzNUM0RxeUV5VDd2?=
 =?utf-8?B?QW01Z0VrYjlHejYrWkRtM3Y0Z3FXYlZ4anZWSVZyUXM5aDE4R2JZbzdqd2Uw?=
 =?utf-8?B?bHZNcURlaFNleGkrSFFESjBaYmRNWFgyY0ZIRWVQM1lUNU5aVGV5ZmpULzRB?=
 =?utf-8?B?Rk9zQmswb0hxa2cxUG5ZZm9WazRBalUwZkxKZjcwUVdGeXFobitCbE5La1Ni?=
 =?utf-8?B?QWRaL00xMXF3dGJNQzBiTWVXaC80alUranlHQmc3Qlo1U2NUSTJnRWFlRUx2?=
 =?utf-8?B?V2MyY3ZGTlNpNWxibnQzL2x3SlNRK0NSY0ZCMm9KeVo5MjFPY0tEWDhSekhY?=
 =?utf-8?B?bnorREluczhCVXNEdmR2ZkFNd1NOZk84dHloZnpCWTU1VUJzL3dhRnlnbmd2?=
 =?utf-8?B?bTExWGhLNUlXb3JwQkd5WGJrWXBCQ0k3dUdsNDUwaWdtOHZJRUovY2Q3TTND?=
 =?utf-8?B?aE41OThST1padHRGK1p3Ung0QXJ3MFNSd1Foa1VEdU1QYk40b2w5OGd6YXc5?=
 =?utf-8?B?WTg3VVFmVVdsR1VmcmlHajcwNnNEaWdKTjZkeStoYW1xZUZjYm1pWlN5VmRG?=
 =?utf-8?B?RzQ1dlZVU0IxZDh2czE1ek13ckhRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc54b8c8-ba7b-4393-703e-08d9c191d55c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 19:17:14.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AF07ZQu1qH5RSAE3QNHRjWADtqIUA8igivlt07RnsD/9OAdaHr3wMbiD6wyAXd5AsrekYM/0UPd7WPR671ZzOtnwUxBBWWs64ftNJ57d8K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4157
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10201 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=916 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170110
X-Proofpoint-ORIG-GUID: DwkldegeRpsqFL5iPXEaxN3MjOJEWuIs
X-Proofpoint-GUID: DwkldegeRpsqFL5iPXEaxN3MjOJEWuIs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/16/21 5:02 PM, Oleksandr wrote:
>
> On 09.12.21 22:05, Oleksandr Tyshchenko wrote:
>
>
> Hello Juergen, Boris
>
>
> May I please ask, are you happy (or otherwise) with current patch series (I assume, especially with commits #3-4)?


LGTM, I have no more comments.


-boris



