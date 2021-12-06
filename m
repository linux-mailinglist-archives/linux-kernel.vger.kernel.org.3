Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0B9469715
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbhLFNfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:35:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12950 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244627AbhLFNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:35:35 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6C47sG005927;
        Mon, 6 Dec 2021 13:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7aS3u+2gf4pMCXS+tFHbbmOSTXhOTTvkvURD2k6C/+k=;
 b=JQK9OTw9d4p051+mNAmmeBYV6eWBpPTtisFL1OS5/2FwhzftwLpT1U1vIhocegxOw1FK
 0QM4Gzt0UXRn2F7+oLS5QkxeXq1KtWzCi4jZu1ra3ZuKKDlDHTCaH7gE+7OeOMO9JGjr
 7UllCQAhRdmWY3Ryk1xuNqd3Nvh/ho1O2o9xdYAXES8h0dEjX67z+3kD23E7UT3MJBRS
 hiBA26guw62SgE0ROscvv1onXXGwQrpeXedpy79sZ3ZQDrZvdFIgk+DGC6TuSBxGa85N
 XG1E/eD7aY7wh4PVvruBn2AVLsMqYxYaarD9VREkCwuAQK+X89L0u801labfj7sgDQPH wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csd2y9rj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 13:31:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6DQ2jT054756;
        Mon, 6 Dec 2021 13:31:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by aserp3020.oracle.com with ESMTP id 3cr053dwst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 13:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngtOog1yQCVqKfbrxzx+flPg2D+F6PazUqyRadj9tuzzzIoLUT45jKArz0zmPPKk9qPEgoxGBXgsmVZsOO7d4b6eGHrtxgzkaiy1XRypz+FpoesD3KxTn2J9nDFVPYvin1EwDeB75vGAZdvzTwDEqy71h8BTjLeZ4JqZ1ZrYvVuel5kwBHTJJaAJae1qXjU822IPUbAp4SVSSzipgx0KNP+zrX6cvAK3V+cQ+g0G0dChonMOephOD287gW32Tb1dS8iwHKmMggE1PSDE6hdqKp1rkozCBXAQUzBR2lFbAlLEWq4soJFpNUpvyExTKNPU8bg06kdhO3u01WtNm0D3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aS3u+2gf4pMCXS+tFHbbmOSTXhOTTvkvURD2k6C/+k=;
 b=CxcrunJeFh1xWaZDzXyYBAH4UCq6Oyow/gmvq/9fKZPto/+oax/se3q82LWkrMLzz/BW893lOBKerSAAIkIao2bsaThbZFZbG/y75aF/knPFUiH2qvnL5UZY5kFkxRhkWqKAcsU/L6vtUmD6QcfAtF0oNP412t1wIHVVwuhyBOPYNpuuYFn58IO2WHepSJWTl5d05Z/EPFL1hJ1/c5L4Q/snRXvn+Bd67jmIRtewcwZCs1ARtmE5ysSrQnXqJ4cfNZfi53LidaYw/QbKQuYF7sXIN2VLn+vwGDfdlCzm/n3b/Yrqdu9VsTfmhSpiqyn42SF4CJi+GONfn5y7KahPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aS3u+2gf4pMCXS+tFHbbmOSTXhOTTvkvURD2k6C/+k=;
 b=UrBGgjsY5XhtOBqQos7nsg2rvkVZ7oEx886Zkmt+M2SWd//v5wDb3yTUZNa92ZKBlujHbxhxnBOUMzl0ucI3lVlxCWVpzCG85ewSdKW4v3LVdp2FyCReL5NXJQ2kHoqNN9uPhlhevAJI7CkCxhlQ5rfbO+5bFAmiV3OdJ6RYvEM=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4381.namprd10.prod.outlook.com (2603:10b6:208:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 13:31:41 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 13:31:41 +0000
