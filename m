Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05811467226
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 07:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350754AbhLCGpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 01:45:17 -0500
Received: from mail-bo1ind01olkn0186.outbound.protection.outlook.com ([104.47.101.186]:6314
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244502AbhLCGpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 01:45:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hud1MMdW1muNBiGQgVAyrNh9/cFSTeb3hWcCmLmAvL7S5icICfXKOCOehz/6ZcO7u1SICjB2sNBqlXARczjt6HGUI1sq+YvJ03+e4ZYHXJF+XShWwrWKAzfKcjuINDoU+ZwM7DE4fJCeDLJ+9HqyQdHJL46K6Dguhvu4GXFET2P+LloEQk7njwGOTQ7Vg3+TaBb3MbFKTmVESHx1CFTwx0ur7pBho2wFo49Cyfgd132T1lKIzJRo9PyQIy8ZaQRqi6H881yKHwJf+8t8hUO1DCPMOOmSSG0bTPa8jUux83MD0TD8D/Fl6aVsZsNsqpP/EaHU1OiIuRPwSK8UJZQ6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFGuyMHXhQapYoaVRG82eACo//tIvOhHjTidR3wJd/M=;
 b=iYIg1S9z/ol+xYkG9cxWN49MfwTU1ukiaDyTto9nOrluc2RBNmD8Fj3nYs8eFpQvqh7H3XW3QOdp6R72i89fL2sTM5EGaDnt7XC2VvojnEYFXoTcnebmg01qX95N4fv9+vQgQGyJpHcvpVOTG+pD/ZOXd9oaprBAED3aeEHFvis+N50kZvNw1Z9t7acVy0JI2onTPCab3TxQUwQVRpbmdlQpMgJlFDDIqEmmmd/dl6lhtCim6RAuQAF0KYhRwGB3pzB3FErnz955KJAlVbGuTnV9WISe/NEMQbuQ8RRfxLgL6VC9QiH+wNrwDnejYyL7r9K0ix0RxbyYwyvbn8xaGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFGuyMHXhQapYoaVRG82eACo//tIvOhHjTidR3wJd/M=;
 b=UNtjKJPg/f80kk9W+T4bU4J/ptsNgRDljtBmiOjPaLzojJ8z1V9CWUPf/UH8tR8VuSIOYvvjvDgBufZoLMuyoV/0A0L+kybnIM/5apurux+JQGrJW65ixnwsxGrXHhOYOoR/WxJ41ycuBK1eXxRCw0biJBywdD6hlcNe5pvlbcVjVda4wwS/7PpGKj8ovvvec+C4PQeWsp4Y2MZgFtkEXImAjauJpl0MSPpz00l86Xmfk99wWEF5RV2UH+K7Sev413C80ILCHxMS/U/WMZ/QSonjjnlTJoMHtXCKLH69yNWIAOaJ+QCmS/faOynOBTUVRqnCV8DK0ck9yxQQtHvjpw==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB4414.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 06:41:44 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4755.016; Fri, 3 Dec 2021
 06:41:44 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>
CC:     "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "chi-hsien.lin@infineon.com" <chi-hsien.lin@infineon.com>,
        "wright.feng@infineon.com" <wright.feng@infineon.com>,
        "chung-hsien.hsu@infineon.com" <chung-hsien.hsu@infineon.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stan Skowronek <stan@corellium.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v3 1/3] brcmfmac: Add support for BCM4378 on Apple
 hardware (with their special OTP).
Thread-Topic: [PATCH v3 1/3] brcmfmac: Add support for BCM4378 on Apple
 hardware (with their special OTP).
Thread-Index: AQHX0GuU60Mzr7gPW0qK2qCd4kZ7oKvxeKSAgC8IL4A=
Date:   Fri, 3 Dec 2021 06:41:44 +0000
Message-ID: <510D7CA0-8DED-488B-9F27-1F407F74861C@live.com>
References: <PNZPR01MB4415874CD530F2C305872F88B88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB44155DC40EAA3A13FCE85193B88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB44156C94263746D4EC592E96B88B9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <391FADA9-4C9D-42F5-97FA-B87D36BE901B@live.com>
 <4928ea79-2794-05fb-d1a8-942b589a1c3a@marcan.st>
