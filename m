Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D04F9390
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiDHLP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiDHLPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:15:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B4335254
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLEnrhSUiUHUll5ZSfvGmcUPsXQrsrUkn8YqhzAspdt2DynWcYRxEIAxO0okTWW1GdKOjNzEjoo80vPExShlKEB6DlWiro9u1mgpOq6k6dgzhRlyGq3FS0V30UxtzXOrbzdFAq8knHOc1Yj3fbgtyp84deExDWWJRC+o2LekPuMOd8oh3hlGJRT/bfN1g5Q4AxMzvq6iQ9iyLuc9ttcFD2tDkd8z6mnx+r2siqJZQzcmqdgMYsWcalurtQ9P2v5DPdSuD3Ed+IJo/OLsmrloKIgWtkV/XKx3sOE5IZ1PfSUtgmYefsSGnlpro/nN6R5OVpCPpMjmhHhTnnAAbMyJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neCqXeAA7lpbbvuzrumkGBotE5z64EJTyJrg8Qa5f3s=;
 b=b1+R2prdVsZLMfTG+e6H1oTrYAWuCMSdb0NPN3gdpsLNa0CjkTKWMss4aNVnBoU+PWrxhcU8MwkM6nYXxpN0xAPPPegWsfzzs8SGzwvXBWKz5AhfiKqjmhH2yIa5ZfqonABzADKXy10OUqbzmgVYXX66SSCX7C4vBjOzwpjU4Dh7mjeHeKSeMikz4KojdNsu+YWyjRxjI3bRc1griC6E7tAYO3GxfD4qoXczaKUG6EocuTBluKvFcuDEFc4xNpa6MMJjjgbeLvAk2601jIBT4W/mdKxh5yDnUv1ruZq0ZYxyr2yi6f+S19U9j1M7e01GLn/v2bipW45dlgABsfPg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neCqXeAA7lpbbvuzrumkGBotE5z64EJTyJrg8Qa5f3s=;
 b=oUHerIru9DJ+3PDerOPd9QxxYkcmVg1abK/w/EX4oAUqYYvgR0QOeOr8ud9zDBfg3dO0cWFxgMiZkW/OM1SR6Z8pPabZhVDidWt1Nnyc7Cd2eipjtjojot/k9uaxN8E+ACP2JDwvR/KU44yBzslczkYj78Yi7nDIqkIBIE77KpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 11:13:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 11:13:17 +0000
