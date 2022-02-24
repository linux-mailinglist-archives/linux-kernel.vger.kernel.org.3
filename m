Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885B4C318D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiBXQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBXQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:35:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE41E5006;
        Thu, 24 Feb 2022 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645720490; x=1677256490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJcHBIv5GtzJ7UFp/EHGVlmJY6Fq7yzDCkR6uBrWNjY=;
  b=NSac/zQVqMm6Qx65h5mF+s16apJmrHm5VvRCNoLqUS/vjIOQREpCLDB6
   s/B5GrnVkdQ5BSjULu8YZLs/NhuD4ge4GAE11Lttavy7j9e4GUILxUyEi
   Z0+f5UyztoEmL87BcY38kJschTmwQ0cSr+kdoSsvNCyFU2knSQi8Lk4kG
   sYLlNXFYV4hKOPOHnJN2Oz3J9biQydsbPeRscnbJRnxGpegCRIegK8pdN
   7AUtFq8AVlpq+AI/4HHitdWjjhVQeKrFMpEVZglN2Jh6ucihb75NUNaek
   qTjP2BOdUbEBrWWTLw2roH0tkOLf9/wTIa6InF1ShMRbWCGtUYzpCmR/R
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="338710256"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="338710256"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 08:19:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548812952"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 24 Feb 2022 08:19:56 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 08:19:56 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 08:19:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 24 Feb 2022 08:19:55 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 24 Feb 2022 08:19:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0mWl4btNho5uGuy6/2sfVs9XK3DYDOpYTH+6/YJbn/HnY7dgLsYPWU41E1p9Tsg5a+CPbo9KajU1qcKVk/dUHCfvT8FB1fo1noi8+oAHqaCXipfiS5kM7sNAt0Kt76fzXNRObRtycv1OP3zbN5DvbX9ZvL3IMqpRMkWZP9Pjq1F505S+oXa/9y5J2fsGbEZHMFHzqc9bGt1WNZ6NM7S3SRDMRa7dmle9mOXRJfpCM2yjbEdPOViMAHgQPi6DYSl5r9fOiApSlRuC/3yP/aDjah2xDTs5jT6xU34xrnKVk2htdXPrRXmNAg7Vh9RUNAW4ZhWYu0Ni2yuEEKQQ2fI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi3dVeCjvXtFudZ3K3P3b37oxoxa7GIsLUhceXXBz2Q=;
 b=Nxch7tZbnUGb3V2RiRxbYW7e8iCxsVxYIqj9H0mFCQ3cxbM9R9V3R1Ds58Mob3oHL70sDAUA4HFKrW6GlormM9ASdP8C0E6kMWlTJah+SUmxtCaQSYdqLxUdC8XQn29z2aITHZut8/uPegkEPXrPtB7WrGSGo3Z4q+kOL7CndEyD6Kmri24y+rDpTjiDM5J0306QpuvMvCxJZS2sCun4ZVWvTaaPlxK5O5xGtZ8C7r71CGScT5Zh0gtJKV0MdaFPZq9nmjnFzvFcxKNetBsJvXf2H9aTJZ8+jRKUcJxrc9ClPJ27+qZ9KHA13+AI4asruWmTtOqmLVcLP5qMfKXqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by MN2PR11MB3549.namprd11.prod.outlook.com (2603:10b6:208:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 16:19:53 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::910a:a800:65c2:c366]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::910a:a800:65c2:c366%5]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 16:19:52 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater than 50 ms
Thread-Topic: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater than 50 ms
Thread-Index: AQHYKXMVEnTJK3a8GECkhoN2wlnjd6yi4XkA
Date:   Thu, 24 Feb 2022 16:19:52 +0000
Message-ID: <BYAPR11MB32563DC0413B8595D1339B37873D9@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20220224113807.91771-1-pmenzel@molgen.mpg.de>
 <20220224113807.91771-3-pmenzel@molgen.mpg.de>
