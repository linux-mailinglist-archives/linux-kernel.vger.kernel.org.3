Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A91498585
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiAXQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:57:21 -0500
Received: from mail-eus2azon11020018.outbound.protection.outlook.com ([52.101.56.18]:32655
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243796AbiAXQ5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:57:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOHR5oTaYycRd3KXd9jFsh8sLoYc6QwRuMEtePuocOxqcKUhKiLVoBO9z95n72HOaoJ5fH30EpeGDcNTFppr4gw4AnuEbiJCmmo3E+1K+/z6rc3xi848qEy8V2zn01kG2lq+YOWS3AQ+YvCGeMwxuieIVLn7wzLPD4pgmjAwQ4NTRI1RSMUPuAEEiAUMoHw4QGVg+sUSTxcmrIH0YF4wdmrmj2zxHC1dHbiocarw3dPMzkIGzYvUXzFmAnVouiMFpc7EafyLLD8FYYfZ5IicBfnbaAzaO5NG+QdwIo5zrEM3wAlwBktMpiMqirEHB7l3WESNIXkDDiedjUSylkoDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJQp3BihuovIYiZ5oTOL0cK1iP60wp6QMeykxEMfrsU=;
 b=NKIfVjGEJHOlykGORwrF7rnfC7ql/tEAR4Z4cmq0a3VuoMa3VBb7vAl7do503T49gIDSgNYgl7cNWw4uLyn99i7s9UGYKUhLhMrB1pD7x8k1jkF7QEmA5WkC9LkR0dfWs6Ya0CqtZlXkjIIQHJnT35LYVZMgma4V4EJyZ1MF+4CWo3jKzxkjqdwRIjYuHBf1vRCPAOXPc9HZ3WN4ftc0nvMiCNkAgl1Mhnz0WrSSn95PPcsDJ1iBivLH5ffCUC/igc4xIAdLfu96LFrYVVoI3Fe9yHrshqLnf4VnqH45ZV6+IPpLvoRupGgVemTqiwjOC7rAXkr4uWHqS+oOYuhvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJQp3BihuovIYiZ5oTOL0cK1iP60wp6QMeykxEMfrsU=;
 b=eCBBtdFpSvmANSDnVDny6+YaYVsGiLLB576c4TQ6zHWvPb09ugd8ttlUjbqE2DOHF2Qwz3by6FgHrLWKzIj9iDlumKE1YLnpAdM4lGxfHPUzvZQu10qteDeajewt7vDe2BWcknkEDS/rhme4OVBrrQ955qX4M4J2hn6xNpCcWzA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM5PR2101MB0904.namprd21.prod.outlook.com (2603:10b6:4:a7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.9; Mon, 24 Jan
 2022 16:57:17 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%7]) with mapi id 15.20.4951.003; Mon, 24 Jan 2022
 16:57:17 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Baoquan He <bhe@redhat.com>
