Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5304A53F5C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiFGF5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiFGF5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:57:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C966F20BC4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 22:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654581448; x=1686117448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B+gS/aAuoXUMV+oMKZgbOl83oarhdfyCdaabMYF181o=;
  b=YisFK6kgF0wQYmE+uXrgCu5K9kU+kvYEE/fLfLaAUIOa0r0OD7RNvmMN
   AbKPO7F1F6iXXItoyWq8zYZAUD+nQBuVDTIU4Z5mqqKqj7IH6EIlbpnBM
   RO+OUsINYEcGU6/s/Y76rRIREikkDd61aU3kXeoXNbu4BSV/PScSrC6ti
   goAflPXilua9ZfjxLk9ByVvNBrhRZIJEEA/cEnSxqWs/u7To/DefSx29q
   JTmizRsg4/o5yGW2Rz0rY3PAnECBshl7GJhD/IoUCxEm/Qfm2DrTQ8B9o
   Zgere+9wePh6kacBN7ydMRiXtOS6zCaDwcy4Gek1JPH8s94OEHvaz4lMX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="274244662"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="274244662"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 22:57:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="682595616"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2022 22:57:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 6 Jun 2022 22:57:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 6 Jun 2022 22:57:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 6 Jun 2022 22:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3EAiE8IjQJvkjBiiXIhWtdhX8cQaa/WwaoQGsCznZ8JneU3HHSKsV7PBU9suAGusHQ4N6z7OsUuzcvJrx5zIcRauvKPLDxA/ZYDlYYnVb67vXXIy8RIpF5nc7bpYGnht7Eo5Rqf2P18idylnbkQtUTQCF6aMfTaDzes07brAwbndbbxgQ0/N2qRbdnCNTm9ypCmi/CqmPqEpXRm7FqWlKyy9Y8WwXcDTW4G2iVRzbOiQqCumkThSnb78UNkN4bqBRciJ3l6ZYGG8mkddNao9Pl2HZIi5eGguN1akx1PIDskqUs0m7ACewxOZ8QXP0Dn/32sKRTNUl6A6ZEMPbyv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYWq8ZUPkk8sx3z9wAAkfUmMl4GVDwnxdux4vNwM8Xk=;
 b=QhbStvpZlVaf5HzKQUDZJufiNO1JukHEauR0eh1aPbshACeBkcXUedYqs62g6j0HU9ALUQgiJbQHBXAoib3BaB5ExZ2dBfgZtOcM0YjWTcOSSoN5AuYyOEpqf8MTFz4rOggtTA4LxivRBvZzMbSzQrSP4pLZpqmUkZ87m5+PipAjutp36q5zhVgDgJScaNV5Ibe1SgxfyV5UjDXm/RcXaRZ6t+GuJ727m/2ZCjcQ76APkBgYgO4GH520NvIllnXgHbClGC+YQwrPa2Eh3gJE1frdOxMUiTm49fwBrkU3FNNHU2XMZ1T5rJywnDH8jI55Cj9Az2JoUjGCuB4bfA9dXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 05:57:26 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::4d94:5d8b:51d7:d8b4]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::4d94:5d8b:51d7:d8b4%9]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 05:57:26 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] regmap: add generic indirect regmap support
Thread-Topic: [PATCH v1] regmap: add generic indirect regmap support
Thread-Index: AQHYeg+4rjimubWf70mLnwe3EofT5q1DYAqAgAAQOgA=
Date:   Tue, 7 Jun 2022 05:57:26 +0000
Message-ID: <BN9PR11MB5483041B0B76EB4486266E93E3A59@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220607013755.594554-1-tianfei.zhang@intel.com>
 <Yp7ZCWq3yjNcMM4N@kroah.com>
