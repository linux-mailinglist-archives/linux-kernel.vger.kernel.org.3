Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D04F42C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445990AbiDEUIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384266AbiDEM1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:18 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140111.outbound.protection.outlook.com [40.107.14.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D61EBBB5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H14FcINlzuA9q46cavjOiqd8IStihR2vLLTpDMK8Ieg8uDe83n70z7ug3zVPxceBl6dsQdvxn5V9Qx13TUsEeIa8y+SDpsmTpxbzkSaoavmRcVnQ0JPtK13H1xa1KmjVCiJreUBITAhJOYGSpt+l374l470mDRey2ze6wDuAqB6ujXwu7bbi9kpXO56wYPxMO6CeqUq/PrhVwzXRkSbr0cSOdhIvF8ptoODBnhjnMQJgHyH11KwN40kGUo8m9yfWrdRbQvHdCfiZw9F1Hg8AbWIZYkajIrwjKXBQfsseBZCshp0QMHSDKQcmqmadSHh5bqcWe1130T/MF5Pm/moU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdsUV7aMjZvadKMvs2CSnVo6FTrq7glR44q9WINtCDQ=;
 b=fz0uSVC2ZLshkT3cIoK2oUc9R9L3dOZ9WF6MIy36//3lK7fpGgBCKup/ydIlQelvvwSLcKgf8B83nzSdQS4RMhJ+sbm0quWwljNDSi2NYagEHFeNX/SV6vevF82GVKJuap+Bc/0IAPNj0eMr4QahmeBXQBtg6Gp/c3xZUM6DuSRtp41YksRMmdW/xugobjDJhYhvbRveSnv5RthrgMFwpOd5flA6kFjRxJr6+tiS/5RzMbgSbflhYVKOg2cx0g/4fBCYn9QFB33mJR/qjxNRppMxKBmLG7WitzBx7orVGD4QtDVz8aDvsKmTl6HZMtB02c2pk4dngedqARyneVPYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdsUV7aMjZvadKMvs2CSnVo6FTrq7glR44q9WINtCDQ=;
 b=GnM4qnaVEwiZrfqsI18qhm40+kxO0ea3wGXHd3v3W8Hp65UxmQr9rOt5yET5SzYuwSqVh9kMXkJZnJ6AasFVUkYwCfyF4wdw8XlIJpQ5bNKHvVuc58/JEGL7jnlrnsoy6Rk7qq38J76XnNDyk28UrGQm8zllzwnkj2f5TZL5yCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB4114.eurprd07.prod.outlook.com (2603:10a6:208:45::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.14; Tue, 5 Apr
 2022 11:36:14 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::2505:5d08:7490:d517]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::2505:5d08:7490:d517%7]) with mapi id 15.20.5144.016; Tue, 5 Apr 2022
 11:36:14 +0000
Message-ID: <dc5eb22d-5389-bacb-3756-253e774a8394@nokia.com>
Date:   Tue, 5 Apr 2022 13:36:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: mm: swap: locking in release_pages()
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <89009285-c75d-0f09-5b08-d133c42a18f9@nokia.com>
 <YkwdRnuQBjoJ01YK@dhcp22.suse.cz>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
