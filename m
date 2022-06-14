Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A4854A7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbiFNECt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiFNECq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:02:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAB117E0E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655179365; x=1686715365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HMVZ1mx1L0/bCO0joI+j3q/1Pnw6hZ24wUua92yELqc=;
  b=EYGx3Kf6zYZ7CuMfnL9SbexUfZNb+26zeIrAdNwANTlXcWf16s0DP+RY
   jaN/GjCYyZyyi6S9tGrYW2boQrLOKkS2OSiag7bF7QOgXqQMCezIEm6+h
   F75efRpE10Otfbi+mjMDkd9Wy7u1rf78dhRNDmX0nTTbfGfrYq9H1kIXP
   oF3gog4Js+rOYSY94qMAP/2dBAreQ2clihC1DB1P+6n5UoishWSqVadZv
   0VzdM1jIc90RY2IKglVlJ9cnWwg18sa6HZpostPwe+Jr2EvXZogq73FZQ
   JfPpqvvSwub69jWgrFhXz/2ZHnPmEswKpB5P2s35z0HTDxegwfaIfXRM2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="340164562"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="340164562"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="651787406"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2022 21:02:44 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 21:02:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 21:02:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 21:02:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBM+pMBDuIGYYdfokK7Ef9JiXw7av/c4U6TJaJut33itIPIhjFCKXcoMbAgxp2phVRpGO4h680oan30KP/QcbkWWtatULQjORuYMoDb7Us7tcAnf0Rt+t0ELsgGPVcgGdM0KPQY6/XiqnyrYjIlO2qVsIxfGU4AubyefF8po7mI07rOYdK8qRJQpWl1KAk2FH8GRrIsXZsM0OXJfNRIROain8gyfMM3R1ITJUQ46LSDV8POSbLsgYaw0viQ+VpX9ROUME0BPssHlk53s2FG/IcEbpBvIsVEi8CHvyC3mH+q1viLHq4eAEcPvUlCLcmn/aygSqw2JWmSsZKKYVQ8jmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF8LnWAJsOkMvZGjazkJKK1usPer6skA6jN9AJYLTbM=;
 b=a+nK8Klmc1l86ZgzFRfG02Bv7k96RRVcNKeyuCS+cgY4BrWY3NaAtHiOD4NJECF1HdrP9rzFSvGqwok5bYmdBl5epyZ67ldX4k5DefbTtqRLkxLzZnwpqbndSU5nxd69a1s0WNR++NVMdydba+GaWJPvgMDdYIiB2NWko/gh77xe8j8kOnqzwxFjmbwxkBRZvQmZTZsGQ7qhmQs6SICcLrRurHAKcVjn0pI+fO4Qf4NtgsBnV0IYmfbyxsTTJsWeWXDsrK4ya/ZOgtySbGcW5MtgzzUiYO9y4oyFCqUWzQKAoPIsz+U24HVdVmUG8ADULlwrjoBzvCQxNR6Q/12oOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19)
 by BY5PR11MB4181.namprd11.prod.outlook.com (2603:10b6:a03:18c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 04:02:42 +0000
Received: from DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::c5d1:fe18:c2f1:2885]) by DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::c5d1:fe18:c2f1:2885%7]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 04:02:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Thread-Topic: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Thread-Index: AQHYf6GWvMc4HxovbUuxK/w7aTPg8K1ORtLg
Date:   Tue, 14 Jun 2022 04:02:42 +0000
Message-ID: <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
References: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: cf5f4be5-3716-4f49-2096-08da4dbabaf7
x-ms-traffictypediagnostic: BY5PR11MB4181:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB4181DDEC85FE5D136D89492E8CAA9@BY5PR11MB4181.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wLR0j3LAXKrA0kcdKclQpeQN3dU1k9XUDCKVXOy2Qri0W8KkIb6eqjRxof2h0oapftd0LwWRstv6AfIwp0U/q1/82bdXsFe/GI2htNKddT/XCwu9i+7oyEIe5zKagX6QI5pZ9xHB7WFJn98dbSvSiJYbDrU/+skE/5vi63VYIijMDCaaQza14clsCDBvvQQKik1/T8wWiLj/URGmN/YFytQDXBbr548iQ5FZxeAb95wLDFIbm7HBG/aHgkJzmmv8eiMw9RI+/ITCk3ZouAy8RYtvPW/ql4c63rx8Z1JgL33HN5V8oTupcX7F2HzC67plCGPI0iiibnLKalkvjz4N0lJmKeRHm3z+swo3lYEn1FvqKYYGMgbnykGwmlJWtRHNrGq0S25kyk2PzKBc02c5muDNYPOmjDPmF8wX4BH/yCqMrmU+1nQJiyo4msG2AjXOo4anpRKwpY3GzEk6/fq82fHlDfRFSvFdI0lelI8wuhDZzPabNSYVi1p59zHTpeepOr2Et3JZcBBuMkUB4icvMxwPxoGzIOxMe5DfzSSJ5i5ezQuzmmrKMQybIVSrGgpDePetmpO33Yf033nzU+E5oWeQ5qvkyKJ1J+Y5MSYriKt+dRkJxvHTCBaJJgq8TeBGzZml7vdm3Hd08g2SvirdTaP135+YyX6ZF6I4wTWzTTJh9S+lCkCX8n2uAq05YNNUSrCULdqBSUxsYTc8HCX2bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(82960400001)(4744005)(33656002)(2906002)(186003)(54906003)(26005)(9686003)(110136005)(122000001)(71200400001)(38100700002)(55016003)(5660300002)(7696005)(4326008)(8676002)(66476007)(66946007)(66556008)(86362001)(52536014)(66446008)(8936002)(6506007)(64756008)(508600001)(76116006)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6z2ZHIiwGNCK3NkfnPKBAuY+Fco4XpXyAZ3Zz3HnUjhEoJKAKKhE3zHayPtK?=
 =?us-ascii?Q?Cd9P1/rZPgmXz+xKwqE898FaLGdbKoOpC/InJxMcuC7s04w6UijSEZBoBJzm?=
 =?us-ascii?Q?YBPz9n34i7ljrLqGnPUvxnXMgpF+KqGKrI1dUgJrUE1a78ZQGRlMSTJ9/LmN?=
 =?us-ascii?Q?h4cuzJqXnf7/ShgFJQZ8SCUTc/aSfVUXB3e2SITP06HmQuGFuxUMMvBgGUie?=
 =?us-ascii?Q?XyfjkEsYvzEFuNG28aavStroUIBvDYgKp4lSTv7lwymqAjEkNybFUhYiyjq5?=
 =?us-ascii?Q?GgvbYk1o73NzDC5WvfiJ6VpdoCQIIi5p5B+e+8DQcZxBrwbeap1q7/chef97?=
 =?us-ascii?Q?O03qUafUWPKXJAsCCwWpo/yvXa5G4UWzggLnQKTs+7pDiMbmBvkaDz6J/XLR?=
 =?us-ascii?Q?iBzepFb1XIPDxggQ8qjPzzjlYZTeFIWliP6IHT/IFmiBz4X4tSP/tSnDEfEy?=
 =?us-ascii?Q?ju4Y2/I7Jq87trdB1KHJx/jQhFHRq9CFO8vhpFxQp7YQ2jXBiDjn98dFIOav?=
 =?us-ascii?Q?H8e/zzc8pmNstTmjGx26BOSX7UQ71+rL2ZMbaL86BttR5TwN91/TL36fuMCh?=
 =?us-ascii?Q?JTLsLefhg7rvNMn3DsJe6vTChlWDya6vYaOE+ahXOv17mkygOQkZbQW1Z/Xb?=
 =?us-ascii?Q?rHt63DcBYl2c55w9CSg0eVqkC8CAeHrkTELLFgxl00gotjAQIsOjxpmq+Jsb?=
 =?us-ascii?Q?8KkDgzqAnfM3hZ65UIk0BbS9xdiNlRLCKWyGrou3IjFZfzSOplNwF9Om6mVN?=
 =?us-ascii?Q?VxH5eKETLAtjQZElhl9ZnIko42wSfZX6YkKLXc9+vOvSajMhOVWtkVeLurhJ?=
 =?us-ascii?Q?k0FpIuOl6/w79q/g3Cd45SxunF6DANBGVOSbbqVKwCTkhEHIpBdkeY5qGLPw?=
 =?us-ascii?Q?T2zItPKEmviHcvV9x4bmQ9FH/KcUCCNRKinMQmNNpKS0TyaX5Td6YpSgE2cd?=
 =?us-ascii?Q?Ph8kRXi7xP/GKsbEMesaMp3tLQdCR4ksAxWjoWKJBMYKiEMC8cliXxPyMe5W?=
 =?us-ascii?Q?xMXARViGPTKVH+DfBxBEIxQzWQWQOEOssvu4EBI3QrTa9vimGkjQrjzvaC6C?=
 =?us-ascii?Q?rgYKIxcNQTSjVf1oxhtTXYWgCkRArnt8MLrbSIkuRaC4+i4gdb6RGn239X3x?=
 =?us-ascii?Q?f03ClPiT083Qa1WaWetSg9AE/0nDYLEAIzoGFB1KcHK+v6e3L9QW8C4H/ri7?=
 =?us-ascii?Q?+dZMgGVAtQUSuNSfhqVINi2TrCbQnH/Hj5w3900R6XK5HLbydDyILvR0Q1Le?=
 =?us-ascii?Q?uNnXeZq2yM0zwab9vjy0ZhVN2h1Or2aLxJHXAldWrPmTcPfKzUFxsL40JeGi?=
 =?us-ascii?Q?HjKsSrqeSDq0r7OQo1QeiFdQ21i7SruFarT8URPsjxYQzFH30TITOqxjbClL?=
 =?us-ascii?Q?HcsLtfnQS6mfHaym0EaH6wccv9vDoYNtGAVoAKnrXzuSAiWf+99yVkg7ibXl?=
 =?us-ascii?Q?0U4uCcT3E76/NuFv6LyTAAXM9wx0qH/fXed7vbx7NeGypKlu+yXvlWIINexA?=
 =?us-ascii?Q?kSn20NHwz9ISDjtbEizXQapvSjIDRpP4cPjIhEc5bGkbV3Xdno90Cn3eXXMS?=
 =?us-ascii?Q?GIlwj4lPT9Zi9QDb+VC9P2ncj2PJM1gCcW7o99r9vCqPfeaQzt9ssegnJwkA?=
 =?us-ascii?Q?79+UKza76tgPZi/jo7kz9SrX8A1nrqn+C0kndxB0VDJZiNzFnBThCRNTbwm+?=
 =?us-ascii?Q?5kQJmM5V4eBO4p4Qw8qpbI25v4/lbIte4T9tJZ8vQRBc7+jR2adDZJvb9EPd?=
 =?us-ascii?Q?O3BMwyfAyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5f4be5-3716-4f49-2096-08da4dbabaf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 04:02:42.2048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMgnienfOyKNXaq+DDEd8L5Hoky+TjnFwzp5WhPrnllrZORLNimOylbIy6xAaLby8ZQFgV22ANjyB0/h9RFKrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4181
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 14, 2022 11:44 AM
>=20
> This allows the upper layers to set a domain to a PASID of a device
> if the PASID feature is supported by the IOMMU hardware. The typical
> use cases are, for example, kernel DMA with PASID and hardware
> assisted mediated device drivers.
>=20

why is it not part of the series for those use cases? There is no consumer
of added callbacks in this patch...

> +/* PCI domain-subdevice relationship */
> +struct subdev_domain_info {
> +	struct list_head link_domain;	/* link to domain siblings */
> +	struct device *dev;		/* physical device derived from */
> +	ioasid_t pasid;			/* PASID on physical device */
> +};
> +

It's not subdev. Just dev+pasid in iommu's context.
