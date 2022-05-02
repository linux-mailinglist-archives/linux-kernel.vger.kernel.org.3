Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41C517AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiEBXZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiEBXYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:24:00 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733F42AF4
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:20:24 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id m62so14382623vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kD4nACOSY/APvZl7Jejb8yTw6pDPiNpkZFLVJ6Ps/g=;
        b=GF4YY7vMyrRNaiSybvsbVUdWRrNJepIDJvsWmHCuxDcKKt5zu8QA4on3F2K13BkJ2T
         5OPYZdTN3ETUQr8xuTQZ/4r2cSkV+oY6zuie5fyXGr2UXQbsFPWLISM9RHx911nqqafE
         y9lvXmvgQedVrgaYIfuxTAVif6KXBMMOuQTX/Nb3+N6vBbRkUOhsuRp7hztSOh23tfkt
         kqhsCrGHdtakDNTAl6DS6uZb5gwfEMN5drBq5FNbSEwFlA9deKvbcqPi3tKbZqOa9Ayk
         KApZedDjQx8Md8udYixi4HGJdh1Ns/9UnkltZ6KfIAgzhBcZqnmtVCV8d7dZ3givQQfe
         TSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kD4nACOSY/APvZl7Jejb8yTw6pDPiNpkZFLVJ6Ps/g=;
        b=xZg92DghPtLnmn7kOUrQvWejqCXOSNkLLN4dBMBp5h6YLNKy5ScWg5b1aBTs+8xniY
         WbbKBKk6Eraaiyk+mAHXDaSkWF1rL01m1bBI7cxelMGKPN7kErdr308hHyZnyk4j1AjK
         YoCFXEDptc5w4ziel9soLLChtuiTNKLKeYYlBbR07HtMHZuJlp+27X4QekVOEisTQARR
         jxHWvTZrkUt8mbEpqsJaoeI/M2Ief2pworA1SFdS5k1PrpCc+TisGNVjiObvlWrOaWzf
         cmKHnvp1hgRyhp/TqAafldeOqohPfVCjlqqrNEF5XUfQemfxZWFQZecZ6343pPq+FWRh
         97yA==
X-Gm-Message-State: AOAM530gSGGkhz52W6QXvb/nk31BoNyMFuJouYXD6v5YAkEfvbDjTdXj
        321mBjlvKdC6liCfdF87nmaQ5lcRFcZJg1P2lKH4Yw==
X-Google-Smtp-Source: ABdhPJx9a8pxmcrbJi6unqcR9DdA9WsWAie/Wf5yqgZL/vnDIxlBXn4crPJBtIVUBpXpdInk9lvUolGPzzkrDPBw4p4=
X-Received: by 2002:a67:c408:0:b0:32d:1319:2e38 with SMTP id
 c8-20020a67c408000000b0032d13192e38mr4300957vsk.72.1651533589636; Mon, 02 May
 2022 16:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220429202207.3045-1-almasrymina@google.com> <20220429133345.d79af45fb107340c31655c8e@linux-foundation.org>
 <152cb376-3793-0dd3-7d2d-d6197b8e014f@oracle.com>
In-Reply-To: <152cb376-3793-0dd3-7d2d-d6197b8e014f@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 2 May 2022 16:19:37 -0700
Message-ID: <CAHS8izMnxs8Btyk2PGax88vtNqoRwi5cBb0Rmfp8RSEV-WePhA@mail.gmail.com>
Subject: Re: [PATCH v1] hugetlbfs: fix hugetlbfs_statfs() locking
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Apr 29, 2022 at 1:59 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 4/29/22 13:33, Andrew Morton wrote:
> > On Fri, 29 Apr 2022 13:22:06 -0700 Mina Almasry <almasrymina@google.com> wrote:
> >
> >> After commit db71ef79b59b ("hugetlb: make free_huge_page irq safe"),
> >> the subpool lock should be locked with spin_lock_irq() and all call
> >> sites was modified as such, except for the ones in hugetlbfs_statfs().
> >>
> >> ...
> >>
> >> --- a/fs/hugetlbfs/inode.c
> >> +++ b/fs/hugetlbfs/inode.c
> >> @@ -1048,12 +1048,12 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >>              if (sbinfo->spool) {
> >>                      long free_pages;
> >>
> >> -                    spin_lock(&sbinfo->spool->lock);
> >> +                    spin_lock_irq(&sbinfo->spool->lock);
> >>                      buf->f_blocks = sbinfo->spool->max_hpages;
> >>                      free_pages = sbinfo->spool->max_hpages
> >>                              - sbinfo->spool->used_hpages;
> >>                      buf->f_bavail = buf->f_bfree = free_pages;
> >> -                    spin_unlock(&sbinfo->spool->lock);
> >> +                    spin_unlock_irq(&sbinfo->spool->lock);
> >>                      buf->f_files = sbinfo->max_inodes;
> >>                      buf->f_ffree = sbinfo->free_inodes;
> >>              }
> >
> > Looks good.
>
> Agree, thanks Mina!
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> >
> > This seems to be theoretically deadlockable and less theoretically
> > lockdep splattable, so I'm inclined to cc:stable on this.
> >
> > I wonder why we didn't do that with db71ef79b59bb2e78dc4.
> >
>
> I do not think it was considered because the "less theoretically lockdep splattable" was so rare.
>
> IIRC, the issue of possibly freeing hugetlb pages in IRQ context existed
> from almost the beginning of hugetlb.  It was first discovered and 'addressed'
> with c77c0a8ac4c5.  That was not cc:stable.  Then it was discovered that c77c0a8ac4c5 was not complete, so db71ef79b59b effectively replaced c77c0a8ac4c5.  That also was not cc:stable.  I guess we could cc:stable this.
>
> Mina, did you find this with lockdep or just code inspection?

Greg Thelen found this by code inspection. He was reviewing a related
fix and noticed this particular instance of locking wasn't _irq(), and
based on previous changes it ought to be. Lockdep did not complain
about this.

> --
> Mike Kravetz
