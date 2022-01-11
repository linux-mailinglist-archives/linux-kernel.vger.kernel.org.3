Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7C48B14A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349680AbiAKPuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiAKPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:50:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B7AC06173F;
        Tue, 11 Jan 2022 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qOEManFFF/BXlKCeJbWOHviQUdQHvRMg2IeFAr2Wkyw=; b=r5HfzORtD1IRGl3YcIl/ZGdcYY
        c6QpHh4pauZJ9VIeXnrZwrYa6E9N50fJKPU5jcr9ZHz+MuSJwi8sL7VlMH+/AXi8yRLuphf5eLSw0
        MwaIovFKOC7ZdoEhXuq+M6VE/5X1rbx8jAqM42uV+bNlEgtrwkkt9r0aiv4M4Gj88EW2lqoCmanJr
        uR82TvEMsu99PsQDrzTGF8Gai8gHGt0ku/cDjNqOrzjFiOj2Y2gyTXCVdhkCQ1xT0n2UYbQsaylNd
        lzHIjXhAeX8d2WyGFROjMBeCsM/JswR28dBVXpikQqg65GsD6DarJjFot9pZeNgZGqNsAkF3eqqF8
        xFPfsBng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7JPJ-00GnAY-Jk; Tue, 11 Jan 2022 15:49:57 +0000
Date:   Tue, 11 Jan 2022 07:49:57 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vimal Agrawal <avimalin@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vimal Agrawal <vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/module.c: heuristic enhancement when
 INSTALL_MOD_STRIP= "--strip-unneeded" is used
Message-ID: <Yd2nJZRtc3OjPb0w@bombadil.infradead.org>
References: <YcJZWiQ407ZxMM+y@bombadil.infradead.org>
 <20211222132332.7817-1-vimal.agrawal@sophos.com>
 <YcRRQCMZFepB/hzX@infradead.org>
 <CALkUMdRxTm6STT4CncTuvQ9hM_bez+B91TsuenEj71KPxFgMsg@mail.gmail.com>
 <YcVtG26b/sO9k7ox@infradead.org>
 <CALkUMdSY3XCHqhH9dDQ+0VHykv9AiBiqLgoC+cj5P=9Q1jdXrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALkUMdSY3XCHqhH9dDQ+0VHykv9AiBiqLgoC+cj5P=9Q1jdXrg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 06:38:02AM +0530, Vimal Agrawal wrote:
> On Fri, Dec 24, 2021 at 12:17 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > I don't think we can support passing arbitrary linker options and
> > expects things to work.  If we want to support --strip-unneeded
> > it needs a good rationale and be added as a direct config option.
> INSTALL_MOD_STRIP was provided to give flexibility for providing
> strippping options.

Yes but the point here is the heuristic you are adding for
when "--strip-unneeded" is used is now *always* being used and
we have no way of knowing this. So I'd agree with Christoph that
if we want to support this it might make sense to make a kconfig
option for enabling "--strip-unneeded" and then another for this
heuristic.

You may want to work on top of Aaron's patches as that would make
adding new kconfig entries for modules much cleaner:

https://lkml.kernel.org/r/20220106234319.2067842-1-atomlin@redhat.com

I hope to review those this week, so I might have a tree you can
work off on by the end of this or next week.

  Luis
