Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1554F8C98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiDHB03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiDHB0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:26:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EC915B992
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEtoD1leiL5Dc/7e9RT8I3tVVIlhQYv9ozeGHdBR2Saiwz3TOqjyCqY1HnUkg/xhVoXv2WInWiyYXV9UqOeT0aK4wkv1kMN88gib3hk8ML5IgB4+TuLda8hByPd3e+Vpg99cIn5YEaquLDNRlwrmLfWVZLjzDCrU+0DBgMctzHQHjPFciNm99Ib9d9h0y6g1vJWY3wMzxCLWhEIpZrXrrCB02yDzGR/9kMwN6QeT7S34wlEoT2iAfhO6zBHXP0v5C75fi7C+APHT5iTwksxBVQYevxHsA61ised7Z7bZsSfDQVS6fBtziMHnO6tRwK9NFuYaIHlA8pai+X3WHqz92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ1T+GzBH5fiBct+wRl8HI92jH9dDQug7a9NRntLfFI=;
 b=PX5tW6fxqlnEfxwjZA2TT5tG5vZg2u24sTJ0M0m3/dW2VM/jTuixK1lAMJ9ZVq7glJw1RqOXCbRoDqN3GUzbZINM367Ntu+GVZlAysXdhHoZZ2ntbF53LiiQ5Ah8PZGGaG/9/FtuS4SVDkZr3P704ltIvZzv39oJBCAbK+umNfJdIR90YZj7E2RmiBt3GstF5HRdWRtMlzMFnY2ZfNu9nfDYMGm/oJQo++cvzQfwH++53y1Evv6U6feL7VpeJaP5ZAZfJhxkP676kmMHyABM6YlkHKNhMVl9f4QjtJcPSPC1aiCvYFl7P3AC3CBG7E67Of1A/Ox3ndyLz7wcYuf5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ1T+GzBH5fiBct+wRl8HI92jH9dDQug7a9NRntLfFI=;
 b=ONQDsteCz98MCSPzd8nj7BpZvN8DIbbSVyZRLh9nnU5MZreszhVlTLByeT4UIv09CnGiWfulZcCCnxanXNZUbQY5qxsHQSvkREyTs0W4U5g+jPaSdc/V9S9DFZNydljUgbsmKbq5zu3mDtQAa11et0IhAnPhl3DcQehc/Xr04OM=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.22; Fri, 8 Apr 2022 01:24:16 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 01:24:15 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Thread-Index: AQHYSO0si5fvSUiei0GnFDYbI7mXuKzhWxKAgAARiYCAAAWWwIAABNIAgABQN2CAAFaUAIAA0EgAgAIJqoCAAEOtoA==
Date:   Fri, 8 Apr 2022 01:24:15 +0000
Message-ID: <BL1PR12MB5157E978932A02865541D319E2E99@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
 <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
 <BL1PR12MB515745615F4C92627033CD5BE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5873a444-bb32-f0d5-27f1-173f469baf21@intel.com>
 <BL1PR12MB515702C06E483DF4EB78A7ADE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <87a6cz0yvh.ffs@tglx>
 <BL1PR12MB51573FC5B880ED914628A95BE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
 <7a95b837-e347-0ad3-3a2c-f347f12d6625@intel.com>
