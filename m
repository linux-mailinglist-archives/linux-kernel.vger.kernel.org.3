Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19389524036
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348732AbiEKWZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiEKWZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:25:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462CF13CCB
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbBUUn+xK+fLvc/zNB/Pxb7wHaKWumQnsUoISetEyizWdMZCg4Ki5qFd6DfjqjdIGFCt3MNGyhCjpr8Teyfw/iMwhIMmEsfHEXXTa2iYCWyo3DZ9rqmD7P2amdSahduvoLIP6Ps7qMeD4EC54rH9SS1buNCrWI2lL1+fRMHbmNVY17+9kV6xYA1R2JsLVHLxs/1mWYHW/EHIDc3dYY0lRAlsgRSIJLCLCUXOV5yDmlaQB7wlqTpgUbKGbombyRxO0wBYVRxRaWOue9oCeztkuLfiSqqgkzIPR3RSkvDZovw97w7NZMfUoDCvNos6oZ9DbGfiQY7TiahlyQnm+ZJB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8Wamra9PYF4ZrCWc4DM2lNNpM/YWBsGC1qoMPCaYM4=;
 b=Co8oyZMuCUybQKooUGTjvfeMibPxnU4ZVHBdkfeCqPmOmrG4PDxCCQWbDOztwmFgMM8lB0mlQvz+mLVUAbPEY7fB/q3H0tUq8bmIJqnRlu81JMDEqQczEleHLOfvAEoAze+IraGb+w0Amw6IzreE/tgeRSMWOgoyVX+yU36HR2yZJhzNsXunsBhl+vCEzS13xMkGlZPSEJ4r2CUrlGQLkdTq0LY0LQl2L2j06ngKZgkg3ggRPRjvYrzVOOwGvNV/4E2cTTj0ak+vPxQknVqjMUdH6wX8IPfyHy80X97M6FM0IcncBLeXhqBZ735Gtb+GVnCftJ0WEURy+ZdHaYJr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8Wamra9PYF4ZrCWc4DM2lNNpM/YWBsGC1qoMPCaYM4=;
 b=Ye8o0yMHaUBflp0EDi3UYkxHwLhgSaLkCn+rAbNWePxcTPACnmfYE6giQuei/4IqSFKNtrogcItVjqZ98ttbPNDtbrVhfwq3SxpR7bQ7VNFjWQg0eDsmCT1nst9dE4WhMqMyClqqRMu6rKFQT0ByZBMYR72cXjigDFZ48JWm9jZqhf9MpXaO+aBVv9EyEQABfIvQ5YOy7FQMDeVwsgsg8ujYRnPnq7yS2BZFwurF1S4w67XRPjju6+VdsP5TJuneSZWSJH9SHgAsTDL7tGBGwKvi+16r/OKAuK3gkVBtoQeuMJhLi0rt8CKi9H4r2HENTMT35OXC0AYZlJh4RDaVEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BN7PR12MB2626.namprd12.prod.outlook.com (2603:10b6:408:29::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 22:25:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 22:25:51 +0000
Message-ID: <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
Date:   Wed, 11 May 2022 15:25:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
 <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YnwupNzDNv7IbjRQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a30433-48b9-4a8c-f082-08da339d349a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2626:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2626B789A56B47816DAE1911A8C89@BN7PR12MB2626.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePGrfYihQX1h1nIkMyJzpRBhgTQ/oen248TMFApXEz0r09USJPGf/O9HuytQMR1BRuCYSoecWesIlZliolrs4qGU59N27mSUKd1ci1wwPBlFzzbEMGfA9THtyPYT6GYBS7ErU3KFtTJLQp6pYUntW6yoPFx8qFiQfzSnLDMR7MMZ3tmk6dXWXuq0jSYwfWTQ70Ld5AUkuvFN/vlmh46Wq2hTSnVBXnFV17ArM3ZhFoYumODFYb4JpvBYJau/VDvnJj8CqaLKVKUcLnG7XdO/+X8EmjPom0NNafssH7KdjN/AQogDNnpY9ZbZh/tHM19RcHvrlNvvEfuYBjnoRkHVVj/VifiEgV48Fdj85gps8UVN/0lsK3mm3ZIFscTeuqn+NrMDXN2VnUoWMgJoT+50F1qQAmUo9J85WFsrPvZoNjQoC8JBKHP8N449qd59+PqISIONuVzG9W6jjLGY1YkFH57BBjR3lVnJokWbGaCrDE6YtqS40leyfr34v71BCP0pNj/vpFh+s3P9mnXz55vH4v7eGIShs1ig0AkFKNVRU0a1oU0VSm9OcPbGys1QiusRxDXW7XTNP6JrDCcfeCssWhb+ozE4iR3TWAuMUTrPwJ4xktpqA/l44/WQ7GU93nNytKk13c4N2S2xgg6Zf5eDVtofWWTQ555sWJ+edRCi2yL754tp+cg+3gHc5Fx4TtLC5o7mM9ejKSpXvZZGzvxPUW5/gT9pYibMeTRAVb/Bd63ydCseSj2aztQK1BKTrJ3q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6512007)(38100700002)(2906002)(2616005)(6916009)(53546011)(31696002)(6506007)(31686004)(36756003)(5660300002)(8936002)(6486002)(4326008)(186003)(66946007)(66476007)(66556008)(8676002)(26005)(316002)(508600001)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUhzZEE0OHZiOXQ2QmQwMi9lUmJBL2h4OC82aXhoaTIzK3FQR3BkMTVwTWo0?=
 =?utf-8?B?eHArc2NnZS9NVnNoOU9haW1vTnlCRHk3SVpzMUtMdWVEWXJnMHh6SFdlcUNn?=
 =?utf-8?B?MzZDZmlyS1BpMVMrZXliNHVUS0hnUjJ1NS9HKyt0MnY5MnoxYXEzblAweFdp?=
 =?utf-8?B?TjVZYm44WFUwNlRNNkMzWmRZQ1RtSUNQaUhsZlIvVGpGVDdnK0NYNU5nY2c0?=
 =?utf-8?B?REJYYVkzeWZxNGR6bXg2dGxJWkI0eWlSaUpQZmFlM0wzYjlSWlFURU1sa0xL?=
 =?utf-8?B?QlR0ZEF1SW1iUENUNEh6NnMrbG9MK2Z0cXN4MkkySWcza1lrcXB2WmFWZmdu?=
 =?utf-8?B?OVVra0x6Ukc5M1JkWHZCaW1qWVhzMlNJcnFiUDJlNXZtTnM3alhuQW0ydWdW?=
 =?utf-8?B?RW1XSDdPMnpCTnJ5R1hRTFcvTzExQTh1WjB6ek9mbXFrRFQ3S3JkOVFQa0hj?=
 =?utf-8?B?M2Y1RlJLZnJPblBFbVpndGRVa3pUQk5aR3dMMC9VTldCLzdWU3pla3EwajUw?=
 =?utf-8?B?S1ErMFJnS0ZsTjBkVFU3d3pHWFBGSEV2MjkrTTd6SVhOMDJCSW8ySXd6NWJj?=
 =?utf-8?B?RFZGUUVjODBpNVA5K3c5eVJLbzRxd21xSGEzRXM3Mk5SSzYzWVNta1lKeXJr?=
 =?utf-8?B?Z0Y0WlNjN3lhQit0TVIxL3Y3emdUMkJkNE9sSHFNRnZBR2xNLzEvUzBEU1dI?=
 =?utf-8?B?cUd5MFRsRG5zSEdraFY4dUJ2Rk9NeS9QVFVxQVpoNXErMDhvWUZTUi9sS0hr?=
 =?utf-8?B?QXplOCtmeFNpVW01d2NtbkNqSjZJMmR4eXlPVURkNm5VUGs0WFhMMTRpWlZj?=
 =?utf-8?B?ZnQvanVIaThjWFBiK3FLYTBiZWZoWXdlUUpYanl4MUhmcW5QMjRFUzZOUXZW?=
 =?utf-8?B?YzZ5ZFIzTzNTaFhOajhteEYrQ25MVFNpQ1JzTEIxUFJXWmd5UEVPcmp2SU9s?=
 =?utf-8?B?Y1ZXL1R5NW9uNEZtUXJiS3FFTGlMYTBHSXFwQ0QxWWVmeUQzS2orMnhYZ0tz?=
 =?utf-8?B?MzYycnlPR01hVzVuVEcyQk1Mc244a0lXbEdSN3htdTRqNGFSM0dkWjUwOThW?=
 =?utf-8?B?UzJsT1lWYWdGTGZjeVU5QlU2V0pjSGVHenJBanVPWUMzRFl5T0xIZjUraXg5?=
 =?utf-8?B?YUE4ZzRhNFlveW01aUVScC9EYUk5TlJsSG1kWTdJSy9ad2F4aVF6OUpZaHBB?=
 =?utf-8?B?eFZ3NlRxRG92ZEt2R3IySHVYYVhSRXNaamFYMEc5Z0VyVjFjS0VSK0JtUnpW?=
 =?utf-8?B?TSswcnB6L3lZZiswL3lCT2EwMmFsdUdhakZNQ2Zyc0pHYXNyRm9hRXRhQ3hn?=
 =?utf-8?B?N2lNdFFUcmhWSFRML25XaXRTV2x3bE40dEE0U25uVHpkZkR2bFBCRTRDM1RT?=
 =?utf-8?B?d2gzNEVoUlhUOGorMVZqWlYyRFJsdTFnK2Z5SzExamV0K3dIckd6bDNJUjZ5?=
 =?utf-8?B?RlYrNkJWeW5KYVc2cHdtVW82ZTNGRU9NTXphSzYyUm5CaWZ2NHZLRUZsL3Rn?=
 =?utf-8?B?blJIYU1wQ3FSazdSUC9TNlM4WElDUVNSbDJ2cTF2Z1pmL3Nxc3Zkd1o0VzJ0?=
 =?utf-8?B?MjZxcXBXTWo5aUtjZnFadTNCR2pXUGNkaEJzd1Rwa3hmMGYzMVBtcEZUMU9Y?=
 =?utf-8?B?RFhzWFRkNTBCSDFLUlVlaW84Z1B0K1Y3ZkE3TWRUV0gvY0xwaS9tcU1URlJi?=
 =?utf-8?B?VnczblJobGUvbityTE1mMTJienUrYm5BWHQzZUR0cDMvWmxHSVpxR1pXYlpy?=
 =?utf-8?B?UUVKMi9VMEp0eTRLdUtnUkxoaGpjeGRldFZpeGoySU9HVENQM0YycmZDdGE2?=
 =?utf-8?B?S3orN1dtcmJOYUdoTmFKZUsrRnZOOUVrL1JWWWhwbjJ1Q203L0xOeHV3UjQ1?=
 =?utf-8?B?TzRVYUNTbkoycWx1UVcrSWNkUmFqTGxBOHRZcUlWYVp0UEZJYkZCRDNmZUNB?=
 =?utf-8?B?UEdCeGhxZmtEV0lta3Y2TytpamlnSEtNbE5ESzVCdWpQdHgwUytxWmRVeVoy?=
 =?utf-8?B?amd3aUFJN3NUZ2hyV21DQlhBNTA1eFgzbElQZjVKK2o3Z2s1S1BPN3FTUi9s?=
 =?utf-8?B?VThKTHhpNmp2VTJGZVhlL0NXYmI4MGxKYzdGMndONk15SkswakcwWHdlaHI4?=
 =?utf-8?B?djB0S2RNQ0xkV3owTVpGRWFteGVZUDBBa2ZSY0dWYWpScUsraWdYUW9OWTJv?=
 =?utf-8?B?MzRQRTlOVHd3TE5hcFJhV0oxampEZnN4Q3pKVm9RU0VEWG9LRHJnOVdmdDVE?=
 =?utf-8?B?UDc4UWFidFNXK2FYVUFWbjhHaXI5cUJVeERMNmdQZDNNcStRWFNsSzRZQWhI?=
 =?utf-8?B?RW9TV0ZwaThLQ0R2RWJHL2dWcEdKUVpKZGNiczc0RHZ0NExDRkkvSFd1UlZN?=
 =?utf-8?Q?JPEcNXnWQtM+X+oY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a30433-48b9-4a8c-f082-08da339d349a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 22:25:51.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYIXaR9t2j5DbJ/AZAPqFkL7mpzavTeIjWw/qvZQZ2yyA0a7CD8kCkkrY1zD7zMmeTbWNkM7trEaKL0k0LhcYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2626
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 2:46 PM, Minchan Kim wrote:
>> I read that, but there was never any real justification there for needing
>> to prevent a re-read of mt, just a preference: "I'd like to keep use the local
>> variable mt's value in folloing conditions checks instead of refetching
>> the value from get_pageblock_migratetype."
>>
>> But I don't believe that there is any combination of values of mt that
>> will cause a problem here.
>>
>> I also think that once we pull in experts, they will tell us that the
>> compiler is not going to re-run a non-trivial function to re-fetch a
>> value, but I'm not one of those experts, so that's still arguable. But
>> imagine what the kernel code would look like if every time we call
>> a large function, we have to consider if it actually gets called some
>> arbitrary number of times, due to (anti-) optimizations by the compiler.
>> This seems like something that is not really happening.
> 
> Maybe, I might be paranoid since I have heard too subtle things
> about how compiler could changes high level language code so wanted
> be careful especially when we do lockless-stuff.
> 
> Who cares when we change the large(?) function to small(?) function
> later on? I'd like to hear from experts to decide it.
> 

Yes. But one thing that is still unanswered, that I think you can
answer, is: even if the compiler *did* re-read the mt variable, what
problems could that cause? I claim "no problems", because there is
no combination of 0, _CMA, _ISOLATE, _CMA|ISOLATE that will cause
problems here.

Any if that's true, then we can leave the experts alone, because
the answer is there without knowing what happens exactly to mt.

thanks,

-- 
John Hubbard
NVIDIA
