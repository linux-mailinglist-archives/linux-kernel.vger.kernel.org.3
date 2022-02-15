Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C59A4B7629
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbiBOTgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:36:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbiBOTgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:36:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB766C24A2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:36:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 921C51F382;
        Tue, 15 Feb 2022 19:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644953769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ii5TNPWsUIAw9A7FnVbIdGfffp+xa+Xc1AZj2a+jkto=;
        b=ii/Z6CGN1NybTstlvc1PJeSPlw7jeLLEf4yJ0N3iydUQMZ4W73O1hjmYbZOJJ3kmcxketp
        WxSLGwC0YW0ZrK1j/Bh/BmTt8TX9AyDJHjOWSvrUTqnvov20ZM+kUynCs0Vk+sHIPeS0eD
        MHOIc0TRYJnf1ZAf3AYyfDnSTGsmQtU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 62467A3B83;
        Tue, 15 Feb 2022 19:36:09 +0000 (UTC)
Date:   Tue, 15 Feb 2022 20:36:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        syzbot <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __oom_reap_task_mm
Message-ID: <YgwApdvLhxFU26j5@dhcp22.suse.cz>
References: <00000000000072ef2c05d7f81950@google.com>
 <CAHbLzkpr=xHC7C2+wkOGUB24924T4L1Lx_v+m1Ke8Ku3ym7wYw@mail.gmail.com>
 <Ygt5cAS78BFxVwkg@dhcp22.suse.cz>
 <CAJuCfpGf8HLh=tfrnK3VFd2QO9bgzuM9HyDY8PYYxJkbdbmYRA@mail.gmail.com>
 <CAHbLzkpKGq8XaLx3G1=oJ-TsZiqC+A+CaVK5=Mjzo1Jo0qA3DQ@mail.gmail.com>
 <CAJuCfpE833u+Z909yaLgGEJV7O10fVw-_eG1nH=w4b3+PbxrLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE833u+Z909yaLgGEJV7O10fVw-_eG1nH=w4b3+PbxrLg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-02-22 10:10:53, Suren Baghdasaryan wrote:
> On Tue, Feb 15, 2022 at 9:53 AM Yang Shi <shy828301@gmail.com> wrote:
[...]
> > Isn't the below race possible?
> >
> >           CPU A                                     CPU B
> > exiting:
> >   mmap_write_lock
> >   remove_vma()
> >   mmap_write_unlock
> >                                                 process_mrelease:
> >                                                   mmap_read_lock
> >                                                   __oom_reap_task_mm
> >                                                   mmap_read_unlock
> >
> 
> Sure, that sequence (would not call it a race) is possible but in this
> case __oom_reap_task_mm will find no vmas in the mm because exit_mmap
> freed and removed all of them.

I didn't really have chance to have a closer look but I do not see
exit_mmap doing mm->mmap = NULL so the pointer can be a freed vma unless
I am missing something. I thought we've had it in your patches? Has this
got lost somewhere in the process?
-- 
Michal Hocko
SUSE Labs