In-Reply-To: <20220224113807.91771-3-pmenzel@molgen.mpg.de>
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
x-ms-office365-filtering-correlation-id: 2edbc282-99e1-44b1-26b2-08d9f7b17d1b
x-ms-traffictypediagnostic: MN2PR11MB3549:EE_
x-microsoft-antispam-prvs: <MN2PR11MB35497314C5E59439DC317303873D9@MN2PR11MB3549.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMB8WFTNiYJINuWLMg1fy06sc7VAT1ObZiu25LkbLOGatgZdmYcqRyJ7bltMKEKhhlzTt+MViRD4Pl60T18d0wP++0GCKhOuiDVeLoGpt3gCn/WvL9haEUxSnIGSPa2uB7zWs/mkpHDBCQ3lpz2gUuJ05BSrmKeMQWZ6j3Gv2WzA/hWGmcoB7tfD0HkvBiPvB8L4IL/6qYvZvzXCnuhh9bxIgIhNXLiqmJQxCLPL5LRU8UgTTRGAGU7YORmN+YtKN73gk+9/WB417LUbF2/JUeD79Tf6S0nwNHJlgCT+zpTWpg3mW55UITpzxUqR0cGrbnAndQ3LC/SsFM7/bPYJt+g7vu0ZjDzmEOf2T1C4JTlja/gyN29IdmF9+ldPIccX+4wKYIF6ytSDgmZ6CjUa+rEmPRjV58CzAUoVgXfUrRMtNT4rJ612YF46oLa5uWIqleHPO9C//ohOmwCVc0JEREuLLMPZ9ipyG+LEIWpTaYiXbdiWdK40VS+xTQrhRCHBH2pT0qJ/QNxVGcOm6OOd7zUzLGraW6b9QVxjD09q3XvtmkNJXL2FGhs3EPvZABrrBAI1DJOIPdsKP/J4OJp/4SJxVZO2nHLEd5P/Hv5/4t3C5+r514JZIGUHBGY1I7i4nHfUwF1j3UBsK1+vsy5cboyqTBvcF1g5H2O6qw7jfNzP71XhsqzBobf2QamO91uqu2teqHHVtGkMysKu+U8p8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(26005)(186003)(71200400001)(52536014)(316002)(54906003)(38100700002)(76116006)(8676002)(66556008)(66946007)(110136005)(66476007)(122000001)(86362001)(33656002)(82960400001)(83380400001)(4326008)(66446008)(64756008)(38070700005)(2906002)(7696005)(5660300002)(6506007)(55016003)(9686003)(508600001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CB95+ETv7+diOXFWLSnj/enLGAdoBHQAKd5p3Mt8f0rCvvPbcpGykERtohNh?=
 =?us-ascii?Q?5zFVflGojk9vcfllNhwTmj+8ocQA1ll5KhvNUD96nnA6sIkeK9QWeJqki+B/?=
 =?us-ascii?Q?bzym1wYlxAViZn7N9IzslH0pKf2ekPhkuqoZ/ocJpRv5FVtdEeRnpG7RG0Qw?=
 =?us-ascii?Q?L3K8cqT9x+q71HkrNca2hRDPZUElX9s9d3jmswtKhB8gUqdX1sApPb8W2wji?=
 =?us-ascii?Q?hfFaST1VCyaM+7Cjq4UVgzHEMwepnGzc/7dXut7TuKdY7wfOu6fxCJeaGLzs?=
 =?us-ascii?Q?0Vu6gXmFg9YA4BICyqshjh6x7DY3vbTZGYv8gfLxiIq+slsqUPoG8ws6rZE8?=
 =?us-ascii?Q?OBGnO5S8lkXuJjayb8sw2/4mQvEaeCCn7PXK9tzCuR9I9OM45HYIH+2JLtYi?=
 =?us-ascii?Q?oqOIjUPKf1R/Hf9LH/MrE/Y517F7GCvwZA5LZ5MlLx/+byi45FlC7u6uSsOi?=
 =?us-ascii?Q?hltqbmh8/oL2zh4PcjyNa2U4TQuO5/Z09LNfpCRypE2Su3E/Oy7YW2zfGgKE?=
 =?us-ascii?Q?8HOTJ7yz5mbYb2MJu1fo8RdA4FZ+X2EQEkpwvkJWLlPdgUx9S29wO1I/5/au?=
 =?us-ascii?Q?UO/Zbt2yMj27lJ5LByae+Am1cPLIp1MGZmxQXtrmox/UznMNC64Hdyu1kxQR?=
 =?us-ascii?Q?ecnUcLIj4lcqwpD4wn1xtUEXaxYXsQrYQB8ZE0xPq4sx014PGhOoCXTJaDom?=
 =?us-ascii?Q?UhgHUJArcStidIpxsLAdGVnBIHdNaN3Lk+3wvCYMItxzx0TmR82YDkjG9n2S?=
 =?us-ascii?Q?Ff2wsdHK7IQ10mTwKCqLNXQxLtUUgYSdmmzX9uCatIN9c9COhutms49bFDoM?=
 =?us-ascii?Q?1ECrPybngqRC+ygI7HTLX1p8lDtyBsEWitEAwewtujWZpJzrB3M2De7NXWcM?=
 =?us-ascii?Q?uYvWwcguFY7PTSQwlVsZ53e6/lBXIQZCptDSaAkJckGZRP0J/WpwmXctRMu2?=
 =?us-ascii?Q?TdBRv/FFPuB207lyIxgMf00ZubFNpxNTeUVM6dAZxpMyR7lbiAEDOVqe1DfI?=
 =?us-ascii?Q?Jo89eq5n0VMm731OzyYK/Ao9FBA5+B7s+/sYOuemRrbCBRHPKlOAw5gVVF9y?=
 =?us-ascii?Q?bAqsrzjWfdP92AhI8FkzRwIP8PJTvvMmiTh2q111Q4TA6gyS/0dhLNclMCIX?=
 =?us-ascii?Q?HIum3PJpoWmULoBaszU1+BH2fJM/IaUfSnhhsbPjpcf/IJpyA5qfUar4K8Ok?=
 =?us-ascii?Q?CjsPr73/vB2EgJxNN96bT+w4RW3+ixbIs3voFCpFVv8LIGqEA+V3B1J2Z1pc?=
 =?us-ascii?Q?8C/0LEAfLD4QEcDmRwhrkxP/GzHqdZRKWO8t8t76RCsbaFehpLXRcH6hlxJF?=
 =?us-ascii?Q?Q6AfykCvuCWq1pXiX2PnXHLo+dGunaEXG3S1sc5Xr0WqUrWRZioEUwrBlbHt?=
 =?us-ascii?Q?g1zvjIydN4EugqO66lvzX6iU3aJ/5bB11xhBMAIBhi4+H1gK99wDnDllGpV5?=
 =?us-ascii?Q?8LO8Jg4FeJJ5Vb52sdgkBqVZRySmULp/aXNwQsKuu2qL9VVcQeaUrmyykHoT?=
 =?us-ascii?Q?/8NDxJcOaclMvV6KeZtOvDk1BM8sE7fNwdqSfNDrnwAdMSu94RSUPtTSWQJM?=
 =?us-ascii?Q?aF+ToRH1H8DpKfBkjaw7XgG2XvK5lwlpZrubFHNkqE8XCwFNdIrHbX9ArdXc?=
 =?us-ascii?Q?/K1dS+vW10pFc7NekpV8voI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edbc282-99e1-44b1-26b2-08d9f7b17d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 16:19:52.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+uvRVFlIveMFmXbSDOzhclt+BXdpLcMfeIFiJLr3SG/8sIuJXCCW4aFTSzgPlxwWmsa0YUSMP62Gu/f3T/Phw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3549
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

