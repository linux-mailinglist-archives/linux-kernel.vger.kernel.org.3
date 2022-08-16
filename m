Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783D15955B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiHPJBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHPJAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:00:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832805E65E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660633890; x=1692169890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AHQ/QaZcdP2Wrk7md8trE7wtrqetlf5YAVd3LgauJBk=;
  b=i/W5mfjuuJ93WDmt5OJ+WCRVAA58LWQwTUahfx/Oe2lHoVzhLv1Iez7V
   NLrmaAG1T2oVEzsBOc2/fHFFC00cMyEes5eCQsW+WcwQWf8kXYHQsyJDZ
   pIpJ3AQf7MWSuRV9O02jF4syUEEy7uxxRRRCMF0abm+WyHNwPqn0BBjgz
   nQnKOJuP/080nySzqLTDRdfO917ha1ysfwgqDhu/3BvnqVKCxxTa9t8jY
   H++PNAs0TUXbzTeN1ZdGO+eoIQA8rkc3AN9AHGxe4TRNcanbud9g9WuXW
   btNUR5U1NDWxAmnruaG2mIV690OV3CVQvtLOrqWZCg0/BNnBHEVdbDl0t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293417692"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="293417692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 00:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666988899"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2022 00:11:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 00:11:29 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 00:11:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 00:11:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 00:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKOOobz3lUXRTo9gPannaGr0NNf0859zzbJIB+slpSARkYbVYnolJ8cXKOqeRLPQJGlDp2UsKGumhGBddJNLDDAWMBiQAXzLnHx+rJceulbPYdolegdqksS2t+PBs6HQuSF6lFmnIeNWQKpd1snRv9JGQDFnQq4jbpYWLJ2rV8PUh+TenpZOcxhgu7ZAIgEYX1kpmTYQSgr/z6niygzsuRIdx4TF7dBfQaMzRTQBdMcglQx4oBR52/AvNvimuE4yk/q0e6C3/SilRjlaPRiKF9k7/Xc7EAipTjm52zAuJE2oKEz4C9b0C+Yfya+I6aykZfAmjLgtZ6/m3S8a623diQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHQ/QaZcdP2Wrk7md8trE7wtrqetlf5YAVd3LgauJBk=;
 b=DFhbTC5yEYTE0AE5U21m/JOyfPxyWUd++4I9vGJqKvwjxXUbvMEknZa2H6CEPbFZf7eL66OFwPBcZbUxoVdaozhzDyV5miHonN5NHvPOPAKlWuJgHpe+a+sx7dasHxvmQCDqiU1KLw4HuuAcE81QcLX8zodzjelhdBohNwF4byqqfg4zttRnZwas+9dvBSgdi1fi0241mvQH1PuN2qBc2ApiY+iRaZfng7+rk6IekJyxuTz9zpUjkEFxwIH6apN6BfwWT5CL2vae80feF2lV4ERxJHXQP/NsCjHMjc0VzEnUSDE1MCmE4g1JCYgCVYPWjjlcH4sZwoxXLms2oFxUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 07:11:25 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::cc41:b741:dc2f:182f]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::cc41:b741:dc2f:182f%5]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 07:11:25 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Thread-Topic: [PATCH] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Thread-Index: AQHYsTYaOMjdpEyOSEuDlN0oiWaO862xG/Cw
