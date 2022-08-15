Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812A3592915
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiHOFfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHOFfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:35:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEB42BC7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 22:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhTOfpYo7TxFOEr1h0K+Q140NZ6PIj/BUQ6/4JscPDleT/3HXBlV9lFX9K1X1RjIK/SCS/kyfglDYVUWtAt0+fcDEL7ih6mZ89sDWCQsIqRdEIRhb5st1+ze4A2dCYqr61u127xTRiTwBdpEbvhiofhCRXHueoplKSQN2nV1Xtc/eR8CNXwh+mo+JGhm9hxxA71qEoYiZcXJzsZPBCOaRmQvcqil8QZgEsIkpiGgcIt1G/ZQ49Ff5MZtIQkRzWJQLGTQbHXZdtXQ0xplDSKP+akK6BDjYPXRfCNrN0eWd8CPp4vVgGq+jt2/TLoVbGr8VLfY2Vw8DOOq4gmaqMZYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXe0mqblUJleAg3oEe5aDQYvJv/v+IM2MsA7rqTzNU8=;
 b=fXp+B/yjO8pygxel3ba33xQzpdxeGWlPvXSbcNA3nodNSuuExLzOpo2lB0Inc6ck9TaddLvgKo3jf9rjsGz4o9iJeBIOCJI72UIxb3ayUZ9YjKRxTStjXiHnI3z3Gf7XRoIMFfsfQLoL4jZbnwDhZ+Nbi/4zktyl/Jxg+B7oDK9LQi5tO79/pcXUPFJx2NwAI51a4FP0nL9zkCOqrYePVbOu394/8lAQTMBCdoVENUEeQC6g9uPxOUkmRmjQ5L2ZPElvtWY91Qlg6/+wDTixxNu4IPwOQDNse4/7lb9V684q9aLRKUUpqfpv/jgPKFKabwBB9BjSn4oyn8ZONavx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXe0mqblUJleAg3oEe5aDQYvJv/v+IM2MsA7rqTzNU8=;
 b=gx4A24ggyHinf01DIUJ2nbvzlJzh+0ydzhKxu8p2lmFdoFaBTs7JyQbhR7lwXjapY7dhlFhZp1gJug09el3x2+f9mpYD36nDvoPEUV3Vi8JohJ5m17mpcSDO94F3bVf4JbkL2rU6tVqz5gmrwLXaVXQLB8u/IxihvGAPB3pne+tKO+vK+OYnccPmu0HLYQhHqmRNZIGoRf/nr6Dd3m1VhlJjWQ1OfRfdw0amXz1EQkk9cLlj+GmzCgW432mzTPnKrrYe86Gp2aJuzAbCbzKolMGNDsEELwcHFZVOCxoqVeLsAru40CNc2I/o9Ri6y2gISgzVOoEtsLo4om0+neIRJg==
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by SN6PR12MB5696.namprd12.prod.outlook.com (2603:10b6:805:e9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 05:35:27 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::23) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Mon, 15 Aug 2022 05:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Mon, 15 Aug 2022 05:35:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 15 Aug
 2022 05:35:26 +0000
