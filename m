Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BADF4A5E6C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbiBAOih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239405AbiBAOig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643726315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yP1bs/cD6ul5vF2aW3mHYFKWpId1PYYPSFAUCUmS+ys=;
        b=JlSzjvZbIv2eCQUcY1lQqNKW7xrVJG7XwIPBqf0rPUwGu1BJZfRJUBb2T2gMN4E15eSe1i
        fDKDZxiOy68TjE5NiJ12KBx8UW7jkO/n9oclwrUKBo6472/ACyKshglDfPAckLoXPJqRa9
        ObslTB1niOpPrDaZsAO+ymqcKzikzRA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-1nQX0R13MPi9Q9w1j-kGbA-1; Tue, 01 Feb 2022 09:38:34 -0500
X-MC-Unique: 1nQX0R13MPi9Q9w1j-kGbA-1
Received: by mail-yb1-f197.google.com with SMTP id a125-20020a25ca83000000b00619442ade1cso24418989ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yP1bs/cD6ul5vF2aW3mHYFKWpId1PYYPSFAUCUmS+ys=;
        b=OtCsmMU6/7XwrX248g9QRUDhvSGkRtvWEp5Bjjj3CtLAuN50inD1wFZe9BwLaSL8co
         1zs9NMpaL+ffKe8Xwz9Hw4DOwtMgD6bcg9dpvsD7a4zgoMAX67kdtWXn+jENRC2w1DU9
         IKjskpBGuZTLilXWPqh0o5lluMoOG0DkggCW1d6K9rbu/9RvNoqNwZ0mcmifvLptSl0N
         YmdaI34pLlLZRrX14oSrtTSdQqitTURpxB/WYdCyVK4Zy3SbShj+AkP7imEjMhbPZqry
         7urZyoQtRpO8Lhu7BCf2smdkqx6Fku/A9EtrHDwaIXNvHL7JTT5nDOjJPFqVk99j9a0s
         +3GQ==
X-Gm-Message-State: AOAM532u6tnWKEQlr0Hz+5jQeDNQ02jQ6Or6KkKnFmFK58wjfpYUvq8T
        vnFBb9L45WDRZYTWIgMqAYFgNzK70nEdDY059lvg4Pt3fPTAB+IS+hYDsV2rwWsRkbexh47CJoQ
        z/RXkAGxu88+3x15q92f1fonDvozBajoHeWVWrRzG
X-Received: by 2002:a25:7382:: with SMTP id o124mr34766805ybc.318.1643726313972;
        Tue, 01 Feb 2022 06:38:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxAXD5P65F6JW0OiYGwB7dqy0nRCCl4tn2Upv5lN7vsS5B73WmEMitmQBqmvRWfJpdSzuWlZrc30QHIx/QgY4=
X-Received: by 2002:a25:7382:: with SMTP id o124mr34766786ybc.318.1643726313750;
 Tue, 01 Feb 2022 06:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
 <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
 <CAFqZXNvny0zJmEMzFeMFuy0DzjAAaB5uqRpQoSMbZwVcUxTDAQ@mail.gmail.com> <CAHC9VhQE4JPhTjkKwV3ovRSuPceiHDrP3MDW4RPDcNtLkb7tAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQE4JPhTjkKwV3ovRSuPceiHDrP3MDW4RPDcNtLkb7tAQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 1 Feb 2022 15:38:16 +0100
Message-ID: <CAFqZXNs7P+p0B-uZ2owMH1qa04unbq870tMqQ4Kwup7dXJ9z=g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 5:16 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Jan 31, 2022 at 7:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Jan 28, 2022 at 3:28 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Jan 27, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > I wonder if we could make this all much simpler by *always* doing the
> > > > label parsing in selinux_add_opt() and just returning an error when
> > > > !selinux_initialized(&selinux_state). Before the new mount API, mount
> > > > options were always passed directly to the mount(2) syscall, so it
> > > > wasn't possible to pass any SELinux mount options before the SELinux
> > > > policy was loaded. I don't see why we need to jump through hoops here
> > > > just to support this pseudo-feature of stashing an unparsed label into
> > > > an fs_context before policy is loaded... Userspace should never need
> > > > to do that.
> > >
> > > I could agree with that, although part of my mind is a little nervous
> > > about the "userspace should *never* ..." because that always seems to
> > > bite us.  Although I'm struggling to think of a case where userspace
> > > would need to set explicit SELinux mount options without having a
> > > policy loaded.
> >
> > I get that, but IMO this is enough of an odd "use case" that I
> > wouldn't worry too much ...
>
> I understand, but seeing as I'm the only one that defends these things
> with Linus and others lets do this:

It's not all black and white:
https://lore.kernel.org/lkml/Pine.LNX.4.64.0512291322560.3298@g5.osdl.org/

> 1. Fix what we have now using Scott's patches once he incorporates the feedback.
> 2. Merge another patch (separate patch(set) please!) which does the
> parsing in selinux_add_opt().
>
> ... this was if we have to revert #2 we still have the fixes in #1.

Sounds good to me. I can prepare the simplification patch. If anyone
does come to complain, then by all means, let's revert it.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

