Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9BF59290C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbiHOFRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiHOFRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:17:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5766D1573B
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 22:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Od8vfhHqn0znHUsDx4dwf5+k3+4Jqm9AqEsQoqiD+bNbHTCbuBJYr2AhGi4QjRdqlCeHcgOBc8JE2xRG6OXPQw+KPBo8/E2FGGtH3Ja85IIDDgz1/XgoD2mKBk/2GB0XwuO02yI5H8F6fhYjIzCdJ+AscS8mW4J+PMVLeBXEWfD3mqXIVzcYahAt0JXSVWYnbtImIGi81QBGHIDpg9H+WrOe7mB9TFSKRTrBMKbbLT4i7qjY8Q36+xpDFoZVohBOgpRqv/CzUEUJI1Gg7p/5yGWuqinDoBezoKZ1fhU4OLio/GuCTfbe5xDdoR8D9xGRHyQjEmpQ1mU5k5t8eneNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qAkVBnTIPQgKNVhlYqeH4MqY5N9P9NCUWi5F0uEqfY=;
 b=i5A9kw6cstNTiHmHn5PyafBKyhXMCkC9H+cFaDqUQrZFXUvB86OcGHBDUm/VZth7h18fBYJMif+qaFTUGZXhpUIt8RtzV5MyR+XkI4Fyo3d9Q8mb/h4SI/6Z9B2xQfLCGxEwemhMHxUe+L3qNhZKu4edoDX8Gnx4G94752HCFendUJD7hZ6x5zmXjmjtYZOQLwzQTIPWbWE1ySO5+wNAG9TUMeCAj6ndjfKTCOVkL2rV0gCaMTrusu6JN2dZPzegCBcwsJZo3l3kcEkfmIIX6Z8awpLb52ktjPE0XvbLgPNAAcjgG/KrUvHGpYJjj+68c+Lr7v5sJGTedMtjLxzYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qAkVBnTIPQgKNVhlYqeH4MqY5N9P9NCUWi5F0uEqfY=;
 b=tqoj+2v9FjVDAQJj1P2GwwjSXPNLJ8yiSM+wRfqGH1aNA1KHb0gqQ2U/HAk1CjntdI5EJYZc/MVD/0PYyvJ/sv0lcGuQDxea6nTh1FWJ0FRKa9eXaT86fbjKSvZkS3/7F2FP3lG3XU9ympHyDRD8Gt45JYLtFsolEA72XgCx3IQFT48I08pIHeVMGjpBL1HTLBoB4roZy5Okbmoa1oj9AKitoT+bZmwuYU4o1bHueAUnUeBNAq3GEbgIo2XQ+G+TdLHWfmgoZcOM4yYLJAkbNcuVCJEkZtETmiInJuMrlNGieCpxalbdxBYVXEJvFHEJFDwWmECU+29nzHnVHoy4NQ==
