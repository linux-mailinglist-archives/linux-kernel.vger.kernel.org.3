Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849F947DFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbhLWHqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:46:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:65171 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347037AbhLWHqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640245599; x=1671781599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U7FH2pteoxshD9v6lNlW7EettmVWUYHUs69AuCQ9mk0=;
  b=ngpwU/BopocEuL7aZJla5To0DNRvDYj+2mAbQoMTjYvhQXsRtJkSG7Su
   3eYVRAtvHZZvwJsVSgi4mQZowmzy7fxwvjCTLifnyEnY5Soau5uyrlnIQ
   28+QGNhSb5d2Y58l3DUMCM241C6SrJuRHhcvZTjbNZwayTi3yaz3P08ib
   OftIGgQx51emc1LaZPQDm7PbROMS7fwPG8PtbTfvLPtJc2ewJh7rquzGv
   LS6V4zRoMPRMyvAisvuZVDX82e6MSyUws7yCcAdPJExd6g3LU5NsOKTvG
   8BFp/PPy3QQobl/nBRNcXeZ70YSTtboJ/MyBp6Kso26DK7AGLKbRQ0Qle
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="239530832"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="239530832"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 23:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="570836605"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 22 Dec 2021 23:46:38 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 23:46:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 22 Dec 2021 23:46:38 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 22 Dec 2021 23:46:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3eGHNz9OuD9nF8oTiFcmrdf4s3zl/IkRUt+Pjoh2KblKxT6Yd8WMpPobynmnCBORIi53YiCRqdTEPXuaYM2xqX/z6Gw0Y96o8GgWd2s4Fui6ZOMkBpvDV0DLVySvphe4Ff4Tm0efhoSjDaVVti819ovNYBTF+gABqRLLXd2yVLk/+pkGZj4bGT4ikZMPaXAOrAVuu7vonUJJRUnq6z1DElsOZ6rLgVfEs9ydmARlUUewsKHlT0dXE46FYJ1t1acjrLsKDKeM2GKblHBPnVy3qGyNTn0He+kStZtvIaWOjiBbECS2PKX3ADIzvI0ZuQvVFtx018lELzBbsNlyGONfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/VK2zXHaFCqDRL7uxtFUNLqmrJrphZrqihOL0i4jec=;
 b=eZbgf18mvI5r4zvC71FRc33zojkOYkLLlgrOGDDhrzm8JjlZPlLrTA8cM4+D6HYokIMeVx/wQOPcEusIjJkVlWWUTAhitkvZxPwhO4SoQdRoxRbICjVIVo4T5WNg2vdi4KHroLRTEKNFEJ1eAm6sm/n1tMQUWfo1xuFpOnOk+E2HyxAl9cyRD7OQZbSof+9bBzuUAQGR3/8EooL9cP8UJ6vb60RdhDaNHe+0W+PcoQNBFKKJMVO0VANHxDGH7BYRVEd2PDXaa9k19XEPfUS/9owJhN6LCqVsmaSQQB9ArCN0xgvEDMsaNNIAU2AZTRqbTbamhkQ9PCIzHbdkztPCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (10.255.61.139) by
 DM6PR11MB2858.namprd11.prod.outlook.com (20.176.94.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Thu, 23 Dec 2021 07:46:36 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6027:515f:a09c:d07d]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::6027:515f:a09c:d07d%6]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 07:46:36 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>
Subject: RE: [PATCH 7/7] soundwire: intel: remove PDM support
Thread-Topic: [PATCH 7/7] soundwire: intel: remove PDM support
Thread-Index: AQHX7+TlYkewtyPq/kiicjsWCVwmBqw/tWkAgAALUhA=
Date:   Thu, 23 Dec 2021 07:46:36 +0000
Message-ID: <DM6PR11MB4074FEE19010B83F0CDDE8A9FF7E9@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <20211213054634.30088-8-yung-chuan.liao@linux.intel.com>
 <YcQeRJ060/u4n6fR@matsya>
