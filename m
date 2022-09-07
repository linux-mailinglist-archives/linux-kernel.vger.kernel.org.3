Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853545B0A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiIGQaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiIGQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:30:28 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F53DBDD;
        Wed,  7 Sep 2022 09:30:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSTB21EWoOh9h+GFolDbfFdE3RUZoj/+vhd6FdXl73iK06Ix5jXCWg8bRFBOwKh55AeV1ZcwK8gsbZvDJrmE/d+GYoDu2jtldqIiSoJ0SFbzWIklu1Mm06XLVlYY0DUZj5cQC3eE3+92yHxIssoSW3/Cj5FJpOFHXIQYP2bHhFzR5TODgidHsp5+bWgkfT+czdZ/1hd6WMQXVKD83uVewZqyVBCu48gdo8veXrqplvqf5o9YIdTLX247syTmIrY2D7gA5mqovZD3BFLGrmAY0CFuoSpdF4eTGBARrLY7ZLP2eXxiUCFNRR78LMn/WnQeSxLhJ6Nalp+/RrXmmTwNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts7nlONiyKoXdu164RwZf1VKNbG7Bt7YBWYSmhfdwcA=;
 b=DdLmUnyAQoEbNYvlnZNjpTD+Vo5hAuVr+4h719iAHc1GhoxM+iK04ELuKaP7EumO1VNiB5qzgPJn2uUA7+VC+f/TKgooSM+n2xDl2gB5UF8BwIX8c+sYuJrz471vP3Zx3xZl4n6sR/mFDTCdoT70VmysLtFMBQx/CQs5ZxCQhvBoCXbIKwmdk3In+xd/9SDon6257FzI/qO3O6Rd0Z6jiRIBg+h9paIYLBKuMaGG5cVSEhryK7hEaqGz2PSoc57QM5PKIFRvK3pqjafHqhcJ7DZ7qh025Zgz+NvEVjmMPWObIebN2s8ueykN03+rXH5mRSlAIbaaLdc1UXSOOvPq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts7nlONiyKoXdu164RwZf1VKNbG7Bt7YBWYSmhfdwcA=;
 b=YADFv6b8CDedHujHRnITqld0sxDwa1B4WoDkTVosLZY0j3ZNtlo7cUcicGb82DTK7iTR4FjwhGr142eTTgYFyrCSwf4REvE/mXMNKNQNc0f/z1ofvVyg7DmodVE88ODJHN90StcIpJqI0at1BEjK1WQR3UdwwM2HPZ3BvVfdCNg=
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 16:30:22 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::a829:e4ec:9bcc:fb28]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::a829:e4ec:9bcc:fb28%3]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 16:30:21 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tsao, Anson" <anson.tsao@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] thunderbolt: Resume PCIe bridges after switch is found on
 AMD USB4 controller
Thread-Topic: [PATCH] thunderbolt: Resume PCIe bridges after switch is found
 on AMD USB4 controller
Thread-Index: AQHYwPSi1SqS/lCQjkqzEg6b618N2q3QcK2AgAOnlDA=
Date:   Wed, 7 Sep 2022 16:30:21 +0000
Message-ID: <DS7PR12MB60959AACEDB0AEFEE78A5B2EE2419@DS7PR12MB6095.namprd12.prod.outlook.com>
References: <20220905065622.1573811-1-kai.heng.feng@canonical.com>
 <YxWlc1n4HRxawa/K@kroah.com>
