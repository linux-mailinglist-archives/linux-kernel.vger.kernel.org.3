Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1584E20DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbiCUHDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344728AbiCUHDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:03:04 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52542BEF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647846100; x=1679382100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s8T/YllRrK8YCjBQgCqSYLEoGUVKNGvzNoYbMYzqjTY=;
  b=Jj6kzbyacj1IpCB83TTe0BE2WGYJJtVin04yuRGNZL85XRb6uneFyBhG
   MYIkvpdtkD+0A483JA2SZyAlWQPBS0VbySAplw0tCTVz8q+GoVBwutx6O
   iPJNIQsoCJ64sZsitSdB+U9AWRMiCHac8mwA3/b9fzj8NG39aIUzZY6jL
   PKnvcXd7RDP/M152B34+415t450pjOkZZ3xpJPlk9HoMFTHNQ6ukfPEZQ
   iD6aZecV6VE3lOFiNk3vVngnK6WqpGG+p9tj0tbpupDzTMmbrwIFUf0w4
   15VmHgmFrZ1H44ALJj0AlPZ4aCZu9ZIgtx6hMgp65E+rooK3w0PhIuxf6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="318194262"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="318194262"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 00:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="543098751"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 21 Mar 2022 00:01:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 21 Mar 2022 00:01:39 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 00:01:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 21 Mar 2022 00:01:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 00:01:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR5olDYmAqBG0lr4pVSKucQaOkFHIteYiQhsv4c5P2zEzcNBiOVOTghrSt/EVwdHd0EeeHtthqn2FWeZApTYthcoIu1GFuMHP5yQwA7L+6DxVB/r9vMvX8XSOr1mamI5WYJE1nmNaZw4ZBk/iyqsI532G8vjrNyKT/fRlDLsxpm0NmaNTyQ1pGmhyi7c/uooQcG6Oq1eggfOFAnMqx47s5oUfgvXwxna93ZbzY+bofstnO2lQoEez2cpiRolmiKSEztho9/A/xIjPb/Kg2jAheb9uVQDfuBUZZxB8v0+1CBcdVthhn/eB578MmnA+KpJ0mwglkC3Mwn3eOTvIX263A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1hRI4Hf5RQN691abMz8GPjkuaAhUBRzrMF1rn86TUY=;
 b=dFihpoVCHCBcz5yoNOZiJqLBlkKDV9DBvThepFFWSnr4JLpZ4MPKXQL107jWcnasoc+Ss73ElBdQK0cj0FhrRqzVoUF4boo4x6AesLSup4uQkHv6TglZyft69ijL9Cs/SpJCq/lYm7tgZkPM0QT2DDMA7AtzSKlXDV+Hg1t1vtJYW4RwmstV6R6cYCHEOg5ud6QfUi05l4QZzsaak45qJZfaUN8ucNh8EID3ZaxM7IyjhyWZyjuxheyS3IMZz7CHmcQkIIIsrseZUHwmOBUE1XoafzS34MHLmYOG625uc+vK7uf0FAgqfr2cyUft64Zm3XDFVf8IDSnCCoWZ8419SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CH0PR11MB5692.namprd11.prod.outlook.com (2603:10b6:610:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 07:01:37 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96%3]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 07:01:36 +0000
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
Subject: RE: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Thread-Topic: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct
 dev_iommu
