Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D51A5115C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiD0LIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiD0LIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:08:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E95997D;
        Wed, 27 Apr 2022 04:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651057392; x=1682593392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B6JA7SdY9vgsdCVKdMpLILuW9xLoXkB4R7IxljdKoqA=;
  b=O23Q/t7MJ7ZxXieF3CfSW3owl/RMNlVsqYhbWPiVsCREw69gjHgSBrMU
   srHW7XlxImOnrWYWCiac/3rCYgP5Vm6cQnTUIUsSENQOjl1fNXyG9pByY
   0sMlsEAygikpSxoTQmi1+Ad4AbJv3M5gUJt2JBXOFtom1AxRdcZMj5api
   hYohR5whtuZsc4ETr60HHnuVBqCFR3Yg88rREEQvQxvOcLaEkeKR5L6gz
   s+D8l+WmE9chcP6zvcenrtiRTE4OKonyAmX6F2Q+q3BZN9nJX5Mcz1JWt
   ErnQZ9cOcAzAtjcK4cdAOp/dJ8u+QZ7KXqqhe4oOuAS8CtMPwyPXrRrKd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328822755"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="328822755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 02:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="705471683"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 27 Apr 2022 02:51:50 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 27 Apr 2022 02:51:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 27 Apr 2022 02:51:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 27 Apr 2022 02:51:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 27 Apr 2022 02:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njd6g3pNIElDnROUPMXZSm7vq/yU55rFjG2S9m3JZdfNKFp19m6U7FzpZWxYxungSIA4urSa+XQ7cBLSasdCM0yT62fpmrzp3swSS9rbZBFs3MSaRHDQt4h1QDPaJxQXLe0ER/8YkSsN9wVYXZP8k82Yzc4ABg/Zc7ZqfxnmbPRWE4QxPBPSKhoLXDhnJKt0uH21J40806Xz3xQ5qxfeViStJZIPno0NGGb9kV/FXCXs/kDF7QrZmF8s3sA4aYOJCKJbCrVVz7iGyUETYiSSMOSlpuOxlEu1GyqEIA300F5dvAkxW2FXfEoUefm6atI0eQX/oE7jm4iBzQ/zENdQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBCVGQ5MjMZ38QOM6nRQjxVnNBNaCBGB8gvkd0DdhOs=;
 b=ltSaRcLiVOZug7GfM8UKAZvuwjmlZAfkn2VFMp0IYKvH/kg45c1MbsdS6Dmn7miouE1DUKr9j+wsT3jBhIxsPn7dJmw4SlRWUW6hG/Bv18kM5vz0shJRLptcW/MHsU/9/esojufwUkDqoo6IJSBQUWEYNe4Qxi2rWFltbxrnIUarFWeeYYkRGeaWH+2oilgHoBuKK3pmAWbTZpU14rS0I6dcm+wXuzoUDEvIuYd5jcbYS4hSje8Yr2rN4/c7zL2Z3qFtsRdqwXPYVgwQc4SVpgA+T7Tq3kHCky7s82Iw/EhNl99fcmlVhmc3oPygW1rr8hqWs86ZQ8F4lCpWd6TInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18)
 by BYAPR11MB2821.namprd11.prod.outlook.com (2603:10b6:a02:c9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 09:51:48 +0000
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::7d0d:3d90:3bbb:462c]) by SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::7d0d:3d90:3bbb:462c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 09:51:48 +0000
From:   "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: RE: [PATCH v4 3/3] spi: dw: Add support for master mode selection for
 DWC SSI controller
Thread-Topic: [PATCH v4 3/3] spi: dw: Add support for master mode selection
 for DWC SSI controller
Thread-Index: AQHYMtgoq5JfEBCuBU6bkaYDj8pnVqzuB92AgBXKJlA=
Date:   Wed, 27 Apr 2022 09:51:47 +0000
Message-ID: <SJ0PR11MB58160274EABEA39BFA625F5485FA9@SJ0PR11MB5816.namprd11.prod.outlook.com>
References: <20220308103331.4116-1-nandhini.srikandan@intel.com>
 <20220308103331.4116-4-nandhini.srikandan@intel.com>
 <20220413130249.ueisqj5xs3komhmr@mobilestation>
