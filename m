Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1F462D31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbhK3HAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:00:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:52521 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhK3HAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:00:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234881993"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="234881993"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 22:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="511397127"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2021 22:57:28 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 22:57:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 22:57:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 29 Nov 2021 22:57:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9DhUfyvIOkEQPDKw5KyysZ6aV9GBd+xITpYiaqY7H8xDqBDh4X+Ul8VmpEIcoiqDG2xjSeOh220PL/pseJnKzAygf86S/ebzGwQOqjKoDLrASp8hKgeZDDCvJq+jVtlt/69UT35/qyVuHvn9LVmFlDUQF6nxe4a/w8kiDzWp+a6YM2PbPcXr4cQeFpAFIhaHSBMgZH7V3FuuM0yDIW0bylH/1uj3dPF/FTDltnIcQrdtNTTnWn/+ho8aDPRuNqBS1QvNidrbRgQAzGxIa2DNe/pEbfg82+g48k4qyQb0Wyk0oV8nvihecAvkTuCQoYhakCKAG78KAGb/locbXwKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lyByvWvWRh9nfhiCFov9b3kfIjN2Y21s4P8HBEtUlQ=;
 b=XOZUxXI794DXeIPinU76zrWkxUSPfiT/aaaLxOmeoYXbDkR1q5FS98oDXKXbxDr5WU2nUmTpahWAT16Fpu5XLlV8c60cNDEg2DR2tfQLu4ZcxcycNOtFi5oN5NR431q7WnzmYqh0hPRHxWR53iIavvIlci3LD1nhl6P1vSWR0Ojbv1xGBqVSCNihxtOtgxM8PmvMwhhn+Vrdo1mQ73G0vLg5u9+E0+HtBecDnOqxkcO1LA8A0YpeLou/xZIVqyYCkfODHMIsqz/NBXFaNFZJ6LKnUin+odLcZPxgRzhPsHlcWI5k0AsN6d+SH7qJnvpK/ZeOPs+6fjTmGE6mvpE7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lyByvWvWRh9nfhiCFov9b3kfIjN2Y21s4P8HBEtUlQ=;
 b=zOCuPqtDWxXQGNS4cmThH33mB69R4mWIXdpsZjprGSpyJgXHnca63oXzsaIIzHKee6E+MkHGJ72DstJGVNxTL41PFCpgI0skkz/j0N5KxOFiIuyi7J29h2S54QqFpkcn60kvlou7Z7xreiUBOHUDQePOmTuYFtcKxULNCKUooog=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Tue, 30 Nov
 2021 06:57:22 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 06:57:22 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
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
Thread-Index: AQHX4W/kZoA3rQNJf0mSmN0oRVVbp6wbd4YAgAA0pIA=
Date:   Tue, 30 Nov 2021 06:57:22 +0000
Message-ID: <011B53ED-6D9E-41EB-834B-8A64485DBED5@intel.com>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <20211124200700.15888-12-chang.seok.bae@intel.com>
 <YaWfKB+k66MzNtIi@sol.localdomain>
