Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E982B5A7A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiHaJlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHaJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:41:10 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30008F95A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:41:06 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id o12so2204303vkn.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=H8I52gPNPVJrjSXFrBrthY/mEoKoCdNI9xLIW6uiQAo=;
        b=RmqVJSYxWksJR/0krMxdP2/erN7GsGomo+62ATiUwnPwroCqeWj+mwmS95PgcKwEDF
         jPTc+WqR4L3WEIJJceFutF4ZvV7VIFh/te3peDR4XY+7NTDYFoVuWAYWwpfgssqCVj2w
         ew1uMTMT11WW7eCobbZgpv+0DBiOuriBz9v6j9/As1TDEACv5+eAIb8m31avfgoAAKPY
         IGYUZFF4zK2gEfyD7yeHzDl6rkDXp5E9ePEfgzzR32vOu5PJUF8p0jq5QrfiIIjAmfS4
         1zJScAHU4QQ8ZtNvvGOSt6zuZW8/dznOw4cBDpIrTdcueCvYqFzpucqfzmZwftCDOVAS
         9dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=H8I52gPNPVJrjSXFrBrthY/mEoKoCdNI9xLIW6uiQAo=;
        b=CNmt6CgopKkZ5chwnIVq536920K81/lfJA8jLUEJJKZvj5ue/x8LBdG15RZl9eocjN
         9MM8TZnTWoMLyhq0hVzW0Qyb4OtTnKMnpECjOX+qHZObEFsnSu3yAHB9011a96j+UAAB
         k+BQ5FaqIUMgce4aRdCGXzD9vTTytzHvXQp70A6EIPbLxJOtQiqb7QpYLZCvKAMgdPC5
         bstAG9r1O+jBpqotgGQkGK4CdCbD4AQTC5x5lIc/63hgheUmsbyXS5ZECQd+CQ1Q8VVi
         kB0wxyg0vkzqa8XP6mP9M6UhRfOgeuAf6XXWVn7lKM6/tqF1aJKZCxS7Bw0vz/3i/ssh
         CbjQ==
X-Gm-Message-State: ACgBeo0oh18CMM8t2eZxVbNWSO8cq0n2JO2kvJFX6TIHdmB3o3OdH/vy
        Of/Yuk1UzDIYCR/gN4p6LbfUMp8d3IUVIln6d11MwA==
X-Google-Smtp-Source: AA6agR7m2IqkYQg1r6P55MJEV7W9yiHksf53dzKw1v+1lTnKHiAD3I7MJmnyzMzHPLO4TIaqD27aT11ApVx6ZFD+ZyA=
X-Received: by 2002:a1f:bd0e:0:b0:394:9da0:2449 with SMTP id
 n14-20020a1fbd0e000000b003949da02449mr2239474vkf.4.1661938865760; Wed, 31 Aug
 2022 02:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002c73fd05e6ba3e0b@google.com> <20220821013246.a706fa7c2d8cb494efdba02e@linux-foundation.org>
 <0004c00e-e50f-5dcf-20f9-1b8da0822bfd@nvidia.com> <20220821163120.df7d936c9f47b6dc875ab763@linux-foundation.org>
 <761793f4-cd16-fcc1-8777-f7e032604e1e@nvidia.com>
In-Reply-To: <761793f4-cd16-fcc1-8777-f7e032604e1e@nvidia.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 31 Aug 2022 11:40:54 +0200
Message-ID: <CANp29Y6Wk21aqLjJ2ygTykZgqZ+3=1kQks6cTYrB_=TVRQqghw@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in vma_is_shmem
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com>,
        hughd@google.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
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

Let's tell syzbot about the fix

#syz fix: mm/gup.c: Fix return value for __gup_longterm_locked()

On Mon, Aug 22, 2022 at 2:10 AM 'John Hubbard' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On 8/21/22 16:31, Andrew Morton wrote:
> > On Sun, 21 Aug 2022 16:18:48 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
> >
> >>> vmas[] array.  We haven't messed with gup.c much this time around -
> >>> just one patch from Alistair ("mm/gup.c: simplify and fix
> >>> check_and_migrate_movable_pages() return codes").  It does touch this
> >>> area, but I can't immediately see how it could newly cause this.
> >>>
> >>
> >> Neither can I, even after looking at both of these recent commits to
> >> gup.c in this branch:
> >>
> >> commit 4d1225cd5560 ("mm/gup.c: simplify and fix
> >> check_and_migrate_movable_pages() return codes")
> >>
> >> commit 0e5d6dac6b65 ("mm/gup: fix FOLL_FORCE COW security issue and
> >> remove FOLL_COW")
> >>
> >> As you say, a bisection would really help here.
> >
> > Might
> > https://lkml.kernel.org/r/20220821183547.950370-1-syoshida@redhat.com
> > save us?
> >
> >
>
> aha yes, that looks right.
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/761793f4-cd16-fcc1-8777-f7e032604e1e%40nvidia.com.
