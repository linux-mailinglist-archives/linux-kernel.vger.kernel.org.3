Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CE34B788E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbiBOUag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:30:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBOUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:30:35 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12160D64C8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:30:24 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y6so59729235ybc.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRjg0qk9vV87dyI9lyCi9FXx3ENAAnG458Hs0Q58UVg=;
        b=pxuEh8vUdbhQf1LELZsY0LeBJcvY+4zvlI9aChylje5FbF034p/fi3aL/X769/DMyE
         M+9j6uAVGQYhUtlbmvOWTaCvagb38iu2vWuD6OBL4nMepE8mVnbLSPi/ap8RF2zVvu0g
         2jTgy7h3a51suONhrViTHnTagzVNAl/KNw026jfHNgVoGn5aI70Hp/kQd2/TUbElPnT/
         f6r/9o1TjKKqh1o5a6eJctb5FuPI3kbTgh6oL9UsikNZLrvfot4fGgTRKncHPBi92TGI
         kJItxxZmK7ELEFkMvovx2wMTrZnP+4EHgCus7gHDQZ15HbxCRIZatBX7/NP4bRda7/ab
         AX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRjg0qk9vV87dyI9lyCi9FXx3ENAAnG458Hs0Q58UVg=;
        b=bUd2oosnedAQEKN7NlpfPK4XOnqwtrVnI9FEIIm4rH/50TbqgY8iraenH7fFYFX+/o
         41mqRIw3b8lqyYrw+TZNUJ27+cUQCeZRxNRdB7/NEYknhPI493Ub+TGNiFLt//2+rd7P
         ekVejlV7oAsdiNzLjcbFHQZ8lchOCsoC1FNaaAdsNUt3pI85fj3zGQyXvNgzQFGGz/m/
         WQ4DA1VgOUDhphxA3HTXIhkV27cEIrnyzBXRXdbJi1CsXhUsnNBsvbS908FX2WJVjXOo
         hJMvgrmfqMEXguiwatr8gR9MkaF1BHhit/MPrD/qNyHbzLeg41eurfhGZeZLyTnkbj93
         dOHQ==
X-Gm-Message-State: AOAM531mNN9+BhP7gvCstCQhGbBAbBzLY16lmrwH8srtOB0Oy9QHsCWQ
        Ccc94xXrSuLX7EKJNGZ/ZKVCaOSB+uWaUeV5zFYxzg==
X-Google-Smtp-Source: ABdhPJw7EkF1pN4PINiRbGc7VCCCm0fFXLN5PUwYlG+x3zRIffiAhWddyBvAph0kkRdZoyR8vuO62gRAyp1M3kuqe0s=
X-Received: by 2002:a81:c541:: with SMTP id o1mr587836ywj.507.1644957023067;
 Tue, 15 Feb 2022 12:30:23 -0800 (PST)
MIME-Version: 1.0
References: <00000000000072ef2c05d7f81950@google.com> <CAHbLzkpr=xHC7C2+wkOGUB24924T4L1Lx_v+m1Ke8Ku3ym7wYw@mail.gmail.com>
 <Ygt5cAS78BFxVwkg@dhcp22.suse.cz> <CAJuCfpGf8HLh=tfrnK3VFd2QO9bgzuM9HyDY8PYYxJkbdbmYRA@mail.gmail.com>
 <CAHbLzkpKGq8XaLx3G1=oJ-TsZiqC+A+CaVK5=Mjzo1Jo0qA3DQ@mail.gmail.com>
 <CAJuCfpE833u+Z909yaLgGEJV7O10fVw-_eG1nH=w4b3+PbxrLg@mail.gmail.com>
 <YgwApdvLhxFU26j5@dhcp22.suse.cz> <CAJuCfpGixCqZDAqokxCrQ1YjMb+32Y77U5jHkULKM0htnR19MQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGixCqZDAqokxCrQ1YjMb+32Y77U5jHkULKM0htnR19MQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 15 Feb 2022 12:30:12 -0800
Message-ID: <CAJuCfpF0-xm-RzUmaA6uHQ974tGtg4F8jzTTOFbBLM8iUy4nFA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __oom_reap_task_mm
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        syzbot <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
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

On Tue, Feb 15, 2022 at 11:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Feb 15, 2022 at 11:36 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 15-02-22 10:10:53, Suren Baghdasaryan wrote:
> > > On Tue, Feb 15, 2022 at 9:53 AM Yang Shi <shy828301@gmail.com> wrote:
> > [...]
> > > > Isn't the below race possible?
> > > >
> > > >           CPU A                                     CPU B
> > > > exiting:
> > > >   mmap_write_lock
> > > >   remove_vma()
> > > >   mmap_write_unlock
> > > >                                                 process_mrelease:
> > > >                                                   mmap_read_lock
> > > >                                                   __oom_reap_task_mm
> > > >                                                   mmap_read_unlock
> > > >
> > >
> > > Sure, that sequence (would not call it a race) is possible but in this
> > > case __oom_reap_task_mm will find no vmas in the mm because exit_mmap
> > > freed and removed all of them.
> >
> > I didn't really have chance to have a closer look but I do not see
> > exit_mmap doing mm->mmap = NULL so the pointer can be a freed vma unless
> > I am missing something. I thought we've had it in your patches? Has this
> > got lost somewhere in the process?
>
> Doh! Yes, it looks like I completely missed the actual pointer. That
> must be it since I don't see any other possibility. Will post a patch
> shortly.

Fix posted at https://lore.kernel.org/all/20220215201922.1908156-1-surenb@google.com/

> Thanks!
>
> > --
> > Michal Hocko
> > SUSE Labs
