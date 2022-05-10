Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C885224DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiEJTfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiEJTfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:35:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CD728ABB4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:35:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p189so10791139wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKRFb9sxsi8oVNRQ43Dsv1RUcYQL89fBmT5eMJ6Q6vc=;
        b=EfY1U3ySncids9bZ/XiDLa2VH9i6sbY/PMjLNCbvBO1E67+B//9XD39LPI+k4M4SXb
         0mo6agcKMHL4JcqBGuur1rZZOR0bYlBs9lVOXwn6IxVJevsm9h4qZ5fCDG0CsQl86FHc
         dZm45vhhVRzeMywWFM3c/rIK3xZj9OfCrjmXk+ay6MaeYyuLU2MaWZK4v3cKSshiy3Hh
         8dxDMZWPxm8hyWF/FqJUetv/QUwyev5dO10y3i0kox5kliJcYyKHTQbwrNCeq2ieBpQn
         0QHn/Xra2ZglGj1nSXfcsFwuCOVxiit8IExysiIj+GKovfTp/eBVC8LodvK2lIvQQLOF
         NK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKRFb9sxsi8oVNRQ43Dsv1RUcYQL89fBmT5eMJ6Q6vc=;
        b=xWBkJ6ZYxxO0GK6uuN2unSvfqzonlYMlr1+5r2A1ow+YysT/VuAATZ+SPEzTV3ii78
         bmUVYwqTFsDVaC73RMAxkQDtNP08DFV5VucC2oZFLW3WUSHkdqWLkBvqd5Fj5DvFXDQL
         6q2Y75IIS5pY9NBoMHSDkYPm7EK/lDq1JudR1JuN4YroCed3AT8UvDzFnrcNnYIrOPV+
         d97dDd1NmN/EbRHUtU7t2kRHeTIOutDOARBRk+ftQ3TKFAc+cEOARE3KpGTl4MIO2oNv
         Ax4Y+0/xgwzTKYRUyed69GKjFgjk0vE9hA4HgIXGbi0Ty7OH0XWfsA7goHmLoq/7DhgJ
         pdhA==
X-Gm-Message-State: AOAM533r5iCKPnI08Rnu6EgKrVtYS427IhpEDHXe1fssimaQnnB8+dwX
        0xoxKLn/ar6Y1zlfBrT+Ixf8fgR2w9RfQ5RKhxCn2A==
X-Google-Smtp-Source: ABdhPJwtdbqlTr6NGdts99IEdCRtAfnTWT+wHPPMXwyZcWIMcXkbhDPH8ehovcRs+RmtpcnP4cUwZes7T+tfAkJVltw=
X-Received: by 2002:a05:600c:4ecc:b0:394:790d:5f69 with SMTP id
 g12-20020a05600c4ecc00b00394790d5f69mr1481079wmq.196.1652211318302; Tue, 10
 May 2022 12:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com>
 <20220510001807.4132027-2-yosryahmed@google.com> <Ynqyh+K1tMyNCTUW@slm.duckdns.org>
In-Reply-To: <Ynqyh+K1tMyNCTUW@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 10 May 2022 12:34:42 -0700
Message-ID: <CAJD7tkZVXJY3s2k8M4pcq+eJVD+aX=iMDiDKtdE=j0_q+UWQzA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/9] bpf: introduce CGROUP_SUBSYS_RSTAT
 program type
To:     Tejun Heo <tj@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:44 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, May 10, 2022 at 12:17:59AM +0000, Yosry Ahmed wrote:
> > @@ -706,6 +707,9 @@ struct cgroup_subsys {
> >        * specifies the mask of subsystems that this one depends on.
> >        */
> >       unsigned int depends_on;
> > +
> > +     /* used to store bpf programs.*/
> > +     struct cgroup_subsys_bpf bpf;
> >  };
>
> Care to elaborate on rationales around associating this with a specific
> cgroup_subsys rather than letting it walk cgroups and access whatever csses
> as needed? I don't think it's a wrong approach or anything but I can think
> of plenty of things that would be interesting without being associated with
> a specific subsystem - even all the cpu usage statistics are built to in the
> cgroup core and given how e.g. systemd uses cgroup to organize the
> applications in the system whether resource control is active or not, there
> are a lot of info one can gather about those without being associated with a
> specific subsystem.

Hi Tejun,

Thanks so much for taking the time to look into this!

The rationale behind associating this work with cgroup_subsys is that
usually the stats are associated with a resource (e.g. memory, cpu,
etc). For example, if the memory controller is only enabled for a
subtree in a big hierarchy, it would be more efficient to only run BPF
rstat programs for those cgroups, not the entire hierarchy. It
provides a way to control what part of the hierarchy you want to
collect stats for. This is also semantically similar to the
css_rstat_flush() callback.

However, I do see your point about the benefits of collecting stats
that are not associated with any controller. I think there are
multiple options here, and I would love to hear what you prefer:
1. In addition to subsystems, support an "all" or "cgroup" attach
point that loads BPF rstat flush programs that will run for all
cgroups.
2. Simplify the interface so that all BPF rstat flush programs run for
all cgroups, and add the subsystem association later if a need arises.
3. Instead of attaching BPF programs to a subsystem, attach them to a
cgroup. This gives more flexibility, but also makes lifetime handling
of programs more complicated and error-prone. I can also see most use
cases (including ours) attaching programs to the root cgroup anyway.
In this case, we waste space by storing pointers to the same program
in every cgroup, and have unnecessary complexity in the code.

Let me know what you think!

>
> Thanks.
>
> --
> tejun
