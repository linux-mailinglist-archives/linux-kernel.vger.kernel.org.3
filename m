Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCDC4E3264
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 22:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiCUVqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCUVqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:46:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C59E264561
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 14:41:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q11so13839639pln.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hzlxuoVcUtFNyYhd7IaP3vW/n/31iVrjVI0cYpxyVIg=;
        b=AJJS8AlLvE3dh4Iw3f148oDobBs8GBjNK4HQR4fd1ld62s0aCs+22XINlkoJDU3AoS
         8uOi8t84billfQr0/CqrEHKAzh01irX6vV3+g/0cziRJHBRIamVkeOpo/BnaIatO7PZV
         Eh43oCbXlnRIdtB69OTh5c/BRYxUtttvmXan5DnrMyeb/hsvFapXSvlvx+JuWcvRFGHt
         Ntke3y/TTx6l6EOaJqInsPSOd9mVsFU0WbP2/5lR+aO70ZuS7ys8aNRkV3i6D/Lf0evC
         r6BJwCreN/NdOKs2SjJv0+1od6GQSOKpx1d5z0hh7EF2eui/EcuQxfMSPoOkBKCZ7FWC
         /+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hzlxuoVcUtFNyYhd7IaP3vW/n/31iVrjVI0cYpxyVIg=;
        b=UbRXTHrsbs6r0S2xJn6wkWkjLM0sXBCuSClQGXF3b9YN1d7gUCaFKioapaKrzp61J/
         E9n7l3nG4HC1IAZayHLTDvgXK+I9JlvEwUWUJ3kOFpzMcLyKFJ4XB6Nbd128LwbAnlmj
         z7SHiKaXmgbbU2PnO3X7jNPgP0uaX6YpCN+2f8uSsUKXJlKgc8PYeACy5/qPq56NqJa8
         DxXKjqomHcW+SJPzEfqZMeNA6YDlSRxsPgQQUGR/jdwYoEfNBX2eGURhDimjP6Z9uTog
         OqWq0wUTvJgY33rOXnqzq/sSpEXUy/QqU6vyof2KMEgdyYr5rGmDSoe/zq67OmGly1i8
         GyDA==
X-Gm-Message-State: AOAM5331arWquAjePhmXc/F4LWOf3rOR4vRYwoiekQ99g7POnKsxphy9
        cQ9VIolu8MYM979p/tlV0qxCTuXwPdI9sQebPhnRBg==
X-Google-Smtp-Source: ABdhPJyzdofKTKHoiJ4iGCBbHSPi4Xc1wlwYjpgmL6SpWKAD7UioDwd+ubLQF8zj102JpbsH9iOBSWpSmWQXM5a6nHg=
X-Received: by 2002:a17:903:32c7:b0:154:4156:f384 with SMTP id
 i7-20020a17090332c700b001544156f384mr10917932plr.34.1647898771195; Mon, 21
 Mar 2022 14:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220318114133.113627-1-kjain@linux.ibm.com> <20220318114133.113627-2-kjain@linux.ibm.com>
In-Reply-To: <20220318114133.113627-2-kjain@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Mar 2022 14:39:23 -0700
Message-ID: <CAPcyv4iqpTn89WLOW1XjFXGZEYG_MmPg+VQbcDJ9ygJ4Jaybtw@mail.gmail.com>
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

On Fri, Mar 18, 2022 at 4:42 AM Kajol Jain <kjain@linux.ibm.com> wrote:
>
> The following build failure occures when CONFIG_PERF_EVENTS is not set
> as generic pmu functions are not visible in that scenario.
>
> arch/powerpc/platforms/pseries/papr_scm.c:372:35: error: =E2=80=98struct =
perf_event=E2=80=99 has no member named =E2=80=98attr=E2=80=99
>          p->nvdimm_events_map[event->attr.config],
>                                    ^~
> In file included from ./include/linux/list.h:5,
>                  from ./include/linux/kobject.h:19,
>                  from ./include/linux/of.h:17,
>                  from arch/powerpc/platforms/pseries/papr_scm.c:5:
> arch/powerpc/platforms/pseries/papr_scm.c: In function =E2=80=98papr_scm_=
pmu_event_init=E2=80=99:
> arch/powerpc/platforms/pseries/papr_scm.c:389:49: error: =E2=80=98struct =
perf_event=E2=80=99 has no member named =E2=80=98pmu=E2=80=99
>   struct nvdimm_pmu *nd_pmu =3D to_nvdimm_pmu(event->pmu);
>                                                  ^~
> ./include/linux/container_of.h:18:26: note: in definition of macro =E2=80=
=98container_of=E2=80=99
>   void *__mptr =3D (void *)(ptr);     \
>                           ^~~
> arch/powerpc/platforms/pseries/papr_scm.c:389:30: note: in expansion of m=
acro =E2=80=98to_nvdimm_pmu=E2=80=99
>   struct nvdimm_pmu *nd_pmu =3D to_nvdimm_pmu(event->pmu);
>                               ^~~~~~~~~~~~~
> In file included from ./include/linux/bits.h:22,
>                  from ./include/linux/bitops.h:6,
>                  from ./include/linux/of.h:15,
>                  from arch/powerpc/platforms/pseries/papr_scm.c:5:
>
> Fix the build issue by adding check for CONFIG_PERF_EVENTS config option
> and disabling the papr_scm perf interface support incase this config
> is not set
>
> Fixes: 4c08d4bbc089 ("powerpc/papr_scm: Add perf interface support") (Com=
mit id
> based on linux-next tree)
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 15 +++++++++++++++

This is a bit messier than I would have liked mainly because it dumps
a bunch of ifdefery into a C file contrary to coding style, "Wherever
possible, don't use preprocessor conditionals (#if, #ifdef) in .c
files". I would expect this all to move to an organization like:

arch/powerpc/platforms/pseries/papr_scm/main.c
arch/powerpc/platforms/pseries/papr_scm/perf.c

...and a new config symbol like:

config PAPR_SCM_PERF
       depends on PAPR_SCM && PERF_EVENTS
       def_bool y

...with wrappers in header files to make everything compile away
without any need for main.c to carry an ifdef.

Can you turn a patch like that in the next couple days? Otherwise, I
think if Linus saw me sending a late breaking compile fix that threw
coding style out the window he'd have cause to just drop the pull
request entirely.
