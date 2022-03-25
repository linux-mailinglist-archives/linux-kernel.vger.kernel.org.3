Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A514E6C64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357780AbiCYCMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357753AbiCYCMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:12:14 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AB9A147B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:10:25 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id x20so11544151ybi.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKwNBEs3tASJWL7vN74tIrUm9dV+sBlNlNaJ5KwKgTs=;
        b=cbc3BGe5+zL07UFEV9pbFjATQyTFfHkL8NRVARYGOxWmh0lxE1dNlskSSeW2JkMs2k
         sFZgeI9XI06R2An17rGJRCrVBd+4KlMmefFE0nM82JlLERTRrgyL+1O3jRbO/hSqr9ZS
         Pvf+cXGQaP182cb0VU8dTVUGy9z7Ic0Nmx+vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKwNBEs3tASJWL7vN74tIrUm9dV+sBlNlNaJ5KwKgTs=;
        b=LvDWwcR1aUyVmJid6wKJyqEl7Z50dxnvQWWb4iBQiY+0hE4hzXN/NRF0+rO1xL21y5
         //rP+h45TnJBcCkXSNx4mqvYF3Q29F6Z4Hp1yybGwaxEOJxN7seRC37YNE3LxE+cFsX2
         ScUgO0dex0PZ5xqTV82Jv2bkadvtHTzI7dJ8Zk/TrhUcTF7JZH1dOxpFAzYvx6enodmz
         nTNn6mYTJnD0nRhoZpNQ+LJ2YCNy5EDeUxPdy68YgdSBhTPbc7ZFSoAq5CNUkZ+9fUs0
         9YzvLYkJtGI7HbhKVEYVaAPjGAZUVUy5VfG3Do6amyQEm0YZLMraaAsUQhQ3FruRiozo
         LiSw==
X-Gm-Message-State: AOAM530LWdmWjaJjuNLA3OcdDnYbdxxKHu2tKLDH9Uc9DYEjNVy85v/r
        K7e7i9aA+NyW04DE3QqXUGw4ImCrW27kfUp/9yOnAw==
X-Google-Smtp-Source: ABdhPJz3y4TlNL1JF4KJF+1yuPmc8LbezhlJz2o/4Jb79VASFUj+QoEgLFnQxvm0LwiSP+zSpCA553HDqMC/wZi0OFI=
X-Received: by 2002:a25:3f43:0:b0:633:bdd8:4ae6 with SMTP id
 m64-20020a253f43000000b00633bdd84ae6mr7423462yba.134.1648174224922; Thu, 24
 Mar 2022 19:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CABWYdi1PeNbgnM4qE001+_BzHJxQcaaY9sLOK=Y7gjqfXZO0=g@mail.gmail.com>
 <YjA439FwajtHsahr@google.com> <YjEOiZCLBMgbw8oc@google.com>
 <CABWYdi0jd_pG_qqAnnGK6otNNXeNoiAWtmC14Jv+tiSadJPw0w@mail.gmail.com>
 <CABWYdi2gOzAK60gLYKx9gSoSfJRZaAjyAWm+55gLgcSKrDrP9Q@mail.gmail.com>
 <YjTCF37cUNz9FwGi@google.com> <YjTVVxIAsnKAXjTd@google.com>
In-Reply-To: <YjTVVxIAsnKAXjTd@google.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 24 Mar 2022 19:10:14 -0700
Message-ID: <CABWYdi0tgau=trCiGWULY88Wu1-=13ck8NikV0KxfDQHFCCiMA@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:54 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Mar 18, 2022 at 10:32:07AM -0700, Minchan Kim wrote:
> > On Fri, Mar 18, 2022 at 09:30:09AM -0700, Ivan Babrou wrote:
> > > On Wed, Mar 16, 2022 at 11:26 AM Ivan Babrou <ivan@cloudflare.com> wrote:
> > > > I'm making an internal build and will push it to some location to see
> > > > how it behaves, but it might take a few days to get any sort of
> > > > confidence in the results (unless it breaks immediately).
> > > >
> > > > I've also pushed my patch that disables SWP_SYNCHRONOUS_IO to a few
> > > > locations yesterday to see how it fares.
> > >
> > > I have some updates before the weekend. There are two experimental groups:
> > >
> > > * My patch that removes the SWP_SYNCHRONOUS_IO flag. There are 704
> > > machines in this group across 5 datacenters with cumulative uptime of
> > > 916 days.
> > > * Minchan's patch to remove swap_slot_free_notify. There are 376
> > > machines in this group across 3 datacenters with cumulative uptime of
> > > 240 days.
> > >
> > > Our machines take a couple of hours to start swapping anything after
> > > boot, and I discounted these two hours from the cumulative uptime.
> > >
> > > Neither of these two groups experienced unexpected coredumps or
> > > rocksdb corruptions.
> > >
> > > I think at this point it's reasonable to proceed with Minchan's patch
> > > (including a backport).
> >
> > Let me cook the patch and then will post it.
> >
> > Thanks for the testing as well as reporting, Ivan!
>
> From 1ede54d46f0b1958bfc624f17fe709637ef8f12a Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Tue, 15 Mar 2022 14:14:23 -0700
> Subject: [PATCH] mm: fix unexpected zeroed page mapping with zram swap

Is there any action needed from me to make sure that this lands into
the mm tree and eventually into stable releases?
