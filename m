Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066A44EBB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiC3GwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbiC3GwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:52:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B19BBBD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648623036; x=1680159036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lop3h539RtYwFjWqniZwLLaN/TOXzhcfcXy/SqD8Pwk=;
  b=D2bERCG8AljqUe4QlOAPkR90Qj6V8MWjPC5XMnmVOUGli0cDZhwh30ET
   3ov2d9tN4Q+iVLzvmp/1tamUqW4VSVfPrx5+VWbUPORskAv32k/1VGJBg
   hUvEQtELQFCCt634pmpQ802B2TV/l23Qm2HkR2T7XHQw2QJ1KY4yjOoNL
   XWDbhUImh83inC4uq5IniwOdLv6pJaN9FASb7R9DgD8sszckqq3sfZ9SE
   QtlG9XgVL9TYfSdI6tZnNSRVTVpnUAj6WrFJqGG4o9LLy3oNa39IwBVct
   HmPdqYux1f0O+QiiR9B9RDLMh14UqbBFrJbNiQyKRLvkuJ6AGvltYLe1f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="257040527"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="257040527"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="521774312"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2022 23:50:14 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 23:50:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 23:50:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 29 Mar 2022 23:50:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 29 Mar 2022 23:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jz4veI47i/mPGAGqs/xq9HjQgnQ4W3GfcHo0S6GtBKboV9WJ3J27egpL35elU6LaenTAMepT8vzQEr3IAzHKhFHx/45hCDERWHhAkh7abXevaz1EGCafVLMzb1xQPNT9J8uk5HR6Hp8SVIdY+a12MwTBrfvlUBf1SQJ+3tv9knkT8oymLpWB4h28fpRZ4mvqhsEEC+8+Xdm72DiQ8YJrPKtJN0I4EK9aShlKuNG/vXk8uBhs/6e2RQwUujb6FBqtS/gVRq1UiSwq0Cq1s0l4q5Yf9zxaCbyhKxeRgygUKt9tXROCK8M9TiAuiPbxxE1KkyNVduXbHxJQJFkhIbpXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lop3h539RtYwFjWqniZwLLaN/TOXzhcfcXy/SqD8Pwk=;
 b=iYH4ndJVwZwC28VnKRiicrs5dCeNPadcKj4pt49XYUTrW8PsSdlWikpPfw/pNixZqPZTAnK8Aj2zAoM0h4vt8rI93k+p9XfWPenXA49TRHi+mV/trIKjGyfKLm0+VdiBiwLDC9VYn5E0Y9aHezwvM87mXobYKse7Q39QrBMULHCAqg+3cKTQEPeQkBu14UPYusAws+SMdkuTE/Kry5MOMtSAdJI9rnrUS6dfipcSY7Ud8xhr1bllrNXpnI9C8W2oziYI+5lKLRo+wjrU7JDA1oyNSAn65TPgPwh0vMFr4seSVyUQNJeN2KlauYW6lGJyu27vWlqjiuF4s0E62G97kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB3873.namprd11.prod.outlook.com (2603:10b6:405:83::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 06:50:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 06:50:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAA4VICAASjOcA==
Date:   Wed, 30 Mar 2022 06:50:11 +0000
Message-ID: <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
In-Reply-To: <20220329114259.GB1716663@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ab92b2f-8923-4714-6d84-08da121989c1
x-ms-traffictypediagnostic: BN6PR11MB3873:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB3873CED8DA1B240DED32977F8C1F9@BN6PR11MB3873.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ScxZR6KrjLPjSRDSiYWrbGHWHu12/mQiu2uYIKu88pnwJ9FGGfjsbxjWwi5KMyZybPflN8DksxwHEovf94ED4FLGlsxXxtZ04jASHcD6ONt2igCmrEZhrquRKqJ/ARcBA6yBJ/ah7KVggWajQl3MQq9bX830uvAqvELmkCO0jdloAxcZ+B54Vw/Wh4uBD7UM9plQgaUyJ+wkJ+gt6wDmzIOpOHi3TUA6G64lVaChrWGYh6Ppzi5UdJbX+pX0pVLHEBR/a2wQQllAX6kmpDNABrBa+DQ4HRjHAETauQomEbIUX03hQzM1q+zztY6n8x82pgZrl+cVyMRdsPcl0hhDxdTpese0d/qBARVY+wAyOsiwzeyyRwawTTcS82cL5H1RDUhef9p5WivIh7R7qsgYY8sKeok1aWDFS+J8SIfW7Bj0gKSIJXv2ZZGA7f4lmH7718iJabOtblsUo0sm5X2bUHkS4csVxZGjze6BLY26aW/BJh3e/79D990dFuV6aEVIbGDU3iQUc1AKQV14EMKnCDybrsBw7UQhr7iJedrSacMKpqCD40Ye2Br/agQoAIx/cVwZHcuNBma0SRYH7VPS24n/jbr4V74g1QjKtVWJt5zCBUzN2F11Ca/7qWmoC2WCL016K0A9EZLlNdJhvDqisoNdVHiAxb/Fe34pDZbtFsOXOLTd4wlQWBEu27sfB0wEgezvUNKyq5SJRiAZOhv++w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66556008)(83380400001)(82960400001)(76116006)(66946007)(33656002)(4326008)(66446008)(26005)(186003)(66476007)(8676002)(122000001)(38070700005)(64756008)(9686003)(52536014)(38100700002)(5660300002)(8936002)(86362001)(6916009)(7416002)(54906003)(508600001)(71200400001)(55016003)(7696005)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1TzD2wo/Gyj6DsK1utwtr8jS0sFweZYWPMauhHAkmYkCg2H+UFfMDdXEseYd?=
 =?us-ascii?Q?ToiNWY7d+hljI2DWArrVPhY5i8SAnIqFOMlqpT88RLjMeoP3bPSxk9/SSWOD?=
 =?us-ascii?Q?YrFwcvrOxGX/sOGViAk2W0dTsRKCE6jDd1rXtmBRLNUJlhL5oRe7C3ickJKQ?=
 =?us-ascii?Q?KwKwYi/QO1i0EZ09M3IbGWNqrF4fGfAmdDB/a2Tf16dL7+/TSVwb6nrrahIN?=
 =?us-ascii?Q?07WzNzgQ27UGtU6759KusEu9pgqqXkmKrpp8BQb8puD3BqnlPnHt/GKKvsDM?=
 =?us-ascii?Q?SE40gXM2frAgPMJYZ1AR8/TjkKG7mapa84Xgnmea9GPeUYXiz0fwONNO9Gj7?=
 =?us-ascii?Q?Y2XUJlzSVY1pS+d1ucqTWaL5NPJ7IQcEkdzqbpBqXJzyRTO/MoMzad4f8F+n?=
 =?us-ascii?Q?wOlaywuAJspNO6DZe738xApgqq4SDdAK03FdUr5q2+mN2CEbFlbBeaMAR/Q7?=
 =?us-ascii?Q?68k0Ou76hUN9DlOR5fcWRnoblrLpJBwn8EGgOslKbNvN6qQrK3l7k8c3nVja?=
 =?us-ascii?Q?b4DDD8bMNuiwSwz02ST419yAoZ3tfkSTPddXweljY3mGU3IDt5HkYRzDbmi0?=
 =?us-ascii?Q?ds5Z9/5j9pdw7FoDOXU9ooZKbh+NM76zVlBgmNYEDjTwICwaApFjNcoJR/tH?=
 =?us-ascii?Q?BAqa06I+m03JutGbjOdMZlG3HJySjhCe0yk687aeGSZePhRpvQ/QyvynDS/h?=
 =?us-ascii?Q?5qMntN1b8FfMV3nEbqsUQF1KrHo5TLxaOaqey9tiJ2MmJ4oe+Wwl9+D+phd8?=
 =?us-ascii?Q?VxjunLIIzp+2PGF7WnxgMH9PUF45rwwpIedqKxu522aCgpJdpaJk8YKsSJXw?=
 =?us-ascii?Q?Tg3JxOhh1wIK/mG5mCu4DoHFzjSfkBCsAdQ7R5HPtujlmUiZGKJxuOV2fkyr?=
 =?us-ascii?Q?n75GJNUK4CyyoKTN3vhNojR6iGhdYqbH/cJShEOPxsPpqWNlZxox7EaSNwcE?=
 =?us-ascii?Q?8e+iIg/VTtshuFYKfeUAUWbpCOr7Zj4AQC/b5fEmgDnqEPN3HALspPpYIQA+?=
 =?us-ascii?Q?E2SqzSPlUlY2uroGG83Ykq+dsOES0sii7LzvEEbdQ9lFsRVij7tyHH52qTXL?=
 =?us-ascii?Q?A0vuqC1ilvH9jJC60iqL1ZLDDUAT/vYw0SEdcDCHfOR+z7C2xkzqADDbmaOO?=
 =?us-ascii?Q?rW8FLB2c8jeSVPLgoYePbBQFqGQ4tjYoPTWG0Qg14soURtJgse+MgQ4LQhIH?=
 =?us-ascii?Q?XisNXUF/usqiNvCV0Bpbbi2wWNEDvCiq1MlSe4ZzU/dMhCQC9PlUxnUanNvD?=
 =?us-ascii?Q?QdYhzsuQ15XiAEdYe3pDEdcoER34Mq03OtNM8HyXP1fuTJyFVxcgqSmzIAD0?=
 =?us-ascii?Q?FJ1KSizsDTlXs3Rk/yZwiv+692+mlqiXONiq45FiCEJbF2bxUBHGvJeACZ+M?=
 =?us-ascii?Q?mwzMnMnVcACStk1R43xjN9/25V0Yof131c+H/OvcarhkeozpPxLGuf5RkBLz?=
 =?us-ascii?Q?tzJXZDiHHTIOVveGYQTEjPN3JJlthDrPSKl+RqlzZ2/1/A6Mg6euwANRCiH7?=
 =?us-ascii?Q?Tmj8ozJJFbv+iKz9u8l0wXdqh5gqI1oWabQGb228o60Y/14VHr2P463zrXKU?=
 =?us-ascii?Q?/K3aEnV7gOJJC5tWRq36i4R8kVRJBQv0IwyRHMvEDtMkyn1B8fnupKyouFXw?=
 =?us-ascii?Q?2nMzVzlgarC7fYuv0uZwP75lbIdDqcMh3fTYz6tLfS/cisezZzfbe49+QorK?=
 =?us-ascii?Q?jPIUeHnMkRdu3FXkJC4lWQfbbGWjebwiDAogiCTJw5dKhFIjLRt3IziszbfZ?=
 =?us-ascii?Q?dDAOQz74nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab92b2f-8923-4714-6d84-08da121989c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 06:50:11.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esuWtiOC48HVeF4QisuyCpfY2hDVfsvK537C90CNBKIX2OeAjV7TlC5YNiH3PJ153kAcoccsQ7zlwU69olwLlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 29, 2022 7:43 PM
