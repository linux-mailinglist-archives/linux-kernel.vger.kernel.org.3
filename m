Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6077E59291E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 07:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiHOFiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 01:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHOFiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:38:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E787B13F30
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660541879; x=1692077879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1atO7w+MX/BNZAyGhF/SDIzuOpJy17oOqzNQ7HyzlsY=;
  b=kvXTQTeT2tcOMl6Y6pM+GLU8MgeUApsTsZzANFi8G5ti0bhwdkCY/Ea4
   QgWZme5hv2V2MJ9TRrd7fJfOE6zDrhEbgyDGylpyT/Rv9kcch1M8TG21S
   jxQYLeQFSDhocB/xKbV0t/fK/FlPY+Dgv0foC5SvzytZha+RHr7NxtoST
   cdZMIsQZDDy/HITQBsvt3slpZkODK9andtB8XNo4FNjo9+BQv1udR6d0s
   5Hz5CzEdAMdHaIUp3NvkX3OID8dTnQ3gJPkbuWhFcfyAPWWbuL1HU6kiU
   PhHbz2mSaHhyD6h551mYGuCj6D8kYR2gSZXo8Iu64uYBriPdAbnbgx78v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="317875899"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="317875899"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 22:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="635361554"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2022 22:37:58 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 22:37:58 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 22:37:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 22:37:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 22:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaBIbUwNJEDVW1vh9CzVlQByH67I7NYkcPRJ69EoRs+j4H3Zd9NFNACV1xmmMjXgYzR4aTS7nv6UrOrF95qDLbl4hseNKJyV5x/9GZPdt/kCMKG6PrNPxeE6IBTvWYUsqhJCD5cfiWE+7m2cHklHQ3boXaNDl7Rg0zQe7DSNW+wc6ilr6fPF0W27tqmt+5XMnA6tyKf7CB3CaAyLa10opuSxerXeKY7y9BS6bUzaqeCeCgyxo0+3VW84QdTmHUtXxjSJeGdoMcabSvXpZY8wB08cx8vqZnAv8KyRpF5pjs4eW1E/GUHFgdd9GKRB/oi/B0FJ6qy59wSCKSb1rswnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/j4eDpWae5hMJ1qkp+ZSZaCzpwgwMZ8ode0FMVTckY=;
 b=Y88v5kOAWHBtiwyOW3r9jn4b68CT8KGc0Z0g+Ewx/afKpfSTbxTMSHHmCxHnKBo7opjsP7wSfwqacbmrn0pBmV6ExKelU8KyO9NDvgWHYSYCc3wQs0hcPBcyofl0793CVik8Dq+YpAndwPpC+YD65V2PNFsVfaP1SBTGrksQ2OhpqvGxhnapQ91rkc4ULaGarJdSKr8WzHXk+kaX+oNXO+BjvABDI8H8BoipMVPyDGm1amVLZniW76TEwmyiDThBJeTCyrwXnFsnkMxzmnrGOmZpH2/IjIOr8IxS7xtAME+x7nLBFxxVOBiQGszdGuB5s1D1tWkFtExdWozlXqeR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by DM5PR1101MB2155.namprd11.prod.outlook.com (2603:10b6:4:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 05:37:55 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::6133:d318:f357:48d7%7]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 05:37:54 +0000
From:   "Wang, Haiyue" <haiyue.wang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>
Subject: RE: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Topic: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Thread-Index: AQHYsEqaehDxLZhp/0WpLois8QzWXq2vXnsAgAADE2CAAApTAIAAALnAgAAEbgCAAABUcA==
Date:   Mon, 15 Aug 2022 05:37:54 +0000
Message-ID: <BYAPR11MB34951AED33C858D1E6BFC391F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <8348741.Rxym6mXZyZ@nvdebian>
 <BYAPR11MB349505CD7A028D8132DB40B3F7689@BYAPR11MB3495.namprd11.prod.outlook.com>
 <4639789.K93oBFmSNS@nvdebian>
