Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2941747EA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350856AbhLXBiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:38:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:61855 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350805AbhLXBiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640309931; x=1671845931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vo5q2DR5PcWZcF1TN5I8oIHDRohWNWnqQEPHrsDD0eI=;
  b=l5EY9vEOxm37FrUHYOKR9+jfA4ZnnJC4DULXi/lyPpnQx0+8I4UY3NkG
   wP5SznpUfXiDil9Kb0kE+O/GJpSlGKARRufOL8Y9Kk3ccRYgXGYpOW1dO
   PXQxLtOZODwSMXgRkqmLGGykp5+PuD9xluIkml9vFEKmA471Yq8Ld2Tus
   YPIQGJm2k3wYDSSylOK8xLjhLVld4ilg1iZKOM6d6Q97rwRD0M+zLnGq+
   51MpGmeRvJ0yj6NXvwHe/Q0j4jLTe6hJTNkvyZLKQhisGiOrQNlYO6/MT
   N/uFKlo44RhG0ovz0MIQ3hio09Rm6cbG+zBFu1yFfcM8UOlvW5xJcVf4V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="221584690"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="221584690"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 17:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; 
   d="scan'208";a="759379296"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 23 Dec 2021 17:38:50 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 17:38:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 23 Dec 2021 17:38:49 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 23 Dec 2021 17:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4xZVkTK1HNBPXbTAnjX70RXi8wpSr4Hi0/AID8ncLJ9Ip11FMbl/zawUiCAaWOgsb6FS2esqomY6LXXSosg86vpnK5bkL/6Z1NHpl8fByroHW5ITluzU3lks9jN9nYEQ6q8FBUAFrA3dJ2Leb3g2sNNpY+wfawTTBmBSIum5EL1nwCp01R3ShcQLChHmh/bOzgRRD3Bs23NsAD0ZnadGTN39BEwPHEWYOuuqLIj1o5tXGd2m9GT99lzf+MIYkWPb+YSuTH0fr+5wo1fjG/aJg+VBMbxQ6pK/Hy+FZ8EUzBgpjJEXolk3JTmwbN/g51CcmCCVZSOhQp1EI4aIdndMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sH+k7OPNl4KuVgqSxMfYZM6cVT+uMfR51Bw2pPFtlg=;
 b=egbaoC3jM6lI9MhHCqCK/31OphkMl5Gz/FCU17IrPhX+xE6U44iYWysMwlXDqGm3tySEYpfbfDv14KTw+czaBXKFrpw/yM5eUIhme96t2R9w5g+57somFzWvn42Fc7ClTw8F1lQYd7Ev9XLMGXRc2IWHWProiCeVEbN9MG+hPgtQCbtotDAsgROalCd4gWg17IE9Wj3RfGRd1K8il3IE1L7nIsKyT+b4Plwcu7RZy1AOgSrrD5dlvdHsoqNbKWIaogyseqHqgLfUbCkUSows8PbIl1smOI/OVg+lW1hoyqOkNIjshzsksBAIsYAtqHUHgcZv5n7mUTPLOMTFXRD29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 DM6PR11MB2985.namprd11.prod.outlook.com (2603:10b6:5:66::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Fri, 24 Dec 2021 01:38:48 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6027:515f:a09c:d07d]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6027:515f:a09c:d07d%6]) with mapi id 15.20.4823.019; Fri, 24 Dec 2021
 01:38:48 +0000
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
Subject: RE: [PATCH 7/7] soundwire: intel: remove PDM support
Thread-Topic: [PATCH 7/7] soundwire: intel: remove PDM support
Thread-Index: AQHX7+TlYkewtyPq/kiicjsWCVwmBqxAdYoAgABo9uA=
Date:   Fri, 24 Dec 2021 01:38:48 +0000
Message-ID: <DM6PR11MB40746A38CF42DC4DA6C21AC6FF7F9@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <20211213054634.30088-8-yung-chuan.liao@linux.intel.com>
 <YcS/cPb0UXsc9SWm@sirena.org.uk>
