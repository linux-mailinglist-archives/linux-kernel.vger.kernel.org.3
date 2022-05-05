Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA151BADA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350238AbiEEIr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbiEEIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:47:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB84A3F8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651740255; x=1683276255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nyOxrnKSsb8D2vUrfvgYB0CHdeODgzBZTeMepGS9V4Q=;
  b=Y87DVgtEeQ1ep+ZwHXWDKVgEftV0zVT/5yGsJideN995Ll0bURoh/P8U
   SZQWmCfkxVRAY72J774I+X5etixpxDPo/30AbIbzK8i7TcxzjDX0hkLaH
   nYA6cyFPqvKNlk/HrGF6GFdhIPpoRyTU+JZCYlbD89i9ELmDUOcGGoaI3
   Co/EnuqA9Ag62DnpURD/RQCOSRT+0yDUAczrdTFhGZ5W3IYIPJWbO3C4G
   ktDokzMAR5Ir6g+P2x/RtLcQGzOtGM//nvG3x+KpSl9/zykvKZNPF5feg
   4jPW6Xh1jZ3u4tY2dbvV0apiKdzcOPurxEMUeRkdZ+DjKOXH+TvV9KB5P
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="354479316"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="354479316"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 01:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="563142438"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 05 May 2022 01:44:15 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 01:44:14 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 01:44:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 01:44:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 01:44:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXckRYOXxje/hzijXxQdO/6Ccj0fL1DHxxZqb0cprvVwI+8cweOdfKbkFjYVEYaFy1z1pq149vI44hDGrnOqxqGxFl/54Uf3clC/B26UhgdhlGxBTajbgya+Fhs3LzVB62wElv3UyMIDELVoEB+CYsE4L1xuqIPQkxzAqXCKfPrxEoSDCcOxOUl/11XpdEFNLPwYyaaRyx3ChulrpRaq1Jwj0LHPwyV6zGSTyW87Q1lcz7GMeQ++Yx9SP3Gn/SYa427tiNmj146PsEHL36XffLBb6PBuZP3nlD6SBP9T7vDg8sjOu16AzY/SemoXpOBDohNZJPkt+YzQ6z9bH2/EPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3STPaUBQOH5C+wnLBQs5gxk3fU94b9jKTKaXAM7cxi4=;
 b=DIQfa4gniZ6IwFm+asaKFp4+l5Nzaol/bK/3/HKwdYhGxmBysLkUTv/HW+K3DxfVaN1itPMaflIHxSxDGKj7NEyuDGuSov0T2EqAmGt3C0vAz9jsVPZgw/O8gq+NT7xia708mnCvYoPd0U0FpprSR038A827GicM9QMykk2xrMVakYzSFA3ILLcIqQ04gQR2gubGIxcsUgCv0KjT56PCdGjomU3rkTiwkC/zrGkPCYRvsYIVCoMRKfvAWNtV2Zs40BbYizlihbqgCfqxTzSwL/vXoEhD/7WT/IsE7vbLr+60VpoXYk4MXw/Qs7sgfymXT30Wus5IRHQ/337/HHDRzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM5PR11MB1561.namprd11.prod.outlook.com (2603:10b6:4:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 08:44:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 08:44:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] iommu/vt-d: Remove domain_update_iommu_snooping()
Thread-Topic: [PATCH v2 3/4] iommu/vt-d: Remove domain_update_iommu_snooping()
Thread-Index: AQHYYBzuLf036VjEZUK0JdsDPbzL0q0P+EZw
Date:   Thu, 5 May 2022 08:44:12 +0000
Message-ID: <BN9PR11MB5276C0D4628F568C2C0CAD148CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
 <20220505010710.1477739-4-baolu.lu@linux.intel.com>
