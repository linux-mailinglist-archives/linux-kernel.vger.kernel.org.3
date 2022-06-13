Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D6549C41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344796AbiFMSyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbiFMSxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:53:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AECEF7F9D;
        Mon, 13 Jun 2022 08:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltTghIjeKNSRmda1Gv+llOCqPkx4En+JpRvIyN3TL2/WDoXMGgLeYKt6GOtojwdH65q1aQWJzN6f5gZetitKPnomuxh3p/9xUhe0L28YVKvHbi8sjnFTUXkVYuWsWJCo58HJUE3NccW+DB5uiIafHZanlUPNXX3a2+y6p2e09x2J2uCH3kHpqt3DKA37uqzcF3E8UfczyVSFBFcvjzh7GRhE2DAslYJaD/LfEORqEv9J2l4PGIBSY+hAVLaaXFz7W5Mv01kFv880yB2J9hpMyq1OeHMPiRMb4f/zP+fwMCiQoChgrEknuNqqDxQz/Nc0L2vwkME8crXHI5AQh831Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6FjRt05x07TNerkep9bFVcetJINEWManqcWOGnFUok=;
 b=gX4TG0rCQPzAP7UbHDpgEcFmcmXRot0+HeBv1hoqNwyh9BVaTMis2jesBjaKQFtkZCz2q7h/Wj7fAN2mQUutpvMlwq5Ofjlf7J2+hoxN31MAZsUdPKOTllV58bpQZQEoQdLfv0YTPS0VdDaBQwxqrsczFt/paavqKuG0D8FTrTqWZmPBFvFlJylN4HUWi7mCJXPHjGv5sjdWQ6CRFGpY79cGPjta3AdkmcgEiBshHVkkFg4o4ZMYP4ZLM7TaPtbXveAtWHSE+LYFdA/X+Ce2wEpnvinimFTXggio2IxDiiUMB/9nk1tEgPxVijZCF+gWKLHt1r4lPKxm0NHugDW5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6FjRt05x07TNerkep9bFVcetJINEWManqcWOGnFUok=;
 b=fUN4DjHlR6W3Js113zTLjK5b1nmpG12x7PwU29l3MH036+YkPyklBh4nZ8XCgf9pHyF57fjlEq4lXLVPL2KozuzFWvmO6ERYPk0rzS+A9k+TsyEVZkGlriOC/rYoi3jSflS5HV332U0MQjkG0XtEi9+tM7MA9D8sIWCI0Py/bBc=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY4PR12MB1782.namprd12.prod.outlook.com (2603:10b6:903:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Mon, 13 Jun
 2022 15:57:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1%5]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 15:57:09 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Documentation: PM: Drop pme_interrupt reference
Thread-Topic: [PATCH] Documentation: PM: Drop pme_interrupt reference
Thread-Index: AQHYdp6IJx+DfZWbjU28FeOkgrM2Aq1GISkAgAdtduA=
Date:   Mon, 13 Jun 2022 15:57:09 +0000
Message-ID: <MN0PR12MB610188F2F289EFA12872D8E2E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220602163330.317-1-mario.limonciello@amd.com>
 <20220608222922.GA429328@bhelgaas>
