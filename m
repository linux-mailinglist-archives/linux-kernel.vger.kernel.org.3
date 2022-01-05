Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7E485BE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbiAEWxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbiAEWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:51:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C756C034005
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:51:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id k15so2215429edk.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ex7w8HcbpnD772/tbtITSyn/vheu68eRRqBswHSSKrI=;
        b=fSyfYTkUPYz+3jTngF7GUBGzyvhqqZNom7Kf6iML9n/fbaxlTB8pins4rMAgiEaWZy
         fsbLdancp+snTegRa/ALD6Oo6aSLUdUiqNs2GKMX7UmkDIEaOnGkeKfv/uqkqqRDJ3OI
         MkZuGFG3vnIxcPGkqIBzptIj1+pTTb3precp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ex7w8HcbpnD772/tbtITSyn/vheu68eRRqBswHSSKrI=;
        b=mZ1zNEQ1aQ0EADMF3BWYBeGYHlkz0f08sl/C/5K/aWEIFVkkSVTvVj/x/fFvr+bCAs
         J6NS19LvXt5c2pDJQjgnf4YNt4xukvDLH4JIlzTWk4nfzLq2nIsLoWwv07QuK/zYphjz
         zRIUOg36sDbv2dR2YHs+XhalRbfLm+Vq6LafZmNkvQsDOOUxfj0BQVcBCgM9JhMc8Umr
         GACgGZ2bmjM5GRJHv1peFVLNqCuwzUBZ4uNXcb8nLKr4CEpBp3U5b7d3YHdEWAQIRBNj
         UbgQH7it970y6keAwit5ANHz825jfs7VS5SV/4u9mvaGywBd88XOokovUJtnwLs6VCnr
         Rv5Q==
X-Gm-Message-State: AOAM531MGQAAZrYZGsEl4bCqTpfRnJerjNUrGejaEZP8f81OSOkJMh5J
        75No8yaYqHRsOMZpInstv71VO/m/HQULbgaBFmE=
X-Google-Smtp-Source: ABdhPJz3/UsTQxG+xwySs6k0aIuQLMBKxLzZ66MTfjBE5Cg1rAcdiAnv5pKKJ/b0COnOaXvrz5TSvA==
X-Received: by 2002:a17:907:9086:: with SMTP id ge6mr318918ejb.332.1641423083363;
        Wed, 05 Jan 2022 14:51:23 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id ne31sm54593ejc.48.2022.01.05.14.51.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:51:22 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id o3so1130312wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:51:21 -0800 (PST)
X-Received: by 2002:a5d:6c68:: with SMTP id r8mr47342739wrz.281.1641423081626;
 Wed, 05 Jan 2022 14:51:21 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-2-ebiederm@xmission.com> <YdUmN7n4W5YETUhW@zeniv-ca.linux.org.uk>
 <871r1l9ai5.fsf@email.froward.int.ebiederm.org> <YdYTV9gQEPxssuZe@zeniv-ca.linux.org.uk>
In-Reply-To: <YdYTV9gQEPxssuZe@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jan 2022 14:51:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggCHypiukgs2_tm-00r2xaAkG8MQjuZtSNoG_umg7Rrg@mail.gmail.com>
Message-ID: <CAHk-=wggCHypiukgs2_tm-00r2xaAkG8MQjuZtSNoG_umg7Rrg@mail.gmail.com>
Subject: Re: [PATCH 02/10] exit: Add and use make_task_dead.
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 1:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jan 05, 2022 at 02:46:10PM -0600, Eric W. Biederman wrote:
> >
> > Being in assembly it did not have anything after the name do_exit so it
> > hid from my regex "[^A-Za-z0-9_]do_exit[^A-Za-z0-9]".  Thank you for
> > finding that.
>
> Umm...  What's wrong with '\<do_exit\>'?

Christ people, you both make it so complicated.

If you want to search for 'do_exit', just do

        git grep -w do_exit

where that '-w' does exactly that "word boundary" thing.

I thought everybody knew about this, because it's such a common thing
to do - checking my shell history, more than a third of my "git grep"
uses use '-w', exactly because it's very convenient for identifier
lookup

But yes, in more complex cases where you have other parts to the
pattern (ie you're not looking *just* for a single word), by all means
use '\<' and/or '\>'.

                 Linus