In-Reply-To: <20220505010710.1477739-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7454baf7-a2ed-45b9-f887-08da2e736df1
x-ms-traffictypediagnostic: DM5PR11MB1561:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1561D97582ED489FADE121EA8CC29@DM5PR11MB1561.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+O6IgCiIrNpfWli/1d9Kyfr/fWhFjAadc4XgJYTzTm0Smy6yPIrWbaU75oTw3IuP1/GrIbndcnjoL6ffYdtm6p8c+nBSXpbGmZM7AGKNaCYd91YKGIf8EMM4+DEArVwBeft+dtFem6X8FfEJxymRcc8nnP8APzaOV9MAipUz7Psay0fY/sclp/fDSYcEQ4I+lQpX+2L4bW4xYjA9Jd0AeT/0FallY9wvLZFf1ApVs9DXyCNZtHTx17iCWaYWpgaQDEkEEtbT7uEcZgpknQtP4aWA1XDfFiTJs5mrH9Tr1yVuI6p2qoBQh7vLzOGK25D7gGjcZV7PRKf5w8diQAdHBr7gvn8ql2r7PelT8C/XDakV1+FSjEVdsupZsZ/6HEwFh27fJxsPZVO3nW8Ah5oq2KO+yA/hKtevZRm2U3GsCLS5Phlq2RsEk0kDgvZKuYQxz781rCifnl+PBg9k9w9sVX8XXJWr2j6C4wcBDlh2iiQ/IbeZGG85TgYRhFqXZe54CUiLmQp3GNl7deIYYeIKKFxFILQTqovHHNvrjZ2U//hnjvxmtX6lVjxjJO52If9hQ7nl+z2AxPTxPZ6J5F4v6ks3eEE3SpxeflONwOYPD9ip5noK0/6qd/HBl7o6rWEbWihi/YrAeUefqm3UsTHuna83WY6x9TfjDEkkTJJNY+q+FotJmitVwfoDzpXRqCDsfwwC2g4+92Acj7sQGL1YQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(33656002)(83380400001)(316002)(64756008)(66446008)(5660300002)(66476007)(66946007)(4326008)(76116006)(8676002)(71200400001)(66556008)(110136005)(508600001)(54906003)(8936002)(52536014)(186003)(6506007)(7696005)(26005)(9686003)(38070700005)(86362001)(38100700002)(55016003)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YCegv1S6A0zzdO0BGFoD8+I8Og20j1angbvlIQ67p86S5eElZ37/7yrKtFge?=
 =?us-ascii?Q?rrIX2EFGZ1jygx3y+unAZKALEh6FO95LTV1fS419YXzQQBxrQgwPrHRq9dcD?=
 =?us-ascii?Q?oQh7wcLsp29pMjFSzB+FQwdHw+E5p9l3U0lqQYHh67aoIvCSFUptBN+iEJ1V?=
 =?us-ascii?Q?Rir+91xFJxwRhK1BtdqOKZJs24jaOIUod6+WgNv+IpIF0S3Ol6daESJHfut9?=
 =?us-ascii?Q?XD1Xaoj7RVW4l8f3I9hHP+BoSyjxRfnGLYsh9PTgRLw4752OEMPVAT53z8Lz?=
 =?us-ascii?Q?P778sq9F+qikZTdfOHF0QynzXDI1icj9R38fqqmpRYJ1y00sE8sNiCmdwkB/?=
 =?us-ascii?Q?H+E7HVr1uY0Vf1T3beLRq3JFk2f2Nqiqn1iDiJmYEPjxg2wdKPotgd+OFYrx?=
 =?us-ascii?Q?vRKIgg+/ptVRGsVy0qVXq0kHo4OnBUcvHGBUPRbPv9r++j35O5UMI8U78BXt?=
 =?us-ascii?Q?GZERPGONpHp/f1YLZRaCkbCJiiFymJlZdjCHmhcQ0zm3mESEpaPlNtYOhgd2?=
 =?us-ascii?Q?sbOv6vpDXuT/VrzULmrIbK+STwZ5BFrsduq4I7H2uvnDurSKluoWElyXWnqy?=
 =?us-ascii?Q?FAHqeTvWrgrXZJh0HlRBbDaFj6Kt7aPK1OehRdlSQOhCCmCJZ1bt+afIdSbX?=
 =?us-ascii?Q?idJsNRNoRMKNT3GBemAqKdwB8W/HJIbF1l9nf2td0m8WtNUAuq2PByihG+zl?=
 =?us-ascii?Q?GsUwb4+VaRjtkIs98r295zHQ0PDKH85i3eLLLYKMZpdMvASGNtwCWYR44/k9?=
 =?us-ascii?Q?rfFgXsnEzrM8lMWAIGsRWu8ztGg97r/wf/NTF2hDNs1vK3CDk4rQEMBmFxlc?=
 =?us-ascii?Q?RVhXtKdiFj5nKcJNEuCaENKCmWCnvZ8/42ww+feq8ibm7V94UFtVSv5mqJqv?=
 =?us-ascii?Q?jQDeJq+rPrIdthz1QEN31lvFfSScql42XQXi01Jy8WJVSmTkCCBkOf6BXJQp?=
 =?us-ascii?Q?sOYmMOO8A0E0S0ikxlVLVFgdx6Y9N5OLg4aDAjz9XONdLRoQuXrbhPiEwaV+?=
 =?us-ascii?Q?zkQctR01TRpo/mVYssVm6ytdKxZuU5jopMH21+A987e/b3evwnsAei/NadfT?=
 =?us-ascii?Q?F2QO+2Ggnf+H50g0NJSYRRlXX3ExtTlQ4jryZhcyBfODdlXb3V5SqJo+lrQL?=
 =?us-ascii?Q?wWpRvBG6m4liSLqlitYpTcqZzoLuj21crfj+p4w8hudAt3SPKPWS/QanUTml?=
 =?us-ascii?Q?ZBicZV2NRBYdPaH6VoATA+z4ANkTINdjcq9f0tBpDq9F/Ee3YNBPX711HMsm?=
 =?us-ascii?Q?RIB/z0c8954XC99SVpOWlq4w/6APzEmUEf4XnJYsaqHCNdQOW5+f7IPUiV13?=
 =?us-ascii?Q?PeTl2xk+2e8YK7qGyoUYyMcka52U8oTvOYdRNvMWYaDGB2T7bXYwe774sLo9?=
 =?us-ascii?Q?z4ZZsC/LNljFMfLvXv1hKvhoAuaav3NfIwmJHlL7l1h7Va8iZb0JmemuKY/c?=
 =?us-ascii?Q?fAaNfLb0YlPJS+ykjsLkpxpFvZo9Y1wtxcPiNfi+eAoD5v+oRvSVdIgnS/i4?=
 =?us-ascii?Q?gWOkgO9/sfdwKPJchC/G24IRtc+pSRGkIfpC0qqsLpdkJb+c92emDcb/PE/8?=
 =?us-ascii?Q?t1576EKS2f4WqMSSRJ/s6ua074lgOlN/EaM8nDBzCX+MrtKZs4Q1MgJdpN+n?=
 =?us-ascii?Q?SFS7od+zKMbLqM1QAASkSr5jbmNmrrEotd6qjcCX4Bfjjw8cDBngOTHjH0Bc?=
 =?us-ascii?Q?uUsial4BV7+rv6ZmN8U1SfwJUAYMCyDd+BAM2N8J4JxOFxaeihp8V9YLHjH5?=
 =?us-ascii?Q?KmNPPQflFw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7454baf7-a2ed-45b9-f887-08da2e736df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 08:44:12.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hN5Fo9AXmnLhbXUmvMpfpsyCOeNimqEyp0TDOcxLzflt2We+AuYWCPPddOZ6ryI/3T6LrKiavttyHZaIZ/QT7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 5, 2022 9:07 AM
