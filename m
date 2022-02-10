Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2EE4B117F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbiBJPSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:18:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243485AbiBJPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:18:36 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2981B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:18:36 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id bt13so16464165ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSJt8CAQGYy8+Qr3AHVnbVBwslNc59d9Xks8fwy34k4=;
        b=FnBkguaVd+krz0Rmqf9XinS18oXA5REL/KikbJTnfijjYxkKuz3GpqE5OEsEiUpEeO
         3Gszr4f8RsYKtHT86TEo0oXjtCM4KbijQg/JLQM/G3os8sCR6yl9LheQ6HDGYg2M8OOT
         PnB7JKNy4lY16c2ttZArEOhFLXsAvTNjm8oDZ/ubC4f6StCJeqsvcsMBMztW3rb5/4Nn
         vYxuPC+iFrN7VP2ckjfwNIEBG4s8GlwUNfBvoAqtiCx5BQw9gZl2gfVqp4QmwzZ5TKnf
         zVE7TYIkXokjXNZwt8cG2uFtb8ac9Zb0vRr1aMiki2ZXn1gAs20GikT+NwCHDvb5w8ro
         M3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSJt8CAQGYy8+Qr3AHVnbVBwslNc59d9Xks8fwy34k4=;
        b=sLCubkDw8Xm9fjQ391SaayF08ImDhknZ5ntcqtfO9o3yP0n7RAntMgn0+6cvA72bjr
         DclT9RJYxwgLmCJEJXxNZC0EOJyC2L4vKNudmKA7ZMYqSpX5bNRG+S73Ex5aAXxT2uGW
         XVNr6knOwcG2r4l+FAhZXTg77KJB8MF5b043tKvJHDrh9H/GK03QBsMyDK1DHGxghYUk
         V8ei78Xvge3sex7S8z/v3UxgE3IkqCR+bRLE7ZAGIgLAhxBJ9rZPn/P6EDfPD2fVNvmd
         oVjT2FBDw1CH0/vlKefA+l3FFJo2QuMfXF58d77cg/eww/GpPzeaosZsrBp9wUyEbqvv
         qhdQ==
X-Gm-Message-State: AOAM532VUY7rNZYkS7IVm0LrOcBx1rxJlkwhwTVt4fPILrBvGY8T6RF5
        w7+SIxxCFDvPTgQ0yxzRO6g7A95f+T+Ga6i9hWlJ1Q==
X-Google-Smtp-Source: ABdhPJz2b1gN5kCrvKQtWO5ov0VVk5Qmgz0rZFVdfy820O8pdCfysTPmN7H0fwfgqmMeUddkGJPYN0vUDyWr5r951C4=
X-Received: by 2002:a81:7e4f:: with SMTP id p15mr7600216ywn.180.1644506315505;
 Thu, 10 Feb 2022 07:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20220210043215.42794-1-surenb@google.com> <YgUHzSqltDp2dr70@dhcp22.suse.cz>
In-Reply-To: <YgUHzSqltDp2dr70@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Feb 2022 07:18:24 -0800
Message-ID: <CAJuCfpGkW7MoWW=E1tqEib24M3JjxDKF_zgmMnvWo8wJP6cy2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        Chris Hyser <chris.hyser@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Collingbourne <pcc@google.com>, caoxiaofeng@yulong.com,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

On Thu, Feb 10, 2022 at 4:40 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed 09-02-22 20:32:15, Suren Baghdasaryan wrote:
> > When adjacent vmas are being merged it can result in the vma that was
> > originally passed to madvise_update_vma being destroyed. In the current
> > implementation, the name parameter passed to madvise_update_vma points
> > directly to vma->anon_name->name and it is used after the call to
> > vma_merge. In the cases when vma_merge merges the original vma and
> > destroys it, this will result in use-after-free bug as shown below:
> >
> > madvise_vma_behavior << passes vma->anon_name->name as name param
> >   madvise_update_vma(name)
> >     vma_merge
> >       __vma_adjust
> >         vm_area_free <-- frees the vma
> >     replace_vma_anon_name(name) <-- UAF
> >
> > Fix this by raising the name refcount and stabilizing it. Introduce
> > vma_anon_name_{get/put} API for this purpose.
>
> What is the reason that madvise_update_vma uses the naked name rather
> than the encapsulated anon_vma_name? This really just begs for problems.

The reason for that is the second place it's being used from the prctl syscall:

prctl_set_vma
  madvise_set_anon_name
    madvise_vma_anon_name
      madvise_update_vma

In that case the name parameter is not part of any anon_vma_name
struct and therefore is stable. I can add a comment to
madvise_update_vma indicating that the name parameter has to be stable
if that helps.

> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