So, this is the current implementation:

    /*
     * For compatibility with other ACPI implementations and to prevent
     * accidental deep sleeps, limit the sleep time to something reasonable=
.
     */
    if (HowLong > ACPI_MAX_SLEEP)
    {
        HowLong =3D ACPI_MAX_SLEEP;
    }

    AcpiOsSleep (HowLong);

Where ACPI_MAX_SLEEP is:=20

#define ACPI_MAX_SLEEP                  2000    /* 2000 millisec =3D=3D two=
 seconds */

-----Original Message-----
From: Paul Menzel <pmenzel@molgen.mpg.de>=20
Sent: Thursday, February 24, 2022 3:38 AM
To: Moore, Robert <robert.moore@intel.com>; Wysocki, Rafael J <rafael.j.wys=
ocki@intel.com>; Len Brown <lenb@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>; linux-acpi@vger.kernel.org; devel@=
acpica.org; linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] acpi: exsystem: Warn about sleeps greater than 50 ms

Quick boottime is important, so warn about sleeps greater than 50 ms in ACP=
I.

50 ms is still long compared to distribution Linux kernels reaching initrd =
in 350 ms, so should probably changed to 10 ms, so people are aware about t=
his.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/acpi/acpica/exsystem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.=
c index 00f66af31ffa..bdffb8aac05c 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -167,6 +167,11 @@ acpi_status acpi_ex_system_do_sleep(u64 how_long_ms)
=20
 	acpi_ex_exit_interpreter();
=20
+	if (how_long_ms > 50) {
+		ACPI_WARNING((AE_INFO,
+		    "Time parameter %llu > 50 ms. Please contact firmware vendor for mor=
e responsive system.", how_long_ms));
+	}
+
 	/*
 	 * For compatibility with other ACPI implementations and to prevent
 	 * accidental deep sleeps, limit the sleep time to something reasonable.
--
2.35.1

