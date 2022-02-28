Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F244C63E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiB1Hkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiB1Hki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:40:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E5E674F5;
        Sun, 27 Feb 2022 23:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646034000; x=1677570000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q1rthEnP0gNj6vObnBQNxpl6OsE27qdNfHvR+Piopig=;
  b=PS2g0hU6JGn+OEwg2gPlDcgRhsbsAMzfYb8tdFc72+B0iY0Xg7N3miSx
   Phq+n1J8H2w2175OKigcFFY+IRqUblZRZ80ZoIOlYZQTzT6dYbOFvIeGV
   I9zBNEA2kNLBWSDBQImyE0lH5S1ih7sonvVW2M6zdNKZXgb4CRI9k70qO
   6zyeI4R1EbthBqOJ3em8tDiapMeYML1EbtgoZbUATfAMiV0hgNpcZYwCp
   eizvG5fMTyaK0BWn/BMTsYUj2WxbWROY+1x4CVNmer3KgqW0WfSDUf/5g
   VSc4ZyApycd27E0sKkTKtsJ5iP4dOK2aKVq8EwfE7UgLjbCnZBqA06t5c
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="253017673"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="253017673"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 23:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="640804814"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 27 Feb 2022 23:39:59 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 27 Feb 2022 23:39:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Sun, 27 Feb 2022 23:39:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 27 Feb 2022 23:39:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2/vDf3VY+B/Fh0Yh3nrl7R75AlN5yRTOz6pnoqqjRF+Vzn3h8btWLTBanXhzMnm847Hx1HRcXN5bg2TO+AggBhiSfuJNPwimlFNJ3ZYq3vBd/hd4PddRbip/qNGuWTumf6EGib70fMOj6UOjIikY5T1lWCloMwhvo3yw8IUvoz1juTltKJwfAEDtfWVDzPq1YSfWkUljn2sfq4U0yxt+UTQFS/CyAS9CR1Q6TWUOWzxwQMa2P5fEp+1XUMJnpyMGPw/1xIgl93BbTJ1ak975EVFcen9qtdVX8QSWqspbUpI5ZgnV3Rws4YuQ3CSIcvt4keDGEoMKCluj2lVWrDQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7alWvpAJfr5bvp7Vw0h87PrQtPOLCX/7MC2PmoG3DQ8=;
 b=cjpw2u1RvrI+Rdb8LdikGesykc43LaLKNYFqKH5LUFyKvruJ6rduJqSB/iRT15Cdi7CD6u++TMOcSzg3XW75B46hacdgwpCxmHn2K+c3MGusuNX6gF3H+Sj5uWXGbOPXnDhEeOlHw1ReBEn0VlR29g5M8LFQkDSi/mScS7pNK6kt9YpuH9cxS7eJufATmVjGRdbJTeHN1HrNTZV1OlfOaHobEty8sFhrPIIEs3h+duGKM/0P2nDFCBYDGkJZq2LB+P0LDvgLjFFMWcvvu52uHO3N/lnEb4yQ8MXvFmbJ2l2KO/xI3pUFS0JhQEpfIUQQviRHu4prmyUmJE4TZxDOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by DM6PR11MB4234.namprd11.prod.outlook.com (2603:10b6:5:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 07:39:56 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::f047:13:ac5e:a04a]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::f047:13:ac5e:a04a%8]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 07:39:56 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHYJ9KVLj3sL+vmrk6q1BhORuJTLayonMIw