In-Reply-To: <YxWlc1n4HRxawa/K@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-07T15:18:31Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2dd436fe-6890-4ba5-9645-cd12c2499c67;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-07T16:30:20Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 638c7a5c-c772-4c4b-bc22-e02b8a2248c1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d119ff6e-e349-425d-30c2-08da90ee4288
x-ms-traffictypediagnostic: MN2PR12MB4127:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XmOTLLCqBV2YNiMqLFUet4q2RdU4816ufqkclhkRqfx5fzVn09gRbiEF6UMXej7zSZM4p76VA+cixweI1ftuAgkgva/k2vUBbT8xjnBI5BkIpw/6CkLdb54j+cq9p7HHZymTUjB1oY8wAGuPjP4qt9nxQC+CULHcim/Fab0XuzpbV9fpZuLU1KAXSBv3SuyVviysq5gr93bM/mMK2ufrBW/QMdsJHsDb/o/BAYwaFUmvJ8zCFq7UCpWM0TWQCNSfO0Xb+umzGME9sRQMPxLjkhZO5yoPXbNRuSdJ/B1mBpFcS7de1oaQm/BE4R2DJ4wZ8YGe3iYI15x+kO5QkuJHY868ALBpshmPa7eFUwQNceuxd3jMPkDhHhBqApf/muAyPZqXFe9ZFhh/2gMHp0+x8aCXZ9/ZMN+t1XRI+dJbKoDD09ReHENV5SeysWakE3eRsDYa1Px+bmhqBnm0evauq3GHjvuM+rgxwtWNEq7oVBoYId5qpak+BFBXy1e5DZvMXmkJErKPQTTOZ/GBjmZrpctYItvwEntD64urUS710GpIjccz4kH8fwV07wmlheRLHsH1aWrkrMXOc/IowV1hDXK+jJs/SCRJNCt5af0RwjgzcAX8pv7mR8YdSxvuuMojegMqCjh53yc3HX7VxzadqpzPVrpXiKclDHKKpO0KXAlGNJ3Y3lYemCcJrsNqXWIosKOo1IXH5wdK6fxweUOVyIkl2JYVp/30IqheCbm6oI9qyyAsjKkvA3FmFfdD+gWZnsgKRbR7cQePEmswar1tijdiPI+Vj0pW8sXdaAotDg8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(54906003)(6916009)(186003)(38070700005)(71200400001)(83380400001)(316002)(55016003)(41300700001)(8936002)(966005)(26005)(2906002)(122000001)(45080400002)(52536014)(33656002)(9686003)(4326008)(8676002)(7696005)(5660300002)(6506007)(38100700002)(66946007)(53546011)(478600001)(66446008)(76116006)(86362001)(66476007)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VhQgDkzJGHgu3MnGhT+zSm4OhA7VmeyjPUbO0+f7+QdP57tMafOcAEcLjLit?=
 =?us-ascii?Q?OrRGwF9wDtsDEZpyMB1DCLvkFkq57FxEdVVv7wo7155xPgNAxUrBzFVMjoZ2?=
 =?us-ascii?Q?NHcsFxaa72W2NIHs6d57l+s3wg1U/SeoYu5yade49XL/ryLac/uKGLNSRFAc?=
 =?us-ascii?Q?fJlgd1JaQB/01hHP2lZiTDcXnIjmZtq4jkAHL8yqht5Paca7so257VQWeRS5?=
 =?us-ascii?Q?KP7KNMFkJtcpFqHPQIrbIuY/6dVW1VNigwXzKVnStAh3691j3Z72UWZtnUu+?=
 =?us-ascii?Q?fJ3qBoVCzboXrv6WzCMNqJE/sH0ozuoZrunr8nCwLnbmfK3tQQ30KEy2UqhX?=
 =?us-ascii?Q?SEwqjjBSQls2caDtTBAnt/BfeQe1sKX/276IO98uRg2DGwqrC1tMFHHDDrYh?=
 =?us-ascii?Q?VFr2kyN7xj2JAqBTarWtLeeYSGWVNus85JsiR01IQjzzNCN5M7lIYDy/tlFy?=
 =?us-ascii?Q?32QgcHt9+JyrzLxAZvgVuMjsS+N1bYt0Vn8mhqtdUN9bJh6S9EutzT+ijgcl?=
 =?us-ascii?Q?x3wml/xq43MPPAaeMAhBO7RJ1W0pS3dw4TtmgSqKAr2ix2Y65W3+9VF9B3pk?=
 =?us-ascii?Q?YArFxDVXp3A8CBGrWtrf0OShKVPt3YoCgerJWn5Ukyqdp81LVKcL++X0iKtV?=
 =?us-ascii?Q?/l8ymhTMCc1e6gfntJLJbI19/noC6eW7pg+UD0WDveDIekexcn1v2lFaazNU?=
 =?us-ascii?Q?MfOZRVydjI0lPKNf8Qmzg4CjYEl6kf/q9gNpVlbXG85hCdIsSwUW2NleGyaw?=
 =?us-ascii?Q?nNNNCSxqGIalrvB7IUHgRnXPTFBJdn/qEIpp7WJbRhbIozEYBDF6KBEH6FfM?=
 =?us-ascii?Q?v9OQIYJSxTHxsnLkq2FSMN0bgTyG1N4pBMa0mJ7NcVaCLW+st3dkLcNcwxiw?=
 =?us-ascii?Q?7s+UkMsDDyWVoARiWMry6+Z1eGRIwij8TyxQyjLCl86AOR2xuAXU6iQ06uwU?=
 =?us-ascii?Q?6Yu/9O8ATTvqdSgYEwfZkImjOKUErktFf0yZxZEOeVnr1XxJQUIvDtvLKo6C?=
 =?us-ascii?Q?7kTwoMJt+OJf4S4lWQY/ODreQHJjR+G4rNIDVbduMimeVbDZVCMSmliA/3hQ?=
 =?us-ascii?Q?ByCRstG93ajXKo6iauAd37/JvBjpKGvFhIJeocB9/zCApAKibOnYxVYh7zKE?=
 =?us-ascii?Q?Z4yoZJMBXZ2LH4TxYc/He9h8JFraObJJn1nxXTRIjW2BlNF6UKj1Trdz/Yyr?=
 =?us-ascii?Q?cSz3fa07gHqG230tChVzc0waBbE2Kw5UC5egY/hYGD7N50uAo/3NM/74iU3Q?=
 =?us-ascii?Q?ZJFgkHT+JQ91uvIab9OKqNWauePsNIsF9ZBufqpX2oenVr1YT5bTZGUaLlvV?=
 =?us-ascii?Q?UnhCw5pc4d/GBe/mlj4WXVoCIJ+IzgoqBOL95UZWDS9Ad9vWt6MhtmULb4+d?=
 =?us-ascii?Q?Y6Rkbhx17mIqnPpTA15oWwLnSEnGJQHLjYqciOWO757HXeeiF4aRcDONq5Ht?=
 =?us-ascii?Q?FcUvinQUAabX/3G+xsc/FVSBewYU4W9DRbNMgN5RotjjUapTrNleX7bgmcnz?=
 =?us-ascii?Q?8zaIs07gcrRHtkC+LI4VsNGDREwpvhvRaRDNxhZpw3+6ty9UuhnMFYsLXM5v?=
 =?us-ascii?Q?mauT2Ze5abzjJY4PHHE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d119ff6e-e349-425d-30c2-08da90ee4288
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 16:30:21.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jE44915D/6/Bp0WAlkbT2ZV0cMsEcyvvHqRNAJ1VCSgzCYFiWkUZV/gBr+0GWb6e+OhCvOuqZUPlCIZJvDw3gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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

