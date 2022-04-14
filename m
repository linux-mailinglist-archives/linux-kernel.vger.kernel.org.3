Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90870501D11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346766AbiDNVJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiDNVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:09:10 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E69A41F9D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee79vQUp/kw9gkXszivhJAnKDV+fyWh4qstPq3bdG09rD6uhLhiDWNzGc59caRRJXD17syEVjD3Ya9mDFGAB96zuahu0uf03bVpdnx9T6v0sz/WgP866LPOQHclEFfIQrRUdY01pjLtOyZpRAXLoEkIABtC7cFXFI0UbGZqGf3uVI1ipQlwijc9yG520sJ3leZg0wGDY3VdahqRbhUalN9nNFpTo2d59ZetEY9Uq3dUrk8gpc1y0zYXF4WTHKInx9mSmzHHlqiePxRZLdNDsTRBDOyrO2xmKX2Dp5B+43iqTbY90eM/GaRrE00vmnvWgBkAwX3dSfkaaBIPpiMSuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1rvHb3QyNpfVceM/BgeHVPDsXvDziualLUInRAeBfQ=;
 b=ep/5I1J2r/I8R2QOoUCnPgLLsUMTqyHLG3scAfA1fBLbwvx+cOjo0D6+rQs1UndDzIe1/1APLBbmOd3PgDRJCjbHLJ1P1IDT08E0y9aLnSlyvOXlB3Sfud//21KD5Q22BrAQlm7ul9+4DSiLIelxDJXMx4Kdnd4oefBn9w+vCOSvNn7kZMgj2XR071w8Lht0fzk+R50RGyEVgiZEQj1uXuKAQoJbl6b4AMnAptY96HZcYA1HVXqyMdC9LwsON4NOonZq7k7Z9gnpsqdxwqp1KJa5cLyvAb2aU+RjefLeiHSCfb9f0C8UrLy4QG8pQ6Uy12VFBcg7UbAgodtgG0AVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1rvHb3QyNpfVceM/BgeHVPDsXvDziualLUInRAeBfQ=;
 b=AR2bs5TgFIAwmDXHoOZm7UTPsifHDg1XllGcfevlwKVQcw+4YSoKApaffkqs7RnQrafN6crIPapm1+1dhhgXVUQ0eJU+W/fIXLXR7Pm0l5bwCHh6IubfEkudjQNjkNBQG+TzpYUYbvKXo3zdCDt0hV5vjE1z4JUka99a+U5RX48=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 21:06:41 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::3157:3164:59df:b603%7]) with mapi id 15.20.5164.018; Thu, 14 Apr 2022
 21:06:41 +0000
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
Thread-Index: AQHYSO0si5fvSUiei0GnFDYbI7mXuKzhWxKAgAARiYCAAAWWwIAABNIAgABQN2CAAFaUAIAA0EgAgAIJqoCAAEOtoIAKt08Q
Date:   Thu, 14 Apr 2022 21:06:40 +0000
Message-ID: <BL1PR12MB5157EDDA43968B19B5051780E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
 <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
 <BL1PR12MB515745615F4C92627033CD5BE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5873a444-bb32-f0d5-27f1-173f469baf21@intel.com>
 <BL1PR12MB515702C06E483DF4EB78A7ADE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
 <87a6cz0yvh.ffs@tglx>
 <BL1PR12MB51573FC5B880ED914628A95BE2E79@BL1PR12MB5157.namprd12.prod.outlook.com>
 <7a95b837-e347-0ad3-3a2c-f347f12d6625@intel.com>
 <BL1PR12MB5157E978932A02865541D319E2E99@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157E978932A02865541D319E2E99@BL1PR12MB5157.namprd12.prod.outlook.com>
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
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-14T21:06:39Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 036df5e8-c001-4e43-a397-151364762a8b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ddcafed-de33-4cc1-cb85-08da1e5aac3a
x-ms-traffictypediagnostic: DM6PR12MB4332:EE_
x-microsoft-antispam-prvs: <DM6PR12MB43320B2926AAA7C361A286B6E2EF9@DM6PR12MB4332.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: STp6U0H+XWDpA8Wy0abtWH+awlf7Cagu0VKtTv3imrkjL9pVrZJCc2vcNEvJpVsNLm26MFk930NT7MVaZXN5cDfUe2V+8nUebwFmm90lJZoFEYS23IjpZXUer5jmYocvSyI5KjDPQdx7SwEtiRxxHwLePjUm+KCHZkKuxe84BJrX99lVKN3kLPxfjxWoh/PxCUIO9Q/wvN6F0uFyKUIr4GdpNsgBxpeARxDjRYD+Eptgsz1wEeV/k4jDAHLmQKu1FBIzfQN2NrTMCdCuzKF1ylBCB5AsM0qGcVzsvKuRpOfERF6hr3+6KKBsB8JhwVP8VnNoALw025UhaOaVJpG5bBMXUykFhpnmXu8wOtRTqrNXKtkZ8wS+MJ2YfGoa6Zkvt4pF4c5+pb+hgKBmj/N8lwJ4Tbz0/ucddmxeeZUUXsXgMfOiTpeQkzxouzy2fSQQUK3mcWeNxqn2AseKLuCxjRoZAK5Y9pYJnXz7b5Sir3v7JYyqGyU4M9irbouzfRDcxgZY99UtfaPEdfNWTXiFaOXJq8eG2EQQE7bhSp9AIEXMGJBQ2byFZIsRTJb55ryceT0Xvx5FuF87c6fxzsQwprmjtz0hgMS9CUAB+oX9AWDC+mGqjTWIrI8wZAGofiK8MjqE5niAfvB/uhoPT/NY6gjXOjT1LbYbhUFE37/13hJx9SU9BEbxHiCL8SF35V089yHNHPH7zmWMKrKNLil2G+ne97ugRcpOc/GbG6fUJsMky/3v+P4rQqJyjoo7mPdQRZu9fEzvNcgfLCv/p17mWGmztPkwS3NEdul2tiXjDz0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(316002)(4326008)(53546011)(8936002)(52536014)(6506007)(33656002)(54906003)(66556008)(110136005)(71200400001)(7696005)(122000001)(38100700002)(66946007)(66446008)(38070700005)(66476007)(186003)(64756008)(6636002)(83380400001)(55016003)(8676002)(2906002)(9686003)(86362001)(5660300002)(966005)(7416002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tMmqsCQAHZ9YnIRY9Zb2iTr2h0iX6rwztdJMg1AK/T590D8Z8vG99ypk1W1f?=
 =?us-ascii?Q?rrHNrPzcPdAlWAjo+XrFrdkQUzZrmDel+LRHs4wXn6tEZgNcAiSX6AWmdcis?=
 =?us-ascii?Q?6MGdOUxTzj1eCEJsZEhQy3jCLTnsopLhYBAbNFHQmAID8n9/ou/yavLrMl/O?=
 =?us-ascii?Q?HIgI9jg4OSTyJy8pecWatpkwsl6PH0wdLBOM37RHxlObOCsDAN3hAcM5OaeU?=
 =?us-ascii?Q?5F+uW7bZ9wVYjyQ2sWy00FqNVOqmIxLhESWLc61HlR/vf8WOzypJFb2x5We8?=
 =?us-ascii?Q?TT+LdM50YghhW2CHJEpqhRLDh7U1BEV0ENKKOn+XVtyLJKc37rqbnbbjK8PZ?=
 =?us-ascii?Q?vGaBre1Oq1fxHtFGbcFS71AbDdkR1FhrEYU7m9usdK8deLOphm81keTNSISQ?=
 =?us-ascii?Q?x6St7gYdvGNMTbAUllshcdhUt8kfH1ltJ+TJ8jVXFyhQHHvmwGT3L9QAaSPX?=
 =?us-ascii?Q?T2Rmd9LPs2A6v/BFm+E1upeoJsBr+6nvgumFycXQjKaRU0/wmhfgVFwv9lY6?=
 =?us-ascii?Q?RMmIgViAKzi+X1S4CJuy9RYNk8uzz76VCfsJG01pvXiaEod+nUwbQVMXx+TS?=
 =?us-ascii?Q?xK9uXQDB1/1aPIlPuAI2U91JirLCZ0/DcHRuhmDikhy9QY6llOiGb7o53MKl?=
 =?us-ascii?Q?B8jSGC0MOOUFqr4VcE60y1ILaRYiZb75YGjW8n6+EbrmTedv6hJQRhSfxUb0?=
 =?us-ascii?Q?m6zsPjYWazutUIn3FAv33g7RPkl8P1ua9L/LKgcGEX13sfrIlBLlPnRKAI6H?=
 =?us-ascii?Q?2o6xMQjOtHpip3mw0jBbsHHwh/FuM9CfF5PLdvA0PTe9NerU3pV9vSqs2SQy?=
 =?us-ascii?Q?wu6xcWSvQac/L2Yz6bT0VVPAl0LgZVvKGKx4XOXIRUx0CICvvBlf2kKtHDlj?=
 =?us-ascii?Q?aIPTpOpVCUfYfog1ujhS9p5GN2k2oF45bmAdL+ko3M/xUWaOv1V6IMAfCwep?=
 =?us-ascii?Q?A5AgfGoGQLWni69OTAHyM8rjSp1ciVWEIRTx59kbeLATGNrgTqCQ27PBdeV5?=
 =?us-ascii?Q?/FdpK8u2vLNHQ4yJiABi4mmNxjBLoQXs13r2JKFfg7WbxNgjAp1I4cYM5mCN?=
 =?us-ascii?Q?x6Q/2HCXidkCx1RNW/+lMKOT0EtcExLud+EhKkEynP/jCJkZ6fyBeC2KVMxa?=
 =?us-ascii?Q?vyV3wLUDOA1QdW9Mu9+JLuHNZOoyOrOwRVjbv8kI18kLCKLvC1cIXNSDBdG0?=
 =?us-ascii?Q?q2S7mc0XIr05eGiHQvkmfmC8M4cNNL3Y3i7+hxyd66DaisBjRwRV1sMU3tum?=
 =?us-ascii?Q?8+squQobPbeyTX/3v5CN9bX8U9397BNRO4x0cTS8I+xdhwZ/6Gvekeg6pIJ5?=
 =?us-ascii?Q?5pGhCPLfCZ7Sz4zg16HBuGiHZLLgi7quSBjHVUG+IJQa4hiETqNt/f3aEse9?=
 =?us-ascii?Q?etzGY50ucfFmyV0BpTnSSnvGgqgKlskaGUcynsKhb/mp/V+Qw1wxDcA5NfiN?=
 =?us-ascii?Q?UzIuGD0hkDpuLLCoHrz3O59F5VlDROELZY39YkJtalxyEL577q8cRwpzk1hv?=
 =?us-ascii?Q?9pHQ9LXUR6gH2bDJ2o19VriihMB+NdHr2b1VgPg7qFtw8NsUKKQFBZqWuPoJ?=
 =?us-ascii?Q?KUSjfa9lL59fOFBrYPdeKT9Gz68JaVcuIMUv7CnlWVbbDv1oreQdWDiHa4tg?=
 =?us-ascii?Q?tKREo1+wMIfcvF0NmmboK4TidB2NW99DnfbuBKeKT8rW6ghaWycmMl+zP1op?=
 =?us-ascii?Q?E3bJQ9kzrHoL1aUZpI+Se30X4i7vbW2dXxwPhaxJe4C5mJaJhCX8QdokyyNK?=
 =?us-ascii?Q?ioT16DfE4Vk/aYMSZ8OxJxjmkVOaoDvVjpEGF5n9ruYZiVMyJe2pNimzOOyr?=
x-ms-exchange-antispam-messagedata-1: Y6z4DTl7oc+iOg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddcafed-de33-4cc1-cb85-08da1e5aac3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 21:06:40.9427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjxE1mgWgjrUBSFPzRE+IX67MTUxSZmUQsxO2l+GQttfiMvxm4md6X5g0/C6QkxaPTP9mXixg14blqyK3BV07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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



> -----Original Message-----
> From: Limonciello, Mario
> Sent: Thursday, April 7, 2022 20:24
> To: Dave Hansen <dave.hansen@intel.com>; Thomas Gleixner
> <tglx@linutronix.de>; Peter Zijlstra <peterz@infradead.org>; Karny, Wyes
> <Wyes.Karny@amd.com>
> Cc: linux-kernel@vger.kernel.org; Carroll, Lewis <Lewis.Carroll@amd.com>;
> Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Narayan, Ananth
> <Ananth.Narayan@amd.com>; Rao, Bharata Bhasker <bharata@amd.com>;
> len.brown@intel.com; x86@kernel.org; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; hpa@zytor.com; chang.seok.bae@intel.com;
> keescook@chromium.org; metze@samba.org;
> zhengqi.arch@bytedance.com; mark.rutland@arm.com
> Subject: RE: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
>=20
> [Public]
>=20
> >
> > I don't want to give you too hard of a time on this.  But, that's not
> > architecture, that's just telling folks what the implementation is on
> > *one* CPU model.  Don't get me wrong: these model-specific docs are
> > great, and I wish Intel published something like that.
> >
> > But, the code as written depends on behavior for *all* of family 0x19:
> >
> > >         case 0x17: fallthrough;
> > >         case 0x19: init_amd_zn(c); break;
> >
> > So, while the docs for "family 19h model 01h" are *consistent* with thi=
s
> > code, there's also nothing preventing the docs for "family 19h model
> > 02h" from breaking this new MWAIT code.
> >
> > Now, AMD is full of smart folks that aren't going out of their way to
> > try and break existing software.  But, actual documentation of the
> > *architecture* is really preferable to what we have now.  It helps
> > establish a shared hardware/software contract that keeps both sides
> honest.
>=20
> Point taken.  As you're probably aware releasing documentation is never a
> quick
> process, but Lewis and Wyes can take this to the powers that be internall=
y to
> see
> what can be done for the future.

This thread did splinter a bit as it was between speculation control and MW=
AIT.
So I just wanted to complete the thoughts related to the speculation as tha=
t came
up.  Having gone back over what is in the outward facing documentation I di=
d want
to share to you that APM volume 2 page 67-70 does include the details
for speculation control and proper architectural discovery of the MSR.
https://www.amd.com/system/files/TechDocs/24593.pdf

>=20
> >
> > What's missing is something that says:
> >
> > 	All AMD family 0x17 and 0x19 that enumerate support for MWAIT
> > 	also support this "early MWAIT" implementation
> >
> > That represents a promise from AMD that this can't break in the future.
> >  It both gives us something unambiguous to write code with *and*
> > something to help nudge our hardware and microcode colleagues if they
> > start to do something funny in the future.
> >
> > Just having that in the changelog would be fine, and a genuine
> > improvement over what we have now.  Having it one of the
> > model-independent architecture manuals would be even better.
>=20
> OK... I think the commit message and/or a comment is doable in the short
> term for v2.
