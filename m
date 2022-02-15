Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0299E4B6982
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiBOKjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:39:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiBOKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:39:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5D108AE47
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644921547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qy//CAq6cBrf0bkZBfqt/EkJYJk3fPH+mpMekwW7t0=;
        b=RPqhvEOqj1pptFmR4MNm47KgJ033xwXYQwNA+XZP+f+KTRih0tuzdsnjpPyTtIT2ixoSZL
        LM5ajT8pTPUOwRtKfTLf3+8q0ihOLuQE/Tj/2dijRe1xqRNnGDmXBE1Oe0c+a+5yxNn2zm
        tbhHidaLWj3DnxXoDUdg1gWKeeLOUXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-SE9r2WB4M2mNoxQnqUYwiA-1; Tue, 15 Feb 2022 05:39:04 -0500
X-MC-Unique: SE9r2WB4M2mNoxQnqUYwiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AE38180FCAC;
        Tue, 15 Feb 2022 10:39:03 +0000 (UTC)
Received: from rhtmp (unknown [10.39.192.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E7B27039E;
        Tue, 15 Feb 2022 10:38:56 +0000 (UTC)
Date:   Tue, 15 Feb 2022 11:38:54 +0100
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
Message-ID: <20220215113854.7c7e3686@rhtmp>
In-Reply-To: <e58be621-be9f-ea10-502c-82b95bee63e4@suse.cz>
References: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
        <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
        <f28c65f0-9bbb-6bf8-a223-0e18b861c805@loongson.cn>
        <ba065272-78bd-65d0-1e76-08455519b6db@suse.cz>
        <20220131113351.49a47caf@rhtmp>
        <e58be621-be9f-ea10-502c-82b95bee63e4@suse.cz>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Fri, 4 Feb 2022 06:34:19 +0100
Petr Tesa=C5=99=C3=ADk <ptesarik@suse.cz> wrote:

> Hi Philipp,
>=20
> Dne 31. 01. 22 v 11:33 Philipp Rudo napsal(a):
> > Hi,
> >=20
> > On Fri, 28 Jan 2022 11:31:49 +0100
> > Petr Tesa=C5=99=C3=ADk <ptesarik@suse.cz> wrote:
> >  =20
> >> Hi Tiezhu Yang,
> >>
> >> On Jan 28, 2022 at 02:20 Tiezhu Yang wrote: =20
> >>> [...]
> >>> Hi Petr,
> >>>
> >>> Thank you for your reply.
> >>>
> >>> This is a RFC patch, the initial aim of this patch is to discuss what=
 is
> >>> the proper way to support crashkernel=3Dauto. =20
> >>
> >> Well, the point I'm trying to make is that crashkernel=3Dauto cannot be
> >> implemented. Your code would have to know what happens in the future,
> >> and AFAIK time travel has not been discovered yet. ;-)
> >>
> >> A better approach is to make a very large allocation initially, e.g.
> >> half of available RAM. The remaining RAM should still be big enough to
> >> start booting the system. Later, when a kdump user-space service knows
> >> what it wants to load, it can shrink the reservation by writing a lower
> >> value into /sys/kernel/kexec_crash_size. =20
> >=20
> > Even this approach doesn't work in every situation. For example it
> > requires that the system has at least twice the RAM it requires to
> > safely boot. That's not always given for e.g minimalistic VMs or
> > embedded systems. =20
>=20
> If you reserve more RAM for the panic kernel than for running your=20
> actual workload, then you definitely have very special needs, and you=20
> should not expect that everything works out of the box.

That was basically the point I was trying to make. There is always a
scenario with special needs so that is is basically impossible to find
that one solution that works for everybody.

> > Furthermore the memory requirement can also change during runtime due
> > to, e.g. workload spikes, device hot plug, moving the dump target from
> > an un-encrypted to an encrypted disk, etc.. So even when your user-space
> > program can exactly calculate the memory requirement at the moment
> > it loads kdump it might be too little at the moment the system panics.
> > In order for it to work the user-space would constantly need to monitor
> > how much memory is needed and adjust the requirement. But that would
> > also require to increase the reservation during runtime which would be
> > extremely expensive (if possible at all).
> >=20
> > All in all I support Petr that time travel is the only proper solution
> > for implementing crashkernel=3Dauto. But once we have time travel I
> > would prefer to use the gained knowledge to fix the bug that triggered
> > the panic rather than calculating the memory requirement for kdump. =20
>=20
> Yeah, long live patching! :-)
>=20
> >> The alternative approach does not need any changes to the kernel, exce=
pt
> >> maybe adding something like "crashkernel=3Dmax". =20
> >=20
> > A slightly different approach is for the user-space tool to simply set
> > the crashkernel=3D parameter on the kernel commandline for the next boo=
t.
> > This also works for memory restrained systems. Needs a reboot though...=
 =20
