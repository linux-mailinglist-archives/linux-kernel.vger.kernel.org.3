Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047364FD92E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352794AbiDLHYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350242AbiDLHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:09:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EF49F94
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649746182; x=1681282182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i1J6JaOA6HfRjm5poA0Llh/AEzhuQSnkCqO5OLr2S9g=;
  b=LW8j1TqgLS93mE6smMVhbyRrAyWy57fVh49XJ+mmvnqKsQIkb1jmjlbd
   xOZGWwL8DG05GxEnFmFxRp1YB+B/H/zheE0sqse/Lgpdrx5NjU4A0EbpR
   TgC7fu1XSAYku5RQ4iAcFjawnhc4PTy5rQQnBgw322fzIgsJ7Aa3UcniX
   O+xElABXikyq8xo2FpRgssxA9CTXSKZR5WcWjJ3Q2gyiz9mAT/MgTtNd/
   a9T7uTtiYhumJvx/5GfexX4eWP+/XjBS9FehpN1i0f4EKPvsoZmTGJvRo
   cTag62Jz484JuS67KOw27VFQBV6qUW3/090RrOO73myaOgknulSNpc24Y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242878375"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242878375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="526330742"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2022 23:49:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 23:49:40 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 23:49:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 23:49:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 23:49:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrLYOC6bhVoyvo/E8O2MgIHEvUZLgq5QuMOCFB90BgfhwQ3xgU/583ZCImzW8vfgOmTkfNogYFsrqs7K9NnCAZcYIIka3iXHRk4z0ERZoz79IlAQVbuc6WF0duhtRrZikLl548sopbZoBIuE56n+Bjm9EYQfYC1KwFknNg0qr4e1p/p4nkAjDd/AdyQag3gqccds0NupjbB5RU+Z5+nxtEM9+C6qXm6cWQqlueqJiqqoTyFu6TOxeQfPimBTjNlUex0YL8Vp5X5zyG4b+uJoKQXNkbgAy+m2N3fEXMZB0GTYpT2LK8djQtzjdkVXYm946xDDxZUg7A49J90rLe5+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8Uc7rg+SXYFHfpQoDou5UCroWfrzGEJdxpsnYBlbLo=;
 b=HaeK46F4fn+1ngCvRaXqZ2yIVt55FDesSoabw2P3Yu8srGY2OVLvS6Q6j6zLm6uP5rUOljww8D8M8GK9V87cZdyuXJ6Bey8d81VJ+nv7icqvOhNOHnwAKH11isfla3iO4yNoJpewMAfs4h+uztR3+CHJiYtJdh6bUgWHg6qVafn7eiqgOC4EFx1oFJ+Vi6AND08RfKAwXlr42LG2fyJkyRK7vxk7eTupC2EyOb/R+wa2Y9LPcQ8Vvr6nGIjXfCTDJemEPqNU/WfQwr48x/tgQ6ovxeyHTin5eAsw3iGuvvHxZNp5T86Q1m0UVotthLLhzFj/c5qisepEre/lp6vxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB2827.namprd11.prod.outlook.com (2603:10b6:5:c8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:49:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 06:49:38 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC v3 04/12] iommu/sva: Basic data structures for SVA
