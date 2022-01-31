Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D064A477B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378104AbiAaMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:46:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50826 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378063AbiAaMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643633211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbb7oKj7pGqcFFQvVLEG96fF5LM89XRk6kAiNWwlPYQ=;
        b=M0Ar9MCOE2xJFnUP6eN2Hp8grewCNTM0SrC2DaNhW1UN03H1NibZnGy1zlAST681H7X58y
        H8JhYBvuHOAgEbsY/zX1bmGN3PLpfiRBwJaa6OTw7dXwXx2NHHZvYkmY0+C30O/sqc4z+Z
        eDu+SOpFgw0W9YloCeFsJ0m2a5CSzXc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-aQPoDx6tPO-vKt16KPCLbg-1; Mon, 31 Jan 2022 07:46:50 -0500
X-MC-Unique: aQPoDx6tPO-vKt16KPCLbg-1
Received: by mail-yb1-f197.google.com with SMTP id u185-20020a2560c2000000b0060fd98540f7so26597220ybb.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 04:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbb7oKj7pGqcFFQvVLEG96fF5LM89XRk6kAiNWwlPYQ=;
        b=K/lGDzh5YIbBivZLDUAXosaPkTu1kWlvUzBktldCtfGobabccgppBr9+hBiGfuVRpy
         ttVYg9aBWOJIrqGdgUq3BTbUpoXVA7BWPB3hSH7o023gNmbNhqcePjKy6OEheY4+fWmX
         ZwpQF0qw2e08h1/QGc4i7PqW1rfC+oDa8qUN4s+eeYuGav3IawvD1zEavwKvY3145Lak
         ZUllLGsb4t+Qp3prUO7kTCuoE2KoRya+PJisuTjU/Zj8apYTbrvDB3nA6a5/r8KwDrdp
         +D6pkwa895VjtWT6EGO1S+suS9aOxhfpQz42oL5JM4Vgwric4gZjYlni4Du3q+cXZ3lR
         KHSg==
X-Gm-Message-State: AOAM530i7DOCEH/hXucs9lDaBOfD5lengnvgflZ0GF5d3tpv8MISgAB5
        +TMz1rbDFmx1J4YwvMQCUEwstduBcRaPqI/gO9plyCKm20VI0bFrtiejIBGKFJAm1J5Kp1JTJMK
        Ud8iz2Df0lqbPziii7YUzk9hqs9uJgh7AkbTWzysG
X-Received: by 2002:a25:b003:: with SMTP id q3mr26931228ybf.767.1643633209483;
        Mon, 31 Jan 2022 04:46:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXf5DsrdCafeJ+jbkokGucWXiUD4d5CaBpbjPavzB13XtyY3keprMZq0LSYrIY7UgOHJXQUOmX4OcssUPQW5A=
X-Received: by 2002:a25:b003:: with SMTP id q3mr26931208ybf.767.1643633209321;
 Mon, 31 Jan 2022 04:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com> <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
In-Reply-To: <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 31 Jan 2022 13:46:32 +0100
Message-ID: <CAFqZXNvny0zJmEMzFeMFuy0DzjAAaB5uqRpQoSMbZwVcUxTDAQ@mail.gmail.com>
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

On Fri, Jan 28, 2022 at 3:28 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jan 27, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > I wonder if we could make this all much simpler by *always* doing the
> > label parsing in selinux_add_opt() and just returning an error when
> > !selinux_initialized(&selinux_state). Before the new mount API, mount
> > options were always passed directly to the mount(2) syscall, so it
> > wasn't possible to pass any SELinux mount options before the SELinux
> > policy was loaded. I don't see why we need to jump through hoops here
> > just to support this pseudo-feature of stashing an unparsed label into
> > an fs_context before policy is loaded... Userspace should never need
> > to do that.
>
> I could agree with that, although part of my mind is a little nervous
> about the "userspace should *never* ..." because that always seems to
> bite us.  Although I'm struggling to think of a case where userspace
> would need to set explicit SELinux mount options without having a
> policy loaded.

I get that, but IMO this is enough of an odd "use case" that I
wouldn't worry too much. To be affected by this, someone would need
to:
1. Use the new mount API, which:
    a) doesn't even have man pages yet,
    b) isn't even used by the mount(8) utility yet.
2. Call fsconfig(2) with a SELinux mount option before policy is loaded.
3. Call fsmount(2) with the same fd after policy is loaded.

And racing with the policy load doesn't count - that could fail
randomly with or without the change. I honestly can't imagine any
realistic scenario where someone would do this...

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

