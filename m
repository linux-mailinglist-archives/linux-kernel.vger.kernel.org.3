Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8895AC7F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiIDWWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 18:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiIDWWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 18:22:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5A248C1
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 15:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrU7PO623UwxN1Bjb4tomNLRyXvr7mxcn9oiPQk9o6lF9+QgY1K6K8XIQj89wrq9nxc/nstKcZknStLaAdbVuXcON6Tku3jsGPlp5GB1uBzURXmqZsV+6jVmSQqbQVJ2RL1dkDop/xyLzV0xnz1rcne1ABUD/iQ7SiVijQLAOzWctjJ4ABhVMN/j7jUNaDFQCtbg8X3tVO96tmi5kjA4citTd6WTTdxTZVgcQJIoNIxsEg/Y0HPobch78gXJGj5BKKirqaIPuP1/aQZ3h0RM/Nc8ODNqtMPQ1xms7BQX/4h4RZ0odvhUsHtQeowcnBc2bB9qpXqlgCBWPMTBrvvUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Ub+lCfgmQOt/ZxoKKuaikoayD7PktHdG8G+ishuU4=;
 b=Sz+qdfIiU+xPTb3W5pk+E9I+WatfszenwSjANDF7i3qUn3eyVrkjFhjMlSzIttWUPfJtFAQAjIwklp8lHih5Mq55R681mqZVGo2hYD34RuGWnxVuJM+OOs0AJ+/rKLTFdOYbnIOdlHytEmKQjvrc7p1ie/Cjv5pNy+0jOad8y10ciRP53E05H1FPyvZ9FcphzLjaxvIQ9v4dS1tWRE6Rvq5z90oEHXSfstkzjr5M8kuc1PJa+2Taoh5qdr6b6dLveMCmkmxAD57cZs5E5AwXqIUWE9p/yJ8tff37xR9Ipsixs0cTwnmj2ZJXuycENyisrTuKrZ3L31X6AQ5vN9uv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Ub+lCfgmQOt/ZxoKKuaikoayD7PktHdG8G+ishuU4=;
 b=ZmvISQfarcJKzVjaSOAoPBMikEFF1Y3VRG/ORoI/9XFuW27CobPh41f/C3BzK0LEKFq0+Dga9oiQgojVxUkWza/quNtE5W83ncMpaD6uOW8icDgWFOofC5FGbwh9SqvzinAkblvdz59m4vlSuSa98dxUX1v1L56NobAMJvwc/a9Scs3/NxqcGjJ6ycC5qUJb6UEGdQ3Kzp8p0nvqDIQIahn3b/3tsmWBaGRSp9PW6AKhaBuX+po7P2XdkjripXWmufJK4adcEu4lPrYhyLiGrJa0bX8IozXovpSD2rx61UMu7HNuYbzccDTmIqo5H8krlpewbwuS6/pLw6oFN+Jnzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Sun, 4 Sep
 2022 22:22:00 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Sun, 4 Sep 2022
 22:21:59 +0000
Message-ID: <b51769db-0344-5817-7daf-a2e39c5d2644@nvidia.com>
Date:   Sun, 4 Sep 2022 15:21:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>
Cc:     david@redhat.com, kirill.shutemov@linux.intel.com, jgg@nvidia.com,
        hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
 <YxIofPiI8jvGzcjC@xz-m1.local>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YxIofPiI8jvGzcjC@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf5f8ffa-9f9f-46c7-1d30-08da8ec3e280
