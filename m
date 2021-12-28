Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5298D48098F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhL1N2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:28:01 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43272 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhL1N2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:28:00 -0500
Received: from machine.localnet (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0E57D20B7179;
        Tue, 28 Dec 2021 05:27:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E57D20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1640698080;
        bh=v04Y7OlrPi4g7MuLah4XgXmxQpBK1O2dUAp8118zrbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgB2P5NkZFVFMhXhcocuMJrCXtBmp8pqVpwHkqdHlap/udBwSlqkOpg3aK+qbsLvh
         nUKQmquIy91EcgvDMtCbaL+y+qHbXnBJpQ5TWdAUMbh0N7AoTtSx7vbQKcC1eEVuuc
         Vllk9JekgHiIjdpctqaZ/QtCBk2RN911/IlGLi+4=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH v1 1/2] capability: Add cap_strings.
Date:   Tue, 28 Dec 2021 14:27:56 +0100
Message-ID: <18436829.ogB85pbuhf@machine>
In-Reply-To: <289c4134-1ac4-48fc-58ec-cab0bcb63268@schaufler-ca.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com> <20211227205500.214777-2-flaniel@linux.microsoft.com> <289c4134-1ac4-48fc-58ec-cab0bcb63268@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


Le lundi 27 d=E9cembre 2021, 23:26:29 CET Casey Schaufler a =E9crit :
> On 12/27/2021 12:54 PM, Francis Laniel wrote:
> > This array contains the capability names for the given capabilitiy.
> > For example, index CAP_BPF contains "CAP_BPF".
> >=20
> > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > ---
> >=20
> >   include/uapi/linux/capability.h |  1 +
> >   kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
> >   2 files changed, 46 insertions(+)
> >=20
> > diff --git a/include/uapi/linux/capability.h
> > b/include/uapi/linux/capability.h index 463d1ba2232a..9646654d5111 1006=
44
> > --- a/include/uapi/linux/capability.h
> > +++ b/include/uapi/linux/capability.h
> > @@ -428,5 +428,6 @@ struct vfs_ns_cap_data {
> >=20
> >   #define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 =3D=3D bits i=
n __u32
> >   */
> >   #define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed __u=
32
> >   */
> >=20
> > +extern const char *cap_strings[];
> >=20
> >   #endif /* _UAPI_LINUX_CAPABILITY_H */
> >=20
> > diff --git a/kernel/capability.c b/kernel/capability.c
> > index 46a361dde042..5a2e71dcd87b 100644
> > --- a/kernel/capability.c
> > +++ b/kernel/capability.c
> > @@ -15,6 +15,7 @@
> >=20
> >   #include <linux/mm.h>
> >   #include <linux/export.h>
> >   #include <linux/security.h>
> >=20
> > +#include <linux/stringify.h>
> >=20
> >   #include <linux/syscalls.h>
> >   #include <linux/pid_namespace.h>
> >   #include <linux/user_namespace.h>
> >=20
> > @@ -27,6 +28,50 @@
> >=20
> >   const kernel_cap_t __cap_empty_set =3D CAP_EMPTY_SET;
> >   EXPORT_SYMBOL(__cap_empty_set);
> >=20
> > +const char *cap_strings[] =3D {
> > +	[CAP_CHOWN] =3D __stringify_1(CAP_CHOWN),
>=20
> I may just be old and slow, but why is this better than
>=20
> 	[CAP_CHOWN] =3D "CAP_CHOWN",

Good catch, thank you for it, I just replaced the __stringify_1() by quotes.
I thought of using __stringify_() because at first I thought of adding a ne=
w=20
macro which would both define a new capability as well as adding to this ar=
ray.

But I think it is better to with this simple way rather than doing complica=
ted=20
stuff.

> > +	[CAP_DAC_OVERRIDE] =3D __stringify_1(CAP_DAC_OVERRIDE),
> > +	[CAP_DAC_READ_SEARCH] =3D __stringify_1(CAP_DAC_READ_SEARCH),
> > +	[CAP_FOWNER] =3D __stringify_1(CAP_FOWNER),
> > +	[CAP_FSETID] =3D __stringify_1(CAP_FSETID),
> > +	[CAP_KILL] =3D __stringify_1(CAP_KILL),
> > +	[CAP_SETGID] =3D __stringify_1(CAP_SETGID),
> > +	[CAP_SETUID] =3D __stringify_1(CAP_SETUID),
> > +	[CAP_SETPCAP] =3D __stringify_1(CAP_SETPCAP),
> > +	[CAP_LINUX_IMMUTABLE] =3D __stringify_1(CAP_LINUX_IMMUTABLE),
> > +	[CAP_NET_BIND_SERVICE] =3D __stringify_1(CAP_NET_BIND_SERVICE),
> > +	[CAP_NET_BROADCAST] =3D __stringify_1(CAP_NET_BROADCAST),
> > +	[CAP_NET_ADMIN] =3D __stringify_1(CAP_NET_ADMIN),
> > +	[CAP_NET_RAW] =3D __stringify_1(CAP_NET_RAW),
> > +	[CAP_IPC_LOCK] =3D __stringify_1(CAP_IPC_LOCK),
> > +	[CAP_IPC_OWNER] =3D __stringify_1(CAP_IPC_OWNER),
> > +	[CAP_SYS_MODULE] =3D __stringify_1(CAP_SYS_MODULE),
> > +	[CAP_SYS_RAWIO] =3D __stringify_1(CAP_SYS_RAWIO),
> > +	[CAP_SYS_CHROOT] =3D __stringify_1(CAP_SYS_CHROOT),
> > +	[CAP_SYS_PTRACE] =3D __stringify_1(CAP_SYS_PTRACE),
> > +	[CAP_SYS_PACCT] =3D __stringify_1(CAP_SYS_PACCT),
> > +	[CAP_SYS_ADMIN] =3D __stringify_1(CAP_SYS_ADMIN),
> > +	[CAP_SYS_BOOT] =3D __stringify_1(CAP_SYS_BOOT),
> > +	[CAP_SYS_NICE] =3D __stringify_1(CAP_SYS_NICE),
> > +	[CAP_SYS_RESOURCE] =3D __stringify_1(CAP_SYS_RESOURCE),
> > +	[CAP_SYS_TIME] =3D __stringify_1(CAP_SYS_TIME),
> > +	[CAP_SYS_TTY_CONFIG] =3D __stringify_1(CAP_SYS_TTY_CONFIG),
> > +	[CAP_MKNOD] =3D __stringify_1(CAP_MKNOD),
> > +	[CAP_LEASE] =3D __stringify_1(CAP_LEASE),
> > +	[CAP_AUDIT_WRITE] =3D __stringify_1(CAP_AUDIT_WRITE),
> > +	[CAP_AUDIT_CONTROL] =3D __stringify_1(CAP_AUDIT_CONTROL),
> > +	[CAP_SETFCAP] =3D __stringify_1(CAP_SETFCAP),
> > +	[CAP_MAC_OVERRIDE] =3D __stringify_1(CAP_MAC_OVERRIDE),
> > +	[CAP_MAC_ADMIN] =3D __stringify_1(CAP_MAC_ADMIN),
> > +	[CAP_SYSLOG] =3D __stringify_1(CAP_SYSLOG),
> > +	[CAP_WAKE_ALARM] =3D __stringify_1(CAP_WAKE_ALARM),
> > +	[CAP_BLOCK_SUSPEND] =3D __stringify_1(CAP_BLOCK_SUSPEND),
> > +	[CAP_AUDIT_READ] =3D __stringify_1(CAP_AUDIT_READ),
> > +	[CAP_PERFMON] =3D __stringify_1(CAP_PERFMON),
> > +	[CAP_BPF] =3D __stringify_1(CAP_BPF),
> > +	[CAP_CHECKPOINT_RESTORE] =3D __stringify_1(CAP_CHECKPOINT_RESTORE),
> > +};
> > +
> >=20
> >   int file_caps_enabled =3D 1;
> >  =20
> >   static int __init file_caps_disable(char *str)




