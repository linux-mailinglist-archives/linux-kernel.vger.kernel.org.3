Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2226556971D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiGGBB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGGBBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:01:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9A2CE22
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657155714; x=1688691714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BcOVqvIxGV/OG0qfw7LOoJC0kETF/XTh1+mlAlaKiD4=;
  b=nREPb1fgQvFxF9fq0xErrSvOqzGeg1lxA63PZOP1Z5GaKmHh6aNVv+hU
   ICk1s2/V1B2xFF3jUVOVOrumaMmu9eL0vIqyPhUDT8EUdEXH3op86rs1n
   L+fd5xT+tErXgoJVwBRUOCqE1Qe+gVdU+u7mtYQfkJSa8iYfRkuFnhKra
   7mAwLmC1wOAXI5LO85FkzSbpl7uNe4L2Z6xvzPuVp91MI8S2pwqeSO5JO
   3tB7rYq7frl8NcOUZ2eWeoviecnA3Ift+blEV1ke6U9jLSM+N5MYiWuju
   l+u+EibwmLCGo5Gl7JKs7MTa8utlyFz6Bb8pxsf3gKl4fc9QNbldPSBXW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="370219842"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="370219842"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 18:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650905131"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2022 18:01:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:01:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 18:01:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 18:01:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 18:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFRODdCHIxpnu6zf1IToPymDz2fwFtKZLNZItrbxXhPPo3uOyeYMxo6ilI+TUzeNy/RPZZolgreE0ixXhwLgvZ2ti36+VjawIFz/Q8jke3RbuhwL/aBU02AGMHljXKPV0COKZMmZTbVRkD0JCdvSvSaSCIujHTecnXpHeM01ozot47Q6HY7m0Us3lelyQrUeDoovWKSuwGCqROoFG9hLVxlwD1s6YA/t46zBjTBY1TaPunmUbaLBWqD4r4PqBeBmQBr6ZXH1JUeoJpII4n899VFedlE8mmqqJRvRteC4N5CuzddVsAugnUXVV4a7XFwzlV1CwwvMni8tPDn5KDAglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcOVqvIxGV/OG0qfw7LOoJC0kETF/XTh1+mlAlaKiD4=;
 b=XGz+TUpI3C/aetSKQZN8I/tkErqhYGOG8h1LPgyzQr3QdGjeiXSGTl4oXMr2kkam5Ao6eC1LPXqS1tcHCNG/O8pVbAZyJOsqTSPdfC8Ti4hxJLg45yyZ7HVLUnB4vpndCfBki2Og7zysr5XultbBaBIhbxmXAuVIMMqSjuCNvKf2XvOg1V/BjQBH4oVJujDT1Mi0weVGUHqZx6i8BdKep+7u9QDrPKaRhnEWWIfQqB8H2cH02vQHhJRWZ6p5hLRY7bBFeQkFBDf7ej6fr6Vc1ncEy/LNVYCILyPvWyQvsec1hYpPwFKU1bgBFeaE0Tq6GwED+obxyv+GCbvn4Lhzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 7 Jul
 2022 01:01:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 01:01:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Steve Wahl" <steve.wahl@hpe.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] iommu/vt-d: Remove unnecessary check in
 intel_iommu_add()
Thread-Topic: [PATCH v2 4/6] iommu/vt-d: Remove unnecessary check in
 intel_iommu_add()
Thread-Index: AQHYjbeRlDV8cyRv8U6aCfxbf1HBRK1yHr2w
Date:   Thu, 7 Jul 2022 01:01:49 +0000
Message-ID: <BN9PR11MB5276A4C05EC2896EBD02FD968C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
 <20220702015610.2849494-5-baolu.lu@linux.intel.com>
