Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8394FD8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357967AbiDLHk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353096AbiDLHOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:14:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567036175
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649746587; x=1681282587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RXK+DHeAENUM9Shk1u5ilErXNKHL4A7A2CBmSL3fjXE=;
  b=V+owkQZWsGjTVVJqv/hDKrZQWC1nIFi40vQVJoKD0vByR5E46lxC/jDY
   ijoiEIy6KP6ljtFdK146/8k/lT9Z9jKa3Ly+7jpPZi9JKYhu4z4/7MXfp
   d59oQKefklrk91YCpm+0JN1MCAw1z8C0lmtwCaDT40ooRRzyXuCd6RUa1
   y007KxsCIzb4WGtP2YGuzPFcxYV8WWnjEfSh4uu+2d6KJzSXePHNOanFf
   SO6QzeOcxKUPbnArUDDwWd+/qHPUzOVU3JZBSnZEGi2lRZ06hLBFZGJNk
   T87tbQLqmhZszgKuglKsCqit11DkvKP+3S9B6gp5dbR6ovqxrSLYMgdd+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325204184"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="325204184"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="654966011"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 11 Apr 2022 23:56:26 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 23:56:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 23:56:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 23:56:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 23:56:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzGpav2ppmID8U36hywvpQLfXO/LJKiaodKmlPHNfV45wVk1ith+0mc2oqGt9ND4vy+GVCnyu9UT/Z88KUEXAFwf7NMgxqqVRrnd0xygif1u+Q3mUNmm8Cb1he3s32XP++/eCvOaeyyEY1LqK50QI3esla3pEvBET5SNv+K/upq+6oSUqKvGicewIkpoV6SJXkubcfoB3M452aeoTlkUH5sp95PdG8yJONjhf5KpDguiNUH1KsW6XdvVLyhssERB+vpjKkDdkdOkGXsaa03ppGz0l57j6MM/wPMItEfjqnyip2jYISp03WT7E+9kjTwOvPMC73kDsKgTe35Ue+QVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j8yyc2NvAZU/InJuRO9mFAqR5Hrz389DbyJg3h8ahY=;
 b=FjE1hCAwdfv3xUm9qaHg8Z2/8XPQjsGOprol6gA7tG1WVqhX6jehObbcCqkYCWCFbE0ol6Ei0MYaUQLaL0df8DkitDSvrpSqeqkWps31fCmgO6RYaC8GikGlLlyIm0fxOlWMDZ9JrckA04SvxGRt0dc4BhQtBc3vEwitooKfI8du1mSigJtYE3eZqohbRqB2HcUFsVlupjAz+KRX8ayFsIFRZWFFaw44KWBq+zIgfZmNmIKLEWrlgAB7rcFhBQZkl41vOXgrAmsQSTrBjdJyswwTQCSJ/Qm9Ng4Wo3OTei7Ot7N4IMCScHIO5os5tzwFN9bdWWeYY+Q6unN+512r7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB3758.namprd11.prod.outlook.com (2603:10b6:208:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 06:56:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 06:56:23 +0000
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
Thread-Index: AQHYTMWUW/MrlAPo5kuWCX1MvRBmA6zr2t1Q
Date:   Tue, 12 Apr 2022 06:56:23 +0000
Message-ID: <BN9PR11MB52764EB5F4BB89909585662B8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: b4670ad3-cbcb-4037-ddf3-08da1c518e9d
x-ms-traffictypediagnostic: MN2PR11MB3758:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB3758B0975645AF655CA5ED048CED9@MN2PR11MB3758.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gwOo77f5hw77QuNMw6dNiSb2FVDuR/L9Qc/jYcIUCiZ19hVPA9XmHn7Dt6hTPf4uAsik83821zOkyqlQ51DomhYA8uSQQ+S2gKMawvRTJjjCtG2LGvj37oGhjedZc3yY6lln29S30JKn88y0COcFpE8sWBFubIF1kW404/AGQg5gGe0qJFtvZkWaCogv4T5oo5Z58p2Nokhajv7LBMRxUPGYMF0o1IaXfB4pXHJ9szCDulQef16FvtDZ8a+IE+rKDfsUGOK0+AKNteCapUpgM5P+bvitMsb7dV2xo7hp0tqt1knlnjRpSj6DpyhejoPfRTh2+aHQOm/aqIsFdJVJe+uIZKa+SAnqhgolwh/zcVlYNXkFBLjCEG93zmxg2cbPmeGaEzNG1rVxZvhGZNq/5CQXtrSGxPeFJFtyhwiTbltiQybJ/+KC/amGexhOtzLY9j1xFOgIOieLlCJ5zvH7Beq5M75eyiUtymGmYaOUDjQ6H7ejgm82x9EUih7eO/AB8GvGpqFFK/XgnFaN2E5kITrXtTQscHzufRyuL66UR56BgFxex8ue+D5nQX6bGLJfz8cZuBg+IGBHLLeNbCPPDtquFO/iR/BhH09Ldf76POVrNyOx3j9pBg/7d61vvuDimma6o0NkFIjg2dH6yNO3rPL1xIQvm7hdw7RU3y2i9ZfI2PBP8OQbfpYqdrYNwifoxxo88tcRqta4qO3+MU3PIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(2906002)(9686003)(82960400001)(26005)(7696005)(6506007)(122000001)(4326008)(66446008)(64756008)(66476007)(66946007)(8676002)(76116006)(316002)(66556008)(38070700005)(38100700002)(110136005)(8936002)(5660300002)(7416002)(52536014)(83380400001)(54906003)(55016003)(508600001)(186003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gey1IZQN1+MC3OVU9NgdkdKtj8oUUTGcB00f1mdrKRX5T2RpeKqMKbMGzeUy?=
 =?us-ascii?Q?G6oa52y++Al233aNhi+gST3rvEEOBvbYwmke0jb78DGwoQJjP0K/LseIGgQk?=
 =?us-ascii?Q?nv60SMqnycBAd1Ow/43C+PXpVeNFf1W4ecsigWAc34mBaU0rXr3cWrMNwFMO?=
 =?us-ascii?Q?5GpEcdJa/i8FeOS7qO5m4T3jupqOJcsg66o3ktiHJKCojmKwvaOw+sQ/QOId?=
 =?us-ascii?Q?1j25TcqQTJKu4GvCBO6Mw3g9mUOzFwmjcTEAitLMscz/mLZUPjtgjNRC7N3S?=
 =?us-ascii?Q?0QRwK1X5qqO/kUCFv6y0xocOIBHYQyr7FJnlwRlRoGoF9mocb72HnGa+8i0n?=
 =?us-ascii?Q?mzpf635wrxUFqDV5DAKroFsJnZZyFHBDuVq2Gi16znr88+BIvzC7/upxV7eq?=
 =?us-ascii?Q?mkSC9g9MfRNC1EOkbAXJW8iJwd+k2dQVkTniMdEF97KO/fikJ/ZchFSfSCEE?=
 =?us-ascii?Q?NaSpqYVTNa/sEM1+0lAFD6GRsXLAy0WaE4fBj7jzjfxl6hsmG6tF45gsYwr9?=
 =?us-ascii?Q?75oRgYSyEizljyaxy7ekvm52LftRU3p25ql37fmuxOhahhzpn+NuCElQTzyZ?=
 =?us-ascii?Q?Ri80PkKFuRM6422I5Jy2s7mc+IEI1Fd6dZbBvZGVl7XZxtKi1GlGuDYQ7W1Y?=
 =?us-ascii?Q?hHEsLk7uNYF5xa2neSGJ24enbs+eoCgP3mSlW7NdFjJtgJ83cQw/VtM1sjRr?=
 =?us-ascii?Q?YqMkU1ApnhtTi3dx4QwnLveCvnGk60kesTTgzop6Za6DvaN8pDqQRs2bMk2p?=
 =?us-ascii?Q?YBaNi4ouotHrPWa/KdJs0D/sXPCso2OqawwXvrv6q9wa/66pmcOJQOvghsuS?=
 =?us-ascii?Q?S4Pi+82J8lxO+2RLYXJQxqP8lBv5bwwvZq2gkIHoKHmrYyJaMSwrOaVsmJtO?=
 =?us-ascii?Q?q9PAqnCmzVvJdF9IlyyjFYxzZ+22/bg25Rf493ftweFMYgaVQfXCRD4FY6IQ?=
 =?us-ascii?Q?dOMFRVrbjE6q6phrEB/nym2VqkVIKVKrScdWLspWoFY40sUUrdIaUmraoYdh?=
 =?us-ascii?Q?UXnv4UcTb52a92jMW4jc3rTTlxxfeTnpLEubiCNMfftRItfDWFk098nRI0Ym?=
 =?us-ascii?Q?JHLfho4p5DTkiucpVoa9m/kw8J9r7kUbehipnRP/MKofsfJDKyEvC8tzld74?=
 =?us-ascii?Q?nSEdxWM1Yq9T+FLIXv/7rbfyjRd3dqtDzyjEuMgfa3er9lChmIh2cF/2jIPm?=
 =?us-ascii?Q?Rqo5OilQm8EPdGjRAwFj3FlE5ZpOmnHzNr43R/VS2S6kfrJ4WcGZPmkMtjtP?=
 =?us-ascii?Q?1DOcreyxF8SVMwXiJ1MKKKSxnmo+J6lCyYwNefHAJsVyRazOLPu3gx5vzV7D?=
 =?us-ascii?Q?G4Jx+7XJeaTHbfGRCJWgQ7bu8e4o3a0CMtjQmymunxMpHkkcE0RNfbaTYNxw?=
 =?us-ascii?Q?Y+lBEInnP9EZJiDsbtP7ihNiaytH1O6hCY5syxK0/+YmuL0EcyaRXHO7Flug?=
 =?us-ascii?Q?HKT0SclH4Kssvm6hqsPqiQRSmxW+6R1pfpvvemQEu2Ifs5plZE+SBLEMQdYx?=
 =?us-ascii?Q?vyM7GjT0wQltsaQ846eZ3jObhBaLdIbMOR/znz5BWswdyaNF6/VPIoNwFTKG?=
 =?us-ascii?Q?+cgiJP8qWhwiktYZIlDoepYVmduLg66dOEh82OYqUAu6bUsZ0o9XhbRax/n4?=
 =?us-ascii?Q?A/r6sin7o5ltr5ICz0d+f+3Pl0jJlSHAxHrArnmS05csc31T0lsKPf3I9kFs?=
 =?us-ascii?Q?woiNN2rsj19ChLwH/RtfGJrIB0YJDCHVbBL/r1XhQHO9imKPxXxaN2Se7g6+?=
 =?us-ascii?Q?l5BzMBn+eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4670ad3-cbcb-4037-ddf3-08da1c518e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 06:56:23.5892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyEy5yTCA+0XwSnGdO4OVw8LNCLT1P1DZrNGZT3IG3AzmCsqJmjt7HZ+0mqQ8lIWryahRqlu6ms9GR42+ZFL6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3758
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

s/graps/grabs

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

btw given the actually intention of above structures does it make more
sense to s/iommu_sva_ioas/iommu_sva/ and s/iommu_sva/iommu_sva_bond?

Thanks
Kevin