CC:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Petr Mladek <pmladek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: RE: [PATCH V3] panic: Move panic_print before kmsg dumpers
Thread-Topic: [PATCH V3] panic: Move panic_print before kmsg dumpers
Thread-Index: AQHYCXUxbytJ2QSVAEqjOg+wfhk+i6xp9SYAgACP1QCAAR3egIAA1cUAgABSaYCAAMviYIAA6K+AgAPt2jA=
Date:   Mon, 24 Jan 2022 16:57:17 +0000
Message-ID: <MWHPR21MB15933573F5C81C5250BF6A1CD75E9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220122043351.GA2596@MiWiFi-R3L-srv>
In-Reply-To: <20220122043351.GA2596@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff65616c-35fb-46a4-be35-64bc738756bd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-24T16:33:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86f77cc0-2462-4192-4ae4-08d9df5a9438
x-ms-traffictypediagnostic: DM5PR2101MB0904:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR2101MB09044AE3948AB155B36EF692D75E9@DM5PR2101MB0904.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J1MGdn957SNP14hSOrF/0u2+I7cGSXfKK3d78WCHhZUj2reg9nyJzRXyRHx807udiS+o6b6rhjudx1nfAboc8Y26tBQJEqoO+u09kT6K2NEMrfYJU/bGPfggrH+ETwNsMDIFVIFDrgx6P2Vvi8X+e/cI5oDb6M14OgZmenn8RF55Nctr5I1uwnVI8DimIgKiKfn3tzdxiQDpvxU1GnOnUPbIBbiIOhtsH/Ep81nmDJZfpqSXVAKBA3kIhCXjlIecv9g04fdSiEpmBUXYyjwd3VP9YDNW/UoO7fI0P1zmiqFRgItLSSApqZQ7LttN/vpY44VqzztRgynwVqGgMgzl7m8nDbjPUyyNPZp0v8/F1s/tOdGZNTG6nZVmC9MNdk8D6ia6KeIutfCFv+qQvefFOfiap0TAYg+JOZaEP2Kt2mMhuKvdoyM2cpyidpDUlE8Xs06XbXxaknWeMsE580Lx/unyQQd6lC9okgcxC9TewpN2FB/ugiiDLJLqxxHMVVHVipTFpfwQ2/jdL8meX5nS2grDSxTj/MiWKia9fOXfEVpKOrJ0crhoRmrjxWUXEcS/o3GcPNo/cLX2krEbYQcv8AU60Hq9Y9tWMl8SwI9mQ5kKYIpoDYZ/t25xDVbvjgNvygDFSBikBRmssKboKTBJXcvqWIWKcD3qeJ4JCyMi8fp96KfxrbHK+Z5DjjH2K4g0ZecIuKtZ0kNFVNNYtC6lo2YlP3SpZHFa+/8t0pl96/g6d1mfAghPh1xqplNiB+rL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6916009)(55016003)(66476007)(82950400001)(76116006)(66446008)(38100700002)(33656002)(4326008)(64756008)(53546011)(8676002)(66556008)(8936002)(66946007)(8990500004)(82960400001)(7696005)(6506007)(9686003)(122000001)(186003)(26005)(508600001)(54906003)(7416002)(86362001)(2906002)(10290500003)(52536014)(38070700005)(5660300002)(71200400001)(83380400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WYpNE3FgXBjMP8BdtnZZ4BQEH5buVKQm+x661HsloKCAsZCXlfKiMrZVRwyE?=
 =?us-ascii?Q?N//N4L4+JflvYhCj5k52VoM4855vM0E+0A1jy2yC76jaSOlNe5/Kg413P7cG?=
 =?us-ascii?Q?AuG2c6RPigGX1F/yKfTkfWOgWutuc0jbFwGzNc9ouoyZsWZOH+Hh99N4U9/Y?=
 =?us-ascii?Q?sZp8K9fLaAMgRkTP7oreHuHDIv1yCAKp7UqVn1WX9/EATEWeKc88BxG/uf7B?=
 =?us-ascii?Q?Ry0/4DSUQRrqlE4+N1avi+/7KLic6LlRgfs9KmjK4haM9eJlFqv5r0lS863o?=
 =?us-ascii?Q?dd5v0siIreMfNfFPf9/q60fbqcwkdD8WwNikWLPi9eRlXsvXwxNIYkKtzBqk?=
 =?us-ascii?Q?q8DIZiNsgh06HU3FW5IKyTD4g+sB20IYP70FoFNDacg2huUGUwIQh2st5dhH?=
 =?us-ascii?Q?JQHilqlJvIeHi20Pb1tOJZF7mC+lWFNXHdF8GN/qkhWjmi6aEugOAbnsuQ/E?=
 =?us-ascii?Q?vpzE3wPaYoJgcFwWthJDSmTCy5KXC9Wmz5FuuzdJ1N8LQ0yVct06J5BtC7+l?=
 =?us-ascii?Q?CNSQGSgQ90vusFJ/VfHM/Lzlig9H5MhtNCnU633gazB0Or4y0t/fxdsEYiCL?=
 =?us-ascii?Q?7xEQIjaoOv30QmhMqO/BuQj9E2AZeAhHj4GOy0GVA2YMHLlT19T9RZjtK4ae?=
 =?us-ascii?Q?3MqInYyGEGdNE+yufOFCNcsBOUQephIRLXZqOPnn0rVX+Ghucpn2//Eomedx?=
 =?us-ascii?Q?l0BfdYJmJVgSyje8d2W6/1TzFe3IZsnvMZ0qXSFAkxWYkM0t3UKu2GBDLZeA?=
 =?us-ascii?Q?oY/2ZDhm00aGKjnBtIwDc8+GBgkeQ1hzC2C7YuFJAqNwscAHg0/mSUjFPBn4?=
 =?us-ascii?Q?sXSuoB5yx/xlJIZXz8P7rqKtBhsIdUautLTR8mKaK3IrOilZZDucSMyzk+3f?=
 =?us-ascii?Q?XmxdfrwN1Bjcx7gngDNXt4NMVLfgXgAleAtwi4CJ3/3LVpfIQnjs1PVJlljB?=
 =?us-ascii?Q?cIkIuw0sQ3NvKoQczTnctzqSsrGqVGmB59MrMuHlS9jwLCEAk4CwJ2bhIzyX?=
 =?us-ascii?Q?lb8U7W04YRnapgeI1N01rvxvaBEy2SvCaTwI6jU1upbkS+gvDpJLb570xVDB?=
 =?us-ascii?Q?9bVE3kguPD504En1LKpQAGnhjvO8QAFRGu7vlqSGvaMfYgEq6B+Dg3o4uPAw?=
 =?us-ascii?Q?IWr9tJh6Qp1p81dR/lSz0WDfHbDMoE6wBTjXLqzckWLvNITMzvPoafJCLNht?=
 =?us-ascii?Q?sCwtMQkyO7gzc61Iswg8t2oNlLX99RZyD2vDm6ECP1vWzDU4IgnCqyIicyZz?=
 =?us-ascii?Q?gFg4v5HCxDhrWYyDd12b25G6nNzZILxNVZQ10lnL04+tVPM5IHz9YjBwV1/S?=
 =?us-ascii?Q?gS/nCuy4FVuE2nMqcuM53VPpKQC+M/JrZI3gPLEHNSORVgc8+sB05B116GK9?=
 =?us-ascii?Q?Z/bR8eV6Qb50tZnKhaM6YWkg0zEun4pNS6z1W8Y1Q/uMisjeBPnMDBaLWrdJ?=
 =?us-ascii?Q?pr/jVWHtXNhhRiTmECpPpYkjgaKoP/AdBHUfBC9MNl0bA5cTaFu62QJXbQnl?=
 =?us-ascii?Q?ByBrfT7tOtBOGikh88cj0a/JBagTk+btATlt2thHboQZibB4u1UB4hJbdDqy?=
 =?us-ascii?Q?n7EQpg13QSBEXl2SNjDCmMjUn1zDyFQsy+ERpBAnwAtrS2IjGpGoaOZ1x+Qc?=
 =?us-ascii?Q?qoOYznRIDvzOMu9GFmYIX1nSkNUoSZnnUfYxVIRRJQ/PFmTlsxoB+aEySyQu?=
 =?us-ascii?Q?IJMWUQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f77cc0-2462-4192-4ae4-08d9df5a9438
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 16:57:17.5253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7o4RrIFoo5r2jteZ1qBOehEF1qtVTeglAKQHOmJdpce7hK+NImifeaMBYcPU8dmB5N1VKazRPj65zSw24zdAxLGADTmevl7Wzlc5Vkanok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baoquan He <bhe@redhat.com> Sent: Friday, January 21, 2022 8:34 PM
>=20
> On 01/21/22 at 03:00pm, Michael Kelley (LINUX) wrote:
> > From: Baoquan He <bhe@redhat.com> Sent: Thursday, January 20, 2022 6:31=
 PM
> > >
> > > On 01/20/22 at 06:36pm, Guilherme G. Piccoli wrote:
> > > > Hi Baoquan, some comments inline below:
> > > >
> > > > On 20/01/2022 05:51, Baoquan He wrote:

[snip]

> > > > Do you think it should be necessary?
> > > > How about if we allow users to just "panic_print" with or without t=
he
> > > > "crash_kexec_post_notifiers", then we pursue Petr suggestion of
> > > > refactoring the panic notifiers? So, after this future refactor, we
> > > > might have a much clear code.
> > >
> > > I haven't read Petr's reply in another panic notifier filter thread. =
For
> > > panic notifier, it's only enforced to use on HyperV platform, excepto=
 of
> > > that, users need to explicitly add "crash_kexec_post_notifiers=3D1" t=
o enable
> > > it. And we got bug report on the HyperV issue. In our internal discus=
sion,
> > > we strongly suggest HyperV dev to change the default enablement, inst=
ead
> > > leave it to user to decide.
> > >
> >
> > Regarding Hyper-V:   Invoking the Hyper-V notifier prior to running the
> > kdump kernel is necessary for correctness.  During initial boot of the
> > main kernel, the Hyper-V and VMbus code in Linux sets up several guest
> > physical memory pages that are shared with Hyper-V, and that Hyper-V
> > may write to.   A VMbus connection is also established. Before kexec'in=
g
> > into the kdump kernel, the sharing of these pages must be rescinded
> > and the VMbus connection must be terminated.   If this isn't done, the
> > kdump kernel will see strange memory overwrites if these shared guest
> > physical memory pages get used for something else.
> >
> > I hope we've found and fixed all the problems where the Hyper-V
> > notifier could get hung.  Unfortunately, the Hyper-V interfaces were
> > designed long ago without the Linux kexec scenario in mind, and they
> > don't provide a simple way to reset everything except by doing a
> > reboot that goes back through the virtual BIOS/UEFI.  So the Hyper-V
> > notifier code is more complicated than would be desirable, and in
> > particular, terminating the VMbus connection is tricky.
> >
> > This has been an evolving area of understanding.  It's only been the la=
st
> > couple of years that we've fully understood the implications of these
> > shared memory pages on the kexec/kdump scenario and what it takes
> > to reset everything so the kexec'ed kernel will work.
>=20
> Glad to know these background details, thx, Michael. While from the
> commit which introduced it and the code comment above code, I thought
> Hyper-V wants to collect data before crash dump. If this is the true,
> it might be helpful to add these in commit log or add as code comment,
> and also help to defend you when people question it.
>=20
> int __init hv_common_init(void)
> {
>         int i;
>=20
>         /*
>          * Hyper-V expects to get crash register data or kmsg when
>          * crash enlightment is available and system crashes. Set
>          * crash_kexec_post_notifiers to be true to make sure that
>          * calling crash enlightment interface before running kdump
>          * kernel.
>          */
>         if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABL=
E)
>                 crash_kexec_post_notifiers =3D true;
>=20
> 	......
> }

In the Azure cloud, collecting data before crash dumps is a motivation
as well for setting crash_kexec_post_notifiers to true.   That way as
cloud operator we can see broad failure trends, and in specific cases
customers often expect the cloud operator to be able to provide info
about a problem even if they have taken a kdump.  Where did you
envision adding a comment in the code to help clarify these intentions?

I looked at the code again, and should revise my previous comments
somewhat.   The Hyper-V resets that I described indeed must be done
prior to kexec'ing the kdump kernel.   Most such resets are actually
done via __crash_kexec() -> machine_crash_shutdown(), not via the
panic notifier. However, the Hyper-V panic notifier must terminate the
VMbus connection, because that must be done even if kdump is not
being invoked.  See commit 74347a99e73.

Most of the hangs seen in getting into the kdump kernel on Hyper-V/Azure=20
were probably due to the machine_crash_shutdown() path, and not due
to running the panic notifiers prior to kexec'ing the kdump kernel.  The
exception is terminating the VMbus connection, which had problems that
are hopefully now fixed because of adding a timeout.

Michael
