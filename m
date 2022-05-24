Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901EC532650
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiEXJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEXJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:24:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2572F73780
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653384285; x=1684920285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=acZZei5Gqu6JSYeVBajyjClTRZC6XIRiWlx3GFHjXck=;
  b=H9R2JtLqDoKA7DvaYPIm9AxxQOBD2O0WDZrCCGRnwsBnY5aynrDXiglg
   uBUz2YIe12xVRMxG/M4J5HLHRcM19eLo0IOaAyAalbf1LQIZVIN9O8SZH
   +5Y4e2N2dN/KkJPRucrBVGW0o3LW9+NpuALAXnL4c+iIH0tItUDCrsbPe
   LMYbxNfJ/3PuprUcUkGDfE2znQ7fm4miyJKnW6iDqzd6UCwOb0S2wZKds
   c2w9ERvRp+PdLneMHs3bhiSjufJBDR2Quox9+Ar29JNdBxFhrTdE4b3c9
   OQs4uVl2WdH/FlGFfLRYlgB4U2TDM+mLNJBGTaJWu8W6R/mcwRv5LwUm/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273593765"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273593765"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 02:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="703394152"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2022 02:24:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 02:24:43 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 02:24:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 02:24:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 02:24:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha7MtHvgmnD1GjcFm2LZqfzGK4nye97CN1yx9VZstHBIq2BnIHkIW1al7VypGf3iSDOhS6IhWoIhWZ17tKREbfbFZ2ymZ0I4v/44YBd8bttFmgAzs4Y5T1VG50ZuCoDzttoyxDi+xHFV2Bkp/DpUHNrajxwdlCNatbK+Agux178TSKyUXjuZKoIzdDhe5IzT1HZKhoqIe+M3nVCooORsxqtEWoINBtcLpW3hjwMIhC+bXoYiMfKAaRHX5NkdveO5r/l1e1SS9SouIpWFfz3OjI6kKZ/GyXaQbpHAkqRYG59C+iXd91ebb7DeB73f9vNYZTfqMfa9qUvPG1BrenrdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6LdsQsdzZJk31FR4uUC+eK8UD1Nzxeb8/Xp/j6YLkE=;
 b=HjchoHu9GV5UYcC4JI56ZvVjcQeOjI6HmLU4nBqVAIljPExlNJFnqLLaaQcs7iSKkeSr80CL/cnc0WMLT9M0hE4mAzYBcnitBZrVIv0Q6Tq/4oZ9tbQOE6GCIIjGh/q0hUzbsNM5T+FG0vGuct9eqpR7k3MKTBkfRWw3r5NzeT6IySOaPK5xAJ4n0io2xWHZfBSfY/HXFQHWzcwVbGrsluC40M8Ny8yrR8XlPN2OgtSTaFX3/JKj4BujtnUMY4lr2LDt6uOYzVZ+9+6DKVW3s+3TOJtzaJr6qWPGbQLimFWr7RRF+oNE8VrWiAh+0e37KctrzzjF5+l04xdqa0fjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY4PR11MB1974.namprd11.prod.outlook.com (2603:10b6:903:126::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 09:24:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 09:24:41 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Thread-Topic: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Thread-Index: AQHYa1F/TZ46yRp1uEKady2Eopw8mK0ttChw
Date:   Tue, 24 May 2022 09:24:41 +0000
Message-ID: <BN9PR11MB52766D61BBE784A70B4BF06F8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220519072047.2996983-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7187e932-0e47-4bdb-eb73-08da3d673b66
x-ms-traffictypediagnostic: CY4PR11MB1974:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB197406B70D3C8A2FA45300508CD79@CY4PR11MB1974.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZEP0ikMyUleJlxQXv7WtCQdUUWWMcSdKO7vXbll6iaOfH7kyUGgpYGWfAnDaVUA82n2dumU5LlgREmMw4B9H601IHmtGYixxpvRHdHDwX8BgfxrJT9VqEA6tQ8wkC9ny5beldycKYOidL2dWhyNHqVVCfQw5usWC5WS6n3Pb16UKzdjsZgKvYhbGwFPPbxt8nJVFet+ybgK3W/vMSUs0SL6e00JQU0EINK6yEccVBSAR9zbXUKYqmfdrnDoZFHpdbwJNEpXmUukW15mEgocXvL5vQjvp0WvIOm+tFtlccPIw/eHkyTweX528JGAOpWYRytnKF7NFRzJEKt/g+7Ip8itgXaFTW8sUpM9pU74nNdGrKU4t+d+K9gVFRxE3OHcIpwf1Kdjr5ol7cNySje39OvDvktoOYKMitZ2c4mnL34/hcok0JfSvwNkjqTUxxntdUDVwM1ysz8xO5/UwKXA6uY9ocb+YunPg8jzqXTMg1H0Vny2UqFIMonp8NXa3jfscoXXfI/z7JpXAkGN19lTG62ZCJY3BdIn9lyOUheYsQ4l4Tv0j2Ttj4aFh6V10y6WQphlSa6CqTSeI4B3S9DJsbZObaQwjUT2A8Oc5ohYxaWCGMGXsoMf0yugv7oigGZF8GluDHb6e66ltgHbVWb6dWhp3r8998+S47VgPUC13kRt5BHLvj069keLP4Rx9kWwE5rOiH9V3Ysa9ziTUIPOS32vn6U7fLNse9N4fzH25ww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(82960400001)(508600001)(2906002)(55016003)(921005)(33656002)(7696005)(7416002)(5660300002)(54906003)(38100700002)(52536014)(38070700005)(110136005)(316002)(26005)(66476007)(66446008)(83380400001)(66556008)(66946007)(64756008)(76116006)(8676002)(8936002)(4326008)(9686003)(86362001)(6506007)(71200400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HHGEftfb3MV++GSgRojowSWD++Nrjw2+UuXdBUjy+FvlLf8hffoyLGTxqsu6?=
 =?us-ascii?Q?/sdkD7HF5++UO2fmfR3zlbojuUAXOsbOxj9RIc0AvFzcGGG4BpbdjP4LWhbJ?=
 =?us-ascii?Q?GAarxvWNkEiJxCbe2qwVJEnX6Mh5+K4r3N9XK4PpdTUpdpzYtWiDTJOv6g6a?=
 =?us-ascii?Q?ojYR07C5VLyKC+H9M/Wt5L24pR8qyCDd6twXdHhvKRi+iWx5J77JqyyWXgSK?=
 =?us-ascii?Q?whTVbMRrDcfhA8IuaLzxctcHDimZbEb9HJYmM9F0c/fEoanDGuxJXvgBUpJu?=
 =?us-ascii?Q?GT5aqEJyZIX5LTFpwOfEh6/BpxHNcMiZ9xbbGlu8kvu8zdoAqnjdZ+/k/7PM?=
 =?us-ascii?Q?Homq7hi50+rwWfkjVYxNvZ5stYF0MVsWTXYoaXJu03MsSJ37Jp4BQyX4m+I8?=
 =?us-ascii?Q?dgv5nDmznBKnZ6s4FJmnilukptOKKfAcAjhuy1HVxUwo6MYm0J3Z092osExd?=
 =?us-ascii?Q?teOqWBHGzfTPMl9Tm5PTfkVaO2zcAS42I8ejahy9OJUVZai4V5B/wY12ri3m?=
 =?us-ascii?Q?FpVDUKWWBOI1qiyIwTkRAL/HizCoRUlkM8F/6VTlBYW+7QSiM5jxWSdkxSJD?=
 =?us-ascii?Q?vSBt2B3KfdJ0mPtxQNfkEsQMhDsJYdvL7wKQqN4lPy64xZ1vcukzLH61E0Bj?=
 =?us-ascii?Q?upQNMZn62e3svTdKKO8HSgmPe7GjqcynnVaKnZEfk3KGZRE0K++3dLWit7Dp?=
 =?us-ascii?Q?sasudi8ZXrc9aNa3Y1EjJL32NtlIblcLZqf/PTHKcaFzEc9fj9lV227HoCmC?=
 =?us-ascii?Q?ciO8DcOM0taXKpCTk0ogG5Y3UPs3CxDWg/lz0zK2YLnkC4PycrHRpMP19+ev?=
 =?us-ascii?Q?W2ezcf+fzPm9eSJCMdT5Vmb1Y+bKx2CcYEtcirWKab/9cMjj8+XJxTJAsH1L?=
 =?us-ascii?Q?NMubcwA4SsSyNmYg0CPiXJLZXeSuCnZdk07J+BJA3lHhO3ai1QMrSQyfX+uX?=
 =?us-ascii?Q?CJOHulzVNZdvVCJEJ0aKDdp2p9IxNywpjSG1ot/BgjqouI1NQ0XOPSvDxWey?=
 =?us-ascii?Q?2TQcEk9EN69Cu0zae66w95jACdlBTuJCl23QtwVWAfWl/xP1nhUZJexpowYn?=
 =?us-ascii?Q?BEroJMgYX/JdOg4/IdxToV2hb/ALF8/jPuo7dBlQFxSTIJgEPekJx/dE+VI7?=
 =?us-ascii?Q?+hwbdPx1D8+fNGyl5RBB/1o5jsoacBAZ2M+1YsF5dFGtzGGonDJFaH3wFg3J?=
 =?us-ascii?Q?6/mrsCQFsL7Dfgtnvj9GMYApN5GOnAhDzR+ziPbjAd+hYr61R3TpUH3PMFZP?=
 =?us-ascii?Q?ZitRbzSbAZ68IPtG/G870EvpaigLQs1L+mtjEh93VgwVR7wUZJ5r1WhAqfAU?=
 =?us-ascii?Q?yGg9JRJFSRXz9O/Xbd2j0JNAQpNS94/+etJ1ee5LtWYqGFxByaUj/xt8NCrK?=
 =?us-ascii?Q?4xbqhlzhtmq5kOlye4niIX0lIBu0VYag8ZpCXE3mHjrHvwJfnqEfLE+7Blzd?=
 =?us-ascii?Q?s3WMbbrLA84ClnYpkWE+4mBXfKRU4PkhgLuOt1Jyl623LWcYSjokEhw2Oxt1?=
 =?us-ascii?Q?FEf5MA66EuIjIRbvYgrrfFIUkjXWgary9hzX6uVwhsFCFpiv5jKXr8Aae+MX?=
 =?us-ascii?Q?qiOMHNLhmeVTWdR2RnXCCd3yg47I2k3/eXLBqFjOkKJoz4I7+pZH4sR52PfH?=
 =?us-ascii?Q?9Xax/gveOtPC5g1UhMQSe7RV2S/egF0vJCizRWTkJ0FhL7pFlB3BYzyr/9SC?=
 =?us-ascii?Q?IG4u1i84mek5Ivpi6+Ow1YHkhUI0WoBYQvSOjl5qeK5o6ZDyq4YJafigRxYw?=
 =?us-ascii?Q?uL7PRgVImQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7187e932-0e47-4bdb-eb73-08da3d673b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 09:24:41.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvYvUGjbR9xT9HKaVC7MQruKsnVRzbftZX3bJzQcRurwkwHbu+qP/LbV6BcYOVjj6jMyZoGDYFQi0SEK6afmfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1974
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 19, 2022 3:21 PM
>=20
> Use this field to keep the number of supported PASIDs that an IOMMU
> hardware is able to support. This is a generic attribute of an IOMMU
> and lifting it into the per-IOMMU device structure makes it possible
> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver which suports PASID related features should set this
> field before enabling them on the devices.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/iommu.h                       | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  drivers/iommu/intel/dmar.c                  | 4 ++++
>  3 files changed, 7 insertions(+)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..da423e87f248 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -318,12 +318,14 @@ struct iommu_domain_ops {
>   * @list: Used by the iommu-core to keep a list of registered iommus
>   * @ops: iommu-ops for talking to this iommu
>   * @dev: struct device for sysfs handling
> + * @pasids: number of supported PASIDs
>   */
>  struct iommu_device {
>  	struct list_head list;
>  	const struct iommu_ops *ops;
>  	struct fwnode_handle *fwnode;
>  	struct device *dev;
> +	u32 pasids;

max_pasid or nr_pasids?

>  };
>=20
>  /**
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 88817a3376ef..6e2cd082c670 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct
> arm_smmu_device *smmu)
>  	/* SID/SSID sizes */
>  	smmu->ssid_bits =3D FIELD_GET(IDR1_SSIDSIZE, reg);
>  	smmu->sid_bits =3D FIELD_GET(IDR1_SIDSIZE, reg);
> +	smmu->iommu.pasids =3D smmu->ssid_bits;
>=20
>  	/*
>  	 * If the SMMU supports fewer bits than would fill a single L2 stream
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 4de960834a1b..1c3cf267934d 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1126,6 +1126,10 @@ static int alloc_iommu(struct dmar_drhd_unit
> *drhd)
>=20
>  	raw_spin_lock_init(&iommu->register_lock);
>=20
> +	/* Supports full 20-bit PASID in scalable mode. */
> +	if (ecap_pasid(iommu->ecap))
> +		iommu->iommu.pasids =3D 1UL << 20;
> +

supported pasid bits is reported by ecap_pss(). I don't think we should
assume 20bits here.

>  	/*
>  	 * This is only for hotplug; at boot time intel_iommu_enabled won't
>  	 * be set yet. When intel_iommu_init() runs, it registers the units
> --
> 2.25.1

