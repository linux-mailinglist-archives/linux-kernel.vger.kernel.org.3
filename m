Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1A507DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358576AbiDTAlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbiDTAlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:41:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2071.outbound.protection.outlook.com [40.107.95.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02892B857
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moigYMTV7XTcuvhRBy0MchLX0TM7LApYUR/fONLTo4yTDKqnP4D049r7c4kEqQRz3ofkL6fnASn31CYzDkDuI++9YZZo8RV0RAWeqqP1IwBcRvUdyaEYt8i3WjRH4pDSXiSJY5BhvNo7NjN6yf4sGjty8L/7pdP8gjYFWxyZpPdmIHHDzPSBYJx9EPwSOVD3ZLlCLzKjDPxRQGgKfhuwwCK0Twvez06H3v2aItGYkWqnId+Sl9AvwivaMf+ZxysrZfOodZOEH86H5XznYsCHSvkFyU4c01ZB2gz7NADHhCfYYBZa5evMGdaJmXXvAPp+AN66qM3hvig3H4E53LVJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdIE435lxMT7L9ln//Mj5g1NJ3jesGtXBaHjDn9Ffwc=;
 b=bkUTZ3BTk20P5T6LtL0R5KE0HmenjRH3uwMsSJooGHZvWc+DMIa2ygwsj7lxg7F+3Sp6w++O2it99xKSGPplMk6JWMpIcodsF8OaE/Fhy5bEHGljj4ah+EiP0BR3hR9U3oVEfAc5R8r73qqVFW47MPvcBQzVczORYWi9olpyFZQNCPx8YHhtfHbVVgJebgw7zOcuzbDe7DzQmRmF6OMzGpuGKEuige0P52oSviO2uS9AO7kn9SRyTuyRjYhPr+nDuzJI4Qckx27aQBsyn94T6FsMK4G5vmuntYYz97TEkRPvptpg6/4lNSEIWthJlGhiS79ZzIcHeHmAK1Niyx16FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdIE435lxMT7L9ln//Mj5g1NJ3jesGtXBaHjDn9Ffwc=;
 b=j8aaiMDdP26xofD0IaY4jgwBkLpZF4ovsuk2OiP6QT6iV8zfb6nwHxKiy7/Wzi6CsoJ0Fj8HQSxI26Ts9IbHyApuenpbRsYZUXEX/UoWlk+SFLL8WflDxCHcRIhoxZUMtDd2yx5xD06AIpuhwfqWzPpQFsZ5+hAjyIpn+KBNJ9pHZThr/+Q+OimaEFDa2GpAOHrYpCweGRU75ac8cvqWZ3f0cMFvR6tOSksOQ+B4fNKGgVLx/hfPRkbb4uWaq8k+ZCvywmwXKji4Ig9OQPtU8hj7iw4vwNm9pQ2eSUILg3r2dx2ScU8K8TaYR5g27sOG0+0gzF7oUlI8cSxXOjZuGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BYAPR12MB2887.namprd12.prod.outlook.com (2603:10b6:a03:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Wed, 20 Apr
 2022 00:38:23 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 00:38:23 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, david@redhat.com,
        surenb@google.com, minchan@kernel.org, peterx@redhat.com,
        sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Date:   Wed, 20 Apr 2022 10:25:02 +1000
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal> <87r15tjy76.fsf@nvdebian.thelocal>
 <e320fb01-7d53-668e-53b5-463312ae0909@huawei.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <e320fb01-7d53-668e-53b5-463312ae0909@huawei.com>
Message-ID: <87k0bkk2rp.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::9) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9967e30f-0404-416f-ec89-08da2266131e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2887:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2887CC1FCF3D1801E54F71DADFF59@BYAPR12MB2887.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTZr09+ubVlfW4bkJ2Ep/zoMPstEgqfd0Ne4HgizbZzdphNCVCjzc1e77mlcF1kBLClze1CpFgvT3DsvG1gmjGeucgd7l3cRJSnDlsNMYUu4+0fftpTtrIzkEt1enjVi18cThB02g6OpqCiUVKGChZZn9GIfBcCj1kem224bAJQdJQVyOhXM1OwJa8Z5Z495zlg+M0EPtPSZU0QOC9e09XKlq8sjc8HG6dv03qCQZAQbtQI8GsDzDtfQ8EBeLYlo+erZ8W0IVXaFOgtGo7X7qODipc/80d/ihE54cG4grAb6JqJKuBuuHwHEhLvyFZQXj/Z0mFeMhxmoNazPZTCkWmSim6/OGIJLbGSUqgHr0GUGokjdhQeq0+JVvJtcQasCdKX27P+6n/qsyflPNMqyilxAA0vBZgs/vSlhlhVc/osYoL8amya8sd0Pw8Gcy2f8UJ+9ZYVz+B6xjUG7EYCTIx7ENy+/61nmgQfAwNbIX84zhYMWkZIxdYiS50f7hhRGIORRsn7pXJE6YkgP85Q8wsZ4U9C7gjDkIrjvP0ArOqJ7fHRV4BwxdpNjt4m7fr9pMYTaLmhe8F5T9qQ4XxFj3drpZ0GavZWqT3ks8LrabIRGQHJTc9yxO8D+5lR0EPvZ+abET1ULUKMVjkIjIX+WxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66946007)(8936002)(66556008)(38100700002)(66476007)(316002)(44144004)(6506007)(53546011)(6916009)(6666004)(5660300002)(7416002)(508600001)(186003)(26005)(8676002)(83380400001)(2906002)(9686003)(6512007)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hRSk61Y9NJ+IdJV3RS4cz3ND/OZXvuM1MBd3g3hpM419JSE0aEP8h8bt3GH3?=
 =?us-ascii?Q?4q9wv421tvladVZ/P6SwixFSFpKYL1kVxj3X1cj82cN7el9Dbe/qmZhUXyzh?=
 =?us-ascii?Q?ntINEEUkPaxpv7Ig1GWn/pFwZoKc3f6eIWw6OF7II37Z4oruqU1+Kc1GhXq3?=
 =?us-ascii?Q?ZUGf609a46WITI4N9Gec5+7pVIiO0EcnSDu/YzsGmC+ScVOGoX+qt4fmOpiG?=
 =?us-ascii?Q?T06w5xtQo5067lECV3pB+VFlHaqL+ESZFXlNr013rOYj9vv4URg+tkSargNn?=
 =?us-ascii?Q?2S+S2CIdJh5//kbDPulbl8T6LzWQc5tp7KVh1ZnyanNv2AkcmWp986yHU/pR?=
 =?us-ascii?Q?SfC25z+1y07q8Y8l4FvqZoJNwrHrzLeER/90egeTvWJ/jeYY0B/9I8OrpptF?=
 =?us-ascii?Q?MCO6TAAyaR/2asL6H4BmR0WWWESqj/G5k1OlclHDII7264XPHBCWjMjcvesh?=
 =?us-ascii?Q?uXC2C7CIRo9kdQ0I77Ks4pKcTBLpGvaPmKamSoF6WuNSOnC2QT+NvnjSEWF1?=
 =?us-ascii?Q?jnsOU4kPxy60UYmRseWepd+ulo6H7S9Lr6d3dFi1OcCYbVcZKWmHNBJxIYSg?=
 =?us-ascii?Q?xJGdw4mufFvFKlMvMzrTsf5KOpYVM+rIXEbtREoHTra0efiyhZjjKt0NflLH?=
 =?us-ascii?Q?cU1erD9/gAWUjTK2wKRlPr5IhNdqT6uXTjlzT7jwTHHZgvLT8JXoVVgGnSWq?=
 =?us-ascii?Q?cEZWH2WyOgvVxalBkD4+UN67tKkryOv873FxfaGqjj9FyZJr2YK/TucVJmcR?=
 =?us-ascii?Q?k+SAVDqAUjG0eJhEHR/wPvIMIe8cW2bxNstmOC+BNsbaB4aB4nv5IPiX+ROO?=
 =?us-ascii?Q?2Sm4aRcgkmvBC8pKykRMjJCVlmf5MNS/jVvGhPpuprp89n5PI242qy+bIJ2n?=
 =?us-ascii?Q?QoWsrr5VL1Yw/dE66HH7Hkj/pHmyUaW7ScE17Am6bLLx4jZLmljIb3/+3fid?=
 =?us-ascii?Q?wsoGQz8Px4h8qwq+VRXaVdCLykzRfnWHKv4IglthP3AqJO7tPYMiN+ZK1o0r?=
 =?us-ascii?Q?T7YDcvd0x91pD/UQEO/remxbV/Bf0y1x88g+Da0CThU4fc9h7HlVPwaB5z4Z?=
 =?us-ascii?Q?tyS57lC2H2Pr3mLED26Dbu0ibtObFQWjFxpHvaJ50jKE2Nu99qVa4XTj/s+Q?=
 =?us-ascii?Q?wojct8QRTbBjgxmCVA0amm8BeTB4plRyJvZvUVmBH9DcMSptAdw3y844fHrf?=
 =?us-ascii?Q?CZ9I13dZ31gdp0u0mwuecHjQSYGCUYfbCmVMhJBwZG+KlMV2jPSfrvoa5cD5?=
 =?us-ascii?Q?xXRxZYWRlG2wZhkrGC3iDKRx7084z9XYfYpP6PB/TN+ypPMGMFpX3HRy3YtR?=
 =?us-ascii?Q?qyaYmkHzqM+oO3RPa1VVTORflmvHFKgUgdMZNVyldD+4uS2xU2K5pfSqKoLP?=
 =?us-ascii?Q?y3Ee2JK3N5yTWdNZw+OWHBmHIKpohbXCpi/PTNIVGnR5y84oVJ+ZzWjmtir/?=
 =?us-ascii?Q?YFnsQ0nvRp4HatVxDatAPdAwEdOfYeR7aKGTm5U1Et2e/UVa7y2szYcpQZ75?=
 =?us-ascii?Q?36Q9zqYDOY83N3LwazRpHxejAooPi3/bcmKOwsH2rLICTKW2kQYwmFBUby0Z?=
 =?us-ascii?Q?TDVz62LQOALL2oZRxB4r4/KafgiGBAOVsN1wbqRsB8lE/ilix6RrdlJ2MB37?=
 =?us-ascii?Q?F6/Z5jsGPkmSbIoqcFFd1okZYJabexMCzCHBr3NUoSnCyvCKuy4ZnfxX3yeV?=
 =?us-ascii?Q?gZxK16Q8/AEqjGhUJ5kL9UPgTGu7xCB1t3njidLqag1rbHTYkKl/ik9fsla1?=
 =?us-ascii?Q?7WwPXUWuAw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9967e30f-0404-416f-ec89-08da2266131e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 00:38:23.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqIBhIIAZrNb0ob8kglNbFg31lUCvAIFG03R/39Xbada9vbemMSSwiEvQmQNCUkZPur32LiHUHckMcqYwt+TPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2887
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/4/19 15:53, Alistair Popple wrote:
>> Also in madvise_free_pte_range() you could just remove the swap entry as it's no
>> longer needed.
>>
>
> This swap entry will be removed in madvise_dontneed_single_vma().
> And in madvise_free_pte_range(), we may need to keep it as same as
> hwpoison entry. Or am I supposed to remove it even if hwpoison entry
> is reused later?

Why would we need to keep it for MADV_FREE though? It only works on private
anonymous memory, and once the MADV_FREE operation has succeeded callers can
expect they might get zero-fill pages if accessing the memory again. Therefore
it should be safe to delete the entry. I think that applies equally to a
hwpoison entry too - there's no reason to kill the process if it has called
MADV_FREE on the range.

>
> Thanks!
>
>> Alistair Popple <apopple@nvidia.com> writes:
>>
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
> ...

--=-=-=--
