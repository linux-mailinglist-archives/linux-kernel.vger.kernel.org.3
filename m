Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43C74C16CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbiBWPaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiBWPaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:30:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5400B5BD3C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:29:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C04221F43D;
        Wed, 23 Feb 2022 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645630170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E2Ysk5tw3y+Z5+1IoQiOmaQ/uiKURVbh89m7BIZflSo=;
        b=uoCq9+UdexkM9UoY7W3hzi6DwNmGBlXOBrHYEOjcsBLd0zy/iGwcKR7Gkc6yC/AbN48Xdz
        EBBNRhm2+rYWB/kp4Wi0y09ygodWYvcgrPlGJ3hvuRXNuDv7VPEemd1miW/rE9KiWoXqxB
        ELm1hb9ZrWLnOqrcNKD+xYTvHUaS8O4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CCAE5A3B85;
        Wed, 23 Feb 2022 15:29:27 +0000 (UTC)
Date:   Wed, 23 Feb 2022 16:29:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 3/3] mm: fix use-after-free when anon vma name is used
 after vma is freed
Message-ID: <YhZS1A9wKQ8Aryin@dhcp22.suse.cz>
References: <20220222054025.3412898-1-surenb@google.com>
 <20220222054025.3412898-3-surenb@google.com>
 <YhSZhzUYlW6IAQT9@dhcp22.suse.cz>
 <CAJuCfpELxJ=7uuurKL9oRn1E_=rfL3aN8Duhqvi4Z2c1xHAT2w@mail.gmail.com>
 <YhX2mkb327KkZR2/@dhcp22.suse.cz>
 <CAJuCfpE+dpCmA6sRQJBanRP2uJiQHGdoGGjvkhL_GqxRdY9aCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE+dpCmA6sRQJBanRP2uJiQHGdoGGjvkhL_GqxRdY9aCg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-02-22 06:10:54, Suren Baghdasaryan wrote:
> On Wed, Feb 23, 2022 at 12:55 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 22-02-22 07:43:40, Suren Baghdasaryan wrote:
> > > On Tue, Feb 22, 2022 at 12:06 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 21-02-22 21:40:25, Suren Baghdasaryan wrote:
> > > > > When adjacent vmas are being merged it can result in the vma that was
> > > > > originally passed to madvise_update_vma being destroyed.  In the current
> > > > > implementation, the name parameter passed to madvise_update_vma points
> > > > > directly to vma->anon_name->name and it is used after the call to
> > > > > vma_merge.  In the cases when vma_merge merges the original vma and
> > > > > destroys it, this will result in use-after-free bug as shown below:
> > > > >
> > > > > madvise_vma_behavior << passes vma->anon_name->name as name param
> > > > >   madvise_update_vma(name)
> > > > >     vma_merge
> > > > >       __vma_adjust
> > > > >         vm_area_free <-- frees the vma
> > > > >     replace_vma_anon_name(name) <-- UAF
> > > >
> > > > This seems to be stale because bare const char pointer is not passed in
> > > > the call chain. In fact I am not even sure there is any actual UAF here
> > > > after the rework.
> > > > Could you be more specific in describing the scenario?
> > >
> > > Yes, sorry, I need to update the part of the description talking about
> > > passing vma->anon_name->name directly.
> > > I think UAF is still there, it's just harder to reproduce (admittedly
> > > I could not reproduce it with the previous reproducer). The scenario
> > > would be when a vma with vma->anon_name->kref == 1 is being merged
> > > with another one and freed in the process:
> > >
> > > madvise_vma_behavior
> > >    anon_name = vma_anon_name(vma) <-- does not increase refcount
> > >    madvise_update_vma(anon_name)
> > >      *prev = vma_merge <-- returns another vma
> > >        __vma_adjust
> > >          vm_area_free(vma)
> > >            free_vma_anon_name
> > >              anon_vma_name_put
> > >                vma_anon_name_free <-- frees the vma->anon_name
> > >      vma = *prev <-- original vma was freed
> >
> > How come this is not a UAF in the first place?
> 
> Sorry, I got you confused. The original vma that was passed as a
> parameter to vma_merge(vma) was freed and vma_merge() returns the area
> it was merged with:
> 
>     *prev = vma_merge(vma_a) <-- vma_a is merged with adjacent vma_b,
> vma_a is freed and vma_b is returned
>     vma = *prev <-- "vma" now points to vma_b

OK, I see the problem now. Essentially if we have two adjacent vmas
which have the same name but wrapped by two anon_vma_name instances
and we merge them together then the first one can be freed along with
its anon_vma_name which is still used by replace_anon_vma_name.

Thanks for the patience.
-- 
Michal Hocko
SUSE Labs