Message-ID: <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
Date:   Fri, 8 Apr 2022 13:13:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Ken.Xue@amd.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        thomas.hellstrom@linux.intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0026.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::39) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b202b381-d793-4821-088f-08da1950c7ea
X-MS-TrafficTypeDiagnostic: CH0PR12MB5314:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5314729D4E088C2B298C251883E99@CH0PR12MB5314.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Hiu2SblLmeR5gUyZ2O9Srd2hV5de5MCPqY/cD7244hMTFqGUlabnyaNBakXkdbz2of0iHin2z/MlU6DuNZU3/qZd3zrCuHGnosC6wvxlbiwqU2bvtSFrkQMO7JHTKm/IzHDwk8yLAcnboCJImlmp8im/EWmdDjb+68xnyi+1X5lTP6rQOujOe7O/IO5t5gvopbMDrldjtqQp0nR1ifdnr6D5sBLnmm22X4CYfW+xl6Ur63wF7+t4CIizSDHAIDktfCo5dFRe52lQpxoA7buB+0HFW4zq3txAuILllsydbeOyGVhSHprdj8ng+VbPoNwv/JscirgK7ICS/M3IDQQVsEkcyu6lcq3B30jehcZBxu+gHAtpEM4OeNEkpoFlN/ErKN95nVzb83CmPJqb9mr6+LNZpeoE2cpI71afYTTNS9bzQbMRqqPrEqlcVpSyKORuKBZKvNtNuo0WhxhxtgJ/qhZWYAuvHn4JU3UlYnorh1fqS6/IWaC+O5oMzDha82PvJcCN/yNMchUvHYTZZlJpl2yv5tQxe6ZhtaRFIOeOD8gX6V+CdSKW/MEkkrg8it5PQg/HSkUg2bu4+7MTfk+eJnsdFhc98kPJ9Wc54o8+seVycLU2F3I5jMhatfDmdkJhqPpXNzPNjJSjcu/RHS9rDwghkaEwKl+9QNBVUIGm5iWrqKGquTN++YjP5AgnZvSoJlGyAylvDfLXam+w68r7yRX2nQxOJ99V38zYxEqX2M1951zBKKyUS4X0xIWboqH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(6666004)(110136005)(966005)(8936002)(86362001)(6506007)(83380400001)(2906002)(6512007)(2616005)(316002)(186003)(31696002)(4326008)(54906003)(45080400002)(66476007)(508600001)(6486002)(36756003)(38100700002)(6636002)(66556008)(5660300002)(66574015)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHpXbTgydXNIUytWdmZqQ0ZPTEx5TlRpK2ZuS0owL2FWVXpGWUNsWWJNYktE?=
 =?utf-8?B?UGd1bU5Vb0p2TU5ReWNoQ1VMdVM3bCtKaGl0Z0oyWWZmT3kvaGVlYmN1Nkk5?=
 =?utf-8?B?NGdJTEp0Lzg1UlBjaHkzZHhnMU5SaThzclVLM3gwSHN2M1BuQndzNTFJTnJ2?=
 =?utf-8?B?YzVLQ1RaRlFBVVZyYnNkNitqMzc4T2pNKzE3b3ljWHlhRlhoSjBBTWRyMEVt?=
 =?utf-8?B?L0pzOS9nRFBQY04vcktWU2JqMDZPV2tBZkErWjE4MHc4OHc5RTdOdE1wNDl5?=
 =?utf-8?B?ZENMbTBMZnJmYklWU09BNGpubFIwU3pDTnYxMTlGRlpJUndMcGdibm1WRjM3?=
 =?utf-8?B?RFZwQ3hEcVJoK2tDQms5MkdDblNheEsxWTBUZVN5b0dZbzVtUk5mb2JDNTlP?=
 =?utf-8?B?cERTNzJqQWtLM3ArWnZLM01XNEM0WXkwYy80UHdhUXNFOWc3ZFJ2aVZ6Qm5w?=
 =?utf-8?B?UGRvbWptdmo2RmlSSWl1VU1XcHhLcUV0ZzFTdmdkOHJlWjh6UjVWb2oyOERY?=
 =?utf-8?B?U09lbFgyV20raG5tNy8veTVpekxYanZ1aUlPRWM3eXYySFZEelJ5SGwrU3pI?=
 =?utf-8?B?VXNYRzZIY2xLMEc5dm9jemR6RUxiZXpDRHUzTUF0a1l5azZrdHpkcFBMdmwx?=
 =?utf-8?B?dU8xMU5mNnZIVmVQWkUvWTNjZUN6ZDZTNnUwS1FxaUNKQnV1akw4eWdzTThW?=
 =?utf-8?B?NHREOHlEbWVkUTFOTit1K0VXU2hndkNsY2kybzlCdkxNVElHOEFvaDFucVRD?=
 =?utf-8?B?ZUpXRWdKK1A4eEIyL2NyOUxRcTducGp4cUY0K3NIdHdJK2xmK2FhdURKYnJL?=
 =?utf-8?B?NFlGb05jOWlZMks0MjlTKzhESTU3ZzdaNng2blhuNHMrRW8yb1hJdVdKbHBx?=
 =?utf-8?B?U2NwdHptZ203MFBNTVNEVTJyWHdXdHA2bGhEdnlsaHdzWmIvU0Ezb1NBZjBt?=
 =?utf-8?B?WVpjRWFONUpaSEVPUUtpL1RiakhoTUY2WDhWZmhxbVVwdGJVUnRKTmZnSkwz?=
 =?utf-8?B?dzdpdzlyZTc3Wmh0UkV3YVloSWloUG5HR20vZzduczNaY1MrYUF2aEhIREIz?=
 =?utf-8?B?cmhIWDJ3dXYzODlaZFJja2luNzF2Q0lIK0lzUFo3Nk1tanFXMlRzZzBmWWNO?=
 =?utf-8?B?aTZ6SUtpQm5LNzJZSjZDK0h1djRqcGJKUzNLRGRrbWoyRCtJTm5WMFBONk9Q?=
 =?utf-8?B?RVNhNnZwMVZMdElYWityeHQ3QWpwUnljbDZBODd3K2hQcEJWVEhjYmpJdXhw?=
 =?utf-8?B?bnUyYlNkbksyZHppWWJKeTN2NlVIdXRLWHkvdThOaTJGTitrU1JwOHdqSCtj?=
 =?utf-8?B?YW9rZ0g2MktFWWg5Q0tQMUFYbmVTZVVUTSsrSXdhdGtva3ZIdGZZbzUyMGNz?=
 =?utf-8?B?YVpyMWhlN0VsNTVZZTdvODNac01uSFByZ28yaFBGZ3JsY29hVXN1ZUltcHdy?=
 =?utf-8?B?S3RLcG9YSUkrRyt4QkNtM2NTMDdQSUxaSXYxR2VZWkdTSVdEZFJSS1QwQXhI?=
 =?utf-8?B?S1kxL29lcHZaMnh5VU1RaHlRKzlFYkMreTcrd0syU0Y1dFZQcVVDK3VRUVp2?=
 =?utf-8?B?TTlORnFqUlpzbmhVZzZSai9GeGEzZE80bno2UWJEVWZaazRUV2hwMWV6bFUx?=
 =?utf-8?B?RTJndGt0UGJCSXlubnlPYWlFejZDbW5BRmM1YlRHKzZ3NWVrN1RIbUtHRFFD?=
 =?utf-8?B?YUsveGZoOWQ2TjNtdmIreWxCUkMwaFhhajZFdDBRRDE3RzBvRFd4TG1oMXZL?=
 =?utf-8?B?ZGhpWDl1LzRSVFBmbmVVZFMvRW5mN2RhUDI5OUZrQ2tKZlhTeWtpVGE2M0lT?=
 =?utf-8?B?dTBNNkJvYTRiUnkzSmd4THhZU0VVbGxFdTIwcktRd2RKNEpKbXhlZ0VCM2Ez?=
 =?utf-8?B?WkVmSVdtb3VwVkRLaUozQU0zeE5FczJiL3ZzU3FDOC9URG9zeXVZQm45MlVV?=
 =?utf-8?B?K3ZoMnNjaWFkenQ3aWo3OHY3RVFXa3dKWHIrV0RaQTRFdVV6cm9BVVdhZGxO?=
 =?utf-8?B?Z0xLNUo0RHEwR3o3SW5KV0lwVlA1NUV5WU42MWJCMVBZYjNrUktCVWU0Yjcx?=
 =?utf-8?B?ZkhjQVVob0h2UzFxTEl0ejA1cEFoMEFWVlF3cjJab1F3TXBqUmdScU15WHlG?=
 =?utf-8?B?NldwTWNURmZMczFSdjVpbGFCYkdWMVlhcGNFd0NrWEQyWXZ4eERQQjJ1Nlhv?=
 =?utf-8?B?eHk5eGF2OXlhVWF5OXphNnZick15TlkvZWt1UGtrYWN2eVJBOUk1Y3d3VVVD?=
 =?utf-8?B?WEI3TTNCazl6MUYrd2E0VU84cmhDTGNpN3dtYXhUQXAyQk5JMVdsVStBK2k1?=
 =?utf-8?B?QVNpZ3RMSHcyNVU3T3R5SC91RFpRengwd0VRaDVBZXNDTnY3N2xxbEV6TWQ4?=
 =?utf-8?Q?6VeqeHH+2gv/stAy5nknG0W+y2LrzXbqfNHQvKHQEzTZW?=
