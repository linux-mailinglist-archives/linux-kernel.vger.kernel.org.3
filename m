Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1715348E19E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiANAjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:39:14 -0500
Received: from mail.hallyn.com ([178.63.66.53]:41346 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233782AbiANAjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:39:13 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id EC79C69C; Thu, 13 Jan 2022 18:39:10 -0600 (CST)
Date:   Thu, 13 Jan 2022 18:39:10 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] capability: Add cap_strings.
Message-ID: <20220114003910.GA19319@mail.hallyn.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com>
 <20211227205500.214777-2-flaniel@linux.microsoft.com>
 <289c4134-1ac4-48fc-58ec-cab0bcb63268@schaufler-ca.com>
 <18436829.ogB85pbuhf@machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18436829.ogB85pbuhf@machine>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 02:27:56PM +0100, Francis Laniel wrote:
> Hi.
> 
> 
> Le lundi 27 décembre 2021, 23:26:29 CET Casey Schaufler a écrit :
> > On 12/27/2021 12:54 PM, Francis Laniel wrote:
> > > This array contains the capability names for the given capabilitiy.
> > > For example, index CAP_BPF contains "CAP_BPF".
> > > 
> > > Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> > > ---
> > > 
> > >   include/uapi/linux/capability.h |  1 +
> > >   kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
> > >   2 files changed, 46 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/capability.h
> > > b/include/uapi/linux/capability.h index 463d1ba2232a..9646654d5111 100644
> > > --- a/include/uapi/linux/capability.h
> > > +++ b/include/uapi/linux/capability.h
> > > @@ -428,5 +428,6 @@ struct vfs_ns_cap_data {
> > > 
> > >   #define CAP_TO_INDEX(x)     ((x) >> 5)        /* 1 << 5 == bits in __u32
> > >   */
> > >   #define CAP_TO_MASK(x)      (1 << ((x) & 31)) /* mask for indexed __u32
> > >   */
> > > 
> > > +extern const char *cap_strings[];
> > > 
> > >   #endif /* _UAPI_LINUX_CAPABILITY_H */
> > > 
> > > diff --git a/kernel/capability.c b/kernel/capability.c
> > > index 46a361dde042..5a2e71dcd87b 100644
> > > --- a/kernel/capability.c
> > > +++ b/kernel/capability.c
> > > @@ -15,6 +15,7 @@
> > > 
> > >   #include <linux/mm.h>
> > >   #include <linux/export.h>
> > >   #include <linux/security.h>
> > > 
> > > +#include <linux/stringify.h>
> > > 
> > >   #include <linux/syscalls.h>
> > >   #include <linux/pid_namespace.h>
> > >   #include <linux/user_namespace.h>
> > > 
> > > @@ -27,6 +28,50 @@
> > > 
> > >   const kernel_cap_t __cap_empty_set = CAP_EMPTY_SET;
> > >   EXPORT_SYMBOL(__cap_empty_set);
> > > 
> > > +const char *cap_strings[] = {
> > > +	[CAP_CHOWN] = __stringify_1(CAP_CHOWN),
> > 
> > I may just be old and slow, but why is this better than
> > 
> > 	[CAP_CHOWN] = "CAP_CHOWN",
> 
> Good catch, thank you for it, I just replaced the __stringify_1() by quotes.
> I thought of using __stringify_() because at first I thought of adding a new 
> macro which would both define a new capability as well as adding to this array.

I think you are saying you have a new version of the patch where you do
what Casey suggests, but I don't see it.  Have you sent an updated patch,
or am I misunderstanding?

> But I think it is better to with this simple way rather than doing complicated 
> stuff.
> 
> > > +	[CAP_DAC_OVERRIDE] = __stringify_1(CAP_DAC_OVERRIDE),
> > > +	[CAP_DAC_READ_SEARCH] = __stringify_1(CAP_DAC_READ_SEARCH),
> > > +	[CAP_FOWNER] = __stringify_1(CAP_FOWNER),
> > > +	[CAP_FSETID] = __stringify_1(CAP_FSETID),
> > > +	[CAP_KILL] = __stringify_1(CAP_KILL),
> > > +	[CAP_SETGID] = __stringify_1(CAP_SETGID),
> > > +	[CAP_SETUID] = __stringify_1(CAP_SETUID),
> > > +	[CAP_SETPCAP] = __stringify_1(CAP_SETPCAP),
> > > +	[CAP_LINUX_IMMUTABLE] = __stringify_1(CAP_LINUX_IMMUTABLE),
> > > +	[CAP_NET_BIND_SERVICE] = __stringify_1(CAP_NET_BIND_SERVICE),
> > > +	[CAP_NET_BROADCAST] = __stringify_1(CAP_NET_BROADCAST),
> > > +	[CAP_NET_ADMIN] = __stringify_1(CAP_NET_ADMIN),
> > > +	[CAP_NET_RAW] = __stringify_1(CAP_NET_RAW),
> > > +	[CAP_IPC_LOCK] = __stringify_1(CAP_IPC_LOCK),
> > > +	[CAP_IPC_OWNER] = __stringify_1(CAP_IPC_OWNER),
> > > +	[CAP_SYS_MODULE] = __stringify_1(CAP_SYS_MODULE),
> > > +	[CAP_SYS_RAWIO] = __stringify_1(CAP_SYS_RAWIO),
> > > +	[CAP_SYS_CHROOT] = __stringify_1(CAP_SYS_CHROOT),
> > > +	[CAP_SYS_PTRACE] = __stringify_1(CAP_SYS_PTRACE),
> > > +	[CAP_SYS_PACCT] = __stringify_1(CAP_SYS_PACCT),
> > > +	[CAP_SYS_ADMIN] = __stringify_1(CAP_SYS_ADMIN),
> > > +	[CAP_SYS_BOOT] = __stringify_1(CAP_SYS_BOOT),
> > > +	[CAP_SYS_NICE] = __stringify_1(CAP_SYS_NICE),
> > > +	[CAP_SYS_RESOURCE] = __stringify_1(CAP_SYS_RESOURCE),
> > > +	[CAP_SYS_TIME] = __stringify_1(CAP_SYS_TIME),
> > > +	[CAP_SYS_TTY_CONFIG] = __stringify_1(CAP_SYS_TTY_CONFIG),
> > > +	[CAP_MKNOD] = __stringify_1(CAP_MKNOD),
> > > +	[CAP_LEASE] = __stringify_1(CAP_LEASE),
> > > +	[CAP_AUDIT_WRITE] = __stringify_1(CAP_AUDIT_WRITE),
> > > +	[CAP_AUDIT_CONTROL] = __stringify_1(CAP_AUDIT_CONTROL),
> > > +	[CAP_SETFCAP] = __stringify_1(CAP_SETFCAP),
> > > +	[CAP_MAC_OVERRIDE] = __stringify_1(CAP_MAC_OVERRIDE),
> > > +	[CAP_MAC_ADMIN] = __stringify_1(CAP_MAC_ADMIN),
> > > +	[CAP_SYSLOG] = __stringify_1(CAP_SYSLOG),
> > > +	[CAP_WAKE_ALARM] = __stringify_1(CAP_WAKE_ALARM),
> > > +	[CAP_BLOCK_SUSPEND] = __stringify_1(CAP_BLOCK_SUSPEND),
> > > +	[CAP_AUDIT_READ] = __stringify_1(CAP_AUDIT_READ),
> > > +	[CAP_PERFMON] = __stringify_1(CAP_PERFMON),
> > > +	[CAP_BPF] = __stringify_1(CAP_BPF),
> > > +	[CAP_CHECKPOINT_RESTORE] = __stringify_1(CAP_CHECKPOINT_RESTORE),
> > > +};
> > > +
> > > 
> > >   int file_caps_enabled = 1;
> > >   
> > >   static int __init file_caps_disable(char *str)
> 
> 
> 
