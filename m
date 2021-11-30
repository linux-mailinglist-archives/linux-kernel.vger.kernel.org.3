Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395E3463DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbhK3SbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:31:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:53730 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239420AbhK3SbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:31:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="260250765"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="260250765"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 10:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="746815539"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 30 Nov 2021 10:09:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 10:09:37 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 10:09:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 30 Nov 2021 10:09:37 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 30 Nov 2021 10:09:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3hXX0uMWlnhtMlYFxESbS/JSlA96ogOyKb5atz75eOW7FhpZFzxmcAAMou8A84ijYHs4ciMUEe8au64IlloPYXla1o6FYPLYWzHBqZPiv9AWnnA4BzkCD4iST5mUu1/m8sgHIdsFzwaz6P0fOLit6GwMRUptkLgpb2laR/d0KxWDWDGwXapImZxCXBNGE/TwKo608LvQR9/C7J+8QkCqZMnwLQTG4sGgOmzmxtw9feK4R3aQJO2UfzuVdIwXsxquUqG38mTvHPKqxoZCTh0wJVa20wo7gyA0WT1uKBaYgPOZPgwfBGg+PeVwIBZ37Mkf2UYeEeEgUjcNIsoiFNPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOtrB5CGsdpUApoj9ilf+OKNIizmyJX3CtnjCo3Q8Vw=;
 b=HORlEyOYj1NDov1HYYXFsy3CLO8TTlj0sWKSwmKpKiGwegOrsNpCcW9IeaPyGYXkuDopdz4c9Kg+rVrpKi1XSc/WmTXLod1cUQeG2IfPTc7lMsPP+4BdYsuPSkn85pvxcAtsTvxzgC5guaTEpkuocPOKk8NV50Ur1lWzpAKyXk+Z5Fa0lYsQMhZxYVZrhyn8bF3Hb3SC4BJI9totY4LGeSpAocm6hGvpVXtOLmJg3e1iF4lV25sFsvEI7EN8x2NtL0rJVjHYOD+dFRBZjqOl+yIFEQ6SRVQtaiHlgJymobJkwn2mE6H7J51eaw8ynpM9s+Ir6DUhRhkURo82pxwGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOtrB5CGsdpUApoj9ilf+OKNIizmyJX3CtnjCo3Q8Vw=;
 b=BkdGZmgx+0pejgxCZmV5Qm1KKTdh42dr2kkiRltkUUAGM1U5iFMHJzFMPLlN2uPiHqZ20pyRS/H0j4tYilumzrUXStDWaVOh7cMPy40X9nOfDrZFdEAzRVC4EKp5Q4aOFE4Qg6AjmIh9Ij4/sAZ3SuugCtQONKlWxlLa3IyhgQ0=
Received: from SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18)
 by SN6PR11MB3422.namprd11.prod.outlook.com (2603:10b6:805:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 18:09:36 +0000
Received: from SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::ec60:3876:66d4:e910]) by SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::ec60:3876:66d4:e910%7]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 18:09:36 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     youling257 <youling257@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Liao, Bard" <bard.liao@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "cujomalainey@chromium.org" <cujomalainey@chromium.org>,
        "Song, Gongjun" <gongjun.song@intel.com>,
        "guennadi.liakhovetski@linux.intel.com" 
        <guennadi.liakhovetski@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "Yang, Libin" <libin.yang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "malik_hsu@wistron.corp-partner.google.com" 
        <malik_hsu@wistron.corp-partner.google.com>,
        "paul.olaru@oss.nxp.com" <paul.olaru@oss.nxp.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>
Subject: RE: [PATCH v5 4/6] ASoC: Intel: soc-acpi-byt: shrink tables using
 compatible IDs
Thread-Topic: [PATCH v5 4/6] ASoC: Intel: soc-acpi-byt: shrink tables using
 compatible IDs
Thread-Index: AQHXzOjBYSRv9dPRe0e6JGpg2MQwH6wcgtKAgAANz5A=
Date:   Tue, 30 Nov 2021 18:09:35 +0000
Message-ID: <SA2PR11MB489195C0C5AD325DF30D6B4D97679@SA2PR11MB4891.namprd11.prod.outlook.com>
References: <20211029171409.611600-5-brent.lu@intel.com>
 <20211130171841.17277-1-youling257@gmail.com>
