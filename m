Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C85A70DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiH3WbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiH3WbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:31:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A34715739;
        Tue, 30 Aug 2022 15:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksGiGD/BQoQzfEz/0nEN7HQrFK4AcQvMU2JwBOU27dxUXoZsx7gmR4nMeCOpuDELaaFsmq0JyXFoiqMAYo68a6SO4CV/yrwZpglGdwiy5DOzBmcPnTQDUlGAeC3XGyMAO4WQyewcDKrMpnKLHxd45tfsG43qV+ikDhraaBsvD4QuPaBUg1+Q+8rzCVmvZAD49bYCY/ELIfpOY+FDIM4g3dvqAEzKlgxWx7x9t+nUfp5ouNUMuKkxCPSmfWtuLqRYaV0MwahyCXcxziVGoljeqbQRdOtUZQySD2QdHE7UAVcgbp23JtPAWhFR0oM74rFDgjqd1HwON8z6UeDvHUfcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYN2oV0rmHFWHE6/9aOun2ZFj5dcSnrBm3QUdAGZqqs=;
 b=SJ+uRIwFpSEu4d+TJqPymLKlllA8q69L5Ua4cFeczl76uAXZiKtu1oHzAl+K/zXyNZPBARYGmYY8er3AqqsX6QIfgs/vyPAWn3/YBNNeW85e5V6Qbnj1mD71J64FYoTKtmm09ZN/yZYKPqjy2M10jppxRp24alILmCJPRwIPd3rBfh1pUCKMeSWhzd+ECvxp0j5PBXx0iEFfNLmiUbLB0prui9XUTaYtDXBynDhU/h79S/LvY44LEyzRORrzHjvh648ITrUe1pKq6zBiGRUNe2nD+cg4SWlAOI/W6UAvQCd2jyJLw2+MO8zxSoE6dfvIksOAxdvaZIghmyhxmVFuxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYN2oV0rmHFWHE6/9aOun2ZFj5dcSnrBm3QUdAGZqqs=;
 b=es29bP1MbWZWeW0z1P2xFnaBva9ixL7ElbT7caRBTSY5dbaa7+LshDrVRcSNLsmNwLd1jl+hHwMa3i35tzQVFwJQXP68BYlUje3aN3iuVilqA/aW7LV4dNlPl//B0dNNWSuCibOh1N+MUh2w7aqyit/UEiag88qAiYvjMd/u9SE=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 22:29:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:29:00 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "eranian@google.com" <eranian@google.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Thread-Topic: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Thread-Index: AQHYu/6+97Z1rqQba0+RuPu1SMOwwa3HpjGAgABg2VA=
Date:   Tue, 30 Aug 2022 22:28:59 +0000
Message-ID: <MW3PR12MB455321E78C1D50181541422C95799@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <9965edff-c558-2962-4aad-3342480026bc@intel.com>
 <20220829232554.53763-1-babu.moger@amd.com>
 <59259155-6c51-a750-216a-ebbb0702d200@intel.com>
