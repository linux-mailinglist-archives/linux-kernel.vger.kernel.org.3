Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363DD4B7535
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbiBOTnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:43:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiBOTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:43:36 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F263F882
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:43:26 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 124so31274636ybn.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcf+8o+t6+WnOwFW3ZI0zrWbIEyxTwbnoswnCVbg8F8=;
        b=QOKtYm93Mb7Nl3MP7JzAntRwnrHs7RWLTU/tCeRP+GM/Jn80ebbb/qwZx5QaX+mewI
         WUUZuU6nr/9iu5TGPVJhCtVn0+ucVo4HNyV16DQluiaDXFfXynO0wi9IfmRHfy7AMV3Y
         enPQ2mNYTsv5GfwrdbeHMtTUFex+HrNNLZn/CaLxvTvNAGfSnEUEJgzfZM3ql+B1fRKf
         Uwxdzq5t7P7l8ohDBs6ISXllYWkYeAtu9rlf3JopT8ubliFCWgGa3QyOd8tlZIIshh/Y
         beOdvGoM6IwF8SWPlasZQrI4HbcRDD404mYq2HSLETqVVrh8cL4W5EAGq8C3ZQiYQQS/
         VPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcf+8o+t6+WnOwFW3ZI0zrWbIEyxTwbnoswnCVbg8F8=;
        b=RGfXnX9vC6RiCK8tXsrhv9lTZoFsM23fWv9p3oCTXPyKpAjq+SlUHntKjxpMyTkVsZ
         fJIBJP/ii9o/AaRWPKlPafXV1hQR0BC1eomPw1gHc8Bg6nrKI/0l9I4+P/2+LxDwFUKw
         MTt5UsrU8mIz9KIh7uxMxuvaK55YpIphIL7Sfpog9/gkMOiYEX0ewBxvUWLRS7TM3QFW
         fBFbqi8sGHTp9BaFqNBJ4gGtkdid0oUtZV4Ws0s1k2J9opurvG3KEqrTWq1J3zUkSvfx
         AyMUiRPZZTPmS2SWv+mKA/uI1n0DNBLIVrfM78sibEgRSxJEHclC1BJoGDtDD0MjC3he
         hn9A==
X-Gm-Message-State: AOAM531AbMUTR2GEUc3WpDEN64MeGT9GPzekuo0YpbpGpGt3jSL/Zb0K
        OCQMECaBLxhfYpm84q8xDVeT5g6qTodUXHNRWdtIfw==
X-Google-Smtp-Source: ABdhPJw0Ygn9sW+6D5SxaOXJ0cWbKOO0bYs2UrcFSKQtZHUxCfSP7Ewfx33QU+tl0IwKHKZnRZl9PCxf9unHvYZcJTE=
X-Received: by 2002:a25:7a47:: with SMTP id v68mr519462ybc.488.1644954205145;
 Tue, 15 Feb 2022 11:43:25 -0800 (PST)
MIME-Version: 1.0
References: <00000000000072ef2c05d7f81950@google.com> <CAHbLzkpr=xHC7C2+wkOGUB24924T4L1Lx_v+m1Ke8Ku3ym7wYw@mail.gmail.com>
 <Ygt5cAS78BFxVwkg@dhcp22.suse.cz> <CAJuCfpGf8HLh=tfrnK3VFd2QO9bgzuM9HyDY8PYYxJkbdbmYRA@mail.gmail.com>
 <CAHbLzkpKGq8XaLx3G1=oJ-TsZiqC+A+CaVK5=Mjzo1Jo0qA3DQ@mail.gmail.com>
 <CAJuCfpE833u+Z909yaLgGEJV7O10fVw-_eG1nH=w4b3+PbxrLg@mail.gmail.com> <YgwApdvLhxFU26j5@dhcp22.suse.cz>
In-Reply-To: <YgwApdvLhxFU26j5@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 15 Feb 2022 11:43:14 -0800
Message-ID: <CAJuCfpGixCqZDAqokxCrQ1YjMb+32Y77U5jHkULKM0htnR19MQ@mail.gmail.com>
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

On Tue, Feb 15, 2022 at 11:36 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 15-02-22 10:10:53, Suren Baghdasaryan wrote:
> > On Tue, Feb 15, 2022 at 9:53 AM Yang Shi <shy828301@gmail.com> wrote:
> [...]
> > > Isn't the below race possible?
> > >
> > >           CPU A                                     CPU B
> > > exiting:
> > >   mmap_write_lock
> > >   remove_vma()
> > >   mmap_write_unlock
> > >                                                 process_mrelease:
> > >                                                   mmap_read_lock
> > >                                                   __oom_reap_task_mm
> > >                                                   mmap_read_unlock
> > >
> >
> > Sure, that sequence (would not call it a race) is possible but in this
> > case __oom_reap_task_mm will find no vmas in the mm because exit_mmap
> > freed and removed all of them.
>
> I didn't really have chance to have a closer look but I do not see
> exit_mmap doing mm->mmap = NULL so the pointer can be a freed vma unless
> I am missing something. I thought we've had it in your patches? Has this
> got lost somewhere in the process?

Doh! Yes, it looks like I completely missed the actual pointer. That
must be it since I don't see any other possibility. Will post a patch
shortly.
Thanks!

> --
> Michal Hocko
> SUSE Labs
