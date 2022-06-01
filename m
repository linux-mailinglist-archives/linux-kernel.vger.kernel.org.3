Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939BB53A028
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350084AbiFAJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245604AbiFAJSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:18:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C512ACF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654075096; x=1685611096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NPHIOKO10jdLjDuApQHwXzPRp+IrkCJnhhQaKlHPPaA=;
  b=TBig8dln00HmPfcVSeTeqIPtrqCvervCRXmndLpGSsuh2nHie1MCNpEi
   P05YnFBLjtLgxCoX4oK/zbGIfVKuftF6C0fDDNsLKw11iI1grF4cprrra
   xCQIevrWkJkQwOyzMX3L561hFE45dx9070e9E1bS+EXbX+b4qlAi5CTcC
   XBZVHDkNPx/Gk+KmGpmvjBDSyo736dW/aR8pZA1nJM+rVoOfhRamJhz7M
   2+GS7WvKNJYvJChthGRgCPkGl0WveSA+te5N2rgtFsnYpsRMh0L792A8I
   RmRn0uWMVr05NhTAUzRgnive9NthbkgPc0j10YQ9z4ER0gVz0JthcVadR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275250518"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275250518"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 02:18:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="576844162"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 01 Jun 2022 02:18:15 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 02:18:14 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 02:18:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 02:18:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 02:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT9iqSO+qEkU1HmPC4crQFVG8x/BiJq/EJWPeIwoQWDvBGQ/aQyJbXc8eWTPxhxxlpB4tPFOyRjhuJ1s4tV7TCIvna+zSV/K3mVIGbobXnuuwObiWFo72qD+6sTWxlPVoo9+cQ7Rw6WXMquxQmR54SrPCnL1Jt4n2L7cuWG8iUbp5LLBX8hRaXHJB5bBUAvfzidypjxaU67MOU89pC/8iv3z1JqLjQCdCI1yFRncnap0XY6tJGmIXLimlh/x1MkLySyr8EdHSFrMZu6mKsZaI6TZHN5cWmSe5//hzCvhRbHAjFXCrq9Flz0RHeu7gax7DTrGC2Q/UtJgmBevZDEt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1npbt59VtASCAeZe71ByvlZJOrgUMca83R1dVcAoPL8=;
 b=k4lsbPmZNhoG3DcJkNaawmNs0iK5wUNh602k8i+gi6pAWpKZI/QQq1YJ7pfOLolgUt9b0dzlbd2fPGoWcH4J6wu8Yui/QerLGFAg+zGNPok74BlDSxwTs8hExWOUsRHPxlNgSA2EfWL5cjvcK0bghy7FTJtBu9j/ZrA7X0hGN0BUi7tz5zkJP9x4uqbxRfeeXb27QvrsXvC3Y3FHet8xhIztxHAh3urV9ETTS+wEi7v6C+QeeQxD82Igov1NjpEde2TYDqvzX2gae46rc3inV/+Z4d8dCqcJdd3GJ99EiAsonvJeVprEKCRYGG80wuqmEkr5rvHf1Jy/KUb+xcCAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB3802.namprd11.prod.outlook.com (2603:10b6:5:143::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 09:18:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a1cb:c445:9900:65c8%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 09:18:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/12] iommu/vt-d: Acquiring lock in pasid manipulation
 helpers
Thread-Topic: [PATCH 07/12] iommu/vt-d: Acquiring lock in pasid manipulation
 helpers
