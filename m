Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F25465450
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351823AbhLAR7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:59:06 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:22922
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238686AbhLAR6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:58:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFjjqBbHOO1hzE9rXr8z584rMfMwWjN+ubD0B+34+Oj3EsaHf/m9jVmumMdUTYozQqm2ajmsOk2Enqhg3SNIfgCqXhiEAqMB53aiS49fYbXtYWEKGTJWmUqRxViQkVD1f2eRB78RdxK1ZZmcgpGuqe4nncPO/ajQSuR4Lbr4Vt7HNqLXEHt9fGtYrc9bf8r0zfIYoxLItx8eYLEk2uhg5QyPbU8JaGlrVy10DE9ArxW+nLz/K+707IL3nBTptIwrtpqS+nITn96hNDi04ls34Im3NETWTLU01HDdS4KDtM83HTbRCiZf53d2McW8lUZ3Q3MuhPFW4Q9J1WEyuIm1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiKhRctkPGtNFVBsmxfkI9K905eHdy3XJ0wkLFkRNFc=;
 b=Z+pgS5V5oXobxtRnoQ0fXDOoO4E/YStcGDVCVHusrjEjXxzdxko02cfiJY2nNF69vcLhCHSOMQiS9c3e/IdTq1RFbSfhaVSmAndr3PuhK/lUCVwhfO1Ap253BrKy3uf3SfWWro995eu6fASWbdEmLCNfGey2lpi7pMojtc8/vnVWj0vFUdVQ/3IaPVNf4G7yKMTDuBOtK+65A2LBenVUIshH5E3r4gp2MxkUkvrsVzgR77tiYULFg4pQHO/kUc+HJLCgGqexLoVtETFvZDGYDDIS9yn02j1FkSmbuwpS5I+uxtiWslQ0gnZ+TsAIAFwquKdWZznqE/o9SMqKiBOYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lairdconnect.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiKhRctkPGtNFVBsmxfkI9K905eHdy3XJ0wkLFkRNFc=;
 b=QU5yu9H/CarqVmPCeSTKVPpNLRMXzYZOheKCtF4hf2GPIxnDuAYZj382/2fd+JZWpyJdPuJyqGbYxdy/AyeHvD2QDecDWY/qOp9vV4s+7eHegEGSRaHyWZnKT4VdMMqkiWukacGXkA7njZy6cLUPs+QKc/1vvBl8IdStUEpaQ/adyli+UGwvmVVaZgxZRQGj53t10hJi7KGmgCKo84nS/Cb22kS7g39rG6T39n9XPqtsfwPmBsTtHzbGKKQcRCBH03ByGxUQpQUiHN07B6xL4IVLjPsGYaKyF6Ct+wgcJHRAkLjvzOPHr4eBKK+OgHFkUQrlSMFTNigagNMCbILo7Q==