Date:   Mon, 28 Feb 2022 07:39:55 +0000
Message-ID: <BN9PR11MB5545BEA697108310F7D4D261F1019@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-3-shruthi.sanil@intel.com>
In-Reply-To: <20220222095654.9097-3-shruthi.sanil@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08dafc03-d417-49e0-e7d6-08d9fa8d83e8
x-ms-traffictypediagnostic: DM6PR11MB4234:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4234A66DF0E6450C7081357AF1019@DM6PR11MB4234.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBJro7LOGGU3I0Ss2QhQYAAqLlIR6PQgptbAVyFPtBHAfsk0kycbZEN/B+dRFPTkBdh3JaQgRqKlz2NmB9Qk/KVxC9+tHh9fPHORTeVZwz4Av8ZA+rkL3k8C8LgCyxobSIbMOauKTBzA6hWPIqPFrVQm6KmNlrEIvjAhiKqnyaFRTlqc6YQYesD7/MDTn8CZrR4Jgt1kxKM4a0oxVyZLTCPhUGxO8BVT7FvNZ+m2Nt7nMwPD6M1dJmuVca+awtWSueEFQolVNnGhoSDb27BnSHezBGqpEDVsuLoBBE+cp2oJou4tl2iAq7Zy8pS5iT3E66rsYcCXpdr8mzaatKTX8xbwD3v0eQ+sAlKoqVvf3V+sB8y7VDrrtQ6I8TXqreFK/yjdbYQKGYYiOa/ZS4/iVFG1NjdjYm6B+7LzCEBkQIUZpoDADWsxdTKnoRxfCXfc8zy5v87mpydKxCa0MTsAkg+MM0q/Jk96gZq0E5xudpvsgvkoQVc5H25ePXM04yzH1qVICK7JC4XAGWlR8ZGWRCC7cb1LlJEjX7H5YcKqNFJups9ORWChRe9Vn4E4QPP/paIshVG7uUEXsKBkf8e08SnopCB+52osQ5BJkqHAnpPR7dIRhamr7wzZrySHWgGhp58Hauwzc+oe5jk4o2LrBGdHB4wymh4IJfRa22lNCfj0upK/ULk8JF/CYWCVzHSTW/9QgvFN26TfseT870+wwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(76116006)(55016003)(8936002)(4326008)(5660300002)(33656002)(66476007)(8676002)(66946007)(64756008)(66446008)(52536014)(316002)(2906002)(54906003)(110136005)(508600001)(7696005)(26005)(186003)(53546011)(6506007)(83380400001)(9686003)(86362001)(38100700002)(82960400001)(38070700005)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y1z78wou3ntnHVj29Sf17eWljYd6nB8s58W8bADSSoVT+T/JHY/dOaqthrAb?=
 =?us-ascii?Q?HwfjCYPJUCRO3CLBwUjTbxZqZZ0Q0C9jVjYth07dU0VwsNrz6ND14PaN6QNT?=
 =?us-ascii?Q?Udpw+sjsgd7Wm6r86+B4dexAc06s1L+VtVK5SOVcWLcnzRIVGSoL7+qr+RC0?=
 =?us-ascii?Q?cx2eR2yTWiVDx0a1OLSZ2gCzyBQNxsKPdfPigpvntXGB6h770h0EpEWC7qfc?=
 =?us-ascii?Q?LBEyZXClubJTw24ebqC19KtSwhfJdm9MC/ZcLjKnjVanpTvNPR808y7e8vNV?=
 =?us-ascii?Q?dVxwz4ylE8tZs5Wx1VZzvD7Oo6BSAoPaZT8pL04K/dF2bQxp6wmFYjuL6wHB?=
 =?us-ascii?Q?GhcxHrKJ1M+tLZIjyRq+kzIuTNTEatAiTaqDefGuP1iu7d8hpRSGX/w16hms?=
 =?us-ascii?Q?J5AuCWtVxIJ7j9iMNlyGXdKJ2cIcdy5GEP4cgy4Qz0tf5lbZiaSWT4+JZ+hk?=
 =?us-ascii?Q?Y63hjfgbdLY/dsD89wyHS2FcgM9zRTvsKjzaHetyD6dCN6S08BQ7VjcwaUwk?=
 =?us-ascii?Q?fHNGJqE9UKDw+Sn8dPmU/eCqAlPMw+mVemZAKKq3h7qtAx2Kb/drx1XyMZwZ?=
 =?us-ascii?Q?Pf5MB9bdDijvgbeqmxMzZ4EFJhQTZuz2WLn9o8dyDPKnS+lVB4VUEtRhc+CQ?=
 =?us-ascii?Q?0tADlTTrnpR+wfwEc1U4tYO11UFdAM64KscHckdEhabCwXk9YcvZMSQgcVN9?=
 =?us-ascii?Q?JEibUzQsu7c7Ro13/68Cj+Sxg6qiu5i/JIX5h0hubO8fWmhaUUEZ1vlDDwhT?=
 =?us-ascii?Q?pHkK7xZitRbRG+++up9hTZ53IwTrS6lC9wBmZWxo4csATIzv7hMIdclECYZs?=
 =?us-ascii?Q?Eb2+sDU2JLVVzzeciYTDxNt3ImX7Ca75lFsyyOtI3u13Q7lVdK5KgdWlN0jE?=
 =?us-ascii?Q?/KbFXII73iwwDpGR8qwvuwhaVjUMQLu7aHzEAMZdyEtlV0U+mfJS6JrBSje3?=
 =?us-ascii?Q?VBGEj64rwBpxtaE4a91dOayqbrJbqUfJZ2X6DGoPtcJXzD2M9/ftw70y8bfb?=
 =?us-ascii?Q?s0ErqoDOwSBH9Goz1gWaGTRRqqjmvJgyOATk+F15knNCR5AcA8fx1yE7iyu7?=
 =?us-ascii?Q?zM0alu6oNfDoAHCYk12CBLyWg8T7BFyUAWh2JcfhWDjPvEdxwcJ8OwRdmp21?=
 =?us-ascii?Q?BuNXpZdpGeBhL0Jj4ICXK10xtHpODvtlmJcCFdz+Sl/pvYB43E322SIZi8hL?=
 =?us-ascii?Q?EUfGsTum2D+WT18i06UKtkUnnyeSko+6eQYtoq0FLPUhqN/FVTw7Zl1kj1x0?=
 =?us-ascii?Q?afdKy1jI+1Atbw5qIfaTr0qDhmrZOFzytsQYCi2Gf3c6FWXVnQg7rCXqVwF8?=
 =?us-ascii?Q?Ho/S6Z9ykm8fZBm44VnLMcsvWEXrmRmK5gotn76I3h4juWsdLnbgoqvwW+JR?=
 =?us-ascii?Q?ULMadM73mpWv6QzGh/k97ljnjW8t8sccVq1oaDv5zU48+0fiWQQzgTb6VewL?=
 =?us-ascii?Q?AH6wbSc/2ABRWnkvl/EDOjQVUchIYSNvKyby2vXM2vrhHgG7K8Xq+xvYIZDb?=
 =?us-ascii?Q?FQ/FTL7ygy27wQHtFErUbzgWnOzsJbs96oSyCYCD74qz1RbhnsmuaGcWRnY4?=
 =?us-ascii?Q?qKlLnz4UB56y3L6oyHHfXTJMbQbSL4yAtTTk36KKP6Wr1RaAzGD/e7rfp/DP?=
 =?us-ascii?Q?ft4Izup1BfuG8WHsxOXJO+M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dafc03-d417-49e0-e7d6-08d9fa8d83e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 07:39:55.8954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mtLBEBY7la3VGeG01WUfoZNM5CVCJvCqG+lpBEQcYuHrkQ12byfb+yxA6SyoIcTIYGrGDSLKXCiVrhu4rDaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4234
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel and Thomas,