In-Reply-To: <YkwdRnuQBjoJ01YK@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::43) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd46dd7-ede2-41ef-c289-08da16f87d71
X-MS-TrafficTypeDiagnostic: AM0PR07MB4114:EE_
X-Microsoft-Antispam-PRVS: <AM0PR07MB41145577B51D20964AEFE73C88E49@AM0PR07MB4114.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmBhFL9tKg0biCVu7+maaDAmNO1mGeXQTY+E4PqQX/MoZkSYzYJKkX1z9pjjFiYIMrY5uwedT9gj00/IVVpQtrAJRC0BCPULvcssAf5F8weFsIKEqDPz+MmnutWEn7s4PenTsfetakWMdSNgYNWdNJVteo1umXeBT/3oW5mLYRewIjz042m/KNGjfjwzbG2EQoY5cDWfuNhUjQNnjWh+yNTwxyxVROQdXjMd5bvJ9y+qOLvQX+gPqNK0lstTUiupVEXEfT8U/mjOVmVtCqp3LrkLaXJ1ABbs9QRQBH58FKqji/pu9cfCK1a9tT9AF+2kLVbX5qEcic1YepwFRxu432Ez7tH18apzBpd9p7rwJRU+eVNQQVXa1GbKMoSbOBPdlpUcUX3xNVzH813dZVoiQFh2p+lmw/aAxI78y4RtCE9H7nq2pehglT3w+TLX9m6w9bnS6xgeybD5Nj+eC85mY/0dBoB9U2/dsMMDR34ts7T/6UoPd6gyG98VLCnOy8vFlvVJpJP+6ZbMoLwHVVJrtuzCTzRLfWf/U/PPhQaiFo1hdNSZhzg2+5DFVEzrhZXvmUs1cTCtujR6Wn7o0DFkQY+SgCxeW24vjFulfAyVh/lScQsm61aKYz45cCLSC+OzVpuC/UcB9sEdNi8UTFhJ3dZR7Mvu+YqjtYj16EnbcWGEFVBqiCdpUCyZMecGjPgEKvWsQiWtbG23T28R7dORcz3BVK6NOy8zj3ZK/A4+AIZUgd2QQNX2PFC3e6kPh4Wd6QpiO4ZFef+fgvocmAX99V08V04EwPrhkqnnFxVcO8i/GVXiygZrZQuKS8NUsB0P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(7416002)(6486002)(508600001)(31696002)(8936002)(38100700002)(82960400001)(5660300002)(83380400001)(4744005)(2906002)(38350700002)(66556008)(186003)(6916009)(54906003)(26005)(316002)(8676002)(6506007)(52116002)(6666004)(2616005)(4326008)(66476007)(66946007)(53546011)(36756003)(86362001)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW1MQ2dBcS8rU3RTcTZpMFROdkQxOFlleklrTWROSmQ1MUtCK1hXM3BoSG5C?=
 =?utf-8?B?TnNzS1lxOHJmS0x2YWtKVmN6SlNUZUVHWXUxc0hkdTRRS0pvSlJLK2J6L1Bl?=
 =?utf-8?B?cm83eHo4REJ1VkQ2Q0lPdXI4cmRHK2NNS2VnSmR3SWtFbm5VcjlSMG5mSHBX?=
 =?utf-8?B?a0JYZzlSMk40Y3RaYVpXUE04VS9ha0U1SkZZV3lnZTQ2aEtwditVOWQ1VEtk?=
 =?utf-8?B?cVpUbGdCOW5nQ21QMGI3OXRDVENzRFdGZ3AvNzJWLytCVW1uS3c4TW82SUlZ?=
 =?utf-8?B?aFhyRjd0c0JJUUR2a2JvanhmRGNhVmJjS2ZXMjlZL3gxRENDKys0OGMyN3Vv?=
 =?utf-8?B?QW5JUE4rSlVlMFI1ZzJzQlIyVElXUVc2NEgzQ3FDa1VKM2J2LzF3WGlsa1Bs?=
 =?utf-8?B?VWdwL0xnQVgwaDJEbUhWY2p0THRFVkJyWlBlV3pHd0RXZHJJRDNqc2ZyMEFl?=
 =?utf-8?B?M0hVWWR3MzVoQ3UvY3pRSGNuMDAwc0cxMlR0RnBpaTlzU29idlY3Y3d3UDMr?=
 =?utf-8?B?bFkxV2YvY2I0R2JoaVBYTnVRRnpkL3UyMWhIaTE5Q2Z6T25FVEVIcG5GUnhD?=
 =?utf-8?B?dGRyT1BRVVlmQzloZ3E3eFYrU2x2OUswTzlrS1RYMFU0NFZxVEFlblJCRlhG?=
 =?utf-8?B?Z2d0TjFaYURYTUxpT3k0V3U4SW5nakE0SFBJRlpYQTJ0amIraTkxWVJpa0tn?=
 =?utf-8?B?akJTYkdzNElGc2dyTngvWkpUdTJ2S2c2cEpNVlVCZjNoRVh1NHhZeVRaUDNw?=
 =?utf-8?B?WFZZeVJtd0lteFRpcml4dGpmaVJLaTEvMFlMaDFIeklKZmpzUnNzdGhiaVlN?=
 =?utf-8?B?VkR0UE1SamNyZ3Z5cGVVZ0tyK2tUdjd4T1d2NVNuVHJic2tpRmZrWW45NXZQ?=
 =?utf-8?B?bGxwZUNHZFJEVzN1UzRpYzhaam1pZlZCZlhTWktTMjVBTW4rTExmWnhpK0Ji?=
 =?utf-8?B?MU9NN1RhTDBXeW51c045c3hob1Y5TDJIMGM4bVdPcTUrZFhSakZES0pKdkFq?=
 =?utf-8?B?SCs5VUQ3OXZ6dldlVzRNVnhSU2ZyczlsOCtRdGhWa1p1YksxL2o3QXVMS1pD?=
 =?utf-8?B?V0JVaFlidzgxNUJxOGNPbmVDOFczRzR5d0s4NFBSZVg3SllBbDlaM3pmQTBy?=
 =?utf-8?B?TEl0Z1RZUUdTMStEbFQyTHlrZ0doak9tN0prcmg4M2VtTlN1aEhHZEszZ1pI?=
 =?utf-8?B?MVlGSzJwSVY0b2FhdXdNUTNPQk56QVdBNEdNN1J5aThOK1kyQzlVZm0wc0NO?=
 =?utf-8?B?dkg3RWR1alhyVkxZOGFscjhma1E1cDN5am53UXM2N0ZZUENya3J4Mmg2QmNO?=
 =?utf-8?B?OU5wNEF3UStFbVlCSnQ1NjVEMi9SMkZRUTV4UW9vMkhCQm1uWHVwcDdMcU96?=
 =?utf-8?B?RENhQXNTa1J6clI1WFlwRi8waU9ad2h0L09manUvWEZUdzZZSFVkS09yK2RN?=
 =?utf-8?B?WnJLUUp3aDN0TDRsVWZ0ZGdTcExGSWFicjhZZWFUWUpxTmc1TE5rUmR2eXRZ?=
 =?utf-8?B?eHM4bTVseE9MZ3RpSWk0ZUpkSXJudXNIQzZ0MzR2RVdJcmY5UVQyT1FWMG5L?=
 =?utf-8?B?RU5qUzFOOGxsTldjY2RrSTQvajRramdkU3ZLdnFYaFZhRU9CZzdNSGx3Q1Yy?=
 =?utf-8?B?ME91WnpXVkFDQ2tIRmhOeVBFRHN2ZU1NRkpjT0JSRFBqN3FkdXJSNzA4a0c4?=
 =?utf-8?B?VGl5bDFoY2FNUG44VlZkVTU5NmJvYjgxeXY1QzZrOUNhVnJTWCt1a3lvSjky?=
 =?utf-8?B?NU8zMnVrMnh3ZTRSTURFb1VqTkJjZU1OYU9NQ2ZabWRGWGNzTzk4cFFPUTJu?=
 =?utf-8?B?dzNOVmt4TU9BVHJjZW9ZZGN5ZFZwZkMyNDVicEZJZE1NWVFINitDbHdzZE5E?=
 =?utf-8?B?d1dhMmhwR2UxbmVtK1U2ekRBWnk2UFd2RVVGMDk1ZHdKTER4NzlmSEIyZk5u?=
 =?utf-8?B?ay9UenI1VW5wUVR4eTMxcnpNd0FXeFdDbHBOdkhiaXR5eUlTM3pZMXJkS2lG?=
 =?utf-8?B?TWMxVm1KSHc0RXZjbEF0S3BFS3dhQlFVL25tMGVzM0x2bS82WUNwZHBab3VY?=
 =?utf-8?B?aXR3NWVLZGtkaXdLME4wcWY0WitrcTFsNENxaVAwVUhxNHFzYzAra3ZScGov?=
 =?utf-8?B?ZlZuTElFSzN0ZUYyMmhVOE1kZWg5M1NvY2RZVDNlNmVJV2JreGZqRURiTTcw?=
 =?utf-8?B?YU1WVHdqQmlzU2pRQzkrVGpxK3lPcFZRUE1xWUNnM1ZISjlHbXpNUXFDODg0?=
 =?utf-8?B?b2Q3UTRKNlJkK3pSWW1lbEtBL1J3UEZ4bUIzVkV5NWNoYWJCSnZ0NVZpWTNq?=
 =?utf-8?B?U0p2NUYrRExNVjFMemRKaXk4Y2Y5aUxTdmtwVmF3NzZoNWFsUENtM2FlQ0lF?=
 =?utf-8?Q?fiLv+hRnWbPpzT2BFALFYhrFdj9jWOoqShL8g?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd46dd7-ede2-41ef-c289-08da16f87d71
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 11:36:14.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZMbmKVCOX7eez2cnA3KilY2UR5UkdJqHesMtB4YakXix6aj1xt49lNkHPTeMvXjduXNzmh69KDqwgmxA8QWcOAYqByDkQwOtzCDsTEO8z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4114
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

thanks for the quick reply!

On 05/04/2022 12:43, Michal Hocko wrote:
>> 1. Crash of v5.4.170 on an ARM32 machine:
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 00000104
>> pgd = e138149d
>> [00000104] *pgd=84d2fd003, *pmd=8ffd6f003
>> Internal error: Oops: a07 [#1] PREEMPT SMP ARM
>> ...
>> CPU: 1 PID: 6172 Comm: AaSysInfoRColle Tainted: G    B      O      5.4.170-... #1
>> Hardware name: Keystone
>> PC is at release_pages+0x194/0x358
>> LR is at release_pages+0x10c/0x358
> Which LOC does this correspond to? (faddr2line should give you a nice
> output).

Sorry, I forgot this info in the initial report:

this is indeed the del_page_from_lru_list() in this crash. So it's either two different ->lru_lock
or some other code path doesn't take lru_lock at all...

-- 
Best regards,
Alexander Sverdlin.