Thread-Topic: [PATCH RFC v3 04/12] iommu/sva: Basic data structures for SVA
Thread-Index: AQHYTMWUW/MrlAPo5kuWCX1MvRBmA6zrzatg
Date:   Tue, 12 Apr 2022 06:49:38 +0000
Message-ID: <BN9PR11MB52766016D2FAD092A892E2A58CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-5-baolu.lu@linux.intel.com>
In-Reply-To: <20220410102443.294128-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9950d54-a832-41bf-3018-08da1c509d15
x-ms-traffictypediagnostic: DM6PR11MB2827:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB2827F2DAFBB918659E782F018CED9@DM6PR11MB2827.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R54+TsQZVr0rMiHOWCH7gcRuK6nxO71lRpzcpqUBpcqcZ7Q3Y4OPCibGZ3iHCvsR2fWHzq01WcT5cUR377qLdbrOO9XZ1i9UzU1H9eaC5fTPmOo3ZA9b/e8v8yClSzn42EK5rgvxOLRUHtik4fst0R0dnrJ/rNqXyWRwtaLZ9LY9KhAv/GAK/A6+dVUSsz7UqF7hySavXh5FOKYju7MtZF5LdUkQiIv1JbfFT3NGoL/GdfnGroTN6jksrWnMlyKjo493TxQblLHJzMlYZ1CB95mT+0Iw9vNk1G5h4H11cWMAYvasUnM2oX6zt8v2q+zB0Gf1CWJFV9BxeBV9QZXIp2IpyXzSUk8yeTlVvvk6YM0cdtfQLOBQPSqLdeg/wX7zJAlfxTKIBIkPAqywRXyxIXPBdAqpdnqGQaAykSunxvziBJNWVUDHHnUyQ0wis5n/c4LY9O6B1mrDNFHfpyVjEpRScWtX3S3+4AeH7eltjirvC3zxDBsgN5lazvJMw+43JFyS5/OxqG93wPr3r61subfxD0KqiilYm1e5vUTtR7ZnTnap3QWiVwqo+Jo5UxaSDKOPX36IU/knK/HEOi68UVVolwbCmVRAymqTwubPx25knsyxj3w09edRuomfML04MSxOs4FTvgYJVCm3OaTk4pN6kNBlhBbRXWnboSXluGsEtqbrRY4lh5P672dJBQ+so4af9alpgATN4QgKHgZ01g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(33656002)(2906002)(9686003)(6506007)(38100700002)(8936002)(55016003)(66556008)(52536014)(86362001)(82960400001)(71200400001)(122000001)(508600001)(66446008)(64756008)(7696005)(66476007)(26005)(186003)(316002)(5660300002)(7416002)(38070700005)(76116006)(66946007)(8676002)(4326008)(54906003)(110136005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zODxfwft5Q894xuYRAG5JF0GzHF7RdNeDLYVeyJZWQoOfz0QDh431szX5/Xr?=
 =?us-ascii?Q?PhqSvnNfiN93LGSZjLV0gN5QAuGoAt/zhyI8LppygTMuIDx3z0OnvmZvjJxV?=
 =?us-ascii?Q?qcRarBis4AUT730b2oV6dd1hY/OYyfeq7BU8QERaxqUHXNLdc3MfMKrVI1Vc?=
 =?us-ascii?Q?P3EAcImQC9ivIhRmQFqNS+MJgp1ImzEB+B23KVN6ttYcuhMSlI/SX54uQia5?=
 =?us-ascii?Q?ZxbDNgHWBTFA6IWqPR4Xvr2ue+U+NVNRvBOAgX+OGsuhpRnC8qoXwnL8gMrT?=
 =?us-ascii?Q?TXdI6tQywwuFc0arDIZC+DWPwjtXfabjd1/mawisg/xxsEj0RFNJbot+gQ2m?=
 =?us-ascii?Q?eoXwjx1rm3CfnH4L1D9drb7jyFp51rJmJKXQGljyJBon2kIV9sXD9WTTJfhl?=
 =?us-ascii?Q?vz1zDdIqLyVsBe43XN79FqHV8IimLjf677XTJE/5Qh69/QQjMyAkwHdBuQza?=
 =?us-ascii?Q?Y6cIqXIfS0XaE+e8bGsp/an99nP9/otD2nCaCvdVz3hPW8HeeCeoy3IUb5Nz?=
 =?us-ascii?Q?mZEJ/bnMAgPSrQAzfTJDFcymBXrC6L4TJdATaQOdEwkQqnkmgAfd0o4UrV8U?=
 =?us-ascii?Q?TnUcUqjuZ48LiNgCwc1rpywr7cTaTHb13XmxhkwI1MvVQfKwBumWKZ2YGsX/?=
 =?us-ascii?Q?MrQ+2XLE5477AclCc+UbaO+3Um9dm88j9nL9VttSbxWb2KYYTDd2F2QDynId?=
 =?us-ascii?Q?bpSbVXyA+hLXnwHhxKIjuDdEjuB1LLNj9WvtuH5cfpBKbH4QT9cvd3ZJdRdS?=
 =?us-ascii?Q?wb7k135xclcv4E58OjPAl9NRgU7momCF0FifjUQJjt20mAD6q24TOfToe4OS?=
 =?us-ascii?Q?ZQIWxUgXSfLGcbXG09qZGuW4CEy2EuCMByWT0iYjqpjN4y+EGFWPtpAZvkE2?=
 =?us-ascii?Q?2fRtJM3rRlOaZaeRcGQlOqqIAC+imLzMBmZ5Q2Iv82ocuvGtUzy98TD7+ceZ?=
 =?us-ascii?Q?CXllklTgBGuTTrX7WUpDa7VUn9xFEsM6Y7hKSPSZwvWqXAuV35lRDeK7oYXu?=
 =?us-ascii?Q?z+te9UzT9GAW0b/YzMgEZUiQW+8e4NtE8gqJjVOS3WCjtLHqAcpbiprMJUOy?=
 =?us-ascii?Q?ITF7tkTGcj2viFB8NtBw9lvwPT+e11gu6fKIRvkxuWz1Pl8JX40SsQprMMB+?=
 =?us-ascii?Q?ov+AJr0Zz3JOnvMh+OhGuNaqM2xhpBr0yvkjfZbnPSmq783SW+EUEpl9CdSE?=
 =?us-ascii?Q?n6jBMssxqLtk7vT7590dRybQuDsCN/Gfx97fHzvU6r43a378Hri93mNZUH1v?=
 =?us-ascii?Q?ZhAGQ+XutrO3x+aDYXVoqw3p5DqBMy9JjeGMc1llBV0eewwLovWLalopEQvZ?=
 =?us-ascii?Q?NTQvTXnZkjspU4Sbsqz0MG97tNcNQXJPAGzpLERY/CBnGTjVAwAnHph/1My4?=
 =?us-ascii?Q?OdH1xhThbVobxeOhifAkitMIc51nteX5XvNtSECBuqp/c29VP6djCnbdWUXx?=
 =?us-ascii?Q?ieQyvFSH8TksGpcW6zCBB1qUEXtQfrusP8+n65ErEeSuraYTMXPS6Sg/Hb6I?=
 =?us-ascii?Q?7tW6x+aBVh4E56f2opy8QdR2GKvIjgBaZKZ0tO9208JRasVomc80/p4gaFIz?=
 =?us-ascii?Q?UiFPeCz95EVMPz1+boloklPxwvuIzHf+TCXadmscXxDhdZasBVhphcT1RZ1s?=
 =?us-ascii?Q?1C7V59W5MMLVfr+u87bYFikTgb4Ilf8G2CAZMJaAJ0/JS2hHTmiQE1Sn5veY?=
 =?us-ascii?Q?JLOz07WMJFx7zr/GE11C118toVTB2BIABdZ/y50hyFraoU3z4PoARuTwkI5+?=
 =?us-ascii?Q?AEmwXQ0xpg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9950d54-a832-41bf-3018-08da1c509d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 06:49:38.3625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCnSHrVWPH710dgTop/fN3fBMbtGG0L0+fQHSeDDCZCua/glrI5PftdJebtMVNiBmsgsVFhpgVpiTEhzl1Rnnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2827
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, April 10, 2022 6:25 PM
>=20
> Use below data structures for SVA implementation in the IOMMU core:
>=20
> - struct iommu_sva_ioas
>   Represent the I/O address space shared with an application CPU address
>   space. This structure has a 1:1 relationship with an mm_struct. It
>   graps a "mm->mm_count" refcount during creation and drop it on release.
>=20
> - struct iommu_domain (IOMMU_DOMAIN_SVA type)
>   Represent a hardware pagetable that the IOMMU hardware could use for
>   SVA translation. Multiple iommu domains could be bound with an SVA ioas
>   and each graps a refcount from ioas in order to make sure ioas could
>   only be freed after all domains have been unbound.
>=20
> - struct iommu_sva
>   Represent a bond relationship between an SVA ioas and an iommu domain.
>   If a bond already exists, it's reused and a reference is taken.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

This should be patch07. None of following patches touch those structures
until hitting patch08.