In-Reply-To: <YaWfKB+k66MzNtIi@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3d55da6-60d8-42ad-84d5-08d9b3cea895
x-ms-traffictypediagnostic: PH7PR11MB5817:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH7PR11MB581765619DC536A1C97A3B62D8679@PH7PR11MB5817.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: czIz/pZIesTl1R8/IGfe1IsOd5XJxYYQvv5PZINxb3xKQvfPrw8ONOb9u2SkNzZrUyXuAg8LMM2wPMOnC/NzYi6+nFOKDclt0AYW7qQZADHjQLZMyFBOHDyaAfN58v6341V3TSVifFcUCnfBvbFWXKS2q0IIEC5Z7zxgYokO12FoECELhWuz+KrUroPsdbk0AO/jAQ7CeYbGX9Kiuk7vL08vQK1e6QokF2vvjHjS1X51D3X2NZG/ec4DhTET5JpECNRVUuVkPtwMKWTw93WvOp4SyiKN5IX2OtPUrXSgXiqGMEn6HKa3gslTlzHbZmMg8QtkSZcEZ/aasc+VbZN4RJINsQL4sw21DmZPwcHwGhk+ZvybQprKDp/d1xfhl0oB9sI6dowNSsE08mmZr6A/NhtOHLOh0Aa9H48OaSgsNgT2gIPLJZm5Hq4HiR5vHT4CRj+mbbdmBUYkqbIMi1QFzWuxj02l3YQlb8qYc/h4X8bNEutCb2FlPTbfQRm1RW7Tp27LJJBHTeaLU0uXjPAwFhu3+e8FDpmSQWWta2HdKlhWW2vXwoWEjFdWzIHKP0lNYmzZ4sxkshVuOjwgDTDwRhQNwdzWLMjYgt1h0vyIIV9I1d5wQloGxAYy2q6GnrqGR9BOeMy9TrZlLULUsrkmkEMl4NoFkjBi9g0AmvHWZb1Ue4fM1D9lrzpIAb7tO6Sv8gq6yzN5AIW92kxUKQaIfrqauy1RmGDpHh04rfFGTK/kyL1ODdRgr/XuQvqLSth5a56S0fz1LUC5Phi2iZK2EGbOp4Pi5xTZi3EnG9yGj4aeER06hWd8LhsttdXLP6/Fw8QjfUOGN4FL7gkUN0Q6hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(82960400001)(8936002)(316002)(86362001)(38070700005)(4326008)(122000001)(66446008)(8676002)(66556008)(54906003)(66476007)(64756008)(2616005)(7416002)(33656002)(6486002)(6506007)(6512007)(66946007)(2906002)(36756003)(71200400001)(76116006)(186003)(5660300002)(6916009)(38100700002)(53546011)(966005)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VdxbpwMfW3WweDJIrTulHHHHZ/+WSm4FDBSwiRRxv5012d7NO5Bzyw2bzPO5?=
 =?us-ascii?Q?Z5+/YPca989e5OYcJFOLgt/xTtNwpTPJYJNwjV9Z8VytZmb8+gT5tpF2x7sA?=
 =?us-ascii?Q?vL76TG6jebV2H7hsBEasYI1xJD4ZLjNyThobzhflMRjfHvEXfHOeilg6BAbY?=
 =?us-ascii?Q?yXnABZ20pqlB798c6X3VgdjFCKpkqjHdM/OGSb/AAKIyRQNdNvBtl2k/BTNg?=
 =?us-ascii?Q?4U8qKfohtM1dkLTHWzZp/b6DLpCqaBDl432hdlEYVbW7hQTVQAa28aoConwY?=
 =?us-ascii?Q?SnSB5PSkvA1UlPO9ECIgelMIK1cGQVBD9FzN5LZSAEtL6msroFeWKpMnNzeX?=
 =?us-ascii?Q?IJAJik8hmz8WfR49X4cYbRUp1QTZrpxtQ3/uJQocqY0q8pk2J15KuXEDg3+k?=
 =?us-ascii?Q?FzjMl7Noc62fGDaE4/wcRNxsxALb+SY2QhzHGgZqSSV9gGqk2U5Zg/6fg1Nj?=
 =?us-ascii?Q?If0jZxL102noc4bWEwELuiMrg3QleyXYMwUyY9kecdZgichtqFX01DpqDfNK?=
 =?us-ascii?Q?Rp5bxdM3Dx1Qumm0EWsl8cm9Iv9gLyhQu35iKXP1nFOeAMCl0OkdWikZgzt9?=
 =?us-ascii?Q?c22awOybOiEZ+H3enCxsyxzU/bGpIEAZ4PM7ruwDRDfyV9XfaXy8DooP8DZq?=
 =?us-ascii?Q?wfUtrPAWFu5VRjeiGDO/akF4KY2FWWKGe/jvOhd4JNTSsLTzK6AvTdhYNk69?=
 =?us-ascii?Q?Mvue/o3mkgGTW9aLXiL1shnvLAnTAwaWkiXsnyOQwr38xNsbecoEwMTdTFON?=
 =?us-ascii?Q?VVvkM4JyMYuEL031Bkd85M/MMH9ljVhd2cPTWe0a3knjWtEweyoXrLnIh/jp?=
 =?us-ascii?Q?62ESLdSKy6b7qDZTBIyEKQsvtLFjZxWYe0BCe9D4OfWN+OgCulFCY7jealmp?=
 =?us-ascii?Q?VCNOBL7j1xoJ56Uj9QTxwcjoQHwWkyXrU80RnyezLbxl8HC31xZw2jOoSrAe?=
 =?us-ascii?Q?l/o2OvxesM6Ka8CvUlxQtEYcTZq5B8We7Yl547Fwj32YV9tLLNpHJZcWqe8O?=
 =?us-ascii?Q?Mk2hAU/afnYd92SrhndG9b33sw+Bfv1urVpzWQ0c3JZhi48Jo+9mYprq4tbA?=
 =?us-ascii?Q?Rc1ezfr5ZqWVxT0YO1hBBFw0/Zu6xw+K5CSqOKazJwwv0ZBHCO2Lvrji58y/?=
 =?us-ascii?Q?UiBLaIppbIvq2HMXjqEIjLxKqnhdXvtN3On+0LsxzHS2RGn4AuB61f77CdA6?=
 =?us-ascii?Q?bau5K5ROJI/cKlf9s32RbOzJjEFLa1g8h+juyWl/pIWF8ph+59framANfyvD?=
 =?us-ascii?Q?lKp2x+TmoKEe//2HdPMbqL049v4VMOEOxpk5dfBwNKE3gh/+2j9yRVugjj7u?=
 =?us-ascii?Q?rHen4AkNCD1t529wo3fyGjkHlSiSm20V1Fqupyt5D2YNdB7Ob7ESwnjaS2HD?=
 =?us-ascii?Q?RqMAjBrxut1RIAuVbHeevYnSMCNC8sd3b+GDn1xMOtfiHTLqCjVZHt/Jz1gK?=
 =?us-ascii?Q?HsiCRC5beuocLgfYEG1u1JCGUsUnVzZkBew6y0rLhwUClLQfItQLLNIsWBlh?=
 =?us-ascii?Q?VwDgGOjFQh8Hywr/jz5GDav3WhAG/bEmaJDynjMY8evKE6RfmQsr6EBN3i2O?=
 =?us-ascii?Q?7LCDEyqV6dIxW579w1WLlth0I/c/m8F3ZCCP2W6pgTAiwVroUPEsSLhNen0u?=
 =?us-ascii?Q?0+ZYEV4VYNjmU2FtCGouwjaPe8Mm8fMP7HJxmAAeJvFU6qz5r49L4kvTbHyv?=
 =?us-ascii?Q?uTZBNPzAMaFOgohAFJLypNPN3FA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C42491AEBD632742B6677015D7A2A78F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d55da6-60d8-42ad-84d5-08d9b3cea895
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 06:57:22.1038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWEA1VFkGLLl1G/FGQPJ3Oxbg5mnk2KA/lg21abR5Cuy+NONCAi8fYq2grq/qFKH05Aym+HosKBet1Uj3pG3hkz49x9VxxrA0YgZZBv8BOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2021, at 19:48, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Nov 24, 2021 at 12:06:56PM -0800, Chang S. Bae wrote:
>> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
>> index ef6c0b9f69c6..f696b037faa5 100644
>> --- a/arch/x86/crypto/Makefile
>> +++ b/arch/x86/crypto/Makefile
>> @@ -50,6 +50,9 @@ obj-$(CONFIG_CRYPTO_AES_NI_INTEL) +=3D aesni-intel.o
>> aesni-intel-y :=3D aesni-intel_asm.o aesni-intel_glue.o aes-intel_glue.o
>> aesni-intel-$(CONFIG_64BIT) +=3D aesni-intel_avx-x86_64.o aes_ctrby8_avx=
-x86_64.o
>>=20
>> +obj-$(CONFIG_CRYPTO_AES_KL) +=3D aeskl-intel.o
>> +aeskl-intel-y :=3D aeskl-intel_asm.o aesni-intel_asm.o aeskl-intel_glue=
.o aes-intel_glue.o
>=20
> This makes the object files aesni-intel_asm.o and aes-intel_glue.o each b=
e built
> into two separate kernel modules.  My understanding is that duplicating c=
ode
> like that is generally frowned upon.  These files should either be built =
into a
> separate module, which both aesni-intel.ko and aeskl-intel.ko would depen=
d on,
> or aeskl-intel.ko should depend on aesni-intel.ko.

