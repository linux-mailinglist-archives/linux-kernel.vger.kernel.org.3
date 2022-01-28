Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154EC4A0012
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349057AbiA1SZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:25:06 -0500
Received: from mail-eus2azon11020024.outbound.protection.outlook.com ([52.101.56.24]:4223
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343693AbiA1SZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:25:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOnhy9Wp3d7v4eVqf+C6d+dX4ceEb1h4KHWf2MMzN8bm0DdfbnSjeZlBlHDcC0p/aAYu75/4G+ilDiO4rXIOSzlCVjOKDYcOhPnkK83gks4Nkb9b8+NV924bRohAXEkIhI1Gb35WKjc9Z1joJUxhZe2fL8Q8fumEgehWQg1tQ2wi3QePyLEVkFWZXvyYS2jxDfwciQ03GRRp/k8o+Lz+XfsBlDM89nmWb4+MqCCdndUNw7sok7ZXdXd47BvCZMnB9MgfkCm6UOXW+pcm/D6BJAP53T4R63upME/eU1RAER2y1jvZwGUTNAvyRJ1fOOSWMzGTX3b4tMp0gmLK/Y7N2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW0K/jaKwXbCCuBis96YWNw973NqWmMxPQMcSTJ7iiU=;
 b=cEAvDBciVEhSuUFK6J7BEU0YDDsVMVLXRwNx6ewWxQzaW6SnJHKGqL+RKuU96yTgu30cbxpwtkkpUy8vkfg/JNN4mdJphzkEVrIC8BEItPuTb4CC3bI/aY56S8uZrzxL6e3sWnk3NlO54ndHxVngyFxsWOoGnK6n1H9P6lI6Cuc90OKNrX5JbPns54EHWJ7WcGwcx0s70y+FerNo0+S75oi0jT0qiSaC71lZI+1JPqZXxD5YGuTmFwCDJVPa8w/VyhhDmlhJAjI4DPkP+dXza5tFkmGeN9sEpksL11mJH9AMxz/r5eogXHrLf0Qx7I3MaqOq/Md3NHEAEv1rQykPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW0K/jaKwXbCCuBis96YWNw973NqWmMxPQMcSTJ7iiU=;
 b=OmdDn03qRc0UHDgoXtQslqJTkq/bZlTHsVLmeyneXvjgulBBReSexZP8YFw2ii4yi9JK1mJmvSnvEHtCdiDVn/ppxWzW+MqdCeXaP+wAbeg6VKdIR5SYMDwa4Sw6c9hMzqJieKcUp1BbzmhXgoPxi/Uy9WY4dSn7PyFV6AvJuIc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CY4PR21MB0775.namprd21.prod.outlook.com (2603:10b6:903:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.7; Fri, 28 Jan
 2022 18:24:55 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%9]) with mapi id 15.20.4951.007; Fri, 28 Jan 2022
 18:24:55 +0000
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
Thread-Index: AQHYCXUxbytJ2QSVAEqjOg+wfhk+i6xp9SYAgACP1QCAAR3egIAA1cUAgABSaYCAAMviYIAA6K+AgAPt2jCABctjgIAAmjMQ
Date:   Fri, 28 Jan 2022 18:24:55 +0000
Message-ID: <MWHPR21MB159337667BD11F6F8BCA6A06D7229@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220122043351.GA2596@MiWiFi-R3L-srv>
 <MWHPR21MB15933573F5C81C5250BF6A1CD75E9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220128090311.GA27201@MiWiFi-R3L-srv>
