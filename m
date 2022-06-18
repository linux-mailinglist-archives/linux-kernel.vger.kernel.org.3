Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D095504E3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbiFRMvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 08:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiFRMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 08:49:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0E1D1;
        Sat, 18 Jun 2022 05:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655556570; x=1687092570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X//rjU0bPqqCXeIrwJmlRZuZNmvrqvtVrNmYTdTWvvo=;
  b=NnZpYFdQm79/ZPwgqOjFFu3ngv5tv+qfofPI1UZgOV/Nny6D2SLvckgt
   PxzkrpD5jwTEPtq1sCN8A962ZHKJBBFui1au0fBm4NiTuy/hZl8aKh1OD
   PPEoX+cmOogWTMWKJ5HOftIKXBAFkNwGt2xcgkGcYY52eJlAQMOymJ/BG
   V1YHXl8LmCfRzlvg1lp6MgdCN0JKaVNGjv85b0rGwCXPU69GeBW5DwrlK
   tQyBl0wlBN08BhGlwj5JXNBu3RwIw4G/F0aCKL/piwgWyuqac8pGuQuGE
   fw8JgQwhaEyASTSn9ye33wR1kR1fXueMRcyuGn3dNQlWkZu9C0cT4n40p
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259475543"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259475543"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 05:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584337317"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 18 Jun 2022 05:49:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 18 Jun 2022 05:49:29 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 18 Jun 2022 05:49:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 18 Jun 2022 05:49:29 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 18 Jun 2022 05:49:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fi9WUsVVNuKfsd99ZAx103oPlZyBKji9rOrYoYsLRgyXTD5XCVUyukYu44q4xJaNdQauvaWp3Tz3W56aZQzaUHtuLdTJICqCHeFAqhzntz1vsyFC4BTxtJ32N9Dh0aGkHUK2S93NC/y0kP4TXNLZg8Iww8Tq7jTr1AyczheTWmLm8o0A9Ov/fpkdhNMgWCWAYUPPLxakQGD8BP5gKi7wMkqXAtZMU1uKw5/0/yc6cY0VzdbKHuFv3C7x/TtrMGKkWAY2xEol0EBefApSgfpxg8Lk3DKCuvIKM2klpVYWjhkBKWUJqkBWF1e9DLqusKLXqrAvFv1CYVzHtzFqLGXRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQbKI0u2iSvzNHt94aaofEoka9j5K3mTv5HMJPYDmaY=;
 b=QAdlSGWshQTTgzct/qDf+B8W6E7wsVd1hDKW4lZ0LLimuJgxmP0Rftiz8wlwJzSonZdThD7N7DLDiLcbcpVvhopR1KacPRMeBaNDA9LiGcQvzV51ls/wSMlTWzhifVpB1Dc8DA3//aCLnd4Is+CCLBsM5XuxOkJY4AlVWK6WeJCAIQei4SMVAzfakJV6XXEj0unPopIEcxRxqgbWOEIZG7FkmCNsTs6iufIAQxiw9Joj+Rc3VN5NSrwiQfntPWKd6Ja0Zk8LKXPdDlxZLeWhI4FIw9BBzF/7VmG4M/DjX662J3gcX3yPzlizy+E+FIxnilXNFzpqqPDhZDGNb/saEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Sat, 18 Jun 2022 12:49:27 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%5]) with mapi id 15.20.5353.015; Sat, 18 Jun 2022
 12:49:26 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu/nocb: Correct output rcuog/rcuop kthreads
 information
Thread-Topic: [PATCH v2] rcu/nocb: Correct output rcuog/rcuop kthreads
 information
Thread-Index: AQHYgnARx6MR9KNEikiHRs0ziSVaN61UlrqAgACHj+A=
Date:   Sat, 18 Jun 2022 12:49:26 +0000
Message-ID: <PH0PR11MB5880581A04571E129A07CA7BDAAE9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220617141519.1677119-1-qiang1.zhang@intel.com>
 <20220618044223.GK1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220618044223.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 875503eb-3682-407f-23ef-08da5128fa2f
