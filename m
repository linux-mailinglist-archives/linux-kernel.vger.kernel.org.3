Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139534909A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiAQNl4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jan 2022 08:41:56 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:59700 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbiAQNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:41:55 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-41QZaZ6cPQuaP92XkRhvvQ-1; Mon, 17 Jan 2022 08:41:52 -0500
X-MC-Unique: 41QZaZ6cPQuaP92XkRhvvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD4B884BA59;
        Mon, 17 Jan 2022 13:41:50 +0000 (UTC)
Received: from sparkplug.usersys.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C1D77C5AB;
        Mon, 17 Jan 2022 13:41:23 +0000 (UTC)
Received: by sparkplug.usersys.redhat.com (Postfix, from userid 1000)
        id 42608160291; Thu, 17 Dec 2020 12:51:14 +0100 (CET)
Date:   Thu, 17 Dec 2020 12:51:14 +0100
From:   Artem Savkov <artem.savkov@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        WANG Chao <chao.wang@ucloud.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] kbuild: add extra-y to targets-for-modules
Message-ID: <20201217115114.GA673511@sparkplug.usersys.redhat.com>
References: <20201103054425.59251-1-chao.wang@ucloud.cn>
 <CAK7LNARnmJRy1NPBDkgNsoe_TqpD=HJhmri4YHjXjscGZ-neWw@mail.gmail.com>
 <20201123150452.GA68187@MacBook-Pro-2>
 <CAK7LNASH7Pj9eUdxF-sp1_Ap+uA9jEtsXa--pUDDw_pNVLtviA@mail.gmail.com>
 <20201208092035.GA96434@MacBook-Pro-2.local>
 <20201208143117.GA3333762@wtfbox.lan>
 <CAK7LNAS=wdCObfX3x8CQmXf8HsrKAjz+v+XVUCxVg63pxy8MXg@mail.gmail.com>
 <f2d1888b-5b8e-a513-61c7-f41fc3f3f7a3@redhat.com>
 <CAK7LNATmfzt0kTF0BWkSRaZV3p01mvN4OSGPZsCp+KHghCWf0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK7LNATmfzt0kTF0BWkSRaZV3p01mvN4OSGPZsCp+KHghCWf0Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=artem.savkov@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 05:26:07PM +0900, Masahiro Yamada wrote:
