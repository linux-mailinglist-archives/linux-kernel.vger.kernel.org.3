Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D79522CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbiEKG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbiEKGz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:55:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF7B338A5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652252158; x=1683788158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2QzOoczhLCfXeelHIB2RIcgAJ7+KemzQcBCJ/Q4woCQ=;
  b=ZQtFg4I+ED0r6Kgi23DlDjuhg+k+v5RE3urFTByDEc/ME04sMNdpz+d3
   3VeuWGbH/WojiLSQO3p/7sWYK02EEq4ojQkDdAn3i0Dwno7sgx/uA67rq
   0YUnlhjUL0Wf5o97FptYnLUZlZhhvlEM0bE0J7ruoLKCR5zmNPy/mfuuP
   4OB8qTtZ3jniGlGC6Hf5G+1HSI1RSEIL8k8Iz1wdeyFltzy5cmIeKudie
   KIk3ggPWfCM/JyhZHowSib9vcLKkkZcJYSF4viaWRliqy4L4tMwPbqzba
   YnnYfLFY08NONusq5AdFcXIwfbg2mPMWfgvp8GjlfA8L86l0E7eVUSsli
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269740682"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269740682"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 23:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="566034168"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 10 May 2022 23:55:48 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 23:55:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 23:55:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 10 May 2022 23:55:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 10 May 2022 23:55:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPzU8P2XTHOCdfftRsI1p1w+THiM1VEa/UmwHTQ145jWkEm2aM4pBFIA29UAGtYS5uxF8Y2vZfLKHobS9NL2IJqC1954YqwXXjgT1V4IiEk1bHTMLcoxGHgWeD8uR+oSipvALRDKiM6CEuzf79usI5XK7IwZG11ja+dMI/7/hIztK/C4K3JtpUuocJCxxxeQ6AT9aGCRpYRX8/t3SR0w90KCCsQ/MVXsufFshoyBl8UZHp+JpX3rGrzPX4mrIjtc0v6lGhhrsOITmw2IHNCDA8pc5j47WPeoZkJnj5yVoFKNDwEahK1RpaIDic/Ah96ekHA3crdDwOslGMxzI48HzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlry7aF8qA0RhKcDgww4GeC3q3M7UQRicKo9wN5+xaE=;
 b=jrRBsehTw6/cyPE+Ehd6TiiLpsFAnB3sCcQBjClRgzq68UNHeSm1eRlLAM/koJr88zBxagn7MgNr/ltoXFai2f4xoPhBGl7yemO8C0r3qdd0caATqQadkGilebAyiQEDW8lmI1pRSwjUUTdy+OQGkA0vpz980HikvKPlIUeZLjuKQledNboxjHafejDQ2xQPEOeCFavHTnf70J82A4Ecj6jS4+99bbKtYhcDsmkK145qED3dtlGSwV7PmQdEnLulzQQQjTXjNQUXKlwbTZqVJRC0UcFbnJED119HfOl2grerN1ishVIji+SI6oBw4ssWf7SKdISolZSfbLWUZGKSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18)
 by DM6PR11MB3018.namprd11.prod.outlook.com (2603:10b6:5:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 06:55:45 +0000
Received: from SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::6545:bc8e:a452:2d5f]) by SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::6545:bc8e:a452:2d5f%8]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 06:55:45 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Terry Chen <terry_chen@wistron.corp-partner.google.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "cujomalainey@chromium.org" <cujomalainey@chromium.org>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "mark_hsieh@wistron.corp-partner.google.com" 
        <mark_hsieh@wistron.corp-partner.google.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [v3]FROMLIST: ASoC: Intel: sof_cs42l42: adding support
 for ADL configuration and BT offload audio
Thread-Topic: [PATCH] [v3]FROMLIST: ASoC: Intel: sof_cs42l42: adding support
 for ADL configuration and BT offload audio