x-ms-traffictypediagnostic: DS0PR11MB6374:EE_
x-microsoft-antispam-prvs: <DS0PR11MB6374210C05395EF39A5C1CAEDAAE9@DS0PR11MB6374.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uc3UlJFsM8Cm6vJmJVFEbPCdyvPEdXUloWaX+9H6qa1/kgf+Dch3HBiooS1JrZirMTTo10qD7pDPcohprWvnkLgIJERXCRYfaf2nU3g0qx/En0jivCfYOX29VsZG7zAjkZCvugmlo6+5ppyc8xNlNtR2QXShf75rF5FLU7mogiNV9hEourpgoGLVnlt/6b3zhwsxus5b75EUwci1x1vjvbuJKhqGNBVZuSAdWgJ7PCWOFPuqo/GJAdD+Nc5pRazKYNC0tTu9oFp3REnEUFU0mnsQZYSi3iKajyk1NzuGMocLqMDIfq3SpRffGKZ8y5zWrrLFNCZtkJh/AvQSI4xJ0v+FF9fT3rsgKwZ1QNOIrvhT4XriBrVwl3009QogZP5jCDb1nCRYS6V2RrQLx3goU/oRWf/tgGRkvois4oI2ls6J7x/HWBdzqtQkLGpSH18GJbIR+WespTEllpH/gj7vQaFMc9vIz5FsVJwDnrb4RYij209j4xanu7601I3cJj83BQRhFSeFYp2STr2JZeDr5N2CbLKLBYoMT5b3wBJLRlUojStx8SbeKbgx2dihudebZqqNXKI+mWUWN8Qv1h9LxeFxFIyOxnRYAKi2o9i3aDKVMXyyCM/x0gm6qvGZZLr0b2axjtrGuQq1/SoMfgd4C3KLLcLLycrE8U8DdNq2NV/ZpsQySIr7HRN0v8OoCCnXCNA1cNqIgZnZ3wdYnTD9yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8936002)(82960400001)(5660300002)(66476007)(38070700005)(4326008)(8676002)(66446008)(66556008)(64756008)(66946007)(316002)(86362001)(6506007)(7696005)(52536014)(54906003)(71200400001)(122000001)(6916009)(76116006)(498600001)(2906002)(55016003)(83380400001)(33656002)(9686003)(186003)(26005)(38100700002)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7IsS1RiGT3n+K3gBwTEZW4NwEmGjjhWyG8Mn3wWfdf7a9ibbwLN8j6QT5AqB?=
 =?us-ascii?Q?Qxt5BnPjIOcfc74tc4rMVmZE6u5YdrQ69R5jMsPxUUWFigSgLIdYYqd9z9bR?=
 =?us-ascii?Q?CYBtDKsrvJnrCZVxjjUr0aru96oCF8w/KkDbwNPGG63UNgrxhbTG8Uk4CojY?=
 =?us-ascii?Q?bn/Yv0ArfvCvSEWmnVW4FuGS1MjX7FwOr/bhKpPito15BrKT7ctODnzo6d6W?=
 =?us-ascii?Q?7v4U2XSKIeT/VREmd7hDq+AWiDnrYTQxZgtOse6TffnAbcoHC/1L0sxADzTP?=
 =?us-ascii?Q?5S0A5z0w+M74PBBRxEQPDx5t2OhDsu/+JUtkBvJHN+YYTJxiT4x1AEmOuAVS?=
 =?us-ascii?Q?V4+rCpIK2CDxwklVdTD3w7xJ6qFO6Tq3ZUOPmpPeeqVG2M19RVB2cBY2FeW3?=
 =?us-ascii?Q?2RP0n7mZhNgaQsPqNwbCIdw69ACeCSHk6hRqM4RnYsPsZLuxd+ntSap7gnNA?=
 =?us-ascii?Q?4kpjIEw/zgdZ1z5BZwA2/TNrrlcIIy5Wmn62i6vRvVE6EUwZcnip3VEfS5Mr?=
 =?us-ascii?Q?N1R5rPXSq1Ep3qyPzOHR1nDUfSzg1C8ThVGW53o1j/ML8WsIVxQt62sLUjdr?=
 =?us-ascii?Q?oddf20YDItV+TqTiCDynI4uE9GH+6zsVkwUZBcuHc4oF0wK4xPA1Npt2JqM0?=
 =?us-ascii?Q?n2uQoctqGtGb3cMKNnEQDdQSs9BG29y1y/gtKj48P80NJV0L0hgwmgzPyG3X?=
 =?us-ascii?Q?SAsKmom2AubT82wALNnFTy0fwQA1hh7LnU4GB9+JSY9vDubb3dE4Ezp6mISH?=
 =?us-ascii?Q?2CN8lH9wIeos9NTm3hilvKLLXRoDtQqhjl6Mvc90NOopnvEAZA9aSgg7wG56?=
 =?us-ascii?Q?U4+piSzrMg08B0xhysIh+Ag+Y+CuiDDuOCC2DW8PjJcy3CgEkK5p0mrQf/Bq?=
 =?us-ascii?Q?ub1XHLWm10NZD4zfrE7DAAvTuJNDclwcoG666yCaB+B8mtxVPqyV+zpCjHb6?=
 =?us-ascii?Q?6nta4uIZULJQnMS1fmT++J32OuoME+smNiHWtStmdAK9ZZUmqLhypEaNeL2j?=
 =?us-ascii?Q?kMAOsulkX1e9dgpjyZx4wQYwNR1IY6X5G6jbn5YiRr+/cj29gWaPKwBB/FIa?=
 =?us-ascii?Q?mixMwCHJlmH28zXPNbyZObKlkzcK1TIe0KqflTQMcq6mt+jxE2CRf6AZLxBz?=
 =?us-ascii?Q?4b0FET6Y+4a+z6L+zYvh291CTs+y/r6DAoKYl8eUuKuCKkiCMAKQvq1+O5UD?=
 =?us-ascii?Q?SHHFErq3MLxPUTsxbWV/Vtl4q55G5VbyLi4YtwmCsE4Y5pSDGtxeA376f4N+?=
 =?us-ascii?Q?rLpTpS76vs30VWoKjYfsjWvDMsDFs46e5qjzkMWGHVtWVaA1oJODVlnQoaiH?=
 =?us-ascii?Q?tNdNmc2MXwL4i3RI7iBY0HBKPwYs1w5qfBRym735qUJvuwl0IiALbz3l9+W/?=
 =?us-ascii?Q?gKTIT2kwK9Vn3jvuInUTRzhs65qfVU85CB+frg/cZZPIru+dT5NXS10WNxsP?=
 =?us-ascii?Q?FyZ6DPdDCtGIKuiOX4fJg5UI8/fYKuo93c1DqWB6JL8I10tnu69vjbclW+ez?=
 =?us-ascii?Q?ok1dopnFOCSRFdhMZQcOJDIYvJ0zpgI8gGgckL2I8eKNc125HLpqG7g1CvUP?=
 =?us-ascii?Q?NP/5K+Of2Rj7fCWHkBZyLU8nq9jM55zZSoA7Ycn/3gyJq7l6XDHMw+5Bchj7?=
 =?us-ascii?Q?SZE9aB4Y6g3hOvyU7ULlXmWxf6ApAWxFziZMD7ibivQBFxiIxA58/SkydplG?=
 =?us-ascii?Q?Za9mX9hGfD5I+RkJgl2g94S+bKaoUy03ssysBYVSXnWUS8y/BgbZIBgAxXZh?=
 =?us-ascii?Q?vIUZtaLk4g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875503eb-3682-407f-23ef-08da5128fa2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2022 12:49:26.3657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYVb1v3+uOFsnZZI/bVeQS3gB3MJwM6gIs7cm+MiIFhgAlzoZ0OSpKaqdBWPgAdwOjNKtosTz9X/muO565Ei4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 10:15:19PM +0800, Zqiang wrote:
