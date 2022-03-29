Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD6A4EA97A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbiC2IoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiC2IoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:44:00 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE5149647
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648543337; x=1680079337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gjX2EU/kRGtK8MKNQHGx51lmdK9cjtkR5sTyBTFIc5A=;
  b=Q6DluV5Zme6U7uFaKwrjG4KTsjLUOAGHsWSpnKh83phCEQ/24bLCWGv9
   xwVXXC2jmX34jQhi3M0Bs6z5zJg+vn/ko4wbRqOcC1BplR9jE7mRbMHOu
   M1WU3dAkJ6+8ZgJv8Rz206JbiMC5+R4njglmNjYHEayWMhz9xkfcEQaJ8
   QapNmD7TqJWACVAE3GxufnOS3fiombao7sogp+2xZoAeno+pzyayyJeN+
   yOQLJzBDBvhBx5PhDaNYfJGR48ieuAWjTzinZrxEIoS1of2gkWhAQJXPk
   1tTXpa3waQSpkX0u2lB9QSfaBAOgySBqoC51lKl4mPp1wm+KiMO2KwG1/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="319896290"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="319896290"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 01:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564444528"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2022 01:42:17 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 01:42:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 01:42:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 29 Mar 2022 01:42:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 29 Mar 2022 01:42:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLTydJ9RNIQp5B94s9NI2te/8/scoJHCyRT+EcUHX4rLDS8uL5hRSlLDnYBTQicgoz823gk6B7TpOHloRMy2mjdQDd4b5NpqDcdraNstw51UXDX8bO8e6ng1Qahc1sN1n1D/L+ryfV6Ud4xL+XWPPYVOSCF1yWLCGiVLwTb10DLGTYC1fkQ+IeKPYAKCMesMulu1DYsXhsUZ/6l3vz3vmYLzfvp3zcnusGzSJa1M5uv5Y1NGCHKLTfktE+tfyYR8XsKy79EppbASD62UITNrynDx8tE6MCj0qvIUt34YxYWHJSxYsrPYCbR+GSZXW8M44qKXLMQ+a2hSvrwFXQcZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrDWTqdg6A/MGFXA6e69Q3z86e+aDei7r+hCcAcHLWs=;
 b=b9xt33BtVqEmuH3xZ4RL3JlTZbbpudTai6qj/z7A7Gb/lx0Pq34KgZ9i+ii8XrgCY8fWBWlVdl59nNPP0XCeQzBEyOBPFFtozFVAkDl38XtYEH/B+dFoQfXPV6OC8jjPsMFQh+8TqyCze5rclQMYw6274kCnoA3uY0BvgEHP1vRvZn5/nkJWxLnJXr1XC/xIYOWTcnUrsuqwBlWKCNLbZJNtOUx/YrSMmhXke/bau+yZYdGOMhblgmr2vVkVAuDi6tB92MAKoz9KervOzu8QzHcsJBcpkUPBcDNomabeGjhjB6rTPIHxsi/5yQclz5xhcAIuSdb0vZYWrkFtqCFW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MWHPR11MB1488.namprd11.prod.outlook.com (2603:10b6:301:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Tue, 29 Mar
 2022 08:42:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 08:42:13 +0000
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
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTw
Date:   Tue, 29 Mar 2022 08:42:13 +0000
Message-ID: <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220329053800.3049561-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b96f1a4-7b83-4b63-ce48-08da1160059a
x-ms-traffictypediagnostic: MWHPR11MB1488:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB14888204C6938466E1AB5E5A8C1E9@MWHPR11MB1488.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5dBL1x/gV1GVcSzbO0S1FUzb4Hh1GdcPC7Iz7pUnPnTcMLDEo9I56YgZGXkTSH+uGRpRznyOOk4FEsQ1FR9rG/Cw1g+GB53hE98xJ9eN27NR1hKaO1oXa11zMwhngj+SJ1yuD8xsbLNY/qO8ox+QpmzIb9zHDkNM3QCaMS/2xuwL3vj/cCp/u40HsnOi4cMqBTUVobTYjnqfyaK3X57oTZ+WDmV0L+f1Nx0hXq1LEGiUORCSI5D3oEdm7IC3zh6dDRjcqNuYXU5kNntVcrq8FArbtrGZXklqkNDksApwIaGSoASdWKiptSXEQQJoQObohLUyibwSRJ7F9CGcvy3k35yISGtvOFdjpu9Ar1i7lCXqrFbyRMD9mY7HcaJcjc400mfcTUqHUCD14P+1IiGh83qIQSX+spq1PALFtgGGN+HmefY6zznO4HzBUZqiwlE+vYxhknI9G5j4ZEgRPU/k4G78XnXJKD3SlWDaUWW+HKK98ePgGTExUyhRm2GX5dGLgmUUNDxxb+yKh2lbKIvAoOHwfD3EO584hvkutLTJdX1IJEUuSJvxFfoSocyr8yH9DyoVIYG96E/8osuFaN6Um7XLPJ6UPjb+v0dIDlK+R6HnBBG0y8nUjPZGcfYYEBXLDS0BA5kKhiykdZBS6Q7uZ6EcylUMS9elVpJgRzxr/l2YH+InMe7swgt4qiOkErw0/aRVSfRr9FOhJBBq5oyzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(110136005)(9686003)(7696005)(54906003)(76116006)(66476007)(66446008)(64756008)(71200400001)(8676002)(66556008)(66946007)(33656002)(86362001)(55016003)(4326008)(8936002)(5660300002)(52536014)(7416002)(316002)(122000001)(83380400001)(26005)(186003)(508600001)(38100700002)(82960400001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q1A5bV21C5IAL/pjRTDIsdiHNjnM9y1yxtngzK5UnwmtOn0tNHuqQb9qp/5C?=
 =?us-ascii?Q?LFbmU6zWd2pRi+3qPCgcsY9QV3TM8cKhad1mLDG22nflzY1iFTWVcacg6D9C?=
 =?us-ascii?Q?7XOK/XByM4CvgTpPlS6Ns4laA1Se3w3S1o/jNEZIVQ5914A5quFZUFw09cW0?=
 =?us-ascii?Q?4Xoxrk6ScZFF/l6SPvzeCDVXQPmcD8qGZD0xO2gduTODoV9L9U45IAjMBOy6?=
 =?us-ascii?Q?p1vJnzdbGHAZsQpGsba1XH9mG23z7/nx1VLc4ilRZ/jL1P/aS6EHl8tEhsHL?=
 =?us-ascii?Q?3Ssuid9HXy5LnHWNpLzJjJa0SDs1W12FBOidIo73lrwt4g+jI8YjPIg+Qgyu?=
 =?us-ascii?Q?/mUbazmhDRrDiv1+L9/zvqqLXZbUJyEE0Ip+PQJCuXPFv7SOTKT1O5DWos8T?=
 =?us-ascii?Q?9A8ZGajkpF+7xSrrfahh44QdgrzLZbXfPsoc+5RmjPB3Na2zEsRJAEbDyvTw?=
 =?us-ascii?Q?JTZhZfeqW3NRftNA32L9G4dlTZyy30lqZ9v+N68upwy1kvxnnQrRElbbxs4J?=
 =?us-ascii?Q?hStekNTsJp8uldzI62kiZa7qvRDCLSYUl76uEUiTZtVcofygUe8GfDcR/EoW?=
 =?us-ascii?Q?vVTMfh51ioBf3TS/56tS1Jb56isASDx6XojIOkcrT9ol16gpWs8c/LZgdU5+?=
 =?us-ascii?Q?PIZR4IS95+PpiUlZFXdHxOO9e70D5Tld3zy05XeCvygnZm9PWs7DMzr5q04V?=
 =?us-ascii?Q?M0pY6TNs+1xhasYJnERAKKO/agHOa+z8czPLLUbEWf1ZAFpu6/bIlLo/+Gnq?=
 =?us-ascii?Q?+eoaS4T7yTBOQwxiNTHJjqi7ADP7iyGeR7qxJgVQIkTgE2eYJEIhV/0WW8ei?=
 =?us-ascii?Q?qQUGxJTelX7O2VvetW+xKz6jCnCObQxZUwSwxV9EVKZD5AXehg5djF67k3B7?=
 =?us-ascii?Q?jk6fapdo/9pYpk5wc3GjCB1z7hj6tE4FXq9L32zfvgzU8F88iefCmD2Yu3fZ?=
 =?us-ascii?Q?Q6naWXK8x1Zz9odQvmPUPrLxYTK68QKsC3jjsAPUupLedRpcNlwHmXWFZTWE?=
 =?us-ascii?Q?7Ypo7x7pED2h3O0up60zbg+cQeZylVt4QS1ZEATt2HL5u06Wx9VO5a7KcNDL?=
 =?us-ascii?Q?RwqdFHch8YOVmArsslWovyY1bYBHzy+ncxGB/Mlfd2n0avVcq5U20RPlc/MA?=
 =?us-ascii?Q?33AQ+3UCQw/7Zg49ZKRZL7OgqDacA4jkhji1pNCq8h1GirZC+Q/upK5s8F2y?=
 =?us-ascii?Q?XqOtHdgxEl1I+4O91ji8mEXVFfl3tx8ZhF2XvEvU5A61+8sVuDOr4G/hMgHY?=
 =?us-ascii?Q?u0+fvrYD4Er7Vu9z0JZmIHyLJG4/9kFy1yPji3uq99Scc2iPdzE3bDt99yyR?=
 =?us-ascii?Q?CCOJUi2W5tx0TqlIwDdX4duGgERtjMIo1Nwyq6lgXKmZZuTBKgshC3bsXxjQ?=
 =?us-ascii?Q?EWuq6XruCgQ3dplon8+19g1DhWFu1Xl/8u6gDPKol64B81RCTAQlEUebXdO1?=
 =?us-ascii?Q?+bnO/SETePAEaXCliH4bAEygeJCBAd2O0X4Rm5fxDI+siO+dp3al4qGriKwg?=
 =?us-ascii?Q?IMJx/BdDUxECrB07kSOZu3j4cI4YOc7Zh1u0zT8woyoZJOkFApLO4l20Lki0?=
 =?us-ascii?Q?BS9sgbVbEOXHJkTGnY24kIjLbsn1Lu2qGSRaquFCiI1gwt4Gm2XpgpOj5Ayd?=
 =?us-ascii?Q?NjgmEAwf547IrXLCHe7whxtwlvhNaI2qoKz2+65i0sqQEio4icyXnEYvcqj4?=
 =?us-ascii?Q?2RzgdUHcqzmdGq/NKVCTkzyCMPdUnORsj7OKw3XrAzwI0uNJIrUZTC134NAh?=
 =?us-ascii?Q?ATo8anGFPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b96f1a4-7b83-4b63-ce48-08da1160059a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 08:42:13.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gfWtx3nTcm9T+Q37mb5WGr0V2DTVxtnpWaDeg8SmppQdHSsG0SlWLwEFcobQkC5eMghpCHMght2sS3jdnbLfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1488
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
> Sent: Tuesday, March 29, 2022 1:38 PM
>=20
> Some of the interfaces in the IOMMU core require that only a single
> kernel device driver controls the device in the IOMMU group. The
> existing method is to check the device count in the IOMMU group in
> the interfaces. This is unreliable because any device added to the
> IOMMU group later breaks this assumption without notifying the driver
> using the interface. This adds iommu_group_singleton_lockdown() that
> checks the requirement and locks down the IOMMU group with only single
> device driver bound.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c42ece25854..9fb8a5b4491e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -48,6 +48,7 @@ struct iommu_group {
>  	struct list_head entry;
>  	unsigned int owner_cnt;
>  	void *owner;
> +	bool singleton_lockdown;
>  };
>=20
>  struct group_device {
> @@ -968,15 +969,16 @@ void iommu_group_remove_device(struct device
> *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_remove_device);
>=20
> -static int iommu_group_device_count(struct iommu_group *group)
> +/* Callers should hold the group->mutex. */
> +static bool iommu_group_singleton_lockdown(struct iommu_group *group)
>  {
> -	struct group_device *entry;
> -	int ret =3D 0;
> -
> -	list_for_each_entry(entry, &group->devices, list)
> -		ret++;
> +	if (group->owner_cnt !=3D 1 ||
> +	    group->domain !=3D group->default_domain ||
> +	    group->owner)
> +		return false;

Curious why there will be a case where group uses default_domain
while still having a owner? I have the impression that owner is used
for userspace DMA where a different domain is used.

> +	group->singleton_lockdown =3D true;
>=20
> -	return ret;
> +	return true;
>  }

btw I'm not sure whether this is what SVA requires. IIRC the problem with
SVA is because PASID TLP prefix is not counted in PCI packet routing thus
a DMA target address with PASID might be treated as P2P if the address
falls into the MMIO BAR of other devices in the group. This is why the
original code needs to strictly apply SVA in a group containing a single
device, instead of a group attached by a single driver, unless we want to
reserve those MMIO ranges in CPU VA space.

Jean can correct me if my memory is wrong.

Thanks
Kevin
