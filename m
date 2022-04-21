Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B7750A2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389567AbiDUOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389148AbiDUOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:46:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2644092D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3OrHBl0i1pwrTVjjpRW13rSJAR+9fm9nNwF4ygfBSXzKngbka0oxSEPKklEYGKkdJRkqrdFTiUIGjFzlWjQ894TpC0MaoyRBF/+Ru3l9gVDp55/jcEtcN4o1ehj4BJPDZr7vR66zLNNPJW/BqZOh51w5nOZ/jrhxUQNGlxRHcce7OiuoS+ogErRLNnzjv8a8221V3J3TLG8z2iLsSZiA94otZyhNMPoeNr1CsyiP1b7Y6olF9Lil3kBHEpEShE1lmc8L8oSGStfnbjUWGf35WHH8HwhY9gBJg84YQJyJ0OPHuM05UjivOtcNDFYKkMZwbhdRELXBDmi7umhPmWBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5F7pt0GdfXqrH5iH7UoweYXk8O49gqXU2OGRl1KEeE=;
 b=dDtEiLsJa6ZZCwiqM6ePZvZOr7ZPS8olaNTuQQvhqsM7FYeM3++4/DPo+3y0m+abzC/9V6wDr6UiCxuJ3b/KiUOLhFWyfOmg7WkSRnuqsntL21kLwIOT3cHDFv1qZfjSz1XLIogSHQMhCDDr9ykGIXsqZHlNQKSwdtyHiWBtAzzQQMlNL0e2H4BezOVdcRDt3rMAMbnRUTvq1UgBzCt9gKKqmOjiV9wZiDOJIzt17YobjbMLnDbKjOmsFHz7MRisvbAbW6lrCmv2x6+Nwzmq9E3StPnlJe0ZUSG8CXQfuzuXA5X3rjNrN+nl/o9ulRXHC7M2IaEwUiDGpbpWDCK3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5F7pt0GdfXqrH5iH7UoweYXk8O49gqXU2OGRl1KEeE=;
 b=Y4EBLM6y3f/EDKYK/bnAOtfW+HhOXqqIsZs7vk25zkzR7k+x5HGCbSoJ/8DG939Ntf4RfZmpdcOIe2foJSb0OUMkZHK4Cxh+92JdAOqjLHDVKHhaCcSQfsU9s1W3VCk3qOgjG3azH5WnIDM9CLLU5zmWgKUlC9lbJ6ety62OIUw=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BY5PR12MB3923.namprd12.prod.outlook.com (2603:10b6:a03:194::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:02 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603%8]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 14:44:01 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Thread-Topic: [PATCH v2 1/2] iommu/amd: Enable swiotlb in all cases
Thread-Index: AQHYSGU4VLqCQ4qdF0CtZP84uy0tRKzgu/wAgAJi57CAAPr6gIAWcX7Q
Date:   Thu, 21 Apr 2022 14:44:01 +0000
Message-ID: <BL1PR12MB51578402E4910BE40765849BE2F49@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-2-mario.limonciello@amd.com>
 <YkvGwMlrv8JKjHJQ@infradead.org>
 <BL1PR12MB5157E55F2F469E66B46157CDE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
 <Yk6Zv8ubRmQMPPcX@infradead.org>
