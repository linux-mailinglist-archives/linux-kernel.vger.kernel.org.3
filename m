Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D254A76FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbiBBRoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:44:03 -0500
Received: from mail-eus2azon11020016.outbound.protection.outlook.com ([52.101.56.16]:40269
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231680AbiBBRoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:44:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdzh6G3Fd5C5tpWPK0GHornZpq2Xlj5j6xdRsMLYGGEZeMkSJbeUp6/VZbTslcMmMCUbSV6hk+VSG9xfyrPJcsbDeDPiej74LgSJ1Z2q9Jq+yAWtU7wcy0VtzBc8mQzJv+DPjDC3x/Nym8FKOTyGkIcJGtPqRt2TxUnH1BoZdc39MQlxs0wkD5M/P0Zll1b8Z+JB3GSKJFOx66Wu58q5cZM7XOrpbdY8cNjuhBTMociS5/tbStnMuLq8fcJ0WtR/7tNWC578wULgsH/eZeVc7346Y5yBIbe6Bk2gk96uPX0aQNZSR+kJ6nhZXQIbwI2hQgXDB+As1hwSg2kuPOgvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxL2OqZDBUQGEFrZbBPVcWka6f81sX3IcqDX7i4Jt9I=;
 b=Re/IDThy6o6nWi7w5Q9PHpT7l1hpSH4WbTHk+4zAGPZj3sjrsptZ45pICGHwLXVIkQ1l+dvdUhOCfrpWj6iLhvfXfWIho+GMhaEgG1vBphU2tQhfZIvAfXg+kHLjat9iKEUJvewvzPtQWYkRDf0WZT7BQXLiTLhZnwIKlJBYs3NduZG8AXY6TX1tEl7jOPbB4w1uFaEL1RprjPQnHZ3JRFp5fGaGnpjcNdLGT2Lpv4ayX7NjCB2cWCWWEeFwd/gUdP/vPQzS85mQXnVngw1/S4xWbe2nbY5tQFmWogNbqKzlG33VL15LGceirpyxdsvnBmSWUnatUuRJWjo0tNXZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxL2OqZDBUQGEFrZbBPVcWka6f81sX3IcqDX7i4Jt9I=;
 b=X28krNSPFdFa64z0vc/gqet8008WqEZCk6mJpTKr232NyHa8rTsE3bAiqNxGiVBTKGLFJQFItB/dnK0eQn0ixKZ/CimhWSARDnJ9pmBWbVni2r7K979eXaYHFgKb8+FqHixLnEGNUK7PueO/aeB945gD9LAoGvRjC4UwR5zybuY=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1002.namprd21.prod.outlook.com (2603:10b6:302:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.14; Wed, 2 Feb
 2022 17:43:57 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%9]) with mapi id 15.20.4951.007; Wed, 2 Feb 2022
 17:43:57 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Baoquan He <bhe@redhat.com>, Petr Mladek <pmladek@suse.com>
CC:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
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
Thread-Index: AQHYCXUxbytJ2QSVAEqjOg+wfhk+i6xp9SYAgACP1QCAAR3egIAA1cUAgABSaYCAAMviYIAA6K+AgAPt2jCAAtXOAIAEdmOAgAbpCQA=
Date:   Wed, 2 Feb 2022 17:43:56 +0000
Message-ID: <MWHPR21MB15933C9D208DF3973877B1C3D7279@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220122043351.GA2596@MiWiFi-R3L-srv>
 <MWHPR21MB15933573F5C81C5250BF6A1CD75E9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <YfE1zuhB2Qz73wqF@alley> <20220129080027.GC17613@MiWiFi-R3L-srv>