In-Reply-To: <4639789.K93oBFmSNS@nvdebian>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7188c41a-602c-42c4-3ed1-08da7e804d15
x-ms-traffictypediagnostic: DM5PR1101MB2155:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XlLgF8FXTdqwA5fxjeMOBb0UWlWHeAiLqvpeCxznbQyMfv7P2wZiibq+biGMIG5WY8VBUZgZhvXR3hBpS1Ycmt4ihjHStda1qLuN7Ree14dlA9Mo5fKz71Rn5e7I351IWgxAx7gk1+w9kL7wSOrn668EVTitT5zUtRJE4jb2OQJIxbzI3BiWehLxHXbBY/7VXFiHpKsbJ9/owuVF+23YikY0N9Dz1IMLlHhTgXch8tp7SjNOkexdymrNrgHNoqjOu6RLreZ0BDDvNTwWXaIIMqT3jepAA+MItWV2T7V2PNBD2gbKuCQv4lnHHE8dJlMCkMxSdO923unWLyCCtzwM3Sc04BH/4ioNfBoDnEPUUUkCazGgzaWikpjGyafh6jwNBr0WEZ1Qm5Xv1ko1uLbIVD3vgNpPI3DuowBJrJ8Xov1c6tspArRnvIWWi6Um0SOwjcmCzzy8znAcKj6uBZuMe1mMG37KkXR5B9NOIV+qoPZ3IxyqBNh856ZZ+OiIurs8ddRMQBHRJ8emONx8gMGTiW+WHPBp1/xZaEa/DcYggDxnZ1fjow6vHZHZd+PguX65aW6UfczWCbxZqulFzX40XkimofRmuJk2/7za3reZaUwGHMczFLlKUzXkgLzcgx8Qz3uPvHXfELqAOGKqTS16ntjHNe7ivdaC5swkgRknedeGXuJE2pnUWklaoX80wDlkuh2NerZ4NpFcfs7juP69TLWWLW4iJQIHF+OrULeYl678VO9d+HUl1fltNnkfKxpUmZ2wr7v/aTmbF7pZCUjLWZm69KSrDewPv6yxHOMdWnyYK3hhvXbOQ4AL2gVBDRmGXyzVNMSodz0hkQJMi6hhRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(366004)(396003)(39860400002)(82960400001)(38070700005)(83380400001)(86362001)(122000001)(38100700002)(66476007)(66446008)(64756008)(8676002)(76116006)(66946007)(4326008)(110136005)(66556008)(54906003)(52536014)(316002)(8936002)(2906002)(5660300002)(53546011)(7696005)(6506007)(9686003)(26005)(186003)(71200400001)(55016003)(41300700001)(478600001)(33656002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Co63wDykbJDnO4eObmIAryK4SyRcFppdCNx6Se2o844A68nIlYfS1hTp37sC?=
 =?us-ascii?Q?beIjBD3AwpRiEvY6LnCAY4R7Tdyl+BCBdjUgMScsVkQHNJtm87UZJsHoAi5h?=
 =?us-ascii?Q?RbPLhNZP6cDITWlBo0KWN7pKJZTc/bIQUkGI4GLBplyZCOZ5Hc73E7gi/afc?=
 =?us-ascii?Q?emkPUdrOFCzC27vCaRyopzZHHMITkMeGyJfrYWkGoHvJMsSuazTkMf1do80I?=
 =?us-ascii?Q?HG5wEqx8CNdBiJwIDi2N7mpH8aXI+1+xmEd6M+m9KYwBkb7WutAjLWsvOH4c?=
 =?us-ascii?Q?+A5yoO0ETmId0cwD0JkoPHtkWopyzydj5muDQaDP40YFdp+jn1086XUv2vS5?=
 =?us-ascii?Q?GVKWykfafDfPJmYr4Xej45KM8PfTAYg5PTOePV0spWSYvDMVmhKobotDJpt3?=
 =?us-ascii?Q?cgfJ0kqhxaoXR1l1V8VuCPD46rA4qXh5uxmssCW9hOzHoaMWE8Omktji/oZX?=
 =?us-ascii?Q?jPD8ytK4KkgbclMwHYOh2KF4InLngs/4F4wGR+Kr+FF/Tct/eoJhmd1Bkque?=
 =?us-ascii?Q?PHAUvpstY+pOaxDyj01hgeFV4i+Hd8WFGRAzpBKgV/+spdlWNBWVs4rtGSXl?=
 =?us-ascii?Q?p3Sb98xBYk9k0aZPnEr/2FBQ9gkefttD9IITcAtAKH9WoYKEvwD9/2ucUxEY?=
 =?us-ascii?Q?98G2EnduDTCO/uzkvXp2V9EPawc3QDu6aaEDFxKzpVcwdod1u2slMazI1qSX?=
 =?us-ascii?Q?4VQLr+azKkAyf5n16kfhvrefGg0e22FDinHy5gt7fveSURwmoQESmRdVM4Q1?=
 =?us-ascii?Q?MJQIJLTHbtzj1n7wKaa6XmKQFNEPnv5J3bqYL8yxmAr1TqzHuYWLAtYjtWoh?=
 =?us-ascii?Q?LzCG3Mpg5uTVVaiNONOQTRD0HRP4+4GphRWiXnKGUdS5eohLangDXc78ueyA?=
 =?us-ascii?Q?/X07uwanwHn9r2etyPOekq3HiZTir5W4SFYVI1qi1HIbSZmLL8ap5qhsxs8W?=
 =?us-ascii?Q?FxvjobQghevCJw3C4+W/MPa+VtVD5rhBSAcv1dt8WyPNRiV3fQMSJc2mHBv+?=
 =?us-ascii?Q?ob1qSejkRmqyS+J3eapDaypdacTQkVMC/sUAxOlPXv45cOZZw+552gVGRzMb?=
 =?us-ascii?Q?olQf7SJpzPYfI1ZB9MlVkU230LpWhkGoKqWtzSQMW2gk1wxM+C9m3EweXIXp?=
 =?us-ascii?Q?2da5g8g8leoGjURwtf8u0pqPI51BfVcNpIgL+e10aYRF67ugTQMMhbUCw0Se?=
 =?us-ascii?Q?uaos2J8kIf/h8ZWu9GVvNUoxEzIKnn25lHYChIJuhAXHdVZro3F4nFsSRCea?=
 =?us-ascii?Q?9h+nmzHHxagR9Q/croQrF/Nz20E+IoLFqoFiGD5s/ech9WD/LzZk0KhWqAjU?=
 =?us-ascii?Q?XWg7k+H41UnB12fbuJkBv6dpPU4lNQBkyDribE3omLC+NqQr8X/Hl6RpMigj?=
 =?us-ascii?Q?WHG+rkTHxSzryx/3PW0Dwmas2QcqB+sxoaeCOAqCX+PcVCQgl4TOBUaCLht4?=
 =?us-ascii?Q?/WGhQ1U5isHMujdND69dfbm770SumiBVSDdP5e68yvUrnW0QouKiPB+ehm96?=
 =?us-ascii?Q?OqhmGoBl+2OWymjMWn+VDDn9nKP6daGAoNzEZwoMFhwinKS0hM40tZvGKA4c?=
 =?us-ascii?Q?rxOqUJ/WJQHtBCnJjJZ1MZiYsyQL6Tqxe+neguAz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7188c41a-602c-42c4-3ed1-08da7e804d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 05:37:54.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/PoIHjt9ellFUNRhBNc+3EKzRR75DKxIe2lfqqRs83Sa3tnMoT+8aXofEfPgYNawSddiWfj8EF6v6kAg5oEsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2155
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Alistair Popple <apopple@nvidia.com>
> Sent: Monday, August 15, 2022 13:35
> To: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Wang, Haiyue <haiyu=
e.wang@intel.com>
> Cc: akpm@linux-foundation.org; david@redhat.com; linmiaohe@huawei.com; Hu=
ang, Ying
> <ying.huang@intel.com>; songmuchun@bytedance.com; naoya.horiguchi@linux.d=
ev; alex.sierra@amd.com
> Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on fo=
llowing huge page
>=20
> On Monday, 15 August 2022 3:20:28 PM AEST Wang, Haiyue wrote:
> > > -----Original Message-----
> > > From: Alistair Popple <apopple@nvidia.com>
> > > Sent: Monday, August 15, 2022 13:17
> > > To: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Wang, Haiyue
> <haiyue.wang@intel.com>
> > > Cc: akpm@linux-foundation.org; david@redhat.com; linmiaohe@huawei.com=
;
> Huang, Ying
> > > <ying.huang@intel.com>; songmuchun@bytedance.com;
> naoya.horiguchi@linux.dev; alex.sierra@amd.com
> > > Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure o=
n
> following huge page
> > >
> > > On Monday, 15 August 2022 2:40:48 PM AEST Wang, Haiyue wrote:
> > > > > -----Original Message-----
> > > > > From: Alistair Popple <apopple@nvidia.com>
> > > > > Sent: Monday, August 15, 2022 12:29
> > > > > To: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Wang, Haiyu=
e
> > > <haiyue.wang@intel.com>
> > > > > Cc: akpm@linux-foundation.org; david@redhat.com; linmiaohe@huawei=
.com;
> > > Huang, Ying
> > > > > <ying.huang@intel.com>; songmuchun@bytedance.com;
> > > naoya.horiguchi@linux.dev; alex.sierra@amd.com; Wang,
> > > > > Haiyue <haiyue.wang@intel.com>
> > > > > Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failu=
re on
> > > following huge page
> > > > >
> > > > > On Monday, 15 August 2022 11:59:08 AM AEST Haiyue Wang wrote:
> > > > > > Not all huge page APIs support FOLL_GET option, so the
> __NR_move_pages
> > > > > > will fail to get the page node information for huge page.
> > > > >
> > > > > I think you should be explicit in the commit message about which
> functions
> > > do
> > > > > not support FOLL_GET as it's not obvious what support needs to be
> added
> > > before
> > > > > this fix can be reverted.
> > > >
> > > > Yes, make sense, will add them in new patch.
> > >
> > > Actually while you're at it I think it would be good to include a
> description
> > > of the impact of this failure in the commit message. Ie. You're answe=
r to:
> > >
> > > > What are the user-visible runtime effects of this bug?
> > >
> > > As it documents what should be tested if this fix does actually ever =
get
> > > reverted.
> >
> > An short example *.c code to capture the bug in commit message ?
>=20
> That's probably overkill. Just being a bit more explicit about the
> circumstances in which sys_move_pages() actually fails would be good. Eg.
> something like this:
>=20
> "Without this sys_move_pages() will return -ENOENT for 1GB huge page
> memory map when dumping the page node information for nodes !=3D NULL"

OK, understood, will try to add more information about the error. ;-)