In-Reply-To: <20220608222922.GA429328@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-13T15:55:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a23ea24a-b4b0-4e82-8b29-2ab605828834;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-13T15:57:08Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2702f6b9-5197-439c-8e59-dc209a97bb63
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5f18c74-f044-4834-2c42-08da4d555f87
x-ms-traffictypediagnostic: CY4PR12MB1782:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1782B537A053F3782367BEE9E2AB9@CY4PR12MB1782.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8EDyxOnLzOaoR8qUUqaG1c+z6aXRxJOZ0PYgF2ecs38TAi8y5pLcX+p4CiRKy0EE8aE9qQnHhjSHTt5nCgaWVDqmQzfW0W8YJvDqgaIFXv6yRnRgz7oD4TnaxvOnapx7QF6Nu3Gd+Gkkqwgl6O3aq0aBTDnHwswgYp7bimusTEsQGtbDhbRCyOUBIS2Jfkepzeh66/mNS4KJ+P9JVaqo7nIaLWFkO+LtZMuzbf3aU4BKAlg/1z9A5q60UJqbmc3bKHTtKvOlR5G+VlEaOwG/rwmVYTNQL9knmiAwrVcoACvOFx+dpNsRoU0WRHzLN8NSx/ZEipVUlcQDFovYj7LaRy8zCLnjEXHngo3WWhZrCKtgX+J2SiUH39/bxkI1Ey5A50RM52ojodOuBITrYvWAU1AOSq4ZPhVKR0L1m4atvhl3VxnrXNOLHfI0KmTkK6UD2PEUnYIUTdLF+MGALX7NOG1qMjuyCz6lyGXbacxlvIR/6RPSy0oiUzN19Nmwx/+Ixy+2TvtG+xbkNkUBZWuJHpyS1Tpt1yLm/X7rGXiDpgztcVujWxkBW3aL5pKtpWoTaXBawM/eG9blmzjp2wdeay+HOmv2s8iG6ir+W0y6F9MOvx+yOXPZTEM8w2+wAHe3+1cemS/3gDuRGTSTdo39zwTeBADDwfAOzoSFNH4F7fgsYPHQE9i4f5Wl5SP6B9IXicsXeBfjuMlgYvPsfttlfK52XEXYbP0MQTO2STKtXGo7lJSdvnJZH37/zv41nDsa6kq9zvOHY0jW8NJnIZx+yieN+iqeFCf7RP9kyjHfcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(64756008)(66556008)(66446008)(33656002)(5660300002)(66476007)(66946007)(2906002)(76116006)(508600001)(45080400002)(8936002)(52536014)(9686003)(6506007)(966005)(53546011)(86362001)(8676002)(4326008)(38100700002)(7696005)(54906003)(38070700005)(6916009)(71200400001)(26005)(316002)(122000001)(55016003)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OCBoQVlgz7Om6SC8hXvKrDYAVsTGhvhCgF5NNwO8A4BukJCHtVwds7/GcYKG?=
 =?us-ascii?Q?cWICy0eYVvtyfnQaEN7IAJjUh/r8j0DVmSXlmkEn3Z3/DTovzf/fjfSnLaON?=
 =?us-ascii?Q?KyF3+XJzr+ORuE8J+GC122AdW7uoasNgK1PjuLOoZcS5a8JlqMwxt0xcc7ft?=
 =?us-ascii?Q?HnOjIffpGWbLwD0wld3dOFBkCSGauZkLFXwOPzMGYeBqY+C6dtLScPVFiZmx?=
 =?us-ascii?Q?u5uO5nqVyN4LzBDTUV5PQDCSU9TMr+Va8OusgZ/SHRL1IgFO0NqRV2Wc5JMq?=
 =?us-ascii?Q?rmrWH4pFpWZDGkXqO2Vksar2BhadwjsdFszaiea28R4OdtTF+WIUE9XhezeH?=
 =?us-ascii?Q?0ULDUTOifbcmslOhMz8Zp0Msu8Imo7WAzrKXrkKZHmHFrdjOy8XFOHTym3Ez?=
 =?us-ascii?Q?hj0hPyUFZbVbU3WOynjO5Lyg+r5f5NVx/gYqzhXuriO0PZXy1uc3kkCmD/lC?=
 =?us-ascii?Q?yqj9JnbzUYPZg2jcM+5c96miarEZ8lqgrjaERmgtPMkHZiCRbbZaYJwmIU0K?=
 =?us-ascii?Q?rrqUA3zgdyNBzeL2Ks5mU7E72CmPgCkwFM0/UOC+tcqe/tasyrqbFfds6P2v?=
 =?us-ascii?Q?LfUuV32M1UfDysnQ5Xz9/fjmKK2RwYM6ooNtJ86nN1n0OK9pHyT+o39tjgSS?=
 =?us-ascii?Q?Q3Ano7I2nmB2Ke7o+TPwjESwGPHde6bwt7IbJo497/lYC+Q1bU4ZNqgm/TIx?=
 =?us-ascii?Q?pJ0RV5khDXleAqWp1qn6v0aRPvonJ9W0C69dK3YroMmwarOtVVF390yVVSu3?=
 =?us-ascii?Q?Bpc6libMZPiJt4A2veoxQjxtZxO7y+GgJljgMlQwIADFvhwAoNxzniTid/Yl?=
 =?us-ascii?Q?uAFAbp8lrx4ciVVan85SRjZyljKYQ1jyCxxJY1DoiVaJIXr+6rYEoCS/ujG5?=
 =?us-ascii?Q?r59N8Wd3wo/NxUHj20jeq/Dy2LurOBMpm0s0Wbjy74hwyiAgHxhi0HcRFdXX?=
 =?us-ascii?Q?6zhEN7c0ykyndPEPFu+QbR1i0AnSGjYk/cTTDMOHBlc99PiUkVSmotsNahAN?=
 =?us-ascii?Q?xvfw3HwlzsemIwMUSkyZ04CDcwVZJR1P9RL+/BoF8N3hGteS3jc5h/hq5MJz?=
 =?us-ascii?Q?iMJHBvKkz/S4hknY+gdiO/jq3FtTrP7n5Nnueo6tSQDiBaDo6mZLPhBqy5VH?=
 =?us-ascii?Q?eejnWgy1efdOFneN7+ptyYraL+6OEFmd18bhxVFWi2y1MnsDp2kCYO5DZxSi?=
 =?us-ascii?Q?Gxjq45XCQvJ8qxq1EHrxggmdWjVHAeUbDVE3jqtSxI2IbJh+QSQ+O4JLtz58?=
 =?us-ascii?Q?FBb09jpXNARBB+j9gSYeTgrqbouDn6IhONjeFXNtocpGHasywPwEAZZl1T89?=
 =?us-ascii?Q?pAU7pod53Os/OclzRZ/sfpit8Vlu4JAu/Iv2RPoOVo/V0Si1KDiAhTiePj4x?=
 =?us-ascii?Q?5jWptyBdZtW29SwJEeAEi8BZnJprgNo3+RhbRcdwXW+k97/D1YMHtYPAgGwU?=
 =?us-ascii?Q?f1bxiSddFtWXOrP9Vh0mkfK37VVSPFKC1pnYo6eQ4Bdfj0uzYKOwXorRsj6b?=
 =?us-ascii?Q?CjMVGOgNjmMbyICmEW3p+9CCdqDOErhm5pKpknTozZuY/vcg/BF20PYKwMIk?=
 =?us-ascii?Q?+5YDVGd0dNbMq5OcEmNvI43GkUnmKCZqJWqg3SOX9mfj16MrAcfEcRx4xBzw?=
 =?us-ascii?Q?F2hFHBKecR5Kkkl44kYuZOyA+EkFl+b9usQa6IdxE2fP07Y5JNKfZFdKrW13?=
 =?us-ascii?Q?qKq6SAKn1ST7fM1WrHaQOhzPtSg95M4/3aUv/Bd2SO8MTJto?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f18c74-f044-4834-2c42-08da4d555f87
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 15:57:09.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nl9L0W0lQdt8ClBbY/tVdBlxER5jJLBo21XdpefnNyYkE/AsjLyX+SPNVe96+taSPe0W4LeP9zv8XIRhAMSiNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1782
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



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, June 8, 2022 17:29
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Len Brown <len.brown@intel.com=
>;
> Pavel Machek <pavel@ucw.cz>; Bjorn Helgaas <bhelgaas@google.com>; Mika
> Westerberg <mika.westerberg@linux.intel.com>; open list:SUSPEND TO RAM
> <linux-pm@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] Documentation: PM: Drop pme_interrupt reference
>=20
> On Thu, Jun 02, 2022 at 11:33:30AM -0500, Mario Limonciello wrote:
> > `pme_interrupt` was dropped from `struct pci_dev` as part of commit
> > 8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci_dev"),
> > but the Documentation still includes this member.
> >
> > Remove it from the documentation as well and update it to have the miss=
ing
> > `pme_poll` member instead.
> >
> > Fixes: 8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci=
_dev")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  Documentation/power/pci.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> > index b04fb18cc4e2..a125544b4cb6 100644
> > --- a/Documentation/power/pci.rst
> > +++ b/Documentation/power/pci.rst
> > @@ -315,7 +315,7 @@ that these callbacks operate on::
> >  					   configuration space */
> >  	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
> >  					   can be generated */
> > -	unsigned int	pme_interrupt:1;/* Is native PCIe PME signaling used?
> */
> > +	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
> >  	unsigned int	d1_support:1;	/* Low power state D1 is supported */
> >  	unsigned int	d2_support:1;	/* Low power state D2 is supported */
> >  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>=20
> I'm OK with this patch if Rafael wants to take it.
>=20
> But I'm not sure how much value this section of the doc really adds.
> The doc basically says "the PCI PM callbacks operate on several of
> these fields of the struct pci_dev" and goes on to quote part of the
> struct pci_dev.

The reason that the patch came up is that someone who doesn't normally look
at kernel code but looked at documentation reached out asking questions abo=
ut
these variables at the time a bug was occurring.  I was baffled how they we=
re referring
to pme_interrupt until I found that it's only mentioned in documentation si=
nce the linked
Fixes tag.  So I figured we should make the documentation match the code.

>=20
> But "pm_cap" is the only one of those fields that is mentioned
> elsewhere in the doc, and that one is only incidental.
>=20
> For example, is it really useful to say "the PCI PM callbacks use
> pci_dev.pme_poll" without any other details about pme_poll?
>=20
> I think I would consider just removing everything from "The structure
> representing a PCI device ..." to the end of the section, i.e., lines
> 308-329 at [1].
>=20

That's perfectly fine to me too.

> [1]
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ern
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree
> %2FDocumentation%2Fpower%2Fpci.rst%3Fid%3Dv5.18%23n308&amp;data=3D05
> %7C01%7Cmario.limonciello%40amd.com%7C2302a7c692c545aa56f808da499
> e5ade%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637903241734
> 399580%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DqP0
> NdVaGMl2wzbiWzc8t4eMmilwogsLhEvzn6aJtsD8%3D&amp;reserved=3D0