In-Reply-To: <20220128090311.GA27201@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c622f8fe-adde-4de7-aa59-32b3b609cd26;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-28T18:15:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b37a4c6e-e493-4a90-6a81-08d9e28b7b9e
x-ms-traffictypediagnostic: CY4PR21MB0775:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <CY4PR21MB07756F3A6EF5442CC66134B3D7229@CY4PR21MB0775.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AXu1VlaIc0QwdIjZ/MHDxU1woCZfaMxrroxQ951SenoIzZrMXOg5F0IS/c8rnzII0COaJIAHdBXMJff5kPGK4hoibuZimEiPIfwyilSUuFpYFRmxntwUEfjhsy+A/mQDeSgLVhGKvQqxUpHPnv6pN2v3ByZoPvlBGKm8qAJxAQwFzPs5V23DdZRcPtf0kKXhRfjHjWLLCqVzNkCUDJ5QY6xuXYC9oNIuwrveX8+OPIxC9OPSEEm8U773zn73QKSezyz41HbUqaquZl4zNCw/NJRnU3j9/yjBDaISBhrAJepg/L3pPmrd5qs6HYV2JsiEajyxU8IourrXG+tU3PXY4TwII4aZs+HB8si2YzDRbvIiu1NuYacBufqvJpCViteBX+Az2uDeMpnk05MJGzE2xR9UNtsqTercZhzB9Mb32WopjejERrTmjjy5r9LFytS+QF9xtdC5mhPKP1JmR+tzb3XWlnZBrl/AV0dKePrjKvcIsxNxRnqtxPZXsCYwFlyGFvvq7QkDXAbGI56sbF5S5B6oIG5l7JxMqdyHY+uoASo3ZcWHHmeu5Ke9pVZYKlwj6/G9gcTl4qo6fuY5SInzwMDaGM/ag7uLJdLhgDbTQ1DBv/1MnGLiLnoQfnAl77BOPqnxUhOnT1cj+4tHIuFScTB1CN6ZUHZQdoMT01iXWoiDlzcHVD/WrpSj2ZX3en5Ad5JC09TvhVGOMf0bk9JgnVV6exi51deG/dzkHcjV9CWFAvuWApUZYOkDpNvaGsk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(66476007)(10290500003)(66446008)(66556008)(76116006)(66946007)(64756008)(8936002)(54906003)(8676002)(86362001)(4326008)(6916009)(82950400001)(82960400001)(53546011)(5660300002)(38100700002)(38070700005)(316002)(9686003)(6506007)(7696005)(7416002)(55016003)(71200400001)(33656002)(8990500004)(122000001)(52536014)(186003)(26005)(2906002)(83380400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?41RJaIfPwRpmuhCojbOrWvbF+uP1LjsfRgQiXJ/R8+4vXPsC7N7c+FsvOkn4?=
 =?us-ascii?Q?/SfsjLsn7cRcuA/gLmBPaC7BPtk/JOVP8MAaLHCAxpxfMnih9VD9xOfEClIh?=
 =?us-ascii?Q?zJ5OHOQxJVB0Cibk3v/4YsvBcIo+6QNLZ7iEyv6KGEZzyT1F+VffYI8vE4dx?=
 =?us-ascii?Q?NotH5wZvvAOIss9oMAjzgOPpKpvHWwJd1OC2WfNNGaw31jBn53SrPodttMdz?=
 =?us-ascii?Q?uzi8B9zVs7dHENC1prJOuSy/dHLgo1KhbVkOfPIthpQipvCqsItZh6ReuT0Z?=
 =?us-ascii?Q?gTZQSOUiW8hNfm/HAehUSc1iW8VqklTSYc3wNnznhMcbD+2MedysrkIOcnfw?=
 =?us-ascii?Q?iYGsPKDfbd4hqL6y1aikvE9L6tsbBpEjGhLRCsJ9WDt7xGmB9hhrBjZHDYbf?=
 =?us-ascii?Q?ROo+ks+Z9ZKJfTYjbj+UwtwO0rgGXxoCaXTuDADE8g7SyTTiNFY+Tho/Vx3Y?=
 =?us-ascii?Q?mwVi7E508FA5bMdTe8xx9dK+yP+fcXqUp11aSW2ilLPZdlXHMpkLOl80k8ca?=
 =?us-ascii?Q?8L0/SRcVjD8zN8ikxl/7fH0W19DKJBXAk2XNng6UKmUx4UZJadyAGA61cTM2?=
 =?us-ascii?Q?6xbdFOa9FWBWeakH7SMXxGmAG8a9WYn8TQ3YzyX4+fmYmms4nFQg/1RQ94cw?=
 =?us-ascii?Q?ujjeeJBsKt+BtSsQ3aoeXdg8LyzQ4/cQatC6FovxwSWuSk1WauK33bN4qpdD?=
 =?us-ascii?Q?fAKRk6ngSxS+oE5kxURseV9/WATi1zBAkoFgQB8JrSqlXubaTW8DYNPZs834?=
 =?us-ascii?Q?dUcJqa7tXT10vuHQsxTvATYxenJvdtQ/U5eEnslomCPLiavoOnvaRLgr5IPh?=
 =?us-ascii?Q?UfudlrXJJaVuyCt4O25zSmd8+Zt0fneJj3yiLJsfEorGl9RwpZh7ZmZdlOVg?=
 =?us-ascii?Q?QqZQboLOYBR1Ditym5l9gGsVYGO2Uqfh1QePQlEg/HMTEXlqd15BSBdf/JzP?=
 =?us-ascii?Q?96o4ZO0H3ALphzLxgqgyZPknR2wBWfeK/mo5qnHtf/qLjGdM5yzvzsm5NnYA?=
 =?us-ascii?Q?IHuL8xm27sYN6i5GdOi4VHNnUqB0xLQCUz8vPY+VeRTLb80LPANmJ12/7qPt?=
 =?us-ascii?Q?w8FnW+QD44RFociL8BI5WTLkatdqT78wXJNfp/NRmuKBX6fiWAbh5oZUkDGa?=
 =?us-ascii?Q?dssAVxXrZM8NugqUE/g0erYCKJnHjejvjkxXMWpBRJd6utfFjCHY860yabXk?=
 =?us-ascii?Q?HGM0UVeSXd/rgK5BanwgUu4GHmFppk9G6rt7UTNdNZo4cV9xRoXmFunCuSl4?=
 =?us-ascii?Q?P6VJCmnzO3WV0G6jb1UBWgd523LkPH1crU5FVDdjTAfGSxuWS5gi8XgmL0+1?=
 =?us-ascii?Q?qjtJamMuhoaQPUseGjG68NLJ+Zzee6GQpv3B+0QHB/DmdIVuW4CeRdTl9IeO?=
 =?us-ascii?Q?ENPsdw+SHZJ4HFQ2ktSdthxej8SEg4xiA8ee3E5s20IpiUY81ug+UoALJOS9?=
 =?us-ascii?Q?ExvaraZ3NTL5ls70rMDTcMEom5fcRcMYD+mHS+YjiLUWblvQaSrVBI1NM78x?=
 =?us-ascii?Q?S1oKPWMcUHW5sPu1DSULrMzD4d1E214wQj91oKeuMbB945zD4DgMeCJwR2hp?=
 =?us-ascii?Q?fhkqDH/YKgRFAJYvv5zfIgHuNd8Mght6wwEueSwH3EwtKaXTDJA0dIXqX4jS?=
 =?us-ascii?Q?LsQZqS3p9elTJFw/OB/KWMy/r1pptuqnlNpwAg2kmcQlVlsogGrVI/o7TJNM?=
 =?us-ascii?Q?PHpQ7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37a4c6e-e493-4a90-6a81-08d9e28b7b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 18:24:55.0746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98xDLOzDcgmB2zQOAXWhn9f4qC/ZD52MShTd8plJvkaqmfKjs6boIjmDqK5KejoaODHMvvUQMF37mlPTOJCpLFeFRxm+l9qgOcOIDNDsxsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0775
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baoquan He <bhe@redhat.com> Sent: Friday, January 28, 2022 1:03 AM
>=20
> On 01/24/22 at 04:57pm, Michael Kelley (LINUX) wrote:
> > From: Baoquan He <bhe@redhat.com> Sent: Friday, January 21, 2022 8:34 P=
M
> > >
> > > On 01/21/22 at 03:00pm, Michael Kelley (LINUX) wrote:
> > > > From: Baoquan He <bhe@redhat.com> Sent: Thursday, January 20, 2022 =
6:31 PM
> > > > >
> > > > > On 01/20/22 at 06:36pm, Guilherme G. Piccoli wrote:
> > > > > > Hi Baoquan, some comments inline below:
> > > > > >
> > > > > > On 20/01/2022 05:51, Baoquan He wrote:
> >
> > [snip]
> >
> > > > > > Do you think it should be necessary?
> > > > > > How about if we allow users to just "panic_print" with or witho=
ut the
> > > > > > "crash_kexec_post_notifiers", then we pursue Petr suggestion of
> > > > > > refactoring the panic notifiers? So, after this future refactor=
, we
> > > > > > might have a much clear code.
> > > > >
> > > > > I haven't read Petr's reply in another panic notifier filter thre=
ad. For
> > > > > panic notifier, it's only enforced to use on HyperV platform, exc=
epto of
> > > > > that, users need to explicitly add "crash_kexec_post_notifiers=3D=
1" to enable
> > > > > it. And we got bug report on the HyperV issue. In our internal di=
scussion,
> > > > > we strongly suggest HyperV dev to change the default enablement, =
instead
> > > > > leave it to user to decide.
> > > > >
> > > >
> > > > Regarding Hyper-V:   Invoking the Hyper-V notifier prior to running=
 the
> > > > kdump kernel is necessary for correctness.  During initial boot of =
the
> > > > main kernel, the Hyper-V and VMbus code in Linux sets up several gu=
est
> > > > physical memory pages that are shared with Hyper-V, and that Hyper-=
V
> > > > may write to.   A VMbus connection is also established. Before kexe=
c'ing
> > > > into the kdump kernel, the sharing of these pages must be rescinded
> > > > and the VMbus connection must be terminated.   If this isn't done, =
the
> > > > kdump kernel will see strange memory overwrites if these shared gue=
st
> > > > physical memory pages get used for something else.
> > > >
> > > > I hope we've found and fixed all the problems where the Hyper-V
> > > > notifier could get hung.  Unfortunately, the Hyper-V interfaces wer=
e
> > > > designed long ago without the Linux kexec scenario in mind, and the=
y
> > > > don't provide a simple way to reset everything except by doing a
> > > > reboot that goes back through the virtual BIOS/UEFI.  So the Hyper-=
V
> > > > notifier code is more complicated than would be desirable, and in
> > > > particular, terminating the VMbus connection is tricky.
> > > >
> > > > This has been an evolving area of understanding.  It's only been th=
e last
> > > > couple of years that we've fully understood the implications of the=
se
> > > > shared memory pages on the kexec/kdump scenario and what it takes
> > > > to reset everything so the kexec'ed kernel will work.
> > >
> > > Glad to know these background details, thx, Michael. While from the
> > > commit which introduced it and the code comment above code, I thought
> > > Hyper-V wants to collect data before crash dump. If this is the true,
> > > it might be helpful to add these in commit log or add as code comment=
,
> > > and also help to defend you when people question it.
> > >
> > > int __init hv_common_init(void)
> > > {
> > >         int i;
> > >
> > >         /*
> > >          * Hyper-V expects to get crash register data or kmsg when
> > >          * crash enlightment is available and system crashes. Set
> > >          * crash_kexec_post_notifiers to be true to make sure that
> > >          * calling crash enlightment interface before running kdump
> > >          * kernel.
> > >          */
> > >         if (ms_hyperv.misc_features &
> HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
> > >                 crash_kexec_post_notifiers =3D true;
> > >
> > > 	......
> > > }
> >
> > In the Azure cloud, collecting data before crash dumps is a motivation
> > as well for setting crash_kexec_post_notifiers to true.   That way as
> > cloud operator we can see broad failure trends, and in specific cases
> > customers often expect the cloud operator to be able to provide info
> > about a problem even if they have taken a kdump.  Where did you
> > envision adding a comment in the code to help clarify these intentions?
> >
> > I looked at the code again, and should revise my previous comments
> > somewhat.   The Hyper-V resets that I described indeed must be done
> > prior to kexec'ing the kdump kernel.   Most such resets are actually
> > done via __crash_kexec() -> machine_crash_shutdown(), not via the
> > panic notifier. However, the Hyper-V panic notifier must terminate the
> > VMbus connection, because that must be done even if kdump is not
> > being invoked.  See commit 74347a99e73.
> >
> > Most of the hangs seen in getting into the kdump kernel on Hyper-V/Azur=
e
> > were probably due to the machine_crash_shutdown() path, and not due
> > to running the panic notifiers prior to kexec'ing the kdump kernel.  Th=
e
> > exception is terminating the VMbus connection, which had problems that
> > are hopefully now fixed because of adding a timeout.
> Thanks for detailed information.
>=20
> So I can understand the status as:
> =3D=3D=3D
> Hyper-V needed panic_notifier to execute before __crash_kexec() in
> the past, because VMbus connection need be terminated, that's done in
> commit 74347a99e73 as a workaround when panic happened, whether kdump is
> enabled or not. But now, the VMbus connection termination is not needed
> anymore since it's fixed by adding a timeout on Hyper-V.

No.  Sorry I wasn't clear.  Even now, specific action needs to be taken to
terminate the VMbus connection before __crash_kexec() runs so that
the new kdump kernel can start fresh and establish its own VMbus
connection.  You had originally mentioned hang problems occurring
because of running the Hyper-V panic notifier before __crash_kexec().
Terminating the VMbus connection waits for a reply from Hyper-V
because terminating the connection can take a while (10's seconds)
if Hyper-V has a lot of disk data cached.  Dirty data must be flushed back
to a cloud disk before the kdump kernel runs (otherwise other weird stuff
happens in the kdump kernel).  We've added a timeout in Linux so that if
for whatever reason Hyper-V fails to reply, __crash_kexec() still gets call=
ed.
Hopefully that timeout cures any hang problems that were previously
seen.  But the timeout does not remove the need to terminate the
VMbus connection.

Michael

>=20
> Then, in the current kernel, panic_notifier is taken to execute on Hyper-=
V
> by default just because of one reason, Hyper-V wants to collect data
> before crash dump. The data collecting is motivate by trying to see
> broad failure trends as cloud operator on Azure cloud, and in specific
> cases providing info to customer even if they have taken vmcore.
> =3D=3D=3D
>=20
> Do I get it right?