Date:   Tue, 16 Aug 2022 07:11:25 +0000
Message-ID: <CY5PR11MB62570BD5C5BCD243BFA17F56976B9@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20220816060437.1115039-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220816060437.1115039-1-sean.hong@quanta.corp-partner.google.com>
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
x-ms-office365-filtering-correlation-id: b444e88b-e1e9-4601-0720-08da7f568837
x-ms-traffictypediagnostic: SA0PR11MB4656:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pbQW76A/aXml3/YRVTe5o/a43Zt7g0GIhwCiBRa3tfncIyhdPsfWx0ijl8J886+E5dtOmuMk6WUsgnfqwKxTVUa1V85oJqjlhm23vRC2m3fo5BSTT8XCYH8i+NeqKCmtdPCdMhPydIcKZzSGsUZmmeoerZj8sdVbaGIN28O8pqNBBAst26R+NAEi+sHE2n3KppDpsZcYtQISx1xFVYD0qYVL88XkRzKDEx2FFZbSNJdk81Ojw1ivVn5ad92MNFYA9Zp2YhFUwgtW3+gPiOV1j1T8zH9TiToIqvtaPnYkHkAXVOzlR6S4B2mWLzphDIYLCyEkOeJiyYCepNK+oVlAG7VH9i3P1GcFs9iQdHmPiwjmJq7XURVZrtP7eTiv+6Qs/5x00gU6yH3dIDk7pxAcW1ae66dbKbvNrS/1KZVHwzPCI/E5VzNRK2AvYthypnzzZDczz4i8rrjWABW3xy0EVbwFZobgV7s1SZjcYtx+uyVutCRIopI7XkjxDpE9LsQNGV6sYkg3yBsmLiDObWU8bCH+ImUV5Bqh3Jij/k5kyZJl6GhCCtd9N+v5RhS7Scb4IzaGT29ykvi5pwRgdyUurdAuUquq/P34fAf2ezDgBhbDLtesRR08tpKffRAszQS+IoRoASpRBzQ+5kcxMoJxiQNuSej3aYqOmw09W+G+TN5gRNVQ4iumFg14mEaHb9FmNn6DwybYxOzySucngNzFPk3MqKAQTQ6JFjhnT2BnU7ZTgDx+vcF90s7CSToH3aHjrL4lXnsgZRrlwOtIfTcQbs18xkNHLUGHUdkyS8IAVYVVH07ClEh1p/JnyRWz1Dx6W+w6aEdb6aAdKrxMQckz6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(376002)(366004)(110136005)(55016003)(54906003)(7696005)(41300700001)(6506007)(66946007)(64756008)(8676002)(2906002)(4326008)(66446008)(66556008)(66476007)(76116006)(316002)(186003)(38100700002)(71200400001)(26005)(38070700005)(82960400001)(33656002)(9686003)(7416002)(8936002)(86362001)(478600001)(5660300002)(52536014)(558084003)(122000001)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r1mkqk8CszluUAMjfkWWrCOZIzB7r6rHJKCIDi+7g9R9Inb5EDha2LlyBdnK?=
 =?us-ascii?Q?IVnS5NjoWQlrKjdj/T2Z5kIqm32F3sdDyk2sVM2sAvpAsulfeqYxbLEX+hc4?=
 =?us-ascii?Q?7fjJmcXAD3zzfpTOx3PCLXIwuIwwmxXECqHzu9ML0G8lpN7pG+laE0zV4HJ3?=
 =?us-ascii?Q?xFqAjI11eGGQAOOwBXsQOIQbBFbTTc+QSACn3y0GhI6ZSoWwYLRZWRO89Zd8?=
 =?us-ascii?Q?mVi9tCwZ2T9q0FpQtsmhvbWc8xZ/xh1WXeQ9RkEMGpTNTo+lSoxKwW7W5zSH?=
 =?us-ascii?Q?zC8Ezd8mxvUFA728Ky75D5+H0f0q7NNLcNlo5lZcXo7OrURTd2h3A5PUxHgy?=
 =?us-ascii?Q?H4DhFFDAhhRcB/ISoxghy2b9qtISExyXyYfWvSweFJmpHlBeQ0PCtHo42fma?=
 =?us-ascii?Q?Tf1RapE3e9xqeI80gDYuWN6rB2u+ekz92s1wAa+HwC5lU8glVRGNPPNAoetb?=
 =?us-ascii?Q?US6BpuRT4AvO0Df3a47fy1LAY+ie1MGCHfI9phJOhFrwaltfh25NomHZoQVL?=
 =?us-ascii?Q?3DGWcHpcuDO33LUeGLibyeiFEpMh8AdB/nRgC9BGOQgjxHNMGM40lpX1OOK4?=
 =?us-ascii?Q?363b1Lc2Dwzyu0/bByfbpBne6MXesxuk7onoAU+EFJTSDdXDthpzxHWo7M/f?=
 =?us-ascii?Q?2+wHr9mHIfkEmzaIkjeGhXe5tLmJjqdIqdEtK0jYO1AM3UwJD41uscsIpO7l?=
 =?us-ascii?Q?Fs5ocvlsh9qAM/OqKbZjJmIme/B4VytggM/OJqzyQ5fbaFpCsmbpoIU5h2Gj?=
 =?us-ascii?Q?np5vjeQc7j4LCKDRh33cNww9LSw+qR4zxf34qRNjformXfkhCKpr7A5umWck?=
 =?us-ascii?Q?/6d19Py73nVbVsMlq4RaYkdCFzTHkyvyQFwpRyo5nfHWDD5sFJ3qwWv5RrGK?=
 =?us-ascii?Q?hRgxipYC8camy1uyMQjWf81WMR5qsyDKoAUpm4cHgbfqeBrabPWNpquLSaE1?=
 =?us-ascii?Q?6u3yeuiVsMOVjuV6cl6XDzTwj4xLmHLN0fF3QTqYAjX7xzk+WgaYvHSHQocl?=
 =?us-ascii?Q?VnQ+SK0QCu+GGphiDR5b86VT61cdGekvVnCGDR+Y3MZ7GM1pkAUtD9DRZs72?=
 =?us-ascii?Q?uIXH1zQHLOAC/eob4t8b2yOOMoLvaOoPSvV95tFIHxwtnO9anZSgmpjdsCJ6?=
 =?us-ascii?Q?Xvy7ZQAe1SG+gToO1Wvokw/stQs+VCQ6MeN2NN/GOsxikjwqQlSwem/3RtDV?=
 =?us-ascii?Q?biBYMbrb4o1wmQ5DwxknUipnJLiWuh6V9HVqAqCUvm1j3PthygAzan6ONx4s?=
 =?us-ascii?Q?FS481PxOBtajQoip4B1Hr/W9SS4WEUZq1KBsG977UNVI5qfAOkECTLiOxrJD?=
 =?us-ascii?Q?NZguVNo59FpiMrFXul/sc2I5ZXAh1EyvINHQY55oPQGJXxbI1v8BGIQ5EFPS?=
 =?us-ascii?Q?rP2XuaMkUsNQhgacGTxtWsTRd4lB9zHa/YO3sVJvIEG8PZzyftYGBlbIWLxT?=
 =?us-ascii?Q?PdmhDzX6xe4Mt6zhFfGigCyaRd1L1gnf+yCIhIdU/RldLlu07X/ZBxL0d4cI?=
 =?us-ascii?Q?K1a5ZloOJAuDfnc2HiA6rjGTyaRIciolJS/myXgK9Snk4HI1zKj1R8o9PKMY?=
 =?us-ascii?Q?WNfGOnAEaBV+XXo6z5k9rieFaLmMZh/pMpvE60op?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b444e88b-e1e9-4601-0720-08da7f568837
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 07:11:25.5256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfUWNJUVIPMCO0bZXLLBBiQgmB/z8G0QQ1wGrIdyBsMCiDxK+F/q9K7W2OJkX10/I1q2j9U1+kZEUOrjXVI9Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

Please add prefix to your patch. For version 2 patch:
$ git format-patch -1 --subject-prefix=3D"PATCH v2"

Regards,
Brent