Thread-Index: AQHYcZPNOw1kPwHafku9htaT7Fk6LK06TVEQ
Date:   Wed, 1 Jun 2022 09:18:12 +0000
Message-ID: <BN9PR11MB527639286A5F8BB4C8B4D3028CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-8-baolu.lu@linux.intel.com>
In-Reply-To: <20220527063019.3112905-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea9d36d8-1228-46aa-6c19-08da43afa709
x-ms-traffictypediagnostic: DM6PR11MB3802:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB3802B53E0DFF72700A06D5CD8CDF9@DM6PR11MB3802.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /SCJcJc8h2fa6McslgCV+HhTJvntwlLi06MsSWUNfv68wCoZPrbr82VBYUKJytI2C+rfNMXDzxl7hBgrdvZ3/ZtiEACshwNwVjU+yHTlReg5kcg+pg/jwfZbAcPSjfBzlRgZALXHGCUqydBn2ouRbZHDCAjFhhURRX6+DgW5CTJNA/gde2e7u+m0rLBaoGKyR1b4VM3L1rNfcZ6N6FBe0mLyfjENKEMGOZ4NjF0tw8FvB+qmCztr1tRlfhki0CNdtdIV9/SOl4eBdpY+86kJILVxWm6eZPvRWHVLYuk/KcwSSB4q05VbX8M0tGHjM04EMQdnHXQ7/Ch1iKOIpcP1nYz0OPPkRKiCzW1DkfoAGKgSWb8n1TJdOK00QD1SN66YcmtX53qV5DcXgdT8v2dNh6vLz5gVYLk9h654W5eW72R7woAiK5pPxSo1BswtjQUo7uz4FI3Nfa39m0C/R40u/2Qf6BqFqV955TyMX8T0kkYRNkXDbPj1NpgBWju0sXG/cdYRZjczOgI8sTlxsnx0ThpBZMbM3HZl/1KwkMPlNgQxGnE3CWH3kCVKOrS7IgCIWTBtmLiMSrw7g19VcEsWhCV3WKXEWbLc+NUxQoZ84MxyvjROQKXMCFr3W6q5ZU9YU1bJMn2CsFEJY6+buR2QWoOLgVPbIjoUyiOahIPhRfxeXsOtUPID4GrqS+sLbzyPEv7jt5Rw/yi96KQGYg6ieA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(7696005)(66946007)(4326008)(8676002)(6506007)(76116006)(66476007)(38100700002)(316002)(26005)(9686003)(66446008)(2906002)(64756008)(52536014)(86362001)(8936002)(508600001)(38070700005)(5660300002)(82960400001)(122000001)(71200400001)(33656002)(55016003)(54906003)(4744005)(186003)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1g0bk9jZKAwxk7U5QunI+EaOT5NW8VVaGKrRMLGnNmNJJeqjuBoIv0GQnZ3/?=
 =?us-ascii?Q?2VTUogBZ9Z4EtTJOHd6b1oFzTUsqbLYHvKKfq3WeFGJ6kVXzJQRo68Snghub?=
 =?us-ascii?Q?YVuQEjZUlK2Tg50hPk7II34OU4Gt5tQAgbaKrzSJQwelQJre83u2dSSAXpg5?=
 =?us-ascii?Q?kakvSR0R3m71ySMReTYgjHGygo9qRotj6GsY39kQAEOm/KqMzv7fZuvz5eA7?=
 =?us-ascii?Q?sQDeO1+HImm8lZYIRd91nipP5/0Ml/8Afw3Wqskj7sq+KUi9/iJjf1SKQ/Kn?=
 =?us-ascii?Q?ux/bwgtAODqNOuzPeoiIzIWwYlVvRtRf9SE4Ji8hywtrabMEu+dCmqNSkUCN?=
 =?us-ascii?Q?AsHyScyH+wQk/wDOSkOg6v9b8GUAE5Ifu/oyZR4Qb1fbyU/FCcpJ4f9Q92TB?=
 =?us-ascii?Q?TtmzAfZ2r5jwNATadRKy5R6sb3+HGm6L0pzv7LCuYF7sGVho3//2vRxg+noX?=
 =?us-ascii?Q?tUB14M0Qx/7plkppNXD4HUeAaZ0BaXbNJe1Esl+K95/yYPlUj9czagROVL4j?=
 =?us-ascii?Q?pDZFhwc6ixhPFCAdYynoTf5hXPtLKeZ167WQcvZC8+4devnAH7b4rpnnV+He?=
 =?us-ascii?Q?CoGBS7aTt+vu8GwYLML2mPiUVML7A1xkYpPjcznGoUplGSjaZAk2Tc2lV0yG?=
 =?us-ascii?Q?N7XqcYsLNy730wmnXyaxVx6SZDBqd+R2168exYH4j4nXpsXlQKxFu/x2ril5?=
 =?us-ascii?Q?5bAhH9MRibdaTzOXhWmUsdyB7aXDvBcvQVFPgRuBQaOFvIN8sjKJegCK9nA3?=
 =?us-ascii?Q?6d/hK6OZ675h9jlZc0ox5jF+28HX699PdV+NoI/br9wDKc4S3vWgt04xh6LB?=
 =?us-ascii?Q?JSly3PBJl9PABECiecT+0c6UW+1q6JYNeXSWiTInKc5XL6kzUHLunOK9R6lw?=
 =?us-ascii?Q?8f8JozwoHWUSSnAKLAupgBycJH7jv2gpKu7b6+Jimzfx5k8EtkskEHEZX6x/?=
 =?us-ascii?Q?oxuw700V+M82Lk++4OeKNJD7uASFqwN4ywrh67SVvMaIOG0xdHC1HCEVQUFW?=
 =?us-ascii?Q?HIHTCETY6K9BK1MZtm2I45Em7YMxNG4SCgvvJEZdrdtaMdFP757yFTk1jw2O?=
 =?us-ascii?Q?F8zt0ozWlcAwv04NidvDQeE5MtlKbsjppbJMf5SFvIIkA8urQoamkBYqXL6h?=
 =?us-ascii?Q?zX3nz/LDt6VexawSD3bX9Ipy91wGjO+htZFvMsYbvCSeTz1yadboqOiPI0bE?=
 =?us-ascii?Q?E41vX58YADDs9mvx5khY3YhejEo/mDQ3BWgdNHpmOfkn//S/jZ88DCpGZuMc?=
 =?us-ascii?Q?skoXxXyjBd9Axuikc30Yh+KG8IPAUI5K+5+zRnDgQFV0zap1xb5CijXUJnh9?=
 =?us-ascii?Q?t8eeUj1eTRpyd3FIS1bDbmxMRavfWrdrQ+Fv49XLpRgrGECmKkgpRShHnmYy?=
 =?us-ascii?Q?hCreZVdc1PEynFo3Om/K8/50F/LcMvlxWrBPFzsa5mELTpk3/RhVkPoEeHA6?=
 =?us-ascii?Q?jlLDkBaG1T+yKI5pnePHAE00kNuE8P7tVVLAyzHbUGgXLxkX4GbHCPBywar/?=
 =?us-ascii?Q?0CCduzRR1I8sLrNdObpUQmAdyLYX2oC8vys520rbng2n0LQp87ShBCXdtkO1?=
 =?us-ascii?Q?FpmMHck3lZdkaYuz90Hm/Ry+tqZyjTcPYTtLqokmZ2q53WYdSA32nEZGRZXJ?=
 =?us-ascii?Q?+1CxlOCtnweowqdc9C1J3k2nK+PVOrmHFdi9yppptAwfw8Gqm/ust8b4Tdc3?=
 =?us-ascii?Q?um5IKfWuj1M8HoR5n9c2irJfng6WQF5QF45zE2RAEvCVy/Dtaig3yYMjZzvl?=
 =?us-ascii?Q?kejqEPl7ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9d36d8-1228-46aa-6c19-08da43afa709
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 09:18:12.6940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwoMw3yN8hnb0mAeretAQfy/m5UFHZBel8o5AV4zBNqpt6aih/ZGGA3m/m9Ckprl/2fpdY+OYvssZCjDLUc3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3802
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, May 27, 2022 2:30 PM
>=20
> The iommu->lock is used to protect the per-IOMMU pasid directory table
> and pasid table. Move the spinlock acquisition/release into the helpers
> to make the code self-contained.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with one nit

>=20
> -	/* Caller must ensure PASID entry is not in use. */
> -	if (pasid_pte_is_present(pte))
> -		return -EBUSY;
> +	spin_lock(&iommu->lock);
> +	pte =3D get_non_present_pasid_entry(dev, pasid);
> +	if (!pte) {
> +		spin_unlock(&iommu->lock);
> +		return -ENODEV;
> +	}

I don't think above is a good abstraction and it changes the error
code for an present entry from -EBUSY to -ENODEV.