>=20
> The downside is that if you remove some memory while your system is off,=
=20
> then a reservation calculate for the previous RAM size may no longer be=20
> possible on the next boot, and the kernel will boot up without any=20
> reservation. That's where "crashkernel=3Dmax" would come in handy. Let me=
=20
> send a patch and see the discussion.

True, in that situation our approach will fail. I'm looking forward to
see your patch.

Thanks
Philipp

> >>> A moment ago, I find the following patch, it is more flexible, but it=
 is
> >>> not merged into the upstream kernel now.
> >>>
> >>> kernel/crash_core: Add crashkernel=3Dauto for vmcore creation
> >>>
> >>> https://lore.kernel.org/lkml/20210223174153.72802-1-saeed.mirzamohamm=
adi@oracle.com/ =20
> >=20
> > The patch was ultimately rejected by Linus
> >=20
> > https://lore.kernel.org/linux-mm/20210507010432.IN24PudKT%25akpm@linux-=
foundation.org/
> >=20
> > Thanks
> > Philipp
> >  =20
> >>>     =20
> >>>>    =20
> >>>>> [...]
> >>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >>>>> index 256cf6d..32c51e2 100644
> >>>>> --- a/kernel/crash_core.c
> >>>>> +++ b/kernel/crash_core.c
> >>>>> @@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char
> >>>>> *cmdline,
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (suffix)
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return pars=
e_crashkernel_suffix(ck_cmdline, crash_size,
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suffix);
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0 if (strncmp(ck_cmdline, "auto", 4) =3D=3D 0) {
> >>>>> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ck_cmdline =3D "1G-4G:1=
60M,4G-64G:192M,64G-1T:256M,1T-:512M";
> >>>>> +#elif defined(CONFIG_ARM64)
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ck_cmdline =3D "2G-:448=
M";
> >>>>> +#elif defined(CONFIG_PPC64)
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *fadump_cmdline;
> >>>>> +
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fadump_cmdline =3D get_=
last_crashkernel(cmdline, "fadump=3D",
> >>>>> NULL);
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fadump_cmdline =3D fadu=
mp_cmdline ?
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 fadump_cmdline + strlen("fadump=3D") : NULL;
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fadump_cmdline || =
(strncmp(fadump_cmdline, "off", 3) =3D=3D
> >>>>> 0))
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ck_cmdline =3D
> >>>>> "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ck_cmdline =3D
> >>>>> "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4=
T-8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G";
> >>>>>
> >>>>>
> >>>>> +#endif
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_info("Using crashker=
nel=3Dauto, the size chosen is a best
> >>>>> effort estimation.\n");
> >>>>> +=C2=A0=C2=A0=C2=A0 }
> >>>>> + =20
> >>>>
> >>>> How did you even arrive at the above numbers? =20
> >>>
> >>> Memory requirements for kdump:
> >>>
> >>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linu=
x/8/html/managing_monitoring_and_updating_the_kernel/supported-kdump-config=
urations-and-targets_managing-monitoring-and-updating-the-kernel#memory-req=
uirements-for-kdump_supported-kdump-configurations-and-targets
> >>>
> >>>
> >>> I've done some research on =20
> >>>> this topic recently (ie. during the last 7 years or so). My x86_64
> >>>> system with 8G RAM running openSUSE Leap 15.3 seems needs 188M for
> >>>> saving to the local disk, and 203M to save over the network (using
> >>>> SFTP). My PPC64 LPAR with 16G RAM running latest Beta of SLES 15 SP4
> >>>> needs 587M, i.e. with the above numbers it may run out of memory whi=
le
> >>>> saving the dump.
> >>>>
> >>>> Since this is not the first time, I'm trying to explain things, I've
> >>>> written a blog post now:
> >>>>
> >>>> https://sigillatum.tesarici.cz/2022-01-27-whats-wrong-with-crashkern=
el-auto.html
> >>>>
> >>>>    =20
> >>>
> >>> Thank you, this is useful.
> >>>
> >>> Thanks,
> >>> Tiezhu
> >>>     =20
> >>>>
> >>>> HTH
> >>>> Petr Tesarik =20
> >>>
> >>>
> >>> _______________________________________________
> >>> kexec mailing list
> >>> kexec@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/kexec =20
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec =20
> >=20
> >=20
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec =20
>=20