In-Reply-To: <59259155-6c51-a750-216a-ebbb0702d200@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-30T22:26:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=67a9fa66-ef03-4b89-a055-5160f044eaf7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-30T22:28:58Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: df93114c-3a1e-4f02-8b3e-ee11414b8d39
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ee1d03d-db30-4575-2a0b-08da8ad70907
x-ms-traffictypediagnostic: DS7PR12MB6095:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GasiGGSmxgOIFIESNvOjMnVznrHtF4RJYq4AzzyoeIEuOw0E1NW+OX6mO6XslkBApXd9BfNOkBYR/4oAMh2VuFZbWjfMHHaeKfirJWEMcezap0hcu2/aLXJ82f5a5R44AXGPbDRySIM5yxPdUbyqET44O0M/6soxl9HvKf5tQoLpvQ4VFILxNGRNs0K+JfWPYnIO+pbEwyKrcVuZPhyOcMIMbmwp+Z9tDGk1lcBAvlDmA2izE4HMJ1R2ul2iB0ZHnjwt9Kr8zitQZYb0dBAm5436Dwr0wcHegJvtw69rgbSONbj+61+hO4jd5oxIkUIoYyuvTjBD9pi9J5X9PGLjhkaPtydr1c/5+HT1w8Ube756Ml4Vxrr/zeB4A+mZ1GeCreMg3cc3c+KLbxLSutMR8tp4VA4jue/c/o/71xJrLnqDTYsB16cc6xoht2QXENSR1UprD72V04rTaNsUtfURkwIXQbqxSmp5efizkK4/8gk2Hsb781hhScrX/MHl/G1OFPK51Ms1nNgYY/5rV85Epu3bXjU+gmWrrlnNOtqgZe2l7OniLHejqB/9phrUC2dnJ0Lh/u/zWhJHCxFKU4gIqn1QvmTHIVLtckH5FUfbUHHaqcuujZy4oPGkG+BsMVlDcqdduJEWZZNOTEB5DiyI88uSdsf1tdYpoYf7B1joK1JOrVMIsTuHsUQJmvA8ntqL5l6v0IUHM4jpVGz4rsUiBExFDi/Ud33Yd1P8Kih8X+TURACQVaRPqIzOcy4HyMEeRbLtzDFtG+dzTuWkidnkuhyt5FnOkFoiANV+r2P2qaDdbQeVRKw4uLITCwdjm3iAT6Go0caFpVo+NhWOu3/nYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(38070700005)(122000001)(83380400001)(86362001)(186003)(38100700002)(52536014)(5660300002)(4326008)(55016003)(7416002)(66946007)(66556008)(66476007)(8676002)(64756008)(6506007)(2906002)(66446008)(76116006)(9686003)(41300700001)(54906003)(71200400001)(8936002)(966005)(7696005)(478600001)(53546011)(6916009)(26005)(316002)(33656002)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ie0bb7qm5hnYtE4x9bdU2tK3N3oxGRTXOTKci6mqVme76NbEybFze/IbKIty?=
 =?us-ascii?Q?pVqpDrOUeaqv1QvP0lF/hyTxpBqxCFB5WcFYCcHuDqZa9wlzePjag/darW2p?=
 =?us-ascii?Q?mgUO1Jf+oii1xnT2PEoKnNv/+1VaBEoMKUAWsVo599cPdbpqSTpUvMsE2k05?=
 =?us-ascii?Q?P/Kw/daMGdS4goOP4yUBVp0yYbv4KS5ZOqmdTnkkQtUWZGNZti9PGaZDQQdC?=
 =?us-ascii?Q?fcIij9MGONhBrQX5PGZ+JHLCbRlhOP/RgpebyzND//78uT8/og39TgEceYwS?=
 =?us-ascii?Q?mFmk7sZmnXtu7aG6I5qcwizf/rOUf9ir5x96JtT8DxjFmggnfeIx92c7SziR?=
 =?us-ascii?Q?E88+RbWFY9RCvfMqOdAYliAtda5ZafrkKsuNg05gG7+lAla8tBE9fRPkgNL5?=
 =?us-ascii?Q?5B5fjwBpg8wZnT6JcwPzIMbORu5sGsIV5eiRHtkEB6swrjyHhGrPXm2CPBCb?=
 =?us-ascii?Q?0MToihDTwYQoB+jQoSoUO4BBz7qghhvuFz0E+l/m0PP9L0R3bu+NUBjXppul?=
 =?us-ascii?Q?zkXIuRvreO68XuA6QbYv0e/ZN63IuijLfSqJWMJlRO4RQBmmQRsQj+9NvyFi?=
 =?us-ascii?Q?QEYu+LpcOnjXQ7lGV0xXgSR6tbqzMNLmykGPmDJUUVMLAfkph4Kxi3SZ8Fss?=
 =?us-ascii?Q?KYt+tCrOOuB2wLi4WwbWvvV2+6zzBqoVzjQVOcFeJUilGOBjSM+tl+HBHyPH?=
 =?us-ascii?Q?7kHhKbYxib6q+XdBvlXQFnwvxWNM9H3SYpbfc/O9gNVcw/KhSW9iWptJjK6B?=
 =?us-ascii?Q?KiqJ0e0anU/qziG2iFiE5bAuaR9C7JsN4RIsUNd9MerUBYLAEQkXYDlY2cmp?=
 =?us-ascii?Q?f3ZYCQE/0selgBp6WROMS3PPY4CVgoaxQbO0gDO5WybDE8uGSwh/hF6heuny?=
 =?us-ascii?Q?2nTvsF5HdwQFM4FLCCXDg4o/mDtnNguweRpob5UasMRfmu5MbjHtQt40Rwub?=
 =?us-ascii?Q?PG0eaPwepb1H40og006wJvn39jCPO7fgn/mf5v8gBZFku4QhhLYufZXqzyuu?=
 =?us-ascii?Q?6/PieKGvYmEuH90sT+rhDt60idLz39NqnXkxF4IwJO53h/Z3/wjnm7MRhw3e?=
 =?us-ascii?Q?sTb7864p6ADiBwc222nPt4I/S7pl5MrhN15j4JcE8shHeAJpDj3qlnsHd8s4?=
 =?us-ascii?Q?7iXNPI++Ul4t/v3XKv0FCuK9/VUkXiywrUaGLtl80qjEtljYFlbGtrlasnGP?=
 =?us-ascii?Q?FGB+RodlGped/8D9KOmxLYy86H9hS4BfpWDMCCEAu1jjMHPxSr6WxDI+7Omo?=
 =?us-ascii?Q?RCwmOYrSuMiBlh5yJk1dig2akF57whOP/5M/CMIbvFjOHoSmJU6N8yoNOVOo?=
 =?us-ascii?Q?rs6+biUHHR2ig73vG0bNlVDURtdNOqwsUF//aBc5FlYplSkvPbzGl5DbdxrY?=
 =?us-ascii?Q?1C7zFPOEVsz3kiFD8hCZgJSyHILuxUoAgi8n8RMBA0kNq2Pwnn1iPGPGCFVR?=
 =?us-ascii?Q?FeV4Z2RAEfddpJoLmqZ7BDEs2R0gykNF6ejHricHQY1bRnv6YvaUb9xel9T4?=
 =?us-ascii?Q?hjDsJCypswoIWnX9PsVhlWTpRNfq4rkjTjgapxLIrYvRQxFWXc6NOjha10qn?=
 =?us-ascii?Q?W89gHcFp56/GFhTwdEA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee1d03d-db30-4575-2a0b-08da8ad70907
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 22:28:59.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VuPeimKIjzy65FC1Mp3cnalnMNkc1MIOUi5dfK4C5Litzt26oTAKPqg4xoKzB7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Reinette,

> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Tuesday, August 30, 2022 11:40 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: bagasdotme@gmail.com; bp@alien8.de; corbet@lwn.net;
> dave.hansen@linux.intel.com; eranian@google.com; fenghua.yu@intel.com;
> hpa@zytor.com; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> mingo@redhat.com; tglx@linutronix.de; tony.luck@intel.com; x86@kernel.org
> Subject: Re: [PATCH v3 02/10] x86/cpufeatures: Add Slow Memory Bandwidth
> Allocation feature flag
>=20
> Hi Babu,
>=20
> On 8/29/2022 4:25 PM, Babu Moger wrote:
> > Hi Reinette,
> >    Some reason this thread did not land in my mailbox. Replying using
> > git sendmail to the thread
> >
> >> (snip modified links)
> >
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> > amd.com%2Fen%2Fsupport%2Ftech-docs%2Famd64-technology-platform-
> quality
> > -service-
> extensions&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7C5e1d3f7a
> >
> a30749a3841e08da8aa69bd0%7C3dd8961fe4884e608e11a82d994e183d%7C0
> %7C0%7C
> >
> 637974796714276452%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjo
> >
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat
> a=3DyGIo
> > q%2Fp9xD1i6IfrkPEUj8sg9Xz08r0jrNTvGK7khko%3D&amp;reserved=3D0
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
z
> >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D05%7C01%7Cbab
> u.m
> >
> oger%40amd.com%7C5e1d3f7aa30749a3841e08da8aa69bd0%7C3dd8961fe48
> 84e608e
> >
> 11a82d994e183d%7C0%7C0%7C637974796714276452%7CUnknown%7CTWFpb
> GZsb3d8ey
> >
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C300
> >
> 0%7C%7C%7C&amp;sdata=3Dqu1cxHp6nCdEFJbJv5QDD0tAHHaV4tJ63NKC9fIiIx0%
> 3D&am
> > p;reserved=3D0
> >
> >> When you say "in this case", is there another case?
> >
> > There is no other interface. It is only CXL memory device.
> >
> >>
> >> Should "Slow Memory Bandwidth Allocation" thus be considered to be
> >> "CXL.mem Memory Bandwidth Allocation"? Why not call it "CXL(.mem?)
> >> Memory Bandwith Allocation"?
> >
> > Checked with our team here. The currently only supported slow memory
> > is CXL.mem device. As for the naming, the "slow" memory landscape is st=
ill
> evolving.
> > While CXL.mem is the only known type supported right now. The specs
> > says "Slow Memory Bandwidth Allocation". So, we would prefer to keep it
> that way.
>=20
> If you prefer to keep "Slow Memory Bandwidth Allocation" then please also
> provide clear information to the user on what is managed via "Memory
> Bandwidth Allocation" and what is managed via "Slow Memory Bandwidth
> Allocation". This could be in the documentation.