In-Reply-To: <20211130171841.17277-1-youling257@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e0d8a72-d987-4d26-69e6-08d9b42c9166
x-ms-traffictypediagnostic: SN6PR11MB3422:
x-microsoft-antispam-prvs: <SN6PR11MB3422966A0F04D512CB37503597679@SN6PR11MB3422.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+IS/FRN1ugYsMMW2hnv3hEkVj474sMr1Bdv7vI/8BnnBQRzXfWE3WGZPEExtabwECmr2aZftwkfh2BwtyZ9lioWBf10veyZuXOW7fYvVkH4DVOWyMoBasi7sZL6YfhxZl5ZHCCAvY0doQMSbxGd3GPjtLZMnet/YqBqkKTcSvWvKZ2R6yYU46cLngXQBW6A/h16UIzMgg6CR7FRHgFJ0j3Wd3MA6jUA6Cal+d6JfYaiWwZOe4xkkD3o5M3sokNWoM8FggyXzPCdYcmK/bzxDXhRinaiNcPtOJewiDj3y/6/Gs6g18dmLR+2eNY36N1HJ+BJ0xaNX5Wwnc1yPFlVvtZb2vxnWDJwibjxOo7vru4kduNc0VGsUO++YtH+Q3HSZAyj3yCuTgBVwcAsI4gQ2FxeZOxjir4FW+Oq1/okQaIQQVTqcrIygn5q4itPMtppemIYR0U9WWmOgwF16uwRT7RkJNbbE+WJCZCkaozbltyeVLvPVIaHtrLRC3LxF6+JLZQiMtMdO//gnTu6SOQrSxPk9xBzSpVXdVJqnt6k64IVn9/ofKPzkuavJB32jzBFVVz6QMP7guOTdNBO+GvyAxW4j8JG1ZAigAM//8BKRMKMvL/Vrr5EnJAoKY75wlsG6ysdH8Z1I+RJYVLo2N84ZEdM6DrwUxwf/BqoLWGtes1PGhR0W7zi3GLSOq+a2woHKQNeH1TrRm/FrvQU+WyiWms88VXB+IxJn0vYUw5L0nFXyNkVVcU3sjAhuKVxlMxrLXaDi6iS+jDc+1lC5X/RPNk5jq2G5aUXLc01R/AXwdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4891.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(71200400001)(54906003)(66446008)(26005)(6506007)(33656002)(64756008)(76116006)(66476007)(66946007)(66556008)(186003)(316002)(8936002)(8676002)(38100700002)(558084003)(122000001)(7416002)(38070700005)(7696005)(55016003)(5660300002)(4326008)(6916009)(9686003)(82960400001)(52536014)(86362001)(508600001)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F2/dpXzoIDyjT98/cQ35PFQvMhze2GoFGSEYAmRt4OnVzGWzLIMsgh7K3K20?=
 =?us-ascii?Q?frV/ZwS0BsZkzf4Xvz/iCLrYGaOG3c65r/ZeQJYUKkWoWitLsuyA+T/ARYuw?=
 =?us-ascii?Q?Aj59GHsrLTWVNhrklwLWnUbPURuGxYNATHKIahAgaXrKXJqxMuUTYCAaNxc1?=
 =?us-ascii?Q?ObtMPHoypql7Ip829hrJtOs3Wo3TqyewvfVDmv+vPSXdraxHTIPOnzLKsHib?=
 =?us-ascii?Q?j8EmRkHlLz9l0rCc3j0U2R6BXPHJqJo9e/sALtFwQxjqEuuSdI6n2EyWVYmw?=
 =?us-ascii?Q?UajIbi/T4n4IiYn3uS11LeDoi23TVQ0gxthtoe1mXNw7zpgBqKuYNdHfiaNK?=
 =?us-ascii?Q?+QVcGejnG6y+f5ewMnk/kZWx5l0l8rP2ceihg75B5AV/OhiZntGHxMae1FJU?=
 =?us-ascii?Q?nwF94QUTVYVIGca7Hs2E/Cg668+X8iFNkURwvdo/p4hANMWDxrUb8jjhN7Ig?=
 =?us-ascii?Q?vEqm83DuhT+tMR3kQqOoXcVyczJDHZX/+0ymCqyOy345XoDYvgxvNYpV+LG4?=
 =?us-ascii?Q?z1eTYr6Bgw7+9L0DX770mkc0eJ+KdsH1Na4hN17HJ0kpSot9QHGS+q78dYoZ?=
 =?us-ascii?Q?udBrYBGsnVNVKbpV9kCLsKtxC38TAVLeUyB4QVu4+zuSjiJiLZpuPqZHNiMK?=
 =?us-ascii?Q?IQqvnNs79R2c5L0FmMsp8VazNYzqfG+Gi8qpALbl9vRO9Ty1izbKNXv7SyvQ?=
 =?us-ascii?Q?zhu9xH7HbD+OTp3dK2bGlGM/6kaY2SEyNxAjEldXeUYEu0154TgOOkOaPUEH?=
 =?us-ascii?Q?KgNItZ9WmjNRdpl+XhYll8Ptg2nwqzR7sZpvSc5ft0PPCWGPKSNMOLFgSIcN?=
 =?us-ascii?Q?hqn60rfgfX2E+IPPG9Kq6nDVy3+LeW/2ZpFRZ614T65TZobks0OppjVOZQVY?=
 =?us-ascii?Q?9MI41MeKGu335/C+1DrftuW93Tys8i02v/sK/Sab64GDuS7yir67beOGBLAc?=
 =?us-ascii?Q?RFaRuWv5qnmvTLHyxqw2zzIUAAARSMi6TuCW+GQ7hFjeYNKgtEGwGOHPrXQZ?=
 =?us-ascii?Q?PHE2T5dGhScQp6QMpOZZ1Ojd66HUNrVs3QKjY3VHP+Svy0dLfcRIuHjo8PO4?=
 =?us-ascii?Q?dOhCihngUdMWtLX+vOQJDct8T58bWNifoDObrp707/aHH8diT2ZaxuY4aXZM?=
 =?us-ascii?Q?/YEdHfMkAPJUK4Bmi1nWqtIDmZOIkM9V8Fn9YF8QLpGbS7rsP4hUifRmrHk+?=
 =?us-ascii?Q?kSl2xCwEWlEJ2/f4UqlkAqHQuLe27T/CQjyicfCYbS3tc7MgR6+eevNt7/E4?=
 =?us-ascii?Q?64WX7wHK/T4KbmB9kcgjI+Y1kopPWEW2H5arcORo30wdFFTPNZPqyOvJwtkw?=
 =?us-ascii?Q?DjyI4jdZGn1f/9mXT8klb1kJTJKy6/XqZwQnFhgXz00c52SCC9fmy1iveKqU?=
 =?us-ascii?Q?pMamb4N7Dp7fGMNR98rildDRT0dKniJY4O6UoRV3Rusethi57qb8SwfPEuVn?=
 =?us-ascii?Q?aVx7ZSPL0AfIcOXQS3O/7sqec2wIUEgUHc/IHAIPbzIcpVO20qylol4FOwGa?=
 =?us-ascii?Q?T7PcbRnZZ6x6K8yS5NQo5P/Q+uc1fM+8JGLw5oyMnk+XtiShPMHQP/UaFFs0?=
 =?us-ascii?Q?wsPyyAaBK38/1p/F118Z3TbGQ2UcqVnyYRXJdt9RIkPZWSvKL/G4x0fip1qR?=
 =?us-ascii?Q?Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4891.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0d8a72-d987-4d26-69e6-08d9b42c9166
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 18:09:35.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2/v460cxRoIcx9F+7pjqZUWf6NMcJiBmv8ObisB94Sfd9Y55kL8sGUVcjraDUi0MzkhRjs4nyqewseYrUvqvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3422
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> This patch cause Bay trail-CR z3735f tablet rt5640 no sound, bytcr_rt5640
> bytcr_rt5640: Error cannot find '' dev.

The fix 28c916ade1bd("ASoC: soc-acpi: Set mach->id field on comp_ids matche=
s") was submitted to for-linus branch.