Thread-Index: AQHYPCW67tZrDf6F9E+D6qob0d5J2azJabXQ
Date:   Mon, 21 Mar 2022 07:01:36 +0000
Message-ID: <BL1PR11MB527130BAAC3B4F48E4901F5D8C169@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220320064030.2936936-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01b925e3-db81-46cb-bbab-08da0b08a446
x-ms-traffictypediagnostic: CH0PR11MB5692:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH0PR11MB5692EAA230EAA015A60B8F558C169@CH0PR11MB5692.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1fV06VMw0BVR5a85DRV351K42a/UzswADhird+y0dDT1wTlGiI2qgoRq5iOziYuLfppve2r+y2l4wVYuot83LLAgmQ5Jo39fLO25Ig6ZV2pwInWaIGxtnc8jSvsbdzagvEILYnxJuTjarHUF0OKhA8P6S65VDfheTK3YYR+Os5BdGPW60FU8NMS6k2HKUv81kdrLrUzZBuCA5lSxNl6Htffn5lnFBMp6sKox4hQjpau+rJu+YRMgDPVGaz9W5I6xgaSuGU2Id+eAauSUdtcPNVdKv523vxYPg8vevQORhbjlQ6UDWpgSlzvzPA1T6zqM90WZmd4Gs8znuWEemRgMOL52d7a5ju6Vu1KHC11TNA4ponDzH54OLwNvbuAoirOeLm7Qa5LPb2o3r43jKFK9bP1QLLEceakXC63/8yIlVeXEqMurrJhbQYM+J7XhE6BqQOy6eAes70oP8jOMw1tfdOs6+Dy0wwTyymmu1t1p2n121fHuUXfn3IP150RGxVdOQZw0Ai26/9F1YGxpeEOP/omsdF6P5Dwd65biJae82RVuYeaJMj6mhSrYdNM5wQ74xOs4RvVdGkpu03i1TojaMh7/qgX0gorCx9QBdejHfcNZoj6RfDtTRnB58w1YT28tiOjnga+zmvymxavuFFhGp5cNfvr8LzDFQo8vmS22rUb1TGhSIv/rk7grvOWmALbrLD28sRzq7QZEU328EOwMbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(86362001)(26005)(186003)(7416002)(5660300002)(83380400001)(33656002)(316002)(9686003)(7696005)(6506007)(110136005)(2906002)(55016003)(82960400001)(76116006)(66946007)(4326008)(8676002)(66446008)(66476007)(64756008)(66556008)(38100700002)(38070700005)(8936002)(508600001)(52536014)(122000001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0d3kYI0bo8S5VtqKoMnhh0lny6Bk43Bx3tlOfrWMxumjIH+yGOwEreK05STA?=
 =?us-ascii?Q?EJtsCaOZEuoKMfLL/R2XdigECzawUaurELeOrQP6tOPu6adiAUsGaXvGcOGg?=
 =?us-ascii?Q?itsovVfrn/GViXVmpB6SJjfM1ounKGfGKc2i1/sNLNnX7w3d56TO9FEY61Sw?=
 =?us-ascii?Q?dLsEuiMOfN4bCMDzorAQNiwz9Qa6C0V1QIqlL26qeXfbXRunWKf0tMchtRGV?=
 =?us-ascii?Q?pdZ0e1Td3xAzbaqQ31QgKZP4QS5YsPkCgQalwzdGS3t3UZ6FM/GvWnvv5jYR?=
 =?us-ascii?Q?mfJpRuEeNnAhr5ASQum5ef6P/P1YflfY8wOjEzpfYdepIomo2okdMPn3dY1d?=
 =?us-ascii?Q?NLVUcNIEVXgQmmDLVtnrnHx9Yew//Vec01c7UMxEvrCorl6k0Rnjf1YzvosK?=
 =?us-ascii?Q?C3Hc7NF57JfxxZkLlIoy3hpkpPo0aR4WETftGPgdSDXllT7sYB3M8sTCwIOR?=
 =?us-ascii?Q?TUiakGgfOUjetnOPbWIIG6/BPuGWl1ndeVVD9rcDkQ5nZtsZpM3c1wEyqkKM?=
 =?us-ascii?Q?CZmpyEN75IxDJvdWF7Mzu62W6QXEsAuY0trAVZHq64C+xRR9EpD29AoyuhnD?=
 =?us-ascii?Q?j5z4jR12y0VEJENwqV8DuVqWvBHOAfBIi1x1vyR1PIp21gJXDcojm/B9IAGt?=
 =?us-ascii?Q?R4xUjOx1L7n/wsiSUDc45PkIIuMdzTA9BgGS7N3uTOdlxKRp4/mTB+q+0ZJi?=
 =?us-ascii?Q?npNPeRc1/BOpDN0lyv7WbZYs4Zh74QA7X1h4/WinXDsRhCcZxghLC9L6oick?=
 =?us-ascii?Q?AtSHNkgNVuOyERsTZ71CE9dXoMfjM3LbeO5gCOM79jhe+J7SOpMFXVrO/leN?=
 =?us-ascii?Q?N/3DT0Qbvms+Q56Judo0//Cjo0u//fQWd7uIC/V1o1sfCxjmNiwf0+ry5s2x?=
 =?us-ascii?Q?+h6FBxaKQYhUrcj/ZLvWQ1z3/7MqBxABUJA1Fg33SR5qDi6zWGR40meJvtk4?=
 =?us-ascii?Q?az/t8UdRtjiGCNVJWAtlDS4UJMjU/N7tqWSyjKc59YLa1ou+8WtRrCKvCAef?=
 =?us-ascii?Q?ShLKQnoSc3hzWG0etpYgM4C6zrgLo+HAbtMWwv732K38XNDJg4As0rxoUQQs?=
 =?us-ascii?Q?2lVzupsijMXsuBwKuhAl28TwsW1Bb+dokxz2vltko9rkw6UN10+EoU9W74J4?=
 =?us-ascii?Q?C0jfuwBepXXgRhmrOr1h4ZPtkLF/Rwd4tsX7jrYUMdHxFFOqCEWsgH7CkWPH?=
 =?us-ascii?Q?uxudHbb/bIBoYD8Ki2B19CD/IwaPJicPPk6KLfWWqxwZxccJ+cvyPMKARz9v?=
 =?us-ascii?Q?ZrCyqwXd4xh8uWNn+UjMOE9VH4OXih/M+x3wYO6x2KmAR0sLlqMDR2BTyTY+?=
 =?us-ascii?Q?bPy+Z+RnniKqWTrjaF7zoPWPaZRflK5QtL6NhbLFElsyXV/mavI0qliSalxD?=
 =?us-ascii?Q?yR/x/eC4WFh6+ZXY1TwPp4BVTQp64d+W/TGDqjbYTMrYfw3/VxUBQDsNST5Z?=
 =?us-ascii?Q?BFGDxzd4gmMD7gXmmQdvTnH2863xrk2U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b925e3-db81-46cb-bbab-08da0b08a446
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 07:01:36.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCWjZG/ZGNJ6Lq9Nz6uAPKvaIZLxRSu2JLFtAcXsU3rMmV6MsIQwkwA9i7YSEKMEM8fMFhYenQ2NjVemTR55fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5692
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, March 20, 2022 2:40 PM
>=20
> Use this field to save the pasid/ssid bits that a device is able to
> support with its IOMMU hardware. It is a generic attribute of a device
> and lifting it into the per-device dev_iommu struct makes it possible
> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver which suports PASID related features should set this
> field before features are enabled on the devices.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h                       | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  drivers/iommu/intel/iommu.c                 | 5 ++++-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 6ef2df258673..36f43af0af53 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -368,6 +368,7 @@ struct dev_iommu {
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> +	unsigned int			pasid_bits;
>  };
>=20
>  int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..8e262210b5ad 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2812,6 +2812,7 @@ static int arm_smmu_dev_enable_feature(struct
> device *dev,
>  		master->iopf_enabled =3D true;
>  		return 0;
>  	case IOMMU_DEV_FEAT_SVA:
> +		dev->iommu->pasid_bits =3D master->ssid_bits;
>  		return arm_smmu_master_enable_sva(master);
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6f7485c44a4b..c1b91bce1530 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4587,8 +4587,11 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>  			if (pasid_supported(iommu)) {
>  				int features =3D pci_pasid_features(pdev);
>=20
> -				if (features >=3D 0)
> +				if (features >=3D 0) {
>  					info->pasid_supported =3D features | 1;
> +					dev->iommu->pasid_bits =3D
> +						fls(pci_max_pasids(pdev)) - 1;

Original intel_svm_alloc_pasid() covers both PCI and non-PCI devices:

	ioasid_t max_pasid =3D dev_is_pci(dev) ?
		pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;

though I'm not sure whether non-PCI SVA has been supported indeed, this
patch implies a functional change here.

> +				}
>  			}
>=20
>  			if (info->ats_supported && ecap_prs(iommu->ecap)
> &&
> --
> 2.25.1