In-Reply-To: <Yk6Zv8ubRmQMPPcX@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-21T14:44:00Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b7292798-14d5-4da0-a610-0415acfc6ed9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-21T14:44:00Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 8dec633c-6a22-403b-a4e4-4e211ae1af6f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d7f2b2d-2b64-4615-c588-08da23a5605d
x-ms-traffictypediagnostic: BY5PR12MB3923:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3923DEE031483248A613F32BE2F49@BY5PR12MB3923.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y3Lhw355s6BaqT6PmBtx/O94xfj2IXHcks9K1xaQS6X+8nSSyKJtbO2pm1dZlaNFFqymveO6BF1nhIQyRQ6YomzCv5+E29PVKu2MEDzmeWDBfksvyJOy0GJ2Q2KVfOxWV3gBNWqTfmSkoaiU5JrttJu8dxQKBVBoFQjP6T+DOwzRdIWRnsJ48FbueftsdY0a/GYkgCF7xKxaE100rCts4NXqde713Tv+r954/dAJe1Cv2d80sOHPmw/o1yePCKQyZGNKaCw6rxUU4bnRzwPTFJBa35G4+ACbBPwW+2v2GFDeMK8rCMrv8NIg2RVjHt6m99eFsHw/hS7pt8GRUCRFYHz/ljOlWfalmF5M5vKBcQKY73qx/uKpw6CQhzxED/bME+oQztSJ0wSkLvN35UcHiX1s4+32LW1CE0/PIU9V4NvOY8VDCPaJUAmQDVDTIAzY4aufFcPRtmNgoLWNvkiRero13G+LqPRPij+m4/GDvXQXW9SHguCzj7HELotLaETuDZsL6fY58Dq2HlgtaXAAMRYgqq4E38mkVlUcHv+qFRoycYjV7XIE1HIL2qvwS/6mT0j6Aa2vY4hT8SsIEkKTaj2PYDlKQNG6Bi86ZpR2wXXrMlyRONmDLof7N9L/grw3dUcsrYvRAg/M0GAe4wgITycw425ASGGMqdtFgYtHJKr+m/Hb3R/vClT8S/1FDo8SElpWqQvhaZiVrpWfK/Py3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(9686003)(8676002)(4326008)(83380400001)(6506007)(316002)(7696005)(55016003)(8936002)(33656002)(122000001)(38100700002)(2906002)(508600001)(52536014)(38070700005)(5660300002)(84970400001)(71200400001)(26005)(186003)(54906003)(66946007)(4744005)(64756008)(66476007)(76116006)(66556008)(66446008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n6DL5jUND/7v5mF7VMbX5WmwWXL21qRvCkpLCZ53S4u/XfmS09RSIM6xHmQD?=
 =?us-ascii?Q?lzcQ0/BZ8Sv6bMUyX7OwfCouzsqWgxlmRt7MF0FLZFT+cwP2hI3sprfAbbDD?=
 =?us-ascii?Q?X0IEGlj4Z6EXFJDw05SVO6dUBkOQ9uNcELApl238TVIVEftsTDBguj4TKUkz?=
 =?us-ascii?Q?gQneVF8O3MbjgFe02jcUnr2WDLUo9gYD/t17h4NT8DlT5Idqtj6DI1LLLfkV?=
 =?us-ascii?Q?WWciLB/QR3rJWlz7nSn0lZEgeeBWOeskRHuiEmYcfSSBh2hRiRBsyPVQpwti?=
 =?us-ascii?Q?pVzhdX4H3ja3ELNprxUZDwdP0bC0aSAm6QiCYVqmwG14S0EDfNVqNdGv8bvo?=
 =?us-ascii?Q?Mfle1nn6J4f6uzEpXOHYjwojWbkEOUDa/JZWu1T3jOMi1f0PNHwousTkVT+D?=
 =?us-ascii?Q?Ys7Ep8RmLa2v5URFq03RUtYzfGbTuk3piOYubPvmonAmj94li4G0U6SZMsbl?=
 =?us-ascii?Q?wde0C0WCcQYfUxlZnUogDChuCAo9NNpG5K4uqyyYz3YRp/VUBaHXIEhUj6Oh?=
 =?us-ascii?Q?NkmeJo2zssD0uayc1C8WVRJpfaxxpPj8vjMLuhm/6Tw5RBZdWQpX0x2KhH40?=
 =?us-ascii?Q?mVA+O5pMEPoeYv9H21eC0KNz9667cqkkCHr1juvqFS+tOhWGi+zVcsihObvv?=
 =?us-ascii?Q?B2BiwvJLPxO/vHelSSa21ru8UrVAshJSIP5/LsLZoeBrnxItiQJXTyOmW+I6?=
 =?us-ascii?Q?ERmDNnFULs/gK4hwPFaIipSgOz41qG0aK24L4tLKjRq9HLNJGmFi3cwz11Z3?=
 =?us-ascii?Q?KB9L3cz0U7jrus6t6bZpfiyDUV6tSbaOZ7Xs4oDMIUuMbU230A+0i7kUA6yX?=
 =?us-ascii?Q?5WA81WKsY9IMog7Ivy9TuBYnHQ6kqb7sS8lYipYSnREJhOM5JrOzik5iMsy9?=
 =?us-ascii?Q?LhKfOWYVfgCx8FjLsO+PG9aU7TzXtyfQ/XLRQy10xyxd+HmYTkWd+/EKokAN?=
 =?us-ascii?Q?zyFin2vvyxDi43in7esXXXXM73arWDHdrKpn79akwt8toZ3HKWsBbe/9y5FZ?=
 =?us-ascii?Q?pOJvMbJyjtJRWMP+qPzf4yYkLPGMBjYAd45fxpaeSjaDTaqtZdR2+//k6JVa?=
 =?us-ascii?Q?sAw239PVgYSwfT+0UaPv99EZ/5M0L41DELYzAONEEDI4bMTC5dmLVeqL5gaa?=
 =?us-ascii?Q?j+Qdc1td69mcMAyYH4/p5L3eq9V4BAKSy9lFGx3kIVXOKCNPzWXzK4pFySbL?=
 =?us-ascii?Q?tE82N9fQDUh/S5l8B/MJ4VLZnayzVBRXbZ0BaTe3Lf5xbUDzYVSSCebxaeJ8?=
 =?us-ascii?Q?g4UhK3TQPqXTtmqxwlVNGR4H/NLbujl6Up01T0QovjSQ5kvR2ATKgW92PJ/2?=
 =?us-ascii?Q?TovwnWmSYnPKIF57OvLBBieysft/B5xmNm1EfzY+ROkERkacIprbabd8VD2Y?=
 =?us-ascii?Q?bOKoEbCW/av852MquAbF4iCSpnBnMCilQtdtFnQ4C1yl8ClVo2dTcbqVaZfl?=
 =?us-ascii?Q?Y13AZ3kQFcq4hdyhwqMRy7H7rcsq6zXO+Ssgf3ciQ9pEf1JE2KuR9/7Pm6XW?=
 =?us-ascii?Q?if3hsjbwHfNA+AgHc00VE0aFVwUeOdfSBEh6hRaPShP/9IuMxBJyqr4BwXud?=
 =?us-ascii?Q?NFMmZnGeSGevTS10BowK1sZ5DegIQoNe/8OgjlLtMWUuXzzq3UrhaLk563GH?=
 =?us-ascii?Q?q+1WOxRPuHQ5Vf+Vy7PUBwGE4NkQZu1Tnv/2mzDroDYSxO5sds4mE93XtMoc?=
 =?us-ascii?Q?fDinxMfTXvF8Uh5GB21/iuR+gw0ZbYA+S4g+w21g0GPZ8AIXDCPPQO1ZdQ9O?=
 =?us-ascii?Q?HzTEHip5ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7f2b2d-2b64-4615-c588-08da23a5605d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 14:44:01.9368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42q/g9WiMy37V/N13chNBef5oWZ9a6GDdqa9Vxz55jshp6tWMjJZDqzzlIDY57WpoEZHVzF1kLJ9no3l4DMsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

> On Wed, Apr 06, 2022 at 05:04:52PM +0000, Limonciello, Mario wrote:
> > Considering before this fix effectively swiotlb was turned off on most =
AMD
> > systems, when this is picked up I think y'all should consider to add a:
> >
> > Cc: stable@vger.kernel.org # 5.11+
>=20
> Agreed.  I think this is for Joerg to pick up, and I'd love to see it
> picked up soon as I'll have to rebase my
>=20
> "cleanup swiotlb initialization" series on top of it.

Joerg,

Just want to double check this wasn't lost the last few weeks.  I was just =
checking
iommu.git/next and didn't notice it still.

Thanks,
