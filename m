Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA515527DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbiEPHAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbiEPG75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:59:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3146ADFA5
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:59:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g6so26773292ejw.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SH+DM8gWRShDh4xAKJ9hq9ZGV6WzwS40V7Ikj9JGnTU=;
        b=aKJMP7FFPV4UsmM8hjbALJW38MNT+IhNk/fyIk0k+DzD6WAfnAvr5bgKwW5D1tTQWt
         OhKgJhsvN9hDqnwoSO8fE/M5y3CxnnfBMfWuuOkU5N9dypEbs9+s9aElvnwnFn46Z6EN
         1K+gRZq1tUfcB2BiIANmYaWh5IIk08T+yTMaJwn9QI5RX/K8IQplq2XSzrnoZ8K3dpXx
         VnqUowRVTSH9v0IbVo6nSaooCYxuXagd4qtjAQlhdQTrVi4MfmWmPXduazz4hSf6jFm0
         KH0P1TGu44ipz1q1VHAIP1ciG/k9ijhoWxlMacA7KvWp+P5qBc0lskRwzNjcaQa+LBA4
         3sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SH+DM8gWRShDh4xAKJ9hq9ZGV6WzwS40V7Ikj9JGnTU=;
        b=CsA0sKPqT2gpmZtob7zCc+OiU2BB0TJGRps62RQWGqpBD1U6QW02f2IDMRCxJDV/GI
         /iEPYi+KUshPhoKGC3ES6DDL+lD3hWRQPrwSklCT5eiU0vU3Hw5AjwnXXyOETQCs1Mgl
         NWVA/UOYRw9itgfKZ+Ll4QL/H1i4W93w8MgAFZpH17HhlelYPPCdiKV/MK1m9ZjQfNWT
         RnXqrDpB+HPqtdHnVYyqwGiuuPLfNOUaIw9w1WxJMCsXX2vMFefrxWxK8MG9rlQBq9sZ
         +14VT/NAfvzMwsCUZdTMekIdrN88jUvPNKRVFOzc1hHyHSXrCyCH+RBL5LiN6CrEp60Y
         oF8g==
X-Gm-Message-State: AOAM532K7PC0OpCuPvh8hJutSn5eLT5aJ5o6/zenDopuB/X47YZanJ/u
        E2b/LWsHGeQUIhJpHhECRfvq6EP5eAR61I0J6iIKYpppnCQ=
X-Google-Smtp-Source: ABdhPJyRWL9sG7b4N57dKKmf+qijk6tKu6Uz08nhG0MhS/lMZv0z0BBWDuJPgIMS+41XqW/xAzsSvJ4z05GcAZJuP9w=
X-Received: by 2002:a17:906:7309:b0:6f5:ea1:afa with SMTP id
 di9-20020a170906730900b006f50ea10afamr13666909ejc.170.1652684394688; Sun, 15
 May 2022 23:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220513093433.425163-1-dietmar.eggemann@arm.com> <39be28ea-1645-30c3-316e-87a43b8738a8@arm.com>
In-Reply-To: <39be28ea-1645-30c3-316e-87a43b8738a8@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 16 May 2022 18:59:43 +1200
Message-ID: <CAGsJ_4z=U=4mtkbjJKq3=_npLnqDtXnCwqr-9kbXkaRn4Jiydw@mail.gmail.com>
Subject: Re: [PATCH] topology: Remove unused cpu_cluster_mask()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 9:48 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> - Barry Song <song.bao.hua@hisilicon.com> bounced
> + Barry Song <21cnbao@gmail.com>
>
> On 13/05/2022 11:34, Dietmar Eggemann wrote:
> > default_topology[] uses cpu_clustergroup_mask() for the CLS level
> > (guarded by CONFIG_SCHED_CLUSTER) which is currently provided by x86
> > (arch/x86/kernel/smpboot.c) and arm64 (drivers/base/arch_topology.c).
> >
> > Fixes: 778c558f49a2c ("sched: Add cluster scheduler level in core and
> > related Kconfig for ARM64")
> >
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
> >  include/linux/topology.h | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/include/linux/topology.h b/include/linux/topology.h
> > index f19bc3626297..4564faafd0e1 100644
> > --- a/include/linux/topology.h
> > +++ b/include/linux/topology.h
> > @@ -240,13 +240,6 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
> >  }
> >  #endif
> >
> > -#if defined(CONFIG_SCHED_CLUSTER) && !defined(cpu_cluster_mask)
> > -static inline const struct cpumask *cpu_cluster_mask(int cpu)
> > -{
> > -     return topology_cluster_cpumask(cpu);
> > -}
> > -#endif
> > -

Acked-by: Barry Song <baohua@kernel.org>

I agree there are no users right now. I probably wrote it like cpu_smt_mask()
and used it in kernel/sched for the wake_affine patch but forgot to remove it
while sending patches without wake_affine.


> >  static inline const struct cpumask *cpu_cpu_mask(int cpu)
> >  {
> >       return cpumask_of_node(cpu_to_node(cpu));
>

Thanks
Barry