In-Reply-To: <20220413130249.ueisqj5xs3komhmr@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28ddada4-dbd8-4bbe-02aa-08da28338bc8
x-ms-traffictypediagnostic: BYAPR11MB2821:EE_
x-microsoft-antispam-prvs: <BYAPR11MB28212B1678D5524F89805D3485FA9@BYAPR11MB2821.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tViNnatC4oXl+TFhZfB35GYm/RgVxIgU1Wqwx530j1tuONijHXESIhqMhMb9lmDiLX2jvtnGJ5V24SYfxKQ/ilF+l0PXlwrj3zahcrQp7/dkJGB7Lky2wjjRddwxl46oiIOIovJwC75wrL8ssLcBu3dXwoLi0wmiPRhdy8XhW9IXKe15u5ywC8agY09nEaOGELRPsPmScwL+z8uE7k6w9uUzMjjX/Gbf549QM6VLtD6dabHrWqOjJn4IvdTtvCzIEaQAccaC9MlcIlNxk2B24YTClhX748MagLTzAdTxkWVHVCwx8xhWl1k9XZLAotSgv/8Q0ll3X+yjBEzfZ1gr7m9P0egO2QMNCdvehtm11SVP8sfZNDxWc1jjr4F7pxeBYUkCyQhpClOvFkuodtsPtvXSbqyoYxtRoG0wY/axU57f1sF8I2BsDfsEQ2ZE1CDpEGzLPDWiVnK9gfF3k7TL+Po4LHNR8OWN2o0g37WAh6MmDPaFp+PQlTa92KyzBwnkP/Vyj2qTTJWxqHINX34Bw0audt3aRnlwkWVXwMGecEE82MHU9oYBfhVXNhh2v3+KVCh9VcUh4WFMRKV2q7tnbbQiX7ihYEDmX1/eCC7RKtnX5qSdvh08HiJ4F1ZQ1p7VYcwHX6RxBKZVP5QdiKnZVuGffWTWsRnH/mrVMqi1qMPy0ZczJgVGY9gzFma0No5iw+Og3F6t7wWc/KdZOv/3W1WM5HZStKegTDONqyUZKI5O+5shrvs8fmp0BoHrfv3ziOyrZ1Z6NJ/BqA2RxzgBSEe+sxv60g4Z6r1CcuIwv44=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5816.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(7696005)(66476007)(66556008)(76116006)(26005)(66946007)(53546011)(966005)(9686003)(71200400001)(54906003)(316002)(508600001)(6916009)(86362001)(82960400001)(83380400001)(186003)(38070700005)(38100700002)(66446008)(122000001)(64756008)(2906002)(55016003)(52536014)(5660300002)(33656002)(8936002)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bVilC3l2/6NbNZg6/rza4ua7BKNV38oK1HibBgUXobmDgDT2XHoljp15SfS5?=
 =?us-ascii?Q?PvIwet077YgRKEKK/OKAndXmeXEEgs7aiPvvS8w/nNPg9Z7DSGhig/UaDN/Y?=
 =?us-ascii?Q?LNllxE4UygYCLBVklVfY0vI3mYQq5+sWuFJZWp/3KOZBGzVWBukINzelZT59?=
 =?us-ascii?Q?PQrwu2Fz975DiU1uv75H4Er+k9kK5CnN0v4e8H6K/UstMosOIla0q/sgyfnk?=
 =?us-ascii?Q?tBvYpaOPqCr6A1n6LO+SUgAKVkE8o9tqAMgCCwBhzin1dU9lWdbNU6hKGkxA?=
 =?us-ascii?Q?VOB0VtvIfv4pi2GmM3BWj9Leyq0EI09y3t1R/eDHEDO5rNTS8BATMdhXzvKt?=
 =?us-ascii?Q?C6CyI4FcVVy2y6RUvY9RT9+ib5L1b65Vn+SX1+g7t/Q9egrd3dtZggHv3fnN?=
 =?us-ascii?Q?9x5RKTMc4p0qOYdBTLZkLXsQp8jeoDc0YAr10HXp/noEApiwXtKn09E3hY8D?=
 =?us-ascii?Q?Dg70BuKxbvBBpntNlgyV/kpqY/J9ecrifrrtopNJmrYW6FvhYYOntOJFodsh?=
 =?us-ascii?Q?fbVtujLU9VeyojrrVcsfraCi8w4iidfyMwMF1F5nAaX3eB4fC6g9Y6awTlJ5?=
 =?us-ascii?Q?5b6vKDff4NlcSRgRwsf+m8WwPl5/Gv9JFNuHNsXD4aozKZekVVc41tDs1Bhm?=
 =?us-ascii?Q?yt9/8X5kyrzqVlckIcP2fZqWVAntZPtDxD82q5LF7C3BJrB17aU+15FsuUhl?=
 =?us-ascii?Q?bMBBplRI+UzUiUNe/sui163mROjAzNh12K5/iN8vGraYm3f6lzEE6EJnHQts?=
 =?us-ascii?Q?J58Pwkp2Uni9n9pGW8FuS8WBpGOeH6AGmuRcwKhQGZjPOptzvgL1JZTnVhNH?=
 =?us-ascii?Q?hHW21AK9cUz8FBCYjFJ+jWWoYRA97oaYinKWlCeJnsZBtvwzmzoFfRHH7Cnv?=
 =?us-ascii?Q?Xl3oceQemfOjhBKxyTqAgd8adwOofMaA3epmOmo4paQOjSomd7rf8MZ8KA8D?=
 =?us-ascii?Q?6vxRGrcMYwC/xf4nWUwZkZGMJ6RjT0VvCP5G3t+eTavY1tRJRHAv69kRt4gG?=
 =?us-ascii?Q?L10I4ukVF033wWqbqkanXrCgXjDPLHE2v4owDFnuDzk2EGTdbkI2NUypi4Qq?=
 =?us-ascii?Q?2OlXRDlhLFU78z2wDG23pQY4jjHl05bThq0DFLCObhCJrBXae2bkYZO/8JaD?=
 =?us-ascii?Q?9EfePy1HncZrghlUvR2jzaeRXMC2TF+51mm+JbvpYC5oPh91lM2agDZmWKC3?=
 =?us-ascii?Q?lmVGfX55GBf6iPy6L3jcF6MutMCLKyfLo4i6irc2jjfcmqrL7eOMpiZS7RT7?=
 =?us-ascii?Q?n66+U35zGmwXTn4o84ikksUHafV8PakEyjuZQK8xmy6+KOfw8+Phz2mQq3AR?=
 =?us-ascii?Q?AuRWAUtMHD2AEJkCWJjCwQZlV9VqUUnllac4ka9Hgd9UiVZ//8we2BdyaySK?=
 =?us-ascii?Q?3DxH1ZlY9Q3k30jHrMc5F8NTC+c8BhagLRnnaGkQz1Jq2DcwzG7RtOJVoupG?=
 =?us-ascii?Q?+CYVwCIVCPX55aGCjFCHjDPZuW9rSvoC5KdJiQQdpQ+u5vL2xDPJ/mljHEnS?=
 =?us-ascii?Q?158D6m7uKZHW5G9ML7vDsLJne5U6CJki5Hw+EmbYbhLEI9hXgOg7nS6bBdnG?=
 =?us-ascii?Q?FRw1mYTrQxrRbS8PNKLmpBXXj2FPC9AoWlM/aH82Evouv/esTZT1oQZLf3Gs?=
 =?us-ascii?Q?PDwd8VVq8plgQ2YVTnhgTQpsK7uqU6e54ZFliMWVocVNsIFFOl9yPWelodGU?=
 =?us-ascii?Q?e5TqI+/5EWy0nlKzftuhleIkEFoahuknVDoqkb0lPpy2bkYx71Tr72pJXmW4?=
 =?us-ascii?Q?J9psG8/gr34ByWHQLzk/3k45txSQgHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5816.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ddada4-dbd8-4bbe-02aa-08da28338bc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 09:51:47.9305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwJ8u3KAKrnsFdfWZ1eWjdq3kcSY42lfhPjaJVgX1ib53ZoN2PxmLMQP53ROd0zoJ2r+CBZTE9Z2nmo6Sa05Lmu+/sm1uTNWjW/wZvSKGRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2821
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Wednesday, April 13, 2022 6:33 PM
> To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; broonie@kernel.org;
> robh+dt@kernel.org; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> Subject: Re: [PATCH v4 3/3] spi: dw: Add support for master mode selectio=
n
> for DWC SSI controller
>=20
> Hello Nandhini
>=20
> AFAICS this patch should go before
> [PATCH v4 2/3] spi: dw: Add support for Intel Thunder Bay SPI controller
> Thus you'd perform the DWC AHB SSI Master mode conversion first, then
> introduce the new controller support. Otherwise without this patch applie=
d
> the DW SPI driver is most likely left broken for the Intel SPI controller=
s since
> you drop the DW_SPI_CAP_KEEMBAY_MST macro usage in [PATCH 2/3] while
> the new DW AHB SSI Master functionality is introduced in the next patch
> [PATCH 3/3]. So please convert the series to the harmless configuration o=
n
> each git image state.
>=20
Sure, I will reorder patch 2/3 and 3/3 so that the master mode conversion h=
appens first followed by new controller support.