In-Reply-To: <20220129080027.GC17613@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=287269c4-6eb0-4dbd-bf3d-71be55845373;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-02T17:32:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ca1ec66-52f3-4fa9-4112-08d9e673967d
x-ms-traffictypediagnostic: MW2PR2101MB1002:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW2PR2101MB100263C095086F802348B2ACD7279@MW2PR2101MB1002.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lH0srm7CthiU8R8R5Is45XccELk7aotXvXmzhHRYf6LnXbRizgz8dPdCUkCcPQ2vkOOQ+8Rznf96Wj1f9XuaRhzkFNUTMHmQldtjQiR2oyRjyVaFamFEdUAjP0mSZAKvzM/sRurUP2fARroGOTySTkE9RBq6AdYt6CVtOI9E853qh/Xo0RVHFy9rqtiVeJ+O0NC2LKc6s0xPL3GIGobiVpMBckW8+hj8XT06k6UGAs0HlCfkkXY3X/KXD16T/D/alnIWWz7uDlxYQmSh1vjV8WIhN0FTd8br/92Zeb39SviGsUE7DQ3/BNw/YHxcNYjH5lMvXTx+Q9sp5JRpR20eVrrDk927fG3oGXZNU9l5Gl2e3WqOYsCDnZEKM6J4GEJ3kFr3MTNOCUdBQFxs0yIXtV1zaahkeBHE6sJ9q5/MuANsv7Y9NJQH9H1Z/OmNkKZIaDlqFpzCEf04ldAGVgm8Fe/5RBGNmUu/bBqR5lhRq1nEs/cG4yv2fcxTSX9Xl9ttJYLDMPF8PuEM8ezzZ7mvNCLjoasJmU1YKAV5HPsCGP9WBPqvoK5TEOT/z3CW+insxcuRXIstJ3OChOfpGLUGdRBhDyPFuZBzIDNDVD+aps0bKkNEgxV8YWTHwtXdheb1a+iRdWAEmLlC6idAvUMiDMvvMfbNSZ7oU03VzbWvsxuWRvMmDK7iCUeEy1ukdk2dmTu7fbuxF08/vZn5k+D6EPNaeiiHg/cRp0JwIg+AXFM+sw0MoSXdSu/SfQeoJ5NE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(2906002)(4326008)(186003)(26005)(33656002)(7416002)(66556008)(55016003)(86362001)(9686003)(8936002)(8990500004)(8676002)(66476007)(66446008)(7696005)(64756008)(6506007)(66946007)(53546011)(71200400001)(122000001)(83380400001)(316002)(10290500003)(82950400001)(508600001)(76116006)(52536014)(38100700002)(54906003)(5660300002)(82960400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KkoqnVwjG0B4mtdaHRbTd9qZYHT4K4k3YuzCnpOvtcZ/aFcQZePIHq4pR7oA?=
 =?us-ascii?Q?CItPWoTGS7x96lnf72Cl132uPs9EBDHBdXc5xbQx2sbtynnXrCZNK8oVW+ez?=
 =?us-ascii?Q?umH4SSTqGiXtRxdbxpuyDmBmySxLycOCJ3Fn9de980z1jKC+jbpt+9mjseMi?=
 =?us-ascii?Q?tsDoqcyNk3Dhy11Lu78c/QFblIXbEfLTnkzyEKy3kMC7vU4bTW21DRWiKg+M?=
 =?us-ascii?Q?2Cz7mTW7802oWFIo4U05XPxQN9zVc0RT7bwVUy2iqyg/7g25un39A8yMZcWZ?=
 =?us-ascii?Q?lJBdZbelhxAsVlIyIsxDpUftn7HjQ7VKAlqitCpyBCw71qGmktmSTuEKZu5T?=
 =?us-ascii?Q?st85xXGmRoyJPMT778LLySz97rBpXj6wGyNZq4THqLSOwY1AaLUW4rpAdx9u?=
 =?us-ascii?Q?VKx6fjVvVWaMjX1kD3r/4RGRbzmdTrg+/rN73RJuTnQXXLpn7bDzBUi0jLsT?=
 =?us-ascii?Q?9UbvJipukMb5CytmM7NqYbvzJ0l9IDseGwV2uYHFdDRKjJmVE+vN2V21Jzw/?=
 =?us-ascii?Q?3ZdlPvh8Yj/H/75VDs2tTQDDY0k+4HmwANskJM+ec+cUCZzGe6c32jvH+6uV?=
 =?us-ascii?Q?nPyM/2hjTq7bBKAs4ITvzpKUJqV6TwT3uvqhF5mhZ+aeJ5rKckH6YqOtEHgE?=
 =?us-ascii?Q?f/lCsd2fx6NY4gGaqkWKhqqY7TrHnoRBVnQrrX8stQf8W56Vs6EEpSa2s//W?=
 =?us-ascii?Q?8/yUR5Ou7abkqWXa6B9qEGTJwjZkl7yJfl3S3g62dXO5MZ4R/bA+tHK1rzK/?=
 =?us-ascii?Q?+82UD7W6Jwob7GH8N5wvZ9sRBuc/JwgO8xvKyvllqRHcKKlFXrgGORzpR1lc?=
 =?us-ascii?Q?kAX7grk5P8iAoOAohHWE5yEa0IeH70nIb8BwI4vPbB7z10snQnIL9/O5E9X/?=
 =?us-ascii?Q?QpC9Mp0z9qhMS/CaYKvEhVHOSNEV8HmEe/ZXkyqOcB+w1ONl6qJc3RNcYqrF?=
 =?us-ascii?Q?2mPbB1+dR2BTIEaAc4gRMMVA93NX4dTZm4F7PYjdF9JqUSmKMtKoN4kqKxsN?=
 =?us-ascii?Q?1QxpYyc06ksbuiaja+Vq0t08PKG5A4FLJTs1FKaEJcyyNRNub+ptjujDC/C3?=
 =?us-ascii?Q?2/1YQHZmIAMJbFyRQyzLqmCkNUEzjEdlrME1WlG98xHJdHMYEPRgwZ+vu8BI?=
 =?us-ascii?Q?3FhJ0R7JylIeEliLhCVJxgVLYSpxw45XiYH5XZNzwJPbrP6emhz20jzsXxW+?=
 =?us-ascii?Q?amRW8MsQ2TIlwPbtCc0nLRwiIoiVq8TFODIRAl/ondTq30B/40F+YFJFo3/q?=
 =?us-ascii?Q?GAC7iZNba1pbiaC+5JgR62QOhaf7QynSJvFLEwY/QNRmoUjqKUL5FH28M+o+?=
 =?us-ascii?Q?zs8YcWEaXF2OT1qTTlyS3a5w42WpOWOTkof0CLa0ORQmxFjKUTiF7dgKJVH6?=
 =?us-ascii?Q?tXM4evl/vXZ8zQv1aNGDJ4W13y4+ePu9+EC6i2QDy1V2dOwbB7+hot1G5VfP?=
 =?us-ascii?Q?L/aGpHUVtwKl2frA4zToLZ7l4J8VAvdch5yvb4KDvLYBGtUhosiEssD7Ppst?=
 =?us-ascii?Q?2hpS3CUfjYvd18TG3g50UXpWTXtgDe4lNQz58BQRWT085roqogF3PLeNFqqP?=
 =?us-ascii?Q?+UVK7SpimQ6Q0DKPNSDn0X6uoTemhOo+NO/zQ2wCWbjPPSTDCJ8Z9gDt0OW2?=
 =?us-ascii?Q?zIp1byYrXmmQGmx04y/EB4L9e4xMCNjzBoZDdeivv5EQRmbWfI7UvPI55HT/?=
 =?us-ascii?Q?+DGdow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca1ec66-52f3-4fa9-4112-08d9e673967d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 17:43:56.9204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOrqmOcoOT9qvv9MoBIHs3LPQDdMAB9E/OxLx9dtraPSa7j/S+6bRqxKTZ2P+6jaCeIJLY8l+rct6D1aBygyhsMk8eqj7w5rHD6XK/fAZLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baoquan He <bhe@redhat.com> Sent: Saturday, January 29, 2022 12:00 AM
>=20
> On 01/26/22 at 12:51pm, Petr Mladek wrote:
> > On Mon 2022-01-24 16:57:17, Michael Kelley (LINUX) wrote:
> > > From: Baoquan He <bhe@redhat.com> Sent: Friday, January 21, 2022 8:34=
 PM
> > > >
> > > > On 01/21/22 at 03:00pm, Michael Kelley (LINUX) wrote:
> > > > > From: Baoquan He <bhe@redhat.com> Sent: Thursday, January 20, 202=
2 6:31 PM
> > > > > >
> > > > > > On 01/20/22 at 06:36pm, Guilherme G. Piccoli wrote:
> > > > > > > Hi Baoquan, some comments inline below:
> > > > > > >
> > > > > > > On 20/01/2022 05:51, Baoquan He wrote:
> > >
> > > [snip]
> > >
> > > > > > > Do you think it should be necessary?
> > > > > > > How about if we allow users to just "panic_print" with or wit=
hout the
> > > > > > > "crash_kexec_post_notifiers", then we pursue Petr suggestion =
of
> > > > > > > refactoring the panic notifiers? So, after this future refact=
or, we
> > > > > > > might have a much clear code.
> > > > > >
> > > > > > I haven't read Petr's reply in another panic notifier filter th=
read. For
> > > > > > panic notifier, it's only enforced to use on HyperV platform, e=
xcepto of
> > > > > > that, users need to explicitly add "crash_kexec_post_notifiers=
=3D1" to enable
> > > > > > it. And we got bug report on the HyperV issue. In our internal =
discussion,
> > > > > > we strongly suggest HyperV dev to change the default enablement=
, instead
> > > > > > leave it to user to decide.
> > > > > >
> > > > >
> > > > > Regarding Hyper-V:   Invoking the Hyper-V notifier prior to runni=
ng the
> > > > > kdump kernel is necessary for correctness.  During initial boot o=
f the
> > > > > main kernel, the Hyper-V and VMbus code in Linux sets up several =
guest
> > > > > physical memory pages that are shared with Hyper-V, and that Hype=
r-V
> > > > > may write to.   A VMbus connection is also established. Before ke=
xec'ing
> > > > > into the kdump kernel, the sharing of these pages must be rescind=
ed
> > > > > and the VMbus connection must be terminated.   If this isn't done=
, the
> > > > > kdump kernel will see strange memory overwrites if these shared g=
uest
> > > > > physical memory pages get used for something else.
> > >
> > > In the Azure cloud, collecting data before crash dumps is a motivatio=
n
> > > as well for setting crash_kexec_post_notifiers to true.   That way as
> > > cloud operator we can see broad failure trends, and in specific cases
> > > customers often expect the cloud operator to be able to provide info
> > > about a problem even if they have taken a kdump.  Where did you
> > > envision adding a comment in the code to help clarify these intention=
s?
> > >
> > > I looked at the code again, and should revise my previous comments
> > > somewhat.   The Hyper-V resets that I described indeed must be done
> > > prior to kexec'ing the kdump kernel.   Most such resets are actually
> > > done via __crash_kexec() -> machine_crash_shutdown(), not via the
> > > panic notifier. However, the Hyper-V panic notifier must terminate th=
e
> > > VMbus connection, because that must be done even if kdump is not
> > > being invoked.  See commit 74347a99e73.
> > >
> > > Most of the hangs seen in getting into the kdump kernel on Hyper-V/Az=
ure
> > > were probably due to the machine_crash_shutdown() path, and not due
> > > to running the panic notifiers prior to kexec'ing the kdump kernel.  =
The
> > > exception is terminating the VMbus connection, which had problems tha=
t
> > > are hopefully now fixed because of adding a timeout.
> >
> > My undestanding is that we could split the actions into three groups:
> >
> >   1. Actions that has to be before kexec'ing kdump kernel, like
> >      resetting physicall memory shared with Hyper-V.
> >
> >      These operation(s) are needed only for kexec and can be done
> >      in kexec.
> >
> >
> >    2. Notify Hyper-V so that, for example, Azure cloud, could collect
> >       data before crash dump.
> >
> >       It is nice to have.
> >
> >       It should be configurable if it is not completely safe. I mean
> >       that there should be a way to disable it when it might increase
> >       the risk that kexec'ing kdump kernel might fail.
> >
> >
> >    3. Some actions are needed only when panic() ends up in the
> >       infinite loop.
> >
> >       For example, unloading vmbus channel. At least the commit
> >       74347a99e73ae00b8385f ("x86/Hyper-V: Unload vmbus channel in
> >       hv panic callback") says that it is done in kdump path
> >       out of box.
> >
> > All these operations are needed and used only when the kernel is
> > running under Hyper-V.
> >
> > My mine intention is to understand if we need 2 or 3 notifier lists
> > or the current one is enough.
> >
> > The 3 notifier lists would be:
> >
> >    + always do (even before kdump)
> >    + optionally do before or after kdump
> >    + needed only when kdump is not called
>=20
> Totally agree with above suggesitons for Hyper-V. Cleanup as ablove
> seems necesary. Stuffing them into panic_notifiers package is not
> appropriate.

Baoquan -- if the concept of panic notifiers is broadened as Petr is
proposing, with three different notifier lists, are you OK with the
Hyper-V requirements being met that way?  Having a generic
mechanism seems better to me than adding #ifdef CONFIG_HYPERV
code into panic().

Michael



