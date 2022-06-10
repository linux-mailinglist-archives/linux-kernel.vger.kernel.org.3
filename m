Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55DC546332
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347499AbiFJKI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbiFJKI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:08:58 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE019D629
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:08:56 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3137316bb69so72504387b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FqOEYfTPGzkFTNzleE3Yq5zFcM08tmYv8xDU0r1Kelk=;
        b=Gaa7Cp9jRk8Xdo8S6vKLLzLBOIZnlowf8JcL5qQBiUCiLD97gVsiEOjNbAVFY53Qd2
         geffaAS9d9V13pBtWQoeRhjr33B3mBIYV64wvPAD1i2Uufb/LU70i2rCDsj8HKyygcR/
         3HB3WmA+ZS1/idvp9oZBBRdGkzvdtyQj5Ymjq8NmoqM/AzJnLtWE1bUWC0w6Zpx2/Z8c
         iiKRzI52/ty6OqLNAWD7Vm6R+groS9m2X8N/G7fYi0YfFjujuwJ5r1w9IezzNyuH/zZg
         f93/j2jAxzIPw2/0iRp4vnro6yrI5h5FVZ8elOvrPT0T6enU/yusHSnQSDlcC0ndHJp0
         jfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FqOEYfTPGzkFTNzleE3Yq5zFcM08tmYv8xDU0r1Kelk=;
        b=LpnxELVHntTXSFUFPEHiW5ZDYfcrbrmPIpU78Si1gLepI5A7QzMfA4PVZ9ZfBj86LL
         LO743FxsP+buBF8u9rQsvSnCjYVVMZz55GV6rhZ0mDNshOzu6qqaAYtk1MIyYIBo2j6N
         ufjF1+0GQ3js7WeBS/IWfusdkATy0g0kNwNNMvkvp7SwPW4pROXMS12XVMcqXFyKiQUv
         4hF+9BNnom80FBUWD38LIi3vqnr7NoDSZVuEf1Jp0SizTyXZeKLEd3L03eO84jpEjBXY
         kok9WPJVqHKv/KihmaRylJ/eiGOpbtUcQWyfXo+q8zSitOB5lvizNzqKsc4hJB4TaarS
         GLFw==
X-Gm-Message-State: AOAM531rox3Kx735YrpE5/A1Xte2defqc0HpGyCwQobUv06QR6A2LlYB
        fdXtmqbmt7LGj13sr936nzFvFsIsk0VlEpXxstLxnw==
X-Google-Smtp-Source: ABdhPJzAb6cydAqIvV9gfGidvRMumSUL3neEQhe9D2juNGEbwTOLmCo4/1bMQz+yDKQqcQfBgcp5ZHMT4EIjw3OZ4hY=
X-Received: by 2002:a0d:d68b:0:b0:30f:abb1:5b55 with SMTP id
 y133-20020a0dd68b000000b0030fabb15b55mr47464839ywd.359.1654855735850; Fri, 10
 Jun 2022 03:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220525081416.3306043-8-sudeep.holla@arm.com>
 <20220525081416.3306043-9-sudeep.holla@arm.com> <20220525081416.3306043-10-sudeep.holla@arm.com>
 <20220525081416.3306043-11-sudeep.holla@arm.com> <20220525081416.3306043-12-sudeep.holla@arm.com>
 <20220525081416.3306043-13-sudeep.holla@arm.com> <20220525081416.3306043-14-sudeep.holla@arm.com>
 <20220525081416.3306043-15-sudeep.holla@arm.com> <20220525081416.3306043-16-sudeep.holla@arm.com>
 <947470ba-35fc-3c72-d01b-c0a7337216a2@arm.com> <20220606102159.dduxmvq4m2fm6gks@bogus>