Received: from BY5PR14MB3416.namprd14.prod.outlook.com (2603:10b6:a03:1ed::16)
 by SJ0PR14MB4411.namprd14.prod.outlook.com (2603:10b6:a03:2c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 17:55:33 +0000
Received: from BY5PR14MB3416.namprd14.prod.outlook.com
 ([fe80::553d:2c99:5525:2389]) by BY5PR14MB3416.namprd14.prod.outlook.com
 ([fe80::553d:2c99:5525:2389%5]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 17:55:32 +0000
From:   Boris Krasnovskiy <Boris.Krasnovskiy@lairdconnect.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
CC:     Simo Sorce <simo@redhat.com>, Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>, Tso Ted <tytso@mit.edu>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Thread-Topic: [PATCH v43 01/15] Linux Random Number Generator
Thread-Index: AQHX5sz0mOv14rnNIkKw7OyLfJ1msawd4ZyAgAAJbXc=
Date:   Wed, 1 Dec 2021 17:55:32 +0000
Message-ID: <BY5PR14MB341621FBA9F7BD09B6D8C3FE86689@BY5PR14MB3416.namprd14.prod.outlook.com>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
         <22137816.pfsBpAd9cS@tauon.chronox.de> <YaEJtv4A6SoDFYjc@kroah.com>
         <9311513.S0ZZtNTvxh@tauon.chronox.de> <YaT+9MueQIa5p8xr@kroah.com>
         <CAH8yC8nokDTGs8H6nGDkvDxRHN_qoFROAfWnTv-q6UqzYvoSWA@mail.gmail.com>
         <YaYvYdnSaAvS8MAk@kroah.com>
         <ac123d96b31f4a51b167b4e85a205f31a6c97876.camel@redhat.com>
         <YaZHKHjomEivul6U@kroah.com> <YaZqVxI1C8RByq+w@gmail.com>
         <CAHmME9p60Ve5XJTVcmGvSpUkg_hRp_i0rGG0R9VhuwLs0o_nXQ@mail.gmail.com>
         <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
         <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
In-Reply-To: <49d6091e571e24efff7bc4dc70c4c62628eb0782.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 81ae9266-4c75-9b73-a5b5-8668c456d8d6
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lairdconnect.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7342cfc0-e7da-4171-0c1e-08d9b4f3c53d
x-ms-traffictypediagnostic: SJ0PR14MB4411:
x-microsoft-antispam-prvs: <SJ0PR14MB44112EE7169C26721307127E86689@SJ0PR14MB4411.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Irvqs/UKhMaPdyYjswa8ebkiNvn+vNzqtV19BZ1xxSTzuMleSEA6MhZRxq5/JHrA8dwLwBeae+r9Ny8ygM+r87jDXojmLDfg9eioN7AgGoXbPIAgnUiAwiKmMf75Iwl+GLJjsNxqVPPv30i+D0WGbFJaoicb3LC6RUdpgr6cqWbPwdbOmm0Z3K4YXcVzxMkFeJ96iGYGXPnciCtukUKvSDIfpltyS/J1V+xR0GrccUIqe7ozhcPCQj1LiCju+bfh2s02VleT/Ql6tCaJEjYOw7an7lth2bxB/D+jnYtnJ/Kdfniqzrd1ansMH8sxDyhEBeNH8OoAJhNfsDS4vHufXmcYimpa8sjM+Kg2ryVujDrwbuVI56kF2mex+cV2Vb7jE0SzpmFhOewI3shjpiBx859adpETBmF/vrP3BkXWLIBr/IexdyXYGNLbowu9qd0Ea4Q+G+OmvSnTWpon/3/OqqS00ZlUACklYruN4QW0QuDkFVWzDIlQsfdGfuLItzHa3IXCVYmoXgtpBo5uqVEvDRRgcLg7lJGxjEkcFua0csqLJOqk56fVPtl7iNPj3zWDhYHK453N98aytvpCaTMUqsw9lqP8Sjb3hp1gEv5w3tL46q1Z0PVnEPHA39ykGyPNMjobiAUKNxj3tNPAZDUHoLwG6NSUsRqrJQVmgWMQ6w9ihXP90taKUZtInGq19HPd3ugrB6WvZ/kMRlj4fd976g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR14MB3416.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(38100700002)(6506007)(316002)(86362001)(38070700005)(9686003)(71200400001)(76116006)(8676002)(33656002)(64756008)(186003)(7406005)(66446008)(83380400001)(52536014)(2906002)(66476007)(55016003)(4326008)(7416002)(54906003)(66556008)(110136005)(508600001)(7696005)(66946007)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UiTY+eRyg2UyGPPMP9TTttpOixIedS1nHEvZWFRqO9nS6X4mu3W8vUQgDd?=
 =?iso-8859-1?Q?Uzr0AAxoq1nvvpcNWN0o5W2Fvqci7ZDEi5/i+CGMHiBbJH6qMezedCgLRH?=
 =?iso-8859-1?Q?2TrWjFjqRvJobNHFovx1bVfQcNx6/S5BdTgLt7z+mInq42iV1Xn7D1hnUC?=
 =?iso-8859-1?Q?J9v9zdkkRDm1Td6L8MV4cMTfQ5O23O2hwqRGFpUmF9+h3UFxif1GV0N6ME?=
 =?iso-8859-1?Q?GAIuftMhLuTn8ZDis7IlUkmBED1ytghnNZ2t6EjpagIkyqlwi6eLJ117KQ?=
 =?iso-8859-1?Q?x8/TrWmDgML7RUjFmgS/g9wm+86Gt+vt7z387w0V7gdUE1OM+QZ+K3wnNu?=
 =?iso-8859-1?Q?YpJO0j0Hddl/+ZoYfgd3H9dFeJc8NA1iBoLZX9CSFSlbAVXdniFDfoyWfN?=
 =?iso-8859-1?Q?6doohgSlNuSNULLRJhuIkX7GRJRwxHxnuRm8XV6MBvp0QggUTRD58JlCUN?=
 =?iso-8859-1?Q?Ywk+KPoIQ+1/ZlZUG1P+Z6bqvnholerZ3UsIsHLvdjTouP/DtBTZ7WRc+I?=
 =?iso-8859-1?Q?3cYUO9yhr4i/Y92A6IkIvfL5LKxKsCxqPUPVssq1Fv42gIG6gidBLpKnLC?=
 =?iso-8859-1?Q?f5xd794e98aVefmfBouDN24YphcFSkXTHiLFr80LQW9mrNgbv6PFf3l6X3?=
 =?iso-8859-1?Q?esKI1VSC7pA/iEEsx1B/N2fPW8LeehTceXC/7c1pT2oxmebLFt+YRl889b?=
 =?iso-8859-1?Q?/5fn80053HzS1fWPt1CKS7V2HkfLCIUAM0Wg388oedMd8VRTj57l2jXMsB?=
 =?iso-8859-1?Q?RcXQjySfRYokm8+OspnbcMUB+yOTCu3tXTs8ohD9C6V9SEBO2kF7V6o5MW?=
 =?iso-8859-1?Q?CfkHZlcitzNovv5QKNoICTT7y5qBtTDoU40HPXcatDyjsBWEAiVONVNUkY?=
 =?iso-8859-1?Q?kfRmfvvhqXTSaElBwrAeaZ+nb6pjluLtVNPWfdonZ75MXAKJX4rQjyx3+l?=
 =?iso-8859-1?Q?CeXGY4xCDARH9BGC4OCqptEsCPX0gP45AiD2Md3gbUzWoR1lKkS9/zLseU?=
 =?iso-8859-1?Q?D6ed984BrXTfGYOtO8yVrYGZfM1AgNse1DsxQ15SNnoNHtWb9UxxjdR+T8?=
 =?iso-8859-1?Q?mksP7FfdR0z7Tv6MEnp+A2nfdhF0BCtpzIoorS5Wn9iSq4kWrgjsqwu8xe?=
 =?iso-8859-1?Q?bEbY+ot/bQ3lyMdweR70k7srGU7wzV+GJsE3Mk+21Lgf0Gr5wExbUmkE97?=
 =?iso-8859-1?Q?N9m9CSf7ngUptd4m7rIkO3i0JRWWCUxfcvzwys9DMnrCQicmDlt47FpMqR?=
 =?iso-8859-1?Q?laP0LmckBpjdfaYXwB8j18T2qSgaOt1GBwOv01FnSKq+ZTWxHtTdRKkhOa?=
 =?iso-8859-1?Q?t+SCjVWk299kaSrjyLSuL1eRlWxFp4aISJDzCtDQHu1Sik6dbU9E5gvcRV?=
 =?iso-8859-1?Q?0TY3jn7nSz9ybODoKGl4J9PLYaup/haAZUrfkOAWUY/yghXBNIjJdMkwa3?=
 =?iso-8859-1?Q?XZYCXeMok2BgRx+uo6TdJQYILQWVMIu8D0pwbUVd74Xe6ezC1Pellh+4jm?=
 =?iso-8859-1?Q?IkJvlFa8wj0pnGQZp5cz0J5JFrZa5HScmkAeRXNe/aKeZZXbcRuXOki1Cr?=
 =?iso-8859-1?Q?KY6+6SlbRtdclNKFJC1tDGgSHevq2bmpKURS+wZ1TNxPXC1+/LTAmxOvzF?=
 =?iso-8859-1?Q?aIDTdYGTzp/4PttRr7DYjQMzRGsqipP2HakPHk2Fo96R1S21/Vbx+ncGMo?=
 =?iso-8859-1?Q?xsoYpSziBduPRq7QkC2ndFEr0Y/4enj8W0Sa53ZG1t8y285+hAwvqCJlSJ?=
 =?iso-8859-1?Q?fToLetkTkqSyvIaRvvUtHukU9uXTCJDoYQbiKjtTtVvl8ZJICko6a/Emwu?=
 =?iso-8859-1?Q?mtsYDzmzERveQ2kPe5UFlY9vA8cfwPFzFsAWj2LEYegOqTH3C1wE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB3416.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7342cfc0-e7da-4171-0c1e-08d9b4f3c53d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 17:55:32.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7MK/91Zx94VU9WgiMeh4MycUPgLBf6O8CsDsCQBVzWzgyeKKbtD3b+CFy6BRsvIAvKEM+ZnM1DLd9zImVsvrM+ESBwmYwb6vXp3lgFPNGeNCp+69k0ZZWwSyS/ktmvv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB4411
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, Greg,

a lot of the issues LRNG address are related to RNG and FIPS on embedded/Io=
T devices.

The problem we have is that /dev/random as it stands today in many cases do=
es not generate enough entropy to support cryptography on embedded/IoT devi=
ces. Embedded devices in most cases have limited interrupt and IO activity,=
 they do have in many cases aggressive power management where device is up =
and running few seconds at a time and fallbacks into suspend mode, this is =
done to preserve power (battery and otherwise), and now such operation even=
 the legal mandate in EU (we are going green).

What options do we have here:

Use hardware random number if CPU supports it. Yes, some people do not trus=
t it, but it's better than nothing. /dev/random currently does not allow to=
 mix in Hardware RNG unless quality parameter is set, and none of the kerne=
l Hardware RNG have it set out of the box.

Not all CPUs have hardware RNG to use or have non-compliant Hardware RNG (w=
hich is after 90C was adopted most of the older ones, 90C requires runtime =
test on raw entropy which is not exposed outside of the IC), what to do now=
? This is one of the areas where Jitter RNG comes in. It has fast entropy c=
ollection, meets FIPS requirements and could be run on any CPU, provided it=
 has High Resolution Timer, does not require storing seed on the file syste=
m that is prohibited by FIPS. There is no option as of today to mix in or f=
lood Jitter entropy into /dev/random inside kernel.

I am aware that there are userspace daemons that take entropy from Hardware=
 RNG or Jitter and feed into /dev/random, but is it really the best approac=
h?
Now let get into FIPS on such systems.

I hoped I explained earlier why existing /dev/random is unusable.
If userspace solution to /dev/random is used, one has to demonstrate that e=
ntropy fed by userspace daemon floods /dev/random to the point where other =
sources of entropy statistically does not matter. That increases cost of FI=
PS certification by about 30% last time we checked.

This is why it would help a lot if one can choose from kernel configuration=
 which RNG is appropriate for the system at hand, and this exactly what LRN=
G does.

Thank you,
Boris
THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN MAY B=
E PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY, AND MAY FUR=
THER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED RECIP=
IENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NOTIFY T=
HE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROPERTY O=
F LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WITHOUT THE EX=
PRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
