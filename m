Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181F94B11A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiBJP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:27:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiBJP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:27:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4132EC5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gynz4GctFraPlMytzPSTNoFqFWVAHNCc0fOzdQVAQao=; b=NR/BHKdbpQZLlGtoCSDgUNPG7O
        Psw60z4N0oxcyitqN37cRew0XqRp4cDUPsyKjL0PxURP+FV2ib53eVf1fPPOGC/N0zcMhJgU+3LOB
        lljmJblJ+yQIlB7KrTDIX9umG6orwo+cfbeelE/IzN3PT3BoEdG7elhwCk399RxvYdd3qcPMYPchy
        Id+Q1MLy8dTsv2lAzpXdjHR2T90uqUiIF87u2sjzXLMaxoso1KjuH9hb5IIAD24aJTfX8DXZHNj5t
        3r+4CIcDjTVb1BtGw2/hXD3f5zknfgMEp2hOx1XOfjHAno8gOPDbmWa/K9JWfXzctbL+QC0eNU+YG
        frimlstw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIBLm-009XVY-RL; Thu, 10 Feb 2022 15:27:14 +0000
Date:   Thu, 10 Feb 2022 15:27:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
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
Subject: Re: [PATCH v2 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
Message-ID: <YgUu0prRt3iu1Cpy@casper.infradead.org>
References: <20220210043215.42794-1-surenb@google.com>
 <YgUHzSqltDp2dr70@dhcp22.suse.cz>
 <CAJuCfpGkW7MoWW=E1tqEib24M3JjxDKF_zgmMnvWo8wJP6cy2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGkW7MoWW=E1tqEib24M3JjxDKF_zgmMnvWo8wJP6cy2g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 07:18:24AM -0800, Suren Baghdasaryan wrote:
> On Thu, Feb 10, 2022 at 4:40 AM 'Michal Hocko' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > On Wed 09-02-22 20:32:15, Suren Baghdasaryan wrote:
> > > When adjacent vmas are being merged it can result in the vma that was
> > > originally passed to madvise_update_vma being destroyed. In the current
> > > implementation, the name parameter passed to madvise_update_vma points
> > > directly to vma->anon_name->name and it is used after the call to
> > > vma_merge. In the cases when vma_merge merges the original vma and
> > > destroys it, this will result in use-after-free bug as shown below:
> > >
> > > madvise_vma_behavior << passes vma->anon_name->name as name param
> > >   madvise_update_vma(name)
> > >     vma_merge
> > >       __vma_adjust
> > >         vm_area_free <-- frees the vma
> > >     replace_vma_anon_name(name) <-- UAF
> > >
> > > Fix this by raising the name refcount and stabilizing it. Introduce
> > > vma_anon_name_{get/put} API for this purpose.
> >
> > What is the reason that madvise_update_vma uses the naked name rather
> > than the encapsulated anon_vma_name? This really just begs for problems.
> 
> The reason for that is the second place it's being used from the prctl syscall:
> 
> prctl_set_vma
>   madvise_set_anon_name
>     madvise_vma_anon_name
>       madvise_update_vma
> 
> In that case the name parameter is not part of any anon_vma_name
> struct and therefore is stable. I can add a comment to
> madvise_update_vma indicating that the name parameter has to be stable
> if that helps.

Seems to me it'd simplify things if replace_vma_anon_name() and
madvise_vma_anon_name() took a struct anon_vma_name instead of
a bare char *.  You could construct it in madvise_set_anon_name().
