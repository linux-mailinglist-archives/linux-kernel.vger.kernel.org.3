Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6005F54402D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiFHXws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFHXwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:52:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2993D37CC33
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654732469; x=1686268469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AbZtMGok+u8llwcmb5F+MaVvu7zhiiU+fZGuh+wH9MY=;
  b=lkEfFwHt5otDHddfro4tgr4Sj9IjEWy5fGVD3uD4Rp2sXVvB8M/Hrqkq
   fONqgk2EZY6us3Z0P3wbHQLwKXapFDE9hs8OJm2/AX7x+1/DILlJLpLrn
   fNpAqrQ0AbnLalmiSJkMFz4rhF5WZSjqMZPPIwPDBB67+9k6FrkLaE8q5
   n9JjGej6LMSzzEjwQs3W9QPr4tnTYoR3WcFf7+UFMyOsMgZHLObodESHr
   /k750w6lLhjxhQVpUlz3p8CNIT+bH5Upt5oVzyAN/taHGrF93afLQ4kib
   v2DihPVE62NI9n+kagrIDfEPQOEYzS/hzIVz6PlNyfo1lt4N/9hslg9Ze
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277112417"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277112417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 16:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="683639692"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2022 16:54:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 16:54:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 8 Jun 2022 16:54:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 8 Jun 2022 16:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxlfcBAIOmG6YL1e89nbPSD1tRWqLGocpo+wseeJgumSR82bHNwQZj2Fv/jHfyXNV5Y5LEv8BibVNjhTl0y2UxZFsOqCFW2FVH15nUBbZBsuAWx24FTu0PI56TTYaM+Ny4/UieKkTZgsEriVUxY8IYgM2xB1jOE0dmyadj0YxB5L7oyHusL0fW5kvHOO4Ff8CKW8u2lt3zSY3hnoMB2WLadSpVvdWW6G4htutIL65gWDvhkBNKTe7BEZmQ5QGzCybWDd0z35I1yxAHyeKKC/vLYfUoI0FRM0s/9UB0LI8Yix95kbTO8qCCE+v4C3bS2ocbveXU4Smrf9+Z93SqGwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aed6Indixewppkf+FtUg1PAAcCgxj49e2OPjv0ufYBE=;
 b=ZTWG3Joqe+I4yXrm9rO6SFp1AjPAyZZDtnGdNsCTp4K+acJ8Mt9Uwe2+NBgCYoD9184BM7okn94Lhv9Gh4PGQZbwsjcpIN0FHlSgPf0DnHGSF9eP+e+hq0EiICpFlWRFSCh939QsfRK2iIFHyiNtQ61hqIpTgRaX5l80qQkz/AGFc1Q2Ba2uE8SIg89r/ojqoa0BctEhnEIGjlWmBki5k6qNoXEhdzxyklbGDZ7QderfhYcS42QmKweS4y8Oz87zHWqRLK+py+HlYtkqecdMRrg1+KvIrfh24BFPQTQtqhwZHFCrHyNIoxYzoNhITNC+Ru0dWgPdh+yDeGXtFjQczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by CY4PR11MB1240.namprd11.prod.outlook.com (2603:10b6:903:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Wed, 8 Jun
 2022 23:54:26 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::4d94:5d8b:51d7:d8b4]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::4d94:5d8b:51d7:d8b4%9]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 23:54:26 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Mark Brown <broonie@kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v1] regmap: add generic indirect regmap support
Thread-Topic: [PATCH v1] regmap: add generic indirect regmap support
Thread-Index: AQHYeg+4rjimubWf70mLnwe3EofT5q1D7TaAgAC7xwCAAKv3gIAA28Uw
Date:   Wed, 8 Jun 2022 23:54:26 +0000
Message-ID: <BN9PR11MB548315C03B09D841B6392E63E3A49@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220607013755.594554-1-tianfei.zhang@intel.com>
 <Yp9PdZn2Xu/oqiA8@sirena.org.uk>
 <alpine.DEB.2.22.394.2206071714420.3001206@rhweight-WRK1>
 <YqB9O8HhZV2tXo8g@sirena.org.uk>
