Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD2569ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiGGGvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiGGGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:51:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814C12C654;
        Wed,  6 Jul 2022 23:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657176681; x=1688712681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eXTYdrArHvFymfyug9XR+XQFv5yi2Hj9jj12L8edwlc=;
  b=X2tXMfrhl2BA6ivP0fqQsXFp2WMLec2k69yUvGgw6My9baKx4M3dFp/T
   3Xqh7ND2dgHU8+1PBGV4/ukEoMzfq2oZwKwWJ2D2yidVzjcP62Y++kqoQ
   A3X74GX8T634zH3ce/+ZYR1Zrqa81Yp6hKeiU3U0b5Cr6UYOnVuGyZkkx
   qyGLevLZCcvYFZFfObyxernliWncDh/y3719U7Q6oSnH6MLUd4dQfnAWk
   N24YPo4BjvvRNMSHYUcbiluWkttRhM12Y2YbBDYaMVB2N/rwAz8kXCw5e
   3raXLijQt2/rouC9cA6QsC88hYhrmsD4UF8e9yDuUpBECMrV3VR9lhRt2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="285072228"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="285072228"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 23:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="920477562"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2022 23:51:20 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:51:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:51:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 23:51:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 23:51:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mChtejoRuf9OHxrhghyhAqMhLbjMlEi44OeL9dKDNNZ+o4MF1ZKrK4+LXj6Y81z0oYCpvlY5fdW1G/tuqeMyDTqC2aI4CxFuqe1Gu2zT+loyCggF7TY2Z2on8l1eA/s04/uQdE+UOIBTqUtsWBgqOJ0o1vFo5D+2Jq+nzR50EBQCyTfXgdXIpWJI04Pu1fmdS8LEapg8xN8VE9Tw3PrJr7WV7OxIrk3P5vOv6ekmFn+1FPlG8HSzETIw1nrSWoOvOAbyDHPfRl+1HSdjExA8hw6KuMsU7eId+Q81E51tjuaCiZ9VeS8FjH3Ieu9UnjlSeYdXmF+rtlMuUgrpJYauFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5ef6XS6IxmpmSrc0O6ApOEuudpdv1JvChjcDVNJAvw=;
 b=dEN1qafkcM3IibT+PfV3NWreKNCF41kz2GGwNlg9SBhWrs5gPsExQ/+TLB5G/3ANSHFVXDa0wcJraOQuFn97ttC6cpAQoGWRdSoD7qk57c+Yo3VHY+5uo0mKy7TEe9QigfAy7T/l9bisw3ruwEMzX/d2ZmeID+J47ofhKXc1qRwbaNMXpEF5n2KUSwdMN3WPy5BwysWhMM9KmF2b3qkfHJjy+zXm2tt8DLh92LQIxg6bok81bTe12dfFJ3gavUCaARW+uIiI8U0ujiCQXTGtuJhJeXPmr/XOcViQAVbtFZZfwKqjzRqmyakJqm8jen6vB8Ms1flq32SRVZ0SwCM+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB3987.namprd11.prod.outlook.com (2603:10b6:405:78::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 06:51:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 06:51:17 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 04/15] iommu: Move bus setup to IOMMU device
 registration
Thread-Topic: [PATCH v3 04/15] iommu: Move bus setup to IOMMU device
 registration