Hi,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, September 5, 2022 02:30
> To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: mika.westerberg@linux.intel.com; andreas.noever@gmail.com;
> michael.jamet@intel.com; YehezkelShB@gmail.com; Mehta, Sanju
> <Sanju.Mehta@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] thunderbolt: Resume PCIe bridges after switch is fou=
nd
> on AMD USB4 controller
>=20
> On Mon, Sep 05, 2022 at 02:56:22PM +0800, Kai-Heng Feng wrote:
> > AMD USB4 can not detect external PCIe devices like external NVMe when
> > it's hotplugged, because card/link are not up:
> >
> > pcieport 0000:00:04.1: pciehp: pciehp_check_link_active: lnk_status =3D=
 1101
>=20
> That sounds like a hardware bug, how does this work in other operating
> systems for this hardware?

We happen to have this HP system in our lab.  My colleague Anson (now on CC=
) flashed
the same BIOS to it (01.02.01) using dediprog and loaded a 6.0-rc3 mainline=
 kernel built
from the Canonical mainline kernel PPA.

He then tried to hotplug a TBT3 SSD a number of times but couldn't hit this=
 issue.
I attached his log to the kernel Bugzilla.

>=20
> > Use `lspci` to resume pciehp bridges can find external devices.
>=20
> That's not good :(
>=20
> > A long delay before checking card/link presence doesn't help, either.
> > The only way to make the hotplug work is to enable pciehp interrupt and
> > check card presence after the TB switch is added.
> >
> > Since the topology of USB4 and its PCIe bridges are siblings, hardcode
> > the bridge ID so TBT driver can wake them up to check presence.
>=20
> As I mention below, this is not an acceptable solution.
>=20
> AMD developers, any ideas on how to get this fixed in the TB controller
> firware instead?