In-Reply-To: <YcS/cPb0UXsc9SWm@sirena.org.uk>
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
x-ms-office365-filtering-correlation-id: a651a0a9-2af6-4426-5cc3-08d9c67e21e3
x-ms-traffictypediagnostic: DM6PR11MB2985:EE_
x-microsoft-antispam-prvs: <DM6PR11MB29853C00E0E6E2534BE42DF6FF7F9@DM6PR11MB2985.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0cWs/boHSjCXSTlb2f9RA1KJkzN68BfbIoSzGKPUDLtDG1tzWJx4MjGFC3urhDAJqmmXLtZV1rGc8gdl+qhAgy5CTktxlDoaahFHaHxVQ5yJ+sQFc5NuDQaziF4DVIcTH29aoshktLJr7xEmXuu5SSaf9MLFLtK7ypzyKW1iUHluyv7AHQiSGGJvmFPaF0cQgyuImPnhj+Fzkd9SGT7xN4kfAlHchBRA1kHY9QpYppXLQuE9dJfRdSU+txdpCHSmFUzOhSoKcCpsFcUMOiHs3xkSOACOsVDa/877ZxQqpNFnEyzC8B3t6LgeZuVj5NXx88vOhCX4U9hNVlb4E4+nXRLlNQkKyc4B/VN353u3I3ABDE7wkXGI23qgZ3Pi/wkHGaXNCmuKoBGj/IxYh4RKyQ0Pp1vGB8QCM8ZEmFtUqVs4WJNqPGAGBVUM3DXRO6kytPX5nTeETr1C7YGtBTga0UZ24LoQLHLIz4BAl7v9JPCkBQIJT5kF07JRe8IBWqJBRzmf6cAcd7Tps1XhgOV6PpLL6rx1IUNDJjfr8DSwvNi+shk5adR2SbDDOUJdTnPAelR0C8iUsEXFji+5KBiM0MHgpwOIWpv1zahK/OjThMHJG+1u85uT9bwyP6T/GEmnV+Y+ydPxMqBONAEzumAPekHC5JYu8HnOXflF1+UiXgCFsbsHcyGcz81yqF77b+4c3qHAP2ry3empeUQloAG1yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(7696005)(9686003)(8676002)(8936002)(186003)(122000001)(6506007)(66556008)(53546011)(26005)(33656002)(38100700002)(2906002)(52536014)(54906003)(7416002)(86362001)(82960400001)(76116006)(66476007)(66946007)(5660300002)(66446008)(110136005)(508600001)(83380400001)(71200400001)(55016003)(316002)(64756008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jzdajY9wLdtoG/+05h2X97Ee9Mf6MmH0G41S+R9Xd0+WGjwL2CNwsX27th1u?=
 =?us-ascii?Q?1LFBqIlEvNLNWVH2IEcBH2ambaTCncXpl1wGtPsM4DfAHmAwTukXxd+KehkY?=
 =?us-ascii?Q?MhXm/Uiw6EwgH7jUut1KatpneOwb2+U30APfFppo7m2vKHguoWZl/WDJSpUP?=
 =?us-ascii?Q?65bRXLjIraW0VCkISc+5CZgQpJrTVNSFFRpdgdECWV+Lt4w57SN00n6JBlfJ?=
 =?us-ascii?Q?v5lC+bhBHO1D/WAVDKRQdb8qA13Gom0aenOkdXNqO9doVc4NQs0sljJWW5p2?=
 =?us-ascii?Q?KPTpo6+EuaMTE9md16TvE1hiJOLPCo9n/2CNPKQHdI17pni4yqyySnPA3pO7?=
 =?us-ascii?Q?9azG2gLmgluhYVwHY76PSgk4Gv1uL2I5okj1OS/MpiI9rTpjJlBjKaPfQKVp?=
 =?us-ascii?Q?8MnG8lg7GUYHvYkvYhPLHUU3XMTqD4vubhxGnqPGYjGPvOVeqCFU+1OVgKb0?=
 =?us-ascii?Q?A6ZVBcBv1N5t0PSmG5XTFmdsudUHru+zzrKfddi9LqWpI9Lv/xByEBRlV9PP?=
 =?us-ascii?Q?hT4u8hP5QdyevYQhgf80qpbooL5LHgqgNNGSrxJnynvrIs0FvCyzv3wTYx0Z?=
 =?us-ascii?Q?KeCDxcGybRsa9FfnFQQuAloH3VAo80Fwu2W02FlgMq5hVqbL9KG3GySumJ3U?=
 =?us-ascii?Q?2QsQrljjcPPXu8u0SELivkGBkunjv+SgbZAhvT/l5u9evRYX8akuKgZpEHTj?=
 =?us-ascii?Q?El9wxpV96dkUPiA4PvEo9PHcv6J+a4hDvgsQi9F5IsVgdfKSji42X/0hhpVV?=
 =?us-ascii?Q?A+zDXweGfSnsdLpoJbxI87Khm2QAuNn42t0wKLleJG5nbqrFHJjVxnsgkoSU?=
 =?us-ascii?Q?DsznpFeqdBOiZGmbM9C43fB0yIfRbCBHjbeeIEOPiXWYeOfm4EhsQNABcpgJ?=
 =?us-ascii?Q?o9ejLOakcrBy8dZmOJAWMV7jMoNYvClCQ7AYJUMEtH6AwDRSY8oSJHTFzZEb?=
 =?us-ascii?Q?0eXcfpoIpugsveOsaGt6jssNXx0kW/lONZLvN+uRwr9SVMZDI2TCE6PzgaVo?=
 =?us-ascii?Q?E3ExoP6VelwLavBDs4JcptpMuOPzegBorLebxad5KP7kpA9IKOHPuMgyTe0i?=
 =?us-ascii?Q?IKVz4GSYsk1pEmKkCfvLXkyTfcOw60aRDdd+tUmPs+rGJNH8EcR41/PpFwaE?=
 =?us-ascii?Q?xa1XZc04zGatD19UpP2bWbR1rw43DvORIbkbLqYwZbF/zej0E+TLzRruJf6T?=
 =?us-ascii?Q?SaAtihwI9DJY9rm9GlwSdNZEwLQCKgMbXAf3ttIUW70GJHbAWDf0qkMyDdTK?=
 =?us-ascii?Q?8rQxpVslOBY9Cya8cbYb4zui44zdKny/k7s5Uuv0jwtJkGQ9W+zRvSt4KlX5?=
 =?us-ascii?Q?mn8XkpOjIBgJi59TIfyQT4Skh+C8MRU925NLGkOLOJfoMBQwMIddoI3GwvcL?=
 =?us-ascii?Q?dwx1wInjGtiE/K5uJN4y8fx9AJ4+Lpr83YmC7F5CgbXgc03piggzCdcb+N6L?=
 =?us-ascii?Q?XMr6EtsvM5VlW6BihGzlH4KFTIEXqOpXHs554F/AF/eUhYICr6sByupYtBCW?=
 =?us-ascii?Q?lijcakN5vBwjMk4KClI01qXQjtNd4LtaiYCfBmmrhbj/bSYoaHI1qyA9on4x?=
 =?us-ascii?Q?iq6Sh4fwSrJz+LEYkqLqAKu2bfovlP0xdtC6fbv32AViVq1n2bGI6dKh2Kcd?=
 =?us-ascii?Q?7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a651a0a9-2af6-4426-5cc3-08d9c67e21e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 01:38:48.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISL17VMKyhYRfvX2jOvhOSRlXoJttYwd02Iq9adBwXXd4bYEJ1WsS6pwONr/tzp/1izC6+blPaq/70GkJmCaQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2985
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, December 24, 2021 2:27 AM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; vkoul@kernel.org; vinod.koul@linaro.org;
> linux-kernel@vger.kernel.org; tiwai@suse.de; gregkh@linuxfoundation.org;
> srinivas.kandagatla@linaro.org; pierre-louis.bossart@linux.intel.com; Kal=
e,
> Sanyog R <sanyog.r.kale@intel.com>; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH 7/7] soundwire: intel: remove PDM support
>=20
> On Mon, Dec 13, 2021 at 01:46:34PM +0800, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >
> > While the hardware supports PDM streams, this capability has never
> > been tested or enabled on any product, so this is dead-code. Let's
> > remove all this.
>=20
> This doesn't build with current code, I'm guessing due to a Soundwire
> dependency I don't have:

Hi Mark,

Sorry, it is my fault.  "[PATCH 7/7] soundwire: intel: remove PDM support"
was before "[PATCH 4/7] ASoC/SoundWire: dai: expand 'stream' concept
beyond". So there was no "intel_pdm_dai_ops" stuff in the "ASoC/SoundWire:=
=20
dai: expand 'stream' concept beyond" patch.
But when I re-order the patches order, the intel_pdm_dai_ops stuff was
still in the "ASoC/SoundWire:  dai: expand 'stream' concept beyond" patch
and I forgot rename set_sdw_stream and get_sdw_stream ops in
intel_pdm_dai_ops.
I will send v2 to fix it. Sorry about it.

>=20
> /mnt/kernel/drivers/soundwire/intel.c:1142:3: error: 'const struct
> snd_soc_dai_ops' has no member named 'set_sdw_stream'; did you mean
> 'set_stream'?
>  1142 |  .set_sdw_stream =3D intel_pdm_set_sdw_stream,
>       |   ^~~~~~~~~~~~~~
>       |   set_stream
> /mnt/kernel/drivers/soundwire/intel.c:1142:20: error: initialization of '=
int
> (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *, struct
> snd_soc_dai *)' from incompatible pointer type 'int (*)(struct snd_soc_da=
i *,
> void *, int)' [-Werror=3Dincompatible-pointer-types]
>  1142 |  .set_sdw_stream =3D intel_pdm_set_sdw_stream,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~
> /mnt/kernel/drivers/soundwire/intel.c:1142:20: note: (near initialization=
 for
> 'intel_pdm_dai_ops.hw_params')
> /mnt/kernel/drivers/soundwire/intel.c:1143:3: error: 'const struct
> snd_soc_dai_ops' has no member named 'get_sdw_stream'; did you mean
> 'get_stream'?
>  1143 |  .get_sdw_stream =3D intel_get_sdw_stream,
>       |   ^~~~~~~~~~~~~~
>       |   get_stream
> /mnt/kernel/drivers/soundwire/intel.c:1143:20: error: initialization of '=
int
> (*)(struct snd_pcm_substream *, struct snd_soc_dai *)' from incompatible
> pointer type 'void * (*)(struct snd_soc_dai *, int)' [-Werror=3Dincompati=
ble-
> pointer-types]
>  1143 |  .get_sdw_stream =3D intel_get_sdw_stream,
>       |                    ^~~~~~~~~~~~~~~~~~~~
> /mnt/kernel/drivers/soundwire/intel.c:1143:20: note: (near initialization=
 for
> 'intel_pdm_dai_ops.hw_free')
> cc1: all warnings being treated as errors
> make[3]: *** [/mnt/kernel/scripts/Makefile.build:287:
> drivers/soundwire/intel.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [/mnt/kernel/scripts/Makefile.build:549: drivers/soundwire]
> Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/Makefile:1846: drivers] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:219: __sub-make] Error 2