Could you please help review this patch?


Regards,
Shruthi

> -----Original Message-----
> From: Sanil, Shruthi <shruthi.sanil@intel.com>
> Sent: Tuesday, February 22, 2022 3:27 PM
> To: daniel.lezcano@linaro.org; tglx@linutronix.de; robh+dt@kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Cc: andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Thokala,
> Srikanth <srikanth.thokala@intel.com>; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Sanil, Shruthi
> <shruthi.sanil@intel.com>
> Subject: [PATCH v8 2/2] clocksource: Add Intel Keem Bay timer support
>=20
> From: Shruthi Sanil <shruthi.sanil@intel.com>
>=20
> The Intel Keem Bay timer driver supports clocksource and clockevent
> features for the timer IP used in Intel Keem Bay SoC.
> The timer block supports 1 free running counter and 8 timers.
> The free running counter can be used as a clocksource and the timers can =
be
> used as clockevent. Each timer is capable of generating individual interr=
upt.
> Both the features are enabled through the timer general config register.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
> ---
>  MAINTAINERS                         |   6 +
>  drivers/clocksource/Kconfig         |  11 ++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-keembay.c | 230
> ++++++++++++++++++++++++++++
>  4 files changed, 248 insertions(+)
>  create mode 100644 drivers/clocksource/timer-keembay.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 777cd6fa2b3d..73c0029dcdf7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9796,6 +9796,12 @@ F:	drivers/crypto/keembay/keembay-ocs-hcu-
> core.c
>  F:	drivers/crypto/keembay/ocs-hcu.c
>  F:	drivers/crypto/keembay/ocs-hcu.h
>=20
> +INTEL KEEM BAY TIMER DRIVER
> +M:	Shruthi Sanil <shruthi.sanil@intel.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/timer/intel,keembay-
> timer.yaml
> +F:	drivers/clocksource/timer-keembay.c
> +
>  INTEL THUNDER BAY EMMC PHY DRIVER
>  M:	Nandhini Srikandan <nandhini.srikandan@intel.com>
>  M:	Rashmi A <rashmi.a@intel.com>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig in=
dex
> cfb8ea0df3b1..65b6cf916e5a 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -721,4 +721,15 @@ config MICROCHIP_PIT64B
>  	  modes and high resolution. It is used as a clocksource
>  	  and a clockevent.
>=20
> +config KEEMBAY_TIMER
> +	bool "Intel Keem Bay timer"
> +	depends on ARCH_KEEMBAY || COMPILE_TEST
> +	select TIMER_OF
> +	help
> +	  This option enables the support for the Intel Keem Bay
> +	  general purpose timer and free running counter driver.
> +	  Each timer can generate an individual interrupt and
> +	  supports oneshot and periodic modes.
> +	  The 64-bit counter can be used as a clock source.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index fa5f624eadb6..dff6458ef9e5 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -89,3 +89,4 @@ obj-$(CONFIG_GX6605S_TIMER)		+=3D timer-
> gx6605s.o
>  obj-$(CONFIG_HYPERV_TIMER)		+=3D hyperv_timer.o
>  obj-$(CONFIG_MICROCHIP_PIT64B)		+=3D timer-microchip-pit64b.o
>  obj-$(CONFIG_MSC313E_TIMER)		+=3D timer-msc313e.o
> +obj-$(CONFIG_KEEMBAY_TIMER)		+=3D timer-keembay.o
> diff --git a/drivers/clocksource/timer-keembay.c
> b/drivers/clocksource/timer-keembay.c
> new file mode 100644
> index 000000000000..230609c06a26
> --- /dev/null
> +++ b/drivers/clocksource/timer-keembay.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Intel Keem Bay Timer driver
> + *
> + * Copyright (C) 2020 Intel Corporation  */
> +
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h> #include <linux/mfd/syscon.h>
> +#include <linux/module.h> #include <linux/of_address.h> #include
> +<linux/sizes.h> #include <linux/slab.h> #include <linux/regmap.h>
> +
> +#include "timer-of.h"
> +
> +/* Timer register offset */
> +#define TIM_CNT_VAL_OFFSET		0x0
> +#define TIM_RELOAD_VAL_OFFSET		0x4
> +#define TIM_CONFIG_OFFSET		0x8
> +
> +/* Bit fields of timer general config register */
> +#define TIM_CONFIG_PRESCALER_ENABLE	BIT(2)
> +#define TIM_CONFIG_COUNTER_ENABLE	BIT(0)
> +
> +/* Bit fields of timer config register */
> +#define TIM_CONFIG_INTERRUPT_PENDING	BIT(4)
> +#define TIM_CONFIG_INTERRUPT_ENABLE	BIT(2)
> +#define TIM_CONFIG_RESTART		BIT(1)
> +#define TIM_CONFIG_ENABLE		BIT(0)
> +
> +#define TIM_GEN_MASK			GENMASK(31, 12)
> +#define TIM_RATING			200
> +#define TIM_CLKSRC_MASK_BITS		64
> +
> +#define TIMER_NAME_SIZE			25
> +
> +static inline void keembay_timer_enable(void __iomem *base, u32 flags)
> +{
> +	writel(TIM_CONFIG_ENABLE | flags, base + TIM_CONFIG_OFFSET); }
> +
> +static inline void keembay_timer_disable(void __iomem *base) {
> +	writel(0x0, base + TIM_CONFIG_OFFSET); }
> +
> +static inline void keembay_timer_update_counter(void __iomem *base, u32
> +val) {
> +	writel(val, base + TIM_CNT_VAL_OFFSET);
> +	writel(val, base + TIM_RELOAD_VAL_OFFSET); }
> +
> +static inline void keembay_timer_clear_pending_int(void __iomem *base)
> +{
> +	u32 val;
> +
> +	val =3D readl(base + TIM_CONFIG_OFFSET);
> +	val &=3D ~TIM_CONFIG_INTERRUPT_PENDING;
> +	writel(val, base + TIM_CONFIG_OFFSET); }
> +
> +static int keembay_timer_set_next_event(unsigned long evt, struct
> +clock_event_device *ce) {
> +	u32 flags =3D TIM_CONFIG_INTERRUPT_ENABLE;
> +	struct timer_of *to =3D to_timer_of(ce);
> +	void __iomem *tim_base =3D timer_of_base(to);
> +
> +	keembay_timer_disable(tim_base);
> +	keembay_timer_update_counter(tim_base, evt);
> +	keembay_timer_enable(tim_base, flags);
> +
> +	return 0;
> +}
> +
> +static int keembay_timer_periodic(struct clock_event_device *ce) {
> +	u32 flags =3D TIM_CONFIG_INTERRUPT_ENABLE |
> TIM_CONFIG_RESTART;
> +	struct timer_of *to =3D to_timer_of(ce);
> +	void __iomem *tim_base =3D timer_of_base(to);
> +
> +	keembay_timer_disable(tim_base);
> +	keembay_timer_update_counter(tim_base, timer_of_period(to));
> +	keembay_timer_enable(tim_base, flags);
> +
> +	return 0;
> +}
> +
> +static int keembay_timer_shutdown(struct clock_event_device *ce) {
> +	struct timer_of *to =3D to_timer_of(ce);
> +
> +	keembay_timer_disable(timer_of_base(to));
> +
> +	return 0;
> +}
> +
> +static irqreturn_t keembay_timer_isr(int irq, void *dev_id) {
> +	struct clock_event_device *evt =3D dev_id;
> +	struct timer_of *to =3D to_timer_of(evt);
> +	void __iomem *tim_base =3D timer_of_base(to);
> +	u32 val;
> +
> +	val =3D readl(tim_base + TIM_CONFIG_OFFSET);
> +
> +	if (val & TIM_CONFIG_RESTART) {
> +		/* Clear interrupt for periodic timer*/
> +		keembay_timer_clear_pending_int(tim_base);
> +	} else {
> +		/* Disable the timer for one shot timer */
> +		keembay_timer_disable(tim_base);
> +	}
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init keembay_clockevent_init(struct device_node *np) {
> +	struct timer_of *keembay_ce_to;
> +	struct regmap *regmap;
> +	int ret;
> +	u32 val;
> +
> +	regmap =3D device_node_to_regmap(np->parent);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret =3D regmap_read(regmap, TIM_CONFIG_OFFSET, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Prescaler bit must be enabled for the timer to function */
> +	if (!(val & TIM_CONFIG_PRESCALER_ENABLE)) {
> +		pr_err("%pOF: Prescaler is not enabled\n", np);
> +		ret =3D -ENODEV;
> +	}
> +
> +	keembay_ce_to =3D kzalloc(sizeof(*keembay_ce_to), GFP_KERNEL);
> +	if (!keembay_ce_to)
> +		ret =3D -ENOMEM;
> +
> +	keembay_ce_to->flags =3D TIMER_OF_IRQ | TIMER_OF_BASE |
> TIMER_OF_CLOCK;
> +	keembay_ce_to->clkevt.name =3D "keembay_timer";
> +	keembay_ce_to->clkevt.cpumask =3D cpu_possible_mask;
> +	keembay_ce_to->clkevt.features =3D CLOCK_EVT_FEAT_PERIODIC |
> +					 CLOCK_EVT_FEAT_ONESHOT  |
> +					 CLOCK_EVT_FEAT_DYNIRQ;
> +	keembay_ce_to->clkevt.rating =3D TIM_RATING;
> +	keembay_ce_to->clkevt.set_next_event =3D
> keembay_timer_set_next_event;
> +	keembay_ce_to->clkevt.set_state_periodic =3D
> keembay_timer_periodic;
> +	keembay_ce_to->clkevt.set_state_shutdown =3D
> keembay_timer_shutdown;
> +	keembay_ce_to->of_irq.handler =3D keembay_timer_isr;
> +	keembay_ce_to->of_irq.flags =3D IRQF_TIMER;
> +
> +	ret =3D timer_of_init(np, keembay_ce_to);
> +	if (ret)
> +		goto err_keembay_ce_to_free;
> +
> +	ret =3D regmap_read(regmap, TIM_RELOAD_VAL_OFFSET, &val);
> +	if (ret)
> +		goto err_keembay_ce_to_free;
> +
> +	keembay_ce_to->of_clk.rate =3D keembay_ce_to->of_clk.rate / (val +
> 1);
> +
> +	clockevents_config_and_register(&keembay_ce_to->clkevt,
> +					timer_of_rate(keembay_ce_to),
> +					1,
> +					U32_MAX);
> +
> +	return 0;
> +
> +err_keembay_ce_to_free:
> +	kfree(keembay_ce_to);
> +
> +	return ret;
> +}
> +
> +static struct timer_of keembay_cs_to =3D {
> +	.flags	=3D TIMER_OF_BASE | TIMER_OF_CLOCK,
> +};
> +
> +static u64 notrace keembay_clocksource_read(struct clocksource *cs) {
> +	return lo_hi_readq(timer_of_base(&keembay_cs_to));
> +}
> +
> +static struct clocksource keembay_counter =3D {
> +	.name	=3D "keembay_sys_counter",
> +	.rating	=3D TIM_RATING,
> +	.read	=3D keembay_clocksource_read,
> +	.mask	=3D CLOCKSOURCE_MASK(TIM_CLKSRC_MASK_BITS),
> +	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS |
> +		  CLOCK_SOURCE_SUSPEND_NONSTOP,
> +};
> +
> +static int __init keembay_clocksource_init(struct device_node *np) {
> +	struct regmap *regmap;
> +	u32 val;
> +	int ret;
> +
> +	regmap =3D device_node_to_regmap(np->parent);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret =3D regmap_read(regmap, TIM_CONFIG_OFFSET, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Free Running Counter bit must be enabled for counter to function
> */
> +	if (!(val & TIM_CONFIG_COUNTER_ENABLE)) {
> +		pr_err("%pOF: free running counter is not enabled\n", np);
> +		return -ENODEV;
> +	}
> +
> +	ret =3D timer_of_init(np, &keembay_cs_to);
> +	if (ret)
> +		return ret;
> +
> +	return clocksource_register_hz(&keembay_counter,
> +timer_of_rate(&keembay_cs_to)); }
> +
> +TIMER_OF_DECLARE(keembay_clockevent, "intel,keembay-timer",
> +keembay_clockevent_init); TIMER_OF_DECLARE(keembay_clocksource,
> +"intel,keembay-counter", keembay_clocksource_init);
> --
> 2.17.1

