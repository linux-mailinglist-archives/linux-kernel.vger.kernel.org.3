Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48194B1696
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbiBJTwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:52:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiBJTwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:52:51 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C6FE4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:52:51 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 192so18557868ybd.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzF5sCY7uSZwHV5WGzzKAf4z/VWvg0ici6ENvRgYqC4=;
        b=Epfrw6WyAWC6gEZYIY7Jz86oAY2LmjJS6xb2zSKqlpEC2QM/ZW3m6mH+eKxTicJHjH
         O8IdU+pWTHmJ6fZ4ryiKLoSe+A5mRsM9rzDgPELClfrUpnsAUkYOJABk1mzHWQD5ZmbL
         ExjGBKuABxj5PiwJkSAkK0/5YOzsiywo7FlBm6UNRNrJtEqkhulNeoS/Bf0tm1IEqiyc
         XyKcrVtjMwPEIuJKcNLeAoYVXGy3ewbx19QVB6Ss16CLPjcUH4mqh2/Iv1DluoFPxDRP
         Xa4J4/Ly9sBGu2rKuqcurrVscY9Z5xPumH3xaMuBxreyji30rI1VyJ0HT3p5C9Lzi4bJ
         CWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzF5sCY7uSZwHV5WGzzKAf4z/VWvg0ici6ENvRgYqC4=;
        b=bCskejn9XO50rNFb/sO5d7VzjBKiTZWT9zWtCndJ8rUyWV0UHNgl60uCfF6wAVgr24
         cMBK1DWNkNjNrjfWila4JNnte+mibq006w3HjGNzRgFM4OPJIFT9xdigkUJO6nwNUYFY
         bRDJDsnfIUrNtdJCsxip2Ofp7qZCdFyvm5LZKwVIh6CbbhAncQYUAFvdZ+xa6iY3LmBj
         gNgfVwE+ZuO2iCg+cjkP2tYbjUR65LdSYhMInCmUNP5tbAO/ZPKl/yba98DOQpByp2Lt
         q26lOTB3yZEVWXPOPWDp1rG6i45G87Igq5qUa8pVQv3+QXC5vr7EzFNiZzcbI9R730wd
         +VDA==
X-Gm-Message-State: AOAM532iKNfrIU3f47mS663WWVBt7QYpzZZVH61SBiF/chyrKSm2CUI7
        b4enB2m5XPGwS36QtfthutydXQ7UFx+NNP3Aw2UpAA==
X-Google-Smtp-Source: ABdhPJwJKjzNrf7IrOnDOsPDe5QoC9e9IfeU+Wu0eDgNzJWLBh/Y7A11hRrhEy9HcUj0K2Lq9B4Uq9aJcb/qP3061gI=
X-Received: by 2002:a25:6a55:: with SMTP id f82mr8235453ybc.1.1644522770377;
 Thu, 10 Feb 2022 11:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20220210043215.42794-1-surenb@google.com> <YgUHzSqltDp2dr70@dhcp22.suse.cz>
 <CAJuCfpGkW7MoWW=E1tqEib24M3JjxDKF_zgmMnvWo8wJP6cy2g@mail.gmail.com>
 <YgUu0prRt3iu1Cpy@casper.infradead.org> <CAJuCfpHPZNbK2rd95pZAWr0d3vACGzHdiAFv=bM-G8nC+YdYwg@mail.gmail.com>
 <YgVo5HrAhoeoix7a@casper.infradead.org>
In-Reply-To: <YgVo5HrAhoeoix7a@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Feb 2022 11:52:37 -0800
Message-ID: <CAJuCfpHX22MaU8S0otoRiq8EdLGcdnYFNyxDmp4FZB_eM_+hdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
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

On Thu, Feb 10, 2022 at 11:35 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Feb 10, 2022 at 08:00:15AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Feb 10, 2022 at 7:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Feb 10, 2022 at 07:18:24AM -0800, Suren Baghdasaryan wrote:
> > > > On Thu, Feb 10, 2022 at 4:40 AM 'Michal Hocko' via kernel-team
> > > > <kernel-team@android.com> wrote:
> > > > >
> > > > > On Wed 09-02-22 20:32:15, Suren Baghdasaryan wrote:
> > > > > > When adjacent vmas are being merged it can result in the vma that was
> > > > > > originally passed to madvise_update_vma being destroyed. In the current
> > > > > > implementation, the name parameter passed to madvise_update_vma points
> > > > > > directly to vma->anon_name->name and it is used after the call to
> > > > > > vma_merge. In the cases when vma_merge merges the original vma and
> > > > > > destroys it, this will result in use-after-free bug as shown below:
> > > > > >
> > > > > > madvise_vma_behavior << passes vma->anon_name->name as name param
> > > > > >   madvise_update_vma(name)
> > > > > >     vma_merge
> > > > > >       __vma_adjust
> > > > > >         vm_area_free <-- frees the vma
> > > > > >     replace_vma_anon_name(name) <-- UAF
> > > > > >
> > > > > > Fix this by raising the name refcount and stabilizing it. Introduce
> > > > > > vma_anon_name_{get/put} API for this purpose.
> > > > >
> > > > > What is the reason that madvise_update_vma uses the naked name rather
> > > > > than the encapsulated anon_vma_name? This really just begs for problems.
> > > >
> > > > The reason for that is the second place it's being used from the prctl syscall:
> > > >
> > > > prctl_set_vma
> > > >   madvise_set_anon_name
> > > >     madvise_vma_anon_name
> > > >       madvise_update_vma
> > > >
> > > > In that case the name parameter is not part of any anon_vma_name
> > > > struct and therefore is stable. I can add a comment to
> > > > madvise_update_vma indicating that the name parameter has to be stable
> > > > if that helps.
> > >
> > > Seems to me it'd simplify things if replace_vma_anon_name() and
> > > madvise_vma_anon_name() took a struct anon_vma_name instead of
> > > a bare char *.  You could construct it in madvise_set_anon_name().
> >
> > Ok, this can be done. However I don't think changing
> > replace_vma_anon_name() to accept a struct anon_vma_name would be a
> > good idea. Reader might think that the object being passed will become
> > the vma->anon_name of the vma, while in reality that's not the case.
>
> Why woud we not want that to be the case?  It's a refcounted name.
> I don't see why it shouldn't be shared between multiple VMAs that
> have the same name?

You are right. After I reworked the code it became apparent that
replace_vma_anon_name() should use anon_vma_name. I have made that
change and am testing it now. Hopefully no new surprises pop up.
Thanks,
Suren.

>
