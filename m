Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2391758978D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiHDFwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbiHDFwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:52:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64A37191
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:52:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f22so12976008edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ycPE2Cu6aU1QIKtvU9pwb7W6byoSfFvVJ1sdHjuliz0=;
        b=HzswFvQeQsQn9alrwZKXZKVRit/CaeV8RbluY0O/DRYlsRbfuXQnL1uL8uWRVB0Omj
         khkn4DA6JrOZLPQPHV4OFhFXjyG0QuT8m3iDgSi5gcXuB0JdJrHF/SczsGMCKtVc3YXH
         3dswerDAZseU3dJdTTbsaxCOgB/7l6aQsraS0744fUkhph8pM3tKVGXSOpvrw90/GklO
         sgGucl390L5rNGJkp+HgIEf+dAn94TcNd71N8OoXe7ZHxUT+VDq2kUu0mdRW0lzAwD5z
         9eWMAIeI6M4wEbMTS+H3KzY7BZQ1iY1Jy2MC4CmwnoWo0x7Z3D0/2rlzmF5cWy0W/0Kx
         lAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ycPE2Cu6aU1QIKtvU9pwb7W6byoSfFvVJ1sdHjuliz0=;
        b=6c6HDmPA6cfEp0R+yQhBnVybcI2e1ZuUqpMP2pC5Apr4w5UJxQNqC8Oeu0FlkvCj97
         5rEH5lRhvnPzDwODAHQzjjfXveQZ/VaMdS2plgLJvwY0VKBtUaDO6QoeTQewCfSACGk7
         uW2bzLShyfIByx+j1weIXL/F4BHwVi6RnqERetF6utZ4uTOOc0ohifSkPPlZelv3SkTY
         ITq9tX5eSlC8MFmn7CZSqt8xpcopARMmRBzmB/0fAdrGzK5tLkJMRRPDjg2wLvRJqKp5
         wa8gki/TTcLt03tpISyd7GLhXGwozcaJutANyaLAgMjAZMQQET95XNBlzR813E4Mhpna
         Am3A==
X-Gm-Message-State: ACgBeo04qAuZWQR2MqFWl9FnQu90nub0AvyDAlB6K8umF1QkKJZcnn/y
        ALneBTH4dKrjP1223kh9TdlzjJwD+FZU/PtDgsE=
X-Google-Smtp-Source: AA6agR4aEuVjdYTMIi8ac+Iz6qf8aed84F8hlkR46UR6fpb5wbCPkpqpsKl5eJFrYNj6fAQX4RccW8dPPcARAriLBuI=
X-Received: by 2002:a05:6402:249b:b0:43c:8ce6:8890 with SMTP id
 q27-20020a056402249b00b0043c8ce68890mr355130eda.74.1659592356779; Wed, 03 Aug
 2022 22:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
 <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
 <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com>
 <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com>
 <CAPM=9txkjJg5uArn1ann7Hf+JFCukQFGwqv+YHAx97Cdxezs_Q@mail.gmail.com>
 <CAHk-=whWcektQzPJgSPa2DC3wMPxgLh8fJVQWeo8i99XMXPjfg@mail.gmail.com>
 <CAPM=9twUvRoVcWHhBH7yuDDVj8K8aM0APQ8Yx3cx19keLJP8Gg@mail.gmail.com>
 <CAHk-=wjbfAuN1eV+F0wWFsWEaMmJsT2p3DXnUvxo7bQ-xJwKCQ@mail.gmail.com>
 <CAHk-=wih3NEubvTye4URZOmLYu6G+ZT9cngepo0z++ogCWUymQ@mail.gmail.com> <CAPM=9twRb4c62e0mU9CwOTAYMkR6YCRR5=KLTrSKoLbJ7RB9xw@mail.gmail.com>
In-Reply-To: <CAPM=9twRb4c62e0mU9CwOTAYMkR6YCRR5=KLTrSKoLbJ7RB9xw@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 4 Aug 2022 15:52:25 +1000
Message-ID: <CAPM=9txwzNZgUCJUTxww3hYmTnbrNH-2zdjxamxB4=yW9sFHxQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 at 15:25, Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 4 Aug 2022 at 14:46, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Aug 3, 2022 at 9:27 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > I'll do a few more. It's close enough already that it should be just
> > > four more reboots to pinpoint exactly which commit breaks.
> >
> > commit 5d945cbcd4b16a29d6470a80dfb19738f9a4319f is the first bad commit.
> >
> > I think it's supposed to make no semantic changes, but it clearly does.
> >
> > What a pain to figure out what's wrong in there, and I assume it
> > doesn't revert cleanly either.
> >
> > Bringing in the guilty parties. See
> >
> >   https://lore.kernel.org/all/CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com/
> >
> > for the beginning of this thread.
>
> I think I've tracked it down, looks like it would only affect GFX8
> cards, which might explain why you and I have seen it, and I haven't
> seen any other reports.
>
> pretty sure you have an rx580, and I just happen to have a fiji card
> in this machine right now.
>
> I'll retest on master and send you a fixup patch.

To close the loop

https://lore.kernel.org/all/20220804055036.691670-1-airlied@redhat.com/T/#u

Seems to fix it here.

Dave.