In-Reply-To: <YqB9O8HhZV2tXo8g@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cff9b14-722f-49c9-4bdd-08da49aa3874
x-ms-traffictypediagnostic: CY4PR11MB1240:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1240B798B3E51FF1AAD22EBEE3A49@CY4PR11MB1240.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qhhAwtQ77A516wRR1jVbxTFW5bCUjq9U3piJ9BQIr6T1hTD9rVM/QqSTGTI3O4AcinizmIPiP6iC8prUVUW2dJHcEhJ5+YgZ8ndL9NOJhYCTK4c62je+6J2LRWdIIf6+BVWub901pfUuskSGiyGYH/e9rHDy3i22b30Hsa9c0yL8uyAQnOacZLH5AkDtTVbit/L4hzrvOSUedf/pIhKyB3CsPxhrVnGLtT3x8siUjYL0ddAdVxjiFX+24y/SFuskPjnPkA9kehddNZGvxXxe7Fb7QmPgd74040WCjxch6cD5LV0vDwNVUMX9nltvWgvRJr16GrlhFaDWAvUbjZE1vz5SzSIPqOVo4ZodcrSEHuGUICMVf5xqgXJMpFOoSRvOyZ4AbDPzdXMKA84hh+aXxgnuMz68buYcSwxPiL1ohaP5bNY5FZIhECzalvJ6rCyfnn+bv+za9GVvohdAJ9HcrIZlTm41na+YfVfRlJb9UJ3Wo9U3rQx+YlGZIsMerl2M9rhTMWCww32Ydal9cUDxqXgOsS/IbpSEjQ8aizxNwvKU1ae+2APa0VVHDEQynWCWmxVtfNHMdDgoBtpF8V1zJzYDwgnsRNohKMgm4xyq9FRxRw0AbxlTn2dZFCNmKQ4TGsZyfYfitE4FyuJ4tNi93lUvmhiSJWq/C1kW8BITn7G61tOiAgbBNCfXHT0CNEavfLfpMzyhHLmj7Wi9OyYjNpPYiWCY8WuLql4Fm1KFsPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(4326008)(55016003)(186003)(66946007)(64756008)(53546011)(8936002)(71200400001)(9686003)(83380400001)(6506007)(7696005)(66446008)(8676002)(66556008)(38100700002)(86362001)(66476007)(33656002)(76116006)(110136005)(52536014)(2906002)(316002)(38070700005)(82960400001)(122000001)(5660300002)(508600001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CeAUOz6cgu/yUFtDB2T2mjEn0UOl0xUKyu5TF2nu8niY5Nu2fCItjreYYWrH?=
 =?us-ascii?Q?k3iJ0xnPgmxf90fEJ1e3poUf74Mq6J/lSkhE5jHJRrolu0uOxc17+ngDJTfG?=
 =?us-ascii?Q?S+TXuShUjyoJV10sv4e4ONWlkYfBhe7txYXM25lSsQwIsPj5c0kiDf56FoGd?=
 =?us-ascii?Q?8jZKRcb3sCzcEZBVUdtEjcP60ts2lDJCbQi9d7U1kRGHdCUiG+5iqSo7Tgpt?=
 =?us-ascii?Q?+2Mi6nZcQRo0PcDuXeaffwXMHRReLYdbWxtmQLIHZzzjRiduvmP+kDmYsY08?=
 =?us-ascii?Q?AjzjRjPBvfFHe4oW/Hg4g91xc/Z34nttdW0KfXTg2NiZ4ER62u9dn2FQe4fH?=
 =?us-ascii?Q?51fEAI+8Lgu0+32UsOMIGUoZkQKdZyaZQVyqSTvaTR/U7gJsHvu1S6llci+9?=
 =?us-ascii?Q?f7uy2kCR2ylR8ILcuyJVdCWqu0aAVDI7rCJmqsY9b5BAlNGYcFRvgcKKMTtZ?=
 =?us-ascii?Q?/pH6Om9j1LIQPhLPgzO3G41CaPSGZAcfkCShXBpWGl2U1E2r1AdqClyldNpL?=
 =?us-ascii?Q?0KZNAYoz1/REXGX2Erl7D+TR8vU1R0Hy0KBIUmEL3uyy6crlgN4CTwV4+KCT?=
 =?us-ascii?Q?HYkhkvkWvmi7vMj7MSk3T5pc0JB/K3sPPxoSfZIFxJnOYMd0XSHapspT04ir?=
 =?us-ascii?Q?VjFvNP/1ZTNB67fXlpPYjB1nRWUcLx2mUSTULcNqhGuNvFYMB6m+c3tJfwxB?=
 =?us-ascii?Q?dcuFNF3El+chG1vvcRjZ3tjtK71KD+Zpl3+KXE3GDzWvNl0KyA3ik/VB/91n?=
 =?us-ascii?Q?Txoeh0bf/YTN0g7mkUKWZIpkN4DMKEB9kBGZItx4t2SAwAr56WP5cjfEnoq7?=
 =?us-ascii?Q?IkTDw94E+IK87tbh8TmCjWk6nSG8FbCV/k1GIT0AN5qBTklnTvQDvKVmxZZY?=
 =?us-ascii?Q?6QdCSHlVTgHw/a1VJ3jhIVRo1Js4pubp7XE75hcG9IM/OcYYfntlz1ErBsar?=
 =?us-ascii?Q?tWtWbX8farOulnSwbkG70jWRvSm6KFHWE8kHtZP1BVS3dxh+H0whqoTVFcgA?=
 =?us-ascii?Q?x4m2jwBEecOOWA0baDmvLwbfwVtxjuovDZ3Sch7XmUyRkLP3h6gk49RySdA9?=
 =?us-ascii?Q?rfl7GMD3qMCVpWYHCO0AEqqE+7WQSRuJl3szdKvV3nVemvmRMfJ5enWqvhvI?=
 =?us-ascii?Q?oSkJPhVZKeJpvMRs1dtCPyWanSttc16oxyK0H2GQJnRwSE1h/G9pHT7/TN15?=
 =?us-ascii?Q?gTk/u9A0nMVwzc7Yv4wCNir0DESfp7FfbCtBklx0StAwksHNoo78Q7u205LA?=
 =?us-ascii?Q?bYFtV6bPuLvrtJIp57Hxq+RXPFVsrN+yzwGrQHpTzEbZkzuA7ei0SK5lV+Hz?=
 =?us-ascii?Q?sQrFEJlnGd3JmFEZM20UqOxldOICNA42JnfSFnSYpHf/Ngc70cuWmbUz3bIy?=
 =?us-ascii?Q?BWxlZ56wRswHruUX20LiM0jR0egrombVEdt5pDdCo1uMEsUj2xcgxNpyAAEV?=
 =?us-ascii?Q?0u7+Q7xywqhGXuBWyFIALUCrInQraC+n5KtqTfn2s9CLG6hSVJcRBuPWBB07?=
 =?us-ascii?Q?FsdgKqIouuFKVUUVw5j9t1ifayM5zOr/RTee7j9QKDFyJmWyxN8BKYscYeyI?=
 =?us-ascii?Q?oEj88gUaHRPUiol79VZuyywtFd4ps+mHlxwbN34OicxsK8xxTh7ksqCcfe9+?=
 =?us-ascii?Q?/VXvYFeGlIz02K0ngtwyHvad04gNsHbyMI7Ww/2yPszeq9iy04AMA54uPxZ2?=
 =?us-ascii?Q?7OUN6+hDaRSeKO825eeNemOsQW6j3t8btxsa/SQZNjAiuqrkPI/8ydnV77uY?=
 =?us-ascii?Q?Lwik7p/0GLe41MAAMiH+XTW0ujBVW+XJh6SDsFc1Yn319KmrMhlrZURzGhbr?=
x-ms-exchange-antispam-messagedata-1: 2wIlH3tiU7XP28dcQpgvSS2A1RIPDhO6wGI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cff9b14-722f-49c9-4bdd-08da49aa3874
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 23:54:26.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qo6mj6WMaUNvhdN2BW5B82oNA0nQOoQQ3Z9pWO46gp9akcmzT/EOzVcD7BCxoSe+Tn0yx/Z0TqdeZKBopCtyqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1240
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



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, June 8, 2022 6:43 PM
> To: matthew.gerlach@linux.intel.com
> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>; gregkh@linuxfoundation.org;
> rafael@kernel.org; linux-kernel@vger.kernel.org; Wu, Hao
> <hao.wu@intel.com>; trix@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Weight, Russell H <russell.h.weight@intel.com>
> Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
>=20
> On Tue, Jun 07, 2022 at 05:27:38PM -0700, matthew.gerlach@linux.intel.com
> wrote:
> > On Tue, 7 Jun 2022, Mark Brown wrote:
> > > On Mon, Jun 06, 2022 at 09:37:55PM -0400, Tianfei Zhang wrote:
> > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> > > > This patch adds support for regmap APIs that are intended to be
> > > > used by the drivers of some devices which support generic indirect
> > > > register access, for example PMCI (Platform Management Control
> > > > Interface) device, HSSI (High Speed Serial Interface) device in FPG=
A.
>=20
> > > What is "generic indirect register access"?  I'm not clear what this
> > > is intended to support...
>=20
> > "indirect register access" is a RTL design pattern we use in FPGAs
> > frequently.  The design pattern involves a small number of registers
> > plus a little handshake code to access various register spaces inside
> > the FPGA fabric.  The design pattern is "generic" in the sense that
> > the same small number of registers and handshake can be used with many
> > different IP components in the FPGA.  Historically, the bit
> > definitions and handshaking was slightly different for each IP
> > component.  This is an attempt at a consistent usage across IP componen=
ts.
>=20
> > Would a different name help?
>=20
> This wouldn't address the major problem which is...
>=20
> > > > +	writel(0, ctx->base + INDIRECT_CMD_OFF);
> > > > +	ret =3D readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > > > +				 (!cmd), INDIRECT_INT_US,
> INDIRECT_TIMEOUT_US);
> > > > +	if (ret)
> > > > +		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn",
> > > > +__func__, cmd);
>=20
> > > ...and this doesn't look particularly generic, it looks like it's
> > > for some particular controller/bridge?
>=20
> ...that this appears to be entirely specific to some particular device, i=
t's got
> things like hard coded register addresses and timeouts which mean it can'=
t be
> reused.

Yet, this is a register access hardware controller/bridge widely used in FP=
GA IP blocks, like PMCI, HSSI.
How about we change the patch title like this:

regmap: add indirect register controller support