The only reason to include the AES-NI object here is that AES-KL does not
support the 192-bit key.

Maybe the fallback can be the aes-generic driver [1] instead of AES-NI here=
.

>> diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-i=
ntel_asm.S
>> new file mode 100644
>> index 000000000000..d56ec8dd6644
>> --- /dev/null
>> +++ b/arch/x86/crypto/aeskl-intel_asm.S
>=20
> This file gets very long after all the modes are added (> 1100 lines).  I=
s there
> really no feasible way to share code between this and aesni-intel_asm.S, =
similar
> to how the arm64 AES implementations work?  Surely most of the logic is t=
he
> same, and it's just the actual AES instructions that differ?

No, these two instruction sets are separate. So I think no room to share th=
e
ASM code.

>> +config CRYPTO_AES_KL
>> +	tristate "AES cipher algorithms (AES-KL)"
>> +	depends on (LD_VERSION >=3D 23600) || (LLD_VERSION >=3D 120000)
>> +	depends on DM_CRYPT
>=20
> 'depends on DM_CRYPT' doesn't really make sense here, since there is no a=
ctual
> dependency on dm-crypt in the code.

I think the intention here is to build a policy that the library is availab=
le
only when there is a clear use case.

But maybe putting such restriction is too much here.

Thanks
Chang

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/crypto/aes_generic.c


