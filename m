Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7615823B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiG0KBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiG0KBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:01:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2E31B798;
        Wed, 27 Jul 2022 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658916065; x=1690452065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QkZ7/u42dNuJ2bRAsD1NRTHkiQJWf2RDw5TjDjDa3xA=;
  b=Xk95b4GgH5GTNdRuQvLwAj/7eKXlaEnQemrVRhfDE/h4obHtw+efDtkE
   aah6esgRfF0aa08vU2dzXumTl1wdyjHOpcpwvVZnx82eRfGra+ySCaFgw
   TXvJC3LX7D2m99EsVx/Hnu62tK8Jj1n2kPz4WKyjvUipGrBqejfUY1/1g
   K/38SicErcR2MkQHlCV8mo0mS3EBOcyuoYbc4MCExosHHDFTGHy8d7U/e
   XVpeMxfMkEdqTYs9znLXuJlCDGJCw81oL7Ho/AS6pxHgDcX9E9/IKVoTb
   rMLS+Hy1tEgHh+3e+JxP2VRUBYPOfNB3K8ORGmWRmBz2iNjN0bXLxYLlZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289387682"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="289387682"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 03:01:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="633147515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 27 Jul 2022 03:01:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 03:01:04 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 03:01:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 03:01:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 03:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA/4+fKvswuJ7GguR/QqshTxF+/4jdlWUiiUjedkPLnE2B0gdAguntNtGFoI0fnNFkr7/SZLIIzwCq5hKWi4221IN883arHPwy1nqKvIoWm+N/amVMQf3JWld+GAtwl6L9b93Qz/9xyCRjn4lXiUPGoxnsjpQ5MNCxOMVf1m6yM9yGdiVTDjm9IOjOHWgmvBqMwS0/oHPy4PCCSElcNRL4Q7s3iUmRLgsZ8wJO3wgslchS3ICCezWCx5k//2Yidd0qj0pdmlJmzUtrZ/yJqjS5B+xkHMw3KrSJt2t8p77wPjmwjphIF2ub09OpEwJrq9heW+Iq+aqzPUmlqo61S9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au4kYAXyrRoJoU0DKBeYzay6GkP8LuQRFTtSM9ajk6A=;
 b=cypYXOOXLWeNbRu3G/EAQ3Tei16jYxAg8bGcp7pRC1tlRd9fRixF/ua8O4gM+rohgRSLnNYmgq5tAy3zENmKEmK6kJBN7E4mmr/Q7nLUzUUKxvlFb1UvH24ACoeecnVPKCdR0SroyFXeuasQ11bmYQ8fe2t5zt5X6CCuhRy3v2lM+Sak6wq+mw2hmWkrNg9hP9GCFyZTFDJ6345sGBHMpc5ao3GNBnUBlmS4hDx8ANKT6etuwlLQ0z0gHslJkiDQtO8ST4HVbDsslLUpE7GB/x8J/MACx6f+u2GNpJDaYYONF7ZSMUs131UWGagBndtc7zisZ7N2X/PR3w3KDTDzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Wed, 27 Jul
 2022 10:01:02 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521%7]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 10:01:02 +0000
From:   "Cao, Bingbu" <bingbu.cao@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Tu, ShawnX" <shawnx.tu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH v1 4/8] media: ov2740: Remove duplicate check for NULL
 fwnode
Thread-Topic: [PATCH v1 4/8] media: ov2740: Remove duplicate check for NULL
 fwnode
