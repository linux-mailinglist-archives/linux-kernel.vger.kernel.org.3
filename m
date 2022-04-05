Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855014F51EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848755AbiDFC2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378559AbiDEVbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:31:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CC53A67;
        Tue,  5 Apr 2022 14:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDJRHugsbLxxvXvTaak2i7ygmApQ1QHnG0TIaI3AbUnUBnLeAxcPHpDvVAJG3UOqCENy+ufBCGE3cBlYzRSDCUb1z56F4W1K6ve7JAT1J/jeY232ckR1wDWotRxlkvCy/XHEFor1+t7YkvWza6ER/8+3CnB7Xm5Y09DtZAoA0gjqGN1pent0c00OvokCVtmkgefSZg/bRKbsU+pSW50f4741eWo98ZqcmfSaLRRQjPgLUUVCoqlUgHkLXVZHfyLBKpMx62yle085fmkfBLJ4WOXQUEB6xS7hMBzEgvEgQEAQyM0Qb6MadwjmojnTzjo83dEmE6rOTXo3qpyRqhILNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI5Bh56K8jnGngVat9BuCcYEn7vhC5b9eTAw0Ubfp+o=;
 b=Bz2M7ldpFXOI3h2Q+ki9ncr2Ogi/Uaj8DNnHrehOPfrhPrHBJhX3mP+aq3W0si0qdUsuQRZQNhsYj1l+oN37aIJGjogirOnd9yEg93BagO7mQioXw8Hf9ejznBX8vU2rdnZbFkTmQ/HxQa1l72Zmlnvz7BIFAEOQqhsD3iQ3njrCRhGjK6ztXObQU0VKMLYA+xxgOX8i3aR3ATpPGOdFcmybQvM3T0ES8/SQJnXjtmEfh857CdFcqskmt1dn2nsrd+P1zO5BQsLPmt5xWuF8jbj6BhMspEC4IDVR5veW+2u1ctJK1jwpvxEuKpryAPyPa9OEL09DZrRNl6/pxDBdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI5Bh56K8jnGngVat9BuCcYEn7vhC5b9eTAw0Ubfp+o=;
 b=s1uwvvINrs1jj8mG2ILh6JgRpOqT9wbe6BqhpzJ56vVzst1gJ/jp/Xq6AVpYlMFvt+ZzoWtIJweBFaqrKUQ6Hgd2vaSTTY9KyWFUi5r2ynRLdJOMjD+qNhuDrmoUH18ia0wIFQX97+GwaT8pBLjj+sWnsM7EJD6rj/ZoNmfQ87M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MWHPR12MB1216.namprd12.prod.outlook.com (2603:10b6:300:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 21:05:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1946:2337:6656:ae2e%9]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 21:05:39 +0000
