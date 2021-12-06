Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93B146AE11
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376941AbhLFXC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:02:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:53102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377156AbhLFXCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:02:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="323680684"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="323680684"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 14:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="579549837"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2021 14:59:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 14:59:12 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 14:59:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 14:59:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 14:59:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqAoXYkXB0AVcJFg73+lx01iDW2ZTKwzNB6F0xBzh6hxVDHxC0c8Bkne/U/yLiOjBFs3dIPyVTJ0+ISODmULmBuT6mMfPu3VXgM8/QZAZRAPQZ0qIc31kQDJmTczpvuAN1C7BX7PDZY5Qp0tVAMDgKaeQWws+jL5BvfBT64pyRIvhxRxFG91l7tS2PM9tMav0JXX/gMqJs8aodMBm5yzXgR1RMbuRiNezyx4NC4Y485DTEF+lgfGZWT1cHJCNrf2byoSsPWlaQ1ObB7WfhU2fhMlKCUBboQiCHoLDjWYwJVLaym6wsJvW3JoLC4PKay+WGMNk5qUQSbFPOxXzvTwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eV6zimoqRcF+XxYtI+cxbU9NlylxB0Ghy1+1cvcNJY=;
 b=SYlS0BsgqDttsvJ9cEnmPQDM9Vanz7HxUVLUk/0N79Lz1bLkPXAUr9OIUY6tx5j8xld191Rq1at0pDXhD6bHG5Lbc202Vn8wg0K/+7nohgf4hrnXh6g/rZomJfY82Wm1VGz3gcF00laxC7MeEQGmw20SV9Qp3AM4Y5FalKV9vcglFEasNZFsxiMrQen5u78WmjKPNGbwGBllS55SXpbERvUQWH3XDHz+SEKfL5hcOtaPqIInxQk7yJ3cM8ybKU2MgjLaPIRnikim1eMUWouzsYLCR/9OD69qeFfnbg12FVoQ/uGuOZadsZRD44QSPM4yE0wGd4It9YuCgfO+Bog0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eV6zimoqRcF+XxYtI+cxbU9NlylxB0Ghy1+1cvcNJY=;
 b=fCbE+eTGXT0cfIPggygEfN0GjtmyRWmq/ax5S7JmNha07i6FJuc//PTvFFDCwXSCPuO/Xdsa/M4EAY+nHhTA2mV2lBIOiWRh9MgRgPqYwxW6B7Bw9kEh13BNedOuUcrJR3ZsLD2N9KOVL1ckJB+9wqRRJvTSuLgArgRAAWtPb/E=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 22:59:10 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::38cc:22c0:928a:95b7%6]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 22:59:10 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Thread-Index: AQHX4W/kZoA3rQNJf0mSmN0oRVVbp6wbd4YAgAA0pICACm46gIAADHwA
Date:   Mon, 6 Dec 2021 22:59:09 +0000
Message-ID: <1F509A28-1A49-4F60-9E96-B2AD9CC6E921@intel.com>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <20211124200700.15888-12-chang.seok.bae@intel.com>
 <YaWfKB+k66MzNtIi@sol.localdomain>
 <011B53ED-6D9E-41EB-834B-8A64485DBED5@intel.com>
 <CAMj1kXF1hoyW6fdidJ2Dt4R_qBv_QLNaowKf4LM5Oe3_zaJuTA@mail.gmail.com>
