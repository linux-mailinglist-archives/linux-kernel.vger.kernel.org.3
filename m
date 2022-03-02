Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9194CAAB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiCBQrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiCBQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:47:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237ECD0046
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646239621; x=1677775621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vuK7gYXcvpkO59iBqloOC5uZIl0xUkeoh34Z3383Bzw=;
  b=C4Z6V3mZjqWpU7awURt+Ox4VH19Jw0RGWCCltxw6+Gh4ODjSyTZVeCSI
   hP3QYJP50Ke29H58dyATADpo7F856K55jbbzGN2oRWUSLzZ+7Ur/o2ElW
   +XvUZ7Ze/0RtUR6xVTGxUserLWEOmgCWLMdZcMf+b6uNMahE2fIYXGjl3
   TM+K3stRiR67le2YpR4Ll0obFickd4W0f4I7gfN5RBZMcdIpi8Iqj2BVr
   aNwu5Z+vgNWBfI6rDF/Y4nDZsUc7xsxzoS8xJgHs8JLi61+zntWOMvGPU
   m1n0deSaTIqLwbXE35ZfgDVGKNZc0XYN7OCf5eAPLR1RyJK8evSPO1Mv2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="234064489"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="234064489"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 08:46:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="686188929"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2022 08:46:48 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 08:46:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 08:46:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 2 Mar 2022 08:46:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 2 Mar 2022 08:46:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+L9nFnmWNrTyVddZ/teSD3YG40m/9RSBS8m440+L8QvbQ4g62Wk/egKOfAkjgpCXmfCcc/VcVVV3XHzKQY6dBNhyxoNJYgCw4FcqvF12ZUQPDrlz1bj7iDLJ3CGnwiY021aXw6mhZzSenh6/9UgjD7eXIiMf4xhMhlAy9kUQsPAmmmiH9KGEmPmx5Vq+OOKlGz5C5UEQzhv/m+0A0iwZhkA83bAPUs5hcS/NSWycqEnDsQSs93fYhT6r+wK2OHhkmlqyitmZPWrqSka5HfWEuhq6KPm9V0LSagalYrmD4W2XJxMZVLaBBEqMReydH8J2sgnyw5vwe+Kgyz8SXspfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJtmopFZD3Nc/c+I+BdDJsj4uRrkstZjITb50MMPwUk=;
 b=Xiq2HqQjzRR6U/+DYyENlLayWnFWR7iuYR0zEg59bvx6Zjaq6oUYrDbLHPLnKsVUWeudCw68RRnbjan67IEzI8ymENzjrg07ZWMmqmI+dWNOicrkr2qT7JHdkdw7/1mcrpJgo9GyQt7lav5x2EZ+XW6js4L9mhwijLNCOc8svPYhUP+JS0gdWGlxoYSp2UyyCshZsmwEVJmnB/oHsmNQkV6pADTCy7+4fe5x9R9FqqLQt87f4HVBsDykWJuhNnO7Q7c2b9lZaCSun4lDWLKmFZU6GBHYG716Dd+5cMLhC3mXtRPcMnYBZ/ZngoLZwCZrxlTJTYqoa6DMQR9QDag3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5897.namprd11.prod.outlook.com (2603:10b6:806:228::20)
 by DM5PR11MB1803.namprd11.prod.outlook.com (2603:10b6:3:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 16:46:45 +0000
Received: from SA1PR11MB5897.namprd11.prod.outlook.com
 ([fe80::a529:c483:ba76:4bc5]) by SA1PR11MB5897.namprd11.prod.outlook.com
 ([fe80::a529:c483:ba76:4bc5%6]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 16:46:45 +0000
From:   "Nguyen, Dinh" <dinh.nguyen@intel.com>
To:     "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "spujar@nvidia.com" <spujar@nvidia.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: defconfig: enable the CVP driver
Thread-Topic: [PATCH] arm64: defconfig: enable the CVP driver
Thread-Index: AQHYK9SgnSrZRhHZ0keIhRusu9ooN6ysUl0w
Date:   Wed, 2 Mar 2022 16:46:45 +0000
Message-ID: <SA1PR11MB5897E5B9ACEC86235FB0846CE4039@SA1PR11MB5897.namprd11.prod.outlook.com>
References: <20220227122127.35093-1-niravkumar.l.rabara@intel.com>
In-Reply-To: <20220227122127.35093-1-niravkumar.l.rabara@intel.com>
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
x-ms-office365-filtering-correlation-id: efbeca54-a58a-4976-1b2e-08d9fc6c3cd0
x-ms-traffictypediagnostic: DM5PR11MB1803:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1803129FFDEB4E4EA7A82897E4039@DM5PR11MB1803.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ziDG1PM0455yiMcQoGGvaypCD2gjS4U5NsbMAGlgjWTtic4af6Uotw1xgMZ7nrR0AShDymn66/l6WrzuKU/Jr0LNsqtJBVMu7ZTSYWPmA5kbvRzG4u0DVGkopIqHaaRbb3XGcAzXeNk6m8dLA7whICYQU5HW3DNxVEd07rkM3h6AfXFYq7DiC4YEyEwN90TFDBNRx0HsTtvYlhzGkXxJSvCwxTGhF9SzehJRxA3C/XV44iexWTcF2g9TvaZeolX5x2l7/DEPCj6wg93V13ek73FNdCoKGeJKBlhB5BZkuGOZqOVRoGixRhzx9TT+4aj/pFioQqomakFac/KuW+49IvtDEvye6ddqRNeSwWlwmMYY7AN0q/iP4+lQfGcFC/dz7fACjaxRMGGBtzdeC5fSBl9W5lQikKzFqmJVrt/JkDgxAFcY0wlOBL+sVISlnyYH3+VtB5flpk+ceW0vtryFCU8zAq0mNz7ykPSzpDT8gai41ddr6buP08BWxHJnOykBfWhL1BL5zlysG+AGwVLtcyZ9SxGv7Aoy9yTiB7fD1SWepFw/CxRCeb1T3bbCnLDjguf9xVOl5g+QvzUY1arKLe68wQzo9p4gHcNpoQ+qSlmtfoUrcL5s6RzsdUY3qtNTpxr99Ix0GKNF4AjDWqGW24K2TCqYrBEL4AHt+8nHhNEWDgipYCqnIUVD3SVlggoPu4CfQe0ITMWPnCARb5QqBve1TZ79Lp3iamyX4eOGs4Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5897.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(52536014)(508600001)(83380400001)(54906003)(7416002)(86362001)(71200400001)(55016003)(26005)(186003)(5660300002)(110136005)(316002)(66556008)(66946007)(64756008)(66476007)(66446008)(122000001)(38070700005)(8676002)(4326008)(33656002)(38100700002)(53546011)(6506007)(7696005)(921005)(9686003)(82960400001)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HI0CEuwQlstr8EOx6iGcMUnG8jnpMl9WqU/bFVR9GdvywQ0U2nky+7c+stZF?=
 =?us-ascii?Q?42WAXkwuYizFRg5WcPRw6YpCHqYUIbjHHbCR+/WJpV8IrnBR9ZPQp3SWL7jP?=
 =?us-ascii?Q?3bTx80VH54mX9DMCOUb5ilypJVnhCZImfXZkiXqJk5Eo4Xj1mj7WJH64bjUZ?=
 =?us-ascii?Q?Jji/AFqzVSm87wjh7kDTYz1AZBieLBwWlyoHY68tcEK5UloCIh1RI77hqNvc?=
 =?us-ascii?Q?1YHT8Lw4/MmKa/JQm3rosqOUcMQYAVlXOXdAv+D1M9UkmcX+REHpZQL/X8k1?=
 =?us-ascii?Q?kXKYWZ7oO07/g1eodNafrWBx6GvqhFKESURjIq5hhs63FSnuumpfesLCrCWV?=
 =?us-ascii?Q?jZZmhmaJBZ2fsPhecjFWPGyjXhsg0q1um1KmLamPa11DF3UnwjIPQyV0Vc3y?=
 =?us-ascii?Q?hGh2A6b6QKOWthK2cH4CqubmeH7OiULLH5PZlj3O0Uur9oqwF6/qGTEN7cVh?=
 =?us-ascii?Q?f9+qfI7+KHPtO4NcFOLzoZ85TwXR0n9j49xiCRK9waWZO26+n2ZrO0RGJ2Vl?=
 =?us-ascii?Q?Njd4rDcTv4VZKjPGZPlSRWxJ9svXkDQ4seeIA2PUDQOswwcqHJkOj2m1oJv2?=
 =?us-ascii?Q?78pYVogAHHYcIS8+5dRX1aZL96qHZan9iWP2Js3gnK8g/zFSc+3Vnh632cUP?=
 =?us-ascii?Q?tyGsOUxL/NayAQk0g0UfLrCwo78QtRYDrsMj5yQf8i60eMhzayMrEtV7+0Pd?=
 =?us-ascii?Q?do93newhVa5iz8BKZJDt1KxKEmPJ7T8au0i/AuuzblumVM0fjKL0nTcQMb2s?=
 =?us-ascii?Q?xh9cTJJe87yVoTPPSyk4HdV0EDXVutVcbXnJvLrPkGxQBHri+MIZpPt+mJSv?=
 =?us-ascii?Q?h42A+mQHlHK/Ep60Z1Sj/AA+B2sO8CxHafLgpWl0OclLzL1Ge75nj4BdGYUo?=
 =?us-ascii?Q?b9gmD5pF80uOvoldwzoxTpwyx3eEC/xM59NJG/xBll7ndB6LB3iWgLZ6QUJ3?=
 =?us-ascii?Q?6rC+CgNmG+hpEiUaBH+82sPng40Aebe5yvRDwr/p7GrenBO1q3uXXGkV4me/?=
 =?us-ascii?Q?14xH5oBbOZmJUibTV0y/mETZQONAHR4bFKvGWEv2uTMJuc4HpVFdzpF/YAP4?=
 =?us-ascii?Q?XPrHo4XZC4pbJ/VIeUnPF0At4QsMvw1CSDk418PNjfoIgMH/pgkvzN2h+okU?=
 =?us-ascii?Q?NQ2rZcArpYtHdC87oCPcM3iYO8Vrf+1VV6DCdvQxW5LmFrq1XH02FtTg/rQ7?=
 =?us-ascii?Q?tTKV18reqZrBSW2wa9TxpQERCzmMMyQTdq9ODdJEi54mORexxmqoEkinZxFd?=
 =?us-ascii?Q?Csiq+s+pYExMB/LFYFogvttCrKpwloNm9WLBrlXa4NCdY/3zCn86+Xn1ShYG?=
 =?us-ascii?Q?3G6xv6AgxDpHKnywaI1phl5IBb3ptGZrCjJevEXxZ0ONMfjCOKLizY8GIMIV?=
 =?us-ascii?Q?c67YgmLmwauLbdPGIxAh4aao2vV+fCVQsNGrVL/aXjDKUDXY8NqBPbfSD9k/?=
 =?us-ascii?Q?aIjtpU5pcyR5fiy6GU9/v5L0/54YAJctIv5rEsyZYKVHbWVweEoL8Q9a+8jo?=
 =?us-ascii?Q?9dF1hJ0vGHaJRry6hkUO154YKej+mTbMLilO6emgeK+2vTdBDeyuFcVNw9ey?=
 =?us-ascii?Q?MzYvJE9Mp8Z3FIP2VuR4pMEalssbM5UEHRB9K/jP2EixP4SkwuSCVwk9pOXt?=
 =?us-ascii?Q?t1JVMVbPvVHT5h89+7U4CNc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5897.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbeca54-a58a-4976-1b2e-08d9fc6c3cd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 16:46:45.6262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+c67z+F53+5W0KFTuKyOlcMLA6E1+AGJRPoolt5nYx6h0sT9gZ0B2IDA9vQ3dz/wkr2cn2JJP/pq2yurnld1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rabara, Niravkumar L <niravkumar.l.rabara@intel.com>
> Sent: Sunday, February 27, 2022 6:21 AM
> To: catalin.marinas@arm.com; will@kernel.org; shawnguo@kernel.org;
> bjorn.andersson@linaro.org; geert+renesas@glider.be; krzk@kernel.org;
> biju.das.jz@bp.renesas.com; enric.balletbo@collabora.com;
> nobuhiro1.iwamatsu@toshiba.co.jp; aford173@gmail.com;
> alexander.stein@ew.tq-group.com; spujar@nvidia.com;
> yuzenghui@huawei.com; festevam@gmail.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; R=
abara,
> Niravkumar L <niravkumar.l.rabara@intel.com>; Nguyen, Dinh
> <dinh.nguyen@intel.com>
> Subject: [PATCH] arm64: defconfig: enable the CVP driver
>=20
> From: Dinh Nguyen <dinh.nguyen@intel.com>
>=20
> Build the CVP driver in the standard arm64 defconfig.
>=20
> Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 30516dc0b70e..b2efafb15de6 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1172,6 +1172,7 @@ CONFIG_UNIPHIER_EFUSE=3Dy
> CONFIG_MESON_EFUSE=3Dm  CONFIG_NVMEM_RMEM=3Dm  CONFIG_FPGA=3Dy
> +CONFIG_FPGA_MGR_ALTERA_CVP=3Dm
>  CONFIG_FPGA_MGR_STRATIX10_SOC=3Dm
>  CONFIG_FPGA_BRIDGE=3Dm
>  CONFIG_ALTERA_FREEZE_BRIDGE=3Dm
> --
> 2.19.0

Applied!

Thanks,
Dinh