>=20
> The IOMMU force snooping capability is not required to be consistent
> among all the IOMMUs anymore. Remove force snooping capability check
> in the IOMMU hot-add path and domain_update_iommu_snooping()
> becomes
> a dead code now.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/intel/iommu.c | 34 +---------------------------------
>  1 file changed, 1 insertion(+), 33 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 98112228ae93..da4bfb34ae4b 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -533,33 +533,6 @@ static void
> domain_update_iommu_coherency(struct dmar_domain *domain)
>  	rcu_read_unlock();
>  }
>=20
> -static bool domain_update_iommu_snooping(struct intel_iommu *skip)
> -{
> -	struct dmar_drhd_unit *drhd;
> -	struct intel_iommu *iommu;
> -	bool ret =3D true;
> -
> -	rcu_read_lock();
> -	for_each_active_iommu(iommu, drhd) {
> -		if (iommu !=3D skip) {
> -			/*
> -			 * If the hardware is operating in the scalable mode,
> -			 * the snooping control is always supported since we
> -			 * always set PASID-table-entry.PGSNP bit if the
> domain
> -			 * is managed outside (UNMANAGED).
> -			 */
> -			if (!sm_supported(iommu) &&
> -			    !ecap_sc_support(iommu->ecap)) {
> -				ret =3D false;
> -				break;
> -			}
> -		}
> -	}
> -	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
>  static int domain_update_iommu_superpage(struct dmar_domain *domain,
>  					 struct intel_iommu *skip)
>  {
> @@ -3593,12 +3566,7 @@ static int intel_iommu_add(struct
> dmar_drhd_unit *dmaru)
>  			iommu->name);
>  		return -ENXIO;
>  	}
> -	if (!ecap_sc_support(iommu->ecap) &&
> -	    domain_update_iommu_snooping(iommu)) {
> -		pr_warn("%s: Doesn't support snooping.\n",
> -			iommu->name);
> -		return -ENXIO;
> -	}
> +
>  	sp =3D domain_update_iommu_superpage(NULL, iommu) - 1;
>  	if (sp >=3D 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
>  		pr_warn("%s: Doesn't support large page.\n",
> --
> 2.25.1

