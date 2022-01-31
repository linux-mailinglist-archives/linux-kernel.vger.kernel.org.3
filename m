Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A93E4A404A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358218AbiAaKeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:34:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348231AbiAaKeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643625243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYgvdWZauKdwx56tpJYbjCs99NNdbstoUesyXGNGGmM=;
        b=gpMYmeacH5nGVNWYE+RBqXfh8a2gTV3hcO8F1S/6LhzDyk2rrRZFtlxGxTwAgvabgsOwKJ
        VzWG3Rtjtlw1dilJqvT5W4X4NMwiLkRkhd0kYKNLAuR5BDT6OHVtsGOa693vAyXB/zK4SP
        I9Ydb7A5TeWwP081FPfjxSm/SiyXe1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-KExOlbYjNX2R4FpQXMMHAg-1; Mon, 31 Jan 2022 05:33:58 -0500
X-MC-Unique: KExOlbYjNX2R4FpQXMMHAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D93BA1B2C983;
        Mon, 31 Jan 2022 10:33:55 +0000 (UTC)
Received: from rhtmp (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0C3E67C99;
        Mon, 31 Jan 2022 10:33:52 +0000 (UTC)
Date:   Mon, 31 Jan 2022 11:33:51 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Petr =?UTF-8?B?VGVzYcWZw61r?= <ptesarik@suse.cz>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kdump: Add support for crashkernel=auto
Message-ID: <20220131113351.49a47caf@rhtmp>
In-Reply-To: <ba065272-78bd-65d0-1e76-08455519b6db@suse.cz>
References: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
        <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
        <f28c65f0-9bbb-6bf8-a223-0e18b861c805@loongson.cn>
        <ba065272-78bd-65d0-1e76-08455519b6db@suse.cz>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Jan 2022 11:31:49 +0100
Petr Tesa=C5=99=C3=ADk <ptesarik@suse.cz> wrote:

> Hi Tiezhu Yang,
>=20
> On Jan 28, 2022 at 02:20 Tiezhu Yang wrote:
> >[...]
> > Hi Petr,
> >=20
> > Thank you for your reply.
> >=20
> > This is a RFC patch, the initial aim of this patch is to discuss what i=
s=20
> > the proper way to support crashkernel=3Dauto. =20
>=20
> Well, the point I'm trying to make is that crashkernel=3Dauto cannot be=20
> implemented. Your code would have to know what happens in the future,=20
> and AFAIK time travel has not been discovered yet. ;-)
>
> A better approach is to make a very large allocation initially, e.g.=20
> half of available RAM. The remaining RAM should still be big enough to=20
> start booting the system. Later, when a kdump user-space service knows=20
> what it wants to load, it can shrink the reservation by writing a lower=20
> value into /sys/kernel/kexec_crash_size.

Even this approach doesn't work in every situation. For example it
requires that the system has at least twice the RAM it requires to
safely boot. That's not always given for e.g minimalistic VMs or
embedded systems.
Furthermore the memory requirement can also change during runtime due
to, e.g. workload spikes, device hot plug, moving the dump target from
an un-encrypted to an encrypted disk, etc.. So even when your user-space
program can exactly calculate the memory requirement at the moment
it loads kdump it might be too little at the moment the system panics.
In order for it to work the user-space would constantly need to monitor
how much memory is needed and adjust the requirement. But that would
also require to increase the reservation during runtime which would be
extremely expensive (if possible at all).

All in all I support Petr that time travel is the only proper solution
for implementing crashkernel=3Dauto. But once we have time travel I
would prefer to use the gained knowledge to fix the bug that triggered
the panic rather than calculating the memory requirement for kdump.
=20
> The alternative approach does not need any changes to the kernel, except=
=20
> maybe adding something like "crashkernel=3Dmax".

A slightly different approach is for the user-space tool to simply set
the crashkernel=3D parameter on the kernel commandline for the next boot.
This also works for memory restrained systems. Needs a reboot though...

> > A moment ago, I find the following patch, it is more flexible, but it i=
s=20
> > not merged into the upstream kernel now.
> >=20
> > kernel/crash_core: Add crashkernel=3Dauto for vmcore creation
> >=20
> > https://lore.kernel.org/lkml/20210223174153.72802-1-saeed.mirzamohammad=
i@oracle.com/=20

The patch was ultimately rejected by Linus

https://lore.kernel.org/linux-mm/20210507010432.IN24PudKT%25akpm@linux-foun=
dation.org/

Thanks
Philipp

> >  =20
> >> =20
> >>> [...]
> >>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >>> index 256cf6d..32c51e2 100644
> >>> --- a/kernel/crash_core.c
> >>> +++ b/kernel/crash_core.c
> >>> @@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char=20
> >>> *cmdline,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (suffix)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return parse_c=
rashkernel_suffix(ck_cmdline, crash_size,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suffix);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 if (strncmp(ck_cmdline, "auto", 4) =3D=3D 0) {
> >>> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ck_cmdline =3D "1G-4G:160=
M,4G-64G:192M,64G-1T:256M,1T-:512M";
> >>> +#elif defined(CONFIG_ARM64)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ck_cmdline =3D "2G-:448M";
> >>> +#elif defined(CONFIG_PPC64)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *fadump_cmdline;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fadump_cmdline =3D get_la=
st_crashkernel(cmdline, "fadump=3D",=20
> >>> NULL);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fadump_cmdline =3D fadump=
_cmdline ?
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 fadump_cmdline + strlen("fadump=3D") : NULL;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fadump_cmdline || (s=
trncmp(fadump_cmdline, "off", 3) =3D=3D=20
> >>> 0))
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
k_cmdline =3D
> >>> "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
k_cmdline =3D
> >>> "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4T-=
8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G";=20
> >>>
> >>>
> >>> +#endif
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("Using crashkerne=
l=3Dauto, the size chosen is a best
> >>> effort estimation.\n");
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> + =20
> >>
> >> How did you even arrive at the above numbers? =20
> >=20
> > Memory requirements for kdump:
> >=20
> > https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/=
8/html/managing_monitoring_and_updating_the_kernel/supported-kdump-configur=
ations-and-targets_managing-monitoring-and-updating-the-kernel#memory-requi=
rements-for-kdump_supported-kdump-configurations-and-targets=20
> >=20
> >=20
> > I've done some research on =20
> >> this topic recently (ie. during the last 7 years or so). My x86_64
> >> system with 8G RAM running openSUSE Leap 15.3 seems needs 188M for
> >> saving to the local disk, and 203M to save over the network (using
> >> SFTP). My PPC64 LPAR with 16G RAM running latest Beta of SLES 15 SP4
> >> needs 587M, i.e. with the above numbers it may run out of memory while
> >> saving the dump.
> >>
> >> Since this is not the first time, I'm trying to explain things, I've
> >> written a blog post now:
> >>
> >> https://sigillatum.tesarici.cz/2022-01-27-whats-wrong-with-crashkernel=
-auto.html=20
> >>
> >> =20
> >=20
> > Thank you, this is useful.
> >=20
> > Thanks,
> > Tiezhu
> >  =20
> >>
> >> HTH
> >> Petr Tesarik =20
> >=20
> >=20
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec =20
>=20
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

