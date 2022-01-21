Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658604961AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381447AbiAUPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:00:31 -0500
Received: from mail-cusazon11020027.outbound.protection.outlook.com ([52.101.61.27]:53682
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238192AbiAUPAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:00:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5FVhK2u1pkchctwvxsqKcqNika8ONGIRpsEe0voOCxoW5l14G9PHTxsTam2AeyoV1yFcKZsRQMupQs6OAppjidLRvkJlXkCOKLjt2bkVuDgMzAmkeCQIBtr2uvmOAYutOD6CSSIzdyjySsUfKd4rSSyGWxmbuqHHLUAu9d9SUtGWlEtkF+fvs5+PsjJ35Pbo/g9YYfyM4q+9AuThH8L8DPLN5Gtys2NeApqy2RrSiJpbILqhi11luOSITvykZzfKrXnyMmvZ5efBQulWamkKttFgu9SeNgAQFEkikKmHiKRo0jXwYsQgtJQiJC7zAGqHbu8ymjPbBn+2txuppCVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv3g7fUEcrUQsbdoydcaXB3S/61z4cEDU0uiaz+eWuU=;
 b=ISkM6z9cuT6Xi+x9G5y/3TtCpI8154dxddRF9J60ZYRhK0ekfmQFE3ApxxZT+tzSElqhSQvsBECcO4XC0zRxEmmo16n+GsBkncVAqsqJcKyfD50VgiHloEx9cOBWVngrBVnBmMGJyf9olup6BakqRB3h63yKqMg+egqbzpbLMJ/G1oSgV7r80wNUAKHLoxqXV3OOVjmk4iOmLdFLeYnKPLC9CpqV5aZy6yHh0WyhN8gkHCacPRqrxeGKspAycXZvsD5S8qcRALSTsxfjc/KRDK5sDkn7vdH54BWo3RdgqtjqEYffPzpaX8KEWWvimukBvg2eSF8tAmOlPZ7BNc317Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv3g7fUEcrUQsbdoydcaXB3S/61z4cEDU0uiaz+eWuU=;
 b=P7tQtHGZ7sTY83K5ffsJMWshnHMeOnNC7qqz0UjmU/rHrKTaLK+gvB9rFrFJ/plqNHqq49FnZGwJ4sBwr6BvDnWF/luTNqYrLDhtYe15geYypdueF7dV+hRHXE5JB5K7zPYcAwyYioD2/npGLl+9H7kOqsGtXvxhaiKDoDhiJTk=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by BYAPR21MB1607.namprd21.prod.outlook.com (2603:10b6:a02:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.9; Fri, 21 Jan
 2022 15:00:20 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::61d3:a4c2:9674:9db6%7]) with mapi id 15.20.4930.006; Fri, 21 Jan 2022
 15:00:20 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Baoquan He <bhe@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
