Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9B5927B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiHOCOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiHOCOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:14:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC6712D0F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660529688; x=1692065688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fCp8ifAYcH2jF2Rwfip436xbG95sDEQZl6eZYynEGmw=;
  b=BTmYil6ZzNxDvSIQnAD3152dPUmgrwFHotNGNkTvwz1lTg6MV8QmAFJA
   2hnH2bV2RRkMKgMTRFBsxAD4zvkkOws73GyLXJ0fCatdU1fTOviaNAWn6
   PZAZ1nB0dFJLLJqogllX9CoJQ7neopY5dUdy/NW/x2bDDWjCYU5xIhnYu
   mWmoOzlQW8tTnz2QzNPJ0dX2bVU+Md39jkL1K9pLYE07+mcPI68JuhJND
   Et4lcSxlaRoXnKft3WlrPrl/v6Wvg02GylAAONrv1/1060p8Rsr7bkoYw
   trGBqjCQJeRvA3UNCi+4mV5OhS38HJHpcgvGDdpjrosm94t6L+YrAmRLN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="274928255"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="274928255"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="603050316"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 14 Aug 2022 19:14:47 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 14 Aug 2022 19:14:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 14 Aug 2022 19:14:46 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 14 Aug 2022 19:14:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dflCg3YKGzW436p/yD/M+T0Uof6zkwvaUJdkOlIyNp9DbJHeWSldHkBa7UsveQoJxJC3kMhLckaMDbkCR0NXcSD/35cp0mnPGlQBJkytUZpjhRntM5Xwc49D0Uc1ZbbuyRdb27xN79zGtqORFKA+0548TcVu84Pc2jHCqxcFeFXR1s4UYGXUUqVfHftto9GVw+UGi7Vpln48Z82HeV0iJEpi5LdQSH/mqVKVms35clSUWBpZC5A9/ijB7nyhPl5gPhUk/rWOkQnGcC7y2VE+PZsdzWR9NzmHSikFrWg9p02ONZ7FsaSTY4x4rNl5WvWGVT89SVTTczdm8PjaOwk1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA6Kkdxe6+ABUNT8+fQMnvT4R47UxmGzqFDXyJ2ECtI=;
 b=LnptwaO/46qNghdAslH0qKqeko9ccDTQRXfHlEwDxgewvBksvtN6QkQQNVKfWh13+SB4g97kr2JVGkpCUBVv8F6wD2rnkzJB9gWOg9dPYCA4IE1+kmEC6h3HuPRWGhQlN62JMgycZjku5IjX8Us/mSDMwZI3ABMugVbkNUhKaW7kZxNv95PMzow0LfTu7gSwBpBTADuzs7wWOpsotMt5p7dOSGmQ1tVLQRdDGlB0G9B2Gg+0BIVP1S+tuwB5T5hcB1V9HPwsRDoOEOvwUNiM8+caynazHXi99q1aNq8eQFCvol4TeYHOGFr84wPIoXjrQwPCCYGa3hTbW92H/noawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by CY4PR11MB2055.namprd11.prod.outlook.com (2603:10b6:903:23::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 02:14:36 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::cc41:b741:dc2f:182f]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::cc41:b741:dc2f:182f%5]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 02:14:36 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Thread-Topic: [PATCH] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Thread-Index: AQHYrkFuhd+ftbZDCk+dLVSshb9ioK2vOjTg
