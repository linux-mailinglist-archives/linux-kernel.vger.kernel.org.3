Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA405721F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiGLRuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiGLRuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:50:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F324A65572
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4/s6H7+JkExqU7Ls/fkU2X4QZtfpMA+oKcDbnHI0R1xU6gLzxprnCBbw53GIvT0x+8O372pG0ltblCTYkA/aYuCy8UFD99gR1Bc7xmBrGAKL61K//k5F6F+GeZhBwldJylOFe4w6SMDPpNW+BsZwOueq9/LpFCd7xDwxU5lOfXd8nDZwX+KHjiMUrtOZwDCnA8NopiKjMzaDg1iXs/dIU+hSy4+OzGks4EvQ9SeQ43hEF56eF1fGA+hwVEGhqFcU0uMK1NPSPXlLeZJ+t+9SmnHyiTsorxJ7d0TKaQr3+0+O/CKfcnLaXC71tc3iNBO1T4/cFMqEC3Pz7bKPpMS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5MYP39yenCY0VvPBDNJLwzJq8RK8rdS5tTTH5i3aJY=;
 b=J+HjrCbA93k0lRM9OjvWdps5G6lKVY8j4urxXy3FJSNrovK41W6N8yNcKEjAZSF43pwjEYWG7ZCmCs0gYf+6eCMegncP8pfOd/dfSko76hrtXqP8cqWt4Nm8BFK2W6HujWcOfwgAXlmBKg1hS4ck+I4n4SdGrITjhDTM+q6+mwTKE5weZpz4b0Zso7spios8Yo2C3S8TkDtLs5YZ+XwqhplB56fLwCIsp0oB0994azYwl4SWrVVcCwEQTbe7OOdslI5FVPK4Iwl+PF4fVP6EyB/s92g6CSLWDm2DQ6hblHw0/G2LN3+8jKt0DlxmXatPSLkzNLBoARZC8I6/3UPfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5MYP39yenCY0VvPBDNJLwzJq8RK8rdS5tTTH5i3aJY=;
 b=RU0V5dbuYWjgsOq89rLPWoFR0C9FzSu2iH6+m5B+Osw4YkbswhY6eiICFj3lD9Q5rT+pNleDptojH1QPXgXBOC7n/hElLZOL2OB6Z2MF2temMFSzXDAyDRDckrTpgvwx7WXkUOTLxSawy397tHvMSSbchy0FZd8JFLaqSsVN3CQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MWHPR12MB1215.namprd12.prod.outlook.com (2603:10b6:300:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 17:50:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 17:50:33 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [REGRESSION] amd-pstate doesn't work since v5.18.11
Thread-Topic: [REGRESSION] amd-pstate doesn't work since v5.18.11
Thread-Index: AQHYlhZ+E801N9hl00CBpOxB/Pr12K17A18AgAAAEtA=
Date:   Tue, 12 Jul 2022 17:50:33 +0000
Message-ID: <MN0PR12MB6101ECFEFBBDBB65CA75F1C3E2869@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <3559249.JlDtxWtqDm@natalenko.name>
 <DM4PR12MB527879122FE84DCD355C33B59C869@DM4PR12MB5278.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB527879122FE84DCD355C33B59C869@DM4PR12MB5278.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-12T17:50:27Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8a2f6fbe-7c68-4ea7-8b17-344e7f18bd2e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-12T17:50:31Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d1902572-5989-40f7-b200-6d0930814bdc
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: babf7b3a-e2ef-438d-8733-08da642f04b1
x-ms-traffictypediagnostic: MWHPR12MB1215:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iDucRv5pmbOUP0064kahImMwTPlV5ku3UsXhNkiaxDTy78ZNXbhQYbgmx6Cj8+qYnytbpZgEEx9hbWyBwbF5Zbu1VboP6M3C4pzYAPp9L0ib5wYg/4fJ+nimwDscdEIT/yW3R8JjUrBxpMgyqZhVqGrsf7h1HhiVizI/YQkCFtudag1ArCCjOFftWgZH8UIGMIZXgIsAUc1daQolVq1LQfIhFtHgxxkiXKCfJfLoEqRm245FSf99dLKh3izNWVGknSUUZhuLW+z4Lw8KQK1JAs3D2SzBfHaeWuADiOesuu9c5BT6kkr3qwA0/n4AwD0JyxWk+y08bmle/ZaXlt08fdcwDcie+yaVJpBBUmNO12WhcJG9vHueoc5PEHZ/fMaWnEONscl4L1ZTMPesc2mtdVLkWlwy+bvcX/N9gveHEsgduaq3Zm+XUrg0QV6QL6VICOomQd1WaFuWaCZVZcGMgAhF3dKU2FJVLtQjHWoucEQ1oiJRf7u0Eb+zgK2hnOXCiQxAlSHL/gIeiYZuM+tJLlFNaR/8knb8fbDd6PpfsqdnOUE09FwZEanJzQheMJqiUoFXvIjY5NwjLwQBviFFTBgPWS/NT+nYPfjpXMdSctlAVqSxuT29/sCl1xHKU3CR7jGsbf58HFXs/pZQ1CriY7rwMzeupFOdNRjhfZ6hlohS+h9eYSGY8VwZDUhGMF8a+IL0brZZnb7vapL4e4buXFRewJrIfBKJBK19CPaKWDVYX9lKj+eKg3s+MTFXrMLVz6qTXyAq/cJt+NtWQlLr8oYgy+rhqAVlfCKWTIxnS4irYj0gqPQlsWMyAx04x2gaZPOIRYnBDjs17c9Uj9SD/UibstnmbtIppxXv5i74iGk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(53546011)(8676002)(66476007)(66446008)(86362001)(64756008)(478600001)(66946007)(4326008)(26005)(5660300002)(71200400001)(8936002)(66556008)(76116006)(41300700001)(9686003)(316002)(38100700002)(110136005)(38070700005)(52536014)(7696005)(54906003)(6636002)(122000001)(2906002)(33656002)(6506007)(55016003)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4H6UBteAEBjOKpg2JpGzkyvZPeqb9huXbPHZpCIGelRMOLfCSM9JAb6qdYsG?=
 =?us-ascii?Q?gmmgYgZ0UVYnz/JY8lFJoy5uLysnuKdhjl8Luj3R9fcXpxxiHBSzXRMag+s0?=
 =?us-ascii?Q?242/mCGWTzovYM/X0RuMOXhM5DDB7FqI1yQY4p2yx1lqZYQDaJQb2A60OjMO?=
 =?us-ascii?Q?kSbuRMbrHuUxgexT6sXAkdUsbCMkbrP4mT3TgN3jnuqXN3wk29gj9m6EHcQC?=
 =?us-ascii?Q?0YpuOMYlZwxFnK7wRLIE53UFuva3ll1ZXClf8g+JaiyPqJYuQFVYLR7zkXjS?=
 =?us-ascii?Q?lZ4UsN/nFRrrJ/es61UTk6WLjcAhdQfBfGT9suJXC+D1tgtK9BXdNktBlm9t?=
 =?us-ascii?Q?rtXscXkR82ue4bGDLXP2EuCNBqLKOjGGYUx3+K24R7TFrtAkkCq81mIW4I2W?=
 =?us-ascii?Q?HIZc/htUhbsrF2tYEoj0N3olTz3hQe5kfdvkH7nHsGhqzeDAUctPdZDy1nYK?=
 =?us-ascii?Q?H1ohexBBGBe0Bp+HZoUFS42EqB0RHjOmojMuQYaWg4zTBsu5mAN2FIIo11wT?=
 =?us-ascii?Q?Babn7R6NUqMvsStm2Y6drx2BvQ7RDCWxpQ1i8jsRTpGot5lWki/Yv9uQU8KB?=
 =?us-ascii?Q?RSxEn3lrQkc13F5R4qhoitm41Kw/Ue6//qMIb1U2zq8+0AVz7CL29egA7+fW?=
 =?us-ascii?Q?eNYXvNELBp6sgsXQeWrG5mnGRUSITwhSptZtYyQkKYooabcZEYnhRLsEMmof?=
 =?us-ascii?Q?1lwjnL1bNO/LF44l45a0XKtIOVDpqFrOM7Q70CgkaFfWWPv7ys/FStJYYO5j?=
 =?us-ascii?Q?3qkn1Kcx9sphKzhaAcfihJ8twViAZukZMQZrMVhGdvFUimIC7iE6J5rlBKXl?=
 =?us-ascii?Q?1OZoNFAmALlpIIKjxs+BPp+peQO0o0IkwM+f45gq8Gai+up3M0pG4jUYbBhs?=
 =?us-ascii?Q?LHw/Yv46SsFNiSkaTxZWnMSgzQgLaE1iZVez+t278bfqRj/rQNP3OQ/C/7Ad?=
 =?us-ascii?Q?kHNy5YhxIf6JJMBiV4p6MzZkwS9FcsgprLow8+sfJ/QwXzY3sUvNnwxc2+ZZ?=
 =?us-ascii?Q?zc7XYWKeUeDLH0xNw+W7+pVnAQFex2hHGe455pQau5lFFVkGFC4bf93JnOYN?=
 =?us-ascii?Q?gI3SJ1Xi4WU6rD7hRRqEZKQwuS4O+AIInUAAEbixOMI8DgBbUOBn9QSFwzlc?=
 =?us-ascii?Q?nj4zQiIHKEcv72wRmaQsqZbLXuGjuckEfgf8+nBmKew3kU3qTxbJyJnt3ddm?=
 =?us-ascii?Q?rRDuwrdYI7PVW3c9jsioVdSutocQji1oblJ6ztD2o7/PX7lY/1bBjJse6EWr?=
 =?us-ascii?Q?XMZRQJIBP9gR39XJgQzQtIiEg1+9akd3Qa/JgCNRCV3EhwXREkjW8n/3rqSB?=
 =?us-ascii?Q?bUsoiEY83dmgqxY91iz5uAmvsBJXF59cbPJhC6wJSZwkmS2KixmXwALzg319?=
 =?us-ascii?Q?oiOmDFRnngWEGyBuIe0feS8QMDLZDWODZAbUj3N1BUIK2rmC/VDjx6UpIxOL?=
 =?us-ascii?Q?Qj3FGgE7Clu98Rob3JUEyDwlmbu9nC6fRhVde0XN0DxHQ8/xhCQVh9H9AsbA?=
 =?us-ascii?Q?n9CdiDmRwdP/67E8CyY6mIW+1bpmkj2mIF1xSY++TWEOQDN0ErB/ZENDLNIJ?=
 =?us-ascii?Q?qua9dZYTVCzWoXz6P3I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babf7b3a-e2ef-438d-8733-08da642f04b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 17:50:33.0861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFj6HOz8WG3uNLY5rKeVqP5GvGroL27aDrKHBiiodP1DGQqbcEqGbpceVzRWsNb7QZokkqUp5JQQvDnF28SpDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

+ Ray=20

> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Tuesday, July 12, 2022 12:50
> To: Oleksandr Natalenko <oleksandr@natalenko.name>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; linux-kernel@vger.kernel.org
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
> <sashal@kernel.org>; x86@kernel.org; H. Peter Anvin <hpa@zytor.com>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Subject: RE: [REGRESSION] amd-pstate doesn't work since v5.18.11
>=20
> [AMD Official Use Only - General]
>=20
> Hi Oleksandr:
>=20
> > -----Original Message-----
> > From: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Sent: Wednesday, July 13, 2022 1:40 AM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>; linux-
> > kernel@vger.kernel.org
> > Cc: Yuan, Perry <Perry.Yuan@amd.com>; Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com>; Sasha Levin <sashal@kernel.org>;
> > x86@kernel.org; H. Peter Anvin <hpa@zytor.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>
> > Subject: [REGRESSION] amd-pstate doesn't work since v5.18.11
> >
> > [CAUTION: External Email]
> >
> > Hello Mario.
> >
> > The following commits were pulled into v5.18.11:
> >
> > ```
> > $ git log --oneline --no-merges v5.18.10..v5.18.11 | grep ACPI
> > 2783414e6ef7 ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
> > supported
> > 3068cfeca3b5 ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
> > 8beb71759cc8 ACPI: bus: Set CPPC _OSC bits for all and when CPPC_LIB is
> > supported
> > 13bb696dd2f3 ACPI: CPPC: Check _OSC for flexible address space ```
> >
> > and now this happens:
> >
> > ```
> > $ sudo modprobe amd-pstate shared_mem=3D1
> > modprobe: ERROR: could not insert 'amd_pstate': No such device ```
> >
> > With v5.18.10 this worked just fine.
> >
> > In your upstream commit 8b356e536e69f3a4d6778ae9f0858a1beadabb1f
> > you write:
> >
> > ```
> > If there is additional breakage on the shared memory designs also missi=
ng
> > this _OSC, additional follow up changes may be needed.
> > ```
> >
> > So the question is what else should be pulled into the stable tree to
> > unbreak amd-pstate?
> >
> > Thanks.
> >
> > --
> > Oleksandr Natalenko (post-factum)
> >
>=20
> Could you share the lscpu output ?
>=20
> Perry.

Thanks this is the sort of thing I was worried might happen as a result of =
requiring
the _OSC.  It was introduced as part of that commit 8beb71759cc8.

To solve it I think we need to add more things to cpc_supported_by_cpu
(https://github.com/torvalds/linux/blob/525496a030de4ae64bb9e1d6bfc88eec6f5=
fe6e2/arch/x86/kernel/acpi/cppc.c#L19)

The question is how do we safely detect the shared memory designs?
These are a fixed quantity as newer designs /should/ be using the MSR.

I am tending to thing that unfortunately we need to have an allow-list of s=
hared
memory design here unless someone has other ideas.=
