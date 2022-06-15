Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966FF54D4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350299AbiFOWoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350327AbiFOWob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:44:31 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185F56390
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:44:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31332df12a6so75694687b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tavlAUV9j8wy9Y5ZQvNo9SbXkg+xPmAoMXm4I/5xKc=;
        b=aZNQ5xMgIiG+HULjGPsz/c4fuu1pIiVq25bbPs0kP7PT4TVBMUXWXxCb+XdLlboNiS
         BY1QO9YbEkE1ucrqKunLlScMzaeQjou00OCPBM4w+t5MZQLjUIxAd7DQQBe7lKb1FOG+
         c5NGYsihwrfO1Ad6GDXI18YoVHjQaZ+S2FCfah4pFm6qevntRpdMtuxzgJO8y299+li5
         Gqz5VJ4/8kRzkg8gMQO32Vz1ItJbqloXo35C1YbgSSBn/9u/TCyYr1NOYhdJhHFkYht2
         DpG6H7EHtm3JLFKAXgoVXB5PaPGNQANnNBqDYGif7OcNDRf0fXUlmM6+kwFRCJtliAI8
         CZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tavlAUV9j8wy9Y5ZQvNo9SbXkg+xPmAoMXm4I/5xKc=;
        b=oHHHzDRlV4zGfLmUZ1oVkTlMU8CYGrcendGEWbLQOW3GIOvymM9sGliU8bSeeVWHP/
         vccphKwAsMBYg+ZTRnKXsmqz7voZ3I42qXvjvwqq5f3WKC3yT4XkV5CHdvuR/6YFFac1
         6Mim0BbeZ616UF4rI4P+nIhepG/RDTg7sNE85UgHLlakKf/QyH38UzmPhMPyW2tlCi7U
         TNEXcZhGVNQLmlfz7TXKGkOtASmmtVdcJLF1+z1b7s2y+nMbycu0ncXIPasGGbzclp5T
         q+0RLnaxUSVLRPwMjI4CMdVmJuOCjpLnvTy5V//SzZeQtjfOEUKyAbSnOIDaHqA5WVrg
         Nk/A==
X-Gm-Message-State: AJIora9bQI2b+OUyxAg92vwk2HSTOhAgBMSv8844GyxG/MCpv/aoHfwW
        4LNRUYwra1c3T/sNVNy6Bc5ZFdKl+9QVGTJL9WBN2g==
X-Google-Smtp-Source: AGRyM1stRFtj29Af2h8WR1JcITwxs/W78sA8TWkUE/45znWIrRL39l5SwaqbU8gHEq2Pk+V2tvNYYWtmYMer5uWOrHY=
X-Received: by 2002:a81:8707:0:b0:314:1c64:eb4d with SMTP id
 x7-20020a818707000000b003141c64eb4dmr2323993ywf.86.1655333069287; Wed, 15 Jun
 2022 15:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220525081416.3306043-12-sudeep.holla@arm.com>
 <20220525081416.3306043-13-sudeep.holla@arm.com> <20220525081416.3306043-14-sudeep.holla@arm.com>
 <20220525081416.3306043-15-sudeep.holla@arm.com> <20220525081416.3306043-16-sudeep.holla@arm.com>
 <947470ba-35fc-3c72-d01b-c0a7337216a2@arm.com> <20220606102159.dduxmvq4m2fm6gks@bogus>
 <CAKfTPtB8iPzEXipsJqNtd9-aJMKx-FAaiGMzOg58HgRQuo39iA@mail.gmail.com>
 <20220610102753.virkx47uyfsojol6@bogus> <CAKfTPtD==UMjbSGHvKxT_z=LyvsJt=UCHsqkbgVnagbn5Aqpcw@mail.gmail.com>
 <20220615170033.q4og4pnmpwdg3l2g@bogus>