CC:     Petr Mladek <pmladek@suse.com>,
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
Thread-Index: AQHYCXUxbytJ2QSVAEqjOg+wfhk+i6xp9SYAgACP1QCAAR3egIAA1cUAgABSaYCAAMviYA==
Date:   Fri, 21 Jan 2022 15:00:20 +0000
Message-ID: <MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
In-Reply-To: <20220121023119.GB4579@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=188a899d-4690-44f9-b319-c23284fb3c57;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-21T14:41:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95e65024-1575-4c7c-9b0a-08d9dceebeac
x-ms-traffictypediagnostic: BYAPR21MB1607:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BYAPR21MB160797CB57B99F2FDF3300BDD75B9@BYAPR21MB1607.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZWufyBbDztgCBfw148qtQQdLMvblS5udjGQ/U7QYI3kQZfhFOtTzQZwTFQLvV+yMxXAQd1Ldl1PwIHRaXnGJ33HRTo23AaMLCiM5SeGBPIoVJju3SNxr6T1WuLP2SQvX3+nohO0KwHL/0NSUVypTsgVnPzaMcTqEf/DPcnreX6k4BC7pNZNB8t01tBCkkvaUViyxwEmyYuAQqpG9zxOyWQvLgf4gcIsKynaIWCOdCiPT/eA5JutUWgOPGIVd4gp7T4lCyjBIEfRSt4jn1syLprahzq1xjSmuZLVWod8bHWSTYYcaCquEDzvjbd1T4jSIR6YsnLUK59eSVJxlEs1KiOTdma7EkjhvdO1J1zPLbPF6i52cV1iO8ZPSeyzON+WrqlLuCH0DFPz/PR8Y5fDlSnVgluKlMRIU58tjqPmKQiufVgvLoJlregd/hwO23ZpItHHVShBnrg6NiL0avK0BZaKS08PQUa7jwDanRo9oS3qvszBgqyFEWF3MquxmkS2fHZXWm/xSilfEW4LahsCnOXVMN+2KGXzf03XxaT8sOZNa8NUeRy5HW09F41kFyd1+yS+0opfbfUqeyuYV9dKq6tATpg8jk3iz3skpmK0sI23LnKNNJwE6flngIT6Mq8CW6MN9xheq6a0fyRZo0MeL+9xBhqxM1iP/8bh480O85zyBad82dNjl+ze/8JnpbTog5+2BmOALoCcSHVl36cbwedPDqM+lklM8bOpJBnrmhTKyFKRMu5SqOuIUQPjJhcc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82950400001)(82960400001)(316002)(10290500003)(38100700002)(508600001)(71200400001)(76116006)(110136005)(55016003)(122000001)(54906003)(86362001)(38070700005)(7416002)(5660300002)(6506007)(8990500004)(26005)(186003)(9686003)(33656002)(2906002)(52536014)(53546011)(7696005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8936002)(83380400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nMFO1XLKX3DegtN2h1EvbxL/PmPlbXVqt4Jn6SYVrdkwu1r9N89Gu41VNNJ9?=
 =?us-ascii?Q?4eCy/t/x/wrKAh87ARZqOTZ/sALkn5deKIB86jPiRZcWPTV0/Sjeky4yxG6+?=
 =?us-ascii?Q?l/DEyYsJ4eLPDngB2nwxkjuUazd6eMCqlfCY3QQoRhpkpmFvzxgxs/mPstWo?=
 =?us-ascii?Q?g0xk5JPzY4WS5F6CEr0tQmQ0XHmnZ6nNLxWOsEoTTqOlfIMJERVROHxx3A/7?=
 =?us-ascii?Q?UQyrbqK9rr6Do3CXYnI1zW+GuEy9y40HzWzXjuRg7p8MKm7fwGJXsUCOICzT?=
 =?us-ascii?Q?2Xol5EVW56w0Kayp882gFlVSCY47cOcJ3WzG1BxcpomQpbsZUEaOMkD92yQG?=
 =?us-ascii?Q?IR9lW+MzBRldcOQ+Ax7bfH2Xp8/yd8ZTqt0OzowW2K9zYGJwys7qLaE5COYE?=
 =?us-ascii?Q?xMpBRgjFQvUjjCIAi4fgHKtEXnI7ehrIaB/gsGMqn9IaX/3XjQf34pIW5lyz?=
 =?us-ascii?Q?usvirWgo0N+rN3Rhg3e4vbsx96MPd/VZHqm9VpVyotW/asP5IOusrYpVpi/D?=
 =?us-ascii?Q?GIeabE2VyajfeK25mquDgjifiMcmW9/QP96DjSLpkkLB+1cCWHypYYGH+6hE?=
 =?us-ascii?Q?0f6SqGX5doWrl9OUZwb7+xPqE9ljs7idjcuTFUM3nsRaLUzBCX3ko7AUq2A7?=
 =?us-ascii?Q?X64CqQtArNP65YKxlurJEZgRY8GnNoSi/UC6l+DbTIBnqvfWhyDuZ4NEWiJu?=
 =?us-ascii?Q?K8ZDoNjLdAvdSiadNLSZL7o/Qvlkser0FWZuqoJ7bgrJGoBHoQOEMAeq60ap?=
 =?us-ascii?Q?qnP0GwL2wbmRZ5yX1aJ2isj3+fFyqpgyoeV3GQYKSakz0ec0XgSoqTUMWgPC?=
 =?us-ascii?Q?vqJkYQSMH+9MNenIuA338E4+pLNASzoo4JPDd6kBcooc7qTnAP+MlFRDEjPE?=
 =?us-ascii?Q?CQyknelRwCZI0KBTRGcdiPK+3aVbXpOGjiv5CRRT0P1f6Cwn/tBIyOQo8QVQ?=
 =?us-ascii?Q?j5JdfYrQWSmTf7xN1GZ8dddOUHmCL5Q6OjwlODoq6weXa1hg5kZaatxAIgBf?=
 =?us-ascii?Q?fyu8C58Ylg0qh4CwnX2lgJVpZU81LFSNmpjc4EstERFMzklNF9ii3n49icYM?=
 =?us-ascii?Q?cALioFYEmS1xTAzrLpt258s0q9nRmJZM5tHboN9lLqAxGKX9nlN1RjlSZAyj?=
 =?us-ascii?Q?FhKS4corBaeo9zK4bcmE0oagoDuB+p3z6VYRKJWzhnJSIosHwmS6pJMOOBrl?=
 =?us-ascii?Q?Pn0wvKKeP1ivyvLnUxZrcNWpE2bZcwQBADFTCiiVonQrFBwBqm4JkH8DFaWQ?=
 =?us-ascii?Q?LaULoWKss4s7TniVRcQWeoq534hdD00TC/1dRVF59AzcXBTE5sQzp/D5wTGV?=
 =?us-ascii?Q?LIUTQI0x77cRzbem7hyYjtkieiUh1XsOsUJubds1Oc8oe964sm//n5CE3Wos?=
 =?us-ascii?Q?NYsyj1ZK+Y5cQSIhabFZelmC1tDlWT4YbDzN1rniXD6a7To98Cr5SnKrHQJR?=
 =?us-ascii?Q?tVrZ2vXEnhd/73mhETvohGqPhNeJI1nd5DTJ86708z571Q9hbuXBUfPz+nhr?=
 =?us-ascii?Q?mmmEGPAUr3QabdaDB7cFNkDDC3z+QmByOorkNoZmBChUyWNyqvymETMr6NDs?=
 =?us-ascii?Q?Ws+YXRTgQGp6ewLd4KU0jj8XUcCaQNTtCw1odcbzFCLWo1R5WgdgC4u2vwEN?=
 =?us-ascii?Q?XSHO0xcu/7LDyQhg1awQv12X0FOpNPKOm0hz7ZJoHrRjNrE4PQqkpoCXt1rx?=
 =?us-ascii?Q?6bfN6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e65024-1575-4c7c-9b0a-08d9dceebeac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 15:00:20.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdDwwyKWKhEE0819IXUdEFrvdnvu0OR6MC5kMss+AnhOLMMMewqlpSsUIjwjMWcCxk+jQjghFMryWOa8BwA1slEHFKfV4/mI/JwlAUzEw9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1607
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baoquan He <bhe@redhat.com> Sent: Thursday, January 20, 2022 6:31 PM
>=20
> On 01/20/22 at 06:36pm, Guilherme G. Piccoli wrote:
> > Hi Baoquan, some comments inline below:
> >
> >
> > On 20/01/2022 05:51, Baoquan He wrote:
> > > [...]
> > >> From my POV, the function of panic notifiers is not well defined. Th=
ey
> > >> do various things, for example:
> > >> [...]
> > >> The do more that just providing information. Some are risky. It is n=
ot
> > >> easy to disable a particular one.
> > >
> > > Yes, agree. Not all of them just provide information.
> > >
> > > Now panic_notifier_filter Guilherme added can help to disable some of
> > > them.
> >
> > So, just for completeness, worth to mention Petr had some interesting
> > suggestions in the other thread (about the filter) and we may end-up no=
t
> > having this implemented - in other words, maybe a refactor of that
> > mechanism is going to be proposed.
>=20
> OK, saw that. We can continue discuss that there.
>=20
> >
> >
> > > [...]
> > >>
> > >>   + Guilherme uses crash dump only to dump the kernel log. It might
> > >>     be more reliable than kmsg_dump. In this case, panic_print_sys_i=
nfo()
> > >>     is the only way to get the extra information.
> > >
> > > Hmm, I haven't made clear what Guilherme really wants in his recent
> > > post. In this patch he wants to get panic print info into pstore. He
> > > also want to dump the kernel log poked by panic_print in kdump kernel=
.
> > > And it's very weird people try to collect kernel log via crash dump
> > > mechnism, that is obviously using a sledgehammer to crack a nut.
> > > Sometime, we should not add or change code to a too specific corner
> > > case.
> >
> > OK, I'll try to be really clear, hopefully I can explain the use case i=
n
> > better and simpler words. First of all, I wouldn't call it a corner cas=
e
> > - it's just a valid use case that, in my opinion, should be allowed. Wh=
y
> > not, right? Kernel shouldn't push policy on users, we should instead le=
t
> > the users decide how to use the tools/options.
>=20
> Agree, sorry about my wrong expression.
>=20
> >
> > So imagine you cannot collect a vmcore, due to the lack of storage
> > space. Yet, you want the most information as possible to investigate th=
e
> > cause of a panic. The kernel flag "panic_print" is the perfect fit, we
> > can dump backtraces, task list, memory info...right on a panic event.
> >
> > But then, how to save this panic log with lots of information after a
> > reboot? There are 2 ways in my understanding:
> >
> > (a) pstore/kmsg_dump()
> > (b) kdump
> >
> > The option (a) is easily the best - we don't need to reserve lots of
> > memory, then boot another kernel, etc. This patch (being hereby
> > discussed) aims to enable the "panic_print" output for this case!
> > But...there are cases in which option (a) cannot work. We need a backen=
d
> > of persistent storage, either a block device or, more common, RAM memor=
y
> > that is persistent across a reboot. What if it's not available?
> >
> > Then, we fallback to option (b) - kind of a sledgehammer, in your words=
 heh
> > It's not ideal, but might be a last resort for users wanting to collect
> > the most information they can without saving a full vmcore. And for
> > that, we need to be able to invoke "panic_print" function before the
> > __crash_kexec() call. Continue below...
>=20
> OK, pstore via kmsg_dump is first option, then fallback to kdump.
> This is what I suggested at below. This is what panic notifier has done
> at below. I think both of them are similar, thus should take the same
> way to handle.
>=20
>  void panic()
>  {
>          if (!_crash_kexec_post_notifiers && !panic_print) {
>                  __crash_kexec(NULL);
>                  smp_send_stop();
>          } else {
>                  crash_smp_send_stop();
>          }
>=20
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  	panic_print_sys_info(false);
>  	kmsg_dump(KMSG_DUMP_PANIC);
>  	if (_crash_kexec_post_notifiers || panic_print)
>                  __crash_kexec(NULL);
>  	...
>  	debug_locks_off();
>          console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>=20
>          panic_print_sys_info(true);
>  	......
>  }
> > >
> >
> > So, your idea is good and it mostly works, except it *requires* users t=
o
> > make use of "crash_kexec_post_notifiers" in order to use "panic_print"
> > in the case (b) above discussed.
>=20
> I don't get. Why it has to *require* users to make use of
> "crash_kexec_post_notifiers" in order to use "panic_print"?
> To enable panic notifiers and panic_print, we need add below parameter
> to kernel cmdline separately.
>=20
> 	crash_kexec_post_notifiers=3D1
>         panic_print=3D0x7f
>=20
> With above code, we have:
> 1) None specified in cmdline, only kdump enabled.
>    Crash dump will work to get vmcore.
> 2) crash_kexec_post_notifiers=3D1 , kdump enabled
>    panic_notifers are executed, then crash dump
> 3) panic_print=3D0x7f, kdump enabled,
>    Panic_print get system info printed, then crash dump
> 4) crash_kexec_post_notifiers=3D1 panic_print=3D0x7f, kdump enabled
>    panic_notifers are executed firstly, then panic_print, at last crash d=
ump
>=20
> Here I don't list the no kdump enabled case. Please help point out if I
> misunderstood anything.
> >
> > Do you think it should be necessary?
> > How about if we allow users to just "panic_print" with or without the
> > "crash_kexec_post_notifiers", then we pursue Petr suggestion of
> > refactoring the panic notifiers? So, after this future refactor, we
> > might have a much clear code.
>=20
> I haven't read Petr's reply in another panic notifier filter thread. For
> panic notifier, it's only enforced to use on HyperV platform, excepto of
> that, users need to explicitly add "crash_kexec_post_notifiers=3D1" to en=
able
> it. And we got bug report on the HyperV issue. In our internal discussion=
,
> we strongly suggest HyperV dev to change the default enablement, instead
> leave it to user to decide.
>

