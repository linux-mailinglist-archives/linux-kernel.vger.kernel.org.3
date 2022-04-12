Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2B14FCCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiDLDSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbiDLDSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:18:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8883137C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649733357; x=1681269357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WF2bogzPqR33LkBggtPXRbS2Pmr015N+JvUhgqu8uyc=;
  b=Q06vNaTULTYoQFZA1uStH4iAdljjhUtSoVaNyiG/XqpLoXi63dZkK1wy
   iXg8kAua9n74MQS4OjyDXHfUDuLcgv4huQ/QoUyGOu5xfY0h/geSiJz06
   netS6Re1WBSMRo1QsSrh4JlMc8yWArkSVsjQY3iU9jaIu8azQSWFPP6nf
   XwpcJb1q2lZepVMywCU/e90eUeUgQl6dqfTAbcpIaZfQeeg4gClifdiWQ
   NaT5Al+sZ8u5L1ScECD5tG0lAJvMHbD3XhhHhoKYgKOiZMfoShetM2D3d
   fNljJwRCFxXCzaaXBYYrp57AeELH5+GfCl45QQR2tyRS9d7O6gXYqvE0k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="287278926"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="287278926"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 20:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="699640485"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2022 20:15:56 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 20:15:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 20:15:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 20:15:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 20:15:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXS9rxYXsWbFHChlZUsIeON9Yes17TJn82d2AUQCGTxi4qVBp+WOrK8GFkQ0u+RGUt+kBIXfy8VIM/+ZrrU9DVTS2i0Lnx5Dbq1PNPeuyKPrAPIwgsBspzt3UP50Tj/CvVlzfd1MREG0YARwCsKbrAPFy44da6lMdWm9QytUsBsNYkyghj/UDd1aFSVbqvDdc7Rw10y11CZ5FZ7YlX8ZtxvZAizsNse4Nd1LojF9uUDnvmBX0Ru/0JfZmHIN140QDH7WIq4Mf4YidHKVVqgstmauBibnXsEuyTv/C2Qg2HlnGCtKfJbq8pqmiwUZOXtgoOwhmljXIJzMKVAkY+VBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG9u+HE9a9Gj8siQXc2ciERF8Fj1Q1tF6i1fapozoLU=;
 b=BlU8KqtyriFYOiVoP07ae0fEL0EoZxldFphXNfT1x4sHAUYfH6Bu7TAc2qZBF18RmkLTvbDraydXOEosO3dVyWm1joDTzWZKlH3BpmVB6DvtKOrUurF6o8eROgf0RJXV3crMMCv3EuiKfQOTY7eqjhy6wDxVqUJPaEx5Jw/en7aU7L0eEXOdGLnvT5djE0peZq/u9gnV5P5iz+Llwdl3A+IVVWOBvjX2bodFogvGMXmDTNOzefLknKxgUaE7vEVZgZMDto8LJ3PvtiWBCImtNRcLvahyKyQbtnzXTLRUSKYefbllZuubGzbkTj2l4ubI6SPlDGW0IdZydYp2gkjrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1713.namprd11.prod.outlook.com (2603:10b6:404:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 03:15:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 03:15:47 +0000
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
Subject: RE: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Topic: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Index: AQHYTMWQdMRj1LtW7ESP7xJUKRpqwqzrmnCQ
Date:   Tue, 12 Apr 2022 03:15:47 +0000
Message-ID: <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220410102443.294128-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7393e724-1f26-4ec6-83b4-08da1c32bd33
x-ms-traffictypediagnostic: BN6PR11MB1713:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB17138C9C86A35D79D608F2978CED9@BN6PR11MB1713.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JUCFPSRmd9bLWIUoUY1je14Z/AeGAwK9DiWLgjj3+YC44fWFid8W9jN5QEPhBhM/xr2t4iXYprZj7xXQKtSkRr505Hp3EoR0Qb9wVTRrRMafWL82+MLvURmbxL4xW5f7/s2DXRWa9TNJ0fVqpgQ3/59xVRwSOeIKKn53JHXz61dC4qjNm7F8zDZDdsgu9oW3qkSSlk5EizkuT55qAMuSkaV112mRNRIdJeRsdmjLB9t+5wqaTBDDBLggeLRNgSUxywQW3qFUlr7NCnruwKFgT2uQk1EtD6Z8mj0FXOVanFZGraW4jNELuT94Iv/7PqLnkVaky4WemqD2MymUE7UHvCq9df7FV421VALf2OzaJ9MLtYqFZejE2ZUssVTyeatCqpXmqJGHMwYkCV0KqO0HHb8FB/3yPlzdUMJACIGEMLpBd92Abhbb2BPDsIKqZ3E5H55fgP0l4PxeToRvVMfKvfbIdSneHnY35DzFbpyGOuXlpdfIS7QzPEZ1YqjAyNnTsU5okdGsyurOqcclOn6FlKzsRytFns3+u0QnMMWJWQe/gkyOZjzth0kZOr6aMAany8BU3qNpYsofE/E4UEhnTB3E9+sSwYG2fSivzcMNZCnl/ZmL17KgqcqiFhBnKQV16N8IY7Pvzy2cNTD9tT3bVJrlMLgYpOinU1CUH/6xxhzx+y8Wc4UUWZDtU4lGCO9xkC2Et5sO6bl9LLNRpftzSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(33656002)(316002)(54906003)(2906002)(83380400001)(110136005)(9686003)(55016003)(508600001)(186003)(38100700002)(26005)(122000001)(6506007)(38070700005)(7696005)(52536014)(8936002)(4326008)(8676002)(64756008)(66476007)(66446008)(66556008)(5660300002)(76116006)(7416002)(66946007)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t/rhvv48WA1O9TMLjZ/SX1Lpm7bkC8IWfi2Ga6wRVXlkw0kU6xPFY2KAbMNo?=
 =?us-ascii?Q?39+3/3KUicvQ7qQtqE3jzNaRDkG4vLez9ZVONBIe5FM1yHaGAGaN5H5kTx+t?=
 =?us-ascii?Q?BRWao2ckjba+vl57kvMFZoIIjMnczgzvIrcHY6jLL/6/Htbudc/IXoUAFM4B?=
 =?us-ascii?Q?RJ/tLLnPBvnLQ6mWwPqFmkazJkzmR37VknM8iBo6vGHxVcwOIhmb7mck0lHA?=
 =?us-ascii?Q?ofonoIvKQxjASLs/pswlY2VGgD1gGqFBeRXTDGz/d0SfPoMpkCNuSoXSQniS?=
 =?us-ascii?Q?hH7awJaf2GlUT/yRVEzfzWmKlzYRhxtiz8rVUDFNsnr0a3eUTfeN215MLJSW?=
 =?us-ascii?Q?qngN1KckYi6ZjYBvgt2kFpSb4+aH4b1r2XQ/lNPJ04PJRxlEk8aNlxyXkKNp?=
 =?us-ascii?Q?Jzv6SooTIvXQP2eylDPehQeFI6cyn8c36F9tf5dUz/0pfoVuwH6Kqu4Xp6iy?=
 =?us-ascii?Q?uFexbJgF3moCwCmxminyaG4YZf7QA/xSyRpjR6AETlLvGrpIgI0xdRqD9yaY?=
 =?us-ascii?Q?zw6O/MpioXxNs/RDeJsqU7MVum9cqGhqHYZVrFkrMse88Ujn9ta/8ExwlwCq?=
 =?us-ascii?Q?LxB91m8QADPtgU06xi2ojJg8avyo0ALsErPtpdkd2Y994slj/IDi2+FsxxBG?=
 =?us-ascii?Q?mkZyArUFaMRZA0JaaUdyNDJUVNpWzMAxHl2OdqSUOHwnbG3EzIS8xUJ23PXc?=
 =?us-ascii?Q?2aVXRbd04iEcvzpq9u15A1e0ZWsIurB5hdBYS/hr8v19yZAcQnC4j8/AxRYF?=
 =?us-ascii?Q?qrxaNuJ0kLPLquaPCYnAW8dS7kt0hXUdI4WcyJ7Ldc/95F6HJfnpo4e13Lqi?=
 =?us-ascii?Q?ich3wvck/L2pcc9Q1rAtNfeXzq43mmvtH38E44TPKs7fiSwNO1EcMAZlnOd+?=
 =?us-ascii?Q?AGWBYxkzZaHt1pZ+T2/2lueh/IVIhdsLBa2HIErhUGxoo8y6Ia8C5zRM82GY?=
 =?us-ascii?Q?ZM031pnKMsDguL9B9D15IrklyhIIZqItcWFRMPdOROftBVDvqD3JzkOyhTJ5?=
 =?us-ascii?Q?ZF6kGwKTJ/vypn96SR8Z/G5TQTXsuRQe/pXcQBnKVNo57LRL2fLdvS4eborG?=
 =?us-ascii?Q?00SGS8yx2qT/quE8OppDbN4IbyAOHH596MhYyNeb9svSQSovCoqDuE5j+7Yq?=
 =?us-ascii?Q?tvE+ehuu6ksHE2He0WVR0O1t8cH+fDxTmEcdxZhuV+my8Fs110/Ebg0LqbGx?=
 =?us-ascii?Q?RTfAqmhghdPaDZ0fWmkoKehE05u3g2Sbn4sRin0PFlDaDMvO0ELa9ObvQ34z?=
 =?us-ascii?Q?2S/YJzeItm0AHqbFPhq6hglBFrwI80t7J7UTT04zXvLbruq1iSP/SCUzLLW8?=
 =?us-ascii?Q?ot+Tu/HQ+YOq4EyEaMcMtq7tOcvEvnU5wAFDiZ5g2ywJaBQHfz+0BdYbZFTg?=
 =?us-ascii?Q?qr9cDJBPDO+U0ASmhz8sQhdpaYWlQ+E/qIi3Im060vDI+mrLCcPww7Cb5iOD?=
 =?us-ascii?Q?4a9svkL5sf429S7KPwvCwdo7E8jEfihbxqYqnthmB0L4KoGd2+QbZeMSZHJP?=
 =?us-ascii?Q?EmyEnAwI6un4XWDMNAI6andaIHnffI5NEdoUqQ1AkuP2iVCsmhPPHBHJ4BQv?=
 =?us-ascii?Q?mMVnzuaM7JcGztrI5NGEAVrtfkmSEkENAXTjpnEO/MbEjgw2i7DLHKKIW3e7?=
 =?us-ascii?Q?sGBvTdDAncTHGKMIeKjtQScUxl9bEgoxcHtQcW5wVbAQmkupqzjgAqCCV7r0?=
 =?us-ascii?Q?ASwmhZyAa/lHCmqlBi8yLU0Yti+8HOsDmlheDScmnApToG2aROMAsz+1bVoB?=
 =?us-ascii?Q?WsTO7ZUj3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7393e724-1f26-4ec6-83b4-08da1c32bd33
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 03:15:47.3152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7o2eT9zya2gUDomHmvB0Oo/t+a4Qc0bMjtFWRz1Vyy6SKmqfwt1iYVfrEH8WiuQxWgFdJbdHSCLmrpEsyVOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1713
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, April 10, 2022 6:25 PM
>=20
> Some features require that a single device must be immutably isolated,
> even when hot plug is supported.=20

This reads confusing, as hotplug cannot be allowed in a singleton group.
What you actually meant suppose to be:

"Enabling certain device features require the device in a singleton iommu
group which is immutable in fabric i.e. not affected by hotplug"

> For example, the SVA bind()/unbind()
> interfaces require that the device exists in a singleton group. If we
> have a singleton group that doesn't have ACS (or similar technologies)
> and someone hotplugs in another device on a bridge, then our SVA is
> completely broken and we get data corruption.

this needs the background that PASID doesn't join PCI packet routing
thus the dma address (CPU VA) may hit a p2p range.

>=20
> This adds a flag in the iommu_group struct to indicate an immutable
> singleton group, and uses standard PCI bus topology, isolation features,
> and DMA alias quirks to set the flag. If the device came from DT, assume
> it is static and then the singleton attribute can know from the device
> count in the group.

where does the assumption come from?

>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 67 ++++++++++++++++++++++++++++++++++++----
> ---
>  1 file changed, 57 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c42ece25854..56ffbf5fdc18 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -48,6 +48,7 @@ struct iommu_group {
>  	struct list_head entry;
>  	unsigned int owner_cnt;
>  	void *owner;
> +	bool immutable_singleton;

Just call it 'singleton' with a comment to explain it must be immutable?

>  };
>=20
>  struct group_device {
> @@ -74,6 +75,16 @@ static const char * const
> iommu_group_resv_type_string[] =3D {
>  #define IOMMU_CMD_LINE_DMA_API		BIT(0)
>  #define IOMMU_CMD_LINE_STRICT		BIT(1)
>=20
> +/*
> + * To consider a PCI device isolated, we require ACS to support Source
> + * Validation, Request Redirection, Completer Redirection, and Upstream
> + * Forwarding.  This effectively means that devices cannot spoof their
> + * requester ID, requests and completions cannot be redirected, and all
> + * transactions are forwarded upstream, even as it passes through a
> + * bridge where the target device is downstream.
> + */
> +#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR |
> PCI_ACS_UF)
> +
>  static int iommu_alloc_default_domain(struct iommu_group *group,
>  				      struct device *dev);
>  static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
> @@ -89,6 +100,7 @@ static int
> iommu_create_device_direct_mappings(struct iommu_group *group,
>  static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>  static ssize_t iommu_group_store_type(struct iommu_group *group,
>  				      const char *buf, size_t count);
> +static int iommu_group_device_count(struct iommu_group *group);
>=20
>  #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)
> 	\
>  struct iommu_group_attribute iommu_group_attr_##_name =3D		\
> @@ -844,6 +856,37 @@ static bool iommu_is_attach_deferred(struct device
> *dev)
>  	return false;
>  }
>=20
> +static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
> +{
> +	return -EEXIST;
> +}
> +
> +static bool pci_immutably_isolated(struct pci_dev *pdev)
> +{
> +	/* Skip the bridges. */
> +	if (pci_is_bridge(pdev))
> +		return false;
> +
> +	/*
> +	 * The device could be considered to be fully isolated if
> +	 * all devices on the path from the parent to the host-PCI
> +	 * bridge are protected from peer-to-peer DMA by ACS.
> +	 */
> +	if (!pci_is_root_bus(pdev->bus) &&
> +	    !pci_acs_path_enabled(pdev->bus->self, NULL, REQ_ACS_FLAGS))
> +		return false;
> +
> +	/* Multi-function devices should have ACS enabled. */
> +	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> +		return false;

Looks my earlier comment was lost, i.e. you can just use
pci_acs_path_enabled(pdev) to cover above two checks.

> +
> +	/* Filter out devices which has any alias device. */
> +	if (pci_for_each_dma_alias(pdev, has_pci_alias, NULL))
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * iommu_group_add_device - add a device to an iommu group
>   * @group: the group into which to add the device (reference should be h=
eld)
> @@ -898,6 +941,20 @@ int iommu_group_add_device(struct iommu_group
> *group, struct device *dev)
>  	list_add_tail(&device->list, &group->devices);
>  	if (group->domain  && !iommu_is_attach_deferred(dev))
>  		ret =3D __iommu_attach_device(group->domain, dev);
> +
> +	/*
> +	 * Use standard PCI bus topology, isolation features, and DMA
> +	 * alias quirks to set the immutable singleton attribute. If
> +	 * the device came from DT, assume it is static and then
> +	 * singleton can know from the device count in the group.
> +	 */
> +	if (dev_is_pci(dev))
> +		group->immutable_singleton =3D
> +				pci_immutably_isolated(to_pci_dev(dev));
> +	else if (is_of_node(dev_fwnode(dev)))
> +		group->immutable_singleton =3D
> +				(iommu_group_device_count(group) =3D=3D 1);
> +
>  	mutex_unlock(&group->mutex);
>  	if (ret)
>  		goto err_put_group;
> @@ -1290,16 +1347,6 @@ EXPORT_SYMBOL_GPL(iommu_group_id);
>  static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>  					       unsigned long *devfns);
>=20
> -/*
> - * To consider a PCI device isolated, we require ACS to support Source
> - * Validation, Request Redirection, Completer Redirection, and Upstream
> - * Forwarding.  This effectively means that devices cannot spoof their
> - * requester ID, requests and completions cannot be redirected, and all
> - * transactions are forwarded upstream, even as it passes through a
> - * bridge where the target device is downstream.
> - */
> -#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR |
> PCI_ACS_UF)
> -
>  /*
>   * For multifunction devices which are not isolated from each other, fin=
d
>   * all the other non-isolated functions and look for existing groups.  F=
or
> --
> 2.25.1

