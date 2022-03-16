Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E194DABEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354235AbiCPHlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354254AbiCPHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:40:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B60760AAE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647416383; x=1678952383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ERgiEkShEkl+4rF9YNhf661hi5N9PlHoJR5sfSPNtBE=;
  b=QG3fioYwuK3FvsK1L1tfhVCUuSCsY2HviJjyVTDNoPN8WO9EOVE6bmF6
   wmLAjh7E0H4I6/yCiMv6zWvrTW6+h2+MRRQnRxHkLdxY0nVoX6eFO+ywi
   EjDsrn8qP5VFkkpOuxSoxZ3EXEIKZqXdjQr8DCoUsnCHEQ0pur14ovljg
   vbpi2bZEe7/7kicdLsOdKXse7tnLftY86obzDRDYmiuigYNYG+j6iSoqP
   //X2GJLG3Ttm51gjhkL6tv4PvPA5bc7p60NDLPjx9YnOGwMh2RLDagOVr
   mfrPlGL5P4EjUqna42HvPAtCJ+xDkN48MoAqquGoYEGYft/dyoJaKhH25
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243968273"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="243968273"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="580810757"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2022 00:39:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 00:39:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 00:39:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 00:39:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 00:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOWneACqFYBvBSwyiQtfLDHP0bUJRs4BWy6KjqBPLKGWCcVOmem3fAe0NaAGPQfscqzFbyqiFape/Oa2f+Pao3IfzzeS3jNVUhYKgPy/bnqqqo95BfXG93yeBWwdiLge5eaE+vB5tsHFrOkMZ/NmxgRMKi1Uw3ohd/VTzsa3rUZ4f6oI9xBdn/3NdIswvUo/VB7GhP3IuyPor9CysxqCKRQM0mI0qe9atXC/S+3U9YbAcSpeSfp1x19EFsUMGdixYEoneYPdbpWbwgCOITXha8RSjZnIlJyPa4W6tv84+bwXJHKRTsCw6gB/eGEOKvceFbSo8+JVK1CdgXNY1+BZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA4jM1/YM2Uh1c7gKRuvBG4FmLTyeYL9/Z4QtjDntbE=;
 b=gw83im5d9yaWAIAk711xXD1q4ZS95u0+Pfa+rsIMntJjQLrp07rhNbK1jZgOgPEUsE/PJ7pybpSumD8cJUr+vK8GBpGvSlKJXPte7+TjKnEfN/ccuQtWKe/do9t7fG5WN6nC7DjSKUxbE0fbq0lg739vrnVzWK62S43UHzY47XOm3GO3lV1ag/atGPYqfsVtVQRsh7WEIs5PeDPLUnuCr8pBgl2xmG+uY+L00G2Yb1pay9hDLU/7ymAAcXZ5QSdOwYf7tpRxjI8r/9s5+WnOhYcqw3TpCeITFNy8QZ/9UzZ2bolXTV4sJRI8ZrewhIvfxzz5cAOnn3EIBBqdsrvZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2653.namprd11.prod.outlook.com (2603:10b6:805:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 07:39:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 07:39:09 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Topic: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Thread-Index: AQHYOCoddoPAbs8qR0GMuSnaaH7P9KzBoSaA
Date:   Wed, 16 Mar 2022 07:39:09 +0000
Message-ID: <BN9PR11MB527696917B0F6496700885328C119@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25ba95e5-8d12-46c3-a7ec-08da07200ed0
x-ms-traffictypediagnostic: SN6PR11MB2653:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <SN6PR11MB26535CF0E802DE2AD79ED5DD8C119@SN6PR11MB2653.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ytXGxCFeEHg0m9P35osnvrcLJzsv9jTRkaIHrZZ7GZanzutBpjJb1MlfnbWJkffWBqjj1DFlH1Y3zEiBDXAyUnpr6EXUzyWyzwns+xN8ixtRXdH6GoWZ7knKQ33DfxAz42dgfKX33iuQ8QJKIxyk3skLEvYxSwaoC1HpACxtM3v+yWIeN2yhsPRLsS7cUEz5HxVldgbpkIXSqOVV/Z9VoJ4DDCXEG/XB+WpBZL8BdsWDCpuB6H4QKfqBXm3+8rx5iK4XhXmouEDQQ9BuiWDt1zyXXzqBUJmGxlvAkczoaFNGNMEa+vdlg45DTbBDWXsDvKqUjK6cVVbjcTGtylFg5sm3oMvZJ2A99n+7dqaSY8a99OcwEUgfAP+KzjPHpZM6oJLgL+FypovHLQsHQFIkfXqkpNlnkdl3JghPAGft3YaqpvlAt5eai4cPNZfW13A98dmpD+Y0cVvbtXEHUhzdQagize78/AYBtJfKfFIBQf+M1MfcCfL0GNd2RPuvDQsfyKXoal3uIXQaH1w04VH6ibwHcfu2R4OsxyuMRs/BxDr31NTAOLvUqm53XDmFJgjcGVb0vmSowmusxb+NFWEWcrqJWDC58oG/LY3tky3myAGqSoiLCeq2Kp/bngj3jyeI9gTZB9S9kOkmvC/2uucKsK+bv39DOA+RLmGaFwR6mIfrfy0JBGmLT9pa4kzjOQQtRo7OQFNk6bFD++Ok8iCN8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(316002)(110136005)(55016003)(54906003)(4744005)(82960400001)(26005)(186003)(38070700005)(508600001)(52536014)(2906002)(5660300002)(8676002)(86362001)(9686003)(33656002)(8936002)(6506007)(7696005)(4326008)(71200400001)(122000001)(66446008)(66476007)(64756008)(66946007)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FGt5QJYILtZZBLEgSDFcE0da9E+RSJeemSqjfa2IeZ4+u1NWx/6au9wVunha?=
 =?us-ascii?Q?7gMx+NFj9U9565Qcu0mJp0/5yHT/P0sDzw5BLV2SYO7jrjwjTcxSOTQso7Sz?=
 =?us-ascii?Q?H1bqhBR0G2H2R9wsFajOcX/8KQpb0uVxBZRmPu6y9R9v82qb6zNDycM0NzoF?=
 =?us-ascii?Q?vspBqP14/kJbpi0IeFk4EDDU874r8rV4uCXic+iEu1SbswLPngAFZUZT4ZVW?=
 =?us-ascii?Q?HJWLDJsLNfADJtYzMY9Pw0VxJuGPXkTpPBNILGnUhi5via3bYxABRQEzyKBA?=
 =?us-ascii?Q?CWFMZD8KmvRhmbAfvd59tBuvmzt9QIuzacFM5Z1NwOcPd/2IQXrVx8oZ4a0N?=
 =?us-ascii?Q?ELjns9l8mazBEG3qjHYODsNLy/kMPECEfL7bkSP+yjrgAFfqJuiTvVNztapG?=
 =?us-ascii?Q?ECezkzy9wD81V6qO3YAv/FOvloBxVMuX+8Zk101y2u/Y1MxWJ8JVeZQ9B0Ue?=
 =?us-ascii?Q?LzbFYcx4tK/W8pCwEW/TZxmi8efYB9w02RsJ/G+2lTfkiYZIG5YqzeYDhCuS?=
 =?us-ascii?Q?gbkixDqEhFkpGWg0hKO/A1+6bYFcwfoD6b9LVoNxg5EDfz29MOkpovd99C38?=
 =?us-ascii?Q?YMuONZ93/AEl0KAsjg5vLeUt+QZuJ6o+vmEDHRpGxQ4ENwE/iwqudm5NTIqn?=
 =?us-ascii?Q?ym9Nv4IqXwUax/ZVLuqktoVFin6mA+fdM8eN/aHA9Aa/kb4YrOjzoBUIEIle?=
 =?us-ascii?Q?w0j5PUSi6Cp3VGkrpyAaZ8gDG8Ch9dL9xdIEFx5v6ptaZ9F4P7FUKsBZoiZs?=
 =?us-ascii?Q?z/VJdYDeHB11RYzJnrRD+WYT99CY8JHXwEjuModLtsqTJbmLR1xww9F/M8+Z?=
 =?us-ascii?Q?Mx9oXNjnXiesCXJ5OVyqrA4TQftbkQdrvChyOy0VsdiHCEpu6n4qIhvPtgch?=
 =?us-ascii?Q?LHscyZlH6yKDXibgQsJf/6APw/9kaNwVp2HBbscTkblwexSYsyNp+ZrDVhZU?=
 =?us-ascii?Q?Q5UcGTHNdlzmutZA23kW9I1NNNuy5kwAmT+BY0bRa0ab/c7N6FNEFcOF9OpV?=
 =?us-ascii?Q?1gOkIbmZe1lhC+smLJcRkFkvjgL/U6vZMWHdlO4LJ8wjY92/S+e/T4eTaG+5?=
 =?us-ascii?Q?NOXHXUFTMOw5pik+Wjqk0qIKJgyI05yLNTTTr/UFyXgHA/2uXWd8oxEA8Fim?=
 =?us-ascii?Q?QeIwJImlY4ha0CvrApp7lD3m8VwBN9ZWZX7DSfFpqrbOG4VI5LFzcQAmZW17?=
 =?us-ascii?Q?rhUc9B7tCKg1ktruKo8STID2TTiihihKlPMDOc5sFUFMAP89TcjNsD+QAW63?=
 =?us-ascii?Q?P5dW4BBMzW0udOAMw/HnwCpDtI2UHrOYz+DrQtbaRt7frYJI1LsgCjCm+6vk?=
 =?us-ascii?Q?rnFtNB0jpJdMh5Bhd9qekvL4pppv05PvVYc1u+hJBT4OextNJTC+hMta0GbK?=
 =?us-ascii?Q?HR0s+P8SWgpMfD8pNL7WvTMiyg5VTQ9ZMZOJweheQbruTBFLJkVDB4hf5a70?=
 =?us-ascii?Q?kk4A0cAjLbKp5DI5LzYsGFFtuq+EVUdY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ba95e5-8d12-46c3-a7ec-08da07200ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 07:39:09.3687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCIL7auDDt5Wn9DLu0DD3ilRaOysIia3nz1VcXABjaWtGjFcNEyn/UA8lSfSooEnHxxGMokLT7K91wKEVsOkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 15, 2022 1:07 PM
> +static int intel_iommu_attach_dev_pasid(struct iommu_domain *domain,
> +					struct device *dev, ioasid_t pasid)
> +{
> +	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +	struct device_domain_info *info =3D get_domain_info(dev);
> +	struct intel_iommu *iommu =3D info->iommu;
> +	struct pasid_info *pinfo;
> +	unsigned long flags;
> +	int ret =3D 0;
> +	void *entry;
> +
> +	if (!info)
> +		return -ENODEV;

btw this interface only works in scalable mode. Lack of a check to
return error on legacy mode here.

Thanks
Kevin