In-Reply-To: <4928ea79-2794-05fb-d1a8-942b589a1c3a@marcan.st>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [CGeXRie244E5p95IStUVel203jRJZQsUeNBP+6XfMw9Vx8NuOXzVP4VzRKdwUbjm]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c4ffadb-0fde-4376-3c7e-08d9b627f8f5
x-ms-traffictypediagnostic: PNZPR01MB4414:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddOdaFaOiMbn8NXk43d2dI/e90aXPLQHUvvSjXmFCbDGugalkPbQ71TfikksZCDqljGu4PIOL3w2v8w7t25a19YSoSXsLNlNrDAQMw7ku6t2v+xt2jwHpOmMu+6jaHN50ZzdrJYY0ncCUHB8oh2MY4Abi54oExf0EUG1O5+1q5LOSpy2twG6I4tXh1J5qslmJ28CXTO1yAaEq66gmXXDy3JOupwVv+YVS4jkYzEc5BOkWonKgOTE4lNEEXoRiqJu5S1uFqKQDeoDyaaFXbH5FaGSisykD/zpa/0CFy/v1dekuW31CgpTpD1F6klbt1vp57GTDOmTL7WPtpv9VYFTcDfuzuYVTpzbHady7xngSKy8ary3wuDMVQMLgaRMb9/9DR7P3IPzg5tor4ax1kS/eKp3xxBZR8IekW3GwrN67fDUBu5bpYqAIx8uW4Ndn1n6R9SjcJxhHilxJ/3Lz1G6GEIwypjG42tG/EVn3Y+GfVx1Jxi8Zykftj5yGs2GnxFJ6qSxj22A9KSPu39+2Y6TLfGwCxuayhopwDMsKnUR69s2jT7UvW9ay6WiKep3TbNTIfRwh1raq0a98vRjV0Ev3lpvNE7FnI9DjqpAxBGuq7SU2m0A3aEITO8QIIFJ+P21
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VFqgMf9NdiZHaDXQqCTxtHs7jjkBEBjBXxcP6ka9sMlkBf/MMN2cQHCS1NDi?=
 =?us-ascii?Q?2N3ZSvyiUrRusRJdFdsl58GmxpyBcvzXH+LSbxWFMIwbPDP5QotDET9FGTpI?=
 =?us-ascii?Q?C/RB9u/CBDN4YiJf+wXCKuO/Gla5u/FSS3a2fb63Tf7G+cQpGGAG1oo/P/aj?=
 =?us-ascii?Q?JCSUjA0815hvT0pxLXRVkq5aX97QFxpOKjTaewHscQO1bhYcBxGVBGjdgroz?=
 =?us-ascii?Q?e4CheCZ+S4h3GGVXuzUX8onELcv8fn9YZuOJRCP9AWcISPe+EJHw6s93hFjN?=
 =?us-ascii?Q?9sQE2Uu6dgzwgGnbbTRXtfdAvjXhO2ZFr4OjxSikPySurOIG2Df2HyyVQARM?=
 =?us-ascii?Q?kyIQK+zut1YekmQGyerQhve9lHonkB3wIre5FKDpRu4x6Ze0d1fDZM0ZibEk?=
 =?us-ascii?Q?jlFkQSKLhrR5MWtW4l/VR9KEdv/c88tSqJA8Od5FKuAFcI88smm7j8XLeWof?=
 =?us-ascii?Q?cPIQ0jv6qNrk2Tg2hHpvUNwMLgWmJsitp2QEg04f6NckxRMxpjgPLI5v7VCy?=
 =?us-ascii?Q?1zG/V1RNE5aFPmtQhpHbFMRItdWRcCZ5pVYfSK9vEvfLxE1y4BO/8pVuJJSJ?=
 =?us-ascii?Q?iUzi5kd8ChS4cwQvzBqVu622z1nBo4eHgTeAidFo3DCqd8dq95OGPfFlehCJ?=
 =?us-ascii?Q?qwGtUmtlr4RvN7c0WLtgaLr1FXl28orEC1p56RvuzKDKoaKVTUZnfDRy4FA5?=
 =?us-ascii?Q?gfCOezMOH3LzMaBiRD6IdOUMINtMmr8t2ruh+7mamJFlB4u6HKvNeeoY3pGk?=
 =?us-ascii?Q?V2ck3HRQYU5c7Db74n4rI99JYOQ37RcA8Fow22GeMDR+Anrd5t+0abc7dgri?=
 =?us-ascii?Q?me4mNowj6UYTgC5r0uZTy5ymzB698chUwj/QtEstfEkPxV1cdOBIj/fcsxCY?=
 =?us-ascii?Q?ymWV/43ftFMJia0djYQl1KHjBIqkQEURz9k+C41o9qkxdRcReyHccgMRc12Q?=
 =?us-ascii?Q?T0h4tYu5k6H/cReH5FSvncVgVjvWjZxEzbQaE9m1u47BL2QhO29ZBrchAQGY?=
 =?us-ascii?Q?kBBE8ruwyQ9F52JGexUUmbm4IQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1DEC40790465747B3D1641688B20818@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4ffadb-0fde-4376-3c7e-08d9b627f8f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 06:41:44.6078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4414
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 03-Nov-2021, at 1:58 PM, Hector Martin <marcan@marcan.st> wrote:
>=20
> Hi,
>=20
> I'd been meaning to rewrite this patch because it's such a mess, but sinc=
e we're here... (CCing some relevant folks)
>=20
> Overall: this patch combines a ton of unrelated random changes, many of w=
hich without explanation, with some completely crazy approaches. Stan (CC'e=
d) has so far refused to interact with the kernel community in any way what=
soever, and I do not feel comfortable using his patches without thorough re=
view, including reverse engineering the changes to figure out what they act=
ually do and why. We've already gone through this with some of his other pa=
tches, which ended up being largely rewritten or entirely dropped in the en=
d.
>=20
> The firmware situation with this patch is completely unacceptable. It see=
ms the original intent here is to have users load the driver, have it print=
 the required firmware version, and then expect users to copy specifically =
