Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9287754F7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiFQMoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiFQMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:44:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AE71D302
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:44:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id es26so4342496edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdKMbRmYxGIRzFwzXCrDOD1Iihy0w1EPtro7jghx6ig=;
        b=lWl/eEx1oi+iUvbfmPEtpnL6l1bDL5L+6kDYhaJrlridmjgcJgND+D6HpsPrGj0fOX
         FC1hq48jQOsI0vbQ+ug0Y9gXytTIa1rB8fgt1TDdWRijQqB1B4BP1Vbx6jfm5skCg4pV
         LUYjMsC9IhxZCJ13YQoBm7dpD0cccTJ6VmHuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdKMbRmYxGIRzFwzXCrDOD1Iihy0w1EPtro7jghx6ig=;
        b=RGVnMob27Ry3H70Yf7a0q9vF2ajxmWhF2vjw03cqe4Xmlb2h1SCFhLcdhgk1qGWLEo
         7hAZpL9QXBnKicv0ah4HKG89/sWZDNEFA6+KkhImqJAXZ3LiVkQZ57+yHN8imejSHqM3
         16xk5yNjLV5DypAB9flrRL0d7SlWQYJvlFzHRTD/6Y4eALHm2idL5PzbRxlgZpVb0JP9
         tmccT81a+S5LuZNQDkV96f0pZAdJTvK/dzJJoEsV+eTKzegCEkExHtiWUsxV9f5SBYZ8
         VRMQhAye3ZBiZLOGVZNdJpwO1TOtlX6d/UXrG9HIGyxHtOgLFP+Nyr20x4l4D+ppMYqv
         E0SA==
X-Gm-Message-State: AJIora/Wima0VBzqOKBanMIpLTcT+LvxEBi2eoOTQJrk7a9zAcFwfnVK
        PjGEWNGWQHGvrlaOuW8/i8qYuUf0fMlOSa1yJgYlHg==
X-Google-Smtp-Source: AGRyM1sjXxR00gYNDLUChmtCCtOr/fIfRDGwnJkRu+woOOH5RsmXfvTSEoma/+gm453r0WqgfSMAIMR5R87rQIdxYb8=
X-Received: by 2002:a05:6402:5212:b0:42e:2fa:41a7 with SMTP id
 s18-20020a056402521200b0042e02fa41a7mr12205874edd.22.1655469849402; Fri, 17
 Jun 2022 05:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220617071027.6569-1-dharamhans87@gmail.com> <20220617071027.6569-2-dharamhans87@gmail.com>
 <CAJfpegtRzDbcayn7MYKpgO1MBFeBihyfRB402JHtJkbXg1dvLg@mail.gmail.com> <08d11895-cc40-43da-0437-09d3a831b27b@fastmail.fm>
In-Reply-To: <08d11895-cc40-43da-0437-09d3a831b27b@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 17 Jun 2022 14:43:58 +0200
Message-ID: <CAJfpegvSK0VmU6cLx5kiuXJ=RyL0d4=gvGLFCWQ16FrBGKmhMQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] Allow non-extending parallel direct writes on the
 same file.
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 at 11:25, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> Hi Miklos,
>
> On 6/17/22 09:36, Miklos Szeredi wrote:
> > On Fri, 17 Jun 2022 at 09:10, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >
> >> This patch relaxes the exclusive lock for direct non-extending writes
> >> only. File size extending writes might not need the lock either,
> >> but we are not entirely sure if there is a risk to introduce any
> >> kind of regression. Furthermore, benchmarking with fio does not
> >> show a difference between patch versions that take on file size
> >> extension a) an exclusive lock and b) a shared lock.
> >
> > I'm okay with this, but ISTR Bernd noted a real-life scenario where
> > this is not sufficient.  Maybe that should be mentioned in the patch
> > header?
>
>
> the above comment is actually directly from me.
>
> We didn't check if fio extends the file before the runs, but even if it
> would, my current thinking is that before we serialized n-threads, now
> we have an alternation of
>         - "parallel n-1 threads running" + 1 waiting thread
>         - "blocked  n-1 threads" + 1 running
>
> I think if we will come back anyway, if we should continue to see slow
> IO with MPIIO. Right now we want to get our patches merged first and
> then will create an updated module for RHEL8 (+derivatives) customers.
> Our benchmark machines are also running plain RHEL8 kernels - without
> back porting the modules first we don' know yet what we will be the
> actual impact to things like io500.
>
> Shall we still extend the commit message or are we good to go?

Well, it would be nice to see the real workload on the backported
patch.   Not just because it would tell us if this makes sense in the
first place, but also to have additional testing.

Thanks,
Miklos
