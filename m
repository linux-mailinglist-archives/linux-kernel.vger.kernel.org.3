Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38F94B5C66
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiBNVP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:15:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiBNVPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:15:36 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916811ADFE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:15:28 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id j12so27852127ybh.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koOwKzeH7/Gb78FEuOvCok9kPJwObv2S7DVJdDdOgNA=;
        b=Pb5dbCHSbOY7B3ORjcQJ4tOqYQjm9jFUDuW4A8Uw3ddfl/KioQspJ7vPApWeypuuyQ
         AbdlnFPPC52dg3yNb0beEJdpRbmFdEDeTuxJF39E+eg6ecEa/6ji0TduWQr0JYt33wqk
         F00WTtwEQGRE8fkzuYE19P4BzBBNjs+GOqaHl31cAznCEZMsRqDikQkTwDJclPuKCvxV
         kmxmrEI4FfjSSPAK5el+JyX7Hj1ZqafjYSIjdKPhGDhpAMZDyhpvvBv0wjDJRI2gXsaV
         ekGOhI3vLetimUVdXqmZTzeAxc7HUExrhEQoRc2Vs4Ips6kQQ/pBnxkN2I0ZLJPdeW+t
         EH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koOwKzeH7/Gb78FEuOvCok9kPJwObv2S7DVJdDdOgNA=;
        b=Axf7HjDv5cfjksAAypCKQcOy9oa79Uosc7QYq3HUy/UYL1XU8dm5UuN3Lh52TEDW/Q
         fSXtwXsFJAnMPRRdbAMtC4WJW14FmN33n1AqoTyRYES52W/m0hEQSz3b7YUKWfCwD6ND
         +GPURdLHrH/hU0tOXn5ti1PKKeLfThCDjjOT8ifIck9llLpfQy5sI6gbej47yQ4KZyCW
         TfpJuLvtj9ZabZM/FZ+j28oFSta4Se7uSi5GGSXc0jXHu0MT4bcWbLVuMS9MNxs3YrdT
         zRONnrIRV9xmH29wOoxgAuoXmiBpfIVRgoNS48qquzyOffquqqEVY+9hoIlcXeFyn5Kg
         ZN1g==
X-Gm-Message-State: AOAM533wsFGhmQ8o0HlV7DWZOl5nMBaOUIsQjwgZu6dTscLTztvsePsf
        Msk/RyJ+i4o1sBY3boA3uX4aVtu3k6Gogcwvn9BCLA==
X-Google-Smtp-Source: ABdhPJxYpCGSJ97h8+PYs4ql8r4Wi52kEXKqBk5pvfZj6f9b/g73lOi4fZfqGVy147NfKJkJXNKE6/edp4TkHfyblNY=
X-Received: by 2002:a25:ad18:: with SMTP id y24mr1012325ybi.420.1644873327127;
 Mon, 14 Feb 2022 13:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com>
 <20220211161831.3493782-7-tjmercier@google.com> <Ygdfe3XSvN8iFuUc@kroah.com>
 <CAHRSSEwoJ67Sr_=gtSaP91cbpjJjZdOo57cfAhv3r-ye0da7PA@mail.gmail.com>
 <CAJuCfpHf=Ewm0e9kguY3MEGVHU_cyviVXByi0oQtq7kTtOOD=A@mail.gmail.com>
 <CAHRSSEzsn-EVKXTRfmpbPR9u0wNpdvdZoX64Tm_mB1DQMRSUPQ@mail.gmail.com> <CALAqxLVeLsv9ESCL2EoZQ8-tRgp0V+tmdYbkyakFetf=ewTH+A@mail.gmail.com>
In-Reply-To: <CALAqxLVeLsv9ESCL2EoZQ8-tRgp0V+tmdYbkyakFetf=ewTH+A@mail.gmail.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Mon, 14 Feb 2022 13:14:51 -0800
Message-ID: <CA+wgaPM8AmQ4g6pDSwRABtc7hq11XMw+kH-rRkB8xNGJhM3OKA@mail.gmail.com>
Subject: Re: [RFC v2 6/6] android: binder: Add a buffer flag to relinquish
 ownership of fds
To:     John Stultz <john.stultz@linaro.org>
Cc:     Todd Kjos <tkjos@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "T.J. Mercier" <tjmercier@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:37 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Mon, Feb 14, 2022 at 12:19 PM Todd Kjos <tkjos@google.com> wrote:
> > On Mon, Feb 14, 2022 at 11:29 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > On Mon, Feb 14, 2022 at 10:33 AM Todd Kjos <tkjos@google.com> wrote:
> > > >
> > > > Since we are creating a new gpu cgroup abstraction, couldn't this
> > > > "transfer" be done in userspace by the target instead of in the kernel
> > > > driver? Then this patch would reduce to just a flag on the buffer
> > > > object.
> > >
> > > Are you suggesting to have a userspace accessible cgroup interface for
> > > transferring buffer charges and the target process to use that
> > > interface for requesting the buffer to be charged to its cgroup?
> >
> > Well, I'm asking why we need to do these cgroup-ish actions in the
> > kernel when it seems more natural to do it in userspace.

This was our plan originally i.e. to create a cgroup interface that
userspace could use for explicit charge transfer. However, in our
initial discussions with all interested parties and cgroup maintainers
we reached a conclusion that an explicit charge transfer UAPI for the
cgroup controller did not fit in with the current cgroup
charge/uncharge mechanisms. Like John mentioned, the charge transfer
during binder IPC was suggested by Daniel during LPC.

Regards,
Hridya

> >
>
> In case its useful, some additional context from some of the Linux
> Plumber's discussions last fall:
>
> Daniel Stone outlines some concerns with the cgroup userland handling
> for accounting:
>   https://youtu.be/3OqllZONTiQ?t=3430
>
> And the binder ownership transfer bit was suggested here by Daniel Vetter:
>   https://youtu.be/3OqllZONTiQ?t=3730
>
> thanks
> -john