In-Reply-To: <20220606102159.dduxmvq4m2fm6gks@bogus>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Jun 2022 12:08:44 +0200
Message-ID: <CAKfTPtB8iPzEXipsJqNtd9-aJMKx-FAaiGMzOg58HgRQuo39iA@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 at 12:22, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Jun 03, 2022 at 02:30:04PM +0200, Dietmar Eggemann wrote:
> > On 25/05/2022 10:14, Sudeep Holla wrote:
> > > Let us set the cluster identifier as parsed from the device tree
> > > cluster nodes within /cpu-map.
> > >
> > > We don't support nesting of clusters yet as there are no real hardwar=
e
> > > to support clusters of clusters.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/base/arch_topology.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topolog=
y.c
> > > index b8f0d72908c8..5f4f148a7769 100644
> > > --- a/drivers/base/arch_topology.c
> > > +++ b/drivers/base/arch_topology.c
> > > @@ -492,7 +492,7 @@ static int __init get_cpu_for_node(struct device_=
node *node)
> > >  }
> > >
> > >  static int __init parse_core(struct device_node *core, int package_i=
d,
> > > -                        int core_id)
> > > +                        int cluster_id, int core_id)
> > >  {
> > >     char name[20];
> > >     bool leaf =3D true;
> > > @@ -508,6 +508,7 @@ static int __init parse_core(struct device_node *=
core, int package_id,
> > >                     cpu =3D get_cpu_for_node(t);
> > >                     if (cpu >=3D 0) {
> > >                             cpu_topology[cpu].package_id =3D package_=
id;
> > > +                           cpu_topology[cpu].cluster_id =3D cluster_=
id;
> > >                             cpu_topology[cpu].core_id =3D core_id;
> > >                             cpu_topology[cpu].thread_id =3D i;
> > >                     } else if (cpu !=3D -ENODEV) {
> > > @@ -529,6 +530,7 @@ static int __init parse_core(struct device_node *=
core, int package_id,
> > >             }
> > >
> > >             cpu_topology[cpu].package_id =3D package_id;
> > > +           cpu_topology[cpu].cluster_id =3D cluster_id;
> >
> > I'm still not convinced that this is the right thing to do. Let's take
> > the juno board as an example here. And I guess our assumption should be
> > that we want to make CONFIG_SCHED_CLUSTER a default option, like
> > CONFIG_SCHED_MC is. Simply to avoid a unmanageable zoo of config-option
> > combinations.
> >
>
> Agreed on the config part.
>
> > (1) Scheduler Domains (SDs) w/o CONFIG_SCHED_CLUSTER:
> >
> > MC  <-- !!!
> > DIE
> >
> > (2) SDs w/ CONFIG_SCHED_CLUSTER:
> >
> > CLS <-- !!!
> > DIE
> >
>
> Yes I have seen this.
>
> > In (2) MC gets degenerated in sd_parent_degenerate() since CLS and MC
> > cpumasks are equal and MC does not have any additional flags compared t=
o
> > CLS.
> > I'm not convinced that we can change the degeneration rules without
> > destroying other scenarios of the scheduler so that here MC stays and
> > CLS gets removed instead.
> >
>
> Why ? Are you suggesting that we shouldn't present the hardware cluster
> to the topology because of the above reason ? If so, sorry that is not a
> valid reason. We could add login to return NULL or appropriate value
> needed in cpu_clustergroup_mask id it matches MC level mask if we can't
> deal that in generic scheduler code. But the topology code can't be
> compromised for that reason as it is user visible.

I tend to agree with Dietmar. The legacy use of cluster node in DT
refers to the dynamiQ or legacy b.L cluster which is also aligned to
the LLC and the MC scheduling level. The new cluster level that has
been introduced recently does not target this level but some
intermediate levels either inside like for the kupeng920 or the v9
complex or outside like for the ampere altra. So I would say that
there is one cluster node level in DT that refers to the same MC/LLC
level and only an additional child/parent cluster node should be used
to fill the clustergroup_mask.

IIUC, we don't describe the dynamiQ level in ACPI which  uses cache
topology instead to define cpu_coregroup_mask whereas DT described the
dynamiQ instead of using cache topology. If you use cache topology
now, then you should skip the dynamiQ

Finally, even if CLS and MC have the same scheduling behavior for now,
they might ends up with different scheduling properties which would
mean that replacing MC level by CLS one for current SoC would become
wrong

>
> > Even though MC and CLS are doing the same right now from the perspectiv=
e
> > of the scheduler, we should also see MC and not CLS under (2). CLS only
> > makes sense longer term if the scheduler also makes use of it (next to
> > MC) in the wakeup-path for instance. Especially when this happens, a
> > platform should always construct the same scheduler domain hierarchy, n=
o
> > matter which CONFIG_SCHED_XXX options are enabled.
> >
> >
> > You can see this in update_siblings_masks()
> >
> >     if (last_level_cache_is_shared)
> >         set llc_sibling
> >
> >     if (cpuid_topo->package_id !=3D cpu_topo->package_id)
> >         continue
> >
> >     set core_sibling
> >
> >   If llc cache and socket boundaries are congruent, llc_sibling and
> >   core_sibling are the same.
> >
> >     if (cpuid_topo->cluster_id !=3D cpu_topo->cluster_id)
> >         continue
> >
> >     set cluster_sibling
> >
> >   Now we potentially set clusters. Since socket=3D0 is by default and w=
e
> >   use the existing juno.dts, the cluster nodes end up being congruent t=
o
> >   the llc cache cpumasks as well.
> >
>
> Correct and I see no problems as it matches what the hardware is. So I am
> not expecting any change in any cpumasks there as they all are aligned wi=
th
> the hardware.
>
> > The problem is that we code `llc cache` and `DT cluster nodes` as the
> > same thing in juno.dts.
>
> Why is that a problem ? If so, blame hardware and deal with it as we have=
 to
> =F0=9F=98=84 as usual we get all sorts of topology.
>
> > `Cluster0/1` are congruent with the llc information, although they shou=
ld
> > be actually `socket0/1` right now.
>
> That was complete non-sense and wrong. Boot and check in ACPI mode.
>
> > But we can't set-up a cpu-map with a `socketX` containing `coreY` direc=
tly.
> > And then we use llc_sibling and cluster_sibling in two different SD
> > cpumask functions (cpu_coregroup_mask() and cpu_clustergroup_mask()).
> >
>
> We just need to deal with that. How is that dealt today with ACPI. My
> changes are making these aligned with ACPI. If something is broken as
> per you understanding with ACPI, then that needs fixing. The topology
> presented and parsed by ACPI is correct and we are aligning DT with that.
> There is no question on that.
>
> > Remember, CONFIG_SCHED_CLUSTER was introduced in ACPI/PPTT as a cpumask
> > which is a subset of the cpumasks of CONFIG_SCHED_MC.
> >
>
> But that change also introduced cluster masks into the topology which aga=
in
> aligns with my changes.
>
> > IMHO we probably could just introduce your changes w/o setting `cpu-map
> > cluster nodes` in DT for now. We would just have to make sure that for
> > all `*.dts` affected, the `llc cache` info can take over the old role o=
f
> > the `cluster nodes`. In this case e.g. Juno ends up with MC, DIE no
> > matter if CONFIG_SCHED_CLUSTER is set or not.
>
> Sure I can agree with that if Juno ACPI is not broken. But I am sure it i=
s
> broken based on your argument above. If it is, that needs fixing and this
> series just gets topology parsing in both ACPI and DT aligned, nothing
> more or nothing less. In the process it may be introducing clusters, but
> if it is not dealt correctly in ACPI, then it won't be in DT too and need=
s
> fixing anyways.
>
> --
> Regards,
> Sudeep