Date:   Mon, 15 Aug 2022 02:14:36 +0000
Message-ID: <CY5PR11MB6257F9BB8766EDA67AB9965F97689@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20220812114804.550809-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220812114804.550809-1-sean.hong@quanta.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1b865a1-9f40-43b4-e755-08da7e63e6f3
x-ms-traffictypediagnostic: CY4PR11MB2055:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jGMUBcmllmxM/AZWlshVFCIBomUbVKHjZ8qKfJV9uYtH2wIgqFCa+HRPlA5UwAxSst3gc5j8gAq1DqGemavAnJbtX2vwfG6Q+Xmgef1isw332FyGxC2Ni+Y22gc5NDMIBLa2ZAKZyIO+P5eFFTGCxDiaSOjnkWFq5fOmdWQtdVSTT+khMwTRK65euSGsBB+lAgwOdbEHoRDChxaAndWYeKKrPj+UcMqZgIB+UiuZa78PPdmxhNH+p0A7oWSIE2EG0Mzsp7q9fGRWFueCG4Eoeo8fpKy41q1GB4AKx034/F1iaRKZdY/QWqpTUhDnS0GfezxRTKNbOCaFvUFB4rixYNiil1A2vPFA3uFmMBFCv0kuRZLuw1llSTQ/MO77+orKpoNScme/RprHUAIME34ALw7CFNUM2ZcyUJsVkcWnJCVppqK0068eV75eHFeiXOYMr1xQfzFVM6/AxLpxJTd2q98Lsu6LHJIGqUz98KyCKKEXzybEFxIDyMLdh61l2kQsvINzfpLo6Wpk4j5Egf46LX+2vb1tqXgerINTA3JxcdR7UuoawtF353WaOLjAaLxm6AToCsaZtw3UjcN7az3OQ6vHwpq/qlqOcxjGIbxaZfhVBT37TKaiAdLXAkr8r8pBFnrcrKH8Tvvq0J50M5GKWE/CdJQcuwXRcdUo7/0BMCwWIDubT/X8OMVjG+Pk3gqZWk+VDoQb1kOWeWxo8PtcxA8SBo2mIn1lf6pJRKjYZ/BbE1PJNqOdLHHau9rQiy5XdcH7W3aZgs2gqWxCsI26AW5TOa2g5LgtyZZma2vaGO3Uhj5FzQoIk+5a1eknzt55E+Iab0uxwcZif42uS1fcXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(366004)(39860400002)(346002)(55016003)(8936002)(82960400001)(38070700005)(86362001)(66946007)(38100700002)(33656002)(66556008)(71200400001)(76116006)(478600001)(122000001)(66446008)(66476007)(64756008)(316002)(4326008)(8676002)(966005)(54906003)(110136005)(26005)(9686003)(6506007)(7696005)(2906002)(7416002)(41300700001)(5660300002)(186003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z9yDAhuWLGZ9MlZLvpP3CBnnSuXWejvCsuPdXEYpOTPeHlp7yhTluiHPhQh1?=
 =?us-ascii?Q?cnEVxyXoAZupSnXNT87JCQgWd+pXfoIX0g+jO3c/5BjW1FrgKp4CgtCZBrQl?=
 =?us-ascii?Q?p2eXi3a46cFebz3eWft8Ufb7Mk0XvR538bH3MVcktyUWe6qCOziAmwiXmsXy?=
 =?us-ascii?Q?/R2JNz9aoswMq0fsGOTIhSCPh4UCU9FWuwxzoPHcaB5r2W2Vk79mYCQUfM2I?=
 =?us-ascii?Q?AsFzO1Ms1zY7Rfd7d3aAZIPLremXfXLLwslKUnGyPoiZX/INjjqivPf0XdZU?=
 =?us-ascii?Q?ahG+00zpVeaf7jVwPIfkklRjJpIhKmRzh3TkmresLQmVEiGIegTZBE8uNHAQ?=
 =?us-ascii?Q?V7c81AhjGM4lCoSJM6UbquPz/t/qEsLkbKoulTI7Ui/+pk0I5+KXFdrMWUVn?=
 =?us-ascii?Q?hM4lm1BhgV0lmqGwunL10/6tl7tTGVD0b6VnlmfaipswlF1TQgerSxCPTbEr?=
 =?us-ascii?Q?axV6Qy3WGPbpyFJl1xuSo5E2NP43roJiJCMxgnnn2fnXXXnra493KHdx3tWu?=
 =?us-ascii?Q?MQtOYXg6BHDkpSr1LJ2BQwYyypvQzKY8RtS0/Mav3YKB4Pt7BpLPi1bI+4yT?=
 =?us-ascii?Q?kqX1pQ0tgajxxm7y2l03omq9iRCf1+VWAng0FKYhELx7tlAnnXzYaK82pqpw?=
 =?us-ascii?Q?oDCyjiYEkyJNMF3QCO3bvKAJfMFAuE38Sz+OJKO48DaKQrMbKU/cFz2RU8Dp?=
 =?us-ascii?Q?JWmgGe1atIcB8mvunU2nBU2/bqySGLGeiNIxmyixewh7SY0EHZfKV9oyBGeE?=
 =?us-ascii?Q?WNMGsnzBJPgIR6FGY/+8zUKlydzv6TeDd/My09AR7f3AsNiULxFKCPt3POc2?=
 =?us-ascii?Q?mA966iI0o74FGO9wHe1FSps3d1E99435RR4JcBmHiA9gNK2W65PLbxBxECMo?=
 =?us-ascii?Q?86DWXESlcsc0wFbfafy3S2jglGyK+3N2dg3leDFQw3/Klwb+CReVQC4vBS1y?=
 =?us-ascii?Q?5IjVr7JJrMF0Zs8Jv9QzBlPJbaFCEceD2giLs6uNFk+pofyOYX0oJjOQYr4C?=
 =?us-ascii?Q?rOC5s7UOty3O4Uw/aIJO6RZvBLtQcAn2sJCNuvZvXbVIdM/uo1HbvTyfhORf?=
 =?us-ascii?Q?Or288whljBQammJSJilttRMktTKAVQHm/5igfr/RROklkLjSMyS1+w5HScGe?=
 =?us-ascii?Q?OkFzKuQhR/TEsciPPOtcIbXBInscAN09DPjLofrTT1UB9PCvqP8WObH2UHTo?=
 =?us-ascii?Q?kyLSnqZpiHaRRgkCWxh9ececy7yr+StnBwt+ampA5/jDQhYE3D4z+naxE/Ko?=
 =?us-ascii?Q?KOeIhVYzPod2lvc9pvNuIXKsNyeeCtnR1hm2gpTxJjQFAKGDsWh6mFz0kAnY?=
 =?us-ascii?Q?7ET5WA0bzu755llwdC/jIGuPAfNK4URgEDGhukOCj5rgmsiPT4JPhnd7WoGU?=
 =?us-ascii?Q?YuAjzwsIYrZcQNomokYCgkoMzC3MR1JgOkLuco4zYcDFXw4Z2iDtbNW9msYQ?=
 =?us-ascii?Q?5lvvujcvjjGnBQxsJydqKJJafV/kqBa5XwEzRehrV2wyMPSc1Mvp7DnAsXWx?=
 =?us-ascii?Q?dM5ksPIu6h6RA0Qoi8Y45/Y3fXFE13/lgXBNWae8GEGjjdXgHYCnRELMLGwj?=
 =?us-ascii?Q?cdESXc6UCFJyOytPVTmbspcq9e54R4uEmaKzLZVw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b865a1-9f40-43b4-e755-08da7e63e6f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 02:14:36.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cr2rnpHToPXlXT71y0y+TmRmrF8uSc+Xqvgn/nzppznikphlLZBDaYzhpmammAUdCGfwWMJJPECWwB6OUZNZeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2055
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

index b95c4b2cda947..139d2468f5f70 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -29,6 +29,11 @@ static const struct snd_soc_acpi_codecs rt1015p_spk =3D =
{
 	.codecs =3D {"RTL1015"}
 };
=20
+static struct snd_soc_acpi_codecs rt1019p_spk =3D {
+	.num_codecs =3D 1,
+	.codecs =3D {"RTL1019"}
+}
Missing semicolon. Please compile the kernel and make sure no error before
submitting patch.

+
 static const struct snd_soc_acpi_codecs mx98360a_spk =3D {
 	.num_codecs =3D 1,
 	.codecs =3D {"MX98360A"}
> @@ -78,6 +83,14 @@ struct snd_soc_acpi_mach
> snd_soc_acpi_intel_jsl_machines[] =3D {
>  		.quirk_data =3D &mx98360a_spk,
>  		.sof_tplg_filename =3D "sof-jsl-rt5682-mx98360a.tplg",
>  	},
> +	{
> +		.comp_ids =3D &rt5682_rt5682s_hp,
> +		.drv_name =3D "jsl_rt5682_rt1019",
> +		.sof_fw_filename =3D "sof-jsl.ri",
Remove this line.

> +		.machine_quirk =3D snd_soc_acpi_codec_list,
> +		.quirk_data =3D &rt1019p_spk,
> +		.sof_tplg_filename =3D "sof-jsl-rt5682-rt1015.tplg",
> +	},
>  	{
>  		.id =3D "10134242",
>  		.drv_name =3D "jsl_cs4242_mx98360a",
> --
> 2.25.1
>=20

Hi Sean,
I guess you are using Chrome tree. Please use the for-next branch of brooni=
e tree
to generate the V2 patch.

$ git clone https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.g=
it
$ git checkout for-next

Brent