X-MS-Exchange-AntiSpam-MessageData-1: SQKbq2AE/bB0Yg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b202b381-d793-4821-088f-08da1950c7ea
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 11:13:17.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBbF0LxwtkfqlgPqHhNdLFmGIufQXsmJVCd+MuOGx5vBGC2mg6bUgy3Bzd6LOKpA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.04.22 um 13:01 schrieb Mikhail Gavrilov:
> Hi Christian
>
>> those are two independent and already known problems.
>>
>> The warning triggered from the sync_file is already fixed in
>> drm-misc-next-fixes, but so far I couldn't figure out why the games
>> suddenly doesn't work any more.
> I thought that these warnings are related to the stuck of the listed games.
>
>> There is a bug report for that, but bisecting the changes didn't yielded
>> anything valuable so far.
>>
>> So if you can come up with something that would be rather valuable.
> I found how to fix my build problems. They are all related to gcc12.
> And making again git bisect and found which commit lead to stuck the
> games "Forza Horizon 5", "Forza Horizon 4", "Cyberpunk 2077".
> At least it affected hardware Radeon 6900 XT, Radeon 6800M and Radeon VII.

I own you a beer.

I still don't know what happens here, but that makes at least a bit more 
sense than a patch which only changes comments :)

Looks like we are missing something here. Can I send you a patch to try 
something later today?

