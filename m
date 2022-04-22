Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA52550AE16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443579AbiDVCu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443551AbiDVCul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:50:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE24CD55
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650595663; x=1682131663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SYH5aOKVpbF+qSxADbQNlGUcMR53GAWT+9ShWtgjRCQ=;
  b=akblmXQC10IFp7kREX4e2AWrvEvohWUEx6cZdcDr4gkW/PxX6flQoRSx
   mNesON57eAhbO7SwVGt54mJFwtYwhMnD/+YmYvDHz/DmJRNgMJ3yOgazY
   IHJVlFi8PG7aXWK/XiJYKU/ntgPLctVV1AOz6PxsXZBqN9jIPoEXhSjlK
   gsVgwWJHqEQXkXhzckL7osvzPVpbDGdNv3hHPCxLipJSPSlp3zgt6t/Hz
   CasudEdsYFsBeO4OVAtRLBHbmY4onVXu6ki13nNxk/cMBmL35iIIIGTYS
   Tk4rmcJUiTj2j8RMVWwWH12997d8zQ1kw2GEIUfjVYzElMsIV9n/ah0Hi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289667334"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="289667334"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 19:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="533904899"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2022 19:47:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 19:47:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 19:47:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 19:47:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpcdtHgUlDbtiMRaRx7msQfD1OkSrB23+qY7Y8+YE6CEBO32kZLv/5gZPkDuhXY05hL/ptcX+mBIr5+W3dozZqxWJqw3Dosz75tNXyFIXNRgN+J+9DM871aiAKlz33OJ+QYp6FLq/3+fzmCoCYmfJvGGYi2849AqlolI/NV+emyjLQ15/8/WDAx57xAcdKooSbn2qfh0xWkYojGpmLgyE9jmg0sxOpPi4xzduokcy7po7AKZXRxTo4Jph8t5iuV0L9Gl4H07lDE3AY5RvCR6QCmqPuyf+OOACPByaF+msQe0XQr3nPchAZK4YmXy0JyVwnwcVIx34uGE6epMoB4vvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NymsNYJoiT1Khmb8fWirGvKTJELy3NAfJZRiermBwtU=;
 b=bGlgiC5mS0f1SGpyAOHzAKWAUVBDuQt68y97AY72tQG9DHVS71Tx6ycHCQ5RmBkHT8qsuxBq5+CNTe/0ZovqL6jezkC9Lhtk7OcPZ9pBW0o8GHR08tsHdjLaDKp2km+vLgwVKOybQkY1hrb9XL3uQLTuKQYoem0xi8ZEDzefwbqUINIC6UU2mzI88tJkxU6VraE0oCIzuFvaNOB2fv5MCGS+TAS3q2/9ujsh40AaWW0NP+VnUOAkJWft1tNWJjm9PWyChExtk9oZijwXmJFsLuI/zg7ywfNgI+HZHn4dHYsf36sbdHLr7kr2gv0lmN1eDuzL4WEUW7C43H7nz/ydlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5937.namprd11.prod.outlook.com (2603:10b6:a03:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 02:47:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 02:47:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Topic: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Thread-Index: AQHYVXRiJweT3/DMakGQhv0qzMieEqz7Od6w
Date:   Fri, 22 Apr 2022 02:47:40 +0000
Message-ID: <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220421113558.3504874-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c94ddc82-6e0a-4d50-097f-08da240a77a5
x-ms-traffictypediagnostic: SJ0PR11MB5937:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB59379BD440121A6BA433AF0D8CF79@SJ0PR11MB5937.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /D4Ze9fJSxP/+LgGurzTP+3K09ithY8HIN4liCrDFVsRjRYXYuKtbufznxr+tqfig3hnRVZ9fjCkqdl9k5+3MOBdYT9rRcEe3VaOeY9wTl3IHWUx8Z6sV9UPv4rYGyMWgCBDZeQYe9bAG6GoC79ZQvH1Ut1+6d+8D7X7Y+tA/wXawwUgKKE3MCeWwxkXJgsf28kmPr2locTtHto/ZvzJEFjRGMCmtDi+jBkw9UFpZWRRt/Hfy70mwyVeA8Fe5SsqwRfb8eLjod00/PpmH2UGaVIdajrz66Rp+6tAyfvXKATb0KETPeBxi5I6zw3wV2xtgj+AApvuzw0SN9KrCaWE2H2nnix8XGFCYPJTU6X3J/AFeeqE9b1YxCKnD1vf+U8FPk/6qOxK3JO3AqP6PnjsGvXaY9wIzC4VLCLBCYxa0tyTlWIx7dbr//USXny15vIGE8RvGvt2sCCESmsCjGITjp747ziac27BaWETRkDIR7YHptken/xCXRIH91Z+RnGNJojMBnhjGtaiJHqDKU6S5JZ02ZAOTY5fett8YUx1a/WoD0/sC9BQWxmn+cIzSU4Cpqa4WcoaoDYFWNe0/LmkT2dn1Mhkp4Ix/wrk+jWsG0Hn6+B4ZPjn+Wj9No1esxLWy0m3i7Y+MlFOgvxURQuANYRRIpMO+/kL8zo1L+JKPzOjtFeZKf82GJmksqSIUweq4FQA3kd6NvZOXyki3NfBydxvUNCzGwd8QlOiSly+oek=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(76116006)(2906002)(33656002)(186003)(110136005)(6636002)(316002)(26005)(508600001)(71200400001)(6506007)(9686003)(54906003)(7696005)(8676002)(64756008)(122000001)(66556008)(66946007)(38070700005)(38100700002)(55016003)(82960400001)(5660300002)(52536014)(83380400001)(86362001)(66476007)(8936002)(66446008)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pOCOxk6KuhHmWBY7mzLAeRmn/ak/p/08AoTRlrO0y7QUHbmk95sszqT8Vxhj?=
 =?us-ascii?Q?sfZxGdVOaxFSZrFvvP6Js5kw0ECfHbuIKMH17IOOwlvlwzb/4Z0f+iedJ6c6?=
 =?us-ascii?Q?D6ok68QeC7Q8q4G0Nkx6y1Thia/X8FYIYa6c1Y+m1H627AfjeZJ6+Xct+PuB?=
 =?us-ascii?Q?iq3QsAYQEdvOBR9Yc95G+xgicwPVP+mMGp+d/gzdDeg0h6xpc3BVQOWZ41ex?=
 =?us-ascii?Q?A7acnvucc0Z13vI4SWbEQV25dCHOQo0A1zQIhVbn1eLwdMsVJY0v4yNjlhWs?=
 =?us-ascii?Q?eKyoMqtIzSmFPkloCr7GV0xG+hmuloKy0d3OMJP/KUOHYiyy9VqMXmHEPBeJ?=
 =?us-ascii?Q?5uhAYTDk/7q4HrQhS8zrnyh2G92FRVwIDdTcJjfGMlNgfHJA2lT2Hzpq91p/?=
 =?us-ascii?Q?RrjjKu6KFIHqD9mrRRAUFXs2I8IwwYvANve7ILdkbwzHRMV/wy3NKps2U7c9?=
 =?us-ascii?Q?w/m+P5VdUo7KMuEn8qpP1f1hKZaRU5Y9XccsSIOGb+2CF/gFcue42RIRmDLN?=
 =?us-ascii?Q?CkvXn7vLAPrFqlemsjuNJUs8XeOGRLYguyvIW/bVWha6fW57aYn0/BbKYNGe?=
 =?us-ascii?Q?KFLSkqGjks7S4eB/+EG51axjanQd7jXwWNsbopOj65/hlLGTVQg0yo4upT5j?=
 =?us-ascii?Q?Bti6dGg8V+HNLHXdMAfl+sh3lHs7m/Y9o9A2l+usthWCgZm9TLAOx/2EP4Rv?=
 =?us-ascii?Q?Dm9GpeeIXv023Pq/vKgs4WoL8vbpWEq3Gf6zNOgWvlcJnhm7MXyzBe0iHixz?=
 =?us-ascii?Q?XTyMBuIQzWl8lZTdgag7rLJn2hubKwT299f6MVIwJvRHCrwfQ6uoDJoenPez?=
 =?us-ascii?Q?cGzohz/ALLOXkGReZFfQdwlTioVYY8BTEnuw3Vb2meeUCbkSdsQUTuK/eq4S?=
 =?us-ascii?Q?GGLEbMlbSFXXW8nz88/pI1GrsotT1FoXjLE/wEltV8qFZnHW9Gv9dyjmUKZO?=
 =?us-ascii?Q?EZLAKhtxK+Y0h2pSldDTm24k3vydfTEbFofZ62uWFCL5gdoKPArunZhe1oIk?=
 =?us-ascii?Q?vxZjItmU6HOmSTZvLEdZjpdg3hhllmRd5fSixNARQyvlx69l54hnQAM4EsMy?=
 =?us-ascii?Q?Va+4aZtBZPOt/cpWkIejbCCrS9u5OTt//4ddG79+Zy7py94JS2NPy0urD6l5?=
 =?us-ascii?Q?GYky/vlTZrATqZnEq2lMFGmg2yq8x+SPiLy02X6EvuNb1nUO2J/1ZPd3pREV?=
 =?us-ascii?Q?JsTHU3DS5oK0RULrMCPxdRvwkleNmy2ZwqohRW64y4pfG6UY+CbouaenV2Ic?=
 =?us-ascii?Q?FzB3oLBD+PcqjFQuAiqZValJUw65PRf/h1ve4EompK9bJZ8xCzuSfiMywL33?=
 =?us-ascii?Q?/yU8o7usbq+1pXUjcz8pnmimINSN9swxZyWYkakxDhVxg5YL92k7s5j3YC0a?=
 =?us-ascii?Q?SyHzuUYT9BnM/Y2YsqicFbK2DQxJCPI4Wq5M5a9Seaa5+BqmDCKHpMpS21XO?=
 =?us-ascii?Q?NwNITN9I5S6t9HNWKUsgq+iTVnyvoZVW84wy3bQpfOemGQPBibDkEjOh9SFb?=
 =?us-ascii?Q?/VonXT9wIL/wHKUz9dNdqVoh9JTueU12kJoUuVftlWW1s1S8Zcj5SGNbstny?=
 =?us-ascii?Q?lTGiCr9BssOpar272v8b9ixqwMy0dtQWflR10gOM6/DX7mTHF727R5nJb9oI?=
 =?us-ascii?Q?XmoEA9gkMG75YMzX3LbI/0kV/YNPXitT7im0XDC0KyDJaClg4J13eUHGwXj6?=
 =?us-ascii?Q?SoHAGEQFhpK6UZd9+p2kNESoDcGlQmggxIepYJWG10jk47vDyEgsOTcXjNcG?=
 =?us-ascii?Q?+/JE48kAYw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94ddc82-6e0a-4d50-097f-08da240a77a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 02:47:40.1611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LKoVKTX1FXFFW1IvOHrF/dsqKBfV1ah14A+3RMR9zbaEAeyNohG77uFoy1W+lar1UHy3MP11G6sH8qE8z4fXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5937
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu
> Sent: Thursday, April 21, 2022 7:36 PM
>=20
> The latest VT-d specification states that the PGSNP field in the pasid
> table entry should be treated as Reserved(0) for implementations not
> supporting Snoop Control (SC=3D0 in the Extended Capability Register).
> This adds a check before setting the field.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index f8d215d85695..5cb2daa2b8cb 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -625,8 +625,14 @@ int intel_pasid_setup_first_level(struct intel_iommu
> *iommu,
>  		}
>  	}
>=20
> -	if (flags & PASID_FLAG_PAGE_SNOOP)
> -		pasid_set_pgsnp(pte);
> +	if (flags & PASID_FLAG_PAGE_SNOOP) {
> +		if (ecap_sc_support(iommu->ecap)) {
> +			pasid_set_pgsnp(pte);
> +		} else {
> +			pasid_clear_entry(pte);
> +			return -EINVAL;
> +		}
> +	}
>=20
>  	pasid_set_domain_id(pte, did);
>  	pasid_set_address_width(pte, iommu->agaw);
> @@ -710,7 +716,8 @@ int intel_pasid_setup_second_level(struct
> intel_iommu *iommu,
>  	pasid_set_fault_enable(pte);
>  	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>=20
> -	if (domain->domain.type =3D=3D IOMMU_DOMAIN_UNMANAGED)
> +	if (ecap_sc_support(iommu->ecap) &&
> +	    domain->domain.type =3D=3D IOMMU_DOMAIN_UNMANAGED)
>  		pasid_set_pgsnp(pte);
>=20

This should be rebased on top of Jason's enforce coherency series
instead of blindly setting it. No matter whether it's legacy mode
where we set SNP in PTE or scalable mode where we set PGSNP
in PASID entry for entire page table, the trigger point should be
same i.e. when someone calls enforce_cache_coherency().

Thanks
Kevin
