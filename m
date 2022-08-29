Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0C85A4207
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiH2Ete (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH2Et3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:49:29 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD0E23BF6;
        Sun, 28 Aug 2022 21:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H93hO5FhwarH305UnIbL0ZfsqfvcWfCeF5TaFqW5U+4nTNS2YE4CPXioHe71cBt3ATGk1sUCfwbKsy7bTBJ0fuK8xfrQ7WPIi4xX1BCFEUfldHVGYXBuOO96eh+70gKlNGNY+ksL2c0U3SP3FZaTPKoec3O4Ef5ly2NQvRXkFgynN2UxbBU4+qQlJDRRonh0THdXMfIDY+5+MMIHdncAO7XSVBdblnpPiLB58FTytzg+QjVk5VumJ9+KJYfFx7tZ+bKwpHCJDOW+7sH6/Wy364bD9Ekj0R+C6uTDHjIVvP1okrjf7gYvZDX7znfpzeNHFZHgZYTP/qJsrfGWjkm6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1pEKSkZ/UOkimi9/VzrGKxP/TWuLvr/DDzFV8JVRYk=;
 b=QO1L9oMbpsCX6jA61BUq8cB6k911B3L+S6EHtA0DBMB9din2xyLTYOpDh/sAc+olihPqRfgY6jPYOQlbAAubvOILeEZNGwQ/2jtgeJb/QFXIyrs06fX7bAB8ElYgRcPHQNRjVAW/yERj/+GFHvN6S7PsxuUU6+X03rj5QYSNC7z+bWE4SqDWoW7nGpAIzsz67uat0fULP5pHudtC9KrkmJKjTj+wHOTql9ZTKcDJrHmazgiV0RpcSeQ3CKWqhoudAYp3ElPDoe9OSo74ofTqwuXWRylFz+qfL6Gsw8oAkbh+/hrBteR/fEJ7dHMFWG8a+3rNMiGBPPGJbz8e7vcDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1pEKSkZ/UOkimi9/VzrGKxP/TWuLvr/DDzFV8JVRYk=;
 b=QK/Hv/ats2SadJQM+OBeev7LbDoV0dVoWv760eIc+fFaL15HVB4bKrsdS+6cpd7kGDtetSPZwyqGx1r6pwyVsDpV6X8GAQ61OOcWgO/VEDTWfWmQ2j4lXOz0+omNOd+SzDcFIl7OSN5pO1yFxEVr8U3vBqQV8jWOkU6OO0SiHQP6/kQZLZ76loepdqubt2tDOdw1FaYBLIqN5+k/RZUHMmmQ60tPnbw96RC71vNwwSLN1u9UPsOXpv3zwR3LMcrprw1n0sJwDWhImc8SFPZsaAos7XyTaWhXqxNfL31r3lER0aP8xlLxgg6j6MHGQyxuYZUnckX8v6WOZ9jwCdOdoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 04:49:26 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 04:49:26 +0000
Message-ID: <29fb251b-4622-4eb6-538d-bab6ac6a76f6@nvidia.com>
Date:   Sun, 28 Aug 2022 21:49:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
 <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
 <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com>
 <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
 <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::6) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a3f56d2-19e4-4579-9e39-08da8979d9d0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4527:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfC+C1Qc1ZH8YUyTaIHTYT9anO8OyqvbR5N3rQVgP3SRS8XxsYjS4BFc1UE39G8XwBCKBCtcLS7vMYLYx38CaiQi4PDRbFw3rg8fb0Xnf5Fkb9c00OHYULj1asqVko8lr4YWLauY0GhNIgwba0/ifYnQu33macmDeY5a2kRoKaXz3SpPx6Drc/IdcK60inyafQzVn5qXNXKmMkzJaLxUJxTSM5M9FKAvG3NGAU5WWMg+GZMND1VuICG1HVVwaRUJvbo0kWySzoDTmesJdVt1dXos94ej3WhQnqd+uofz7UUodl0NQ0UTVnAEU74wZ7DWLlbfMi1rhmxRGbBiYEevVmIOq5O/XTkun73MuincUy1xIs45wnphDhNVpQJxpq+l3/NS+TMG0TRKOb9H/GCl9HT0WLZU6N/Sz+xVQf0id4jG3r7ulqAvKVYUYW1w38q5pLTE75Xf0+LzlxJiZMyraN4+BDmAiAkdw9/V1eFvxcPVfoa5uCO3vJsp9Y4GajhaQxWqKo/xLApuePOejYv878gj5j7Rd+G48tN3NlmB6ADvRoA7HU2bDv456VOPDzPA8vfQSyjrdfYsrK1vfLYQq/VPTdxgGntjiR66f7XviXvykGm+sioRYPUVzwk2Nd3Q92Fa/BI3G0Bt9TAJVXKZFRw+hyxb1YnIqFpNnc2j8DBWQdqPKJNLckP/b7RMxX6PEYHH+nZLU7ZcKfgxyUqwaKBXb9CevYs6pdKP3GhnriIxiGb0ydT5lmA+H5PSSVICfsGBDwczEyEA42ix8i5Zm/+IvDLn78tHeavAlL86h1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(6506007)(53546011)(38100700002)(2906002)(6666004)(2616005)(83380400001)(6512007)(186003)(26005)(6486002)(86362001)(8676002)(4326008)(66476007)(31696002)(66556008)(66946007)(110136005)(31686004)(54906003)(316002)(36756003)(7416002)(41300700001)(8936002)(478600001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk9uSEdOUnByaS9rYXN4NytyUHZKUzhDOTAzOHk1eDZkODNVOGdma0VaN2Uw?=
 =?utf-8?B?VTRTM1owdElOb2RTcGQvbFZ2b1hjTyt5cCt2N2E1d1pCOThVTnZUbTZwbUNa?=
 =?utf-8?B?aWVoR0xCRmNQeTRuLzZUWDRSK2orVE1abXJYNFdFbnFmQmxHYWM4cm5vcVBU?=
 =?utf-8?B?MnVkQUN5Sy9WOFRsekwvRDNzY1FuNktFWWhPQUV6bFh5YlhMK0ZxZGZtb0I3?=
 =?utf-8?B?UC84dTduTHg3YVlkWHdSVGE2NW8zR0hHMzVlRmExS2lMMWUwQzBOcC9YTEFN?=
 =?utf-8?B?OXFVNGRHN3FIWjR6WE5JaHVhS0FHeTNVWmgzZGFwSUZGZ2x5clRuMjdiZmpK?=
 =?utf-8?B?MmllRUZBVVRxQnNETFM3QUxXWnlwMHU0KytFcHB5eWxQS2ExL3lIWmpBK3ZU?=
 =?utf-8?B?a3pRbUtIR0xGNnZRRVlTVG9ISU15dEVOb3VkSjk4VGNrVHFTNXZvWWZRTHJy?=
 =?utf-8?B?eVd1NjUwS0N5YmVrWTl5eGtzbWpqVzNjYU11UkE2WmhtTmZScUUxZUVUczF4?=
 =?utf-8?B?VmZ6ZWFoTmszeVpQTzh0Q3lVQkRkVy81OXZtWTBGQzY4aml6OUp6RFZvRWRS?=
 =?utf-8?B?K2t0NE53NU1TczQ1WkVIQ2hMeW9INVNBYWsvdFRTVE5Qb1lrM1RMSDBML2Fs?=
 =?utf-8?B?Nk1SZXk5SnZ1Zyt6QmFqOHBmTnZ1WUZoUXJFNGhDNWFoUzdpV3g2MmZDT2JS?=
 =?utf-8?B?cnE3a3FOV0Z3Yk1aZm54VWh5ZDRhQjhLVEhtRVVNL0tzK3loMXZtZlArVWFJ?=
 =?utf-8?B?ZDFoZlJhK2xTdFUzbFVCUGI4blNIVk9SNmh6NEhKMVJ5RWE4bTREQy9OVEhL?=
 =?utf-8?B?N1RtRUdWV1NrSVk2NXNiRW5pOHBRSWFpUkx3bEliQVFtalF1NlQ4ckcyQWwr?=
 =?utf-8?B?OG95SnJGVVVCVUNZemdSN095SGxYSTRsejRla2N6VVZGVWh3OXlvT09meVBt?=
 =?utf-8?B?Z1pVckxCRkcrejJ4Tkh2UEZVSG0zRFRLOFFwQjk3UDlRYWlkcHZDRmdUTFBz?=
 =?utf-8?B?VG1hOHhOckRNdlBRUlpBT2JscW5CZWdHN1hVOS9VWEZRTlArRkM1OStmaTNQ?=
 =?utf-8?B?ak5paHB5ZFVLU25yTVFzOW4zSmhNQ0JRMUt4VE5wNm51RHF2OFlMYmM4cHRK?=
 =?utf-8?B?TDM1emNhYko3alBDbFlDREJmM014VEhMdW9mZ0lKbU1HclN1c1VqQkwzazlK?=
 =?utf-8?B?OEtwb3Ywc3hvZUJxQytKQys1bEZtQmYyRGl6ODBIZGhsL2R1ak11K0QxLzlK?=
 =?utf-8?B?Y2RIQUxoRHdGanJodFdRajhMdW52TEVKV0lLei9TY1V1NzlmOVJTVE5CTVBC?=
 =?utf-8?B?UDYwYU1JbW12WVhQL3BlRHFGQUN2cGNidERzcVYzNTFwK2t4VTI2KzhLNTVy?=
 =?utf-8?B?eEtVOTYyZk5qTlUrVXRDbTlSSDB3aVRicjVWMXhtWFBtVy8ycFdVZ0xaS0lS?=
 =?utf-8?B?QVY3MEwrV1V3bVk0UmtSWlJWQWVNYVpvNXZHRVliUnBuYWpTMFoySVJpVkJn?=
 =?utf-8?B?REMzSStRUFBTdzd6MkxEdFNVa3A3OXRxb1FUdHVyNjVndm5NNzJhY3hvQVlu?=
 =?utf-8?B?VUJ6cTU3czJwTWdLTmFTbi9jbG5YeEQ2blg0SnUraVhUUnQ2V3BBekZLaW1y?=
 =?utf-8?B?ZHNKVXNrUTBHeW9ndlcxdS9ndzVGQ2V5aEt5bjBLV3FOcDZIMnF3QW0yTjNi?=
 =?utf-8?B?RUcydVVkZnZ2TWNPelhLT2g5aWg2WkFwTWdhMVNtVW5wSTBnOWZwZ1BSNGJT?=
 =?utf-8?B?NUpHTEwwdGhzR1NQOEpUeWZiTlp2UEQxUFBTWTJTWUQ2aXRxWWJaS1huQUtM?=
 =?utf-8?B?RnlrUWVjdGhxSEVWMWNHM3JucitDdGU3M3pWbTVadE9BUGw3Wjhtc2EwTGw4?=
 =?utf-8?B?RjNrS0dpR3M3cDRLamoyS05QSVFJcytVVzAza0RtbDZLQzNQM0RzVkpRc2hC?=
 =?utf-8?B?Y0NmK0Zac2prdi9NSkk0b1Ayb2l5dS85cDJkUDR3S09tL1hDb0plL1p2MmVB?=
 =?utf-8?B?UmIrc21qVEhTYktkSTJOcTB1VmVVU1JhTVl3Zmh2UEtVcjlpVGFadnNSSUY5?=
 =?utf-8?B?eTZqZGVxUEVwNllhcHR3QWJQVU56aFFNTzYwTXNkNXd2WEF0dktYK0Zid0tM?=
 =?utf-8?Q?vux+bVDldY+C7N6utjri709di?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3f56d2-19e4-4579-9e39-08da8979d9d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 04:49:26.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSjE7okJxyagNioC0qkyNgjRaYR/GN8+PsYUqQgHsqPoVrraNaOwZRjSi/o49KMyPn+GLZV9xpi38dThupqXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/22 20:07, Linus Torvalds wrote:
> On Sun, Aug 28, 2022 at 6:56 PM Dave Young <dyoung@redhat.com> wrote:
>>
>>> John mentioned PANIC_ON().
>>
>> I would vote for PANIC_ON(), it sounds like a good idea, because
>> BUG_ON() is not obvious and, PANIC_ON() can alert the code author that
>> this will cause a kernel panic and one will be more careful before
>> using it.
> 
> People, NO.
> 
> We're trying to get rid of BUG_ON() because it kills the machine.
> 
> Not replace it with another bogus thing that kills a machine.

OK, this guidance, and the write-up that follows it, is all very clear,
except for one point...

> 
> So no PANIC_ON(). We used to have "panic()" many many years ago, we
> got rid of it. We're not re-introducing it.

...here. I count ~1000 calls to panic() in today's kernel, to a 
function in kernel/panic.c that shows no hint of being removed, nor
even deprecated. 

$ git grep -nw panic\( | wc -l
1321

Could you please clarify that point? (I'm not trying to debate 
policy, but rather, to figure out what we should write in the
documentation of the policy.)


thanks,

-- 
John Hubbard
NVIDIA