Thread-Index: AQHYkJHwF7q1lwdLwUOXyHWeZ9Wy4K1ydjbA
Date:   Thu, 7 Jul 2022 06:51:17 +0000
Message-ID: <BN9PR11MB5276ECD0D25C09D6A3686A3B8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <5b9b608af21b3c4353af042355973bac55397962.1657034828.git.robin.murphy@arm.com>
In-Reply-To: <5b9b608af21b3c4353af042355973bac55397962.1657034828.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02e31b74-487a-4ca2-9752-08da5fe517e1
x-ms-traffictypediagnostic: BN6PR11MB3987:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +nGQ9VyGcU1wQheoBcjAV3nGuHfJZaS6sg0QHVFzgyqLKenoiyOFx99NOWzrem3ZPGQWAF3tjr6G9A0mcffhNTwK3haOWvNxTUXdQUPvwX1cqn4ejLUxktfkLf67NcKEbfJz2Moa0tefSxnbljLSEK1iJNdQBXNiLuCy2q7qQvSP8eLKHMRL77FeEVgyriNGKB+WLi+jK3E/cDIOVQMrbdS9HnWQdQO048VnCHyI1U4QiZ0lp6r0M67PiT+ynIbwLFmsfsSYzl+D2T4S/zT/0wdqZY6m16D4QoxRu+Mzqd1V/0Bogqc+3Px+phafsmg51NEd3VoQLCu6pqJVP7sRyPJiu0WWA8JuqbQNJxkRaUN53pVTDsLr+X1EdmkSkowPJaZYkn/yp8Uz2R6oi2ptwwWMUHYCbAaasPoS82GfS5Ejqa/phwW+/j71dxenXtsqNHhd1L0en72PW3+w/L+0JicyxkERg0duKuzRDjCtoFPw85KMlOCSG685vuSVTZYKfGAKdstJNXE1qb+ki/4M/k9Gr9fcvo+cH+zi1UiI8puoHMl44SuI0B+zbpt1f2QiNAnarihgUnmDYIkfeHNsXCk/8/XnycJvlckeqTEabetdG2dMkPN1Ck/AAFk0pxcZL7N7YAh5qP/jsH15jZsSzigmFefnbZSlOwPV+lk/TjB2HSDjEphpNUMqEsoTDzoyQc5zybqHEzc3iNJQwZ1PHVUn0a+fl739HbKyIDsmA6LhCRNSi2in9dXt008ZHmxpuCwvk2JdLlE3F2ym/xa3DuUn2zMYP1STK3ylrXy66BCpy7edEzJ0j6i/3kwufhlI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(376002)(39860400002)(136003)(8936002)(478600001)(82960400001)(110136005)(64756008)(66556008)(26005)(33656002)(7416002)(316002)(122000001)(66446008)(54906003)(66476007)(66946007)(9686003)(76116006)(86362001)(55016003)(52536014)(38070700005)(186003)(4326008)(41300700001)(8676002)(83380400001)(7696005)(2906002)(38100700002)(6506007)(4744005)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kwjY3lFl0USrdrTPSoamRJSQKS3pFuyuxNP35lKssWoU9e8FCUy7pcFvEsNd?=
 =?us-ascii?Q?epcmXih7lRjwbcHEdsK0Oib6fO3rwHwxBTrzrdENNqNJkWnOOjKy+LVxoAQb?=
 =?us-ascii?Q?UtqU8e1VAy20cAnVhtuiTY/zc9jcgzcbUFAophoDsOqSdW4Ed1uZzXtYZReP?=
 =?us-ascii?Q?hQKPJ4jXST0T2OiqIOCZcMQhL1c1js8dU6rospTbg/nfHjAvpaaeqvs6+rel?=
 =?us-ascii?Q?i7XIv0n2HpGY7AAYV+MSLNLOw7YSjCAOfjO9VrEMGeOwHrG/KzQeD4IoXt+8?=
 =?us-ascii?Q?T90iwSlDslf3b0hlgVdrbqRJDHCMd7DmX+ejVTXQ9iGN+PSMEzlaS0sTMb7n?=
 =?us-ascii?Q?owcKugOMb6WuciNUHUwEtZ3OB2uznMFJONp9lhyiG2weTNQRsEyYOuZ1lsdR?=
 =?us-ascii?Q?3ZYmfv2nh4kWb3YtRrKpPyKSDZpT0pcAP3TVEd+7pmK52fVx9ZtW+EkF3kF+?=
 =?us-ascii?Q?lXDvcVoMjMcurJ8sLvtqlhABki220gs5HCl1bittytXXLIixfWKnb38ObxRV?=
 =?us-ascii?Q?D/KAkUgjn98JIRSDdLIiu40KU1km2JdaE6aAceuyzDInorMNmpKy88zHjAY+?=
 =?us-ascii?Q?MuLsfXTyFv2DNjACtLX3AtrXlTbG91vg0gkqiz6MzuI9gWfpuqNK5SIjnxcY?=
 =?us-ascii?Q?qu+hRF0+sLQktW/owAuUn6bw0TCqGD0QpButWeLHCbJc50P1//lKhf18JoyC?=
 =?us-ascii?Q?Ezk++1TinSNRVFjMazqnLCnUtmp5eaTHVTfDqByA4iXDvnAnf69/MTpeMuSC?=
 =?us-ascii?Q?qcr9klMTBvjBHynm4JQ0CZbfY4af9XHz14Ptn411efnzqoZx8lNzHUZF1Gi5?=
 =?us-ascii?Q?ukrSSwZsZkUIcFWYtFCOIONNnS7WRSis1ZGu/9/nmPchNY+gGEhAopNkkm3h?=
 =?us-ascii?Q?ZJ2iVhWUj3FlaURwQy0Zj8Pw4L+NaStl2t+9a+6I038OcwIn8gQi7Lj+V0oP?=
 =?us-ascii?Q?qHdMCdZTMWqKkzFyG11y+yTyu897bglp2snPKNVG8m1W/w/Xlv8jqHLHJupy?=
 =?us-ascii?Q?Ur9NJ29oKPrdWRzQX2Axe8y3HiFPubSOth+nntG+3tkol83uV3BRpTOTRcug?=
 =?us-ascii?Q?uVq5ABLlS1cti9L/RsNu3RimspUE9W3gx8jCfrdR2wAaIFIDv027IOaxI8Lb?=
 =?us-ascii?Q?e3NFydz5SlXBD918QkGXuI79csNGhgRdrjD7v2o1aybIehn3ejbRB1DuTYyn?=
 =?us-ascii?Q?7s0U4Dp4ifbjIM6L386XJaMKg1Eii5rwthn2u/upjaB6Ckk/UDV+iYWl5Nxu?=
 =?us-ascii?Q?gvxjfwL0YHChCLOCScXgg3F/rXUEyTtqAGuPzN+fkSqf9U42tZZq5IAdZJVe?=
 =?us-ascii?Q?h5kY/0s7B6jIT4SwZOOol+ivqC4AlSFfkF/yxsYUelhAlter2i6gjLDiCixE?=
 =?us-ascii?Q?f8vC2KsFajLX76LyOMqFqk8B0nbqpAKpT/VqfEAfSV2z7sKiyi88Zm3a5zcu?=
 =?us-ascii?Q?5v96dDlN/v3tOEMf3iUvBWrbYtxWCyab5lzUzbNPmR/UH1Z+e8Tn7IewYrqI?=
 =?us-ascii?Q?jdqt3U4M6nFpazLUELDksuvMR6YVM/l02FsUoYk9F1dkJqcKTc78GG+zv4nN?=
 =?us-ascii?Q?TmLq3gl8DO5MmkIxrDTFxpTcWTgQVsZTocvH6iQ+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e31b74-487a-4ca2-9752-08da5fe517e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 06:51:17.9000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QesQu3vbfHWl69ohPghWpVHDJFWOazwQWqqderyabqpR+XRvaYFc0SnOxDtohlWAVfZaNMo+TG7DyKGE2fRqKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3987
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Wednesday, July 6, 2022 1:08 AM
>=20
> @@ -202,12 +210,32 @@ int iommu_device_register(struct iommu_device
> *iommu,
>  	spin_lock(&iommu_device_lock);
>  	list_add_tail(&iommu->list, &iommu_device_list);
>  	spin_unlock(&iommu_device_lock);
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(iommu_buses); i++) {
> +		struct bus_type *bus =3D iommu_buses[i];
> +		int err;
> +
> +		if (bus->iommu_ops && bus->iommu_ops !=3D ops) {
> +			err =3D -EBUSY;
> +		} else {
> +			bus->iommu_ops =3D ops;
> +			err =3D bus_iommu_probe(bus);
> +		}
> +		if (err) {
> +			iommu_device_unregister(iommu);
> +			return err;
> +		}
> +	}
> +

Probably move above into a new function bus_iommu_probe_all():

	/* probe all buses for devices associated with this iommu */
	err =3D bus_iommu_probe_all();
	if (err) {
		iommu_device_unregister(iommu);
		return err;
	}

Just  my personal preference on leaving logic in iommu_device_register()
more relevant to the iommu instance itself.

Apart from that:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