In-Reply-To: <YcQeRJ060/u4n6fR@matsya>
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
x-ms-office365-filtering-correlation-id: d93254fd-e166-4293-16e5-08d9c5e85925
x-ms-traffictypediagnostic: DM6PR11MB2858:EE_
x-microsoft-antispam-prvs: <DM6PR11MB2858525C247D17E43670750EFF7E9@DM6PR11MB2858.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3OkedeWEZeCaVClIxpFwOX1jry8OW1xxX5aIS/9vX8bIlgkFG9pZ6CkqHVKbyurRtLQzLevjqqqCO4YfZMoZFTAgx0wu+zY7Qh9hT0X0dLjprS05A/L/vviNshdFgc6GgHB+4EAkp1Hq62NWqHuHXV+3hkkUEf379zMx0twb11QyYfvdypruBN/SUBvvzz4BAyH2eRQkQr4wSGSATCn3DbqnlbE530+53wO3FRfB0s7AX5gUSsx6x/p/Jd5oKEAiw7GppHTr7OO7hiyL3ymJ6IGVq8rFN8gdjqaBw9NHG5EzmxziPhtSlR1TbhrNLrM/6OyJ5UmU6+9TPWcONPh9pBBooFxx1KzDWD2F+EgVKW9nh1o/z1yt8ABYsbAlj6WPTZSQ1KSqMqZTndQomkh9yMyvMQ7V/bBnPxtjYsOv+kAuFuNTsEK9jFeepwPOYiS9QG4Dpqyzt71ty8muKw2l2c1RJACiG6p1ct1TGElhoolbk7Tprss0bcOpnJRo6KYGrAS3YMyfnd/bEX5/Iwu+hnjW0bE0Rj2PdNrQlt6Yj41VtbuYZ2JmtAz1Pb25YpOOtXQDfqydq9PqVfCTrekYca5xWlyFMyB/f/KyQuCSPy1sDXNs/iuK50Uj8agAiM5OaLntb/h7O9kMMpB/TbGMAC30uc3AEv0N+NRuRygShn6y25rcpGNZjF7yZB4G+d6VCJa+thzr39oLIzz1YNe1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(508600001)(9686003)(4326008)(33656002)(38100700002)(122000001)(26005)(52536014)(186003)(83380400001)(8936002)(55016003)(7696005)(71200400001)(30864003)(110136005)(2906002)(66574015)(53546011)(54906003)(38070700005)(8676002)(82960400001)(66446008)(64756008)(66476007)(66556008)(66946007)(316002)(5660300002)(76116006)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Owv/s+73pOJ0rlrg4GrRplaD8YYP+Jn+Zf5MFepZcNkUOhBDwVR8nsNU7g?=
 =?iso-8859-1?Q?2ZsWGGwHoRGfn6E5t1ztyvGbxKffJtmqjAd1XXpRNtdCAIpVhmx+3A3uQe?=
 =?iso-8859-1?Q?hdLxjzE/779BspI14za/OGSkOOm/t+w5jAO2JNow6fjacyL1w6ENR79dPj?=
 =?iso-8859-1?Q?0QQ0oOftKsOmeARGDwLiFortik2Ss4LLtTdUAV6ClUeNk4juCsQc7MiKt9?=
 =?iso-8859-1?Q?OiGBOwFkkrZzYo+3SykFwfI75QRh4+iii7DcUJBCgr9ksNLGM3Z1pJ+2gd?=
 =?iso-8859-1?Q?bPjkAPRify9nNgej6ja7OpTPQZjcLWf28Syy7QXTc/C0ltkUCrX1lJtQ9a?=
 =?iso-8859-1?Q?d0P4XGk7oSGaY0KyEj4OE5XTeqJ+XRQwDidF45QovrXEmQQ56Tbckxc93P?=
 =?iso-8859-1?Q?P9/pLmpZ/QlxNC2WLOncDQvmBD51xlVLZuafkKsR0TKxFtWVeuOM/kMGQ9?=
 =?iso-8859-1?Q?GK5FshEsN4YFnWnL+efEpLYQ3OvGFuahWGzyVaJRNPQA97OHaHfF2+938+?=
 =?iso-8859-1?Q?5gUB8AsRWPWNPg4bDnHq/fGKn6L/99oZRuwIoqVII+uhaxf7NyxO2WV9hD?=
 =?iso-8859-1?Q?nYM9ot23THHi83pd8x3VfpFeh0FVhLl9TWqL+XAZKWawd7YL0eR16I+stm?=
 =?iso-8859-1?Q?NRPBMl/dEVYWHmLJqJp4Y/ge53uAJopmbwrbLosiYs0SEMITMkmQOyU/Nx?=
 =?iso-8859-1?Q?U+lrKRCJFPNamHL6XHEmpQwEEWnS9WT4HRTFvRr6SkWDq79lrRLzogdQ2+?=
 =?iso-8859-1?Q?UQt2IYT0R6dh5fRIJwyoGsxM4jjf0nDtzyO1bnE0HzPGLioHpAmGJ//xCr?=
 =?iso-8859-1?Q?MGh0mFlewbxaIb5oWUvReC+poQ2opZTpmW6/svhEcSt1QAttVAWjCMwzB/?=
 =?iso-8859-1?Q?FCgkdvJ+G28QOMkWcHmNREj1E+wCR8IQbKqKbwu9KLNqakX6X4vfODaPYD?=
 =?iso-8859-1?Q?EIrW7iieB6XlCE2xK3gVgSnPFk1UQxSKHL1FlP9u8Xki5y7diU+2a4Bt3P?=
 =?iso-8859-1?Q?XwV1DYp9yJp6NMPqTKmK0t2ip22edVglaXciZT3qo1rebjs3pRNvMBNq5F?=
 =?iso-8859-1?Q?Y6Y4xeCSo0syzn9cH308E1g3hfHZ8heMUSzQd6BaVbSvHyGzAkBhhBaXYM?=
 =?iso-8859-1?Q?67RZy1Fuf+X5vI6wH1IQvs96P9l7/PmoTG64LMox3ektZyLYxyrISGB7QJ?=
 =?iso-8859-1?Q?TEgPeyej2yFmB9PEArq5Z7vBQQeOQR8KFPXlVwMUxV6OOKIrKLK0fI5wZs?=
 =?iso-8859-1?Q?SlKVUSSon1SG486LaxxBspSN7wk+ooGR+Ot9rDs6nE615wHCAFGU0wVY5Q?=
 =?iso-8859-1?Q?N15JklKoZiS1EjhnIl1aVFZ56SvaTx0ZReUuNPndaZ3jfvQYr6VvLrIAvx?=
 =?iso-8859-1?Q?q31hld0uLibzmb5l43ck/IdoPDGJREzDBvXJ0jOzjN0IS6qZblpO/20lTz?=
 =?iso-8859-1?Q?mWkCmxYzFom8QnzJXRm2PBKXlxTn+Q7S39camIPwSZJbi3llYlvg6WOrnw?=
 =?iso-8859-1?Q?flBv4loOfrHLWH7lv5xilXYP3V0OGr5J8JHNeCuW212g664ou2QQJylELb?=
 =?iso-8859-1?Q?JEhempvlZm14glhkH4W6hMJbxGpqElo+Y91dqbCIjzrD4KWFueUuoMhQj4?=
 =?iso-8859-1?Q?PjjOzLasXvmlXnf8lTdrAoKFnZ81X7DZohSGmTgzdW0J7kzjb1pV46Cg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93254fd-e166-4293-16e5-08d9c5e85925
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 07:46:36.4886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zissoxFM59E0nDXUDk8ly8bunnCQeoXfBJkHGLJSwjXFIRs3g/KZDhSVbviIbhWCvwFr1hny6c/+VKoSi/qb5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2858
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, December 23, 2021 2:59 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> tiwai@suse.de; broonie@kernel.org; gregkh@linuxfoundation.org;
> srinivas.kandagatla@linaro.org; pierre-louis.bossart@linux.intel.com; Kal=
e,
> Sanyog R <sanyog.r.kale@intel.com>; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH 7/7] soundwire: intel: remove PDM support
>=20
> On 13-12-21, 13:46, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >
> > While the hardware supports PDM streams, this capability has never
> > been tested or enabled on any product, so this is dead-code. Let's
> > remove all this.
>=20
> So no plans to test and enable this? Do the DMICs not use PDM?