Message-ID: <a0724b86-8cf6-fc55-1177-d7503a467d36@amd.com>
Date:   Tue, 5 Apr 2022 16:05:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/4] crypto: ccp: Allow PSP driver to load without
 SEV/TEE support
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>
References: <20220331211213.2844-1-mario.limonciello@amd.com>
 <20220331211213.2844-4-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220331211213.2844-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0087.namprd02.prod.outlook.com
 (2603:10b6:208:51::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df1bc41b-68d0-48c9-cca1-08da17480956
X-MS-TrafficTypeDiagnostic: MWHPR12MB1216:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB121678060C2592FA43FE69C7ECE49@MWHPR12MB1216.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4Rl3EIV4lPg1l/aUvec7AduuRQKsiCHPHeOVnWYdhxcxO7oQ8ZNq3ygx92s/V/Bt6zIT+ZqZLI0DCf2DS9xeceyjGU37A2ElhwgbJnCL19l+9WyfPNecGQSW8B5Woh5YKnRdM1oEa92Nicqjs4sZFDu8vudYPD+Byw8boZSV2siy0KTwr+Cu+1G7Zq6gsgQaUR+tJvrqTjhUEvQUYXIWWEX5M/k+/bhBfKADOzKgBz3tkMiPwyK7awGjJpDx8XUP8Lt0wO5tAPOBe66XF2R2M7FV6RiazxhqeVA1OGy6UCg2mCpE91eUCPpSQUCA+UPLiW8Hv1lF7xjI+pPQxY9xwJXJRnOv9McyCtNkp8u22m62VRL0/Pc6ahRn3/SxLpDSz1U5NDREV9ayCOMI6eIno5QkQpuPBSEIEzDiz5XU1DnsvAxMhMo/nMBhB4lqNzHkWoOdYUOQ0sYuoQWTzAEh9Vkd8/wOhJNsoGd4Tdo3ol56Mq35PRzrBPqeUbhLN33CzkMGZ36JLdAX0NrBVYfkM91xDG/6cTYj8xTnEJOMeHl+5la2UYs3bdGe2lWxMVqopqQljve6hmvdx71OvCXcoyU4glpDtPQwPFbgD2FWtn57l0cHYsp/zHoBh5uxkZL812KSNOOQhkwgszYGaUAmGxHM1waaCkbj2ANofItfLekclnF/XzzbxqFQ79XrUAGLHREZLWNSYRF7TeSijVCkntB14fugGinVN4zXP0Xo4EyDccuNYRiBsx7KmIKjDRg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(86362001)(2906002)(6512007)(53546011)(38100700002)(4744005)(5660300002)(6666004)(31696002)(83380400001)(8936002)(8676002)(186003)(26005)(66476007)(6486002)(2616005)(110136005)(316002)(54906003)(4326008)(66556008)(66946007)(508600001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21XcHRUcmJXcXVhM0lESmw1RXpJZTc0aUFaeTJBNDZaSUhGUVlPOEdvU0t4?=
 =?utf-8?B?cVpDZHcvMUgwek1Ra0NEbENXcWlvWmUrZTR3bXFOS2ZWY0FGeW5tajU5cmVB?=
 =?utf-8?B?djFNVWs0bUE1TWRaMmZOMUFWekJpbTN5dHNzOTM1aUkzenV3OTc0cnRML0JL?=
 =?utf-8?B?OEhlN21Ic1lLTlZpUjgyVmo1THRpUlNOSkFJMytUNlV1bW5oZW5RVy93a2x0?=
 =?utf-8?B?ajV3LzVKU2RGeVcwVUZWck1wY21jR25lZjlrWVlrd0ozQjhaK1krRXNOb0Ri?=
 =?utf-8?B?ZUNNd3JZZHpSM0RYMEFyYWNWRkZ4T3YvbS9idGVmSWV3MkVxYVhVcCtqYlFW?=
 =?utf-8?B?dXh4dllETXNROGxERnJRZmZVVkNya3hpeHVBdi9EM0M5akovV09YYXM3dzBC?=
 =?utf-8?B?YUJxcERaU0hOOExoK2Y2L05JR1UyQzJFS0lXZjlkbWxWYmlKT2pMVk1PWUVz?=
 =?utf-8?B?czF4ci9EazR0RzdVZnZsT0J1SE5GMklYUjMrVGtVT0NLVXVPTnFDSXQwd211?=
 =?utf-8?B?NU9UcmlIalRUYmY1aWRlZW1qRjl4MkpCNG8zUUNuMEI2WjB0c0xlTXZ2dVFp?=
 =?utf-8?B?enNjOEJuR2dqQlAzcFAyVmZaRHh5a0c3b1pFeXpRNFd1c3AzNW04MGFTdHdS?=
 =?utf-8?B?RkovSXBMcHdER1dja09uUjBKbFJOSmRQTGl5N1k1eFdyRG1KSUNETVZhZjRV?=
 =?utf-8?B?Zml2VWNIRG1ML3RvZ3VwMEVsaVF1a0xHLzVrVHZzUVpDZTlHaE9FUkcyMERO?=
 =?utf-8?B?WWRSU3hlTitObklUWjNVWUd6eUtPZ3d6QTdMUDlaM2g2eHF6WGR2N25NUzhT?=
 =?utf-8?B?VEZYNmM5SktoOWN5SkJYTWt5ZWZVVS9LRVNHVVYvWFIrRFVqTm9uZlNEbUgz?=
 =?utf-8?B?YVk5cE1oMjAveGJScE9MWExGVk42QUlDMTRqclBiOEpvaDVBdVRMUUU4OEtu?=
 =?utf-8?B?UGdHWGVOdmtmQU9Xb2pOamQ1WlIraGFVa2NMOHFCMmdvRStRWWxHcGZidjdz?=
 =?utf-8?B?SjNVdmo2eFI2V1RKVXA3RXR4N2xpVTlhUmV4QjljSjZJelZFdVAwR293TGZ6?=
 =?utf-8?B?REJTZnk5ZXJtWXNJNWdUR3FEZGM4UWdYdlRSSkVId3BLbzI0WnBSb0ptcVBU?=
 =?utf-8?B?VTdEbkhXK1BPSGFFTk5XZHFjNnZaNkJmMzR2UDZZQllpUFZoVmxjK3h1cEZ4?=
 =?utf-8?B?RzBuRW5EWHVHMXFGUVY1L0JwNmlteFNrMEFKRVNoL3o4ZUZYc0JVVU9FdjJv?=
 =?utf-8?B?cXllZ0hRZE9VdUg3WVVNaGtGeCt5QStlNVlNMml4MXo4dXhRM2tsLzN4bGN6?=
 =?utf-8?B?RGpPYTVmRmg4SEZza3JFZnRWbFFpWlJTZDVDWHIxdm9mTnV5R2MrQ0gwbmF4?=
 =?utf-8?B?SjVBVWFqUWFMRmNpd3kxdkU5WkVSZzFlSmNHRkZ6TkJnMHJPRWRpSVRxd1Vl?=
 =?utf-8?B?cDcxZC9zRkRmSGVMOU9hTUhFKzBPdzBCV0YxY3BuR3pFNndUUWVaWlV4QjFm?=
 =?utf-8?B?M25ZRURvclJJNHFYY1ZUbEFvYW9TeTFweTNEZjFhYnN3TlE0S2lTU09zbnYx?=
 =?utf-8?B?VmxWRTBhbmRnNC9nVndkRk5YWjkzUW9sUWZYTWhjdTIvcWFReXhSWWdzemV3?=
 =?utf-8?B?VWNjKzF5VXFISDRSMlNXT29sbmJxYnhyNUlSL1UyNTlZdWhESVd4enJoMEdx?=
 =?utf-8?B?cERJZnlEV0FhZVZabUViOGJxOEp1SHBaSmxsNFlFNkdVNWN1STYra0kzSUQw?=
 =?utf-8?B?T2phRmJOWFBLU2JWci9zbmwrQWx5U0M1a2N4MU5WcEI3dHJ0UTBzYngrMWEx?=
 =?utf-8?B?UDBYMUFlbitiKzZDbnJVb0czTTY1TWVaSGxpdEV1dlJqakRocmEzd21SYWdZ?=
 =?utf-8?B?L241WUdKdFNoNGlaM01TVHhZNStlTVcxcG9GaXBnd0t5WXdZdUlDQUtDb1Ev?=
 =?utf-8?B?YnRNRjJRRzhpejNJVFRNUTRlWkFRZUMyNThkcTJFYktLdzRCZS9tbzBvTlFh?=
 =?utf-8?B?WVIra2pKRUNPMHMvV0Zja3AvRXc4aU5Qdk1wSVNCZ2s4UWR1eks5VmtOeHl4?=
 =?utf-8?B?aml5VlJKYTNLZVJzLy9VanNobTRlSitVOWhkYU9SaWlyOVlCekpIYUdhVEVN?=
 =?utf-8?B?S3Y0VFdNSUNNeTVMK2dKK1h4NzBteXE0bG5WelVLUm03RGVCODNhOEhML0pr?=
 =?utf-8?B?eUg3dUVNKzJHSEJXZVc1TGEwU3NhUTBRV0VWUDdzUktDWmRtcWdGb1JUQVQ5?=
 =?utf-8?B?TnJIUG1pQjAzeC9OSUN3dmpLcXJ2OThaREVzTG1yRmVMN0hNVnpYdE5QOHBq?=
 =?utf-8?B?NHhVdklacS9SSnN6WkRXMWxacTRaaFpmMDVyblJhNU1wLy9TcGxrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1bc41b-68d0-48c9-cca1-08da17480956
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 21:05:39.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5YxTU0S6MP72lEO8C+sIZlU8pnwGu68IeXIoipIqYzFyy8Dt5+e9HfK0+7fuYtOFwbf9RYd5v92y/Cf661Ndw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1216
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 16:12, Mario Limonciello wrote:
> Previously the PSP probe routine would fail if both SEV and TEE were
> missing.  This is possibly the case for some client parts.
> 
> As capabilities can now be accessed from userspace, it may still be
> useful to have the PSP driver finish loading so that those capabilities
> can be read.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
