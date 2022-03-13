Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB14D739C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiCMH3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiCMH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:29:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE033B3D2;
        Sat, 12 Mar 2022 23:28:31 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v130so24984552ybe.13;
        Sat, 12 Mar 2022 23:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hR1Qek6Dt5ZJKGDiQ5dVV6ae1mjFxBIUZ1scNsnvrA=;
        b=U+zef3au6jKLJA6fhaXO7tG152fud3s5ECEi7uZMYolp8xLvx1foI51jhHfWGWspvK
         xkpnvfpekkogCBwZ2Y0OpxkwTZLzF6PCwSuAyptcCn03McsvGBI/kqRrzmT2c02mCiJd
         opnzj2F6g9DodGUJi6avraSw3ATz08qYFVT1VhvN38MPV2soCVcyTUSTOh7cNlejuXFG
         umDEbEXGt8Y6iSVcSjlvWJaSeRK5nsaTecTFjVdxFEhHpvGU88EcCN74XzeK1OPFdWlU
         YU0Vi5DWyb5Ir1ICrLxWs4YLNq1rfwRgGwFZDcgi1wcn8crvVr9KkqysDxCkjWzah0L1
         Ywng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hR1Qek6Dt5ZJKGDiQ5dVV6ae1mjFxBIUZ1scNsnvrA=;
        b=3H6cz+kbC18zqw6wnC9K3ABCOW3YqcIcKteLpjkHn+O6emVsenFI23VbZiwTXlxkfL
         yEbjGRcrJ7iAey0rh2T3XQyAynpcqNjbPhlqdDt9X5JUb3eg6dfpobIojY++VJr8kUm/
         TCM0Q0EwxLobbUokfebMAJJm9mHCOrGC3feYkVMLP1VY/fprYa8MYPF3WdMJ0QIPl9u1
         XUEryNhA9rZk2NzKE5j69BZp4kXwwLt2PZy1N5rLmvGI8fKPqPwgS6Fw3al5V33t/6sO
         eXXYlbmwoJMIBLX8bRSYNQulD9dnUQzjHDjSmm8xz0ryyy/NqqSb4ZcHzGglBTG1SHN6
         KGew==
X-Gm-Message-State: AOAM532ZBSO5AD8JL/tOJCvCYMtT0mB73gop8kQ+ETkKgRAId5b21iez
        OEUTNq/VZodgac6LtZavl7f1PTeThu7awt7dTZbYrE9FysM2zg==
X-Google-Smtp-Source: ABdhPJycQgq2A28LvOvqauCDlV2JOlWLykFcUZwp/7At69abDOkBYJZ63jBPGoCNYQJn/08KUidfii30a8iONzujNzQ=
X-Received: by 2002:a25:cb85:0:b0:628:f0db:b2c4 with SMTP id
 b127-20020a25cb85000000b00628f0dbb2c4mr13434093ybg.531.1647156510213; Sat, 12
 Mar 2022 23:28:30 -0800 (PST)
MIME-Version: 1.0
References: <9a20b33d-b38f-b4a2-4742-c1eb5b8e4d6c@redhat.com>
 <YivTnPMUpvX8ivpj@casper.infradead.org> <CAKFNMonQtBe=pjrUuACqzKL36RTWmvoULwzD9NCP7PET8B73bQ@mail.gmail.com>
 <20220312222351.89844f74d3cf10212f308caf@linux-foundation.org>
In-Reply-To: <20220312222351.89844f74d3cf10212f308caf@linux-foundation.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sun, 13 Mar 2022 16:28:18 +0900
Message-ID: <CAKFNMokY0O9HVVvJ6MrzjP4n1-qyms6RHhHAWsBQ-ZfpJKaoVQ@mail.gmail.com>
Subject: Re: nilfs: WARNING: CPU: 2 PID: 1510 at include/linux/backing-dev.h:269
 __folio_mark_dirty+0x31d/0x3b0
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 3:23 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun, 13 Mar 2022 15:09:27 +0900 Ryusuke Konishi <konishi.ryusuke@gmail.com> wrote:
>
> > Hi Matthew, and Andrew,
> >
> > On Sat, Mar 12, 2022 at 7:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Mar 11, 2022 at 08:43:57PM +0100, David Hildenbrand wrote:
> > > > Hi,
> > > >
> > > > playing with swapfiles on random file systems, I stumbled over the
> > > > following nilfs issue (and reproduced it on latest greatest
> > > > linux/master -- v5.17-rc7+). I did not try finding out when this
> > > > was introduced and I did not run into this issue on other file
> > > > systems I tried.
> > >
> > > It's a known bug in NILFS, and I think yours is the fifth report
> > > of it dating back eight months.
> >
> > The root cause of this issue is that NILFS uses two page caches
> > per inode, one for data blocks and another for b-tree node blocks.
> >
> > Even though __folio_end_writeback(), __folio_start_writeback(), and
> > __folio_mark_dirty() acquire lock for mapping->i_pages,
> > inode_to_wb(inode) inside them performs lockdep test for the former one
> > (i.e. inode->i_mapping->i_pages.xa_lock).
> >
> > So, mark_buffer_dirty(), end_page_writeback(), and set_page_writeback()
> > for pages in the latter NILFS specific page cache hit the LOCKDEP warning.
> >
> > I tried to find a way to  resolve this, but have no good idea so far.
>
> If things are set up appropriately, inode_to_wb() should be able to
> test inode->i_mapping->host->i_mapping->i_pages.xa_lock and get the
> desired result.
>
> At least, that's the case with blockdevs.  I don't know if nilfs2 sets
> things up that way.

Yes, that is the problem of the current implementation of nilfs2.
nilfs2 sets the page cache for data to inode->i_mapping
but the page cache for b-tree nodes is not set to inode->i_mapping
because both are kept in one nilfs_inode together.

To satisfy relation inode->i_mapping->host == inode for both page caches,
I need to change nilfs_inode to assign inode struct for both.

Well, I'll consider if such modification is possible as a solution.

Regards,
Ryusuke Konishi