In-Reply-To: <CAMj1kXF1hoyW6fdidJ2Dt4R_qBv_QLNaowKf4LM5Oe3_zaJuTA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 860d35c6-c846-4c52-ac0b-08d9b90c0395
x-ms-traffictypediagnostic: PH7PR11MB5863:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH7PR11MB58637D8E1F1E2AB01ED61383D86D9@PH7PR11MB5863.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ezGZQRkr3F2GLXltQeH24f6cb49ssKE4G4lvp7TjRZ0Kxc/xL/lCQXxssb8p6siVBJMg0CedicBlDNFnF5XxLfSoYvZExX2nDgj0Degx7GS5teIzF6iaWJr+IZCw3+7p5xWMpfP/a/FLLUfimawuq52crac1e8TJDbqIMi8GT2jfeV7Dl+OONLAXKqq55EBIKtwRsH/Deyfj5F5PeUrJr6Q2Kusac2TmvP/fHD2JY/FxYJyJpia6cuGe8Mb0C5nrSTdBQz05bwlP82A/LHOZOKmzzFDeKucC1O08mr0D0HpwUTI3S/stOXeAOFYG4Uv54RvqYZqrwbCXnIG4qxihMRmvVHxH4Q39uUCvJ98g66FPzI5yMUNNtXVVl4nzHfsy3Ssc1Tt9CCqDOX359Zvw7i9oM5Axt6jFVDl/qJ/nGbbQnW/S66Cy7cCwMCS0Bf0ta+/SwN80ie4mT5nTJsN85aZuXVIyTY439t8SHqoxPw0qPfFl2+R2AH6TZX182ns5nxsCJwKK3+3f0CIqFCErEDqTJaHSDYAENRfHnxMXQh19s7T/UFbQgXyl0h5t6KI2ui6WIHwwtPiEh4Fwsd8LqaGVQcljxjGbPgo7ECLptPERp1QknUgCtNHXk8Yv8MuYPCiLWwX3K3gFdHpmS3rUdkJ+49El4RY7WtzG6PYveP6l26arvulzfoH7/TCk9ZRzsQV7sXmQ8M6WyJoJ77Vo0BZRvH+7nA5SWpvZdQztjk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66946007)(38070700005)(71200400001)(6512007)(8676002)(66446008)(316002)(66556008)(66476007)(33656002)(6916009)(7416002)(53546011)(6486002)(8936002)(4326008)(36756003)(26005)(38100700002)(2616005)(5660300002)(54906003)(82960400001)(83380400001)(186003)(6506007)(122000001)(76116006)(86362001)(2906002)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kW5AqYLlIEu0Dt/kIr+C06EUHj2Q/mEI/RAWFMVSljWtTPPk246nzHOrTmWs?=
 =?us-ascii?Q?+XiDglk49d1RPbMXb4onhHd8oj7tgSW35toLggMir9Xib6sBBU87bDfGAXa5?=
 =?us-ascii?Q?PwB3gzn2ehLiJk+UbuQGYKR59Su7Ty6KkMWoHNh9Ob1dF+YCztBsfcfzYPMN?=
 =?us-ascii?Q?8UE+uXgpNJoET0gsLaK64FnZ0byqVGHWnr9tp2Vl7hkDg80i6YHszvSluM2b?=
 =?us-ascii?Q?gIUUXUQ8eb2VVvu+hq4nQT9sGXqltNH5w0WMPZUP5QPk16FeU1Mi9uq1R+dW?=
 =?us-ascii?Q?5cnilIQJqOeh7sfNPEV3du6OIF1mYvRuQM5McCWDm9vmfu2/EaaKVRIKg11f?=
 =?us-ascii?Q?DKn4v21Rr7M6AN9gmjNPqReB7QzNVMkEZgthLcJXlAl1RhY9TRkzc7yZIcI+?=
 =?us-ascii?Q?qDip43ilXIKhRNdaQlafJlAG49r5tC5FZIoL9VwmxMLvg9d+D8IxP9xBbJIB?=
 =?us-ascii?Q?UZMUiYOSv1A7/mHVtXTQcyVWyg6kRiAlV9tER0ZhEtdT/vYxZGb4uyXAi3Xj?=
 =?us-ascii?Q?MWlWGjIFhJ0nJ6rT/qde7dvWtahIUTntEwXRLi0hF/n8g8MmNGRpixMr43ka?=
 =?us-ascii?Q?ajJ2bATb5LLzYHeWqMWer7pAFF274hfZyZP/dUni3XCjFuiQiRZBg9uDSSrK?=
 =?us-ascii?Q?qmRDAyacI78ryl2j5S4h8dLHbnEGQ++YeeA+bWRvw1FHhu5MC0TEwjW7eEAQ?=
 =?us-ascii?Q?Uh/X6/L4m947RzkDX/f0/8qc1mojfCPCwcburEP9urX82wh7VDcud7Dz2IVp?=
 =?us-ascii?Q?lz88VdL++c59vKE2d9xA9QV1/iiaK93+4eZvjMCYKvfV5pcuaKp+u/YjD/Mj?=
 =?us-ascii?Q?JGP1A8lxFATBtphJeQtcGTguRHsgWlIFGMMQK7YohHrp60rLSH8+6iowylUN?=
 =?us-ascii?Q?KHyvUyp+AhMBfT8/bjtYMU/nSKMna5Im4ivz7w9DoOAtODW/pWkRtZpplEiw?=
 =?us-ascii?Q?Xq6MJ7g8lL9jZzgQFdo78efzrTvjl1vRRlOBrxmCMpNhqUrU6g9010TpibFg?=
 =?us-ascii?Q?HYUaPbY6HB1wA3oBelg71kODQk0X4maoVKA9WLb//VY39ToW90DUMJa0hmeo?=
 =?us-ascii?Q?gYjGNWttY7rG6nTyq1acxT4teXGUW2oFj1ZTC42qXwi4yl4szlO5ks3UsvLr?=
 =?us-ascii?Q?QR6h94E2+brWTzx+OPascbgacMVFN4Ryh10pujHWIfwqd9uY+CZCVO0UD0/Z?=
 =?us-ascii?Q?oJWJy8UQohZ4IyXXDnobNyQL0fSoQPNf/n8qxNkT8lCtW7kHrcMT4KDGqFQq?=
 =?us-ascii?Q?CDht1L7skMyfdxLaUXexd3xoY/5FvLwa0XaEsYyIwZFQLnUTTRtFzIGGY6BD?=
 =?us-ascii?Q?nxYUcb38akWP1k5iSxUIAghceHMiYMoWlNFZuvndVbQTXhr157y04UT+SM1M?=
 =?us-ascii?Q?E3CoTl2P2KKSJ4heVHT+1TeWv6V6i392GvFMfOfo6ka4hB54srk4Mv+dszTi?=
 =?us-ascii?Q?ySV7baC52xphFKTtHEzsv+2mMbTNrKy2FMOtShQ1/bN0Gjtb+AyqZ+qPs6YW?=
 =?us-ascii?Q?kHg3QEq0UOiOSQHykam4z3peW+vdY2OuQiBJX+SBJEWMjVK+HJ1gSzJV5zpe?=
 =?us-ascii?Q?BOyGSGYTMNLcLpHSNbea/WihGJymfF+AFgJZnFkv/lc7Mifknpl4x9LyWNk/?=
 =?us-ascii?Q?hkBpZlsLIwrMCsCnky3gCZOVtqNaWO60lLdRjSccpvSumZdd+05avz9aFrev?=
 =?us-ascii?Q?HYLLJe/9+xMIbkbYQKwuuayXur0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D55EC34D5B60BE4DBCAE4FB224996D41@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860d35c6-c846-4c52-ac0b-08d9b90c0395
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 22:59:09.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GgaHjpe7xmR1fzzxfGywCphy9wIyNO60x5ghMCBnlwyS3cFKvh8vpef2Fdltkn7XFt3TKXUIGIuL+9/pmuMVHgwLxqUXnSYRUthiv6fE4sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 6, 2021, at 14:14, Ard Biesheuvel <ardb@kernel.org> wrote:
> On Tue, 30 Nov 2021 at 07:57, Bae, Chang Seok <chang.seok.bae@intel.com> =
wrote:
>>=20
>>=20
>> No, these two instruction sets are separate. So I think no room to share=
 the
>> ASM code.
>=20
> On arm64, we have
>=20
> aes-ce.S, which uses AES instructions to implement the AES core transform=
s
>=20
> aes-neon.S, which uses plain NEON instructions to implement the AES
> core transforms
>=20
> aes-modes.S, which can be combined with either of the above, and
> implements the various chaining modes (ECB, CBC, CTR, XTS, and a
> helper for CMAC, CBCMAC and XMAC)
>=20
> If you have two different primitives for performing AES transforms
> (the original round by round one, and the KL one that does 10 or 14
> rounds at a time), you should still be able to reuse most of the code
> that implements the non-trivial handling of the chaining modes.

Yes, no question about this for maintainability.

However, besides the fact that a KL instruction takes multiple rounds, some
AES-KL instructions have register constraints. E.g. AESENCWIDE256KL always
uses XMM0-7 for input blocks.

Today, AES-NI code maintains 32-bit compatibility, e.g. clobbering XMM2-3 f=
or
key and input vector, so sharing the code makes the AES-KL code inefficient
and even ugly I think due to the register constraint. E.g. the AES-KL code
does use XMM9-10 for key and an input vector, but it has to move them aroun=
d
just for code sharing.

Thanks,
Chang=