>=20
> > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >  - Alistair
> > > > >
> > > > > > This is an temporary solution to mitigate the racing fix.
> > > > > >
> > > > > > After supporting follow huge page by FOLL_GET is done, this fix=
 can
> be
> > > > > > reverted safely.
> > > > > >
> > > > > > Fixes: 4cd614841c06 ("mm: migration: fix possible
> do_pages_stat_array
> > > racing
> > > > > with memory offline")
> > > > > > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > > > > > ---
> > > > > >  mm/migrate.c | 10 ++++++++--
> > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > > > > index 6a1597c92261..581dfaad9257 100644
> > > > > > --- a/mm/migrate.c
> > > > > > +++ b/mm/migrate.c
> > > > > > @@ -1848,6 +1848,7 @@ static void do_pages_stat_array(struct
> mm_struct
> > > *mm,
> > > > > unsigned long nr_pages,
> > > > > >
> > > > > >  	for (i =3D 0; i < nr_pages; i++) {
> > > > > >  		unsigned long addr =3D (unsigned long)(*pages);
> > > > > > +		unsigned int foll_flags =3D FOLL_DUMP;
> > > > > >  		struct vm_area_struct *vma;
> > > > > >  		struct page *page;
> > > > > >  		int err =3D -EFAULT;
> > > > > > @@ -1856,8 +1857,12 @@ static void do_pages_stat_array(struct
> mm_struct
> > > *mm,
> > > > > unsigned long nr_pages,
> > > > > >  		if (!vma)
> > > > > >  			goto set_status;
> > > > > >
> > > > > > +		/* Not all huge page follow APIs support 'FOLL_GET'
> */
> > > > > > +		if (!is_vm_hugetlb_page(vma))
> > > > > > +			foll_flags |=3D FOLL_GET;
> > > > > > +
> > > > > >  		/* FOLL_DUMP to ignore special (like zero) pages */
> > > > > > -		page =3D follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> > > > > > +		page =3D follow_page(vma, addr, foll_flags);
> > > > > >
> > > > > >  		err =3D PTR_ERR(page);
> > > > > >  		if (IS_ERR(page))
> > > > > > @@ -1865,7 +1870,8 @@ static void do_pages_stat_array(struct
> mm_struct
> > > *mm,
> > > > > unsigned long nr_pages,
> > > > > >
> > > > > >  		if (page && !is_zone_device_page(page)) {
> > > > > >  			err =3D page_to_nid(page);
> > > > > > -			put_page(page);
> > > > > > +			if (foll_flags & FOLL_GET)
> > > > > > +				put_page(page);
> > > > > >  		} else {
> > > > > >  			err =3D -ENOENT;
> > > > > >  		}
> > > > > >
> > > > >
> > > > >
> > > > >
> > > >
> > > >
> > >
> > >
> > >
> >
> >
>=20
>=20
>=20

