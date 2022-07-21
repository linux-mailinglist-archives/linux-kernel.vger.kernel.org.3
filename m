Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF0A57C573
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiGUHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiGUHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:39:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9CE7CB4A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658389164; x=1689925164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vpM4OPwDBHgFiva8hywp7uCWJSAdfcMFD4jim8UnjE=;
  b=ZggKIM4Ig5kbiRYlSLv8eEfGokKsxTxmtSOFsCMM6JaiwDnVYMsUDmVY
   iIl2dIzwwWG4B3/2ueBLBHYtACmAETUWo1mooFP+QBW8OTqJpwWMFLAnt
   WTPmjE3qXr7VIDC90goUrR386bhnYXTUEmQ3G/Tzzwnx9ZbKyoH+stlJf
   EybJ2NO/9cvDPYbiFqHbiWwcv9N3Nbtnu5fM57z91iISC29mHqqJqjd7/
   SQem1m6gbfubGOfUQiZMeXs8psRWe4tnwKHub3op/Bv37ybeHH29ukYYN
   TMwTHaUl61A7HpOrwMnp685AWqFMqU5jXGC5pqb2wByTzQg7U8dfyKD9Z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287725741"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="287725741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 00:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="844324446"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2022 00:39:23 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 00:39:23 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 00:39:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 00:39:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 00:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkDIsyp5TQveYi8fDpH9MTpz97LINTG4hdH5sWij18rJ7N1Ljc9OBLIWiwFNHvcWZmOY8y44ljPv+PrJorJzLPGIhWPlR50tAkK86MrRHUNW2YL3uy+l88qN+YI79W/TFHADESlGIGu8xdUkIL0tXBqKMd9RPKUGIHv4+ffMVU/wo/I6Y/ogbESZqBHUpq7Dixn+p07WaojwYnCOtsHrv+SKgNI7P3k323qR9aaY0Jvu+7PovwyqpmY2YM2b2TfFfh0856xC2TjF0YxsIucC04WvC5Ski5Ca6kfpJ8Edf3/VlKNLQNYl7XSQYYEHOKQR1/+2benjAiKFUYFylZkT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n+a5SEv1ewDqpZxHaKCp7462VryaR3dPROZioID5zU=;
 b=KtWsNmUip5h/dtjrcEDJlHFfejUCCyM6JIE2WR0bmttQ/2tYZwrx7XQhdkM1IsioIzldM6Z9dqHFPakD82Ie0d5oPkKYlkhKXYe47PmtiPN1aniHwR/qcl3FjeV+nqL0vKUJnwAgaiLpTjYt7vQPRJXr+UXBM6f+43iYrZB7NlnxcgyOCdkqD1TO+XETRCz65NWAPdB7aFD55TTGDXxGjetbXo67eeewACM8I+SsYd3x1ec6w84B0cWE4kVM9zNuhlNOGLpvQ4lKuoyIzZ9+HN88WqfO8BIDbYyfHL7LpiiO3v9OkeYajfzMI/WJFCRcP+eW00ela6yEU4iDI9DOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY5PR11MB4356.namprd11.prod.outlook.com (2603:10b6:a03:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 07:39:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 07:39:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()
Thread-Index: AQHYmwJBYp2710JQ30Cl1E4c+WdJBq2Ic2Jw
Date:   Thu, 21 Jul 2022 07:39:20 +0000
Message-ID: <BN9PR11MB5276287E75395A59865812978C919@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220718235325.3952426-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220718235325.3952426-1-baolu.lu@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: 4a9cb6b5-c938-4f42-9aed-08da6aec1fa3
x-ms-traffictypediagnostic: BY5PR11MB4356:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NcL7Vmaur8Hu7B6p7rFpdNdEX+kRaLLEcRozu5YGLB7BzOfdtDrAVY7tz8wUGuhpgYA5iQL7PPlMWUMIuFF7hp8wrnHzpeSxv2EsEir5HlEPjCmUdraJGjSQS8oXxoMNfwuoT5O980k/495XyK6z1p/lP/HYGOHvH35FVtx8nkuZshdbxThJUU5pWFboSGSRseeqzf4CNnnF9d15BF2khDSee0ykKQeDAGx8y+jZdPV/YevkusLmkp6D35tisIjOnmausz1lqG51BoInaiia7CbwT98VEi2keBOysHJHZYkePQORENsuvSIyNjokbkuax1TEHmc2vRLqypZbeRCQhITW2/vGNhfShaOU42jyqEZ05mMW1z8DkV6LV+oYYnirS7HHFXrf/FDS13LA8+wRnGSY+ZW7TyCLRFxU4RXQmjNWxbaByv/sbHIL1d7xD4FQaLcEL/umu9hVtpYPckQ8Eit3PkD7FJH6v8wa7aATgBFjyJQOK3tJvPhcDpDlxOeNbCSSbWPP97FuSJrZidS5RVd2XbMn1bM/PTBgojKUluKNRfhKlxGX2QgSM5hWXKRXHz3kkjZXtT4BpdNb5VOdvLlqgCulMok2IR+oEg2ivzRYKr4E0Asy2xt6cexOZUYB0Qo+bLPUZy0Hga/Ug8/vXrOBQ3atqAbRXD5bU35jHplGHiHx6qHNFCnDpZxmhMj3qjRSVEPXkUsJvcOulWmdBGzD7yVOHSHEJT3lHxdtDPOsTMe26U+P7FmtQRQEj76Xxw7EcbgqnS/7ewZqxTsCtDK7Wr8vbZkf/FeQ8A5HS48fIQikky5p0GETg1nB9oMV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(26005)(5660300002)(6506007)(9686003)(7696005)(76116006)(2906002)(4744005)(8936002)(52536014)(478600001)(71200400001)(41300700001)(186003)(110136005)(38100700002)(33656002)(38070700005)(86362001)(83380400001)(316002)(4326008)(54906003)(55016003)(122000001)(82960400001)(66556008)(66946007)(8676002)(66476007)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UczuaSUeWW4seDaSFDpo2z/B/pwAr17VHewfoYbi9s6AbfBNsLufWpUmjGFV?=
 =?us-ascii?Q?yBOc0pGEhKmrbLfw/NulQ4dw/Sl9DgPwDYbmye49SLa6x/eSmz6pst5ruCht?=
 =?us-ascii?Q?Ak9Qi4zkmekqPAFN1iwpyP0ga5ulhCgyBNLMmDfxNc2N1xowR1yRTSlQBcFG?=
 =?us-ascii?Q?IvN/scLklJVFHbX7R5uNI8h4IoPd91/V+0fVOBAIUzchDt80VCqnXRPimje8?=
 =?us-ascii?Q?5LuHvJdzgqV9odvIBqLQv99DwZn+SB+R9mihXMZMMhBZzar514/6rLki8/jV?=
 =?us-ascii?Q?m2WNFKXF+yc46czRTPU/lAJzw932em6orjzdYqsZqsVbkPxtl46JawOFHWXh?=
 =?us-ascii?Q?SBQBlgmVPlp2ls2RWA3vYQeyeRtLKrnuNHYiAcmMEORQilDGHU66r1x2zzST?=
 =?us-ascii?Q?ZIL7jzx/ZK0OGzPzONGCI5aNLTM6bl4rxderWOGw4RBLrY2Tb7Bm/94EJ35s?=
 =?us-ascii?Q?sFwQ5eraxzJ0JVYBUoWd93hIBuobHyI6RR0t/FYrfCjxiEScurrE0S7yYPkN?=
 =?us-ascii?Q?lTSNsgrtxt85jD8+DdySHiBUVlj6LiSM1k8Yy4F48GQzERmx0f76xY4gKvQS?=
 =?us-ascii?Q?X3hBLiIyV+aEVbm4FOfuZvOFqDGg1zEmVi8xZMMSrPSQy8rgjFqO5encGfIN?=
 =?us-ascii?Q?CLdgGzVlul9QtzTnJWlomul+KPrvEsfYJVum+s2hrqwIhpmOUykY/+DORVrY?=
 =?us-ascii?Q?Zi2rNNwRH8XOas6GICilXo70VWultFvjCkbXVKeqhBfrd/1UefH+3gzarwBx?=
 =?us-ascii?Q?CJF0j3dYiN5OZ6ujxkQmPooFlT+S7QYIQh2sIPl1Th8qt7EtGFg12u5QuGF8?=
 =?us-ascii?Q?muutxa2KQaUP6wt9acmk5fZ29b0YVlikrU1b76yJykKUWRTKebic1ZOwB2Dn?=
 =?us-ascii?Q?5xG/jCNFEal00kHJwrP4+RBU/iYCvRn3xpMGmaWUqxMY2AqAdv2d4/eKjwOC?=
 =?us-ascii?Q?aHTrPlVHKhTdq8wQmsrqNR6aTP6hzNR1ap67m85M24ZKYaE9H/ss6lRlmX8s?=
 =?us-ascii?Q?wsUIJb6X/yX2wjs3Oemk0IxO4TeR2JSf7ZE1B4yCnTA3x3Q/DXVkN7l9kFmF?=
 =?us-ascii?Q?4b2xmsrR6dY5PMPUyy71XiNH34yxJLrcFsdrJ716tcUT7vMl8umxGj/WXOUA?=
 =?us-ascii?Q?4ZrYhVM0Xo35y06LEcXsHLXMbXE/SImQc67qMifviqbte3ZdCi6zGPkReG4N?=
 =?us-ascii?Q?+pnbkuRTwNguzRwjYAzr/Wc+Uk+znpQbfwgxkZD4FCaSJmFGKUI0E7PLROYW?=
 =?us-ascii?Q?b89sxz8AvKn6lxCdVKMeRDmiuQOLNyuH9mZMuvQZgV6iFKtrJ7Cx9Ws1wtjt?=
 =?us-ascii?Q?3A37fvJkg27vnT+MDC6SSJdX3UK2NGXDcbn6xPNCFMj7E8Q2G8grmJuklpxo?=
 =?us-ascii?Q?XW7ZOHGsT+KycysPCZMbQ6lqFIOwUcgGV57rzZqDjg9yFDdBW3tXtCAEgxIU?=
 =?us-ascii?Q?rZk3x4Oa+zKcRuqetlHDhl7udAHz/7jG/XxcmMDspMBqJ55434tR4gZXWvhM?=
 =?us-ascii?Q?daMJHbYplhjgKnTPCxAQDHNQhBrOLkN0Z1eqgTp+LGUL/QhUCVX4nlKrgzjX?=
 =?us-ascii?Q?95581DntkKL89NwiELe1kBNpQRmdjEtIhQjXg0ZL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9cb6b5-c938-4f42-9aed-08da6aec1fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 07:39:20.1519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSomai0NcG7zSV/kHE/Cz51qgKVZi7D8nvQ52yChPHoKjiuHY8wjurYqajHVEfuIBhE6q4kxoYzBoyJ17ifWoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4356
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, July 19, 2022 7:53 AM
>=20
> @@ -88,7 +89,8 @@ extern struct list_head dmar_drhd_units;
>  static inline bool dmar_rcu_check(void)
>  {
>  	return rwsem_is_locked(&dmar_global_lock) ||
> -	       system_state =3D=3D SYSTEM_BOOTING;
> +	       system_state =3D=3D SYSTEM_BOOTING ||
> +	       (IS_ENABLED(CONFIG_INTEL_IOMMU)
> && !intel_iommu_enabled);
>  }

intel_iommu_enabled is 0 if CONFIG_INTEL_IOMMU is not set.

same for other similar checks.


