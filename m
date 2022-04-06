Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50964F665F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbiDFRAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiDFQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:59:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888AE23AC8A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZX14ZkLojKJ6EIsVWNcd7aLpOUug/EQ+RptYEfrH/iSYp8cKoOzevNrBZFr+eucVqy5ltaEAxAs6aIXbzbyncb7hZDFBrUM/gLP/4mGN85llKvGjkn5xDY0ZLIxAYaDr6JUDs/lg1oWoC0hp5bVDgpoqjnT8ktG7HKUsJK1ZjPJcof0gl2jk0w0vWa2nlz+KtM14qhMDqKDDsYnP64n1kAvEPvnxwzU/kiiMEMrd/yNrUdFOloE6v8xFl9UxQpaVnc/+T3IJV3EgR3lPq/8eZpds4N+LTtd6cRQ0LmR+7BwC9s/N8axOnRPBUrRSov5x9blVfld++ZB3s2Ocj0pTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF61b0zjq3FrRXOja4kHQ32pEztoY62iEIidEgDh8R0=;
 b=ZfCPZP3sw7rFP89vJ6H/N8QKTkTOjircz/7n2jqJ3Z6lrCwwhwN6z+Ls+iPdlDFyDuZXUeQ15kZTllFIfT1IIZe6oEynbGjzfTwdI5F+ZLqC8bmQ8P+/7E0y83dWfvlPpEA6ZS+zJAhogoDfgP//tbHH5zz/xn2TC1sQjm/GrCGnr6nsOwHulN2OCSq9GqPnQBOIsnI150o6ydxOguKnsazUWZXKaCpndPB+CjT9CXOU2NbWzAigl63mzgJz3eZePjmhTyJsd8YwCTOiiF4ICMqZmUfYppD+SCfzhIC/nzcRc9o8K8rgzWqWlprN4AY8yxSkUajE5hf+nGuFeMId5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF61b0zjq3FrRXOja4kHQ32pEztoY62iEIidEgDh8R0=;
 b=YXX+4ZgbobNlLfTddXeFQJNLxOzwKMLDKjjll4YvslPuONPSg8JULIfPaR3AI6V+z/wDeAQ6FlqE4pAiVUDIODGQz5/10ZymMLtZr5grthlzJ2JQ0i/o5+KbMWGSL+0dM7HwHup+/rgByrCPgqoXOq9h2wu2O3Z6WAUenIWwdM4=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN6PR12MB1348.namprd12.prod.outlook.com (2603:10b6:404:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 14:23:37 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 14:23:37 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carroll, Lewis" <Lewis.Carroll@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "metze@samba.org" <metze@samba.org>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Topic: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Index: AQHYSO0si5fvSUiei0GnFDYbI7mXuKzhWxKAgAARiYCAAAWWwIAABNIAgABQN2CAAFaUAIAA0EgA
Date:   Wed, 6 Apr 2022 14:23:37 +0000
Message-ID: <BL1PR12MB51573FC5B880ED914628A95BE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
 <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
 <BL1PR12MB515745615F4C92627033CD5BE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5873a444-bb32-f0d5-27f1-173f469baf21@intel.com>
 <BL1PR12MB515702C06E483DF4EB78A7ADE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <87a6cz0yvh.ffs@tglx>
In-Reply-To: <87a6cz0yvh.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-06T14:09:55Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d504bfc0-496a-4602-ac3c-00991c40944d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-06T14:23:36Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0cab68a5-7404-4d3d-8394-a5498d03ec2c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3760e40d-b9cd-4eee-3f61-08da17d90a95
x-ms-traffictypediagnostic: BN6PR12MB1348:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1348D6A8323345460E03751DE2E79@BN6PR12MB1348.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ShQ5WCcGRZwHiJlIFaMXV5XXQHH5SdNdkPF/Rv+ArtsENKguLVbLTPgqZCZ9nIMejyKQUCnOmWYV/1pAEilDL2onWH8yM4GcjojrEBfmhcNZUIvQt71JwkScflzKtr8w3T/Sv15yqMYp9sKsZT+mMlvCn2SOlXHUmMAUkm6qzxXMtaEc7cG4SSuWeqvfpr/X7b9y0zJ21RoRl27nEgWAnYYxkmp2tVJ5HRzwU6/z7MtKrkl29KuJ09bN6LYMAz+gHZBQWOMjnH4joktJQIbaV0hZ0F5Mr0X8vX3lI+EUPxbm1h0qIE7z4bP00lVXIOZnPi5wvB9xnDNR/qd+kBVJD9YoDzltNCxEe5GT2n75+FvPhhbk7DBl3nYW0usnYrOG/6IzqFizbhhSHnntNawfJFmI7FEmxggD1p8csBK9VNG/yrGFRUQRKK9ycbRiruygs/qcAJiiW2m3HsFzt45X3m1GNZ4AaCAv/mtejZIvL609uXdqbu+mVw5030YvWmKlD8lBLgioYFnWcgXAFrnFq1hMdz0fYzuctGqaId4pVdjzVseo+Jqv7CN+AkSEqBYtFkJoUL23YuEgUZ1f9G4BZt1gQcDVeFW9OoUMonJ9+nfBKMKyfCtKtlSwt968NbeMBDgwOOITskm++PROsNe2I4/OXt0uVr5p6cUiL1Q9h06YiinlghM9K+I+zqgiBdopCN/p7xPYm8hBMx1TcjxHoZyfCsbmBaCLdtstp6Isz+D5olQN79L9f5u8+3dWwAwPEM177FjzDv+0uQ7Q6bstSPhr7iDZYwtndGNt8VIVW8U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(4326008)(316002)(71200400001)(83380400001)(33656002)(66446008)(6506007)(110136005)(7696005)(38100700002)(966005)(8936002)(54906003)(52536014)(6636002)(66946007)(66556008)(66476007)(508600001)(7416002)(64756008)(76116006)(8676002)(186003)(9686003)(38070700005)(2906002)(86362001)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EsIZlKJEMLM+h0dEnHvzYIkqT3BTW32f37YuPP05/QL3YJR89+MDXG5UzsT1?=
 =?us-ascii?Q?kHBbKufxzn5CijaFoHGOqCDHKsoIJlpF70yJoHclOTsVp+oPCZnxpUhwPrpu?=
 =?us-ascii?Q?uuF+oWASXKGj+JQpshoG47IIrtulG2zmdKB9qbg8zcDDA/AnmGKA2A+ygvTI?=
 =?us-ascii?Q?IqmRw/mv2COBERZoT2J8NsSRfGdhM4N8SyVvYtJ36bFMzx60cmSwOAnu5VXA?=
 =?us-ascii?Q?7ZJWwtQhKYIJ2M6DiKNtpdqu5oSACwbmykVrxJt4vg3ooYnEqxOB+qlLHXh1?=
 =?us-ascii?Q?MLszvHVZ9HoJbh8Xh7wAnQkf49z1OMhw60GFEF/R3k2qOIJ6NlcqJEEWPywK?=
 =?us-ascii?Q?5TDuzhwpsSJIx+y1hTtbQifDfXVj/KX7/5xcKS7kQE/inErOEIZKv3prC9cg?=
 =?us-ascii?Q?pXU3K6XKnNNQ4xbcZhKjdvUXSjQRc0C2Y5xBG1UNAqBfKPjW2UfZ3yEjIpQp?=
 =?us-ascii?Q?yvlomZUn5b6EnHWZ3cAgJAlVqugBKEPQ87FQyU38MznUtbec37CYgF3IEjjk?=
 =?us-ascii?Q?ceeYYZfSgnZL7hhN27JBplYS8V3xDpcZdbKPVjn+1L/I9xoiONJ3kgaqy2O7?=
 =?us-ascii?Q?YNBlbYVk13ugl75CA1iWVXC0Afqnzrom7t13j8cK2z2uAyt8DEDai7sYcvcX?=
 =?us-ascii?Q?UwJufhy3Vq2zoLJzWluugDJSMzH7GbH3n4gmg0Tdh+6Norrlo6uoY+NN+Ftg?=
 =?us-ascii?Q?hvxYo82LEB1XPLgeuY2QSWbgp9SQbz2jgNdJA2SCxRZ17aSVxrHR1sOGL4OH?=
 =?us-ascii?Q?mcef9RjvX6CLQwPvPNSaq+NDOjGz2h5qMZ8/Zcfp10bGtRGh91PG8ZGd8Smd?=
 =?us-ascii?Q?gLmBiIr1X8fvpnNaSEtJfJMyyl+EROkhCm8HZdcFyrEzPnTJgt22QseLzfJB?=
 =?us-ascii?Q?pYJmCxDj5yyPCkuJDv2aCZugJzvdwzF3qr7x0TXRZZbUkPbmhBl3CKVlJsj/?=
 =?us-ascii?Q?M2U9B9RmIIabKI/J9t1CiWCLAMZjWloahbwhGjLaxPSmilghv0PMtao6LoKk?=
 =?us-ascii?Q?2Te46A+/DFQF94J//W76N2v/+4xB2mHC9PmeW2BrMoq53r2qz51sA3+bmGAP?=
 =?us-ascii?Q?7woz2wWhKJmh0CWhsWBlINKPpJJb0JpSKWxFuMxFMLto6HkUYNy4qqgL+eXE?=
 =?us-ascii?Q?4wdycPVBH9IzrxBqudAMlDFiORzdhW7H3oNQuE/qYfNTO2kVQmRJ4tWG5wvy?=
 =?us-ascii?Q?t3V2IsZCkVOBhZkz7Dd9mFve7vJog4r1At7+z2DdNJQ8d1XTqiUqA8JnRDYK?=
 =?us-ascii?Q?M+6oz80uyEGCJjoZKEA0b5xotvXnF7AkeQUqU1xM9OeI4uNB9O1ZKK5ZMP5B?=
 =?us-ascii?Q?zvv2IhwfC8S0hGt9H2XhCij82jvSKumaq+z/64+eWdYYiaFDSU+4COHXaJff?=
 =?us-ascii?Q?OWZQTk/6mlGHliaGYWCeEuwVHx3CfPxQo9o+F6DLA069pCQxgCu51y4s5GQc?=
 =?us-ascii?Q?+Og4LRG7AyX+QaE2bIR9vbvP4Q3C/fSkTfHR+syM0PIEODxK5iJqVPAMxYdL?=
 =?us-ascii?Q?//khhVBt1fuFeJvdmSR+X2VjQyPLg//RYNzLWto0B71XYXAb4uEi3E2uCxQW?=
 =?us-ascii?Q?5HDR1CaWK/rWDtRnBOHDtrnzHxjPs9Pmj2W5WBSMqSiEXsyt9YFRNiAmCQiK?=
 =?us-ascii?Q?Tk7DDPMyytJZjghtYGitfDjE1Ou7rhgIB0AnVFgHVidFmJHv+IUGs1B0rlBU?=
 =?us-ascii?Q?C4VgyHTFoKpWiqn4UqkEgfPMp8Kv06BMw2NLe82yDIy/m33olPmZcy8giPkj?=
 =?us-ascii?Q?bU0FVu/wAyzp4Hn5uFTUTmDqxtyGlWVloFbggNgYkn+koyQWLqvMgtUuXrLY?=
x-ms-exchange-antispam-messagedata-1: 8/KQp3PJJX1qQQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3760e40d-b9cd-4eee-3f61-08da17d90a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 14:23:37.7367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9byUndFM7RjUDrBWGrEF7utem/Zu0r8EzriyItVwpWVF82sdcf0NMByCrhdQI9RlCxZVnKueN2jR7hc6PJOm4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1348
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> > [Public]
>=20
> Really useful information that your post is public while some of the
> earlier posts in this _public_ thread were marked '[AMD confidential]'.

AMD's mail system adds this tag.  You'll see it in my next reply too.

You might be referring to Lewis' earlier email that had "AMD Official Use O=
nly".
I don't believe anything has been tagged as confidential.

>=20
> >> >> This seem _bit_ at odds with the commit message (and the AMD SSBD
> >> >> whitepaper):
> >> >>
> >> >>>     Add the necessary synchronization logic for AMD family 17H.
> >> >> So, is X86_FEATURE_ZEN for family=3D=3D0x17, or family>=3D0x17?
> >> > There are Zen family CPUs and APUs from family 0x19.  Perhaps at the
> >> > time of the whitepaper there weren't yet though.
> >>
> >> Is this a gap in the documentation, then?  Is there some documentation
> >> of the availability of SSBD mitigations on family 0x19?
> >
> > It looks like a misinterpretation of the document.
>=20
> Not at all. The document does not mention family 19h at all. So where is
> the misinterpretation?
>=20
> Dave was asking for documentation for family 0x19, right?
>=20
> > Notice it mentions in Non-architectural MSRs explicitly:
> >
> > "some models of family 17h have logic that allow loads to bypass older
> stores
> > but lack the architectural SPEC_CTRL or VIRT_SPEC_CTR"
>=20
> That's relevant to Dave's question in which way?

The document is proposing logic that includes saying that if the CPU suppor=
ts
the architectural MSR then use that.  If it doesn't then do this other stuf=
f.
It specifically mentions that some CPUs in family 17h don't support the arc=
hitectural
MSR.

The document is *not intended* to be comprehensive list of CPUs that suppor=
t
It.  Documentation for individual CPUs indicate the availability of the MSR=
.

>=20
> > But that is not for all family 17h nor for family 19h.  You can see ear=
lier in
> > the document the method to detect presence for SSBD which applies to
> the
> > rest of 17h and 19h.
>=20
> We know how to read this document. But this document does not mention
> anything else than family 17h. So what are you talking about?
>=20
> > That code in amd_set_core_ssb_state is only used for one of the
> > mitigation codepaths without MSR support, not for all Zen CPUs.
>=20
> Again, how is that relevant to the legitimate question whether that
> document applies to family 17h only or to 17h+ which includes 19h?

To confirm the availability of the MSR for a particular CPU, you can look
at the PPR for a family 19h CPU.  For example here is family 19h model 01h:
https://www.amd.com/en/support/tech-docs/processor-programming-reference-pp=
r-for-amd-family-19h-model-01h-revision-b1?msclkid=3Df5047d01b5b211ec8d619d=
1385260e2d

>=20
> We need to make a decison about what X86_FEATURE_ZEN means. Is it that
> hard to give an authoritive answer?
>=20

The comment currently associated with X86_FEATURE_ZEN is appropriate that i=
t
means family 17h or newer.  There is an ask in this thread for clarifying t=
hat comment
it's for all CPUs with the Zen microarchitecture, and I believe that will b=
e something
that Wyes will do as a follow up.
