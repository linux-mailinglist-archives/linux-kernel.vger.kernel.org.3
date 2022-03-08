Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C774D1939
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244682AbiCHNeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiCHNep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:34:45 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8984505C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646746425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5sRyC2eJFDIaZJ2S/vbM+9sRGC+3+bM/bTMXjdnLu4M=;
        b=Li7T47kJNsgmDJxFqz3wvWGNUbZFqTbwJW703f2TlHVQBDHujmWuTy9g14tbDb6yrHPar3
        TZsVnJHBtblCnxeeMHF++cBVzSGvf0rtayAZf1LbO9uNQFbAhEHxpPXBsvsuR47tMWfM6O
        u5OnwOS6ygij690ZmRlVlE9Ku7XCp1Q=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2055.outbound.protection.outlook.com [104.47.4.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-X8yrLI3-OgSRvMjcRgtWtg-1; Tue, 08 Mar 2022 14:33:44 +0100
X-MC-Unique: X8yrLI3-OgSRvMjcRgtWtg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyoOhahjk4Cfy45u6tozPg5MaVpt6Y6f5/hE4Wj2WMDkEnGKmkEPUYf7bsmvexcOok0k2SG6IYzkogTHbAjON9+tbbgjY9KkdaBbZ/nYLJpeK4O4A3ziqDQQG5P1/0lwABRq7H7qRGiVUjmbUSj5z5F54x3dw8QNFp7QqRdOwV0E30wcWsLGhi4w8gf0ulTU5mm54k8xXUe7tUGNV8epZ/nYeVFhtlqcd2D+WGBJ7wImLb+SAjnfAZOTtPQ7W+FirHdQZt0y1dnlozqhxwhuyaUluOw1ozPGnw4uqutIbKZ3nK0TMGOrsIc3qIQpVRoUY6/vVY5fzRI5ChZHSCuOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sRyC2eJFDIaZJ2S/vbM+9sRGC+3+bM/bTMXjdnLu4M=;
 b=VrTUbymmZmni+g/tJD+1kJRuRHu2YL6arX6ei4ncStvwUc58kSDS3yik9g+rralmJ/uFkXE2pO2we4DdgYcZo/9uNQzBUXiEIssqVbjatb2S7zorT/wJqOF/6h4xixp90XuEHQC+pC9Fx+mWI1o13lOB+wZFwb2irDvk85X7wnU0VnUtDIJeRubpQWwE0k1VBrKu1LX/cL/Pkd4uBjHtOR2lYWW12uAk7oOw3A9vIbtxzwD26IUYtJ6RkTyCwIOAnNNJXE+1356TyNnuYYMFYvTjSGjQSo0YPXqo9aVVDgcJnKUC+6AHfvGEj8s6cOhpBDL0sjFUlUFYyZ2E7Cfznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by HE1PR0402MB2875.eurprd04.prod.outlook.com (2603:10a6:3:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Tue, 8 Mar
 2022 13:33:41 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:33:40 +0000
Message-ID: <571cc1fd-2586-e666-465f-2607735bcd0b@suse.com>
Date:   Tue, 8 Mar 2022 21:33:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <202203081837.zOttrQRN-lkp@intel.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [kdave-btrfs-devel:for-next-20220307 108/147]
 fs/btrfs/scrub.c:3146 scrub_raid56_data_stripe_for_parity() error: we
 previously assumed 'bioc' could be null (see line 3138)
In-Reply-To: <202203081837.zOttrQRN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:a03:338::8) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311db30c-07ed-482a-440e-08da010841fe
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2875:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2875978E7DBDF4EAFE79857BD6099@HE1PR0402MB2875.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttXaj1tKgoyQrlCCI+aPkD41qmoQxNVufaL58gKJvNjyAqYypXHwbKvCnhaUG7xlXjS/nXFkvCAJV2zJyPGwwjH+bTamr1Eq5uaWNYmlPsdxxaBR92ioG+e5EeM+R+hTELHjY8saYCSNzj5DmGpbmuOdMOy0TEu/roJgII1F6yE3lXls+AKCf69OKHy3NxkqKGHjHa7t6vfjY06K+4x2d63uGcSrGQvjq512r3hc2wnqb2I5uVSkUbMDdWXxpRPMH+Ht4yZVFDV77VWbxY8W5p4YYks3nMdxwb4mXYTDJkYwJgh+BBaLKo3m3nU0oxN305vA2U4kTyuWMncIKPQ0Lkx/Qgsob51x6Yke3hiLLFfJ3sAgRSy2ozxPEVBVxYJEPvttsTNqGG6rkWlK02ianKtjsmKt08QblzeQOqbsABM+eSIRNBmnCH8pSxyyKna7CHYosuCbxrVFLkSVcbLDOnhkDIJ1LlKX8UnGk7PCYN5If4Q3awYqZxrwHAKGk1Pr+CSWOi5xVCu3cRUCFWfc9QXwClSA6QJ8jhJB0Q5RJlnvIWT/yxxBt6tc4k04TFyCU/LUwe0PK/6ikYiUGc8NgumvM+QKD7vBGuSbU+x/0pcYnJt/SSrUREIrKPJ0XpxpXbp3viHaK4MLxJAiFk6zcNZoeQ9Ir1JSAIz9sxbeBnTGmFgGaqIzNex0B6Z6NoijmYSztpbT/gRMqzwM/1NZU95Dz5/erkp0G6I6ajDApBofk1MnSh1Fcp9vtJYmPjyJ5JAn9H8N6xzIPjuP5PvtMP20o+LGxhOOd3njUv2S9LoFENaQV//FDTSL7bKKodZh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(8936002)(4001150100001)(5660300002)(316002)(2906002)(31686004)(966005)(6512007)(6486002)(508600001)(53546011)(186003)(26005)(2616005)(107886003)(6666004)(6506007)(86362001)(31696002)(83380400001)(8676002)(66476007)(66556008)(4326008)(36756003)(66946007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVwY3B0ZGhva3U5UVpzempmdzFZMXQydXZ6VkQ5cXkzQkFlV1NJcmliTVlZ?=
 =?utf-8?B?R0ZaZnVJMzV1cm0yWG1rNzQzZWllaVhta0tjeFhIWksyd21JaVMzM1RtczNF?=
 =?utf-8?B?N2oyRE1OL2dJUzRWTVJzOVFtY3I4THVuNnpOMDNUcW50cjh5aTFiK2NUWDla?=
 =?utf-8?B?S1k5SXJCZWw1RHRUR2hpRGJiTDB0cGhGNDhnK3M3bFNCTUJtQUttWDVPYlBS?=
 =?utf-8?B?MzZWVTZJWVVhRHZ6NVp0aHpUYnpINzR4TDNocnlGa3o0NDd2WEVUUFIvV3hJ?=
 =?utf-8?B?RVhjRlpXd1Ryb0M4Z1Z1cXVjbXVqcjlsWHVBd1hpRVVoZWw5ZUw5UmVWbWpa?=
 =?utf-8?B?bG9BM0VjNW9CaHFaeVc1UHpPNStUU0UweEVTcmk5bHJpWlhSN25HazVnRDRh?=
 =?utf-8?B?QWVKVHhKVGNySDVUQ1Zwbm1VWlBsQ2wrYy9QbytWeWFySWlibFNmQlhVM3Rt?=
 =?utf-8?B?UkF5RWVKWDFMZmJzSVNsWTNTeHk2QUlGVnAxR2dLUHRaSmYwaWFtaW41ZDFi?=
 =?utf-8?B?VklNVmZEYW5lak1maFRDMUttL1V5dW9QSHRBMVM1aXVaQXFKRmpXMHVIbXRo?=
 =?utf-8?B?ZmkxLyt4OE9FaXJ4SFJXOFd5cnZCeTdoakp3eitEN2pmd2ZtY1Q4SWVpd3lT?=
 =?utf-8?B?U0ZrV0I3ckxIc2Vqa1U5K3RFdDNtSzB0cFlFMjlIc3c0ZVpkMGVpK0c2bGtH?=
 =?utf-8?B?eUJ1U2JNWk5oZElWV1ZiRTlyNXV6STgyOXF6MzJ0V1NId2NMWHNpRXd4VXVx?=
 =?utf-8?B?enZDWXhwTDZHSHJuRUhJaWlUUnVxekhvT1o0VDFsWWZrQWszNWNIbXE0VDRr?=
 =?utf-8?B?dWNLYzB3SlpxRjY4cllrYzc5dm9rUDAvaTZ2eXdieUVhN2ppSXV0YTJxSmhh?=
 =?utf-8?B?dml0c3NXbmpiYmRLV20yTWIwNEx4TEtFWlBSYndnRTQ1VW00ZVVBMVl6cnpQ?=
 =?utf-8?B?dGp3WURUUmUzdkt6YWVleTRBMTJmWWp1YUJ6cUtNTWtTaVZxdlNLV1RhM0tT?=
 =?utf-8?B?citlVXk0UjlMMUZyUHA2TWRkVmt5b2JwaklJbmJyRFFVU0QzcDEzS08ycGFV?=
 =?utf-8?B?WlJLbjJteU9yUzdrZUFIb1FyZzhIUGNpbXZudGRlZVRxQ3BxaHlLQUd3RWV1?=
 =?utf-8?B?bWFUNHZlaVZLbWwzUEl4djVvUnJ1bytJM05Yekl4K1M1OGpaVDFFVUJnbksy?=
 =?utf-8?B?d0d6dDlsWmFua0VIS1ZYdG9RQ2h4bjBLckIxY2FvL203WTFvUzl6SzU1clY4?=
 =?utf-8?B?Yk1GRFdKNFpDMnFzUXNKQUtrU0srU1hBS2NXczB3N1JNQ1E3Zkl5dVFzNUJO?=
 =?utf-8?B?aVhxbVMvL3pHL09qTTRjRWw3aTFrb1ltZ2JSR2RhY1FYK1dlb0xST3liSnNh?=
 =?utf-8?B?WSs5TFQvS1pTQVVNMXFLMlBSeEVVeGRlRlhQYVVXcFNNSFZ3Z2o5MjJWTEVM?=
 =?utf-8?B?MXlVSTc4RkJ2U1p5a09CQzZmdjQySWZqRldJOEVHR3dFcm11NityU0d2QnAr?=
 =?utf-8?B?L3pFT0g5SlY3cWZxNnJxalZZYVp6YS9WZmhVaEtWRVhBLzdoNnlSaGxsYVBa?=
 =?utf-8?B?NldtdnkxSzJ5RUhmc1ZFaTUzZ1FSRS9sZjRlT0VqcGU2OEZ4dFpUUnN0Z0pm?=
 =?utf-8?B?Q3FqdXdiT1dNb0E0WEJxVnJWVVpBTXpPRjZscmo1SWRzTTFkcHVjQzFiUVA1?=
 =?utf-8?B?WVl2YmlSU1BBbWFhTWFtZFJ4T09iWlBDd3cvK2psTHkzR0FJTXVHOGVWM1Rn?=
 =?utf-8?B?UVN5OFVwbjFpNlJoRGNzNUt3UFFwejRsQkMwdytiM2ZNTi81WlUxRkNsblli?=
 =?utf-8?B?cVBCYVBMZEFSaWY2VWJtcGdIR1dmMVhxTlRpY0F6Y2R4cS9yWndFb09mWDlr?=
 =?utf-8?B?WXdDb0htY1lxSjUzd1B2VzNodXJkeERUdjl1SUhHUDh6SlBpSVNFNGdTbUZZ?=
 =?utf-8?B?Q3gycFRJMEJENXBaR3huQXpFWmRlRENSdldTSFBTNUpzdTdMcFNnSVVyQTAv?=
 =?utf-8?B?QnhXU1ZpM0ZqN25BUFppTlJzSVVWVFI5bmtOeTlhQU1KN3hOamNCRzhGUEdL?=
 =?utf-8?B?TmVaYWZSVk9EV1doTHVPc1d2RGI3U1U2MnN5VFUzaXVUdmVIZHJGTVRyQ2sw?=
 =?utf-8?Q?mSlw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311db30c-07ed-482a-440e-08da010841fe
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:33:40.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVNJEQUPO8YGNU9bv6h/ZSDn1PF1FWrj2IQcvJ/V7vNF2T+TFHEFMNi5qT3tKHnP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2875
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/3/8 21:09, Dan Carpenter wrote:
> tree:   https://github.com/kdave/btrfs-devel.git for-next-20220307
> head:   912dedd70aeb485247c507115704ea7d137d758b
> commit: 80cd926eefca522182ee3cf04d8e9984073d34d1 [108/147] btrfs: refactor scrub_raid56_parity()
> config: i386-randconfig-m021-20220307 (https://download.01.org/0day-ci/archive/20220308/202203081837.zOttrQRN-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> fs/btrfs/scrub.c:3171 scrub_raid56_data_stripe_for_parity() error: uninitialized symbol 'extent_start'.
> fs/btrfs/scrub.c:3172 scrub_raid56_data_stripe_for_parity() error: uninitialized symbol 'extent_size'.

On that branch, the final code no longer has uninitialized 
@extent_start/@extent_size.

As the latest code calls get_extent_info() immediately after 
find_first_extent_item().

Furthermore, even at commit "btrfs: refactor scrub_raid56_parity()", 
IMHO those warnings are still false positives, explained below.

> 
> Old smatch warnings:
> fs/btrfs/scrub.c:3419 scrub_simple_mirror() error: uninitialized symbol 'ret'.
> 
> vim +/bioc +3146 fs/btrfs/scrub.c
> 
> 093741d4cda2cb4 Qu Wenruo     2022-02-18  3021
> 80cd926eefca522 Qu Wenruo     2022-02-18  3022  static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3023  					       struct scrub_parity *sparity,
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3024  					       struct map_lookup *map,
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3025  					       struct btrfs_device *sdev,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3026  					       struct btrfs_path *path,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3027  					       u64 logical)
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3028  {
> fb456252d3d9c05 Jeff Mahoney  2016-06-22  3029  	struct btrfs_fs_info *fs_info = sctx->fs_info;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3030  	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
> 80cd926eefca522 Qu Wenruo     2022-02-18  3031  	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3032  	struct btrfs_key key;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3033  	u64 extent_start;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3034  	u64 extent_size;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3035  	int ret;
> 2522dbe86b54ff0 Qu Wenruo     2021-12-14  3036
> 80cd926eefca522 Qu Wenruo     2022-02-18  3037  	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3038
> 80cd926eefca522 Qu Wenruo     2022-02-18  3039  	/* Path should not be populated */
> 80cd926eefca522 Qu Wenruo     2022-02-18  3040  	ASSERT(!path->nodes[0]);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3041
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3042  	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3043  		key.type = BTRFS_METADATA_ITEM_KEY;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3044  	else
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3045  		key.type = BTRFS_EXTENT_ITEM_KEY;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3046  	key.objectid = logical;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3047  	key.offset = (u64)-1;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3048
> 80cd926eefca522 Qu Wenruo     2022-02-18  3049  	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3050  	if (ret < 0)
> 80cd926eefca522 Qu Wenruo     2022-02-18  3051  		return ret;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3052
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3053  	if (ret > 0) {
> 80cd926eefca522 Qu Wenruo     2022-02-18  3054  		ret = btrfs_previous_extent_item(extent_root, path, 0);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3055  		if (ret < 0)
> 80cd926eefca522 Qu Wenruo     2022-02-18  3056  			return ret;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3057  		if (ret > 0) {
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3058  			btrfs_release_path(path);
> 80cd926eefca522 Qu Wenruo     2022-02-18  3059  			ret = btrfs_search_slot(NULL, extent_root, &key, path,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3060  						0, 0);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3061  			if (ret < 0)
> 80cd926eefca522 Qu Wenruo     2022-02-18  3062  				return ret;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3063  		}
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3064  	}
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3065
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3066  	while (1) {
> 80cd926eefca522 Qu Wenruo     2022-02-18  3067  		struct btrfs_io_context *bioc = NULL;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3068  		struct btrfs_device *extent_dev;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3069  		struct btrfs_extent_item *ei;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3070  		struct extent_buffer *l;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3071  		int slot;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3072  		u64 mapped_length;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3073  		u64 extent_flags;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3074  		u64 extent_gen;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3075  		u64 extent_physical;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3076  		u64 extent_mirror_num;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3077
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3078  		l = path->nodes[0];
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3079  		slot = path->slots[0];
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3080  		if (slot >= btrfs_header_nritems(l)) {
> 80cd926eefca522 Qu Wenruo     2022-02-18  3081  			ret = btrfs_next_leaf(extent_root, path);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3082  			if (ret == 0)
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3083  				continue;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3084
> 80cd926eefca522 Qu Wenruo     2022-02-18  3085  			/* No more extent items or error, exit */
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3086  			break;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3087  		}
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3088  		btrfs_item_key_to_cpu(l, &key, slot);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3089
> d7cad2389560f32 Zhao Lei      2015-07-22  3090  		if (key.type != BTRFS_EXTENT_ITEM_KEY &&
> d7cad2389560f32 Zhao Lei      2015-07-22  3091  		    key.type != BTRFS_METADATA_ITEM_KEY)
> d7cad2389560f32 Zhao Lei      2015-07-22  3092  			goto next;
> d7cad2389560f32 Zhao Lei      2015-07-22  3093
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3094  		if (key.type == BTRFS_METADATA_ITEM_KEY)
> 80cd926eefca522 Qu Wenruo     2022-02-18  3095  			extent_size = fs_info->nodesize;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3096  		else
> 80cd926eefca522 Qu Wenruo     2022-02-18  3097  			extent_size = key.offset;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3098
> 80cd926eefca522 Qu Wenruo     2022-02-18  3099  		if (key.objectid + extent_size <= logical)
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3100  			goto next;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3101
> 80cd926eefca522 Qu Wenruo     2022-02-18  3102  		/* Beyond this data stripe */
> 80cd926eefca522 Qu Wenruo     2022-02-18  3103  		if (key.objectid >= logical + map->stripe_len)
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3104  			break;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3105
> 80cd926eefca522 Qu Wenruo     2022-02-18  3106  		ei = btrfs_item_ptr(l, slot, struct btrfs_extent_item);
> 80cd926eefca522 Qu Wenruo     2022-02-18  3107  		extent_flags = btrfs_extent_flags(l, ei);
> 80cd926eefca522 Qu Wenruo     2022-02-18  3108  		extent_gen = btrfs_extent_generation(l, ei);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3109
> 80cd926eefca522 Qu Wenruo     2022-02-18  3110  		if ((extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) &&
> 80cd926eefca522 Qu Wenruo     2022-02-18  3111  		    (key.objectid < logical || key.objectid + extent_size >
> 80cd926eefca522 Qu Wenruo     2022-02-18  3112  		     logical + map->stripe_len)) {
> 5d163e0e68ce743 Jeff Mahoney  2016-09-20  3113  			btrfs_err(fs_info,
> 5d163e0e68ce743 Jeff Mahoney  2016-09-20  3114  				  "scrub: tree block %llu spanning stripes, ignored. logical=%llu",
> 80cd926eefca522 Qu Wenruo     2022-02-18  3115  				  key.objectid, logical);
> 9799d2c32bef6fb Zhao Lei      2015-08-25  3116  			spin_lock(&sctx->stat_lock);
> 9799d2c32bef6fb Zhao Lei      2015-08-25  3117  			sctx->stat.uncorrectable_errors++;
> 9799d2c32bef6fb Zhao Lei      2015-08-25  3118  			spin_unlock(&sctx->stat_lock);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3119  			goto next;
> 
> This goto next is what triggers the uninitialized variable warnings for
> extent_start and extent_size.

But for that "goto next" we just go next slot, not relying on @extent_start.

> 
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3120  		}
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3121
> 80cd926eefca522 Qu Wenruo     2022-02-18  3122  		extent_start = key.objectid;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3123  		ASSERT(extent_size <= U32_MAX);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3124
> 80cd926eefca522 Qu Wenruo     2022-02-18  3125  		/* Truncate the range inside the data stripe */
> 80cd926eefca522 Qu Wenruo     2022-02-18  3126  		if (extent_start < logical) {
> 80cd926eefca522 Qu Wenruo     2022-02-18  3127  			extent_size -= logical - extent_start;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3128  			extent_start = logical;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3129  		}
> 80cd926eefca522 Qu Wenruo     2022-02-18  3130  		if (extent_start + extent_size > logical + map->stripe_len)
> 80cd926eefca522 Qu Wenruo     2022-02-18  3131  			extent_size = logical + map->stripe_len - extent_start;

And from now on, both @extent_start and @extent_size are initialized, 
we're safe to break/goto next.

Or did I miss something between?

Thanks,
Qu

> 5a6ac9eacb49143 Miao Xie      2014-11-06  3132
> 80cd926eefca522 Qu Wenruo     2022-02-18  3133  		scrub_parity_mark_sectors_data(sparity, extent_start, extent_size);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3134
> 80cd926eefca522 Qu Wenruo     2022-02-18  3135  		mapped_length = extent_size;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3136  		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_start,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3137  				      &mapped_length, &bioc, 0);
> 80cd926eefca522 Qu Wenruo     2022-02-18  3138  		if (!ret && (!bioc || mapped_length < extent_size))
> 4a770891d9ddf94 Omar Sandoval 2015-06-19  3139  			ret = -EIO;
> 4a770891d9ddf94 Omar Sandoval 2015-06-19  3140  		if (ret) {
> 4c6646117912397 Qu Wenruo     2021-09-15  3141  			btrfs_put_bioc(bioc);
> 80cd926eefca522 Qu Wenruo     2022-02-18  3142  			scrub_parity_mark_sectors_error(sparity, extent_start,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3143  							extent_size);
> 80cd926eefca522 Qu Wenruo     2022-02-18  3144  			break;
> 4a770891d9ddf94 Omar Sandoval 2015-06-19  3145  		}
> 4c6646117912397 Qu Wenruo     2021-09-15  3146  		extent_physical = bioc->stripes[0].physical;
> 4c6646117912397 Qu Wenruo     2021-09-15  3147  		extent_mirror_num = bioc->mirror_num;
> 4c6646117912397 Qu Wenruo     2021-09-15  3148  		extent_dev = bioc->stripes[0].dev;
> 4c6646117912397 Qu Wenruo     2021-09-15  3149  		btrfs_put_bioc(bioc);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3150
> 80cd926eefca522 Qu Wenruo     2022-02-18  3151  		ret = btrfs_lookup_csums_range(csum_root, extent_start,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3152  					       extent_start + extent_size - 1,
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3153  					       &sctx->csum_list, 1);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3154  		if (ret)
> 80cd926eefca522 Qu Wenruo     2022-02-18  3155  			break;
> 6fa96d72f79a155 Zhao Lei      2015-07-21  3156
> 80cd926eefca522 Qu Wenruo     2022-02-18  3157  		ret = scrub_extent_for_parity(sparity, extent_start,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3158  					      extent_size, extent_physical,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3159  					      extent_dev, extent_flags,
> 80cd926eefca522 Qu Wenruo     2022-02-18  3160  					      extent_gen, extent_mirror_num);
> 6fa96d72f79a155 Zhao Lei      2015-07-21  3161  		scrub_free_csums(sctx);
> 6fa96d72f79a155 Zhao Lei      2015-07-21  3162
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3163  		if (ret)
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3164  			break;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3165
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3166  		cond_resched();
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3167  next:
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3168  		path->slots[0]++;
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3169  	}
> 80cd926eefca522 Qu Wenruo     2022-02-18  3170  	if (ret < 0)
> 80cd926eefca522 Qu Wenruo     2022-02-18 @3171  		scrub_parity_mark_sectors_error(sparity, extent_start,
> 80cd926eefca522 Qu Wenruo     2022-02-18 @3172  						extent_size);
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3173  	btrfs_release_path(path);
> 80cd926eefca522 Qu Wenruo     2022-02-18  3174  	return ret;
> 80cd926eefca522 Qu Wenruo     2022-02-18  3175  }
> 5a6ac9eacb49143 Miao Xie      2014-11-06  3176
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