Received: from nvdebian.localnet (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 14 Aug
 2022 22:35:23 -0700
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
Date:   Mon, 15 Aug 2022 15:35:20 +1000
Message-ID: <4639789.K93oBFmSNS@nvdebian>
In-Reply-To: <BYAPR11MB349505CD7A028D8132DB40B3F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com> <8348741.Rxym6mXZyZ@nvdebian> <BYAPR11MB349505CD7A028D8132DB40B3F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ebeaa66-cfc7-4954-b477-08da7e7ff529
X-MS-TrafficTypeDiagnostic: SN6PR12MB5696:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQGNHhENR93B0TxdON/l55lWoiP+272dbuMGoEp34s4/hzGQdSJoNFoJpJV94sHMF4Odl6x3GH+FWc4KYRQ7krQ0X4Z+C2MdZO029aceCGRx0ZM1GXmnNII2gs+hA6vazoEcyXsahTmnLFFeOnmXZMm3ZDtBF1ZkbVatYsf8t4yYQybeQfVhD+VcaLAjP8tpQAUo+YzeVFUibgz3Oxl90+DiNWd+wC0WxGXyv9gWmC8oBwbc18aMx39+e2BZEIK+buVGyJz67IKrON2Vxz+ht0at3VVyhcgnWBD/7IEoHCup2NVSlQKNIODNErvNh427kovDiB5LJhVLYt0UfbCZhwmFmOsQUCpGKhkjAwfce7AqcSNOHrBC3izVLpQxShtdo7d+zwA5MuX2g7QfiS6mKLatI7YCMKPVl6oq3xozCFH+dTMkVdGrQ8ijKKWLAv1o/YfvSXKBXDNHkDSLWNEXpw1jsCzo7cjhakK4J4wL6Df+snhMUCpIi59XovIODvFT+8Lk/qMFQZksglfZfauaD66LxITGqMdn/UPC4/6t+7R5lvKK5kfG5CVLfgfYO+3WYJHgTEgBpPXdU1Xglt47Ovf10+fohxTqKiPhqzPyY478alYyPc4SkB7D7l6ufkNvfPQBHC/lRhDO53OP8fm4P9UVXlU7hVFwFcLl/Y3wAbSz98eTHQC1U6xs+FqD8xx9dsBfSxgk96o+CsOR/xWC9ooL1gU0G+x07mMCkQxaJznc0DMsuXVQeXebwpwgcqNlfywWXdre8r54ErZG50HWWmhAprRgjdi0L1NMyBqPIUKVWq0x0z6I+iDi3NQ5FwQHctoJIjKTeyKDQiLoHhoCKx3jOXwc9UPUZRlabU4Vxji353HOjD+ItVSnClvjgNXYrzLTaI2EphkhPtwW9n0hJQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(70206006)(70586007)(2906002)(8676002)(4326008)(41300700001)(54906003)(316002)(86362001)(110136005)(478600001)(40460700003)(5660300002)(83380400001)(9576002)(8936002)(82740400003)(36860700001)(33716001)(82310400005)(26005)(81166007)(40480700001)(356005)(9686003)(53546011)(16526019)(47076005)(186003)(336012)(426003)(39026012)(14583001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 05:35:26.4506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebeaa66-cfc7-4954-b477-08da7e7ff529
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB5696
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 15 August 2022 3:20:28 PM AEST Wang, Haiyue wrote:
> > -----Original Message-----
> > From: Alistair Popple <apopple@nvidia.com>
> > Sent: Monday, August 15, 2022 13:17
> > To: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Wang, Haiyue 
<haiyue.wang@intel.com>
> > Cc: akpm@linux-foundation.org; david@redhat.com; linmiaohe@huawei.com; 
Huang, Ying
> > <ying.huang@intel.com>; songmuchun@bytedance.com; 
naoya.horiguchi@linux.dev; alex.sierra@amd.com
> > Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on 
following huge page
> > 
> > On Monday, 15 August 2022 2:40:48 PM AEST Wang, Haiyue wrote:
> > > > -----Original Message-----
> > > > From: Alistair Popple <apopple@nvidia.com>
> > > > Sent: Monday, August 15, 2022 12:29
> > > > To: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Wang, Haiyue
> > <haiyue.wang@intel.com>
> > > > Cc: akpm@linux-foundation.org; david@redhat.com; linmiaohe@huawei.com;
> > Huang, Ying
> > > > <ying.huang@intel.com>; songmuchun@bytedance.com;
> > naoya.horiguchi@linux.dev; alex.sierra@amd.com; Wang,
> > > > Haiyue <haiyue.wang@intel.com>
> > > > Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on
> > following huge page
> > > >
> > > > On Monday, 15 August 2022 11:59:08 AM AEST Haiyue Wang wrote:
> > > > > Not all huge page APIs support FOLL_GET option, so the 
__NR_move_pages
> > > > > will fail to get the page node information for huge page.
> > > >
> > > > I think you should be explicit in the commit message about which 
functions
> > do
> > > > not support FOLL_GET as it's not obvious what support needs to be 
added
> > before
> > > > this fix can be reverted.
> > >
> > > Yes, make sense, will add them in new patch.
> > 
> > Actually while you're at it I think it would be good to include a 
description
> > of the impact of this failure in the commit message. Ie. You're answer to:
> > 
> > > What are the user-visible runtime effects of this bug?
> > 
> > As it documents what should be tested if this fix does actually ever get
> > reverted.
> 
> An short example *.c code to capture the bug in commit message ?

That's probably overkill. Just being a bit more explicit about the 
circumstances in which sys_move_pages() actually fails would be good. Eg. 
something like this:

"Without this sys_move_pages() will return -ENOENT for 1GB huge page
memory map when dumping the page node information for nodes != NULL"

> > 
> > > >
> > > > Thanks.
> > > >
> > > >  - Alistair
> > > >
> > > > > This is an temporary solution to mitigate the racing fix.
> > > > >
> > > > > After supporting follow huge page by FOLL_GET is done, this fix can 
be
> > > > > reverted safely.
> > > > >
> > > > > Fixes: 4cd614841c06 ("mm: migration: fix possible 
do_pages_stat_array
> > racing
> > > > with memory offline")
> > > > > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > > > > ---
> > > > >  mm/migrate.c | 10 ++++++++--
> > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > > > index 6a1597c92261..581dfaad9257 100644
> > > > > --- a/mm/migrate.c
> > > > > +++ b/mm/migrate.c
> > > > > @@ -1848,6 +1848,7 @@ static void do_pages_stat_array(struct 
mm_struct
> > *mm,
> > > > unsigned long nr_pages,
> > > > >
> > > > >  	for (i = 0; i < nr_pages; i++) {
> > > > >  		unsigned long addr = (unsigned long)(*pages);
> > > > > +		unsigned int foll_flags = FOLL_DUMP;
> > > > >  		struct vm_area_struct *vma;
> > > > >  		struct page *page;
> > > > >  		int err = -EFAULT;
> > > > > @@ -1856,8 +1857,12 @@ static void do_pages_stat_array(struct 
mm_struct
> > *mm,
> > > > unsigned long nr_pages,
> > > > >  		if (!vma)
> > > > >  			goto set_status;
> > > > >
> > > > > +		/* Not all huge page follow APIs support 'FOLL_GET' 
*/
> > > > > +		if (!is_vm_hugetlb_page(vma))
> > > > > +			foll_flags |= FOLL_GET;
> > > > > +
> > > > >  		/* FOLL_DUMP to ignore special (like zero) pages */
> > > > > -		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> > > > > +		page = follow_page(vma, addr, foll_flags);
> > > > >
> > > > >  		err = PTR_ERR(page);
> > > > >  		if (IS_ERR(page))
> > > > > @@ -1865,7 +1870,8 @@ static void do_pages_stat_array(struct 
mm_struct
> > *mm,
> > > > unsigned long nr_pages,
> > > > >
> > > > >  		if (page && !is_zone_device_page(page)) {
> > > > >  			err = page_to_nid(page);
> > > > > -			put_page(page);
> > > > > +			if (foll_flags & FOLL_GET)
> > > > > +				put_page(page);
> > > > >  		} else {
> > > > >  			err = -ENOENT;
> > > > >  		}
> > > > >
> > > >
> > > >
> > > >
> > >
> > >
> > 
> > 
> > 
> 
> 




