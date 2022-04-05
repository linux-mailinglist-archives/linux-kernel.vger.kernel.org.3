Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42F4F5259
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457293AbiDFCoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577997AbiDEXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:17:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94139167D4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTGAnDuL4UsbyZdRjjnwED7YOAGjqEOKG0r/6M5uEHlXQHcKbRevrtCr8xYCXHP6AApfJ6b/ffjp7KDqAHIq5oyx2Y6hoI6veRNQOQUTePkiWW+es4BHgvY4/i9oM9jubDlpLKgmH/pSux90y2I+JjkMmrXtQr/ZhjKTc4wlA5iwA9NxKYDAZSpYj+NYpjTgl+ztYN8AqkvvRalnEbDETkoR2drykBl8VJBSLfGpP9P1X4LUGIuUX6PUP8hSFvlEVUGiUJUBO/rnz7vi3CYz0kPL+QgorR8P0K7LKpjzsIhMwMwpJCmMYJt5iOZGluL5Mr+m8hFvvjWW8BHJxxC6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVpfZuUJIB2V2KWjS+a2VU/2DxljJHa4UpGxFx3VnzY=;
 b=QrVcEfzef32hEY1NvFiugMqiYO6UE7oz0eJkyX/qtvfY0HPsBV/VAhl3XczcLW2CyxjHvUl3ZEoYWi9M1d3v4cB567YyX5Cc30IHA0WrXBsYpe+uXRa5ESv9OMCIiQhRigVFQFcgabOVItV3uqJ5qmtQHbPK5keCV+RwsjpG/ig6z8t/UPb4jwi6T1vplHU+VC5vgK0921ZtAixSq/twcs5fAizMPQdaWsPOIZ4PmbClLg+BpkbeRjZjWrnmqCBuYZ7Ci8z+hFY4yYsWn1I1Buu5Zjc3ipU25sxQVZMUFCaHifHxxMGiFGw0oiV4FzXztPfbwo8BXW4ZImeytZXlIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVpfZuUJIB2V2KWjS+a2VU/2DxljJHa4UpGxFx3VnzY=;
 b=mZQQd7hCkjOySgiCCArLcDG1xJYpbBDAB4KYbfJXuw5wshOLFQW3D/8OLbE52mwQiI5vltmeHV8aNIG4K8Ib/DtKOn2a6zgqV7uab0WzaUWT6hfpAZN3xmgA1YTlUUfPQj/h8uhHNlIBrtT4NhYneMIIsEgNuceMREXTf4Ogl8o=
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 by BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 21:49:28 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::e0a5:a02d:154c:bb05]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::e0a5:a02d:154c:bb05%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 21:49:27 +0000
From:   "Carroll, Lewis" <Lewis.Carroll@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
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
Thread-Index: AQHYSO0snhd1lCdhiU2/pwc3sV/c0KzhWp+AgABmXzCAAAdvgIAAEKCA
Date:   Tue, 5 Apr 2022 21:49:27 +0000
Message-ID: <MN2PR12MB394969DC4BAF9B91A0E8A560FAE49@MN2PR12MB3949.namprd12.prod.outlook.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxMtx9zdk+nH33r@zn.tnic>
 <MN2PR12MB3949923BCD8B368F8269565BFAE49@MN2PR12MB3949.namprd12.prod.outlook.com>
 <Ykyo00r8aIibvLpP@zn.tnic>