In-Reply-To: <20220615170033.q4og4pnmpwdg3l2g@bogus>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 16 Jun 2022 00:44:17 +0200
Message-ID: <CAKfTPtCeox-qjaoXqOawaghZDwsKBF6FBPENFtsQSb2r6JPy2w@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 at 19:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Please note until we agree on unified view for hardware topology, I will
> temporarily ignore any scheduler domain related issues/concerns as this
> thread/discussion is mixing up too much IMO. I am not ignoring sched_domain
> concerns, but deferring it until we agree on the hardware topology view
> which is user visible and how that impacts sched domain topology can be
> considered soon following that.
>
> On Tue, Jun 14, 2022 at 07:59:23PM +0200, Vincent Guittot wrote:
> > On Fri, 10 Jun 2022 at 12:27, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Fri, Jun 10, 2022 at 12:08:44PM +0200, Vincent Guittot wrote:
> > > > On Mon, 6 Jun 2022 at 12:22, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > >
> > > [...]
> > >
> > > > > Why ? Are you suggesting that we shouldn't present the hardware cluster
> > > > > to the topology because of the above reason ? If so, sorry that is not a
> > > > > valid reason. We could add login to return NULL or appropriate value
> > > > > needed in cpu_clustergroup_mask id it matches MC level mask if we can't
> > > > > deal that in generic scheduler code. But the topology code can't be
> > > > > compromised for that reason as it is user visible.
> > > >
> > > > I tend to agree with Dietmar. The legacy use of cluster node in DT
> > > > refers to the dynamiQ or legacy b.L cluster which is also aligned to
> > > > the LLC and the MC scheduling level. The new cluster level that has
> > > > been introduced recently does not target this level but some
> > > > intermediate levels either inside like for the kupeng920 or the v9
> > > > complex or outside like for the ampere altra. So I would say that
> > > > there is one cluster node level in DT that refers to the same MC/LLC
> > > > level and only an additional child/parent cluster node should be used
> > > > to fill the clustergroup_mask.
> > > >
> > >
> > > Again I completely disagree. Let us look at the problems separately.
> > > The hardware topology that some of the tools like lscpu and lstopo expects
> > > what the hardware looks like and not the scheduler's view of the hardware.
> > > So the topology masks that gets exposed to the user-space needs fixing
> > > even today. I have reports from various tooling people about the same.
> > > E.g. Juno getting exposed as dual socket system is utter non-sense.
> > >
> > > Yes scheduler uses most of the topology masks as is but that is not a must.
> > > There are these *group_mask functions that can implement what scheduler
> > > needs to be fed.
> > >
> > > I am not sure why the 2 issues are getting mixed up and that is the main
> > > reason why I jumped into this to make sure the topology masks are
> > > not tampered based on the way it needs to be used for scheduler.
> > >
> > > Both ACPI and DT on a platform must present exact same hardware topology
> > > to the user-space, there is no space for argument there.
> >
> > But that's exactly my point there:
> > ACPI doesn't show the dynamiQ level anywhere but only the llc which
> > are the same and your patch makes the dynamiQ level visible for DT in
> > addition to llc
> >
>
> Sorry if I am missing something obvious here, but both ACPI and DT has no
> special representation for dynamiQ clusters and hence it is impossible to
> deduce the same from either DT or ACPI. Can you provide some details
> or example as what you are referring as dynamiQ. Also what you mean by
> dynamiQ not shown on ACPI while shown with DT systems. If there is any
> discrepancies, we need to fix.

The cpu-map node in DT is following the dynamiQ or the legacy
big.LITTLE topology. As an example  the hikey6220 has 2 clusters, the
hikey960 has 2 clusters that reflect big.LITTLE and the sdm845 has one
cluster that reflects the dynamiQ cluster.

now my mistake is to have made the assumption that core_sibling is
arch_topology was used to reflect the cores sharing cache but after
looking more deeply in the code it seems to be a lucky coincidence

>
> Now, what I refer as discrepancy for example on Juno is below:
> (value read from a subset of per cpu sysfs files)
> cpu                     0       1       2       3       4       5
> cluster_id              -1      -1      -1      -1      -1      -1
> physical_package_id     1       0       0       1       1       1
> cluster_cpus_list       0       1       2       3       4       5
> package_cpus_list       0,3-5   1-2     1-2     0,3-5   0,3-5   0,3-5
>
> The above one is for DT which is wrong in all the 4 entries above.
> The below one is on ACPI and after applying my series on Juno.
>
> cpu                     0       1       2       3       4       5
> cluster_id              1       0       0       1       1       1
> physical_package_id     0       0       0       0       0       0
> cluster_cpus_list       0,3-5   1-2     1-2     0,3-5   0,3-5   0,3-5
> package_cpus_list       0-5     0-5     0-5     0-5     0-5     0-5
>
> This matches the expectation from the various userspace tools like lscpu,
> lstopo,..etc.
>
> > >
> > > > IIUC, we don't describe the dynamiQ level in ACPI which  uses cache
> > > > topology instead to define cpu_coregroup_mask whereas DT described the
> > > > dynamiQ instead of using cache topology. If you use cache topology
> > > > now, then you should skip the dynamiQ
> > > >
> > >
> > > Yes, unless someone can work out a binding to represent that and convince
> > > DT maintainers ;).
> > >
> > > > Finally, even if CLS and MC have the same scheduling behavior for now,
> > > > they might ends up with different scheduling properties which would
> > > > mean that replacing MC level by CLS one for current SoC would become
> > > > wrong
> > > >
> > >
> > > Again as I mentioned to Dietmar, that is something we can and must deal with
> > > in those *group_mask and not expect topology mask to be altered to meet
> > > CLS/MC or whatever sched domains needs. Sorry, that is my strong opinion
> > > as the topology is already user-space visible and (tooling) people are
> > > complaining that DT systems are broken and doesn't match ACPI systems.
> >
> > again, your proposal doesn't help here because the DT will show a
> > level that doesn't appears in ACPI
> >
>
> Which level exactly ? It matches exactly for Juno, the sysfs files are
> exact match after my changes. Again don't mix the scheduler domains for
> arguments here.
>
> > >
> > > So unless someone gives me non-scheduler and topology specific reasons
> > > to change that, sorry but my opinion on this matter is not going to change ;).
> > >
> > > You will get this view of topology, find a way to manage with all those
> > > *group_mask functions. By the way it is already handled for ACPI systems,
> >
> > AFAICT, no it's not, the cluster described in ACPI is not the dynamiQ
> > level that you make now visible to DT
>
> Again, no. There is no binding for dynamiQ level either in DT or ACPI and
> hence there is no way it can become visible on DT. So I have no idea why
> there is a thought process or assumption about existence of dynamiQ level
> in the DT. It doesn't exist. If that is wrong, can you point me to the
> bindings as well as existing device tree ? If you are referring to the
> phantom domains Dietmar mentioned in earlier threads, then they don't exist.
> It is made up and one need to get the bindings pushed before we can address
> such a system.
>
> --
> Regards,
> Sudeep
