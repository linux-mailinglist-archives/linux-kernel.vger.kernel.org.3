Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA42C490A22
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiAQOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:14:50 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54380 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237674AbiAQOOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:14:37 -0500
Received: from machine.localnet (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2DFD920B9132;
        Mon, 17 Jan 2022 06:14:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DFD920B9132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642428877;
        bh=Emgmu+8u0DDH5mFqspHHwYip5IpMYUB4sTtK8ZbStjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LULG2NOFbk/IITyOKLBCkOZodQ293b5Qv7mfEtjKRJnLFstxRM/Gsrojjb0t+rZ9B
         758KURSJMiJUDKDo8gK0/YuHz6ek/SOotQbX+HDYoy+f/pJTGmy81zZC5z9wOzyB+z
         +aYvXF85INpBYaYKr/y56/J2V6lxnj4792NlFREQ=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] capability: Add cap_strings.
Date:   Mon, 17 Jan 2022 15:14:34 +0100
Message-ID: <2966845.Fhcn9zfbF5@machine>
In-Reply-To: <20220114003910.GA19319@mail.hallyn.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com> <18436829.ogB85pbuhf@machine> <20220114003910.GA19319@mail.hallyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


Le vendredi 14 janvier 2022, 01:39:10 CET Serge E. Hallyn a =E9crit :
> On Tue, Dec 28, 2021 at 02:27:56PM +0100, Francis Laniel wrote:
> > Hi.
> >=20
> > Le lundi 27 d=E9cembre 2021, 23:26:29 CET Casey Schaufler a =E9crit :
> > > On 12/27/2021 12:54 PM, Francis Laniel wrote:
> > > > This array contains the capability names for the given capabilitiy.
> > > > For example, index CAP_BPF contains "CAP_BPF".
> > > >=20
> > > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > > ---
> > > >=20
> > > >   include/uapi/linux/capability.h |  1 +
> > > >   kernel/capability.c             | 45
> > > >   +++++++++++++++++++++++++++++++++
> > > >   2 files changed, 46 insertions(+)
> > > >=20
> > > > diff --git a/include/uapi/linux/capability.h
> > > > b/include/uapi/linux/capability.h index 463d1ba2232a..9646654d5111
> > > > 100644
> > > > --- a/include/uapi/linux/capability.h
> > > > +++ b/include/uapi/linux/capability.h
> > > > @@ -428,5 +428,6 @@ struct vfs_ns_cap_data {
> > > >=20
> > > >   #define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 =3D=3D bi=
ts in
> > > >   __u32
> > > >   */
> > > >   #define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed
> > > >   __u32
> > > >   */
> > > >=20
> > > > +extern const char *cap_strings[];
> > > >=20
> > > >   #endif /* _UAPI_LINUX_CAPABILITY_H */
> > > >=20
> > > > diff --git a/kernel/capability.c b/kernel/capability.c
> > > > index 46a361dde042..5a2e71dcd87b 100644
> > > > --- a/kernel/capability.c
> > > > +++ b/kernel/capability.c
> > > > @@ -15,6 +15,7 @@
> > > >=20
> > > >   #include <linux/mm.h>
> > > >   #include <linux/export.h>
> > > >   #include <linux/security.h>
> > > >=20
> > > > +#include <linux/stringify.h>
> > > >=20
> > > >   #include <linux/syscalls.h>
> > > >   #include <linux/pid_namespace.h>
> > > >   #include <linux/user_namespace.h>
> > > >=20
> > > > @@ -27,6 +28,50 @@
> > > >=20
> > > >   const kernel_cap_t __cap_empty_set =3D CAP_EMPTY_SET;
> > > >   EXPORT_SYMBOL(__cap_empty_set);
> > > >=20
> > > > +const char *cap_strings[] =3D {
> > > > +	[CAP_CHOWN] =3D __stringify_1(CAP_CHOWN),
> > >=20
> > > I may just be old and slow, but why is this better than
> > >=20
> > > 	[CAP_CHOWN] =3D "CAP_CHOWN",
> >=20
> > Good catch, thank you for it, I just replaced the __stringify_1() by
> > quotes. I thought of using __stringify_() because at first I thought of
> > adding a new macro which would both define a new capability as well as
> > adding to this array.
> I think you are saying you have a new version of the patch where you do
> what Casey suggests, but I don't see it.  Have you sent an updated patch,
> or am I misunderstanding?

Sorry, I forgot to send it as we were thinking on the right place to put th=
e=20
sysfs with Casey.
I normally have send it two minutes ago.

> > But I think it is better to with this simple way rather than doing
> > complicated stuff.
> >=20
> > > > +	[CAP_DAC_OVERRIDE] =3D __stringify_1(CAP_DAC_OVERRIDE),
> > > > +	[CAP_DAC_READ_SEARCH] =3D __stringify_1(CAP_DAC_READ_SEARCH),
> > > > +	[CAP_FOWNER] =3D __stringify_1(CAP_FOWNER),
> > > > +	[CAP_FSETID] =3D __stringify_1(CAP_FSETID),
> > > > +	[CAP_KILL] =3D __stringify_1(CAP_KILL),
> > > > +	[CAP_SETGID] =3D __stringify_1(CAP_SETGID),
> > > > +	[CAP_SETUID] =3D __stringify_1(CAP_SETUID),
> > > > +	[CAP_SETPCAP] =3D __stringify_1(CAP_SETPCAP),
> > > > +	[CAP_LINUX_IMMUTABLE] =3D __stringify_1(CAP_LINUX_IMMUTABLE),
> > > > +	[CAP_NET_BIND_SERVICE] =3D __stringify_1(CAP_NET_BIND_SERVICE),
> > > > +	[CAP_NET_BROADCAST] =3D __stringify_1(CAP_NET_BROADCAST),
> > > > +	[CAP_NET_ADMIN] =3D __stringify_1(CAP_NET_ADMIN),
> > > > +	[CAP_NET_RAW] =3D __stringify_1(CAP_NET_RAW),
> > > > +	[CAP_IPC_LOCK] =3D __stringify_1(CAP_IPC_LOCK),
> > > > +	[CAP_IPC_OWNER] =3D __stringify_1(CAP_IPC_OWNER),
> > > > +	[CAP_SYS_MODULE] =3D __stringify_1(CAP_SYS_MODULE),
> > > > +	[CAP_SYS_RAWIO] =3D __stringify_1(CAP_SYS_RAWIO),
> > > > +	[CAP_SYS_CHROOT] =3D __stringify_1(CAP_SYS_CHROOT),
> > > > +	[CAP_SYS_PTRACE] =3D __stringify_1(CAP_SYS_PTRACE),
> > > > +	[CAP_SYS_PACCT] =3D __stringify_1(CAP_SYS_PACCT),
> > > > +	[CAP_SYS_ADMIN] =3D __stringify_1(CAP_SYS_ADMIN),
> > > > +	[CAP_SYS_BOOT] =3D __stringify_1(CAP_SYS_BOOT),
> > > > +	[CAP_SYS_NICE] =3D __stringify_1(CAP_SYS_NICE),
> > > > +	[CAP_SYS_RESOURCE] =3D __stringify_1(CAP_SYS_RESOURCE),
> > > > +	[CAP_SYS_TIME] =3D __stringify_1(CAP_SYS_TIME),
> > > > +	[CAP_SYS_TTY_CONFIG] =3D __stringify_1(CAP_SYS_TTY_CONFIG),
> > > > +	[CAP_MKNOD] =3D __stringify_1(CAP_MKNOD),
> > > > +	[CAP_LEASE] =3D __stringify_1(CAP_LEASE),
> > > > +	[CAP_AUDIT_WRITE] =3D __stringify_1(CAP_AUDIT_WRITE),
> > > > +	[CAP_AUDIT_CONTROL] =3D __stringify_1(CAP_AUDIT_CONTROL),
> > > > +	[CAP_SETFCAP] =3D __stringify_1(CAP_SETFCAP),
> > > > +	[CAP_MAC_OVERRIDE] =3D __stringify_1(CAP_MAC_OVERRIDE),
> > > > +	[CAP_MAC_ADMIN] =3D __stringify_1(CAP_MAC_ADMIN),
> > > > +	[CAP_SYSLOG] =3D __stringify_1(CAP_SYSLOG),
> > > > +	[CAP_WAKE_ALARM] =3D __stringify_1(CAP_WAKE_ALARM),
> > > > +	[CAP_BLOCK_SUSPEND] =3D __stringify_1(CAP_BLOCK_SUSPEND),
> > > > +	[CAP_AUDIT_READ] =3D __stringify_1(CAP_AUDIT_READ),
> > > > +	[CAP_PERFMON] =3D __stringify_1(CAP_PERFMON),
> > > > +	[CAP_BPF] =3D __stringify_1(CAP_BPF),
> > > > +	[CAP_CHECKPOINT_RESTORE] =3D=20
__stringify_1(CAP_CHECKPOINT_RESTORE),
> > > > +};
> > > > +
> > > >=20
> > > >   int file_caps_enabled =3D 1;
> > > >  =20
> > > >   static int __init file_caps_disable(char *str)




