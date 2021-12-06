Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A1346AA84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351829AbhLFVgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:36:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:65134 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351840AbhLFVgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:36:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="234926649"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="234926649"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 13:32:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="542550178"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 06 Dec 2021 13:32:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 13:32:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 13:32:31 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 13:32:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFQfTtCV2aMyHBUM2VRXr2Hw6N2s6mMAvd3WZHqOZxrqBeuy5Hhthvg+x0XtLIu3XvCc9cT7hK3k5jkxM0AirKqyz4lwz5W2kBcNv2kecGJjlhRFKVqV8H/mA1yl781EUG+t7PFyReLCyA7eMY4e9gc0dufWjIUY/f0kfWQ/YeaTEB0spBwZ73zb8FP67HO1pW8SvsIfZDuv7cUk8+xksKfUwd+4craodqp8DHvJTTWYLu9jQKCvBX3+QnhtiILLaC5CbteHQcM1D5pVS1KUTxmLyooh39pnU4LsJvkEZQXUPi9nUQAhyeEMhDmSkUNb5AvLnR9tLXdBF5+LsU5+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Rv8DKbGFiRCP7+JkM7ruE1N5uWc5qewvWU4mVOPEDQ=;
 b=cUmmK0jFuth7qnZriQc6LJhWi0rm+YpTXdtCbeQ6HnAhTmim4qycevMlUWLaKwmL/MUeagqK6ltTiSdTPrh28nAu0GrpwQNMGGEW+yAWPjrpNjsjM1u/iSJ3AA27kzjVKuE1R2avbRbyOK65KxyT7nJ1c8OhqpQ7//sgBV3Z7Ucb0F5ahyLqn+k68y6GILN1GOR2vWtQqZSsUrvb4twNW8E+L9Vl8dXLLMdTjBb5LKc5ceYcrutUYEpApmqEFPxr71GBHTL84ctYPxdlzd0bE5Il0YinPCrz3bt8r2bhZO7ijXtYIEFsQvILaVbPOFzoyalyBYHfjZ9eFpXAq4pNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rv8DKbGFiRCP7+JkM7ruE1N5uWc5qewvWU4mVOPEDQ=;
 b=JBYn4Dsh9is+TuJCXaRXbD0YcYZNuUyLZLj97cyIWgL436wUUYrOM3LPh7B2YKVQi7nE5+i5S5dzPPY9Yf7uKU5iWJFu346LpaZElmTtPJxakesMaBFXYF6YEQJ7jqJKw86Da5V0XhXHVH3aGXsqJwcZSJpuq3uuCx1ZdF1BE68=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5015.namprd11.prod.outlook.com (2603:10b6:510:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 21:32:29 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%6]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 21:32:29 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 11/15] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
Thread-Topic: [PATCH v3 11/15] crypto: x86/aes-kl - Support AES algorithm
 using Key Locker instructions
Thread-Index: AQHX4W/kZoA3rQNJf0mSmN0oRVVbp6wfTOMAgAbBxgA=
Date:   Mon, 6 Dec 2021 21:32:29 +0000
Message-ID: <92B42C5B-ABB1-4CCA-ACD7-3828DAD0FE8E@intel.com>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <20211124200700.15888-12-chang.seok.bae@intel.com>
 <YajWYuwFAy81VP5t@hirez.programming.kicks-ass.net>
