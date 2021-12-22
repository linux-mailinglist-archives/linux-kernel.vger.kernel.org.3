Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED2F47D329
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245484AbhLVNri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:47:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:34360 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234159AbhLVNrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640180856; x=1671716856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JDcvPpMHD7Z90DPSEt8lLyalkyN/R6fxTogzdgZZG5g=;
  b=DO5h4d9mrff7xpF9XQLjknJO/1jrpbvILrHjf/Sqlm6snQunqlSDC1z2
   l0OzBxWMoHobtQI61sny0QYRZuk9z3dkT3luoqwbTqjCx3z4tTEn4qMnC
   Iofv2VotMC7tdsHzNtyRuvn7rvrL558kmHP+hFwGQfAeqT6StwjQh8+bW
   aOjymSNRSFLp7sMyXIYziu786NEY5MkMSrTGbMT3VIHTw9MndTQdz3hS/
   xlWJGtVs/DJDCsGDo5Si3rBeq0Lt+EM3JD++sR9zvFm6VUtq+HZVoib/B
   XjxhXaOkYyuU92TuaRWnTbcrnqDo//X72efLsfi8DOLMqsLAIJTaKMA3G
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="303989870"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="303989870"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 05:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="484759470"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2021 05:47:26 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 05:47:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 22 Dec 2021 05:47:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 22 Dec 2021 05:47:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK3ZcEm7LmTBBnX7oJoJH5Sh4Qk8mqx6DK/nfbOmVywW2YEE9uUVertvX5kgFis2AirE5rN7hzikWRHq5ZlRYH8kXJFCWovS4yqgunojz0wxlM0Ld+nL7KqHEubjwY2DH30LrtKQEjnAtP/5Hcupzbl5HKJlyvb/TcC3bOdGFJtWwNDv7vGOjzLw07uXSZKX+i7QV4qFxnwmQWtWV92yyv0hhangUQON1gRnN2w89m5Q212XQCLzX6f4pwMbqdeFlx46Kcx1EayCjaPEZ76tpjDsyLZHzaBS8aY93WKTSFIzZgA0hwDg7hbnYxJkGESDQT5ufA/Qf5OVEd3KeIgTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iCMpxE/1fEmprIaSZ67PPqYfFHVdDbR1y1104Cj1tw=;
 b=TalZRCR5VzodGtkFMz3yrqkAbz1pcx4Cx/w5DHNoQFsG+9TckCiMWIbybMJ7ndCGfNTsxMVKTJ/TyWqz3SgNsLmLnBmP+5Pi0oWts5ufBmujSI7mg/RjeeVoXnV3wCLSy8fXp5puvN1M3Lzl+OIt9e9+H/JXFVqZj/S97F5bq6zD44doNijJZOiHwfAHt+YTDkqXqXz1TeJThCOXPRqQ231ZnAFEvUKQERW9SegsxivclS3l+gUamJYeRf10d9KKPk1cqckV5889thRpYAibkLVfhW5RsFHKYqABdq7V9s2iJp0+ukO/M5TMZ9Kuj7URB3L2keKoBtx/BXaBfiqxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 DM6PR11MB3147.namprd11.prod.outlook.com (2603:10b6:5:64::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.20; Wed, 22 Dec 2021 13:47:24 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6027:515f:a09c:d07d]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6027:515f:a09c:d07d%6]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 13:47:24 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>
Subject: RE: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use
 set_stream() instead of set_tdm_slots() for HDAudio
Thread-Topic: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use
 set_stream() instead of set_tdm_slots() for HDAudio