In-Reply-To: <Yp7ZCWq3yjNcMM4N@kroah.com>
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
x-ms-office365-filtering-correlation-id: 975fb8ec-40d4-47f8-fc60-08da484a9961
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL3PR11MB648482F4C393289559ECC62DE3A59@BL3PR11MB6484.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RqH/HdOPraQ6urG9Kc+bo4yUYv5s1/7VJZyaQOwWDXVN6a8Q+sGJGnkiKrtPlk0yEr3HNBZbQ71P30qTX+tq5HbhwBdZ5Oo2eBOQsxUMjzjS/EdeQNXse5Xs8lkSBJqnX6zSufD1IdxN3A/eLkGJzEkDo4n5/B8o7SA+358IHtg3BCKah7U60YJo8yiCVUMh5c/wIqmGNP4ZXtrlQ/LyDWngSZCn8gbh8V94f/1fSiZ6v/W0w+0vwSvxQnD/EHPDZ3t3bgvtFgdkmgwn2WDFwLc8bFGSwaUEAVM0PAhIqFaT4PuR2FQdT3GvWNEWPdaOZKSDtLaavvJmsu3IA0JQNBzz+6QysKLieJjJfPnDC0mBqdWXGlKWDLUhkOlWRNR1auAnoLLHMx/fZM2wPqFcV3HjUeyjpgIBo1sJuVCVpOlka64JK/uiBTJyhQP+Qv3Yv5qGuBhB785bRLlyjXiJEYAee89CtaKO9CwAuusYn8yfgzJViY94JhRpbD6EPzaNHEN3EZP4I3AdJmJwtvPqqmImx7shsOqbQmGfwKo0vpCkBt5TxUsgYG3VT86DBBWZcAdXYkVrnRJdVHSVZPpp5Hov8cewvOZf46CysQZBXBjZDzAuzrPajaNuzg2OWm9TjW3q0j7+uwx9UO/JzcbFrpOn5/nE35pyfGY1l+h497kxpfZF06djNacmN5UPy8OiwIuSmnzr/aAm0dyRwZ78sPL8DjX8nDs/qtwZIx7FhkYqJ3ax0mhcdtMLSZfFsdfFLcXOKJy4mOU8EoJrE9+ZAGutVOxkvBvu7w8KxWVp5nJR8XwmlS7LCk+tquPlBcbd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(7696005)(86362001)(52536014)(186003)(966005)(53546011)(9686003)(26005)(8936002)(54906003)(316002)(33656002)(6916009)(122000001)(6506007)(82960400001)(508600001)(83380400001)(5660300002)(38100700002)(38070700005)(66446008)(66476007)(8676002)(64756008)(66556008)(71200400001)(76116006)(66946007)(2906002)(4326008)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ojftpu7+K3dvdIQrQnP84tEBRHC5XeRLtU/Rv944T04dRvVzIH+rdqE5qzDK?=
 =?us-ascii?Q?5/L5noTotuNsBvlJz2KdNHxcYlUKhyytqi4fkYnqN1z7OkyEeWbk0XUEL8/T?=
 =?us-ascii?Q?au255gNaYlPSIgfIFSG2PQcOGQ1A7PijVpG+IahD6zt+PUwAHaggjZx/pPHR?=
 =?us-ascii?Q?vIjwtdJE8ROTNX9bpYx8yJOVK09NH7qsyfm3N+VLj2HirEENYD5bhPcy0fK6?=
 =?us-ascii?Q?RyTtxoboAmxpyYLJbUv3pbGMR+RwDsonxHS4Vu3chacr6GeCNm/y8ZSyKxYA?=
 =?us-ascii?Q?qv0hZ3l9cKcIaCx7s2zlhAAL5BglTcOkG18DAGpXGEHi88uU1SThSY72jHkN?=
 =?us-ascii?Q?p+wd9QyZZVyDnM0/qp+1wj4qMmixkQRu3qZX3dCOiip7kzrgTVrr1k0ZSVg5?=
 =?us-ascii?Q?Hq+nLj0kKYvAWiNTQ7BU7YZizzZ0cirRRqi1pijyMJCXKH7AzOGufyZkthBa?=
 =?us-ascii?Q?MAlnuBKOKWIEe6cj4u70UHz60+aYt0a94/zj/Ivv0vZnnjl0RIO/b72eOjCQ?=
 =?us-ascii?Q?eoBsOoBrD4Q1y8qId+obiaAvVhbrPghVkHx3qD11PGjYRO2oYEDGbRgigGkC?=
 =?us-ascii?Q?mQ00FvVivFHfZhw+PnlHXjC78gDcAj+MRJTedhIt6LuxP1m9XLmYA4gTRg2A?=
 =?us-ascii?Q?LSNUbbZiY/pUQDoXb1dmxEiMqbHZ0vnEQ2KMWTDjlCX05ia3PfkL3Nqb1U8c?=
 =?us-ascii?Q?CqD51SsU+WKveccedJWUOtjdYcvOSw2WVe1YVnvmoU8TFHCXXjCV7uRQ30tI?=
 =?us-ascii?Q?mc33E5D4UZ64c4gIkxoW9Y6NbICVAjsdoT1jhseiFWURmt1vOeRT4FyPVCiD?=
 =?us-ascii?Q?OcTI6P/MTDtqSzWDa0hdmwtFrxC9JYEQ4ZlOdH/jNAJiJBY0IjOYlUKprJ1j?=
 =?us-ascii?Q?yxQQBDdbCK+P6cmsLDozxu5sT2IdN7bKvX0V+s7FOzRgdXeE9MKsKjl24vQU?=
 =?us-ascii?Q?SRGC4fd72QO31/ZaGu2ch4MxpGx8XLD5y4sqrlm+YyhSgdlrzKVSTxdemk66?=
 =?us-ascii?Q?/mCGFmcgUw3k+Ohij3kNRX48/SipT58ZhDhJWEIVw8r9C8O1YiQj5z4Se67I?=
 =?us-ascii?Q?rQb22luFdQ5WAQQpblOKPp6k758YAzBdDaKO5Tp5+A9BrkaJjbOI8b2LPGDv?=
 =?us-ascii?Q?iwRNSsDxsbImQQ2sQFw6RoS212toAo+WR9JKddZMhm2N235wZ3M/sEJ9UlWK?=
 =?us-ascii?Q?9Vnisnl5nQsdGmkPcwTXkJzVJY3MqXuOf9VAV1gl6ieUgXQ46d/PeD8XbnE2?=
 =?us-ascii?Q?vj+cfq8507ToGk/lgjZXBX0xr0f+er12TTMJ9MrLrUQnUbl3ZjMpUZwFlL9Y?=
 =?us-ascii?Q?eS+cTJRZIz43u7bMYtI6Ko2PXRVon9NjS66eA/nBSBBRkw0jdfrlic0u1CzO?=
 =?us-ascii?Q?sed+iEGLDj2CqVPGeqWJQvBMAdSQp2rLQ5+8tisXex4EGJWCXmmP9o82Mwu0?=
 =?us-ascii?Q?ggQzkhRoWisgzD2RhbNVi+2LexEvigyXHX9N9MC+0CRJSJ/QiHROfRmbwOJh?=
 =?us-ascii?Q?OWfE7B/ooGQociF51kCEtlZG6Xn1w1UdMTkvnEobCIR9V8YOzzA4ErilOedD?=
 =?us-ascii?Q?AAqv+q83TxUZxlu0s/uRltBymw9yqzpHjONuoQYZkV8ysL8Zrglj+Gpo5hhz?=
 =?us-ascii?Q?OBIcl/LBFMc3vQua44JwDtJS8jHv9jN/HMv+R5CMIURo3OMRWcZWHb4+lsnZ?=
 =?us-ascii?Q?NJK7ESij98oJj7rCZMy3zS36+oVBOQ57hnwEJHcmtUljXq5SILarSneKrgeR?=
 =?us-ascii?Q?4lgwxtMXlA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975fb8ec-40d4-47f8-fc60-08da484a9961
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 05:57:26.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //5SetLAAZBz4Zjwqe+JrLVgZJCp12udGoM9GVX6MOAGVG3bvp3xpRHBn5adc7GpkXbQrDtUhn1OhajiBx+8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6484
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
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, June 7, 2022 12:50 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: broonie@kernel.org; rafael@kernel.org; linux-kernel@vger.kernel.org; =
Wu,
> Hao <hao.wu@intel.com>; trix@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Weight, Russell H <russell.h.weight@intel.com>; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>
> Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
>=20
> On Mon, Jun 06, 2022 at 09:37:55PM -0400, Tianfei Zhang wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > This patch adds support for regmap APIs that are intended to be used
> > by the drivers of some devices which support generic indirect register
> > access, for example PMCI (Platform Management Control Interface)
> > device, HSSI (High Speed Serial Interface) device in FPGA.
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/base/regmap/Kconfig                   |   3 +
> >  drivers/base/regmap/Makefile                  |   1 +
> >  .../base/regmap/regmap-indirect-register.c    | 133 ++++++++++++++++++
> >  include/linux/regmap.h                        |  12 ++
> >  4 files changed, 149 insertions(+)
> >  create mode 100644 drivers/base/regmap/regmap-indirect-register.c
>=20
> Don't we need users of these before we can take them?

One of user is the PMCI (Platform Management Control Interface) driver of I=
ntel FPGA PAC Card,=20
PMCI device was connected to card BMC which provided telemetry and mailbox =
functionalities.

The PMCI driver is under review now:
https://lore.kernel.org/all/20220607032833.3482-1-tianfei.zhang@intel.com/