In-Reply-To: <7a95b837-e347-0ad3-3a2c-f347f12d6625@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-08T01:19:08Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cad3d196-64f5-45c1-bf9c-c7b732cc4c92;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-08T01:24:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a59c4853-5e68-4d35-8725-5a44e7ccb94c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f6aa25e-a417-4f5d-5b7a-08da18fe7f1e
x-ms-traffictypediagnostic: DM5PR12MB1514:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1514C66C3D0AB23AFFD0AF61E2E99@DM5PR12MB1514.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1efFT9zBdTAWRVF86ItMbzonSo+IBtQObeve2zabn38gaWseDu/VkeRCWg8f20VLavHjYZTWfdnjR9TJ8QHBOXhcQmRe/S8+qvZTlQqMnyAYmUYJ4GyZ00s6fCqQvg94egVGqrqqzN3niIgtgj2PFhUR4D1B59cOAXoOq21XY8VdW3lbw6V91IBWrfHzThKQqA8N/zA1hfQhU6pnKQn8+yE/vPD7xgLYC7uW3ZkUHdXB5j/k9d4GuarA/ZQ59geYARMU/WonvxANsLokq67/kJxoPnLwbW7wFGa6+zREqZEE9eVsMyK6vjjpwKQZxf6aGBLwemPFBAcuPJV3fuK0+0+RyPo/CWL59QkOgLVtaMhnU44SC3dtdPE8t6AfH52WXi67N99wcqwcSbSydZDfmpInvQsfceL8nutDtriqbeWFxg/0vQ/5iE9VccvKF+84/ctNKTwrqVat01YesT/9tQGZfkyDUGOUjH3nLuckxr/QzdRIjerbw+yxX6FWhS5TZOOhoR5X/d2shiy5zUtpKbJspzhuJqJmiUzBtRun1S/1FZmeM1MiAT3VRy/u/PdtRSaCaVuPev1js+O5hbJVH3gZYySL8c63mXZQ5G2otxYhFGzfRJ51nv/+ffxFOFa1vYURYjxX6a5oaeaABB7qHO/jp9c9rGEapqQxHLFVf7PyRb0BK8zNyFGfB5V33GYwLdVBCcbudrBqCwOfr2EhkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(122000001)(64756008)(76116006)(66446008)(4326008)(66946007)(66476007)(66556008)(38070700005)(8676002)(9686003)(71200400001)(33656002)(83380400001)(52536014)(55016003)(2906002)(6506007)(8936002)(38100700002)(5660300002)(86362001)(7696005)(7416002)(316002)(6636002)(26005)(186003)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MMybdRaz72E/ogwGEypthtnrFKOo1N1eVoZEmNpA7sBtZsqvBV9IAYDO5lTq?=
 =?us-ascii?Q?eSg0d5eHAtXykzbn6mFyE3RLyUxgvknWpf+gS1BbksTMmIrNyT4XowJPeOE4?=
 =?us-ascii?Q?Z3RsEHj9QVmDwkTHC1zpeRfGZ+2HWblQi5xw/ODUzwypNGeuFwcpHuX6EDCx?=
 =?us-ascii?Q?1RwVwVM3Wx8lzI2SergbFe4piSQFuM4kLxh5dnzgACto9UMpqYOp91mA9W3h?=
 =?us-ascii?Q?F6LEOmu+Qq5xp5viRMEynZHvowl9+rqlEgKXzL+ZaRBBd3Ds0rdd/HVItRUL?=
 =?us-ascii?Q?OoyhxkmNaTSG5GdecbASuA0hheubnPSZsD0JtRPb3SHZe/2jtG4W19PCuBvl?=
 =?us-ascii?Q?qytPwI6cYIxOXqeUmpmAnB0goqiAS2dd+tAe+ZOV2eppShBbRw2VjJClOthU?=
 =?us-ascii?Q?BvfyTqtAU6t+HT5dPNxhg5e0Es2TVyzeypzgKZmgpSUTOWN9/CN4wgcu//HC?=
 =?us-ascii?Q?RKgQqlUL219wmTyAA1k3GGgMCCt9H/jIARRLrHOZDhCqXADlPWJs9lAAI9cO?=
 =?us-ascii?Q?bqm3cYxQ9zAEBY7njagK+61hhMvYT3AI0p21ScNDNrAvca5lPfjL2Qr/csP4?=
 =?us-ascii?Q?pL1ZbvvKYgNLE8uJA5rGw6Txxuz4prH9gdXhBtoLC49iL0hKfCHv+qug3j5w?=
 =?us-ascii?Q?9qfxaQDv7enkVDKsruracqtCYSl9Fs94sra60+9++JryL44NK4HNhUFGPilz?=
 =?us-ascii?Q?c/HK48SDCpNBYx0Nu5EmsbhXIJhztz9cPisS/uS7HRn/2xDmqEqv55R3B469?=
 =?us-ascii?Q?SRfrgXn8JFx1iXqqUoQFy+XL95RQayKFHS21KioHEw2J5cgg22Cvb5fHxfhF?=
 =?us-ascii?Q?iECV+Uo8w25sxgo/N7zmXzlhFFLQo3N6EeWtZUsaJvakTA7vx5qZVBUt/ZOV?=
 =?us-ascii?Q?7IcFecvL4sE/T5f0DgDIaHT6iEKb7WCG9h2dx/6y57Ql+oULPc1mTfoiNVyg?=
 =?us-ascii?Q?j8qH78pBvbi0pedOLTQ0HYhu8udroJy/lss/e/U2ZerJ0rg8+DdiFT6Lag/h?=
 =?us-ascii?Q?1saT+zr9mBUxUIVvLtdYTh40j2DQ0AsJQc3tfQOnDWPErPB7mRpTWNEp0oFt?=
 =?us-ascii?Q?YyzJihSGlfEcKd7M9JKsJ34iEaveCjiEsdrBdlGUaHR5INi372mA8G0vGDBD?=
 =?us-ascii?Q?PZZxG/JD+J6CM5NWA97XazUqmMw+NrYZTjLZRA5doE0awDrDzplkI/LKsRuj?=
 =?us-ascii?Q?II07eL9MSy8B+ydk/l/uikPbctbQ67FHQgDFcFfagciTxavzYqAN8sI8yuxT?=
 =?us-ascii?Q?JKkf+9/P7I1CI+N1CpkjgGDIAFjPo4ML1dg1K8BZiJjdnwQFmlqABMF5x04L?=
 =?us-ascii?Q?vkdcSAcRfnNPXgKrjxaZQLVZePM3JFlP0O+RIpVxqSLMoEprFcg8qmtd/Rxr?=
 =?us-ascii?Q?BhHC0dYRBUvMNE7XTZEMXSi5bqNU4Sm0Of/4/d4UeIIwD+dzSM7hyi6QCQOE?=
 =?us-ascii?Q?sMEJnhQ72iAKMSvlDfB8Ro/rhLnXSad1h972E6c6QuSqf4RDgl/S+cHsx8ue?=
 =?us-ascii?Q?/GRbfGg9U4hllZT4LiZfWMGoBKG/eW3/QuY6gaBAbXqlxy2+cndi3oJicsnu?=
 =?us-ascii?Q?Lyop9dYR2e35Q8BHyIw/xyqrdFuPr4s+a2aMexz9/P/E2nmacq29JgrXhbhi?=
 =?us-ascii?Q?PydMIv98wA16D/gk0E9/llMveg+yz2BQHW9AMCtEbSWJuEl6blrzYWYoNtHj?=
 =?us-ascii?Q?mcoDrQjGzLql8ypcBDQz4RqBf/LOGGrBy7fHjZVfYvHsDb+t818vWC6nwKXZ?=
 =?us-ascii?Q?vmtyCJSPYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6aa25e-a417-4f5d-5b7a-08da18fe7f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 01:24:15.8396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riKnxIIdFEvsCYl94uFXMu0c2Lk2kyMyMHOzSLySJzafTSEROiFxJ7DUNdcsYw52CnEjsIi4ciyGO1J2T4qb5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