> On Tue, Mar 08, 2022 at 06:33:31PM +0800, nandhini.srikandan@intel.com
> wrote:
> > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> >
> > Add support to select the controller mode as master mode by setting
> > Bit 31 of CTRLR0 register. This feature is supported for controller
> > versions above v1.02.
> >
> > Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > ---
> >  drivers/spi/spi-dw-core.c | 4 ++--
> >  drivers/spi/spi-dw.h      | 7 +++----
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index ecea471ff42c..68bfdf2c4dc7 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -307,8 +307,8 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws,
> struct spi_device *spi)
> >  		if (spi->mode & SPI_LOOP)
> >  			cr0 |=3D DW_HSSI_CTRLR0_SRL;
> >
>=20
> > -		if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > -			cr0 |=3D DW_HSSI_CTRLR0_KEEMBAY_MST;
> > +		/* CTRLR0[31] MST */
> > +		cr0 |=3D DW_HSSI_CTRLR0_MST;
>=20
> Could you please conditionally set that flag here? That's what we agreed =
to
> do in v3:
> https://lore.kernel.org/linux-
> spi/20211116191542.vc42cxvflzn66ien@mobilestation/
> like this:
> +	/* CTRLR0[31] MST */
> +	if (dw_spi_ver_is_ge(dws, HSSI, 102A))
> +		cr0 |=3D DWC_HSSI_CTRLR0_MST;
>=20
In case of Keem Bay, though the version of SPI controller is shown as 1.01a=
 from the HW register, it still needs the MST BIT31 to be set in order for =
