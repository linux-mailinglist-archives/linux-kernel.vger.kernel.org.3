Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D449F0F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbiA1CZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiA1CZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:25:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F6AC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:25:29 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w14so6765618edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIM/9YxONk8z0lexlFGrsOXlsM+mXoPlWV7GxMGCHPU=;
        b=mINAVHjXaAFiquQLI+M15IWJaVPPEA6dLZ3Zm9VgsWOTI5Pfl5KjdqSgvZGS70G9vY
         dywxPdd1gcSy9qY+TqvgtEJyZFm755lGxQ7gs1+9z7bIrObl3EVT175ZusPCi2pceHNr
         XbKd1hQkPit95lQVUqkiZOYC5JatCLaZdAfvbGi5SBanfAbkRoOlT1EU4IV8OZGT0tlz
         va69LKX7VRAB1tqFPGbg84kwTYMt+g+Tohb1mnBwhuC0rl35gtLxhf4l8EMor/3VzCta
         QAe6NUmz8BqmmVB/f7DElWtwol3tE7uSmYP7JK+aEZpGteRWHVb2+cgpXGmRe/wRmxxS
         Z4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIM/9YxONk8z0lexlFGrsOXlsM+mXoPlWV7GxMGCHPU=;
        b=t+KYOHCtS4XGmLhVL1bXLna048JFHSckDSjU8seCoVq6vdVRPMXqcOShgro/3yj0zr
         wJx/asybqyQd/drudtBgogCmicT5RRUXcbpqbxyOa4LkHjQf6w9DOKx9EnBZFk5IlAXC
         KbvW+M+1qFRBwVg4kHkwGI26XRY2thAJ+s22xTeseobMbBo6wbe+fn9JUms5iwrgDJvn
         jFw719znHUrrECB8hN1NjGvqquucd4+/FjcOcUyykfntC9QYfTB8hcv7Jgjmeq+prN0b
         ojvyfr3dTDCbPhNC3X2EiMpyVSM4oSzOpZ6fSygIhRe1jUoDeBfJ+Gxrp1JNgDb6rmqN
         Pl7Q==
X-Gm-Message-State: AOAM532DX+Cb3KISnunPk3/5IQWAGrNsygfKOJ2hcWAHCi2EYtPdIpPp
        EIW4CLWnR1vwQ0VXUmWZ2XSAOjbn98xUc1ckq9WZ
X-Google-Smtp-Source: ABdhPJztDA6NHlQTDRr8lUOhYNr117WJE7+PhFHDKCmhuZCVk44RzyaYKVEHbANIS0iugGjghRQzs4AdEUVNSwDvFqE=
X-Received: by 2002:a50:ef16:: with SMTP id m22mr6093537eds.340.1643336728063;
 Thu, 27 Jan 2022 18:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
 <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
In-Reply-To: <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 21:25:17 -0500
Message-ID: <CAHC9VhQKVdbLNn=eOqebWaktDVeq5bjTjXea68MmcAhKoSa09w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Scott Mayhew <smayhew@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> I wonder if we could make this all much simpler by *always* doing the
> label parsing in selinux_add_opt() and just returning an error when
> !selinux_initialized(&selinux_state). Before the new mount API, mount
> options were always passed directly to the mount(2) syscall, so it
> wasn't possible to pass any SELinux mount options before the SELinux
> policy was loaded. I don't see why we need to jump through hoops here
> just to support this pseudo-feature of stashing an unparsed label into
> an fs_context before policy is loaded... Userspace should never need
> to do that.

I could agree with that, although part of my mind is a little nervous
about the "userspace should *never* ..." because that always seems to
bite us.  Although I'm struggling to think of a case where userspace
would need to set explicit SELinux mount options without having a
policy loaded.

-- 
paul-moore.com