> This commit make rcuog and rcuop thread information output in the=20
> correct location.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Good catch, queued for review and testing, thank you!
>
>Ditto for the "rcu: Avoid reporting strict QSes from NMI context"
>patch.

Hi Paul, please remove this patch, the preempt_count() imply in_nmi()

Thanks
Zqiang

>
>As always, I wordsmithed both commit logs, so please check to see if I mes=
sed something up.
>
>						Thanx, Paul
>
> ---
>  v1->v2:
>  Only change commit information, the v1 is  [PATCH] rcu: Fix incorrect=20
> judgment condition in show_rcu_nocb_state().
>=20
>  kernel/rcu/tree_nocb.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index=20
> a8f574d8850d..f20aec4f4394 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1452,8 +1452,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data =
*rdp)
>  		(long)rdp->nocb_gp_seq,
>  		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
>  		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
> -		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
> -		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
> +		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
> +		show_rcu_should_be_on_cpu(rdp->nocb_gp_kthread));
>  }
> =20
>  /* Dump out nocb kthread state for the specified rcu_data structure.=20
> */ @@ -1497,7 +1497,7 @@ static void show_rcu_nocb_state(struct rcu_data =
*rdp)
>  		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
>  		rcu_segcblist_n_cbs(&rdp->cblist),
>  		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
> -		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
> +		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
>  		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
> =20
>  	/* It is OK for GP kthreads to have GP state. */
> --
> 2.25.1
>=20