In-Reply-To: <YajWYuwFAy81VP5t@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f77a0cbd-4d3e-4a0a-93cc-08d9b8ffe7fb
x-ms-traffictypediagnostic: PH0PR11MB5015:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB5015D6E086682A37497A8009D86D9@PH0PR11MB5015.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5uYCX7SsflmLmXdCFmTxz27pk9ErW37ijYv2EM2rIhg/QtBcJtLFXLncuj1nkRp88ND2eP0G5n0KpzGDtZdKeJUyGJU9N2/scbq2pXKzsU6rlA3iiTeM8TwChEBiNxJE7S+NFv9o6aEiXl1k4NbXp7xeT5bPuxs/iuQPw5jypiHWZmE3yGTYDfNB6SV/tmIVzwgoSaD5PoVt+UMPt9AurFuMw1lJZd3ykWQgtKqBsGUoo0Cyf8tdMpAIUjH2Sy9+oVJPTScgR13tjLm92GevCLME3J04z5lesDemtiR4KMKS/JSxTBlK86IDaZ2VCvFgffW0lj+MoUVwQjV72AiPZkg7j2CMeKV+hvI+5xU8DhGQDPNh4esK1B1C6yKv5zwShehoqszieQrXxzGZEdZO47sbama0ftbkJaWjt584xpTK5RL87WxxNVTeMdRdLX/WZxirWRLxPs0Te/cDYiBEawE/k+muejq+wWFIFQ/BNlpTlBvgM5Yls+grNp3y6tibqxfJ7hw7VL3V6oC+ba7Qk1GNuOHMxkIr1gDkAk3WMhfg6EtGzXdS8+ybkVPDavGcAXqQ1VO4l5SF9eCwXYc9Cdt4jfxljTmq+XNCoyUzsWxJDzbQQlIeqoYWigV7Gc5GT+fhNxKEpBB1QAoqDUo6RkEIfjiDMLdJjIaivbpFpmZTw4aU84BNX9XjNt2u9eeX6K5o5DKe4BHm5lonqaLA55m3XDYB4wP7qrsv+vZNifIe+ql5VE10gqvIfwu0isVf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6916009)(66556008)(6486002)(66946007)(71200400001)(508600001)(316002)(53546011)(6506007)(36756003)(86362001)(64756008)(82960400001)(66476007)(7416002)(76116006)(54906003)(66446008)(4326008)(186003)(38100700002)(8936002)(122000001)(26005)(83380400001)(2616005)(33656002)(38070700005)(8676002)(5660300002)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TtbM2vDzs0JkbJdm8AOM8OAibEyQiW8eiMZNivIeAB3t8IK+WPeRLS0JyOh8?=
 =?us-ascii?Q?pGLUQg3P8rPnx86RSdk0AnkS6VDslPPR11etS/Lp0ph45MB9H/+pk72QX7iR?=
 =?us-ascii?Q?ScdnpTmpv9pu+6O+SQcy9dR0IDOUBIZ99pEq9CYCMnqB5U/ODBIF+DLDlakq?=
 =?us-ascii?Q?U/LxGSXAKPltzvbKrZUG/KkQfL3Xrq7CAMnaJ20sPRCVS6xtBIGRsv3g4VM7?=
 =?us-ascii?Q?FN3OaliXM6p+mx18nXzZWGkD86KTpSBmbz+9ePxhQZdX0EFt7ITFaJLgLNuM?=
 =?us-ascii?Q?MxyB4oTy6JJxa9Y6LHful8fblpNUYIpoTqrv7bFj2ZDt91He2YUnEnTTSAFb?=
 =?us-ascii?Q?/CgaFUtHoKLYTsw52jnxwD80R8gwcQToVUnJT2eb851IaMj8ohFkv2OllstP?=
 =?us-ascii?Q?HGaNG9rS6fMk/cNPoWFFvo2CgBVBKzGEPdBLSbQQbFJj8qVAMJZ/PZD+cWdj?=
 =?us-ascii?Q?ZUv1DkWvRdhavT/e8jXjABxghHBGA+WZlT+AA3h25/BZnssx5eoys2JFbKhh?=
 =?us-ascii?Q?D8gjByQvMhHGljU4W+p2mBRyQ4cLck6QhGGPGorn5XM/yJULPbsIjjPxHMmf?=
 =?us-ascii?Q?l0WPjartc5OOqlXGdf0kVJnDht11Uu7qSqXfW1ZWeQj8OER8WB73/RRUICti?=
 =?us-ascii?Q?cNDFBfG+HD5GIMxFSvkRq+TO8R24k46RbL4rRzVWu8mdCHFMGalavrTqo7Ze?=
 =?us-ascii?Q?2DlL7FOWOV2kuTqL1wqjh+TCi5EfcdUwUWLu61vVu8ZlCNL8GNZIeIN9fPU3?=
 =?us-ascii?Q?neBBVvzDaIaMu7C+MnK9vpOqNoYSwGKNLe4Gypd30FCUda5DAW2GoRQOQUqb?=
 =?us-ascii?Q?jOt/XWsVlbyYiJ+iPtiLxqaa9IbvpEzkFIm0fAOJAe8SN90xY1MLdFyFQ9T7?=
 =?us-ascii?Q?wX/7pzAonItS9W5TwVv2sfKa6380RSQ0GavrzqgDdZBfkQ2Li2Vaior6OQU5?=
 =?us-ascii?Q?vleH6GETjyqk5A2ZlO8Rkyx1YkhvcdLh4VXqhHUizTo0yfnbZUawQt7tW4Jx?=
 =?us-ascii?Q?bLQrBU1gObxQzvGyz4KIQPsgGNwdBIR/hd77G/szY3v1xirWSNjuXJo10l3m?=
 =?us-ascii?Q?3RG8KEPfBuEc9lJozcmnAdudGH79EEH6HJZSDLsEeFEd3tjvoe0pkB22OZKc?=
 =?us-ascii?Q?PGalgOhRglX72Y3HSYnkjDc6a+XpqHvZgxAHPoQNBOcVebR3AxjA9uLTe+CE?=
 =?us-ascii?Q?y34/s0SAWNpfGhoUs9VJK2VeYnihV585zYdaE4eePG9gtavGVcscDVSs2rrf?=
 =?us-ascii?Q?/ifpusv/rY0BW5XnCpChWFzLy2GKSbR8I/t60j5Sl2QWDtaBSipIJTDiN8/O?=
 =?us-ascii?Q?xmw6Hw2zxI+roPTu1ESqGeJnZuNOe78ky3dSj+8HaACvGlsdbUr6R1TRzXo2?=
 =?us-ascii?Q?AaUcEv/X1d29sSCD+nNwWvi/GczuMxpTQYtk4JN8FwcQeYEeZP3dgHyR5JIY?=
 =?us-ascii?Q?/i4byvSSl2gDOdgy92B8xNEOuu34bK0AwztqODi63KCqmSqPDBIkqWgjOTZ5?=
 =?us-ascii?Q?UcM8lahtB+72x69zAUKcFVgO+Ck4r0mQ+P5qAk6poHSpW2F8OkuY68FEd3pY?=
 =?us-ascii?Q?C2tg9UdjG+KOWITmlmoDL0t1q0RqOeIT+cVsrHE19RC5H26DrmbNcxEqpvP+?=
 =?us-ascii?Q?4E57R3WVAxe9Xd47zcihd5DVBrG9O7tFUuMkDyHBfiDEdAqPeNDV0bl6MpKx?=
 =?us-ascii?Q?KNN7GUSMVKeJYiXG+PqQ8CY1OR0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD0724AFB334A34CAEFE1722204BDADC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77a0cbd-4d3e-4a0a-93cc-08d9b8ffe7fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 21:32:29.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doK4Aknx+MhEzM0GbrxooW5fIJf9n9Rhncjua3dBRRMiDOYymFh2c3mKCXiQnOhv2jHqJH8pDS8rGu8BppcKbgM7sCZqJ/qxZmwVASyuvHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5015
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 2, 2021, at 06:21, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Nov 24, 2021 at 12:06:56PM -0800, Chang S. Bae wrote:
>> +	encodekey256 %eax, %eax
>=20
> So this thing uses the fancy new keylocker instructions, however:
>=20
>> diff --git a/crypto/Kconfig b/crypto/Kconfig
>> index 285f82647d2b..784a04433549 100644
>> --- a/crypto/Kconfig
>> +++ b/crypto/Kconfig
>> @@ -1113,6 +1113,50 @@ config CRYPTO_AES_NI_INTEL
>> 	  ECB, CBC, LRW, XTS. The 64 bit version has additional
>> 	  acceleration for CTR.
>>=20
>> +config CRYPTO_AES_KL
>> +	tristate "AES cipher algorithms (AES-KL)"
>> +	depends on (LD_VERSION >=3D 23600) || (LLD_VERSION >=3D 120000)
>> +	depends on DM_CRYPT
>> +	select X86_KEYLOCKER
>> +	select CRYPTO_AES_NI_INTEL
>=20
>=20
> There is no dependency on the compiler actually supporting them..
>=20
> config AS_HAS_KEYLOCKER
> 	def_bool $(as-instr,encodekey256)
>=20
> 	depends on AS_HAS_KEYLOCKER
>=20
> Hmm?

Well, LD_VERSION reflects the binutils version.

But yes, the as-instr macro looks to be useful here:

+config AS_HAS_KEYLOCKER
+       def_bool $(as-instr,encodekey256 %eax$(comma)%eax)
+       help
+         Supported by binutils >=3D2.36 and LLVM integrated assembler >=3D=
 V12
+
 config CRYPTO_AES_KL
        tristate "AES cipher algorithms (AES-KL)"
-       depends on (LD_VERSION >=3D 23600) || (LLD_VERSION >=3D 120000)
+       depends on AS_HAS_KEYLOCKER

Thanks,
Chang
