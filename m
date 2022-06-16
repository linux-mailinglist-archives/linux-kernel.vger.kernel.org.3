Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251A254D8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353703AbiFPDnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349629AbiFPDnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:43:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9F9167D0;
        Wed, 15 Jun 2022 20:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655350981; x=1686886981;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7qf+b1+YvesxTUW7SvcTEGyq/g0rFPY7Pd4LtonY83U=;
  b=Xg6BVyD5zsV+iZjQ+5gCw5DdOF8pDRy3PBdzZzRqWmnGC7wsSUxj4tyQ
   BoHBAoYSL/uEZBWRVd7qTPpUfDDjEZxOy2OYiklqNzD+jNi53rtkF33MI
   uFeYLwTUG0u5TMTd+t7dKODVNuPb8Pf5PYpYK01fivFeBPqyo+dqHsfFO
   JaKyQGTyhckvXZ1Jqhwaa0GiyxIFMzm6siuzsKW24Dp8XEkMYtq8XBHz6
   opIaGDxYpmASHD1wIs4tRKcG9ltbSafw31wUKIcdhdCq+LI9JPVdiaosS
   xsWVB2ECDW8SpHnuUNYrbWBHI/HGqghY9o2Emp/kZlCFiKRdaeEIDJnf6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279215346"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="279215346"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 20:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="613011034"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2022 20:43:00 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 20:42:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 20:42:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 15 Jun 2022 20:42:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 15 Jun 2022 20:42:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jej7i7cmBR8JWpRNkaLA2c7sllGnYkrkF+YlLKxpDQdrWXVg6kYjAe24CYYrmD1wG+K8THlW1sR3yWh7e4fUBlP5XNRdMvwNs5qzyuoF50oDw5tpS9Gr53p6PCK51zYKa46uFUcH9aL9Rp9mOG9JZ4p6X6TX2xrSvcH/f9A6T4UmolmTm19395j/fxlxdlKxkId/WKRtl/Jim9fOF1aYT4hd35f6Yi0Tug6RujaYjtirTGRwzUbrj0o7kNygFa2nYYVMqedQWvlGSnHDKx85JcNj7cTMiZyeBYzUX/1e+vP3fXSFBRTJCiHHy2yjp/mBD8jPOl4L5ecONtiOTDuwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYFvNBro+VeKjSesppc8bdTt65v9XTPjYm2+P8cY/vg=;
 b=X5idUDVERRWKHiD5Dvyit8DszQtRMqkimPh/2edjZv9YPDfmsCk36HChuuDLU5VMDZVaNoYsVOWjw8xkOW0mx/7quFXB2K3OmAjzy4QxFCUVJOZjQjSMj1ilKih4GmOFKYlDZKcf5fcllxX1Re/xG1OUzGtHscd146ZDk9ru+Q/NZj691bquC5MIwRfis82AcDc0eI50xFEyBhSWTjj2WV+lb0A21DD8E9zZJZNXcK6UJiKxT6+FTvVB094aZRSTLNLpXwmtGP7+ZyvT+Yfm7fHC4x2+R79Y8fyHfIQj1UBIJ223o0ub3cyhE5tk1JBvMDExlU2jynhoRiWmrhWPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9)
 by SN6PR11MB3279.namprd11.prod.outlook.com (2603:10b6:805:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 16 Jun
 2022 03:42:52 +0000
Received: from IA1PR11MB6218.namprd11.prod.outlook.com
 ([fe80::d451:e933:b262:d77c]) by IA1PR11MB6218.namprd11.prod.outlook.com
 ([fe80::d451:e933:b262:d77c%9]) with mapi id 15.20.5332.020; Thu, 16 Jun 2022
 03:42:52 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Topic: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Thread-Index: AQHYJ9KPmrr71unh3EaZNB9EpLdxlqygNAOAgADN5wCAE5UmgIAAw7QAgA6SSICAjibRAA==
Date:   Thu, 16 Jun 2022 03:42:51 +0000
Message-ID: <IA1PR11MB6218F9374CF01DB72EC40A76F1AC9@IA1PR11MB6218.namprd11.prod.outlook.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-2-shruthi.sanil@intel.com>
 <YhVuJaf3AJ1c6TpT@robh.at.kernel.org> <YhYa3tlTEcLct2xu@smile.fi.intel.com>
 <CAL_JsqK_k49eKZ+Z+uw29GdY9KFVJL9o5xkzg=1=yF-oEt+JRg@mail.gmail.com>
 <YicsXm9JboW2b+5f@smile.fi.intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa32d899-189f-4a86-41a6-08da4f4a4a64
x-ms-traffictypediagnostic: SN6PR11MB3279:EE_
x-microsoft-antispam-prvs: <SN6PR11MB327906CF16802A89682BC177F1AC9@SN6PR11MB3279.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +uHVtXqzr38I7cllJfZQR5NfPh5UqnmrMoN4DEmzkjjilDhJsTGah5+/KgCJrdyEGuraLxNDJsxKIJ99wysWain9sIHTPcqxs1diyo7FuE226847+NIhJlPaAJvexwqLeWAVZloAdZvINvLPbkHz1dnuY0N93paKS1UNmW/HYE4aTcpBuTCadOcvOLcy1Q259RLLR5EXAPqPTsKE4qOGP2m9xbm80QiSqOebpHzRE6KCFrtCrSqRgxCmvHvYRNqZOCiMHboKPFYyXk7ciQKgCFK+HxH7KzgsPlaauRBitPkhl8xZrXgaj0JkkcMzYZnKN6z2DUkQNCJXLEHSIMTWlV64sm2WYcaGd6Y4cb5sVnT+cSS93Vu5zGJ+3F+xgRI2Zz8yejCSoJl/yec5Y/fKho57az4y2qRridDl8cQPqcLJWi3ZMfBYzzTpVWwF1jfGYl6M8bOgFGuoziYRGBZeyBNeocmNuZ6jvu+X1kkYL2IhgyibwlIf1J7MKXc/g3+jbxC5h2gDjKgVzb1Q7UtBXY/DPiaOfsl0UT47Ra+89wSXYjk/KIhzX55qKOIqt1S39znbL1lvBtpU4XEqT5fS0jNkODfr8b+rtmq4eGWQxXkiQ0DK9Byg7CAZ6VFg6qkJQOyqqO82pXhTEdacXcXoluMihbY7ioBoRYHvewryhL1KrNTCe9oxm0NnW5hdn/0Nv86eCc1drR7kVyoikRLhBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(84040400005)(186003)(38070700005)(83380400001)(82960400001)(55016003)(6506007)(7696005)(38100700002)(122000001)(52536014)(110136005)(508600001)(316002)(2906002)(8936002)(26005)(9686003)(4326008)(66446008)(66946007)(8676002)(54906003)(66556008)(66476007)(76116006)(5660300002)(64756008)(53546011)(71200400001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YG3fW5/5GLIvNO+r5B4HslBRsRQLHRpCQsytlqpuMCIrRbzQUaWRRV8QgsRJ?=
 =?us-ascii?Q?FvJz1cpQ1qjyKI2wahZE/MMoW2xWxHnHzNAgXKwSsmdl9+pWSQllbmR+rvC6?=
 =?us-ascii?Q?j5un1urzRhyX2ORewvb275ab37y5aZTELA36PusYvybwOPbN4hP3ctpnwb9i?=
 =?us-ascii?Q?MAzjGzd9ST2RkVE5sVShzVjFI8TPixiN8F3jSADWz2M0UellthB6ICB618uj?=
 =?us-ascii?Q?NbRL9Hlj0Nzq7zu0UnUkI6enQFxk+3ryldm7q6PFp/HWxUrJ7KnsTdcVHkGv?=
 =?us-ascii?Q?G23P6F5VQucNaGKqlt/W0oHlgfwuOk9URuFafKEZOO/Er+q5BM8fKn/lkfzT?=
 =?us-ascii?Q?BnV9MoFDylbDq423B2pb8DCzVyIUVSF/qo8TLgRTGK9G9CdK6EbXbyl1Bc5/?=
 =?us-ascii?Q?XJn9+LUDNltNyNw8N5cp2iFIvui45vI32o3ruGuUZLH+5Z6RWza1qej9SVPH?=
 =?us-ascii?Q?R3T27eOLpyhjneYrCTx0aoPSlPICRnWZbIbYgVyIJc3/7FMFm74VIhVWPbRt?=
 =?us-ascii?Q?EsOGtulsyiXV/ZhcKXriFBJAHzDeqMWiLa3Q5oJLrljQyW/Pws923OsS7j5m?=
 =?us-ascii?Q?iqPTC7g8r/Bf02ZHTuCQkXLdK7xkHT7qrFCqiYGzO9iUydTCXR1lMylTJ+CC?=
 =?us-ascii?Q?MnfCBeUTQnZ+e9PdtfujYxj2uRFLcZvI6lW8v4Qol7AKbxUmU8DAt4QuXE5z?=
 =?us-ascii?Q?qp4tDuRCyoaJMAlCrSqOq2vdwOmfovRYdN4n+ZtCoXEicVSG+bjRtvOPt7L1?=
 =?us-ascii?Q?RPv+qVMEb39nPrMQXys8Wr+i9Q/ONHeoAPYTCL2Mo3AcI7PvEp9JK7OjsFjf?=
 =?us-ascii?Q?6DD+81SHerRtjl9qfLwPljHDuqsQjVrHnKar3wR1DssbU0os0ggoaUyRDB/V?=
 =?us-ascii?Q?LL7wy1QiJmkq9nVscQzdhWj2JTy0Eb+9eULUH5bX+6Q7E3xUzkoynS6DXI/i?=
 =?us-ascii?Q?zXuzxS4NKy7OS2isCjTAjimMsPunOxH+fZzvrJm1lgutzyg96owkFLBD7QnK?=
 =?us-ascii?Q?UaB8A8wde3P0Bg4QBoV08cHsiybubCzuLXsWn+HPhz8O1qUNRtioaPcO8Zia?=
 =?us-ascii?Q?yF8dVuGrPl8DZpEKT7fUmOy+LysuIrYa6EUh01fvFJpp+/eyy8qv3JmB1f0x?=
 =?us-ascii?Q?m9xTle0soS9S8CBO+ffHCvI5k/+kcEr4p39SsnuMgh5y0txkKW6AwREHQ/Z9?=
 =?us-ascii?Q?U7JzOgAMSA5FtHBrWvYjokGPbq89OKvQNumrV3pB0CjtGLJE5uxgr1uKmpm5?=
 =?us-ascii?Q?3PqxSQdEYLi0gD6Cuzvmxy8JV9EarS6uYSvKu1i47zAdSjVG1CFgxrthboqI?=
 =?us-ascii?Q?3MOAfJ5zprXXspUhCZr6f4TTDBC/wJARdtXU2xxjHvf91YMtGV+U8Ijk70dw?=
 =?us-ascii?Q?p66fQDTpf19eL4vcY3p5orq9uUwjERv3XRAdlr2LeeJiZ8TjAGY9nbPuGSSg?=
 =?us-ascii?Q?qMNPD773FNbx+IdWWMSQuc0xCohmPVlkBs6B+sz69LHjtcPIZ8xxrGs+k1RV?=
 =?us-ascii?Q?rR6qdF/PpaJJHqTj9aBKZuy/SVasdZT0aC+cyhZNiQatR2hld7o7nBGzvDc3?=
 =?us-ascii?Q?x/uCfesWBmk+j6lir9zRyyGLPrpGRBPAnyYzC6VCvene/YRysSXvj2sBNPM2?=
 =?us-ascii?Q?hXFAgjTQWq00qOx3Q4bO6/neEEzwD6L5teHeNU6P3HaFSjvB9Ri+3b5VZheH?=
 =?us-ascii?Q?/xcP/6GkYKK3VRSaE6h/Zq+cpqOSl+P7xKO9srBN6Ow1Eh9qO1vU8EPFTK1Y?=
 =?us-ascii?Q?AYa+GHuM34+FEyAk3QSontTxEuk+5uE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6218.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa32d899-189f-4a86-41a6-08da4f4a4a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 03:42:51.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDCPZlrgHrU4DB3jem6PAmbvtYOQDN52D5ibD9uk9/IQnthrs3EJ0OXJfRknFO8hHFfbUdI9+wcBM6kJNetYHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3279
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Sanil, Shruthi
> Sent: Friday, March 18, 2022 11:07 AM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Rob Herring
> <robh@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
> <tglx@linutronix.de>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Mark Gross <mgross@linux.intel.com>;
> Thokala, Srikanth <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi
> Bai <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar,
> Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: RE: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Ke=
em
> Bay SoC Timer
>=20
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Tuesday, March 8, 2022 3:44 PM
> > To: Rob Herring <robh@kernel.org>
> > Cc: Sanil, Shruthi <shruthi.sanil@intel.com>; Daniel Lezcano
> > <daniel.lezcano@linaro.org>; Thomas Gleixner <tglx@linutronix.de>;
> > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org; Mark Gross
> > <mgross@linux.intel.com>; Thokala, Srikanth
> > <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> > <lakshmi.bai.raja.subramanian@intel.com>;
> > Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> > Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel
> > Keem Bay SoC Timer
> >
> > On Mon, Mar 07, 2022 at 04:33:23PM -0600, Rob Herring wrote:
> > > On Wed, Feb 23, 2022 at 5:31 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Tue, Feb 22, 2022 at 05:13:41PM -0600, Rob Herring wrote:
> > > > > On Tue, Feb 22, 2022 at 03:26:53PM +0530,
> > > > > shruthi.sanil@intel.com
> > wrote:
> > > > > > From: Shruthi Sanil <shruthi.sanil@intel.com>
> > > > > >
> > > > > > Add Device Tree bindings for the Timer IP, which can be used
> > > > > > as clocksource and clockevent device in the Intel Keem Bay SoC.
> > > >
> > > > ...
> > > >
> > > > > > +    soc {
> > > > > > +        #address-cells =3D <0x2>;
> > > > > > +        #size-cells =3D <0x2>;
> > > > > > +
> > > > > > +        gpt@20331000 {
> > > > > > +            compatible =3D "intel,keembay-gpt-creg",
> > > > > > + "simple-mfd";
> > > > >
> > > > > It looks like you are splitting things based on Linux
> > > > > implementation details. Does this h/w block have different
> > > > > combinations of timers and counters? If not, then you don't need
> > > > > the child nodes at all. There's plenty of h/w blocks that get
> > > > > used as both
> > a clocksource and clockevent.
> > > > >
> > > > > Maybe I already raised this, but assume I don't remember and
> > > > > this patch needs to address any questions I already asked.
> > > >
> > > > I dunno if I mentioned that hardware seems to have 5 or so devices
> > > > behind the block, so ideally it should be one device node that
> > > > represents the global register spaces and several children nodes.
> > >
> > > Is it 5 devices or 9 devices?
> >
> > 5 devices, one of which is a timer block out of 8 timers.
> > You may count them as 12 altogether.
> >
> > > > However, I am not familiar with the established practices in DT
> > > > world, but above seems to me the right thing to do since it
> > > > describes the hardware as is (without any linuxisms).
> > >
> > > The Linuxism in these cases defining 1 node per driver because
> > > that's what is convenient for automatic probing. That appears to be
> > > exactly the case here. The red flag is nodes with a compatible and
> > > nothing else. The next question is whether the sub-devices are
> > > blocks that will be assembled in varying combinations and
> > > quantities. If not, then not much point subdividing the h/w blocks.
> >
> > AFAIU the hardware architecture the amount of timers is dependent on
> > the IP synthesis configuration. On this platform it's 8, but it may be
> > 1 or 2, for example.
>=20
> Yes, the number of timers can vary between platforms.
> For eg., Intel Keem Bay SoC has 8 timers where as in Intel Thunder Bay So=
C
> has 6 timers.
>=20
> >
> > > There's also many cases of having multiple 'identical' timers and
> > > wanting to encode which timer gets assigned to clocksource vs.
> > > clockevent. But those 'identical' timers aren't if you care about
> > > which timer gets assigned where. I *think* that's not the case here
> > > unless you are trying to pick the timer for the clockevent by not
> > > defining the other timers.
> > >
> > > Without having a complete picture of what's in 'gpt-creg', I can't
> > > give better advice.
> >
> > I guess they need to share TRM, if possible, to show what this block is=
.
> >
>=20
> I would like to explain briefly about the Timer IP in the Keem Bay Soc.
> The Timers block contains 8 general purpose timers, a free running counte=
r.
> Each general purpose timer can generate an individual interrupt to the
> interrupt controller.
> The timer block consists of secure and non-secure timers. Hence there are
> secure and non-secure registers in separate address banks.
> The secure register bank consists of the common control register where th=
e
> timers and counters need to be enabled.
> From the driver we try to check if these bits are enabled to continue wit=
h the
> initialization of the driver.
> Hence we need to pass the base address of both the address banks to the
> driver from the DTB.
> The control register is common for both timer and counter. Hence we went
> for parent child module in DTB. 'gpt-creg' represents this control regist=
er.
>=20

I tried to get the technical manual that could be shared publicly, but coul=
dn't find one which has the timer IP details.
In the previous reply above, I have tried to explain the details of the Tim=
er IP. Could you please let me know if I was able to answer your question?

I think the concern point here is the common register that needs to be acce=
ssed by the timer during initialization. Same address cannot be defined in =
multiple timer nodes and also we cannot have this in the driver too as offs=
et because this offset is changing from platform to platform. Hence we have=
 gone with the parent child approach. I need your help here on whats the be=
st possible way to do this?

I need your support in taking this patch forward?

> > --
> > With Best Regards,
> > Andy Shevchenko
> >