Thanks,
Christian.

>
> $ git bisect log
> git bisect start
> # good: [ed4643521e6af8ab8ed1e467630a85884d2696cf] Merge tag
> 'arm-dt-5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good ed4643521e6af8ab8ed1e467630a85884d2696cf
> # bad: [34af78c4e616c359ed428d79fe4758a35d2c5473] Merge tag
> 'iommu-updates-v5.18' of
> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> git bisect bad 34af78c4e616c359ed428d79fe4758a35d2c5473
> # good: [4a0cb83ba6e0cd73a50fa4f84736846bf0029f2b] netdevice: add
> missing dm_private kdoc
> git bisect good 4a0cb83ba6e0cd73a50fa4f84736846bf0029f2b
> # skip: [2ab82efeeed885c0210a0029df93bb95a316e8c7] Merge tag
> 'drm-intel-gt-next-2022-03-03' of
> git://anongit.freedesktop.org/drm/drm-intel into drm-next
> git bisect skip 2ab82efeeed885c0210a0029df93bb95a316e8c7
> # good: [00598b056aa6d46c7a6819efa850ec9d0d690d76] scsi: smartpqi:
> Expose SAS address for SATA drives
> git bisect good 00598b056aa6d46c7a6819efa850ec9d0d690d76
> # good: [00598b056aa6d46c7a6819efa850ec9d0d690d76] scsi: smartpqi:
> Expose SAS address for SATA drives
> git bisect good 00598b056aa6d46c7a6819efa850ec9d0d690d76
> # skip: [c674c5b9342e5cb0f3d9e9bcaf37dbe2087845e5] drm/i915/xehp: CCS
> should use RCS setup functions
> git bisect skip c674c5b9342e5cb0f3d9e9bcaf37dbe2087845e5
> # good: [f0d4ce59f4d48622044933054a0e0cefa91ba15e] drm/i915: Disable
> DRRS on IVB/HSW port != A
> git bisect good f0d4ce59f4d48622044933054a0e0cefa91ba15e
> # skip: [6de7e4f02640fba2ffa6ac04e2be13785d614175] Merge tag
> 'drm-msm-next-2022-03-01' of https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Fmsm&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cfb3893e4302546eb959608da194f3614%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637850125371388430%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=vlmJpTnApB4G9cnTiXK2U%2B8Qc6ZqDESk8sCdZmN0w1I%3D&amp;reserved=0
> into drm-next
> git bisect skip 6de7e4f02640fba2ffa6ac04e2be13785d614175
> # bad: [868f4357ed0d1e2f96bbd67d4ac862aa6335effe] drm/amd/display: Add
> DMUB support for DCN316
> git bisect bad 868f4357ed0d1e2f96bbd67d4ac862aa6335effe
> # good: [39da460fd4c0f8e7290dcc9cbfc9375de9d0eeca] drm/amd/display:
> Fix DP LT sequence on EQ fail
> git bisect good 39da460fd4c0f8e7290dcc9cbfc9375de9d0eeca
> # good: [3f268ef06f8cf3c481dbd5843d564f5170c6df54] drm/ttm: add back a
> reference to the bdev to the res manager
> git bisect good 3f268ef06f8cf3c481dbd5843d564f5170c6df54
> # bad: [123db17ddff007080d464e785689fb14f94cbc7a] Merge tag
> 'amd-drm-next-5.18-2022-02-11-1' of
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cfb3893e4302546eb959608da194f3614%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637850125371388430%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=UVN%2B7LS7%2FWeSJRfRptlnHCYHE1fffbSIw5GbhP7YWM0%3D&amp;reserved=0 into drm-next
> git bisect bad 123db17ddff007080d464e785689fb14f94cbc7a
> # bad: [24992ab0b8b0d2521caa9c3dcbed0e2a56cbe3d0] drm/amdkfd: Fix
> prototype warning for get_process_num_bos
> git bisect bad 24992ab0b8b0d2521caa9c3dcbed0e2a56cbe3d0
> # good: [1cbbc8d4f788af4c260ef3cae05902ef7b191197] drm/radeon/uvd: Fix
> forgotten unmap buffer objects
> git bisect good 1cbbc8d4f788af4c260ef3cae05902ef7b191197
> # good: [69f915cc97c4bb82b34105a47abf613f7c87215d] drm/amdgpu: loose
> check for umc poison mode
> git bisect good 69f915cc97c4bb82b34105a47abf613f7c87215d
> # good: [8bbd4d83a68beaf54ae01b2e2aa2024ff1dfc0ba] drm/amdgpu: Reset
> OOB table error count info
> git bisect good 8bbd4d83a68beaf54ae01b2e2aa2024ff1dfc0ba
> # bad: [1915a433954262ac7466469d1a4684ac54218af4] drm/amdgpu: adjust
> register address calculation
> git bisect bad 1915a433954262ac7466469d1a4684ac54218af4
> # bad: [461fa7b0ac565ef25c1da0ced31005dd437883a7] drm/amdgpu: remove ctx->lock
> git bisect bad 461fa7b0ac565ef25c1da0ced31005dd437883a7
> # first bad commit: [461fa7b0ac565ef25c1da0ced31005dd437883a7]
> drm/amdgpu: remove ctx->lock
>
> 461fa7b0ac565ef25c1da0ced31005dd437883a7 is the first bad commit
> commit 461fa7b0ac565ef25c1da0ced31005dd437883a7
> Author: Ken Xue <Ken.Xue@amd.com>
> Date:   Fri Feb 11 16:18:46 2022 -0500
>
>      drm/amdgpu: remove ctx->lock
>
>      KMD reports a warning on holding a lock from drm_syncobj_find_fence,
>      when running amdgpu_test case “syncobj timeline test”.
>
>      ctx->lock was designed to prevent concurrent "amdgpu_ctx_wait_prev_fence"
>      calls and avoid dead reservation lock from GPU reset. since no reservation
>      lock is held in latest GPU reset any more, ctx->lock can be simply removed
>      and concurrent "amdgpu_ctx_wait_prev_fence" call also can be prevented by
>      PD root bo reservation lock.
>
>      call stacks:
>      =================
>      //hold lock
>      amdgpu_cs_ioctl->amdgpu_cs_parser_init->mutex_lock(&parser->ctx->lock);
>      …
>      //report warning
>      amdgpu_cs_dependencies->amdgpu_cs_process_syncobj_timeline_in_dep \
>      ->amdgpu_syncobj_lookup_and_add_to_sync -> drm_syncobj_find_fence \
>      -> lockdep_assert_none_held_once
>      …
>      amdgpu_cs_ioctl->amdgpu_cs_parser_fini->mutex_unlock(&parser->ctx->lock);
>
>      Signed-off-by: Ken Xue <Ken.Xue@amd.com>
>      Reviewed-by: Christian König <christian.koenig@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 16 +++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 -
>   3 files changed, 11 insertions(+), 8 deletions(-)
>
> After reverting commits 57230f0ce6eda6d47a2029b7b3a39cc5bb63fe32,
> 461fa7b0ac565ef25c1da0ced31005dd437883a7 the games "Forza Horizon 5",
> "Forza Horizon 4", "Cyberpunk 2077" start working again.
> Removing commit 57230f0ce6eda6d47a2029b7b3a39cc5bb63fe32 isn't really
> needed. I made it because I didn't want to resolve conflicts.
>
>