Message-ID: <cae0b982-99fb-e808-0ff8-2f8d175b2d6d@oracle.com>
Date:   Mon, 6 Dec 2021 08:31:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] xen-blkfront: Use the bitmap API when applicable
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>, Juergen Gross <jgross@suse.com>,
        sstabellini@kernel.org, roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
 <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
 <d8f87c17-75d1-2e6b-65e1-23adc75bb515@wanadoo.fr>
 <6fcddba84070c021eb92aa9a5ff15fb2a47e9acb.camel@perches.com>
 <3d71577f-dabe-6e1a-4b03-2a44f304b702@wanadoo.fr>
 <863f2cddacac590d581cda09d548ee0a652df8a1.camel@perches.com>
 <1e9291c6-48bb-88e5-37dc-f604cfa4c4db@wanadoo.fr>
 <a6dd44e2-6ea6-d085-0131-1e9bac49461a@oracle.com>
 <f9a5bc6c-347b-8243-2784-04199ef879c2@wanadoo.fr>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <f9a5bc6c-347b-8243-2784-04199ef879c2@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:805:ca::30) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.106.57] (138.3.200.57) by SN6PR16CA0053.namprd16.prod.outlook.com (2603:10b6:805:ca::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 13:31:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25f84b14-f19c-4041-fb2c-08d9b8bcbd02
X-MS-TrafficTypeDiagnostic: MN2PR10MB4381:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4381984A968DDAC5628444B88A6D9@MN2PR10MB4381.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHyWnyyCei+WbVEa8GQ5JDKI+6aVmzCzEqvOt1mRkqyYEyk/4ZByMzwFhpAdA+AKf0Ka0fdVYmlQcdVocO+AEsSlKz0eXpBrElLzzQp7AryzSk6zqHm/Lm8SZ8PjUyMgXsB6A5KGqcgsXXPbKue+9TZ7UsqRfl2GlRAcylurigN7upf4MAwOcPzsv3DPJs4MS69WynDipSMULP05TL+MvM47P9RwCN0mc8lRWnJE7u+e/7nlXHABLK5/PBMI3Mev3nNYbwjENcl5ROJiL/BJFZZAssB7/E7Tx6eEPQvY/nR0r7P5pPtbSrSlVBkeGBGAQLtkrj5+VpkISZS4O2aisUkTEculw8rN5WPfDSbI17FIeXxbAU6PYSkygtEUbgCjWtj9KUrIKEXHOG9IMCtUYtgPI3DI3oulY/btvM8jrXR2qmGSIQj1UahrGqjmxYtht7C3ja5LpFmggaRvdMH0OxCa4KhgvhlIki50JBDKVv41ku/5edmvFp42Sv6s28J8wzXke4i+f4j7nX2uXBXjpjDbVr//481nhqNek42e22dnOIHJXHOSCwToAorDpmPHD0U6AEZTrIRC/qNn7Ob8P+AXEDJF9CBNz7tjHu8Jy6SyXU6J8jywRfj51IQbQjRmiy+JbHZLdmUL1WPVBI5cq+J0gPL4ZMBTW3X6Z6CdbAmytdp+DkN7V7uGZrlfgry2z5wW1bibrGPsYSXKNks5/TUYNrMH1CX0GhVq7k/ee845nYBvTseZpeTnGfI//gCZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(38100700002)(4326008)(6486002)(6666004)(5660300002)(26005)(4744005)(36756003)(186003)(31686004)(7416002)(31696002)(8676002)(2616005)(53546011)(44832011)(66946007)(316002)(66476007)(8936002)(110136005)(66556008)(86362001)(508600001)(2906002)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGZiWFM4K0hLSWl6VGg3aUNsSGM4am5vMmhaSkpvMmRQODJ1VTdUS3Q4Zkp2?=
 =?utf-8?B?U0VFR3BhcHhXektLbEZyS3NhdTAwZzk2OXRkTTVSVWFUTDJTRmljd3o5SkZj?=
 =?utf-8?B?VCtzMmsxUUpOOFJKRTlsZXBQODVrUitYQ0VVZG5JVzNtZ0IvbHZQUzduRkpo?=
 =?utf-8?B?ZFo0WlErMHRaSi9UaFQrNVBvYjZFMlBTeUxhVDVBNlIwTjZhYmMrcTZDbWhn?=
 =?utf-8?B?dmZtUlJsTTlmTzZ1VkltcXFzYXBZdThPMWdxSzdaNzFYclpCakwySWJBZkJK?=
 =?utf-8?B?eGdRMXVyOXpjZDgrakYrR3RvOWpqRFh1Yi9aazQ4M3ZadGMrc3FQUGQ0cUlr?=
 =?utf-8?B?M1A5ZEhDbFNBRkE5UDJwTGMxZjhOMml4UWZuelJVK2NnQnRZdTZPWVZsZ1lY?=
 =?utf-8?B?RHdQTzFHY3RBQWZCR2hDM2xkZUNjdGUvTkpyRll0eGFnYlFRekRxUyttOWlY?=
 =?utf-8?B?M2YyUnZWUCtTK3RoUXc0T1ZRamRXSlFOWG05RWNwOUJMWFZoVGRZRUtnWkRH?=
 =?utf-8?B?VXJGZldZQysxSFc3emlMUlplVGRnVWxMaTdsdUdGVERhOXE3Y21KMGdhT05U?=
 =?utf-8?B?bEUwb0VsY1lHM2NYS05manpHY3dLc1RQSVpJUmFwK00weFgzMG1DcmlvTG92?=
 =?utf-8?B?dU1XYTJjdlVSeFRlZ3hTZGIzbnBOMDdDS0h5WWN0b3c3VTY3Ums5Wjk1eTVL?=
 =?utf-8?B?UkRIbTRWaFE4eEtyK3VvTklsQk9QVzAveHBMdHB6L09mcXUzQUlNWXF0dTRW?=
 =?utf-8?B?RzU5cFROdllOYzdWUzVSQzJHM2RDQzZSL3NIWkJKKzV2LzNyZXJIZ2M2NEtE?=
 =?utf-8?B?aTNhNmp4SmF5Sm1sWHM4OFBBdHl2TmphZzRKMzBoM0cveTBxUjU1czladktk?=
 =?utf-8?B?dmJrRzVhN295WHU0WERWWHgzd2V3RE1ENHBIZ25NdkVibzB1WVpldll1N1lG?=
 =?utf-8?B?YWg0U1c4Q1AvdEVwaklFUGp6VGhtMmlab1FCZ1Jhd0I3cmZUT0l6NjNaTVRz?=
 =?utf-8?B?bGZpK3g0Ris2ZnpSQWNmTy93MkNueFdpZUY3cjd3WWVIODNyVXI3VlBodHNF?=
 =?utf-8?B?QUlycWVHSGpRVWhwbzVZWEE5YzFaRHlMdzlPUFo3Y1d1cjNucFMzWWhzSWM5?=
 =?utf-8?B?UDQzcytUMkhvRFpYb1NPVTUxclZ5cmVnSWE3V1FOVktlM00waHNNNTJneTNq?=
 =?utf-8?B?K1lJUDhXZnNUVEJpQUFlKytLdDlhbm1rWnVYaW4rNCt0RHY3VlhuOVNoanpk?=
 =?utf-8?B?eFdsYlY5NWJNNm9Ib3lqbVJFNTB5cGwrZURVd0pSYytmV2hBWWI5M0xLV0JX?=
 =?utf-8?B?d001YjVuVlZUVnhpNTJLejFsbkxybWlQd0dmVUlUZzRmRW1VKzVQTUhYSVpp?=
 =?utf-8?B?V2NLQnJaMDhibU5weGhiRDFuWlhCeHlZTmhlWlNDTG9qSStpMU5yalhpaWJN?=
 =?utf-8?B?VnVtbWVuL0ZMbjFsMU5PNDZ5MEs5azhDRHQ1N3A3WTNSQTdzSlVGekRzTVZt?=
 =?utf-8?B?eFg0ekkrVEVqK2pVR2pmRFdaSjRFem53aWhhUWMxeGhZcXpFWXk0bG5IWVZH?=
 =?utf-8?B?TGR1K0lpMTk0MGRoaTBRczhNY1VpUzhaME9TZHJTM0FwT211MTNOdElZTW1K?=
 =?utf-8?B?LzB1Z0pNUHJrUlZxNTdNbUdqcWI3WkR3N1d1UTJ4NHlPMEErZmV6ZWtKdUlp?=
 =?utf-8?B?ekh4aHBteFdFYkhvNGV4Qk1IMDBQZ1h4NDNLekVjV3F6Q3haWlhZczNsMG5B?=
 =?utf-8?B?MUVBMjFEY2JUSUxjQ3NNOXRrU2ZJM2xkTmVmZEtMU3psTFZrWDlVeDhVYnVi?=
 =?utf-8?B?UEZ0UXZrOEJJdk5xWlJjZ3g0MkhEdnFkVGIvUU1CMTFJS1FwQmMxN0dDSlFD?=
 =?utf-8?B?WUVTdGJDdTcxWXQxN3FaSzUrVnpIbzdqQWVXeGlqWVY3clZEQlhGdWYyMExI?=
 =?utf-8?B?U0tQWmlUVUZxSDRqRkE5aERWWDBsdXNoMDUxejd5L3M1LzZRWVFiU09IYWZq?=
 =?utf-8?B?VDF2aFV1ZXZMelRxWFJZVmRpaHkxZHdkKy95anN2NSt4MTdVTzgrWDhlSnFB?=
 =?utf-8?B?UzNPNlBkUzZZTk1kYm5neU9ZRmdxTDZoMlpBYStTRnJSZXpqWC9zbk9nRHgv?=
 =?utf-8?B?Lzh2bU1aODc1akJVZisxL3hBRnJPTjVnanh3Z0hscEZYOEJER3JMdGJxQmZ5?=
 =?utf-8?B?Zkg5eHVhR2VKZUgwUmpOQm52U1NZenBzcEFUTjBsNVV3Z09MOVRwYlhtNmNh?=
 =?utf-8?Q?Q1q90ShfLKuNN4dCcRNxcxvnlhLty3h5rpTd7FZsJM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f84b14-f19c-4041-fb2c-08d9b8bcbd02
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:31:41.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I6r1/YPuEK4MVEjWmc9fLAQ1GcPolFnsslPpMuPNZg5jSV6zsJj+UMeCLukweIWrKKLoavVzbJHbKu6KfbhKXZ1Id4chBJkX67PTATGx/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4381
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10189 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060083
X-Proofpoint-GUID: 7p_BFoSUyQbuIpArm8R6z-eW2QcpYcuj
X-Proofpoint-ORIG-GUID: 7p_BFoSUyQbuIpArm8R6z-eW2QcpYcuj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/21 1:57 AM, Christophe JAILLET wrote:
>
> So, maybe adding an "official" 'bitmap_size()' (which is already existing and duplicated in a few places) would ease things.
>
> It would replace the 'nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;' and hide the implementation details of the bitmap API.
>
> Something like:
> static __always_inline size_t bitmap_size(unsigned long nr_bits)
> {
>     return BITS_TO_LONGS(nr_bits) * sizeof(long);
> }
>

Yes, I think this would be a useful helper. Should be sizeof(unsigned long) though to keep things consistent.


-boris

