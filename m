Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4274F51DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848534AbiDFCXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376706AbiDEUuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:50:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A523EF11
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKBQ9LRRD1xhuagfPZE5DJqZxQLpnVDxrsZ2F2NpqqiUGQdzvTWzvCKfsrO1znVsImkqe4Wc4GFZODvn/sRdY1lBkSP/tY7qObvude6Z5l+lJ4eAXOlhzwp3IhcerqmZBvHIhsLT+A5BAnwpchpEi95ClH2y9+iVNL5cK5lW8rk00HaMr/hNSHlUSLzpYDNdcTW3oS7oL8afSwnN9cdR4BbltD1iniqGjz2kc8SW1txSIWbxLbm16kpERxYq4m6JkqV0mpKK1SCp2mo+lMNj2CFv51ZoLa9jbnIV+wc536T3/D6zG1eE8nVLDffnDmtzju3sbqf+n/VjxJ+NmC5XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyrrP2tV8MZVhfsPDBZHFD8iv2hNm/Q5/Ch81dwxEkg=;
 b=MkyN/iYpUWtQj6IIkXcTwflKZmMhlPpRZGkNB3iycIO8YFZy1qD70JyMgUGIv/dPodoR1TXp22AiH6FW1/Rmb3HPfsn2Qg+SvOsL7nEly7UfIRkg4RfQ7DVOcxI78sw8P1h6mF/4NoE5CaD0xIkbLzh53DqIEq9HQLhKnNicl1UdMUdO72fg/zggRCtVXvmFp2RA51IYv4wjwL69HszFr7KA2TOkMXTml44Vi9bxwWAVtvgfqstAqNEEHRBQIS9R2LTQq93l7VItcvI0HzAe01K+pBAVg++WUMr8/mfCkErXshUKpSFa8u0uz4Y0DnrIm5LICelOFusofBNm/ffI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyrrP2tV8MZVhfsPDBZHFD8iv2hNm/Q5/Ch81dwxEkg=;
 b=C8FmwXtEhqFR5VF7Pt3paJets4VdzMjUETWVxDCl2tmTeIF7kYhJF0JxmrsdsfUpSIasMoa+yf4JUPqlNaVpM0Zk+5y4IkIHAGRtaXEkkKdW8f+9f/c25Y7ZdPZcK2KvnDBFH01USn4VdRLJIvdlevSJxruQn0xsQf5WQLUC9mw=
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 by DM5PR12MB1225.namprd12.prod.outlook.com (2603:10b6:3:7a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 20:26:53 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::e0a5:a02d:154c:bb05]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::e0a5:a02d:154c:bb05%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 20:26:53 +0000
From:   "Carroll, Lewis" <Lewis.Carroll@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "metze@samba.org" <metze@samba.org>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Topic: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Index: AQHYSO0snhd1lCdhiU2/pwc3sV/c0KzhWp+AgABmXzA=
Date:   Tue, 5 Apr 2022 20:26:53 +0000
Message-ID: <MN2PR12MB3949923BCD8B368F8269565BFAE49@MN2PR12MB3949.namprd12.prod.outlook.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxMtx9zdk+nH33r@zn.tnic>
In-Reply-To: <YkxMtx9zdk+nH33r@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-05T20:26:52Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3d4052b5-e8d4-4616-b217-35ee899aacb8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 132ce947-94e5-4db7-0e47-08da17429f50
x-ms-traffictypediagnostic: DM5PR12MB1225:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1225B75A6FF0105DBBDDDA15FAE49@DM5PR12MB1225.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XOK7t/bpGo4289BhQJkrZG/fk73UQCNBr/oCcc3Xov6hxHZjxYjFWosipIMnCHMEsXfuT2XI6Zcf9+BpjxZIerO/aUBgeCZB5zrvli9bKN5bCjCuEBgXwJ9PAUZ+iPejSLi+dOVPaE1GwN6zEaEDfRcFDKH59CVYJkTDIRVyFu+t6bKwvTuSkscG/ZzJFUUiaXcEktnWnzDZ8JkUukBWfu3zRLlJ8pYPaTCFJeczzeAmwN/RpBSSfihGEucm5cz39fQj81YQC5gZ/0Se85W/84vEv4ADxtjLBuefl/mzbzG7HOYI7Ai04KtGD8R9i19JI9CPuAiwVXDlxLIODJTpN9eHwNWOwEeQwIwmzOOn1GJmzy4AkxZkD3VGyljAmDDrJ31x00eS709rsyNJZa9/NKDXoSDx5C7qnjpBWy4Zo5dyGD8K/glU3Fy0v0avFnF7P5jAxZw54A4DrzoTkmr6w39jVwMqnmWoyaAbZ2yqCAEZ1XBIwLjWgZEQ2UpEivvDbf11YebkXVCLeO5XWv7e5ylMAKSuwsXte/r4j0Wyy8sVCIIzPxT5oe50vJ5RWfir2nbF7n/SRGEcVCpVGU6akiISsA11McQrFfCd93G1N1tHG3oDhOSDObk7l+9tNShIC4vSP4DJCCZ58izyyIJRH2P+EtkEL+pxUwG6CSFlMGT5W9HEbAbA0euGSNHRAHzAEVdHoljO3BhgbQMmM3ThhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3949.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(86362001)(53546011)(38070700005)(7696005)(508600001)(9686003)(71200400001)(2906002)(33656002)(316002)(4326008)(66476007)(186003)(83380400001)(66556008)(76116006)(66946007)(66446008)(64756008)(8676002)(54906003)(110136005)(55016003)(26005)(122000001)(5660300002)(52536014)(8936002)(7416002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S54Jm6A9SX2LnQEDRMgTv80EAcQVEO0djV06AdGkfZ+XxBaJBx4yyrQU8sSZ?=
 =?us-ascii?Q?YQeGo5iUfOLFlVq/g7EEDY5j1wdbM62u3OIQp2Ie3uncDqecXqlXo6xOk8Xw?=
 =?us-ascii?Q?gD5BsM2rPp7mxsgE64oCmLxzJJTUqXkn2zJxgN8oJx7XFxlbCFC9L5sn0KZP?=
 =?us-ascii?Q?heHrQX027DOM7Q6s9ZmOjfsnbm5aECKCBGZPj6bt2Q1o6Od14MJLWdP54vCM?=
 =?us-ascii?Q?tdL+Ncwgv24nGU7raa3O6bDud+0WX+wnwNCxyeGC8Rd92khY9eB0Erm/rGQi?=
 =?us-ascii?Q?bBPBblhMBgCli7CNPmSDwF0SKSsZPCZqUY4ZfYVjD+uUitEedQ2x47X520d2?=
 =?us-ascii?Q?8qW0NxoJ8TXr6RjMn7fNhqx8hWFLRVqhzX7r48V4AfOMJe+/iuL0mF3LOUR4?=
 =?us-ascii?Q?4HfEj043zlrU66feymCFiK02a/pWgnTmft2XeJa8aOEMxNpOOkBY/KlG9nW0?=
 =?us-ascii?Q?rafZybab2MrzO5egonWdrTaiB69Vfgj6F+5CWKzFQmBDtAhpXz5/BQ4Afmeo?=
 =?us-ascii?Q?EmGqd2oo5tqeHES7p6mzWqcbXSgRdtMj+YHD9xEhWC2LwKoW4JNxoxjpuufb?=
 =?us-ascii?Q?SYz4Ik/zjc+/FfJ3MglQ6mUmwIv/NPJd4QXWKsqAE98U12ojS3mCJ12Qb+9l?=
 =?us-ascii?Q?5FYpM2+fCEODIk2IrrhwbfcgkYWFT6yil8RLuOzl71tDhJQax+jjn1RxYdvQ?=
 =?us-ascii?Q?OKJ2mfwVFqOF0CLO3D9EnoQhgUutANdNLOoIBu3BLsynlDe23uBJaquLaX5g?=
 =?us-ascii?Q?AB9SYls7wr5dMu6BJe7ZMPU8V8WQkiB+oU1t0rRuEzKHvZi+N5p2Jpi7qLzn?=
 =?us-ascii?Q?rkztuEbDj720sGp/VPrPyHzvczIixetAX+LHrc+TGbIBqwVA3frtGFWANwrr?=
 =?us-ascii?Q?0wE61q6uq6qj/WA6vZx6miaSANxIXw/v9T5SxHDi2YOxl3tmGdg9tVmvFTmz?=
 =?us-ascii?Q?c3SGxRzZPypZUXZ2su0aOWgStDZfzBzSzh/mnqKDV580BhwcHa4WUD/iZykI?=
 =?us-ascii?Q?1c/jWGVJnb5Oq0xDO6f9Gj+l1yZzt6wTcKvuynP/yTB/fz6A0OBZ5ySvoqc5?=
 =?us-ascii?Q?V1DzMWlHEnNRhLFCxvm/MqWD4ei4Hbvyshhr5BdMev0mvvLceoLsUzGmFcYh?=
 =?us-ascii?Q?hFKA8DYgMxDizMUKg055X//65rfUSSCo2mgwe59121mdnpngll3T3vL2zCDJ?=
 =?us-ascii?Q?zRq70Ni0dE+s0An1R6CsmdwvZyeKuzIkjyERsArM5K7nzbPrqOyL60tsuiCw?=
 =?us-ascii?Q?1rRfHS5XI7+vAQHy8zahpMvFd+2MLQENgrDrAc07pMCnPKgLeimy/VZXdm7H?=
 =?us-ascii?Q?ssWqvq3qHnALd0OnRBDHbd+h+rRhO422N/eLa3oi7wB/ykE1nouFa6INe4Yh?=
 =?us-ascii?Q?ju60mKErUDdpUGAzQTVAPw89Ew4Q5IBZ7g0aDzacRrBVdMmV6reURi+juEUx?=
 =?us-ascii?Q?x2rLKtJYMRw2ojvVrR0JFaXcv7Q196QuqyCu0wDPYjn2EHuR+NB0t76IJZ2b?=
 =?us-ascii?Q?Kh3MbFi/uGIznECZ8eicciKTvzJmJD1TcNBRvKOVRwx5QPUsjBYAfmFpKNXB?=
 =?us-ascii?Q?joAVdZNECNQckddjUbdtGr/I3BZgh8QyLzfVgv2szOJLNxftnPDD9wRL+2oV?=
 =?us-ascii?Q?wXvjRP80BxjtEp/+65j0URMr5RZ/qNrTyRHn+clqL/inmwyxI8m8jC+0Ppsi?=
 =?us-ascii?Q?1+XRxa61K+eG4xhnFCsiAWNqasP7LxidlBH4Y1Q2PpuIZq5LBjtLA+iZjsc+?=
 =?us-ascii?Q?ubIQazEtKg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3949.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132ce947-94e5-4db7-0e47-08da17429f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 20:26:53.3357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXnOsvUA/qOzDzxvRLdqD525l/jBfXiZ9AezPUQ5nPhT8al2PB+34Pvp684gcteUfR6rguj5TvRus5WN5GQFjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1225
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

Merging some comments from subsequent threads below...

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Tuesday, April 5, 2022 10:06 AM
> To: Karny, Wyes <Wyes.Karny@amd.com>
> Cc: linux-kernel@vger.kernel.org; Carroll, Lewis <Lewis.Carroll@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Narayan, Ananth <Ananth.Narayan@amd.com>; Rao,
> Bharata Bhasker <bharata@amd.com>; len.brown@intel.com; x86@kernel.org;
> tglx@linutronix.de; mingo@redhat.com; dave.hansen@linux.intel.com;
> hpa@zytor.com; peterz@infradead.org; chang.seok.bae@intel.com;
> keescook@chromium.org; metze@samba.org; zhengqi.arch@bytedance.com;
> mark.rutland@arm.com
> Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
>=20
> [CAUTION: External Email]
>=20
> On Tue, Apr 05, 2022 at 06:30:21PM +0530, Wyes Karny wrote:
> > From: Lewis Caroll <lewis.carroll@amd.com>
> >
> > Currently in the absence of the cpuidle driver (eg: when global
> > C-States are disabled in the BIOS or when cpuidle is driver is not
> > compiled in),
>=20
> When does that ever happen?
>=20
> Sounds like a very very niche situation to me...
>=20

This happens when:
 * User disables global C-states in BIOS
 * User disables cpuidle (e.g. idle=3Doff or processor.max_cstate=3D0)
 * Kernel does not have CONFIG_ACPI_PROCESSOR_IDLE
Genesis of this patch is customer performance observations.

> > Here we enable MWAIT instruction as the default idle call for AMD Zen
> > processors which support MWAIT. We retain the existing behaviour for
> > older processors which depend on HALT.
>=20
> Please use passive voice in your commit message: no "we" or "I", etc, and
> describe your changes in imperative mood.
>=20
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.
>=20
> Also, see section "Changelog" in
> Documentation/process/maintainer-tip.rst
>=20
> Bottom line is: personal pronouns are ambiguous in text, especially with =
so
> many parties/companies/etc developing the kernel so let's avoid them plea=
se.
>=20
> >  static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)  {
> > -     if (c->x86_vendor !=3D X86_VENDOR_INTEL)
> > +     if (!early_mwait_supported(c))
>=20
> Isn't it enough to simply do here:
>=20
>         if (cpu_has(c, X86_FEATURE_ZEN))
>                 return 1;
>=20
>         if (c->x86_vendor !=3D X86_VENDOR_INTEL)
>                 return 0;
>=20
>         ...

Yes. We felt the code more readable with the prefer_mwait_c1_over_halt fn.
Hygon CPU init indeed sets X86_FEATURE ZEN.
AMD CPU init sets X86_FEATURE_ZEN for family >=3D 17h (not only 17h).
Cleanest solution might be a new CPU feature (e.g. X86_PREFER_MWAIT_IDLE) t=
hat
gets set appropriately, but that would require touching more files.

>=20
>=20
> --
> Regards/Gruss,
>     Boris.