that firmware file set from macOS, and reload again. This is obviously not =
the right way to do this. We need to statically copy all firmware from macO=
S/recovery mode with a naming scheme that this driver can use, at initial i=
nstall time, and it needs to dynamically select the right firmware for any =
given platform it is booted on.
>=20
> The main issue with these machines is that there is a large set of requir=
ed firmware variants; a few core firmware files plus many nvram variants fo=
r different hardware modules and device revisions. A lot of them are identi=
cal and can be symlinked, but we need to work out a naming scheme for these=
 variations. There are several more dimensions of nvram selection than what=
 we're used to on Linux.
Update on the firmware situation :-
Thanks to this commit (https://git.kernel.org/pub/scm/linux/kernel/git/torv=
alds/linux.git/commit/drivers/net/wireless/broadcom/brcm80211/brcmfmac?h=3D=
v5.16-rc3&id=3D5ff013914c62c493c206d70554cfb1d311ea481a), we can have model=
 specific .bin files for Macs.
Example :- brcmfmac4364-pcie.Apple Inc.-MacBookPro16,1.bin is the file spec=
ific to MacBook Pro 16 inch, 2019

We would need something like this for the .clm_blob files, that is we would=
 want additional support for per board suffix clm_blob files. This should s=
olve the firmware problem for .bin and .clm_blob files. A patch to get the =
same feature would be appreciated. I am Ccing the original author of the ab=
ove commit too.

Next we have is the .txt NVRAM file. This seems tricky cause I haven't been=
 able to find a way to get the module version, on which the variants depend=
 on.
