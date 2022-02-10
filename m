Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105E04B123F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbiBJQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:00:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiBJQA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:00:26 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4672E83
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:00:27 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id x136so14998812ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XCqHQHpWHW92nEkn4B+1VbtafR8Zb17zrKGkCgMBOY=;
        b=faunBAocEyTU3CGL7gl//+yF9YyCQoMEbj2ZN8NRFm7J2vTf4HCC646inj2AKDJ/Li
         T+L57QEnJDZMU/x5GvmE1TNoUgI6KdnyW3BJjjsX9Ktj53KEWlWav5AGH3mFjHB/krwD
         DwKURXCZ+PeogMZdeSdYdXkS9BI63xaS9p7lST+vD23tLVjVQqoY3v+oCv2POgiGsVUC
         9eEAWA8Vn4Wcjzl2qibliqTyiuxXOWEyrIltryEJ1vCwYCfU+r75T8MMcofrmi6aaQ/E
         oIZytQHO2X/pmANbIcx4+WBIDHJFfOMRT/t/dE8qVwVBRxhh8Mrp+WqP1zmnFZu+wiZ7
         7mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XCqHQHpWHW92nEkn4B+1VbtafR8Zb17zrKGkCgMBOY=;
        b=gw+QcT/oWtekqy9aIYCIM1g2A9RuMdqyBFInqLMb1fX5AEwQ90q4rv0QYgl1rzYvHc
         218AvovRO95sqaKsjzP9EzYzMXwszisq0K6ap9On2lOLTumzhiBdeKJuNQXtuBd3l0Z4
         LSAQDcDawF54wWCmVLq/IGSNpYF+ur3JpMpqeXB7mXiq5ZkYljJRS+v38DVDOeQFarAe
         myT+USo+31ZES+ZS8+YeySKx0HU3IEYxmMu6YLTeIz+buMS1TCPm7Bibi38IexEeHLOm
         ILTCcgdqdZh6xSn9oD970fnwqVKkP8EWSkve9i8/zHCpAWgOr1FPQ6Bd8a+jTlR7pxN+
         /RUw==
X-Gm-Message-State: AOAM533dvelaDdiPd4zCEWHGr9/DpbK4sm4/v6v/N1A0oWxg+9TGgFfv
        RnmBnFbfD0QRFbnkPLtq9vWgZl9MKvDRs86RhVOhGA==
X-Google-Smtp-Source: ABdhPJyK0yeU3tCgFGaq/lWLUswz250+pcrtPVEN8SUTLC8FJkGgxsfg2XRHKVPKKE59pgalYQZ9QccYTUPgTw8lEL0=
X-Received: by 2002:a81:7e4f:: with SMTP id p15mr7799834ywn.180.1644508825921;
 Thu, 10 Feb 2022 08:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20220210043215.42794-1-surenb@google.com> <YgUHzSqltDp2dr70@dhcp22.suse.cz>
 <CAJuCfpGkW7MoWW=E1tqEib24M3JjxDKF_zgmMnvWo8wJP6cy2g@mail.gmail.com> <YgUu0prRt3iu1Cpy@casper.infradead.org>
In-Reply-To: <YgUu0prRt3iu1Cpy@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Feb 2022 08:00:15 -0800
Message-ID: <CAJuCfpHPZNbK2rd95pZAWr0d3vACGzHdiAFv=bM-G8nC+YdYwg@mail.gmail.com>
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

On Thu, Feb 10, 2022 at 7:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Feb 10, 2022 at 07:18:24AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Feb 10, 2022 at 4:40 AM 'Michal Hocko' via kernel-team
> > <kernel-team@android.com> wrote:
> > >
> > > On Wed 09-02-22 20:32:15, Suren Baghdasaryan wrote:
> > > > When adjacent vmas are being merged it can result in the vma that was
> > > > originally passed to madvise_update_vma being destroyed. In the current
> > > > implementation, the name parameter passed to madvise_update_vma points
> > > > directly to vma->anon_name->name and it is used after the call to
> > > > vma_merge. In the cases when vma_merge merges the original vma and
> > > > destroys it, this will result in use-after-free bug as shown below:
> > > >
> > > > madvise_vma_behavior << passes vma->anon_name->name as name param
> > > >   madvise_update_vma(name)
> > > >     vma_merge
> > > >       __vma_adjust
> > > >         vm_area_free <-- frees the vma
> > > >     replace_vma_anon_name(name) <-- UAF
> > > >
> > > > Fix this by raising the name refcount and stabilizing it. Introduce
> > > > vma_anon_name_{get/put} API for this purpose.
> > >
> > > What is the reason that madvise_update_vma uses the naked name rather
> > > than the encapsulated anon_vma_name? This really just begs for problems.
> >
> > The reason for that is the second place it's being used from the prctl syscall:
> >
> > prctl_set_vma
> >   madvise_set_anon_name
> >     madvise_vma_anon_name
> >       madvise_update_vma
> >
> > In that case the name parameter is not part of any anon_vma_name
> > struct and therefore is stable. I can add a comment to
> > madvise_update_vma indicating that the name parameter has to be stable
> > if that helps.
>
> Seems to me it'd simplify things if replace_vma_anon_name() and
> madvise_vma_anon_name() took a struct anon_vma_name instead of
> a bare char *.  You could construct it in madvise_set_anon_name().

Ok, this can be done. However I don't think changing
replace_vma_anon_name() to accept a struct anon_vma_name would be a
good idea. Reader might think that the object being passed will become
the vma->anon_name of the vma, while in reality that's not the case.
Keeping it a char* makes it obvious that the function will construct a
new anon_vma_name struct.
I'll post a v3 shortly implementing these suggestions.
Thanks for the review folks!
