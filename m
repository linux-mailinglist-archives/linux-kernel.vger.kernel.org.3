Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18AD4E3622
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiCVBqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiCVBqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:46:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800321D0FE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:45:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w21so7869760pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QIf4Hy84dx7L6X4BNNjvqyd7qQS9lH8gSrCqndVgulg=;
        b=c1eIS7vo7uHJkChkDX9E8UuibyJlcPj9ny6akRAfhecft5A4sQAAvRT6NWdrwAyYS1
         dhaWlwDJJ1cJQ9ZRJHl9EjacUiDF5EHf3CHkOAqMuf0zU49JchE3kIj49+xSipYMpZiR
         HImhOI6SXmdIbf5Eor+xzxKwjeQIQjsWyx8OU4AT+mnrMtNSqd3W8TbEmgIo7Y1ycTlD
         rVRjOa0tpXALsViv1QgoVdGtel5P6mOpCoBMe6neh7LZthVINVhnDwPsTLrKPRqvH1Ba
         hTfFX+3SOKUYmcJb74di86aoahq+yHYqmpEMYLfZnR7rPa1oD6FVpe5eB6p5JxtXIWju
         iwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QIf4Hy84dx7L6X4BNNjvqyd7qQS9lH8gSrCqndVgulg=;
        b=TO4AuhbWFtXrdSbmZVY23o8Pl5luzWZ8cyHsgcrTorP7/vDoVSvr0eVhnUHCDxEGch
         JESDA7FpmoFQfE4+u6XHrK11ibvLXzzjof0uVjmssFmqb3Iol5rdmJHSlHyNk7jPwKAG
         3+9Gw4I3+LsXSJR0EtRx6O6ymsS7389AIERBIsXqd5xLsdxW76DTFPA6PsSFdkcxbTo5
         /qFBBB+ZYoBZxJ7cOuhwld1Zi4NbyEnaYLO0gDNEGnhOZXk6wTHGomCgovyzUu4WC/RU
         KWzMIXZJBB79UrExGfssWEv1ddaM3prx2Uk1LVmZaEeb2SIla4zVkUDXIQ7QEqPsX7Yu
         erfw==
X-Gm-Message-State: AOAM531D8tXXiISzsbf8QXYphoBxZslUmluHdxDLcWQ179YStZayMxWO
        L/wjU45Zrou/vc4/oYlDYUcdXrES2xuxAvMCUUkbOA==
X-Google-Smtp-Source: ABdhPJzVR8hSV4LYUKgF5NX85hxfFWmgAFFzJsBeUycAZHnf4kgiNP9olDkABVHU+za3VoOGb088WtmKxpJ0jIdi06E=
X-Received: by 2002:a63:5c53:0:b0:381:309e:e72c with SMTP id
 n19-20020a635c53000000b00381309ee72cmr20646280pgm.40.1647913516040; Mon, 21
 Mar 2022 18:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220318114133.113627-1-kjain@linux.ibm.com> <20220318114133.113627-2-kjain@linux.ibm.com>
 <CAPcyv4iqpTn89WLOW1XjFXGZEYG_MmPg+VQbcDJ9ygJ4Jaybtw@mail.gmail.com>
In-Reply-To: <CAPcyv4iqpTn89WLOW1XjFXGZEYG_MmPg+VQbcDJ9ygJ4Jaybtw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Mar 2022 18:45:08 -0700
Message-ID: <CAPcyv4iNy-RqKgwc61c+hL9g1zAE_tL5r_mqUQwCiKTzevjoDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/papr_scm: Fix build failure when
 CONFIG_PERF_EVENTS is not set
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Santosh Sivaraj <santosh@fossix.org>, maddy@linux.ibm.com,
        rnsastry@linux.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        atrajeev@linux.vnet.ibm.com, Vaibhav Jain <vaibhav@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 2:39 PM Dan Williams <dan.j.williams@intel.com> wro=
te:
>
> On Fri, Mar 18, 2022 at 4:42 AM Kajol Jain <kjain@linux.ibm.com> wrote:
> >
> > The following build failure occures when CONFIG_PERF_EVENTS is not set
> > as generic pmu functions are not visible in that scenario.
> >
> > arch/powerpc/platforms/pseries/papr_scm.c:372:35: error: =E2=80=98struc=
t perf_event=E2=80=99 has no member named =E2=80=98attr=E2=80=99
> >          p->nvdimm_events_map[event->attr.config],
> >                                    ^~
> > In file included from ./include/linux/list.h:5,
> >                  from ./include/linux/kobject.h:19,
> >                  from ./include/linux/of.h:17,
> >                  from arch/powerpc/platforms/pseries/papr_scm.c:5:
> > arch/powerpc/platforms/pseries/papr_scm.c: In function =E2=80=98papr_sc=
m_pmu_event_init=E2=80=99:
> > arch/powerpc/platforms/pseries/papr_scm.c:389:49: error: =E2=80=98struc=
t perf_event=E2=80=99 has no member named =E2=80=98pmu=E2=80=99
> >   struct nvdimm_pmu *nd_pmu =3D to_nvdimm_pmu(event->pmu);
> >                                                  ^~
> > ./include/linux/container_of.h:18:26: note: in definition of macro =E2=
=80=98container_of=E2=80=99
> >   void *__mptr =3D (void *)(ptr);     \
> >                           ^~~
> > arch/powerpc/platforms/pseries/papr_scm.c:389:30: note: in expansion of=
 macro =E2=80=98to_nvdimm_pmu=E2=80=99
> >   struct nvdimm_pmu *nd_pmu =3D to_nvdimm_pmu(event->pmu);
> >                               ^~~~~~~~~~~~~
> > In file included from ./include/linux/bits.h:22,
> >                  from ./include/linux/bitops.h:6,
> >                  from ./include/linux/of.h:15,
> >                  from arch/powerpc/platforms/pseries/papr_scm.c:5:
> >
> > Fix the build issue by adding check for CONFIG_PERF_EVENTS config optio=
n
> > and disabling the papr_scm perf interface support incase this config
> > is not set
> >
> > Fixes: 4c08d4bbc089 ("powerpc/papr_scm: Add perf interface support") (C=
ommit id
> > based on linux-next tree)
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > ---
> >  arch/powerpc/platforms/pseries/papr_scm.c | 15 +++++++++++++++
>
> This is a bit messier than I would have liked mainly because it dumps
> a bunch of ifdefery into a C file contrary to coding style, "Wherever
> possible, don't use preprocessor conditionals (#if, #ifdef) in .c
> files". I would expect this all to move to an organization like:
>
> arch/powerpc/platforms/pseries/papr_scm/main.c
> arch/powerpc/platforms/pseries/papr_scm/perf.c
>
> ...and a new config symbol like:
>
> config PAPR_SCM_PERF
>        depends on PAPR_SCM && PERF_EVENTS
>        def_bool y
>
> ...with wrappers in header files to make everything compile away
> without any need for main.c to carry an ifdef.
>
> Can you turn a patch like that in the next couple days? Otherwise, I
> think if Linus saw me sending a late breaking compile fix that threw
> coding style out the window he'd have cause to just drop the pull
> request entirely.

Also, please base it on the current state of the libnvdimm-for-next
branch as -next includes some of the SMART health changes leading to
at least one conflict.
