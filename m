Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E6595ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiHPLx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHPLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:53:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC37F0BF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsbGqZAHTasnArzwjcUNql7eF57YHQNIilfqXoxOi1gDHK8Go0BbLY5+Kdz1HNSMdhzO7NDu475hRNgVSlvYiIk84kXJhx8MkmnCrr1eoH9H3YNzPBRPjdcxENGz/D1p8AV08iMzZOO2O10J9z7yB/vDGHEJ1MCT344BGmVN1Xx1fXvy7LAmvzpY9pvbHJPNcOlli1XdK9ZbyUIV+dWHeJjSTQtW1UjIlvU9UI8ppIxoknIgaawr/EHNuX6Qy9deY43pBUjBC9jQf/z+Ti0Zw9wHibq08z2sc0pve28+hAboHfkBJUrDcCqjAvsbTgGOhAMhkI9X2UMXeiXz/7JAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMWf5uZ91tcgBAY/M6iYgm3+p05u+rWzvg87+rig06k=;
 b=S8fz7QS4QmNWDy0pzAm6PJknJ2NlJZz3nUwbUMg56sdlo/crtsv0qVebaG1bDF4X3uos+2rNIV1j5VArvZeoXnLrk3ttwGFJYpGcwVijjMjIPQ//ye1UsA62cyWGqp30R32eCViEOMkmi8CNltLY0yg6sKIileWuWzbn/gom4v+VonMiq69GHuiVss9adOBrcCPwqjpdNTerYBTH85i8EyoPVTbXCV1zQP3U27CA5dOC3uVsD8nkoPGeR6UqrLENLEuTH1z6QivE/mFwZaN9kHuMMMSr6YIXRsq4YyWEBkryJ7Xm/OFXMaZGUmZ1023S7zRvWDF9G7zWJsVM2T+GaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMWf5uZ91tcgBAY/M6iYgm3+p05u+rWzvg87+rig06k=;
 b=cvS7GVZnPkmPzPZYqDruSZ4N9Rhg7dHPMbFG0eD08LbklvNOn0ghSkLTuKv2iCcDwTLOrKoshRZKC8FpkNCsha4hLhrqelAL8xcpCSFZyDNrPzCcQqOeQqpR8n6xK8UR/Ce6N2hsCmjEScm8MiXTjzScz/zQmLSq1JgPEbSivaanU6PxSN45DyoUJEh0+rCX/L4pvaEt7JwakFv4zcdgNcgK7JeJzSV9vNo2oGqA0FX5JU0xguWNtcN2Y7wiRLHPbmsl8Y0vRBLUAC8Kyzsmzb19gjLTwmd5gC5NIlMRc+SWhqAtpaf8uQADLyQ0BVw5OR4uGtgM6czQtGGHKrAXtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB2973.namprd12.prod.outlook.com (2603:10b6:208:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 11:29:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 11:29:10 +0000
Date:   Tue, 16 Aug 2022 08:29:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Message-ID: <Yvt/hZYfSvlCbU02@nvidia.com>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <6b61e9bf7c65f78524db32ba3e65a7eb6b8a76a0.1660269441.git-series.apopple@nvidia.com>
 <YvpxOyrDBUHagpC6@nvidia.com>
 <87edxgvixy.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edxgvixy.fsf@nvdebian.thelocal>
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96dd0f50-8272-4be7-c87c-08da7f7a8a26
X-MS-TrafficTypeDiagnostic: MN2PR12MB2973:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSHnWE/+59ny7wcLP2bgzqqdXny8rK3o9alRTszgd00sJ18BBWlKPDweyK6kVkJi2/ZanZDS5ogAnesBoPv2NXgDOBZZMa1JsHWIybKvVWl5/O0MvRqiXGfkHbbpuW80HDhgeq0lgewUs/rN30Q0PGFwLHaAr5oYUMu05gAOQ8FA6r3lPGZlpA3wz0Mmcrw708VAEKpZh+qEN4WnAV0Cms5WI995mFXrNM+p55/9nKx+O0EMLcIvOkC7xfnY7dfP2PcwdMwFV8wlrHsjPm0WV60N9GP7zZIyMP2cNq7pR50kgm9tSsPgwNSnKr5PRVdAZLSJJyEpsptSm8sCpmk9EsnWDFnfxEPPT6m3+o//asW43kKa5CZ53r3wdx8M15C3TnT4TAqRfzDAJQXGcY+lG1kgG0rUCbMQhcVZ/AvamF73itmwmGH6FOs5wmB2GrpOwAo2WqCEDW8hiWi/MxsH3nVcFMqKTLZ+b0v/GDYtfPoqMDJdiekpQxJJMbwKswhGKGqCRfd4NVU9bZ9E8wvdTTzUosXY9CQohpIUt9BYYbKFE4YQrJJjB99so8SYzM8B/LeksZrjlpyRoCKgT3KpJlquVY7iFq/FIajcuiY1KFcyUoGqLf4sud99wfWArjSW8JzeHMnhZ0ozucLOzvDLGGLVzDUIY/Zx62xQZ08+aoieIGUxXV1+0BBcLXgTVMYhjWJuE2/TcMLR2tOkhNlkl934tfPh/O3uIGVXjx8+tBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6512007)(478600001)(36756003)(86362001)(41300700001)(2616005)(6506007)(6486002)(186003)(83380400001)(26005)(66946007)(6636002)(5660300002)(8676002)(4326008)(66556008)(37006003)(66476007)(38100700002)(54906003)(8936002)(7416002)(6862004)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXOX9HB/q9iyMzom5OzoceyrAbldMTFxf8rQL4gQ1TlS+gpPpzOyzFWOIQGq?=
 =?us-ascii?Q?6VWKt64KHBrZYyYme7LJTTdzBIs8OXclrOg2QJ0/gwlsHnaPzSItiILaiyuF?=
 =?us-ascii?Q?X2Em/giVuuwmrSIM67iIhMMG7sPfJSY2Cv2/XeHVn0vSSJ7inD5PhCaci8iv?=
 =?us-ascii?Q?NoUSNM4lkPiUJ/AcmQaSFsKN3XF+ozReGU5AG86jTI2TQ66WNcCT97H3bk6n?=
 =?us-ascii?Q?jOK6rRVKpokzi5yNcDGXWPh+wykJsgKfmD/6Azb+Yrqty85RJ4OLueYMIsus?=
 =?us-ascii?Q?NYvtlJ5bIqFT0JcIUs9kX4Fvp2nK5jhzeiCENOAOl3VedBgxwOl8+DBFGIPW?=
 =?us-ascii?Q?UFVgUsaEJz5dKMWacPHznnoaBIf6Zho/xs5njP9BsC5hRAc6LKIBrBBH5jlD?=
 =?us-ascii?Q?4lM3IpGNOxtCVBcSyNJjxFKRk0GRzu6qCWoTwbVDth+u87oSgjli4zfoEwTF?=
 =?us-ascii?Q?KLNlKM125l97Njm7yIH9ZpgzlJXFqL+0XeCKUQuGHMEss0xBQq/3GfBjvZDe?=
 =?us-ascii?Q?Jc5vWJhs3r3yRZVnfrhAu7oenvUAhIfujVovc+OP98DjFj1eJyCbp1znTGSc?=
 =?us-ascii?Q?0cb8j7kEYpQhhS+HF3FvV61jAgSvggxgo8aD9dXc2GjOXHnmxlQOchCPAdEB?=
 =?us-ascii?Q?Hy514kifFs89hNtyrJKv/UQV8O80q9uEcHF8ijrKI8ir/7XBpU7TLx/m1URP?=
 =?us-ascii?Q?8xfEWR5iNT2E5k7UBBCMXuE7fZYQFq+Hq4Ah2uidra7ArQDLeH1EQ5ca0Al3?=
 =?us-ascii?Q?vlwWyjBzhoVX1Po7PRYVkI8UejuP+DLSac3qg2X3uL7fslDm+0V72kiQiVkG?=
 =?us-ascii?Q?rTljoRqwvYLQ4q5Ll4To9eh0hG/1Zj49jakM+ZlzN/5BtbpaQYc/L/3ubr96?=
 =?us-ascii?Q?AqzN0ts5Dv4pFlfrdhLhiwYC/gH43eiRADxeVZ/hmuS5JQX01NsPqpe4M/4L?=
 =?us-ascii?Q?8qvfLem4ZtoZvlicqtaOksF7mH6i7hX95cIsEvL6J2jyOgTEn9IfpxOx1Fwx?=
 =?us-ascii?Q?xNp/kDke5Yi28rY3gCl7TK6DyW702Mv8px/0UMzBE+7q/1NI30B8WhCcnGrE?=
 =?us-ascii?Q?xbAcAwxLCGRLylz+zmuprJY+OqmdGuJpqzZSA7p1qhsPCFrmLe2GU0WjT/et?=
 =?us-ascii?Q?OD5A7nGsl8e1hjTIH1HDYemXnwhmqx2l14B12mpqp8CXST+sXXeT6N1HrtBy?=
 =?us-ascii?Q?VDgsQqyBP32VE5omJqNRrI2u9Zl+x6EjWUuCulPx0pqvh83O+LdK56538Ivw?=
 =?us-ascii?Q?1t6PnkzH1IiMiLShNjNqMWCvqFXjB3V/as6vDyBJhnoRwHWiKx7ge4UO1kxl?=
 =?us-ascii?Q?2u2F+ktU9iSm1Ydfl4sis0MB/2nwhbAAPoRXLs34SWGnr3UdkwrhJDy+KUr1?=
 =?us-ascii?Q?50XssX253PvEkCXb/12vhZSiVH9CogQR2o1Shp/6aFlND2qbEY1bruXnvIL4?=
 =?us-ascii?Q?VcvqzJ6ZUliL2GiEPf2Wqjzfn///sNJpL0Kk725ia0Tdd/+BqgnWC7HVEx+D?=
 =?us-ascii?Q?oT8fvL+J6X7joCtqr9vuhk0m+ngg50GtCgm6LP7PIwJGEArPI1oKzHGd3EQr?=
 =?us-ascii?Q?Dsm6jRD4JFg5L+LhKCDDcfzDjH3tJCs0lVdzequA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dd0f50-8272-4be7-c87c-08da7f7a8a26
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 11:29:10.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNAF6YG3RF1/q5PU/Xnu6NOmyaVmQFCRjiQ60xXhsowB5VL2p5KmHSfVIpkBCbYZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:29:20PM +1000, Alistair Popple wrote:

> >> +static long check_and_migrate_movable_pages(unsigned long nr_pages,
> >> +					    struct page **pages)
> >> +{
> >> +	int ret;
> >> +	unsigned long collected;
> >> +	LIST_HEAD(movable_page_list);
> >> +
> >> +	collected = collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
> >> +	if (!collected)
> >> +		return 0;
> >> +
> >> +	ret = migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
> >> +	if (!ret)
> >> +		return -EAGAIN;
> >> +	else
> >> +		return ret;
> >
> > I would drop the else path and just return zero
> 
> Unless I've misunderstood you I don't think that's correct though.
> check_and_migrate_movable_pages() needs to return one of 3 conditions:
> 
>  - 0: All pages are in the correct zone and are still pinned (ie. "success").
>  - -EAGAIN: Some pages were migrated, all pages need re-pinning.
>  - errno: Migration failed, pins were dropped and PUP should fail.
> 
> John's suggested comment update spells this out more clearly.

But that is not what it does..

if (!ret) == if (ret != 0)
        return -EAGAIN
thus ret == 0
return ret == return 0

Jason