Regarding Hyper-V:   Invoking the Hyper-V notifier prior to running the
kdump kernel is necessary for correctness.  During initial boot of the
main kernel, the Hyper-V and VMbus code in Linux sets up several guest
physical memory pages that are shared with Hyper-V, and that Hyper-V
may write to.   A VMbus connection is also established. Before kexec'ing
into the kdump kernel, the sharing of these pages must be rescinded
and the VMbus connection must be terminated.   If this isn't done, the
kdump kernel will see strange memory overwrites if these shared guest
physical memory pages get used for something else.

I hope we've found and fixed all the problems where the Hyper-V
notifier could get hung.  Unfortunately, the Hyper-V interfaces were
designed long ago without the Linux kexec scenario in mind, and they
don't provide a simple way to reset everything except by doing a
reboot that goes back through the virtual BIOS/UEFI.  So the Hyper-V
notifier code is more complicated than would be desirable, and in
particular, terminating the VMbus connection is tricky.

This has been an evolving area of understanding.  It's only been the last
couple of years that we've fully understood the implications of these
shared memory pages on the kexec/kdump scenario and what it takes
to reset everything so the kexec'ed kernel will work.

Michael

>=20
> > > Please, don't name 'after_kmsg_dumpers', that's too nerd, bro :-)
> > > static void panic_print_sys_info(bool console_flush)
> >
> > Sure, I'll rename "after_kmsg_dumpers" to "console_flush" in next
> > iteration, although my nerd side won't be so happy ;-)
>=20
> No offence at all. My wife always call me nerd. Sorry about that.

