Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97B562D4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiGAH6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiGAH6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:58:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A653C1139
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656662289; x=1688198289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3nisnvAUuOKziRrMlTEc4F2bP8gO7W3jxmx9wxUqHKw=;
  b=VXN+fFbgoJinv3E7X/wxUqZKu57KrNa8Vx2iVu+S9fVEMSdFTOrqQWGF
   3r5q4QKbMI+VMGzT/YuESNNgANopXAxvbyM2wR1xD4LTu/wrKvv4YYAMf
   lgbXz8Ayzk+fugFWGB6+B48GA7b/XpbnYls62RvEfnHOltHxnMgP6Rp/a
   ZPAndORvlDq/EE/jTSn+HjlRXPNfrss3cte+FOEksIy9QQtMbLd8MeZp8
   X2jmYtrw4RKdtbmF0qurSaPRVZ84D/NBJDJV2L+E92CxaQJ26YX0wHCcj
   NuJKUr0oR0NkrQ/EN2+eBwI0KucZD+l99YTU8uv8pa2wD14zYvtFwOHgb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262984038"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="262984038"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 00:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="589211850"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 00:58:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 00:58:06 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 00:58:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 00:58:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 00:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCVzucikdVXpoqZ9X4uH/PrfI1p4q7gU7ZQRgnqx+jg4AGTCD9HL5aosZ+ZY28Y0t9LmZ1TqNl/8+kPIjjj1f1rNVSqIkMzhBIT8ORnqtjh3Rv3EKvIqxnQgqBIPa9N0oI84AdVDQGOg274oYNLIE3DDi+HrsPMGTchFseGocD3DXZ6BscCRktuNEAOJHwO53eH1f+AUB7RAiYr5B4oJQ5JJbBe60H5Q897BX7PywDP7AhbrqBtz13WgY8Rbm6JtpFj92VzjoOWPrpxENnpqsL968AkbdVKHdEyqhKyBdNrYiUeApvh1lL5GypvuOfOPaoHasocyipp2ThS/kI6KoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nisnvAUuOKziRrMlTEc4F2bP8gO7W3jxmx9wxUqHKw=;
 b=homXA5wZSAmK9sr62d4+f2IlqKJS4YH5j7vkNTgRmrNa7c4X75QwsSA75jY6Fm8aIMgwZ2MSppgdmj4zANZZkeF6cghj2qpkNwiZqKtVcQZEIrjodLL+kLyaS30Fd8SdJscRzgV0uehucEmpevZdzAWx+OO/e+dSngBAcisYTGMjTP8/z3KN5z95doTusH2WN/VJiVtVRzPDbsp7ejWDaUIFOL51dbF82Kf7H079psFAwPLtw+swexgmEDFDUB19Eq/yIeaPwZxWOat7Yw7sJn5XFtL66e6KaeXKNI5mwjf+jLr+djtl/JPHd8jToqoSqfDNI6j8421hMSN0vxdj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2943.namprd11.prod.outlook.com (2603:10b6:805:d3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Fri, 1 Jul
 2022 07:58:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 07:58:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 02/11] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Topic: [PATCH v3 02/11] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Index: AQHYi40eeQ+35kloMUmgddwM45tICa1pKOZA
