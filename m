Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505EE4EC643
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346668AbiC3OOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbiC3OOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:14:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C32B1EF5DB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648649582; x=1680185582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J8OJB9xIKfRd1SVqyT8OqpL0QWJxdBQYHWLPP49rW/E=;
  b=OGt8X9sCiLVmwMHEqsWcwBtNdrPWm4lDQHb/+WGwFb3fvJAyA3CcycAb
   AFYUExiyIU2ridZxRSdQthmojuYwn84suzYhc3hlF12+/NdhCu1PfG2MU
   C+STTOALtF6qzIn32xCfEJKtyi/+OjWht+43OMKONqFi1yPjwSxjFQowe
   XlFMdqmZTCNL/MFjZ8kCNOVVDBbVSAwdKrIEA95CLcueI1D19hav5b27B
   WE5WkeF//WRooUyWLAvg+JdBBPtNitAsMThMYTgQkEjxb9qojcnUv1ft5
   j1ODGeupSIUKOnIXSnxj/et+NkzsL8cNyy0z12xziCKbWal9l4amSKJ0U
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="247052045"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="247052045"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="605447937"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2022 07:13:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 07:13:01 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 07:13:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 07:13:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 30 Mar 2022 07:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz0P1jFsha7s83nLHAMFnTC9hWoZfY7xLmlMSNOej3kllcsWzxlmx6fallaLLaXXI7NkC9+gDPmX2jDlBtETgPu636kbGRQnLTuAWqa+5x2SDgCT1w4qJheUPcTBN8Q9orf2dhBOcIa+ztKpOUmBxqy2GUPWQoQoasP7sxXLtCHJA76SY1i9C8W20BKrh99SNGqWhPvbxt8y8Z4o+hs77c8DMkqVDGUQ+O0uZuXZvR4XNzK7xfeKuFfBhBtR9dswajJKBV2hoU+ZlKobskqW3rbk1Kl59GsFBleEQDPl/n1mbXWLp6rZw/zDEOPZ0iX4cwo3RFdhBLQeWEIB8GdAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8OJB9xIKfRd1SVqyT8OqpL0QWJxdBQYHWLPP49rW/E=;
 b=hK9Tb7/EVMvbsec2s/6VatSyHhpaZOtlrE08VRK8FXt4zhlUSDMc59MIkPG6Fgm/UDzEAbKjEElhVMZhxs8mlbh9RBbhFU4oswSKTBq/iUOyswX8z26Nn0XzRJRzIsJKUDkpLivuIMbp3rm6qxu4ZXzEHETm7U8H2Zo8qotsbLN/giaW1L4f8Z8dlsE8zX7vnk5xd0F1GFvOqEphj7Ot4SZzSIGKyLBOWB3zpky3JZX71L0i6z+x/6iwGu5UQVaN1+hQmyS+PtFmssGlFrENKY9Hk7j/E7x3OM6u7EguhjQP+fjZtv3RfwY940j+iKnUo9X3X+xRo8TOssZRhbQ6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY4PR11MB1448.namprd11.prod.outlook.com (2603:10b6:910:b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Wed, 30 Mar
 2022 14:12:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 14:12:57 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAA4VICAASjOcIAAbdAAgAAjg7A=
Date:   Wed, 30 Mar 2022 14:12:57 +0000
Message-ID: <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
In-Reply-To: <20220330115820.GE1716663@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75131a09-34cb-4b04-befa-08da12576433
x-ms-traffictypediagnostic: CY4PR11MB1448:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1448275ECCD46D183E7F74BA8C1F9@CY4PR11MB1448.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95EXL/r41DPGeB08vRbIphsVOIAPN3xtf9b+y2zUDhf6YaNv0qjIkom2P5h/T/qkuqezEZYHnFr9VjfeVDRgxiCEpxR8JOnrG3VFtB0lRrezloIVi1ZDFW2ZE5zKp2SZaOHGEh+/Tj2nF7//SN8F3D8xxNFHp02Hl8a6VSEKhIT2J0jRvzsX0BeNiw6I3GRG+c26PWh86Wo3NEJzWCSjgCTfNxZlLVudeXIgk5r3185YpnrksuvH++xOZXxF5Yn1y8F247fGJdtaD4rlNrJoUWL+UcozpHY2ufhawtHX81FmmvWtKKaTirDlKyYlhLgWGnbxCmNv6j8ZuSGj6YUCLuXN5QbwBA3LH4JKJLe9VfD9eYP23wc0DoxT3xgrDgxiAIAPcZczmvizn71dQFiATNhq2Vtef/+GOGWm6UK2eTovoAzcTpr/oDBDLgY17ihrwgQ0A7Snl8KVPIwmeSqxDsvtxQroKTS3TXKs429f4q47e7dlXwUQD2fIfmZ2G6a6lJLEug7RAoZ4Ew9svErJwgqgkvi2KMt1CTtEHhKifUz3iD9lg7hI2QMO5DLDk/5DNiQc8mZMAsBZebvegBjlaMfPb1wwUfY6xmoitDV2w613PbzeopUMFN8hKu87Fzk5a8/Z/FyLwhzcJO+i9Ar2p21AKMMY1P7/UjI4dhI+wm55IDfPyLiHxOupM2l0p7U+dj3FvWRBRlarvp/oGqsKWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(4326008)(2906002)(64756008)(66446008)(76116006)(66476007)(66556008)(8936002)(33656002)(52536014)(38070700005)(86362001)(54906003)(316002)(8676002)(83380400001)(71200400001)(7696005)(5660300002)(26005)(122000001)(66946007)(9686003)(6506007)(55016003)(186003)(82960400001)(38100700002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7niFOougmYdnhJxwn5MNU1IsOOnsTn+cTYDCiuDUYsNVbBp9Xqkid+I6vZqa?=
 =?us-ascii?Q?C1xzkFZoyB8jsx31kgB62lwnfbE8prvpByLqYaQdOTiHiyHEwKnJdDZrDS/i?=
 =?us-ascii?Q?PA0ncKqSJR1VcWWjHxu3wGlex66r9uNIOFCVww7vpr/W0kHG8u66/EbJMjWO?=
 =?us-ascii?Q?Dyq2juRCTInBqYGrJZTCPmyO5zg337Z5EviWLUaij3unsF+wvJHXHGJWfVxD?=
 =?us-ascii?Q?RTryrrOUvC0Ln9bAWDc3BSiEvBHyc5D8jsS+gNvu+17vdObKOI24bfKUYRsM?=
 =?us-ascii?Q?CMNjqDbZYJWlOEeiIhwESI9u0/T3jm6IYgXhFc/LDMYoKaspjq0NV3An3x3x?=
 =?us-ascii?Q?AinbMt4ynYIl0xCIYvRpBoWyS1BuKKfkDeSua4GLeeVsGFu9ZDMHyqzpgz7S?=
 =?us-ascii?Q?9BxEww2stUtXEgj2HQmiyjjgYYHw2lUPVRZ1TGQtta7ibOTouNfWoII1Y05N?=
 =?us-ascii?Q?AFn8G1I2ZjZOnIqj64mI6F9XuPfzdrMHXzSYqO9qM5VQYCyeyLt+t57Hk5Sa?=
 =?us-ascii?Q?X2bOZ5AsOm8jVAqzq2+D4rsvqYR/pebyT1KRi5nszfHYPvhrN8OiJw53hkUh?=
 =?us-ascii?Q?bWBleSkBKHSV6x7l9EddfZm0Bw57splxkpc1gosfwIVH+nksuZ8DQukwzTPi?=
 =?us-ascii?Q?MldS4afUFjO4wReZECyCctvfV53qzySvAtN9VX6U7yYhYLHlvhvKs8Pj7gB5?=
 =?us-ascii?Q?3IFpwOBluEOVq8r85i9s8TKvc+hmfKNWc5Vxlc1uytqAxR/r9EZIydtqaRUR?=
 =?us-ascii?Q?KF1h3iwcCDkv4zG6ErSM23nABPnjfq8fnZJKKR5hPUdJzhpsM680juS36jkZ?=
 =?us-ascii?Q?5r4LG4G7qFSrkC24ASIZCtpmh+MavPbaP2aZP4bjqYS/QJsN5CCyu/dDKKFm?=
 =?us-ascii?Q?hAKMDbc08F2en0zX9mlzeetrI990VZYwFe+ZV4JkWwcT6yKFLdgcVq4YTHlY?=
 =?us-ascii?Q?V9TGme+EDQM+W3DQstlzVkrNAI+w5EW6SZH/PjvHbRM+DPX4GH3pP2SLVCWF?=
 =?us-ascii?Q?N9o0S4MAEnfHcj0Coqp971j2/EbDLqKFuKyvAAnECJuOohZHuyTjtlZ7M8w0?=
 =?us-ascii?Q?QAk+paSVHf/cD0linwEX6/deKG06MPDeqR9Gmy8wphemvhiviB5rTWjE6VLS?=
 =?us-ascii?Q?qcs+DjAJkWt5V1ypseH67X+y8yWeHiO9myMy6aQMd2gaD0yfSjojyeW3trr/?=
 =?us-ascii?Q?xzUFrggmweX5dQIDQFKRouu+krOH9EoIYnH7qqh5PKc1cJ2h2d+IUNm3Gz0c?=
 =?us-ascii?Q?kLQz9C8fwZDu9lvML5Kxza8iWc9BhAu6b6iPeo07SIwyOncX6az+oUy5Cf0f?=
 =?us-ascii?Q?cB4HNXiZErQ0nuyD6ZgRUcpYwZz8977Hlgl49JQWjxclDPfWIbzyNcHdj12M?=
 =?us-ascii?Q?jwt9sWVu88G9K2MWZeJBt4czkKAXCBHSA4SwFANJJY8AMuXl1yL3xmghsDtv?=
 =?us-ascii?Q?+kDRbO7yEVbj/jd+j209jAxC1cBCcJjRffU+JWQaZnO4bZp0urb1/mlruQz7?=
 =?us-ascii?Q?Qi/CScag/pN+IsCbJHB97XLcEVP1MT6lAPBDCdtNCxikmGqlKAI6FtoYpIRk?=
 =?us-ascii?Q?PmdJ9Mqja0aJXV8wjj6ubWzclK3mwYwPlk5ZlNJW9ZFNxXC+rIiXjt0Bf9y/?=
 =?us-ascii?Q?ctMjzISho+r3215L1ogQFQ3uEsX3ElMUp0KKcOhfwUKSMvWblbPpBa9My8AD?=
 =?us-ascii?Q?md8E3xE3S3AYqp/a2M0IwhAubALZKNUQ7Y+Z7UAabYOZdq4UeRAvsPue4vGC?=
 =?us-ascii?Q?EmDuiEoR2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75131a09-34cb-4b04-befa-08da12576433
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 14:12:57.8132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFU/JlCzEaqUBrLEzlaugaF9i3j5q10C6HHUjIGFJtQZX01hMTJLuGLJmdh2QUE079t8nSHvYhokPp4Y36cjeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1448
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe
> Sent: Wednesday, March 30, 2022 7:58 PM
>=20
> On Wed, Mar 30, 2022 at 06:50:11AM +0000, Tian, Kevin wrote:
>=20
> > One thing that I'm not very sure is about DMA alias. Even when physical=
ly
> > there is only a single device within the group the aliasing could lead
> > to multiple RIDs in the group making it non-singleton. But probably we
> > don't need support SVA on such device until a real demand comes?
>=20
> How can we have multiple RIDs in the same group and have only one
> device in the group?

Alex may help throw some insight here. Per what I read from the code
looks like certain device can generate traffic with multiple RIDs.

>=20
> > > ie if we have a singleton group that doesn't have ACS and someone
> > > hotplugs in another device on a bridge, then our SVA is completely
> > > broken and we get data corruption.
> >
> > Can we capture that in iommu_probe_device() when identifying
> > the group which the probed device will be added to has already been
> > locked down for SVA? i.e. make iommu_group_singleton_lockdown()
> > in this patch to lock down the fact of singleton group instead of
> > the fact of singleton driver...
>=20
> No, that is backwards
>=20
> > > Testing the group size is inherently the wrong test to make.
> >
> > What is your suggestion then?
>=20
> Add a flag to the group that positively indicates the group can never
> have more than one member, even after hot plug. eg because it is
> impossible due to ACS, or lack of bridges, and so on.
>=20

OK, I see your point. It essentially refers to a singleton group which
is immutable to hotplug.

Thanks
Kevin=20