Anson also double checked on the AMD reference hardware that the HP system =
is built
against and couldn't reproduce it there either.

KH, I've got a few questions/comments to try to better explain why we're he=
re.

1) How did you flash the 01.02.01 firmware?  In Anson's check, he used dedi=
prog.
Is it possible there was some stateful stuff used by HP's BIOS still on the=
 SPI from the
upgrade that didn't get set/cleared properly from an earlier pre-release BI=
OS?

2) Did you change any BIOS settings?  Particularly anything to do with Pre-=
OS CM?

3) If you explicitly reset to HP's "default BIOS settings" does it resolve?

4) Can you double check ADP_CS_5 bit 31?  I attached is a patch to kernel B=
ugzilla to
add dyndbg output for it.  If it was for some reason set by Pre-OS CM in yo=
ur BIOS/settings
combination, we might need to undo it by the Linux CM.

5) Are you changing any of the default runtime PM policies for any of the U=
SB4 routers or
root ports used for tunneling using software like TLP?

>=20
> >
> > Bugzilla:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugz
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D216448&amp;data=3D05%7C01%7Cm
> ario.limonciello%40amd.com%7C1e27b1d6f69e42796c7b08da8f107121%7C3d
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637979598042186185%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D0lhcaKfUyoK
> 0FXT9uDZ8a%2Fpxs9tHd8aoQcyPFdB%2F0eY%3D&amp;reserved=3D0
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/thunderbolt/nhi.c    | 29 +++++++++++++++++++++++++++++
> >  drivers/thunderbolt/switch.c |  6 ++++++
> >  drivers/thunderbolt/tb.c     |  1 +
> >  drivers/thunderbolt/tb.h     |  5 +++++
> >  include/linux/thunderbolt.h  |  1 +
> >  5 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> > index cb8c9c4ae93a2..75f5ce5e22978 100644
> > --- a/drivers/thunderbolt/nhi.c
> > +++ b/drivers/thunderbolt/nhi.c
> > @@ -1225,6 +1225,8 @@ static int nhi_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
> >  {
> >  	struct tb_nhi *nhi;
> >  	struct tb *tb;
> > +	struct pci_dev *p =3D NULL;
> > +	struct tb_pci_bridge *pci_bridge, *n;
> >  	int res;
> >
> >  	if (!nhi_imr_valid(pdev)) {
> > @@ -1306,6 +1308,19 @@ static int nhi_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
> >  		nhi_shutdown(nhi);
> >  		return res;
> >  	}
> > +
> > +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD) {
> > +		while ((p =3D pci_get_device(PCI_VENDOR_ID_AMD, 0x14cd,
> p))) {
> > +			pci_bridge =3D kmalloc(sizeof(struct tb_pci_bridge),
> GFP_KERNEL);
> > +			if (!pci_bridge)
> > +				goto cleanup;
> > +
> > +			pci_bridge->bridge =3D p;
> > +			INIT_LIST_HEAD(&pci_bridge->list);
> > +			list_add(&pci_bridge->list, &tb->bridge_list);
> > +		}
> > +	}
>=20
> You can't walk the device tree and create a "shadow" list of devices
> like this and expect any lifetime rules to work properly with them at
> all.
>=20
> Please do not do this.
>=20
> greg k-h=