Sure.
>=20
> >> I am not familiar with CXL so please correct me where I am wrong.
> >> From what I understand CXL.mem is a protocol and devices that
> >> implement it can have different memory types ... some faster than
> >> others. So, even if SMBA supports "CXL.mem" devices, could a system
> >> have multiple CXL.mem devices, some faster than others? Would all be
> >> configured the same with SMBA (they would all be classified as "slow" =
and
> throttled the same)?
> >
> > I have not tested the multiple devices with different memory speeds her=
e.
> > But checking with team here says it should just work the same way. It
> > appears that the throttling logic groups all the slow sources together
> > and applies the limit on them as a whole.
>=20
> "the throttling logic groups all the slow sources together and applies th=
e limit
> on them as a whole.". This is valuable content for the documentation abou=
t this
> feature. Could the changes to Documentation/x86/resctrl.rst be updated to
> include a paragraph describing SMBA and what is (or is not) considered a =
"slow
> resource"?

Sure.
>=20
> >> I do not think these devices are invisible to the OS though (after
> >> reading Documentation/driver-api/cxl/memory-devices.rst and
> >> Documentation/ABI/testing/sysfs-class-cxl).
> >>
> >> Is there not a way to provide some more clarity to users on what
> >> would be throttled?
> >>
>=20
> I repeat the question you snipped from my email (please don't do that). C=
ould
Sorry.. Not intentional.

> you please answer it?:
> Would the "SMBA" resource be available only when CXL.mem devices are
> present on the system? Since this is a CPU feature it is unclear to me wh=
ether
> presence of CXL.mem devices would be known at the time "SMBA" is
> enumerated.
> Could the "SMBA" resource thus exist without memory to throttle?

Yes.  The presence of the SMBA feature(with CXL.mem) is independent of whet=
her slow memory is actually present in the system.  If there is no slow mem=
ory, then setting a SMBA limit will have no impact on the performance of th=
e system.
>=20
> >> How does a user know which memory on the system is "slow memory"?
> >>
> >> It remains unclear to me how a user is intended to use this feature.
> >>
> >> How will a user know which devices/memory (if any) are being
> >> throttled by "SMBA"?
> >>
> > This is a new technology. I am still learning.
> >
> > Currently, I have tested with CXL 1.1 type of device. CXL 1.1 uses a
> > simple topology structure of direct attachment between host (such as a
> > CPU or GPU) and CXL device.
> >
> > #numactl -H
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 node 0 size:
> > 63678 MB node 0 free: 59542 MB
> > node 1 cpus:             (CPU list is emply. Node 1 have CXL memory)
> > node 1 size: 16122 MB    (There is 16GB CXL memory)
> > node 1 free: 15627 MB
> > node distances:
> > node   0   1
> >   0:  10  50
> >   1:  50  10
> >
> > The cpu-cxl node distance is greater than cpu-to-cpu distances.
> >
> > We can also verify using lsmem
> >
> > #lsmem --output RANGE,SIZE,STATE,NODE,ZONES,BLOCK
> > RANGE                                 SIZE  STATE NODE  ZONES BLOCK
> > 0x0000000000000000-0x000000007fffffff   2G online    0   None     0
> > 0x0000000080000000-0x00000000ffffffff   2G online    0  DMA32     1
> > 0x0000000100000000-0x0000000fffffffff  60G online    0 Normal  2-31
> > 0x0000001000000000-0x000000107fffffff   2G online    0   None    32
> > 0x0000001080000000-0x000000147fffffff  16G online    1 Normal 33-40
> >
> > Memory block size:         2G
> > Total online memory:      82G
> > Total offline memory:      0B
> >
> >
> > We can also verify using ACPI SRAT table and memory maps.
>=20
> I think that adding (in general terms) that "SMBA throttles CXL.mem devic=
es" to
> Documentation/x86/resctrl.rst may be sufficient for a user to understand =
what
> will be throttled without needing to go into details about CXL device dis=
covery.

Sure.
Thanks
Babu