>=20
> On Tue, Mar 29, 2022 at 08:42:13AM +0000, Tian, Kevin wrote:
>=20
> > btw I'm not sure whether this is what SVA requires. IIRC the problem wi=
th
> > SVA is because PASID TLP prefix is not counted in PCI packet routing th=
us
> > a DMA target address with PASID might be treated as P2P if the address
> > falls into the MMIO BAR of other devices in the group. This is why the
> > original code needs to strictly apply SVA in a group containing a singl=
e
> > device, instead of a group attached by a single driver, unless we want =
to
> > reserve those MMIO ranges in CPU VA space.
>=20
> I think it is not such a good idea to mix up group with this test
>=20
> Here you want to say that all TLPs from the RID route to the host
> bridge - ie ACS is on/etc. This is subtly different from a group with
> a single device. Specifically it is an immutable property of the
> fabric and doesn't change after hot plug events.

Yes, in concept your description is more accurate.

However according to pci_device_group() a group is created mainly
for lacking of ACS. Without ACS there is no guarantee that all TLPs
from the RID in a multi-devices group are routed to the host bridge.
In this case only singleton group can meet this requirement.

One thing that I'm not very sure is about DMA alias. Even when physically
there is only a single device within the group the aliasing could lead
to multiple RIDs in the group making it non-singleton. But probably we
don't need support SVA on such device until a real demand comes?

>=20
> ie if we have a singleton group that doesn't have ACS and someone
> hotplugs in another device on a bridge, then our SVA is completely
> broken and we get data corruption.

Can we capture that in iommu_probe_device() when identifying
the group which the probed device will be added to has already been
locked down for SVA? i.e. make iommu_group_singleton_lockdown()
in this patch to lock down the fact of singleton group instead of
the fact of singleton driver...

>=20
> Testing the group size is inherently the wrong test to make.
>=20

What is your suggestion then?

Thanks
Kevin