Received: from MW4PR03CA0208.namprd03.prod.outlook.com (2603:10b6:303:b8::33)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 05:17:00 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::9e) by MW4PR03CA0208.outlook.office365.com
 (2603:10b6:303:b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Mon, 15 Aug 2022 05:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 05:17:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 15 Aug
 2022 05:17:00 +0000
Received: from nvdebian.localnet (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 14 Aug
 2022 22:16:57 -0700
From:   Alistair Popple <apopple@nvidia.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Haiyue" <haiyue.wang@intel.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>
Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on following huge page
Date:   Mon, 15 Aug 2022 15:16:54 +1000
Message-ID: <8348741.Rxym6mXZyZ@nvdebian>
In-Reply-To: <BYAPR11MB34954E0692FAD9FFB66FD2E6F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com> <5767084.K44AtQxeQl@nvdebian> <BYAPR11MB34954E0692FAD9FFB66FD2E6F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a7f066c-8977-4ebc-40dc-08da7e7d61d9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5285:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgeIiRQOPD8SxZ6SPc625nP3k8dU+gebcSK4v9H34eTNrD2mWmzGRCWZyPVrYHeIPr5dbdYsai7B8olekllHsNfdlrNyxTsVIkX2nJXVDeip/FPWAOGPFnLqIl6d1PLXGW1QuB3UGuf2xUqJqORpaCzkBge7S33AP1Nv4NnrJdT78Y0DVKD9hYqLk6Kb/h1FbYkFmeNzh5Ozd/1hkjYR3nmDdz6e0bK8LZJtuRqTCUa+0ncFcPqiAd8KUj2QIdrodGlQPz4mjsBxCPGobGvts5tTmi4Cg6Vab4WVfiAm70ZhI1EQ06g6CGVQquRisbj/e4qMDSaKP99NIAge3+VCUupBzwtii1Togw3i+O4XiCuJypjX3nqCQkY+31TKAtINP3IARi/IjBg4f5A5/+kOD5k8TkH7MCcH31Ji98xB9SrwCTPDtzMIngX/7eNQrzAOhxxNLk61CdQ5dhzeYBnygsjIpNgxngot5qv5FMyFpts//1LQf9bu16KHzybfkZtwk9GcMY/rYUmqqKnPPgIyb7fgB59UIJgk3o1kc8kUA2MRRSRJ0btcUQvC+WM3g9BizhNy0KZETa1K51DRNCxP6cN9qRzyvrcG5rYh/xk6yZySW/dP0ujXpOryLlmmovY1TucEtEXmmF0QGbMPJPa9fcyIR5r3ue9YaIx74bIx5tLbK61U0dsJ8E1p1Wyoitw4nYVvmM+VMqrJlr5BZS+IEQ8KvKSFS1aQXA9MrITjW/jI6cQyxLfpcRcE5XLQNu4REIMyibY16n9K1pcOLENDrgYNbl9R6NjwOssEBdM/UNy0FSAeXzeHjPPkxWgAlcs9Qmglh7LR0ObE0k7Kp+fs06q2bRdoF7A+UECxCny+Ye1MHavZGOGP6w/3HOYIVLPEosrfoTCnMrUgA9q/St6MUA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(40470700004)(36840700001)(356005)(36860700001)(478600001)(5660300002)(86362001)(82740400003)(40480700001)(81166007)(2906002)(9576002)(8936002)(4326008)(8676002)(70586007)(70206006)(33716001)(54906003)(110136005)(316002)(16526019)(47076005)(26005)(41300700001)(40460700003)(426003)(186003)(336012)(83380400001)(82310400005)(9686003)(53546011)(6666004)(39026012)(14583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 05:17:00.3048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7f066c-8977-4ebc-40dc-08da7e7d61d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 15 August 2022 2:40:48 PM AEST Wang, Haiyue wrote:
> > -----Original Message-----
> > From: Alistair Popple <apopple@nvidia.com>
> > Sent: Monday, August 15, 2022 12:29
> > To: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Wang, Haiyue 
<haiyue.wang@intel.com>
> > Cc: akpm@linux-foundation.org; david@redhat.com; linmiaohe@huawei.com; 
Huang, Ying
> > <ying.huang@intel.com>; songmuchun@bytedance.com; 
naoya.horiguchi@linux.dev; alex.sierra@amd.com; Wang,
> > Haiyue <haiyue.wang@intel.com>
> > Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on 
following huge page
> > 
> > On Monday, 15 August 2022 11:59:08 AM AEST Haiyue Wang wrote:
> > > Not all huge page APIs support FOLL_GET option, so the __NR_move_pages
> > > will fail to get the page node information for huge page.
> > 
> > I think you should be explicit in the commit message about which functions 
do
> > not support FOLL_GET as it's not obvious what support needs to be added 
before
> > this fix can be reverted.
> 
> Yes, make sense, will add them in new patch.

Actually while you're at it I think it would be good to include a description 
of the impact of this failure in the commit message. Ie. You're answer to:

> What are the user-visible runtime effects of this bug?

As it documents what should be tested if this fix does actually ever get 
reverted.

> > 
> > Thanks.
> > 
> >  - Alistair
> > 
> > > This is an temporary solution to mitigate the racing fix.
> > >
> > > After supporting follow huge page by FOLL_GET is done, this fix can be
> > > reverted safely.
> > >
> > > Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array 
racing
> > with memory offline")
> > > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > > ---
> > >  mm/migrate.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index 6a1597c92261..581dfaad9257 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -1848,6 +1848,7 @@ static void do_pages_stat_array(struct mm_struct 
*mm,
> > unsigned long nr_pages,
> > >
> > >  	for (i = 0; i < nr_pages; i++) {
> > >  		unsigned long addr = (unsigned long)(*pages);
> > > +		unsigned int foll_flags = FOLL_DUMP;
> > >  		struct vm_area_struct *vma;
> > >  		struct page *page;
> > >  		int err = -EFAULT;
> > > @@ -1856,8 +1857,12 @@ static void do_pages_stat_array(struct mm_struct 
*mm,
> > unsigned long nr_pages,
> > >  		if (!vma)
> > >  			goto set_status;
> > >
> > > +		/* Not all huge page follow APIs support 'FOLL_GET' */
> > > +		if (!is_vm_hugetlb_page(vma))
> > > +			foll_flags |= FOLL_GET;
> > > +
> > >  		/* FOLL_DUMP to ignore special (like zero) pages */
> > > -		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> > > +		page = follow_page(vma, addr, foll_flags);
> > >
> > >  		err = PTR_ERR(page);
> > >  		if (IS_ERR(page))
> > > @@ -1865,7 +1870,8 @@ static void do_pages_stat_array(struct mm_struct 
*mm,
> > unsigned long nr_pages,
> > >
> > >  		if (page && !is_zone_device_page(page)) {
> > >  			err = page_to_nid(page);
> > > -			put_page(page);
> > > +			if (foll_flags & FOLL_GET)
> > > +				put_page(page);
> > >  		} else {
> > >  			err = -ENOENT;
> > >  		}
> > >
> > 
> > 
> > 
> 
> 