controller to work in master mode.
Also since the older versions of the controller which do not need the BIT31=
 to be set, the bit was reserved. Hence there is no impact by setting this =
BIT31 for older versions.=20
So, the condition check was removed.

> >  	}
> >
> >  	return cr0;
> > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h index
> > d5ee5130601e..2583b7314c41 100644
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> > @@ -23,7 +23,7 @@
> >  	((_dws)->ip =3D=3D DW_ ## _ip ## _ID)
> >
>=20
> >  #define __dw_spi_ver_cmp(_dws, _ip, _ver, _op) \
> > -	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ver)
> > +	(dw_spi_ip_is(_dws, _ip) && (_dws)->ver _op DW_ ## _ip ## _ ##
> _ver)
>=20
> Nice catch. My mistake. Could you please move this change into a dedicate=
d
> patch with the next fixes tag?
> Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions
> interface")
>=20
Sure, I will convert this to a dedicated patch. Just for confirmation, the =
patch should be a separate patch with this title "Fixes: 2cc8d9227bbb ("spi=
: dw: Introduce Synopsys IP-core versions interface")"=20
and not part of the current patch set series.
> >
> >  #define dw_spi_ver_is(_dws, _ip, _ver) __dw_spi_ver_cmp(_dws, _ip,
> > _ver, =3D=3D)
> >
> > @@ -31,8 +31,7 @@
> >
> >  /* DW SPI controller capabilities */
> >  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
> > -#define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
> > -#define DW_SPI_CAP_DFS32		BIT(2)
> > +#define DW_SPI_CAP_DFS32		BIT(1)
> >
> >  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores=
) */
> >  #define DW_SPI_CTRLR0			0x00
> > @@ -100,7 +99,7 @@
>=20
> >   * 0: SSI is slave
> >   * 1: SSI is master
> >   */
> > -#define DW_HSSI_CTRLR0_KEEMBAY_MST		BIT(31)
> > +#define DW_HSSI_CTRLR0_MST			BIT(31)
>=20
> Could you please drop the redundant comment above and join the macro
> with the DW_HSSI_* macros group?
>=20
Sure, I will remove the comment and group the macros.=20
> -Sergey
>=20
> >
> >  /* Bit fields in CTRLR1 */
> >  #define DW_SPI_NDF_MASK				GENMASK(15, 0)
> > --
> > 2.17.1
> >