>=20
> I don't want to give you too hard of a time on this.  But, that's not
> architecture, that's just telling folks what the implementation is on
> *one* CPU model.  Don't get me wrong: these model-specific docs are
> great, and I wish Intel published something like that.
>=20
> But, the code as written depends on behavior for *all* of family 0x19:
>=20
> >         case 0x17: fallthrough;
> >         case 0x19: init_amd_zn(c); break;
>=20
> So, while the docs for "family 19h model 01h" are *consistent* with this
> code, there's also nothing preventing the docs for "family 19h model
> 02h" from breaking this new MWAIT code.
>=20
> Now, AMD is full of smart folks that aren't going out of their way to
> try and break existing software.  But, actual documentation of the
> *architecture* is really preferable to what we have now.  It helps
> establish a shared hardware/software contract that keeps both sides hones=
t.

Point taken.  As you're probably aware releasing documentation is never a q=
uick
process, but Lewis and Wyes can take this to the powers that be internally =
to see
what can be done for the future.

>=20
> What's missing is something that says:
>=20
> 	All AMD family 0x17 and 0x19 that enumerate support for MWAIT
> 	also support this "early MWAIT" implementation
>=20
> That represents a promise from AMD that this can't break in the future.
>  It both gives us something unambiguous to write code with *and*
> something to help nudge our hardware and microcode colleagues if they
> start to do something funny in the future.
>=20
> Just having that in the changelog would be fine, and a genuine
> improvement over what we have now.  Having it one of the
> model-independent architecture manuals would be even better.

OK... I think the commit message and/or a comment is doable in the short
term for v2.