Date:   Fri, 1 Jul 2022 07:58:03 +0000
Message-ID: <BN9PR11MB5276A0E52DB09F5D338CEB998CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <20220629074725.2331441-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220629074725.2331441-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69a1e241-cf29-41fd-984a-08da5b376ce0
x-ms-traffictypediagnostic: SN6PR11MB2943:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9HXVb+fK/qlIIUjdP6TCiKzh2/bleFTHNyuR4Jg709MZE5E91uLfB4n+2/W2ooiNZ4q2MoNbcaeS6uMv9Gel5Ox3H4bAiAXZ3KeYrfqddORKpk4cB5J1nur3248Tj8zfo/gKeIDOAQtufGQlfSV1pAbvDPmSE9vxRjKe7z0NVDsCAh7JEmhxjC/x/pvOsopAkHIG72qq8Xi2H/EzbK/jQL6i+vVzgXwPsD5vumXhvjNjuVW3hiSbFffCLoHf5yQfIFggGUpWTCvKGHBDbN65iYY05eCp1mxA/gLRW8CPS/BSpzGvoUHlw/dIr1BEyJIWtR0/gGZL/XeTMhPoFvWD6DLnYuTHiX0CIPVota53UsL0Vgqn3XaFO7HeKmnGAfnbY6Bgq//8ogqNZAoqXjuEEClTS9uDjypaWTj/IIJIudMzvcpkBc+TOAoIQa2GcvQKqV3i28QBmTHlAsYsNNKYYKnN8E++1bSPJ+k7kkwjY76RorbD56Rc8h/23MEY71I0zbK3Mxm0/IPL7+if3XuVUcqYKdKc4i5sUcdVxGQg69y700S4h1I5wgZi9nW/NF5HHif+/hJKPx+c8RwcdyO62+cnIOc1pYmdAfps97vU9yJ7kZb+1+9pkfLRwzl+qvJqvGfF5NTHFz6c9pBDB8vBkD1a9GPMcZdQVbyaNyBQ9OtSyZ1Sp4ehH5JBA+OtlGoLUp2BpmaoswqlSHzGwJHnPuM7UodOlW1/xlWm1Q+JpP4ab/a2gET7DbUFGpgopEennHIik6pMRBn8sPHwh/z5FLso9mkyXa64ZID/YbBoWP76ugBMkIPlcS/BkvFHRAi6uDyQJJi017Iad+cGRX0UbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(52536014)(7696005)(2906002)(26005)(71200400001)(9686003)(82960400001)(38070700005)(54906003)(966005)(122000001)(6506007)(478600001)(33656002)(110136005)(45080400002)(316002)(8936002)(86362001)(38100700002)(66476007)(66446008)(66556008)(8676002)(76116006)(55016003)(66946007)(186003)(64756008)(5660300002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iA5qgbrQAxyEJrXFo1hxC+trthFMWqszIeMG4DWBK3t3zqQRiRrWs4bNMb1U?=
 =?us-ascii?Q?cZCCQjT4vsI/EHNO1NsHaEMCAw+ScssfJDSJ0C5zvEMB+J5W8TrSmpELBthJ?=
 =?us-ascii?Q?EVwsOUURx5Hy0mkYe5fublQkUQiXhrsqvC9QSmmgANeTQzZ/we2uTr4S8sih?=
 =?us-ascii?Q?HdZAQ2pvWSkV0whw/2KB/XKiK5KfXaqAeLPRIOeuSJazJcmf/cDzX22taGYJ?=
 =?us-ascii?Q?MWLwS3AojvH0gcJGLF8XnNuJg+Wq8mwPTzE+4sDUw9QyNYcKEbFNrqfHnG4Y?=
 =?us-ascii?Q?mt6rPbpSLDMnqrUHUobzOOGSvOcQIVfSo5FDT4JatNTOpcHewwcyNlhhsoC8?=
 =?us-ascii?Q?0Lk9AXhV+Y9K6cSbc+pdyyqx0JuOqa99u7G25uVZ7NEIQbqCR3fYiFvzsmqk?=
 =?us-ascii?Q?T+dpNKaMNQgmreBOkF+Jn47tUlh1JjDIKvVvQXmf11JPQA7k1cHQoQVDo5P1?=
 =?us-ascii?Q?voa+iWbVIHP7Alhc/Ibff6SsTTjhZyiPyqTJ/g1lJsfV7N9VWC3imTX6CDuR?=
 =?us-ascii?Q?2xlLXROmL5nm/6c25u0fnxgrUwITcbog+GF9d2vRb6+YWnYNcKjapmRCXX69?=
 =?us-ascii?Q?QPkHojT5nm+keA2m3cm7+kF1MU5fMm6nynXARAHBdcsl2r/QiIdL+h32S5NV?=
 =?us-ascii?Q?Yr3P1OtTZ+si0Ui2jA6jlB854nqgzFPGAg06SoVN/qlkuAlCx4cS8HsHFXEa?=
 =?us-ascii?Q?fpcxLNy/F7rOgERuXxGbbvcwG9hGDahbt5YxCtdJXGtgKvE3XxB3gup9MgM0?=
 =?us-ascii?Q?nLw6XuXJzjD6AdcI1Pat/Be2z/mgTqxpZBrrzr/bnrEr2Jlllg1DaKCXCIcb?=
 =?us-ascii?Q?+zHMWfqRGxdS8QoPHpr7+aPeF782FhZsAneqHvMgJYPvq58tEIFdU0m2XN4M?=
 =?us-ascii?Q?3uhgS4aJhCsZJsK+8GxlcCPLlA0O2MCXnFzr+dD6OKp6G8ipJarqSyZe6h+v?=
 =?us-ascii?Q?debMvzAr6Zx83BqEWbeFLtvAmj6gZmKP5fDB4WjKXZHJKZDbP8D+SKsTUL+B?=
 =?us-ascii?Q?5bvyv4CjHV96YS9+FeDEwuNXMdjARh6MVhU0R44znoLEcCyNJA0kPmhJqZmk?=
 =?us-ascii?Q?ZO7klWQhrwmPQHyI6WGgk61HFYtEuKUYJzGHR+Uca36wE0Scxc6YD2mCKY+u?=
 =?us-ascii?Q?NJRA/01HxMNhriHoDg//Dlwd7fGTiY+H0aqZ6RZBfVE+7GU3Cg4Q1h30ZTsx?=
 =?us-ascii?Q?1VU++J/vzDniZgTZgX98IOTHlrBTg1tcy3LW3+nGRqJmTGc2bWSdBGFC6f+6?=
 =?us-ascii?Q?scRWyfrwH0PaX+X77TzvMle/y9HzryaXVH8MkZmV723VoO8s4tqCJZ7ekwEP?=
 =?us-ascii?Q?9mYORe0a+9i/YCxyAC+xYO9mLzQ1hBswQnMU6doDdvs834kBY3FRJcMwq+yC?=
 =?us-ascii?Q?ZElq663IOJGLKNL0Y9Jfj36IpjLGdBfwdUUuUvt1RRUITM8UVW7wDj2xrGqJ?=
 =?us-ascii?Q?gHd4eynVm1Me7Uy2o+JOWSHS9C/GoACmG8tqvYeeDv8R+ICzbZR4P8uxXUbs?=
 =?us-ascii?Q?EjA7UPv863pg2gTEetmFEmzAEjxJevFaWKa5UZwUD4RLpckKpn5h2IT+zLxq?=
 =?us-ascii?Q?+MeWS84jS1LIGG5gwu3/4LMBdKJkdxFh4Qb8LLiX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a1e241-cf29-41fd-984a-08da5b376ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 07:58:03.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/leBnY3UvaBweGHYMGBaQi5hOPcgTaR4ahtSAYoCSCGmOk1hqcyij8CLhZs17x1u+3us0zBRX0QsYyvdyWaUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2943
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, June 29, 2022 3:47 PM
>=20
> The disable_dmar_iommu() is called when IOMMU initialization fails or
> the IOMMU is hot-removed from the system. In both cases, there is no
> need to clear the IOMMU translation data structures for devices.
>=20
> On the initialization path, the device probing only happens after the
> IOMMU is initialized successfully, hence there're no translation data
> structures.
>=20
> On the hot-remove path, there is no real use case where the IOMMU is
> hot-removed, but the devices that it manages are still alive in the
> system. The translation data structures were torn down during device
> release, hence there's no need to repeat it in IOMMU hot-remove path
> either. This removes the unnecessary code and only leaves a check.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

You probably overlooked my last comment on kexec:

https://lore.kernel.org/lkml/BL1PR11MB52711A71AD9F11B7AE42694C8CAC9@BL1PR11=
MB5271.namprd11.prod.outlook.com/

I think my question is still not answered.