X-MS-TrafficTypeDiagnostic: DS0PR12MB7632:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cELsoZOA5/gB4xliGyFMth0KJh2uujebGrqUk76S8IXBi2ITF8rJ/PE7ADHxLw1j8zUcqSuESTRygicHsHB5xTsHiJKgjIMgh6lOf5Bcs9GXSiK9399iUr0YJ91tD6OCOoS6lL2CCv5PionyumAEKSGxsMMpAHpJkkh+GZSlrqwWXveB4N6UC+ATrCJuOOgHC3AVCyERNhHF5ZLjzAAlSrJIZTt8E+QZrDm+t3LXwVRJwazQcTu2ZafIDCsNrlfbs0ddR9vW61enILFWLqo1JvkDYCiVFXR98/6+9hud2jEBxb7JXeETRndEHTbgDy5JldT6Dm1/dtTGFUot13UyHEGSs+ic+z1kHw4sYQGwktPesdsnKZNtG/s0SdvOuU77X3Ntzhx0j9Ezc6AZEWYTwEvGdb2fzsex+HmVDq72mZaRkOCjiKuFsLqxF7bhBwtM2OfZeTP53OXSosmZrMcyeuvS8OL4qPU8Qqmqo+8xtxMc0GlpVMwQpVjVTrFgJ8nWZpS8+NvFqaOjvVsrOdyPamXIYsSJ5IEiI3sTtzMANouQSbwgye2tk9EwZo9Tw3JxNobC+tzrpZCjhFSDs6BSzlwyfB/WZ4EZJ+ssewQbqsHHvtaTfLqT7yBECq+My1tY9QBeYhKcIz2J86x7gghAO/3faJSO4B74ppyIyHPtaSSA9yk4Zytpijqq+R3SniEtAXzyDxUAqzWkuUHJl6zsk+8EX7c5UW7pbClMlbSPbGn7gOD378kY+Zb4TdZp2Tq6nu6E2Ei/Z+ELif+Z+pavKkBtmOMSNufCcweNSgW5dio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(186003)(38100700002)(83380400001)(66476007)(110136005)(66556008)(4326008)(8676002)(36756003)(66946007)(2616005)(31686004)(316002)(6486002)(86362001)(478600001)(31696002)(26005)(53546011)(6512007)(8936002)(2906002)(6506007)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yjl5MnRPa3psdUM5N1Rva2dMMXhRR2ZhMnR4RCtwUTZwL0RzMkdrbno5K0xq?=
 =?utf-8?B?aUZzVTNVRlNHOEZFRGJOVG9RaDJEMzROWTZsblVFcm1wbWtUb1dhQlVIVUVQ?=
 =?utf-8?B?RHFXSWZkTit3VU9jWEpJZkY5b2JKZi96UHVweFNodHBZRGxyaDZkdHB4QnVJ?=
 =?utf-8?B?b040TjgwazVGV21JbXB6SDZPbHVlRFNSc011WW10MGNvZ3h6QVhYZXNxblBs?=
 =?utf-8?B?NVBCeTFNS1JNcktBNGRqbm5lcmhONVpGazlEbFpFc0pCVTdSRjh0c1E0OEdt?=
 =?utf-8?B?eHdrNENML2xOOXhTbmszdW1QMnpXM2FIaUFPelg4V2JVeHczbC90UGtkNzQz?=
 =?utf-8?B?eHNLdGxXN1dDa2tjd1lMVmN1QmRPWkdYM3FtTkZjV2Y4aWYwOWxWSElzcmUx?=
 =?utf-8?B?VEhZMWRmcmZ5Q2p4SmcvK1ZJQ2g2Z1VPYU5ZT2NNczNneUJzbVFsaSt0M2py?=
 =?utf-8?B?NUdXSGRRTlZXa0VyZFY2MlRnMDNmQTlibU54RWlCKzl2UHYwVzNrM0FSRVI2?=
 =?utf-8?B?V0tCV1B5b0o2YmZpS1B0aGJ0SWc4ZEQ4SUtFVVRSMFdXZlJlTk81eDd1aXFU?=
 =?utf-8?B?ckpKeFU5N0VLblhtOU93dGszRWJJaGt4b3JId1ZCaUQvNlVQc3FGaU02MlBp?=
 =?utf-8?B?VllOY2dLVnJxT1ZxdkdiY0Y1Tm01SjBwWi8vT3UxTHhPVFhxcENESUJUTVJS?=
 =?utf-8?B?Zzc2QVBvVERwY2FxZEI1UEgvdCtsU1N2Mis4SUpCaCtvckNmaXFDMERyQ2JC?=
 =?utf-8?B?dm9kRml4ekcxTEs2THRMaFg0cmduVktIa1JnWVVvOGlBcndzZHZDOXB0TVZM?=
 =?utf-8?B?UTAyZktLMGg1d0IxbkFJa29yeHB5UDlPOUdibyttREJMelJ0ZnRRQ3ZvemNR?=
 =?utf-8?B?R210bzA3TW1PMnNaRTNabERqMHpuQUJwaG81UEV0LzhXM3FVckRKZFBqZWtx?=
 =?utf-8?B?QnZmNVBSV1NWK1JaVGt6eS9hb0dObHhVb0pDMHlULzVSOE9ZQm91YWdodlgv?=
 =?utf-8?B?bW5NTVVYSG9XRkIxeGFMUDdlNDhubU9FSkRNQnJPeEdWQVZSZ09EN2xvanRC?=
 =?utf-8?B?R0hBaERpaVBZMERXME1DeGxsZWxRc1FJamlyUUNZcTc0a21rc3UzdFAvQ0NE?=
 =?utf-8?B?b1ZWL1YvVHJkYWlsdUJtd0RKM0pVcXpDSk1TQXN4NVk0OUtjRVN6MnNiWmdS?=
 =?utf-8?B?VXVYaHRrNlh2TVY2eW90UTFmK1RTdURtYUNWV2l2TlZSRU9CcnlPNExha0hD?=
 =?utf-8?B?VER5WTlobkt0VmM2WGhOaUpaWXlRV0d0M081SmZobXd1d3dvTnRDOTFrUTJ6?=
 =?utf-8?B?S1hPYVdQL20wZmtqWlF6MTFSYzhJK3JOT09HcUdVdHBZaWFLdWdqWHB2aGxR?=
 =?utf-8?B?NGtuNEZvUVhhT2o1eGZDazVNNnorQUVtWEI2azJvN2ZWcXcrNlBCZWZ0TGh3?=
 =?utf-8?B?NTVHcnJ3NWg2bjV4NlNhcDlwNHc3VHdYdVFqTi92dTB2dnl2SWRld2x6V3pu?=
 =?utf-8?B?M3IxRy94Ni9UVk5FVjN2ZXhmNmxxYmZITzVCdk1hTmNsOWlBbDNld3JlSDJU?=
 =?utf-8?B?YUZHc0tQOUZZMW9XNkNIbGRTTTA2b1NUczNWZnRnR1ZVS2NXdGordTRlZ05T?=
 =?utf-8?B?VGszZnJ6Y1AvSnhmTU1IYXhUWjBJelZUZkx5OWVIbVR0cWdEaFgzL3hrWFQ0?=
 =?utf-8?B?bS9nblhvSzNKSStOL1NFVGtKSnRaTTlkV1NVc3EvTnZMV3VPN3BueXBKY2Zr?=
 =?utf-8?B?SS83WS91WW5nVnVwdWNzMm1uc3k1MHprTHFBSnZNWGJOUUdTTVoyYTNCWkI2?=
 =?utf-8?B?ejhrK1h2L2lDZlE4eHBFWnE2WkpBY1V3SzFiTmtxS09DMHpsSDVZL1pWYW9R?=
 =?utf-8?B?b0hJcnB1c2FWSTJCZmRybTlBZXpTakViTjg4aERTZzlxZngzbnZuZ045VDcy?=
 =?utf-8?B?ZldWODFubUZQc1d1c0VMT0hpSUR4M2I5L0RjaHZzVC9Dby9Gem4rQ1orU0l0?=
 =?utf-8?B?TldZVVpvNTd6REo2a1lsRE9kbDFzU1ZVZzJka3QwZHlxSmRDeWI1cVY5Sklj?=
 =?utf-8?B?SnJ5dVJyeHkvTWZqNzlvZ0hRdllwaC85eGphZjdiNTBHVFlJaVh2TTJhQ1cw?=
 =?utf-8?Q?fycyXFbACjzLo8gIwyR3TH6WD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5f8ffa-9f9f-46c7-1d30-08da8ec3e280
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2022 22:21:59.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E311E2OjmgUJwPGUxi7ecDifw/rKw3qS6JPK4UDPc7jLX3cVzOgqXL91tO0m6dHsXRPV29Pa6uhe9iClC6Z3rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 08:59, Peter Xu wrote:
...
> Would you mind rewording this comment a bit?  I feel it a bit weird to
> suddenly mention about thp collapse especially its details.
> 
> Maybe some statement on the whole history of why check pte, and in what
> case pmd check is needed (where the thp collapse example can be moved to,
> imho)?
> 
> One of my attempt for reference..
> 
> 		/*
> 		 * Fast-gup relies on pte change detection to avoid
> 		 * concurrent pgtable operations.
> 		 *
> 		 * To pin the page, fast-gup needs to do below in order:
> 		 * (1) pin the page (by prefetching pte), then (2) check
> 		 * pte not changed.
> 		 *
> 		 * For the rest of pgtable operations where pgtable updates
> 		 * can be racy with fast-gup, we need to do (1) clear pte,
> 		 * then (2) check whether page is pinned.
> 		 *
> 		 * Above will work for all pte-level operations, including
> 		 * thp split.
> 		 *
> 		 * For thp collapse, it's a bit more complicated because
> 		 * with RCU pgtable free fast-gup can be walking a pgtable
> 		 * page that is being freed (so pte is still valid but pmd
> 		 * can be cleared already).  To avoid race in such
> 		 * condition, we need to also check pmd here to make sure
> 		 * pmd doesn't change (corresponds to pmdp_collapse_flush()
> 		 * in the thp collide code path).
> 		 */
> 
> If you agree with the comment change, feel free to add:
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 

This seems fine, but I'd like to additionally request that we move it
to function-level documentation. Because it expands the length of the
function, which previously fit neatly on my screen. So I think it's
time to move it up a level.

thanks,

-- 
John Hubbard
NVIDIA