Thread-Index: AQHX7+TUNxNBikWSOkKXs12WJCCSSaw9S/WAgAFGsvA=
Date:   Wed, 22 Dec 2021 13:47:24 +0000
Message-ID: <DM6PR11MB40741309EE8E5A7977210EC5FF7D9@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <YcIYT57YLpHR1+9A@sirena.org.uk>
In-Reply-To: <YcIYT57YLpHR1+9A@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcc798fa-812d-4790-19d5-08d9c55195d6
x-ms-traffictypediagnostic: DM6PR11MB3147:EE_
x-microsoft-antispam-prvs: <DM6PR11MB314738E02892D25C0AD3EDAFFF7D9@DM6PR11MB3147.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BAJFctu66cm5Jx04RoF3jorNbvAvZraoMVLpy83eBjRu+WJ2O/TskK5iPANBgOVcWqDfEa/PfzyhHlCmXIOAkI12WXBFpPqp6hFYDXZdzocy4cY30VNQTS6BonVhJAm54R6d8bRHMpQngJcNsqIMOOt1QKapDpIIjYKVP3Y6h6KV2plZL/EfMIw48d7Nwyf0xqgL/A92tlLCt9NKVZ16QPw1SonkEn+VF2sgPZuQk51tjtzQaufQ11e1BrcO8dUURID9ON5CjhXlHWUUVeskMWZgx1liFHDJVfp3F5rGFBOUAd0aDhcKmX8MTDIxDTOxbz7f9kQsT9j9/6z8k4dkzdAmnd8Ds5BBLXlDw8nGLr51a2pAHBDh8TC7cTdvus+yozOTMekCOWT8BmHG2po/SG5QL26wzQemxS7BlYZotdkaucy+QaMypY78c6FAL/IGH7ZbOz6z7hK81+BW8Its8xakzt5BRTP/JD1aBkKcdRjEhYMkq9BJx6sIF0pe3h78+hIOqu8l6e/7OVSFlumrDsWyOPXvFUXjH84kb+5c8iaIgUfJj1Wv1S8LIEhsichhcEu0yxVdnfmXi/K3tteLy25LAsHZXZsCfbMwbFbK+02h21SWNUN0ZFnQZHMQerkbzY8aDzAEXeCZ0uE3yZU0L2exR8CVKlX2s11TqyJQMJg1Tvs0vh+mKND9IE+MZeTVtzNSibGBUFy0VlnsJwsfkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(8936002)(8676002)(7696005)(71200400001)(110136005)(9686003)(66556008)(66946007)(64756008)(53546011)(6506007)(55016003)(52536014)(38100700002)(66446008)(2906002)(122000001)(86362001)(4744005)(508600001)(7416002)(38070700005)(76116006)(26005)(54906003)(33656002)(4326008)(5660300002)(15650500001)(66476007)(316002)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?paH5WGYbL1HtQQCh4hFayR9MZVEGCEEZgVJ6zKewxpKR+kuyKGhR8Ngaxb5r?=
 =?us-ascii?Q?Q9O8I6AB0OYUr6TdePDv2Yzv7Pf3jvLC+/y300d6pZXQ6qQVKxFvdag8RMkb?=
 =?us-ascii?Q?NqMjT65vYNKFXDizPjlHUNQICqCY5jjhcV4t5hKQwQzM/1jZfcK+q6f4blz5?=
 =?us-ascii?Q?h2+WE93gw/JtGowaovZwZtVmcqH4kFhAVbr1SbVqLFCR0g40KXYP8FZILYxg?=
 =?us-ascii?Q?A8WFcsnNKJWOuZ6PEMC5nqHXvFknBvW6INJXaSdhMF++sgAtPU2qrwVojXv4?=
 =?us-ascii?Q?rscuceoNevcgPALfHLcQ9gCSS/KohwZ01AWZsrSRT0Kb1bBmXwkb0iuAN1s6?=
 =?us-ascii?Q?DaZaVblvmqpU8xTtK61efKdhtJrhtOfpjk7ItHsrDWkqaPiteF1NuAcDLGH+?=
 =?us-ascii?Q?kkKvhHrsW1aX0pG5MCdmWhvylLAM4e1W+Fc20sxW6tdqzX1E5hjteXGMrdWC?=
 =?us-ascii?Q?3ugFUumJuRZbh8mCM6o3mOBBMUaPTWYRQMlRFgnIy95S3F6wuO0L2PT0QOFG?=
 =?us-ascii?Q?heX4xScIklhDMhQ5LtKSDz3rv4+1zHn/R/tOYigKEGt7kFx0Le/HNgqwGy7h?=
 =?us-ascii?Q?Pmj0ilFlE4R+jEC8HSaiyNJcv8W2vaiuxVK0sZYAI1TMVqINNbg+i3GniRAc?=
 =?us-ascii?Q?FjQ1rhQNofFRHSH32Vhe6KVf2xvTO5+BAi7NuCBPIB4Tq9lNitPO/7hJbzuB?=
 =?us-ascii?Q?rhYMhwAZgVTwCy0ZN1oJ8yuq+HphgL72Y510p6IzEQvXsr0zKiwpiOo8gCmr?=
 =?us-ascii?Q?nlHUlIXOtM0aBrm/holb1uY4lKIs2RXmZ5b/rk05W1Qo2e7ti/rGJYjKWzkm?=
 =?us-ascii?Q?qs/CKJrxnVRmDlVg9G0c3icaRi+FZ10RWeVh8WNlWS9L4r0m816Jpf2hxPyU?=
 =?us-ascii?Q?7u7V9t0enmT9owvY2kSx/qjnQTxym8T6ZdzEByph6tLvi5IKWUt4UnPo/P7g?=
 =?us-ascii?Q?DV7Ws2dV0hongpwuU9HM5gGNdkH3laLRIwkrQXCw1drtx3g++K2vTAzLLQBg?=
 =?us-ascii?Q?PY6m0dQ8jJlp9lQ4+aat4TyXd3z3BPUisbOdb43fWcmWp09YskNxOjfdkbHK?=
 =?us-ascii?Q?kbCOdrG9Rgg5QKYTRHW3IF1RNXj5E5j4CDvDG37hA0+s2IbiUv5PLNGbH1R8?=
 =?us-ascii?Q?mwL41VVLH5UfZop6P+9k7WajYRUc89YSiKB6XiozhI/abXUjz/3Evgco2145?=
 =?us-ascii?Q?IQLTOJH9izwuWoNmOMK9R/YX1wl5xsvN6UpACWWKwJ7TCludFr02cjcxl5iN?=
 =?us-ascii?Q?tneeHQZ6UxMhXsjN2bgYqRSlflPz6QDa0NDbEwujehDBsXO7GoUaWNosCFDo?=
 =?us-ascii?Q?3fXCrGmlq6yWHicNRswB3exC6ZfeRnzRIj0b7rUyIbvv0osSxjw3YyB3qzpo?=
 =?us-ascii?Q?rX/usKBxDWqtUwyGn5O80NhL/LBNhB/HLqjaCYtPfPRStTkK7f9QAVze8Vct?=
 =?us-ascii?Q?wX81AjcHKvpK0PfMqSAAvsbAnYn1QmlpYroltzt2L9uogvfzLHVekj55GcMy?=
 =?us-ascii?Q?bcQfJqnZvHTvUfHbmT9mud5APspvw/7NA7A98YW2JTqnZbBGbbF9UEGOytoy?=
 =?us-ascii?Q?V8dPj22ONzDAypmHUI0lTcLMDN58FT77n37HNqsOG7q5y29EMfkCp3Ol5m2f?=
 =?us-ascii?Q?yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc798fa-812d-4790-19d5-08d9c55195d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 13:47:24.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRlME3g+3+LgNjfUvMYa1JLCaed7/e051kDa/fRptec53lqq19e7ZdQLZfqbKsXMfZYjmFiu0DKLLi67IP+wcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3147
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, December 22, 2021 2:09 AM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; vkoul@kernel.org; vinod.koul@linaro.org;
> linux-kernel@vger.kernel.org; tiwai@suse.de; gregkh@linuxfoundation.org;
> srinivas.kandagatla@linaro.org; pierre-louis.bossart@linux.intel.com; Kal=
e,
> Sanyog R <sanyog.r.kale@intel.com>; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use
> set_stream() instead of set_tdm_slots() for HDAudio
>=20
> On Mon, Dec 13, 2021 at 01:46:27PM +0800, Bard Liao wrote:
>=20
> > The topics are independent but the changes are dependent. So please
> > allow me to send them in one series.
>=20
> What's the plan for getting these merged?  Looks like they're mainly
> ASoC changes?

Yes, maybe Vinod can ack and these patches can go through ASoC tree.
