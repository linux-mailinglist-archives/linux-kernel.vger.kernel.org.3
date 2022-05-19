Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA252DCE9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbiESSex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiESSet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:34:49 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9718056F90
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:34:48 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2fefb051547so65719307b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sHh+aeOcshksAeWEKoIXMy64MvU5klwb4zgLRhptiQ=;
        b=phgG1zFV85lfVsNRqOlr+jqMp71gt6ziGjyYLUM90kApzwoI3ReHJeVLTkcgWezVjx
         gVB7DMH9h0mBSpxc1/BQhfTOtgAyoK7sf6Nf3Mn8Jy+70R+fQa+6G/7S48XE1qo2kpOy
         U+y6b+r8NCjPB824HZfUKnodEa1yZ2vSLeMNUqKROIhqjIH4+ufXIzfm2S5Km+nHrk3q
         2VqysAjw4rgxaLfPmG8vWXFghm7732u591qv51EvCe1UMYb6EUwfmDoP/3k4Un32bK1B
         2vIR2hnSYAbE4fwcPPKWXwycuacHkZPR1GKD2cg4LbVoHhridUCWwHwSBCq0ddoDyI6X
         d4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sHh+aeOcshksAeWEKoIXMy64MvU5klwb4zgLRhptiQ=;
        b=b6jjIGtHMDxikhW38x54Zdse+ymP8hUzXf0BVtB3Lv5QQ810vq/dohqIsQ2hWU7bM/
         IV4dD2+5ApdZthSsbpg3iqi+dG0nWoA0Plkb4aR2ecRqmtbV5Qxlxn6kkjBn9cUQjWau
         auQNWyrREkaqbwaGlaDGUIa+7EyW6yBk52xB8h8Q1kEht22QFWaLuDrihd1ZX7Jb7VCA
         4D5u+fO4Y7jNRRGntWTNu/ee9wFKeeEop26ubfiXPl2uN4LA/Fteu8e/L06PJe6eFZ0m
         97pGYKhzZdK07FFbxzKlhpYIaFNtrRjSeiMUg75SilWlHHbTdy4DFuQMW0FYEhY6qDAZ
         X0Dg==
X-Gm-Message-State: AOAM5316VHW1+8PoeTuk+PyIOiQpCafMAjPk/oaW2aPYGpLTjRx7Lyhv
        C8NWkHiGYBtnBTFg8quKThexqxZMH1gkJMKWtYQDXg==
X-Google-Smtp-Source: ABdhPJxYVtAEG2Zu0y7At+Od5LAp6r0pSbqx60CulpdFDToh9gVC+6wU0Df8LKe6cewfujtI9pE+iWwdmx14f9qISvM=
X-Received: by 2002:a81:990f:0:b0:2f8:c347:d11a with SMTP id
 q15-20020a81990f000000b002f8c347d11amr5910848ywg.507.1652985287640; Thu, 19
 May 2022 11:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220516033524.3130816-1-chenwandun@huawei.com>
 <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com> <CAJuCfpE7fBsp8ntYVeLsW7Cd0Z09OmxN75X9Az_Qco0GJrz3Wg@mail.gmail.com>
 <CAJuCfpH-BDqsft1YvGFhkbR60VC0TJgfXKRVN+80e0iqQdhxpA@mail.gmail.com>
 <3a31521f-a68a-b2a9-baae-9a458ee17033@huawei.com> <070fe87d-43a0-5e4f-e4c7-c44782c2c195@gmail.com>
 <CAJuCfpH1mTxe5hmzZTe+AbPFse9heenx8uhGzCXE6fAh5G8SzA@mail.gmail.com> <29d66a46-d141-2d02-45dd-a8931786588e@gmail.com>
In-Reply-To: <29d66a46-d141-2d02-45dd-a8931786588e@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 May 2022 11:34:36 -0700
Message-ID: <CAJuCfpHpntz-viUQ+hAAWAkSSow7-TStr+yB3UEvqQ1WhAR22g@mail.gmail.com>
Subject: Re: [PATCH 1/2] psi: add support for multi level pressure stall trigger
To:     Alex Shi <seakeel@gmail.com>
Cc:     Chen Wandun <chenwandun@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
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

On Wed, May 18, 2022 at 11:15 PM Alex Shi <seakeel@gmail.com> wrote:
>
>
>
> On 5/19/22 05:38, Suren Baghdasaryan wrote:
> > On Wed, May 18, 2022 at 3:29 AM Alex Shi <seakeel@gmail.com> wrote:
> >>
> >>
> >>
> >> On 5/17/22 20:46, Chen Wandun wrote:
> >>>>>> This breaks the old ABI. And why you need this new function?
> >>>>> Both great points.
> >>>> BTW, I think the additional max_threshold parameter could be
> >>>> implemented in a backward compatible way so that the old API is not
> >>>> broken:
> >>>>
> >>>> arg_count = sscanf(buf, "some %u %u %u", &min_threshold_us,  &arg2, &arg3);
> >>>> if (arg_count < 2) return ERR_PTR(-EINVAL);
> >>>> if (arg_count < 3) {
> >>>>      max_threshold_us = INT_MAX;
> >>>>      window_us = arg2;
> >>>> } else {
> >>>>      max_threshold_us = arg2;
> >>>>      window_us = arg3;
> >>>> }
> >>> OK
> >>>
> >>> Thanks.
> >>>> But again, the motivation still needs to be explained.
> >>> we want do different operation for different stall level,
> >>> just as prev email explain, multi trigger is also OK in old
> >>> ways, but it is a litter complex.
> >>
> >> In fact, I am not keen for this solution, the older and newer
> >> interface is easy to be confused by users, for some resolvable
> >> unclear issues. It's not a good idea.
> >
> > Maybe adding the max_threshold as an optional last argument will be
> > less confusing? Smth like this:
> >
> > some/full min_threshold window_size [max_threshold]
>
> It's already confused enough. :)
> BTW, I still don't see the strong reason for the pressure range.
>
> > > Also, if we do decide to add it, there should be a warning in the
> > documentation that max_threshold usage might lead to a stall being
> > missed completely. In your example:
> >
> > echo "some 150000 350000 1000000" > /proc/pressure/memory
> >
> > If there is a stall of more than 350ms within a given window, that
> > trigger will not fire at all.
>
> Right.
> And what if others propose more pressure combinations?
> Maybe leave them to user space is more likely workable?

Ok, sounds like userspace can handle the situation of multiple
triggers firing. Let's keep it simple as it is now, until we see a
strong need or convincing performance numbers for adding this new
trigger attribute.
Chen, if you can provide reasons why a userspace solution would be
prohibitive I would be happy to reconsider.
Thanks,
Suren.

>
> Thanks
> Alex