In-Reply-To: <20220702015610.2849494-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dbcc4b4-8bc5-4070-420f-08da5fb445c8
x-ms-traffictypediagnostic: MN2PR11MB4648:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqDCmWmhr4W9EQ1HDz54v2h8rJzGzbItdtn+dTd1gqGhErw5Z73L6Qam52VPzbvpgjyuXsxEyqVz7sYMgvKZRTORNU2kF5qsdONp+k42n9PiDn/zWl6S+uJMz/8Pf7Hbl8iULg8gTsIu9Gb+NiA2/t5QLkwbMWgBkVO5mCAr/x5cZqvG27SNW/Wht/M+SeMAjjSRMXBT3tCiLlrkXRB4EmKlYCyJvfm8CQpM0qV4kO4viwQ7jVTAakb1+zABYGuatOUD+rCAsXMXyQzl8/fF+7EOhIUIVB1Y/LbwsJEZILQvofdSCgeN81ffHiZAParLJvK3RJe/eFLHdgJQALCc8diOc4CziDkOerU1PRNUf7bdS0ZJ27mzC8TB8AwTynxVvNUYp0fxAxoVnQCSa1Q31mFQOK5mlkrVRCwissGJRJ256UknbSpZEinXeEw3wttGyHEBIkMeyi5N1Vsk25uWtK+Ejycz4ciY41IQkKBqdybbOqK9eVYrF9RpK6155nRA8VHzHL7NRLL83n4qbfap6AgpFS0gFGAmrs94sQ1abG5J33ut3WFVyp3WRV74VCCz51nVaQ+CGC/ESKBpIykucWJjNWicMQx0ecg/y5kCgSQpFfMwRwBJo3tV+Vezf9/aMFb9sZm1w9oRaSszefbPu/jNj6JrA4GS3jPUJT4O4pOQxdpgoPlghQVzWY+V0JdOeAqPjaWVutTFsvNK4nBqfHbA4E9lSDBFHoNrpiG9r3k3uQNbscM5cRL9VrtItQ0EZAVbhRFHsOMvQMWo6uJFHbeHllvGZ/wvWxKlVIFLG/9uOvxgOClKpnZDAKqrr1RJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(136003)(366004)(478600001)(83380400001)(110136005)(54906003)(41300700001)(4744005)(122000001)(7416002)(55016003)(9686003)(316002)(26005)(8936002)(52536014)(5660300002)(71200400001)(38070700005)(86362001)(66476007)(66556008)(8676002)(38100700002)(186003)(66446008)(64756008)(66946007)(4326008)(76116006)(7696005)(6506007)(2906002)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3SqOxNOJHr24vyHWnjBlf9d+NjjTFiAScz2VKnDOz8qblpTN8H4srnqXYDKt?=
 =?us-ascii?Q?q0uh+hAITKI7ZWMID7+hr1y1NuJTsWidvr/DxJg4VHCED04mFxi19jHOz2LA?=
 =?us-ascii?Q?aH6OQi6nyRbtEccBag0P5hAhgqpbFgo+UzNVLD0U2R4M53PWdZpLmD4duUZt?=
 =?us-ascii?Q?1cGnTcJQbt8xasXOXL2m8thmayNtUsBljKy6TB86iCur+PQ603NiqcWduMF8?=
 =?us-ascii?Q?5sPeMIZUitfDtCgyhIL7ur3qD9OPJE0HEHPyI/eQqEuIOrkxl9NjQ2p8QLTM?=
 =?us-ascii?Q?ur+A7XkHjI5MtitYAUfeXHZV8jEKkRjhWlsF3tTHmEf3CJNVtGBPMYQaujzx?=
 =?us-ascii?Q?js0ha9uwUzzukvPcOFgGaJuvSm+FC7SBP7Bj0okhBqPCywx9kxL/4hVsDRs8?=
 =?us-ascii?Q?DbyEZJbiASjTnabyZLEpUQKpC5QDzC7A45pibdqRVzTZOD87fj0Ys9v4jBvX?=
 =?us-ascii?Q?7cURD68dvOsYjkx6N8JtcOVkfkt+n3gMKw2hUpUWqdErX261TiIBBLlaVMe9?=
 =?us-ascii?Q?2tzEOOS8BxjeYPQrKk6ZgSgLwd9kcO+1GXGXy33qjuHsgo6jWIyeHYq3P/uK?=
 =?us-ascii?Q?PdNWaQ+z4s12mz2yUuJ0euBHQnj29xru6jigT5PeRaqUsTpzL1tYDZLDduwL?=
 =?us-ascii?Q?K5CGDhzEDOo3vcbbhzu8Nmhas4vf2r+yTPJoY9ONWHgLsT/mtBo3yEY+eH+W?=
 =?us-ascii?Q?4lamfJeV1MelsDmli5g/QyjdVhh3v229DpyqZnXAgPEnRerj4AsTxIFtNSLU?=
 =?us-ascii?Q?uSRL1vRUiPPOquhAnhQYaaYzJ+2mItRPvUz2PkHngxEjho0bJ2aPP1kAcUtq?=
 =?us-ascii?Q?h5FI0AGY1GzX1YURE3fWREN6n5YlwV69DGRwAaiISaP2rQDKseZiz8L74Ure?=
 =?us-ascii?Q?PAhBdQ3kqVHsbj+IXdl+XRIEFIYExqYj0Zzrx90sSFakUaA0MNPFFGT30BFv?=
 =?us-ascii?Q?H6a3ARR+ciyrMSCwbp84lnTVhh7t9tpSpdHYXXVZFQNRetTayWgj1ahyVKsf?=
 =?us-ascii?Q?8FAATlh7p0wNu42iwU3snXDNsWlnf0rPevdniP45bYLGADAMruJP/C/bfit1?=
 =?us-ascii?Q?8MaAo2VfiGPHs+NiwK+UXlPrZG2W5iKWCF7Ej2KEWxdqVekTeQ4JURYRIjtl?=
 =?us-ascii?Q?e/CpXdERUC3tsPMCun35r0AhIf5FfwNzaZrzhBvVJeffIHIj6cOAwynq1KkT?=
 =?us-ascii?Q?z52Ajd1OOpxelA1fpYrMuX0q0eXDI9sAc7QyxVEurL+ltYOHv7IYAbHH8BP3?=
 =?us-ascii?Q?FUG6BtK1fsdurra7kf1Q/uAfVXj4wsB25ieRjtz9P0pPAYP8P0oURnEM4OGN?=
 =?us-ascii?Q?5XFvpgkN0vZqGwpvsQJHjK/1SulTfbuPwApBijuvNSq51TXl4gMyQTPliVfT?=
 =?us-ascii?Q?tFXa2m1MLIgbkvF3MTO4bWx6bNT2BTveky6EdusVpNcTVPmJiccqQWGgzjcw?=
 =?us-ascii?Q?YjhBpsxXAFGpFnuuxVKo6OLGYEdi+5DW+JOx3myi4kqj2c/eFno/QVurvXFT?=
 =?us-ascii?Q?jrKIRpRr6G6YWkHe67vMeOyb1B4duqsaEYdQ/+rYwCTAu8/3BdX9J4bRvA32?=
 =?us-ascii?Q?Dmv9NeNu09e+9fi+Tw2GHL6iO9i4i9heFjLFPxGg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbcc4b4-8bc5-4070-420f-08da5fb445c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 01:01:49.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdE3Z8wwXCMbwiQIwO8+VCUQ8+dRHKdiSL2sZIdpSkgpvpBMW/N1YxpY/GIDBz3i0hPCBFaX5541EjRwiSEPYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Saturday, July 2, 2022 9:56 AM
>=20
> The Intel IOMMU hot-add process starts from dmar_device_hotplug(). It
> uses the global dmar_global_lock to synchronize all the hot-add and
> hot-remove paths. In the hot-add path, the new IOMMU data structures
> are allocated firstly by dmar_parse_one_drhd() and then initialized by
> dmar_hp_add_drhd(). All the IOMMU units are allocated and initialized
> in the same synchronized path. There is no case where any IOMMU unit
> is created and then initialized for multiple times.
>=20
> This removes the unnecessary check in intel_iommu_add() which is the
> last reference place of the global IOMMU array.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