> On Thu, Dec 17, 2020 at 8:04 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
> >
> > On 12/16/20 1:14 AM, Masahiro Yamada wrote:
> > > On Tue, Dec 8, 2020 at 11:31 PM Artem Savkov <artem.savkov@gmail.com> wrote:
> > >>
> > >> On Tue, Dec 08, 2020 at 05:20:35PM +0800, WANG Chao wrote:
> > >>> Sorry for the late reply.
> > >>>
> > >>> On 11/25/20 at 10:42P, Masahiro Yamada wrote:
> > >>>> On Tue, Nov 24, 2020 at 12:05 AM WANG Chao <chao.wang@ucloud.cn> wrote:
> > >>>>>
> > >>>>> On 11/23/20 at 02:23P, Masahiro Yamada wrote:
> > >>>>>> On Tue, Nov 3, 2020 at 3:23 PM WANG Chao <chao.wang@ucloud.cn> wrote:
> > >>>>>>>
> > >>>>>>> extra-y target doesn't build for 'make M=...' since commit 6212804f2d78
> > >>>>>>> ("kbuild: do not create built-in objects for external module builds").
> > >>>>>>>
> > >>>>>>> This especially breaks kpatch, which is using 'extra-y := kpatch.lds'
> > >>>>>>> and 'make M=...' to build livepatch patch module.
> > >>>>>>>
> > >>>>>>> Add extra-y to targets-for-modules so that such kind of build works
> > >>>>>>> properly.
> > >>>>>>>
> > >>>>>>> Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
> > >>>>>>> ---
> > >>>>>>>   scripts/Makefile.build | 2 +-
> > >>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>>>>
> > >>>>>>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > >>>>>>> index ae647379b579..0113a042d643 100644
> > >>>>>>> --- a/scripts/Makefile.build
> > >>>>>>> +++ b/scripts/Makefile.build
> > >>>>>>> @@ -86,7 +86,7 @@ ifdef need-builtin
> > >>>>>>>   targets-for-builtin += $(obj)/built-in.a
> > >>>>>>>   endif
> > >>>>>>>
> > >>>>>>> -targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> > >>>>>>> +targets-for-modules := $(extra-y) $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> > >>>>>>>
> > >>>>>>>   ifdef need-modorder
> > >>>>>>>   targets-for-modules += $(obj)/modules.order
> > >>>>>>> --
> > >>>>>>> 2.29.1
> > >>>>>>>
> > >>>>>>
> > >>>>>> NACK.
> > >>>>>>
> > >>>>>> Please fix your Makefile.
> > >>>>>>
> > >>>>>> Hint:
> > >>>>>> https://patchwork.kernel.org/project/linux-kbuild/patch/20201123045403.63402-6-masahiroy@kernel.org/
> > >>>>>>
> > >>>>>>
> > >>>>>> Probably what you should use is 'targets'.
> > >>>>>
> > >>>>> I tried with 'targets' and 'always-y'. Both doesn't work for me.
> > >>>>>
> > >>>>> I narraw it down to the following example:
> > >>>>>
> > >>>>> cat > Makefile << _EOF_
> > >>>>> obj-m += foo.o
> > >>>>>
> > >>>>> ldflags-y += -T $(src)/kpatch.lds
> > >>>>> always-y += kpatch.lds
> > >>>>>
> > >>>>> foo-objs += bar.o
> > >>>>>
> > >>>>> all:
> > >>>>>          make -C /lib/modules/$(shell uname -r)/build M=$(PWD)
> > >>>>> clean:
> > >>>>>          make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
> > >>>>> _EOF_
> > >>>>>
> > >>>>> Take a look into scripts/Makefile.build:488:
> > >>>>>
> > >>>>> __build: $(if $(KBUILD_BUILTIN), $(targets-for-builtin)) \
> > >>>>>           $(if $(KBUILD_MODULES), $(targets-for-modules)) \
> > >>>>>           $(subdir-ym) $(always-y)
> > >>>>>          @:
> > >>>>>
> > >>>>> 'always-y' is built after 'targets-for-modules'. This makes
> > >>>>> 'targets-for-modules' fails because kpatch.lds isn't there.
> > >>>>
> > >>>>
> > >>>> Heh, you rely on the targets built from left to right,
> > >>>> and you have never thought Make supports the parallel option -j.
> > >>>
> > >>> You're right. I missed that.
> > >>>
> > >>>>
> > >>>>
> > >>>> You need to specify the dependency if you expect objects
> > >>>> are built in the particular order.
> > >>>>
> > >>>> However, in this case, using ldflags-y looks wrong
> > >>>> in the first place.
> > >>>>
> > >>>> The linker script is used when combining the object
> > >>>> as well as the final link of *.ko
> > >>
> > >> We want linker script to be used on both those steps, otherwise modpost
> > >> fails.
> > >
> > >
> > > In that case, does the following work?
> > > (untested)
> > >
> > >
> > >
> > > diff --git a/kmod/patch/Makefile b/kmod/patch/Makefile
> > > index e017b17..02d4c66 100644
> > > --- a/kmod/patch/Makefile
> > > +++ b/kmod/patch/Makefile
> > > @@ -12,7 +12,9 @@ endif
> > >
> > >   obj-m += $(KPATCH_NAME).o
> > >   ldflags-y += -T $(src)/kpatch.lds
> > > -extra-y := kpatch.lds
> > > +targets += kpatch.lds
> > > +
> > > +$(obj)/$(KPATCH_NAME).o: $(obj)/kpatch.lds
> > >
> > >   $(KPATCH_NAME)-objs += patch-hook.o output.o
> > >
> >
> > Hi Masahiro,
> >
> > Yeah this is more or less what Artem came up with:
> > https://github.com/dynup/kpatch/pull/1149
> >
> > though we hadn't added kpatch.lds to targets.  Is there documentation
> > somewhere on what effect "targets" has for out-of-tree builds?
> >
> > Thanks,
> >
> > -- Joe
> >
> 
> 
> Please try the rebuild without changing any source code.
> 
> If kpatch.lds is needlessly rebuilt, you need to add
> it to 'targets'.
> 
> 
> In linux-next, this is documented.
> 
> Documentation/kbuild/makefile.rst:
> 
>         Any target that utilizes if_changed must be listed in $(targets),
>         otherwise the command line check will fail, and the target will
>         always be built.

Ah yes, it did rebuild every time. Thank you for the pointer.

-- 
 Artem

