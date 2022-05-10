Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA76521F66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbiEJPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346208AbiEJPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:48:11 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A09FB4;
        Tue, 10 May 2022 08:44:03 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-edeb6c3642so18761843fac.3;
        Tue, 10 May 2022 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RwhvTaPMTXS/r9Tvnic8Vj/MtLD+ZHDCwWAKS1sXAWg=;
        b=VQ7IuGmdb1SlC/0XtZXIr5zAeGWxfbyxHoFWzy2+8b6P1Xd/Ev8qQ9bUuZ4F5Mg2Th
         JbvEBIFbi/QW5d+INrvGjuQP5gPMtEVQB5gCVUlTipzrW0kQNls5Em0xz3G1T19PpNf0
         cU/ehLjXOZ4ck9mhA1SC8pG9BQXxS9Cgkje8Gd8FZZmpieJGDmjg+6zckKG1PYmtwPZS
         T52Z/FHigzV6six7SFd2lRA75rtqe69yRCJjiuASDXy+LeDQ+q2bwRwQf+2cwXTeTR+t
         SLX62Wo1xOpGSUnDuAu933ocDrsPhDexNRiYo9ACBqiswkVOzzEUMH65o41nj3UouJ5q
         LcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RwhvTaPMTXS/r9Tvnic8Vj/MtLD+ZHDCwWAKS1sXAWg=;
        b=RJA4d2bcrm1aWS1XSyljgPHu6wrJogn/UKa6h4hhouuCSujaYIC7mARs9d9w5qe8mD
         0pXtxf4rcffdCcgORNsWhX7O+YvMyN+2zUP9lbA13fjoY8MJPcMo6RbaIwCDkV00qySd
         TWe5VUg684uHQhTs6183KjIv6K7k7aUppZ5oQ5uSeBikIceAjPKFaIyx2FElBq+yeaKn
         +DTFR+Gb9N1qLboMEo5W6W7GphjmQi/2jGdqjySUhIbU1/tnqrdSJHme5CpxxRN/1ZqJ
         YzG4oXfSr8fh/LtvUAqqXICFZMHeDQG6RIUEn1/HZZfelyHyRg54noxdWQ+YPLWUxEGd
         ApQw==
X-Gm-Message-State: AOAM531o1n2vCWDTjpVVrdBZQKhrN0lqun0OfURlR0FcmqLA1QUCQYpA
        Up+JBqLHcL50Ae7ja0sOvGT5QjXak95acOTA8r0=
X-Google-Smtp-Source: ABdhPJzq7EsizdFxJD9pqNfA33imiXEI04vaxV7qYRPqCUlkNnMEYmisEAnGOvnfsSO7iyfRvrcOd8lNiqIxMUiw/ik=
X-Received: by 2002:a05:6871:611:b0:ed:9b5e:261f with SMTP id
 w17-20020a056871061100b000ed9b5e261fmr422216oan.276.1652197442217; Tue, 10
 May 2022 08:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510152811.88071-1-schspa@gmail.com>
 <CAJZ5v0hj_7tGTQm8q4AVqL6F=Y6FzGP=UV7TkbJ=hJk2LPCN1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hj_7tGTQm8q4AVqL6F=Y6FzGP=UV7TkbJ=hJk2LPCN1Q@mail.gmail.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Tue, 10 May 2022 23:43:50 +0800
Message-ID: <CAMA88Tpj6Gv6xMajNOtiVpwXd8UdjokMzvXgU9z90uzbF6moSQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: fix race on cpufreq online
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2022=E5=B9=B45=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=8C 23:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, May 10, 2022 at 5:28 PM Schspa Shi <schspa@gmail.com> wrote:
> >
> > When cpufreq online failed, policy->cpus are not empty while
> > cpufreq sysfs file available, we may access some data freed.
> >
> > Take policy->clk as an example:
> >
> > static int cpufreq_online(unsigned int cpu)
> > {
> >   ...
> >   // policy->cpus !=3D 0 at this time
> >   down_write(&policy->rwsem);
> >   ret =3D cpufreq_add_dev_interface(policy);
> >   up_write(&policy->rwsem);
> >
> >   down_write(&policy->rwsem);
> >   ...
> >   /* cpufreq nitialization fails in some cases */
> >   if (cpufreq_driver->get && has_target()) {
> >     policy->cur =3D cpufreq_driver->get(policy->cpu);
> >     if (!policy->cur) {
> >       ret =3D -EIO;
> >       pr_err("%s: ->get() failed\n", __func__);
> >       goto out_destroy_policy;
> >     }
> >   }
> >   ...
> >   up_write(&policy->rwsem);
> >   ...
> >
> >   return 0;
> >
> > out_destroy_policy:
> >         for_each_cpu(j, policy->real_cpus)
> >                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
> >     up_write(&policy->rwsem);
> > ...
> > out_exit_policy:
> >   if (cpufreq_driver->exit)
> >     cpufreq_driver->exit(policy);
> >       clk_put(policy->clk);
> >       // policy->clk is a wild pointer
> > ...
> >                                     ^
> >                                     |
> >                             Another process access
> >                             __cpufreq_get
> >                               cpufreq_verify_current_freq
> >                                 cpufreq_generic_get
> >                                   // acces wild pointer of policy->clk;
> >                                     |
> >                                     |
> > out_offline_policy:                 |
> >   cpufreq_policy_free(policy);      |
> >     // deleted here, and will wait for no body reference
> >     cpufreq_policy_put_kobj(policy);
> > }
> >
> > We can fix it by clear the policy->cpus mask.
> > Both show_scaling_cur_freq and show_cpuinfo_cur_freq will return an
> > error by checking this mask, thus avoiding UAF.
> >
> > Signed-off-by: Schspa Shi <schspa@gmail.com>
> >
> > ---
> >
> > Changelog:
> > v1 -> v2:
> >         - Fix bad critical region enlarge which causes uninitialized
> >           unlock.
> > ---
> >  drivers/cpufreq/cpufreq.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 80f535cc8a75..8edfa840dd74 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1337,12 +1337,12 @@ static int cpufreq_online(unsigned int cpu)
> >                 down_write(&policy->rwsem);
> >                 policy->cpu =3D cpu;
> >                 policy->governor =3D NULL;
> > -               up_write(&policy->rwsem);
> >         } else {
> >                 new_policy =3D true;
> >                 policy =3D cpufreq_policy_alloc(cpu);
> >                 if (!policy)
> >                         return -ENOMEM;
> > +               down_write(&policy->rwsem);
> >         }
> >
> >         if (!new_policy && cpufreq_driver->online) {
>
> You seem to have missed the down_write() before the
>
> cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>
> statement.
>
> It needs to be removed, because the semaphore is already being held
> for writing at that point after the changes above.
>

Sorry for that, I have upload a v3 patch to remove this.

> > @@ -1533,7 +1533,7 @@ static int cpufreq_online(unsigned int cpu)
> >         for_each_cpu(j, policy->real_cpus)
> >                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
> >
> > -       up_write(&policy->rwsem);
> > +       cpumask_clear(policy->cpus);
> >
> >  out_offline_policy:
> >         if (cpufreq_driver->offline)
> > @@ -1542,6 +1542,7 @@ static int cpufreq_online(unsigned int cpu)
> >  out_exit_policy:
> >         if (cpufreq_driver->exit)
> >                 cpufreq_driver->exit(policy);
> > +       up_write(&policy->rwsem);
> >
> >  out_free_policy:
> >         cpufreq_policy_free(policy);
> > --
---
BRs
Schspa Shi