The point is that this code is unused/untested. We can re-add it after
it was tested.

>=20
> Again this should not be in this series...

Agree, but since this patche depends on the previous patches, I sent them
together to avoid conflict.

>=20
> >
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.c=
om>
> > Reviewed-by: P=E9ter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > Reviewed-by: Rander Wang <rander.wang@intel.com>
> > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > ---
> >  drivers/soundwire/cadence_master.c |  36 +--------
> >  drivers/soundwire/cadence_master.h |  12 +--
> >  drivers/soundwire/intel.c          | 123 +++++++----------------------
> >  3 files changed, 31 insertions(+), 140 deletions(-)
> >
> > diff --git a/drivers/soundwire/cadence_master.c
> b/drivers/soundwire/cadence_master.c
> > index 4fcc3ba93004..558390af44b6 100644
> > --- a/drivers/soundwire/cadence_master.c
> > +++ b/drivers/soundwire/cadence_master.c
> > @@ -1178,9 +1178,6 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
> >  	cdns->pcm.num_bd =3D config.pcm_bd;
> >  	cdns->pcm.num_in =3D config.pcm_in;
> >  	cdns->pcm.num_out =3D config.pcm_out;
> > -	cdns->pdm.num_bd =3D config.pdm_bd;
> > -	cdns->pdm.num_in =3D config.pdm_in;
> > -	cdns->pdm.num_out =3D config.pdm_out;
> >
> >  	/* Allocate PDIs for PCMs */
> >  	stream =3D &cdns->pcm;
> > @@ -1211,32 +1208,6 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
> >  	stream->num_pdi =3D stream->num_bd + stream->num_in + stream-
> >num_out;
> >  	cdns->num_ports =3D stream->num_pdi;
> >
> > -	/* Allocate PDIs for PDMs */
> > -	stream =3D &cdns->pdm;
> > -	ret =3D cdns_allocate_pdi(cdns, &stream->bd,
> > -				stream->num_bd, offset);
> > -	if (ret)
> > -		return ret;
> > -
> > -	offset +=3D stream->num_bd;
> > -
> > -	ret =3D cdns_allocate_pdi(cdns, &stream->in,
> > -				stream->num_in, offset);
> > -	if (ret)
> > -		return ret;
> > -
> > -	offset +=3D stream->num_in;
> > -
> > -	ret =3D cdns_allocate_pdi(cdns, &stream->out,
> > -				stream->num_out, offset);
> > -
> > -	if (ret)
> > -		return ret;
> > -
> > -	/* Update total number of PDM PDIs */
> > -	stream->num_pdi =3D stream->num_bd + stream->num_in + stream-
> >num_out;
> > -	cdns->num_ports +=3D stream->num_pdi;
> > -
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(sdw_cdns_pdi_init);
> > @@ -1681,7 +1652,7 @@ int sdw_cdns_probe(struct sdw_cdns *cdns)
> >  EXPORT_SYMBOL(sdw_cdns_probe);
> >
> >  int cdns_set_sdw_stream(struct snd_soc_dai *dai,
> > -			void *stream, bool pcm, int direction)
> > +			void *stream, int direction)
> >  {
> >  	struct sdw_cdns *cdns =3D snd_soc_dai_get_drvdata(dai);
> >  	struct sdw_cdns_dma_data *dma;
> > @@ -1705,10 +1676,7 @@ int cdns_set_sdw_stream(struct snd_soc_dai
> *dai,
> >  		if (!dma)
> >  			return -ENOMEM;
> >
> > -		if (pcm)
> > -			dma->stream_type =3D SDW_STREAM_PCM;
> > -		else
> > -			dma->stream_type =3D SDW_STREAM_PDM;
> > +		dma->stream_type =3D SDW_STREAM_PCM;
> >
> >  		dma->bus =3D &cdns->bus;
> >  		dma->link_id =3D cdns->instance;
> > diff --git a/drivers/soundwire/cadence_master.h
> b/drivers/soundwire/cadence_master.h
> > index aa4b9b0eb2a8..595d72c15d97 100644
> > --- a/drivers/soundwire/cadence_master.h
> > +++ b/drivers/soundwire/cadence_master.h
> > @@ -17,7 +17,7 @@
> >   * @h_ch_num: high channel for PDI
> >   * @ch_count: total channel count for PDI
> >   * @dir: data direction
> > - * @type: stream type, PDM or PCM
> > + * @type: stream type, (only PCM supported)
> >   */
> >  struct sdw_cdns_pdi {
> >  	int num;
> > @@ -62,17 +62,11 @@ struct sdw_cdns_streams {
> >   * @pcm_bd: number of bidirectional PCM streams supported
> >   * @pcm_in: number of input PCM streams supported
> >   * @pcm_out: number of output PCM streams supported
> > - * @pdm_bd: number of bidirectional PDM streams supported
> > - * @pdm_in: number of input PDM streams supported
> > - * @pdm_out: number of output PDM streams supported
> >   */
> >  struct sdw_cdns_stream_config {
> >  	unsigned int pcm_bd;
> >  	unsigned int pcm_in;
> >  	unsigned int pcm_out;
> > -	unsigned int pdm_bd;
> > -	unsigned int pdm_in;
> > -	unsigned int pdm_out;
> >  };
> >
> >  /**
> > @@ -111,7 +105,6 @@ struct sdw_cdns_dma_data {
> >   * @ports: Data ports
> >   * @num_ports: Total number of data ports
> >   * @pcm: PCM streams
> > - * @pdm: PDM streams
> >   * @registers: Cadence registers
> >   * @link_up: Link status
> >   * @msg_count: Messages sent on bus
> > @@ -129,7 +122,6 @@ struct sdw_cdns {
> >  	int num_ports;
> >
> >  	struct sdw_cdns_streams pcm;
> > -	struct sdw_cdns_streams pdm;
> >
> >  	int pdi_loopback_source;
> >  	int pdi_loopback_target;
> > @@ -188,7 +180,7 @@ cdns_xfer_msg_defer(struct sdw_bus *bus,
> >  int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params
> *params);
> >
> >  int cdns_set_sdw_stream(struct snd_soc_dai *dai,
> > -			void *stream, bool pcm, int direction);
> > +			void *stream, int direction);
> >
> >  void sdw_cdns_check_self_clearing_bits(struct sdw_cdns *cdns, const
> char *string,
> >  				       bool initial_delay, int reset_iterations);
> > diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> > index 45ea55a7d0c8..79ba0e3f6dac 100644
> > --- a/drivers/soundwire/intel.c
> > +++ b/drivers/soundwire/intel.c
> > @@ -564,7 +564,7 @@ static void intel_pdi_init(struct sdw_intel *sdw,
> >  {
> >  	void __iomem *shim =3D sdw->link_res->shim;
> >  	unsigned int link_id =3D sdw->instance;
> > -	int pcm_cap, pdm_cap;
> > +	int pcm_cap;
> >
> >  	/* PCM Stream Capability */
> >  	pcm_cap =3D intel_readw(shim, SDW_SHIM_PCMSCAP(link_id));
> > @@ -575,41 +575,25 @@ static void intel_pdi_init(struct sdw_intel *sdw,
> >
> >  	dev_dbg(sdw->cdns.dev, "PCM cap bd:%d in:%d out:%d\n",
> >  		config->pcm_bd, config->pcm_in, config->pcm_out);
> > -
> > -	/* PDM Stream Capability */
> > -	pdm_cap =3D intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
> > -
> > -	config->pdm_bd =3D FIELD_GET(SDW_SHIM_PDMSCAP_BSS,
> pdm_cap);
> > -	config->pdm_in =3D FIELD_GET(SDW_SHIM_PDMSCAP_ISS, pdm_cap);
> > -	config->pdm_out =3D FIELD_GET(SDW_SHIM_PDMSCAP_OSS,
> pdm_cap);
> > -
> > -	dev_dbg(sdw->cdns.dev, "PDM cap bd:%d in:%d out:%d\n",
> > -		config->pdm_bd, config->pdm_in, config->pdm_out);
> >  }
> >
> >  static int
> > -intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool
> pcm)
> > +intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num)
> >  {
> >  	void __iomem *shim =3D sdw->link_res->shim;
> >  	unsigned int link_id =3D sdw->instance;
> >  	int count;
> >
> > -	if (pcm) {
> > -		count =3D intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id,
> pdi_num));
> > +	count =3D intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id,
> pdi_num));
> >
> > -		/*
> > -		 * WORKAROUND: on all existing Intel controllers, pdi
> > -		 * number 2 reports channel count as 1 even though it
> > -		 * supports 8 channels. Performing hardcoding for pdi
> > -		 * number 2.
> > -		 */
> > -		if (pdi_num =3D=3D 2)
> > -			count =3D 7;
> > -
> > -	} else {
> > -		count =3D intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
> > -		count =3D FIELD_GET(SDW_SHIM_PDMSCAP_CPSS, count);
> > -	}
> > +	/*
> > +	 * WORKAROUND: on all existing Intel controllers, pdi
> > +	 * number 2 reports channel count as 1 even though it
> > +	 * supports 8 channels. Performing hardcoding for pdi
> > +	 * number 2.
> > +	 */
> > +	if (pdi_num =3D=3D 2)
> > +		count =3D 7;
> >
> >  	/* zero based values for channel count in register */
> >  	count++;
> > @@ -620,12 +604,12 @@ intel_pdi_get_ch_cap(struct sdw_intel *sdw,
> unsigned int pdi_num, bool pcm)
> >  static int intel_pdi_get_ch_update(struct sdw_intel *sdw,
> >  				   struct sdw_cdns_pdi *pdi,
> >  				   unsigned int num_pdi,
> > -				   unsigned int *num_ch, bool pcm)
> > +				   unsigned int *num_ch)
> >  {
> >  	int i, ch_count =3D 0;
> >
> >  	for (i =3D 0; i < num_pdi; i++) {
> > -		pdi->ch_count =3D intel_pdi_get_ch_cap(sdw, pdi->num, pcm);
> > +		pdi->ch_count =3D intel_pdi_get_ch_cap(sdw, pdi->num);
> >  		ch_count +=3D pdi->ch_count;
> >  		pdi++;
> >  	}
> > @@ -635,25 +619,23 @@ static int intel_pdi_get_ch_update(struct
> sdw_intel *sdw,
> >  }
> >
> >  static int intel_pdi_stream_ch_update(struct sdw_intel *sdw,
> > -				      struct sdw_cdns_streams *stream, bool
> pcm)
> > +				      struct sdw_cdns_streams *stream)
> >  {
> >  	intel_pdi_get_ch_update(sdw, stream->bd, stream->num_bd,
> > -				&stream->num_ch_bd, pcm);
> > +				&stream->num_ch_bd);
> >
> >  	intel_pdi_get_ch_update(sdw, stream->in, stream->num_in,
> > -				&stream->num_ch_in, pcm);
> > +				&stream->num_ch_in);
> >
> >  	intel_pdi_get_ch_update(sdw, stream->out, stream->num_out,
> > -				&stream->num_ch_out, pcm);
> > +				&stream->num_ch_out);
> >
> >  	return 0;
> >  }
> >
> >  static int intel_pdi_ch_update(struct sdw_intel *sdw)
> >  {
> > -	/* First update PCM streams followed by PDM streams */
> > -	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pcm, true);
> > -	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pdm, false);
> > +	intel_pdi_stream_ch_update(sdw, &sdw->cdns.pcm);
> >
> >  	return 0;
> >  }
> > @@ -840,7 +822,6 @@ static int intel_hw_params(struct
> snd_pcm_substream *substream,
> >  	struct sdw_port_config *pconfig;
> >  	int ch, dir;
> >  	int ret;
> > -	bool pcm =3D true;
> >
> >  	dma =3D snd_soc_dai_get_dma_data(dai, substream);
> >  	if (!dma)
> > @@ -852,13 +833,7 @@ static int intel_hw_params(struct
> snd_pcm_substream *substream,
> >  	else
> >  		dir =3D SDW_DATA_DIR_TX;
> >
> > -	if (dma->stream_type =3D=3D SDW_STREAM_PDM)
> > -		pcm =3D false;
> > -
> > -	if (pcm)
> > -		pdi =3D sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir, dai->id);
> > -	else
> > -		pdi =3D sdw_cdns_alloc_pdi(cdns, &cdns->pdm, ch, dir, dai->id);
> > +	pdi =3D sdw_cdns_alloc_pdi(cdns, &cdns->pcm, ch, dir, dai->id);
> >
> >  	if (!pdi) {
> >  		ret =3D -EINVAL;
> > @@ -888,12 +863,7 @@ static int intel_hw_params(struct
> snd_pcm_substream *substream,
> >  	sconfig.frame_rate =3D params_rate(params);
> >  	sconfig.type =3D dma->stream_type;
> >
> > -	if (dma->stream_type =3D=3D SDW_STREAM_PDM) {
> > -		sconfig.frame_rate *=3D 50;
> > -		sconfig.bps =3D 1;
> > -	} else {
> > -		sconfig.bps =3D
> snd_pcm_format_width(params_format(params));
> > -	}
> > +	sconfig.bps =3D snd_pcm_format_width(params_format(params));
> >
> >  	/* Port configuration */
> >  	pconfig =3D kzalloc(sizeof(*pconfig), GFP_KERNEL);
> > @@ -1012,13 +982,7 @@ static void intel_shutdown(struct
> snd_pcm_substream *substream,
> >  static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
> >  				    void *stream, int direction)
> >  {
> > -	return cdns_set_sdw_stream(dai, stream, true, direction);
> > -}
> > -
> > -static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
> > -				    void *stream, int direction)
> > -{
> > -	return cdns_set_sdw_stream(dai, stream, false, direction);
> > +	return cdns_set_sdw_stream(dai, stream, direction);
> >  }
> >
> >  static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
> > @@ -1133,16 +1097,6 @@ static const struct snd_soc_dai_ops
> intel_pcm_dai_ops =3D {
> >  	.get_stream =3D intel_get_sdw_stream,
> >  };
> >
> > -static const struct snd_soc_dai_ops intel_pdm_dai_ops =3D {
> > -	.startup =3D intel_startup,
> > -	.hw_params =3D intel_hw_params,
> > -	.prepare =3D intel_prepare,
> > -	.hw_free =3D intel_hw_free,
> > -	.shutdown =3D intel_shutdown,
> > -	.set_sdw_stream =3D intel_pdm_set_sdw_stream,
> > -	.get_sdw_stream =3D intel_get_sdw_stream,
> > -};
> > -
> >  static const struct snd_soc_component_driver dai_component =3D {
> >  	.name           =3D "soundwire",
> >  	.suspend	=3D intel_component_dais_suspend
> > @@ -1151,7 +1105,7 @@ static const struct snd_soc_component_driver
> dai_component =3D {
> >  static int intel_create_dai(struct sdw_cdns *cdns,
> >  			    struct snd_soc_dai_driver *dais,
> >  			    enum intel_pdi_type type,
> > -			    u32 num, u32 off, u32 max_ch, bool pcm)
> > +			    u32 num, u32 off, u32 max_ch)
> >  {
> >  	int i;
> >
> > @@ -1180,10 +1134,7 @@ static int intel_create_dai(struct sdw_cdns *cdn=
s,
> >  			dais[i].capture.formats =3D
> SNDRV_PCM_FMTBIT_S16_LE;
> >  		}
> >
> > -		if (pcm)
> > -			dais[i].ops =3D &intel_pcm_dai_ops;
> > -		else
> > -			dais[i].ops =3D &intel_pdm_dai_ops;
> > +		dais[i].ops =3D &intel_pcm_dai_ops;
> >  	}
> >
> >  	return 0;
> > @@ -1197,7 +1148,7 @@ static int intel_register_dai(struct sdw_intel *s=
dw)
> >  	int num_dai, ret, off =3D 0;
> >
> >  	/* DAIs are created based on total number of PDIs supported */
> > -	num_dai =3D cdns->pcm.num_pdi + cdns->pdm.num_pdi;
> > +	num_dai =3D cdns->pcm.num_pdi;
> >
> >  	dais =3D devm_kcalloc(cdns->dev, num_dai, sizeof(*dais),
> GFP_KERNEL);
> >  	if (!dais)
> > @@ -1207,39 +1158,19 @@ static int intel_register_dai(struct sdw_intel
> *sdw)
> >  	stream =3D &cdns->pcm;
> >
> >  	ret =3D intel_create_dai(cdns, dais, INTEL_PDI_IN, cdns->pcm.num_in,
> > -			       off, stream->num_ch_in, true);
> > +			       off, stream->num_ch_in);
> >  	if (ret)
> >  		return ret;
> >
> >  	off +=3D cdns->pcm.num_in;
> >  	ret =3D intel_create_dai(cdns, dais, INTEL_PDI_OUT, cdns-
> >pcm.num_out,
> > -			       off, stream->num_ch_out, true);
> > +			       off, stream->num_ch_out);
> >  	if (ret)
> >  		return ret;
> >
> >  	off +=3D cdns->pcm.num_out;
> >  	ret =3D intel_create_dai(cdns, dais, INTEL_PDI_BD, cdns->pcm.num_bd,
> > -			       off, stream->num_ch_bd, true);
> > -	if (ret)
> > -		return ret;
> > -
> > -	/* Create PDM DAIs */
> > -	stream =3D &cdns->pdm;
> > -	off +=3D cdns->pcm.num_bd;
> > -	ret =3D intel_create_dai(cdns, dais, INTEL_PDI_IN, cdns->pdm.num_in,
> > -			       off, stream->num_ch_in, false);
> > -	if (ret)
> > -		return ret;
> > -
> > -	off +=3D cdns->pdm.num_in;
> > -	ret =3D intel_create_dai(cdns, dais, INTEL_PDI_OUT, cdns-
> >pdm.num_out,
> > -			       off, stream->num_ch_out, false);
> > -	if (ret)
> > -		return ret;
> > -
> > -	off +=3D cdns->pdm.num_out;
> > -	ret =3D intel_create_dai(cdns, dais, INTEL_PDI_BD, cdns-
> >pdm.num_bd,
> > -			       off, stream->num_ch_bd, false);
> > +			       off, stream->num_ch_bd);
> >  	if (ret)
> >  		return ret;
> >
> > --
> > 2.17.1
>=20
> --
> ~Vinod
