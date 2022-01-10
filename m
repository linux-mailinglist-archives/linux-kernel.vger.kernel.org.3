Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5359A489E90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiAJRmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbiAJRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:42:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A1C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:42:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a18so55606769edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivp04c2e3aswpbUBl40rsDf5F/qMDtdT9+Y9jMZOA1Q=;
        b=TTdgKky08/wWY8IHzQ4R8Iu6WyCMszal1xCNQXMIJQFj7tisdchulnP4SWln7HChj3
         erP0vKpWvoXP6NoMkeWf1ihDRZubjTL6cpa8AQ3I6XIbuWr0Yi5+G3ZkfRNwD7MSWx5E
         EVNav+oSusoTbkI8xMHCIK7H2IjGRrU1kjjyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivp04c2e3aswpbUBl40rsDf5F/qMDtdT9+Y9jMZOA1Q=;
        b=VERM5zIre+wVkGM79F0nM+Bb0ugUoDo6VHxyThvjcH7dnrGMXMdNToguV5BUe5igXb
         tgIEyDlW7nkRSd94Pl0hdl06ilTiwh9eIW/NUnnpQGSX0/8cfMbV34MYDcmQpDPZ4nMe
         Q5yGHkOWU9Iz4n0SVOC08cqXZv+4ZqwTLkUPqcTV9+Icf2lGIy7h3eNEBPuKUYaN6XUp
         ftAP807Xdv8UWmLUWfDbjLxsc560LyNnuwpVWbjRUHHX5Kj9nTqhhumR2/OccyuB1Fiz
         aZc45ZaI/SNsfuM1VDI2vR47N3nePEZS+mYv97z5sWiuBOXpbhgacUx4sgTM7Kd+YBzt
         ZqEg==
X-Gm-Message-State: AOAM533H+J/CDggKsbbWtfAKZ3exr1eXwHjzLpWbYDUGPTXLlUXvYKwJ
        5fG8PYUmcR71kBibwbWxXocM6p4kgQSFXa8OzhQ=
X-Google-Smtp-Source: ABdhPJxPNAy1iYKw25BW8pTRHxb8oARmetp+Xcjc97T+n3QqzTXy0/N6WS0Pya73uNorXNNBv0DDug==
X-Received: by 2002:a05:6402:440e:: with SMTP id y14mr766578eda.12.1641836552379;
        Mon, 10 Jan 2022 09:42:32 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id hb17sm2596857ejc.195.2022.01.10.09.42.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 09:42:31 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id a5so24283632wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:42:29 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr579287wrh.97.1641836549717;
 Mon, 10 Jan 2022 09:42:29 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
 <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
 <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
 <Ydw4hWCRjAhGfCAv@cmpxchg.org> <CAJuCfpHg=SPzx7SGUL75DVpMy0BDEwVj4o-SM0UKGmEJrOSdvg@mail.gmail.com>
In-Reply-To: <CAJuCfpHg=SPzx7SGUL75DVpMy0BDEwVj4o-SM0UKGmEJrOSdvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 09:42:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZ=oic3UfejGzy_31RYggtZWUeF1gE82_NHAA=ENY6Kw@mail.gmail.com>
Message-ID: <CAHk-=wiZ=oic3UfejGzy_31RYggtZWUeF1gE82_NHAA=ENY6Kw@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 9:25 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> About the issue of serializing concurrent writes for
> cgroup_pressure_write() similar to how psi_write() does. Doesn't
> of->mutex inside kernfs_fop_write_iter() serialize the writes to the
> same file?

Ahh, yes, it looks like that does solve the serialization issue.
Sorry, I missed that because I'm not actually all that familiar with
the kernfs 'of' code.

So the only issue is the trigger lifetime one, and if a single trigger
is sufficient and returning -EBUSY for trying to replace an existing
one is good, then I think that's the proper fix.

I'm very busy with the merge window (and some upcoming travel and
family events), so I'm hoping somebody will write and test such a
patch. Please?

                   Linus