Thread-Index: AQHYoOgT3BbsvDQ0lEurL8cW5qr1wa2R/aEg
Date:   Wed, 27 Jul 2022 10:01:02 +0000
Message-ID: <DM8PR11MB5653DB7732D4EA48A1D45CCC99979@DM8PR11MB5653.namprd11.prod.outlook.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <20220726120556.2881-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220726120556.2881-4-andriy.shevchenko@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: 3b0be194-ecc1-4c82-37a2-08da6fb6e9bf
x-ms-traffictypediagnostic: PH8PR11MB6732:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KjBpeSQr8JMNP98CsiIs6vcir7FBtUeramJH3UuW4LO0+gxjGbIaeiLhRcTQS0lonFw0T5Ywcd2o2ZE3SpCho9M1ovySJRFIO85SoL6NzjfO8eJBtzINcbryprji2ikCr06rYZzMai9OMBdZZlYCC+daA1hf1tU7ZL998zuXkEfyih1rd1YF3I7xKwF9ACehDD6iy8Nffw387BuGlUm030/+V+B2WKyXrudrZe5OD9sPFP41wwA/K4paOkJusyFHcIsp1XFOSlTP7Ivu+2vtEkvGQljML4iWwnJOyyqQabX3DoMpt5jxaelXqlyTn+b/GnZRXtHXjKvOIn+5YgvAT5kPekus3POKfVuuTcu9i1026teQs/QwQ2JH0e6ZYIyq9Y+BqdAUY2h8Dqg8xedehdvXp5lUIIPc/JdHGX5ktVq2z8nTACrZ4ZXIdESO02uqz9N8A0h433VLNmcEPItJJzFxRTjbzqasWvSd1pv3CW16NoQeWcE9qmVJvzEBarUxULUgZwYfrC7IddWVH5hCOomHsen4WAbuT9Ljz9PvSQkZJmANYQilSAnYsHUY2D6cNtINwyobgLQKItdKyIZ8OM3fuL/9gp+OvdONm2WJVMjBHOVL4zYMcm5AVv8Ei8k8yj2T0Q4ZHhUKGCyZbyKDUNtMZEnTbfFaNRKqsYV6+r+U5LW520XmkS1id/1wDPZd/PK/1Mo+/pl/vDIAPEfeYdNKZhzWzFOc0GeKyzN+r8D2CsM3O0YFhYKK24iE3z5L6xOzzW2ck+ceTf8f/GXzfXVjyOsOywXOD6FPHDb6haJU3L+gs4tlBlzb9pbhd7TC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5653.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(396003)(366004)(376002)(64756008)(7696005)(66556008)(33656002)(26005)(76116006)(66476007)(66946007)(6506007)(83380400001)(41300700001)(53546011)(54906003)(316002)(4326008)(8676002)(9686003)(86362001)(38070700005)(186003)(110136005)(122000001)(5660300002)(55016003)(8936002)(38100700002)(71200400001)(2906002)(478600001)(82960400001)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vUG2Q0h1ZvpCP/hOt4+Zu4uVLLJX8cDB0HKAB5PLprF6G2WOD32fisPca3Z+?=
 =?us-ascii?Q?6uGdwK4PWdu6aAoNocFqT2ZpqNu7F1JIf1q44RSYaIfaKvj0oskJD02GB6D4?=
 =?us-ascii?Q?LuS0JKNWfVAWPQn+1L21Gvm3V/RUWPJ6xmLWqyl4lxPIABw0EbNJ3n71ZfB4?=
 =?us-ascii?Q?of9eA6MCS3UCSrF7L5U3xXNHrxAfqE3ee/pswC1ooSUgcxuLB9D0OlhQDYvH?=
 =?us-ascii?Q?kLKBzUP2DXO+/bXGC7s2JUnT7qFStAPVz3E4YRgLLr1HWBt7FgGIL9on9PUM?=
 =?us-ascii?Q?hIV5QPOkMntxj8Mnbw8L32OinU9L67sTsCLnu7R1/6k8gY95VqNBbzNDVpxS?=
 =?us-ascii?Q?m6oxTmgvuInU7LIt5RFfunxOmYzLuMALV2k3FxjTF6Ye5tlQDe7Sx1mVKvdf?=
 =?us-ascii?Q?zwDj0ZNBKpYlXkWlvChh9GjBEylYelBLfn00hC64EMkumuZs1BIt8o/2v+YF?=
 =?us-ascii?Q?31g56pd68DSNReF1Ql7wB7Qx/0pg3eVYImBRzVFVRYVpLJUexrf0yFpXrcZS?=
 =?us-ascii?Q?E2lnA9JO+5dHIe5XojHSf/Rv1orFqsybSCGWxw8Ok+5Warkuyt61L9OBODv4?=
 =?us-ascii?Q?R7GkPuQTNgy6/8Es0NSDzglF56RVCapuMrIPzjc5o8jId10+1VSqc8gaC5K7?=
 =?us-ascii?Q?2hRKYOzemn5VNYrWC631p3PcrJvQaQjKLHhl43gOn99sRjgn+XA6McwGOBbA?=
 =?us-ascii?Q?EH1Yz5jG8k8jQbQucMeaOLm91/JFSF6HaeKtTYqhS89qUVxdbXPWL7kc0u4b?=
 =?us-ascii?Q?x//bQIvbCuTz1snXNojLUyhCYotkJSWefzWpyNVLs2uFNlRiJk7mQ20xwMqx?=
 =?us-ascii?Q?2Nd/wAteb0EgFYjqol9nXuJRLJ4L8dnLGQFIYhccrTDrUC7iX1Y33xsZgr/L?=
 =?us-ascii?Q?oJM2h9nL59dqBlJfWTpqz+GfAV5EgLse1orjmWqjqH5FAdAmKZ1IntjA4DZp?=
 =?us-ascii?Q?KaWF6v3jE2oQ/4k3pTxwHoQd1LvSY2sDAS/PO0JKY5VUGEEKlO7ELpXLQjtp?=
 =?us-ascii?Q?x2j1xcg6eXleYwMUKTP9kZ0702gheWJmVgu3FcsqWMJO3Ne9sqkQO2UbI+D0?=
 =?us-ascii?Q?hkA7a5KinD1Jl0jUQAW0F7HoO3tYrTryV7HkJICmMmn49GpqOX7CkOCZMQuV?=
 =?us-ascii?Q?wF18w85/erLf5NE0f5rKLvZiNbCwbTsehoYn2e6sCVo1FGSp35qUy0LP41gF?=
 =?us-ascii?Q?rKU7jUFW8DNCJOylkGww79J0rnzqm/H/I3wj2KOl28nos0yr8Dp/X040pnM1?=
 =?us-ascii?Q?YtVOkwG42CRdDHH/KH8o7EqMg7qJYQouRNVcl+oSJ7mrHfeziLDsra+m7vC7?=
 =?us-ascii?Q?pIfVQMy5SD+WGAq7TYxVqHGvr6rWWs/stNowUpulqbPLhwegsDzJf6VbBk7l?=
 =?us-ascii?Q?XeV40+lTEkyO9gCdQvOwLTH0uPfKumBB7pkBfesq1L5Sk2SRn45cEKOjX63j?=
 =?us-ascii?Q?UkwSuhyfoUnJa5q545F7sQiHLQsGyvYYluvRPbPL2bVUx0H2s3NSJ78COi+s?=
 =?us-ascii?Q?z5h3015PfgJhxXNe9l0QgsXgEVTXvOoVNAt+Opc58o1D0lj/+MVDAxiB6yLW?=
 =?us-ascii?Q?1GprSgn/Lx5CF/ctgqmSfXTmZ/iKY1dUGugmHK3h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0be194-ecc1-4c82-37a2-08da6fb6e9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 10:01:02.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAndfCU8vgVXL5poWMNDEcGHwmaKlrfVn/0Q1Z56Re2lSKXtjv0KXyf7gsFUdlxy5GioGS28zivxmCGIOS3I/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>

________________________
BRs, =20
Bingbu Cao=20

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, July 26, 2022 8:06 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> media@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Qiu, Tian Shu <tian.shu.qiu@intel.com>; Tu, ShawnX
> <shawnx.tu@intel.com>; Cao, Bingbu <bingbu.cao@intel.com>; Mauro Carvalho
> Chehab <mchehab@kernel.org>
> Subject: [PATCH v1 4/8] media: ov2740: Remove duplicate check for NULL
> fwnode
>=20
> fwnode API does proper checks and returns correct codes, no need to repea=
t
> it in the caller.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/i2c/ov2740.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c inde=
x
> 9420258c6073..07fe8fda274e 100644
> --- a/drivers/media/i2c/ov2740.c
> +++ b/drivers/media/i2c/ov2740.c
> @@ -1009,9 +1009,6 @@ static int ov2740_check_hwcfg(struct device *dev)
>  	int ret;
>  	unsigned int i, j;
>=20
> -	if (!fwnode)
> -		return -ENXIO;
> -
>  	ret =3D fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
>  	if (ret)
>  		return ret;
> --
> 2.35.1