Thread-Index: AQHYZP/rutgSvWVg6E+qvH7tXhu/H60ZPIjw
Date:   Wed, 11 May 2022 06:55:45 +0000
Message-ID: <SA2PR11MB4891262E970A79FCCF3B345597C89@SA2PR11MB4891.namprd11.prod.outlook.com>
References: <20220511062514.1743838-1-terry_chen@wistron.corp-partner.google.com>
In-Reply-To: <20220511062514.1743838-1-terry_chen@wistron.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.15
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79a4f410-9cb6-49ec-5196-08da331b45e4
x-ms-traffictypediagnostic: DM6PR11MB3018:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3018470F2585AA296EB9B1E997C89@DM6PR11MB3018.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xsHjBPXeli14UvSpfZRD+KutOPRNh1EmRiTAJZpzwVYq1aO4DA3WtZIChoahGlduHjlX7gsavq3ffAJaX3H9lFgJqgYSNLa2LWdEJu47cgNORmxccXtMLVd1zf4n+Lxzhlu87uv1cZKXie6GVkJWIF0QWMzU0wwL0nPupZ/gfJVn1ObC4pWdnEj2tr+knhOf0AlrVXqbUdMxPrLr37JjSR3loLWS6zVXedKmwNTDMWlHdu2mMuuWSEadKkJOewTYuJp8ZQa5fVfyKvPhtcWrqjC4W8zbtY4WJUAwmkHqI9Nga570uOYX1yRQxgRaG/fArkReimq6zNygNqNtTFA2PdeKltAqupPZcup8coyj1pjC0W/udEL+vcerAZ5eJ4Mxk/Yv0ClhH9y7pC3/k2o40A4Z02ImP4Zj19UyFth4+5YKlV74PIMCg5IyW5oNLbxsNA2QLu06gsA5Se0jiQnS7wslIjrJ2ELNjUkJe1o5tBaQ04PMV65vvcjPcKgqGxPGe2mBue9NEh0PtZl4CFUR/rv52p9J2h8Z6gUO1zt3msx8P6E9kBvpGXzNL8gluduZbMRrM+5Y/P5u3+urCY5AOiiTYJfHAMxDRfd5z+n822CkGMfwLi7kfC7MopiKO/bQLznVnu/sR6ZST/Jy7icEWBKecq/CzfEZsYmkSHqweQ0R6beu+Vypf4ZHXUyQBKh56aFNH5WlimYExIbuZPi+GBf/EkRFlpa9mJEdJqxwEM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4891.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(9686003)(54906003)(8936002)(86362001)(55016003)(316002)(7696005)(6506007)(5660300002)(508600001)(52536014)(33656002)(38070700005)(66476007)(66446008)(66556008)(66946007)(76116006)(38100700002)(4326008)(2906002)(7416002)(71200400001)(64756008)(8676002)(82960400001)(186003)(26005)(122000001)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VkY3qcS5MrNgInue/iDU+ImTfaL54fz/SStL3MTC+BCHZyvWGRxB+InD2phS?=
 =?us-ascii?Q?Gv7ggcYVIA//ehAF3LXj5joLkEznp1VN/mzVr9HLtQNSozr2Z8dSZSASyueB?=
 =?us-ascii?Q?pqj0NlcO0QRun6t36dSxmI9kM+DYztCks1YyGxQPOTCmLY1kWmsNtGtDfPna?=
 =?us-ascii?Q?FnGQeL94/KQbxzpePedXtEIIablenZuJlKSWPX4Hzpjcjf5PC81gN3w3jUVJ?=
 =?us-ascii?Q?A/Lboo3RYtwfoxcUH2Np7je67UCuAgTxCSU30REtdJNsCAT8D51TexOTVmT/?=
 =?us-ascii?Q?mai3cH74Gu/BC9/E3vH1JYauJ75L1hheyHUD546p9oqD9kpM7dmDDJbs9TLl?=
 =?us-ascii?Q?BI+tpGyuWDW1K97ynL6hDxsbREiuMcLYtvyRSNFJt533d6Xr5Ylhng9SbEXf?=
 =?us-ascii?Q?yYT3GCUYciLQSTQgi4ltIKynZi3cCbwkPlc3VPRd08bjhyGYjR56pQs5J0MB?=
 =?us-ascii?Q?yvq6CtUhjYqgW1MsXavpeWjru8tchwtaRIu3fdYhGDY/bwSCDT6XNtXDlrjx?=
 =?us-ascii?Q?WUHEwhgqSJdQLcQktpxjbqcz4+DrWUiTOEqlH6Tb1P730JdqzFHVyPgTTJLC?=
 =?us-ascii?Q?U8BLJBg3DJgeyZkNZdmGPUNHNjdUYXUB4jnbmFcmNAKY20T11kcIc/n2I95c?=
 =?us-ascii?Q?AQaNUpb+drDsiU/tdSzwvZHcbRgfYcOu8yW5jceDJ9IAlAWDIk6jl7JxgURu?=
 =?us-ascii?Q?uVEee76c+B0BHP5SfUsGk0O/VInrD4JIO/gy+UfJOCNyb6tsO7vAnzI7VyW/?=
 =?us-ascii?Q?pscGZmo5Ya2UrL9upTNKRbWooeIjvu319u7YV48TMEW8HjTsBDDDL3msgpt4?=
 =?us-ascii?Q?+ObC7ehgMaZITE47ufdUSpuGteQA1S8AutPHEZP6GCh6tP73HzCqJddjpZpv?=
 =?us-ascii?Q?g5eJXYHRb0/4wd7hE/N+RLIl7sTF7CxzDx94Q1DpY41Adfu3S3jD2bPW75Y1?=
 =?us-ascii?Q?tWA61pS4gSyDmujJzf+GwnOqvM54ROmw24DfGvG83vAfA9RjCkYKaVs24M/u?=
 =?us-ascii?Q?AySmQeT+AGxa+sdNrjNW16B7EDSavt6cG84UtL3q2J5MeOZXW6hNq3rXS/lt?=
 =?us-ascii?Q?TKYokMI3H2XzD+HBU+9XhSqrL61bfV6usyTrPSBmJ1BtPnUGuLTDxZ1KyVkp?=
 =?us-ascii?Q?87IhN5r6UI+ytAaZeARkFQsuIZI4frs7NXtyBLD2AxR3QCD8CJS2RuhToEns?=
 =?us-ascii?Q?q6o/sIXFI7iV8vFn81TDpP92xjIZBIvKqDpFcnWbVOcpfthiICM1o5lb6sL8?=
 =?us-ascii?Q?lrtSrA3Kx7yOenRbFeYiOj/0aw3yngJQGERrzdljDjQsRka91NKuvbzCw3mX?=
 =?us-ascii?Q?QFdG2Y6KRdKnYrRGTHUa7Ca4wch6QOeg65tTWxw07LvRZYI/6g/0TLSrWKvZ?=
 =?us-ascii?Q?LQq3KURySU72BfZWyfFnJLUuKmmKkUkpXz3JtOdmEFOMnaOQu3y41/rl7sfy?=
 =?us-ascii?Q?0+9+tW6pe/jCfnCLX8oRwz131vH2KVoUkwvRZKCtjbHpj9fACenSG1eqOqMc?=
 =?us-ascii?Q?OAdEWNbYVYmmW/dSqPSx+43/lJnqz5BLydFHqLGqYavwenBDsO37VhZQr5vB?=
 =?us-ascii?Q?FOGSmFiF7oGxc7hyVbkVkL84OwXmX0yOGz87AZXxHayRvCtzy/7vZ2SxFbF+?=
 =?us-ascii?Q?Zr8v2RK2+sbJEdenTLKenGP6uj9XGcrzNXtiYGpVGPfj5dp1wnPJN5tEVHZA?=
 =?us-ascii?Q?5xDEGdJJv1G7Bve4i2ZegE6aHamw5c0ZuL38L6GnbOgfktPWHW+IYwGv4UW3?=
 =?us-ascii?Q?3XENtjliYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4891.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a4f410-9cb6-49ec-5196-08da331b45e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 06:55:45.5446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5q/PClVKX0cHhlL9xOCCmL2G8lxWTYLT3QQrNvG7gsa4WeFwvY76l2kfvjlcaNj6iFsaenSEzrMQGYh6Sr/dJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3018
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> +static int create_bt_offload_dai_links(struct device *dev,
> +				       struct snd_soc_dai_link *links,
> +				       struct snd_soc_dai_link_component
> *cpus,
> +				       int *id, int ssp_bt)
> +{
> +	int ret =3D 0;
Unused variable, please remove it.
> +
> +	/* bt offload */
> +	if (!(sof_cs42l42_quirk & SOF_BT_OFFLOAD_PRESENT))
> +		return 0;
> +
> +	links[*id].name =3D devm_kasprintf(dev, GFP_KERNEL, "SSP%d-BT",
> +					 ssp_bt);
> +	if (!links[*id].name) {
> +		ret =3D -ENOMEM;
Remove it, too. And also the brackets.
> +		goto devm_err;
> +	}
> +
> +	links[*id].id =3D *id;
> +	links[*id].codecs =3D dummy_component;
> +	links[*id].num_codecs =3D ARRAY_SIZE(dummy_component);
> +	links[*id].platforms =3D platform_component;
> +	links[*id].num_platforms =3D ARRAY_SIZE(platform_component);
> +
> +	links[*id].dpcm_playback =3D 1;
> +	links[*id].dpcm_capture =3D 1;
> +	links[*id].no_pcm =3D 1;
> +	links[*id].cpus =3D &cpus[*id];
> +	links[*id].num_cpus =3D 1;
> +
> +	links[*id].cpus->dai_name =3D devm_kasprintf(dev, GFP_KERNEL,
> +						   "SSP%d Pin",
> +						   ssp_bt);
> +	if (!links[*id].cpus->dai_name) {
> +		ret =3D -ENOMEM;
Same here.
> +		goto devm_err;
> +	}
> +
> +	(*id)++;
> +
> +	return 0;
> +
> +devm_err:
> +	return -ENOMEM;
> +}
> +

> --- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
> @@ -384,6 +384,14 @@ struct snd_soc_acpi_mach
> snd_soc_acpi_intel_adl_machines[] =3D {
>  		.sof_fw_filename =3D "sof-adl.ri",
>  		.sof_tplg_filename =3D "sof-adl-cs35l41.tplg",
>  	},
> +	{
> +		.id =3D "10134242",
> +		.drv_name =3D "adl_mx98360a_cs4242",
> +		.machine_quirk =3D snd_soc_acpi_codec_list,
> +		.quirk_data =3D &adl_max98360a_amp,
> +		.sof_fw_filename =3D "sof-adl.ri",
I remember that the 'sof_fw_filename' has been removed for a while. Please
apply the patch to the for-next branch on the broonie tree. Build the kerne=
l
and make sure there is no error before sending the patch.

Brent