In-Reply-To: <Ykyo00r8aIibvLpP@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-05T21:49:25Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=197c5a53-db3d-43ef-99a4-3c8f0f7d130d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f18c2143-78d2-4e1d-c18c-08da174e2817
x-ms-traffictypediagnostic: BY5PR12MB3777:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3777CC6E5A3D8AB924A12AF0FAE49@BY5PR12MB3777.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vUaLcbFMmHoJgNLb8FD2X9wYiGNRoacFNh2zwACYJuZHU0oxTa4AW7Ein9cEgY0vb8TIQmG/rBnJ/SCf+/F5NEbM3WqMK+p2HRds/4hUlHA55MycEkAGD6LHe90/oFGojYlzOKc6XW3b/8MPBlKkukGwQkL1QSBVDZGLtSfJK1Z0vpqbZ8cSInMJcI6lv5sZEONE0XgztuCRioaVBqCtiUXLMNd2jPrq0A1ODZ7EYOcn+rtGSBBWq0PRUzxPaqzuQyuu3LgTBy1+Uq/w7DO1z1zq0xYJzvuirfZuMdMRZKc9iHVMi472/l8pS9DV7JZ5L+akyhcljQy3xN+s7jJkNc2MayRpVGs6gN03y9XP7vZ0sLtTQI9vImuGcdFBzhGPHTEcsxrhhh30x/ZhSu4cq2iT4VaFif5Xyxhe1nrHHdE0pLp0tIHnvXwSChSQBjO2HAir2nOLjYytg2ExYr+wyUd7JHQsv7tXz+X4ZcEq3DB9vXnIUNXtEFpwyXmcgocCsBNKVC6FlKTiSudZif6grgkCA5OU4GN5+M9TpmTRItrNVto/5YfLfV/fg4t46NXKXPkXYWUzRzUrs/u/6dgmUoXDvQ/gRIvgokg720riM5WpzbdPF7OjJvD7D0jERfG7UtVtLXPMS13eQTMEa2IzoNFHK8mOSg0FQUAIiUc5v2xZEZHYnnWsajBD7gMNc4nIQdft79laoTewgA/LDdAPkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3949.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(53546011)(66556008)(9686003)(316002)(83380400001)(7696005)(508600001)(6506007)(4326008)(66476007)(66446008)(64756008)(8676002)(33656002)(76116006)(54906003)(38100700002)(71200400001)(52536014)(122000001)(2906002)(86362001)(55016003)(6916009)(7416002)(26005)(38070700005)(8936002)(186003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UM5nDxPOACNPTab7oLzottYZGOn347jrIqDngyECC27y8O5ka03C4UgXK9F1?=
 =?us-ascii?Q?93fwvY83f1dQLq6Y/mR4nhzKUX89S+xvl2qu1z7k+AX/LricpdHa6iPh51HJ?=
 =?us-ascii?Q?Ltb0Ywtvy8GK+fzaDdXVwE8TJZMWzFG+qn7CWuexaulz1AaBjsk2sYm1jPv+?=
 =?us-ascii?Q?jn/Ouob5bOVmC+GU2abCsq/6PdkKxzHX6W1lHbYcvqiQfOJlJ9vTlwwEJynD?=
 =?us-ascii?Q?DJaqfDVGT1WKQM+ktzru7a/+QTsZ3497wt0fLPI/YsMDmsRaM9BxX4mWcTBO?=
 =?us-ascii?Q?l5+2r1uKqrekxwzi09udlY0DVQkFpj7X9P2nX6yJM7DmkGc5TjYItDyFTS+M?=
 =?us-ascii?Q?Y1Md6Rp94GDeHFh7G/z27h10FsO15qxAyKDiA7RXKTH3Ncj5JK4dZdmLzgw6?=
 =?us-ascii?Q?QXEKrDwjBXoCVv2t0cyWr4MOjSFMmYPULdxtZ14TB5GpLZBfL5we5SgPdW4j?=
 =?us-ascii?Q?Le2FEIoIM4zYmlMabEAT+JVPYBetcz5F+WO3GvwqCElAgPcxkKWsNd15v37M?=
 =?us-ascii?Q?SDOgHij3pjmwJnMNjTh1EluP0VdefsBo6MrTsjMTGAqJdDLJqTVNipSTywGa?=
 =?us-ascii?Q?CSMNnDgEp+dJ96Fo/4yLy6DmYHxFlfoMs/E//r3oKAa5f9gy7skyHx674A3v?=
 =?us-ascii?Q?b564Sj/vkiOJQMjDPxzSaPueSgPtcCw1GLTa6hZD62wwIV/DEY8Pik2kWS69?=
 =?us-ascii?Q?QGL/5/sv44mTWeTBdc3YI9Q217rziLeDAhpniQoUOC2yYLLBAaZb97HyAb0f?=
 =?us-ascii?Q?avVyeXcroj5/4ro10yNOmWbwj5uzv55vKkt4HsROoYHGqlUGgznW4Dw70dK8?=
 =?us-ascii?Q?4GExYg7kPKdehpGWcs1p1hJPHDP3f/gsfsrEk49Ulxi0FI8RerF1aJQJ8qDL?=
 =?us-ascii?Q?cJ60KD9KyKBUi6KEOvfZuDOnJH8CEWvy4K1+G0MgQn7zG8eaog+q7II/FxUc?=
 =?us-ascii?Q?G/eh3iOT9po6reMSO+QaVBKhx8FD/I9VHJq7BbPmJp31frDCmTD55nm9X8P2?=
 =?us-ascii?Q?RIu3ZtpyTC1UEI5ukW80ndEhB1r40FV3qs9iOB+64OkYuH7FONjohAwe8oqI?=
 =?us-ascii?Q?6g6D8lYblGT9UIQr4NIoVk1SYL2SZUjJKze4l0IhebPXy+g/2Fi3RDTlpsUq?=
 =?us-ascii?Q?00B9WC3qQcjjmTKU/imcX0CNZ/4RrfEJKK6wH5aHtYODMRrMQhtm346fCAkG?=
 =?us-ascii?Q?L/NIXA87Sldr4QWZ7A3GQktJI1Gyk6H2X1vEOuv9FVh/btSS/u+7suTHW/MR?=
 =?us-ascii?Q?TV/0RF5gTmu5SABZD+edXPvSTKxxaWvKR99iaOsOxYn++IdhABER4rnVYGMk?=
 =?us-ascii?Q?031iE6b3dof8EyQz+/vk4FzXwacohBQ4q/4nHrYzlhkPhUuG+goHOBXI+K7P?=
 =?us-ascii?Q?LqT7+JB3ANPim1Rkf+mv7T9foFIQ4YjRgEBfI6DeJEBEqszUl+YItg3226ET?=
 =?us-ascii?Q?F99NfCS3Gntaq8FZ2r+rY7MlP3Sc+gE1Dvi1O+zz0S0H1tA/Uhoislo41/7t?=
 =?us-ascii?Q?3W9eKkl0NaPdLnLUBcsaThk3fa14cFOIGcOw6HwXxw82PFuaCNaFNl9QiZXd?=
 =?us-ascii?Q?nbjcEugy6zlE9LyYSWef/7xrPZqX4hI9zHZB81WIplLTKMuj3jxoToypbKqZ?=
 =?us-ascii?Q?9oEYGBVUxUIaZkZehjdLQKVxqQtTNC0UHaIoVFNOUhfsevJcfuKpw/6/PV2b?=
 =?us-ascii?Q?Ytf+OuaKFmnQu5v04FviMzE7xgsLjkw9sqbotskFQzxOfxJHqHZjXnruw/Ez?=
 =?us-ascii?Q?iAMI9GteMQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3949.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18c2143-78d2-4e1d-c18c-08da174e2817
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 21:49:27.2005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSxvgBPVJ9CoWzd7nvCo+p/07nk8H5E8AbiNIOSUZ/ozlAc8b1ygnI2tS4Y1j01IEbrDJrwd7EjynDh6fjCOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3777
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
> From: Borislav Petkov <bp@alien8.de>
> Sent: Tuesday, April 5, 2022 4:39 PM
> To: Carroll, Lewis <Lewis.Carroll@amd.com>
> Cc: linux-kernel@vger.kernel.org; peterz@infradead.org;
> dave.hansen@linux.intel.com; Karny, Wyes <Wyes.Karny@amd.com>; Limonciell=
o,
> Mario <Mario.Limonciello@amd.com>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Narayan, Ananth <Ananth.Narayan@amd.com>; Rao,
> Bharata Bhasker <bharata@amd.com>; len.brown@intel.com; x86@kernel.org;
> tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com;
> chang.seok.bae@intel.com; keescook@chromium.org; metze@samba.org;
> zhengqi.arch@bytedance.com; mark.rutland@arm.com
> Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
>=20
> [CAUTION: External Email]
>=20
> On Tue, Apr 05, 2022 at 08:26:53PM +0000, Carroll, Lewis wrote:
> > This happens when:
> >  * User disables global C-states in BIOS
> >  * User disables cpuidle (e.g. idle=3Doff or processor.max_cstate=3D0)
> >  * Kernel does not have CONFIG_ACPI_PROCESSOR_IDLE
>=20
> All three or any one of those?

Just when I thought I was being thorough. Any of the above will block the
cpuidle driver from loading. As will absence of _CST ACPI methods (add that
as a fourth cause). Brings back memories of code comments about a certain
idle driver being created to work around broken BIOSes...

>=20
> > Genesis of this patch is customer performance observations.
>=20
> Please add that explanation to the changelog - it is important when looki=
ng
> back, trying to figure out why this was done.

We will have to see what we can sanitize. The original performance observat=
ion
(packet loss in a networking application) led to discovery of lots of cycle=
s
in the various go-to-sleep-via-halt and wake-from-halt-via-IPI functions. W=
yes
collected the raw data on the relative idle+wake-up latency and included th=
at
in the commit msg. Think of that delta as the root cause of the performance
regression in this case.

>=20
> > Yes. We felt the code more readable with the prefer_mwait_c1_over_halt =
fn.
> > Hygon CPU init indeed sets X86_FEATURE ZEN.
> > AMD CPU init sets X86_FEATURE_ZEN for family >=3D 17h (not only 17h).
>=20
> Yes, but this new logic you're adding, basically says, use MWAIT on all Z=
en
> uarch CPUs, right?

Yes we are saying use MWAIT instead of HLT on all known (as of today) Zen
uarch CPUs (AMD >=3D 17h and Hygon).

>=20
> So why not write exactly that?
>=20
> The simpler the logic and the clearer the code, the better.
>=20
> > Cleanest solution might be a new CPU feature (e.g.
> > X86_PREFER_MWAIT_IDLE) that gets set appropriately, but that would
> > require touching more files.
>=20
> Yes, I thought about it too.
>=20
> Not really necessary if what I wrote above fits.
>=20
> And while you're touching files, pls add that change too:
>=20
> ---
> diff --git a/arch/x86/include/asm/cpufeatures.h
> b/arch/x86/include/asm/cpufeatures.h
> index 73e643ae94b6..c1091f78f104 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -219,7 +219,7 @@
>  #define X86_FEATURE_IBRS               ( 7*32+25) /* Indirect Branch
> Restricted Speculation */
>  #define X86_FEATURE_IBPB               ( 7*32+26) /* Indirect Branch
> Prediction Barrier */
>  #define X86_FEATURE_STIBP              ( 7*32+27) /* Single Thread Indir=
ect
> Branch Predictors */
> -#define X86_FEATURE_ZEN                        ( 7*32+28) /* "" CPU is A=
MD
> family 0x17 or above (Zen) */
> +#define X86_FEATURE_ZEN                        ( 7*32+28) /* "" Set on C=
PUs
> of the Zen uarch */
>  #define X86_FEATURE_L1TF_PTEINV                ( 7*32+29) /* "" L1TF
> workaround PTE inversion */
>  #define X86_FEATURE_IBRS_ENHANCED      ( 7*32+30) /* Enhanced IBRS */
>  #define X86_FEATURE_MSR_IA32_FEAT_CTL  ( 7*32+31) /* "" MSR IA32_FEAT_CT=
L
> configured */
>=20
> so that dhansen and peterz are not confused anymore. :-)
=20
Ack.

>=20
> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.
