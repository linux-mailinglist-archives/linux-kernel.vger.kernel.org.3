Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D304F4643E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 01:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345647AbhLAAWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbhLAAWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:22:04 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6BCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:18:44 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e136so57760831ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G66SjSU43T2mv6UBUeBfbX+1AifLt/+MnLhSLyRgI78=;
        b=Ot/r3vv8w1E2ua1R8SR81W0XqSW7yzHEYzEcQa6qWlw41pimcaSm4utmpFjCj0RKuu
         IDgplljN0qIh82x/k6JDi2KyH5zgLiLQMwBUYQuYxPLWrUTwowwCp4DbqiIH/hRph0wT
         1lbvVi/XlIAjNvvzPdS43DRIFj1XyKTPP8GwsWJOHlX+srI9IuyapalJPWErde3E9fkm
         pTYWnSeMqvF5DtzxBrvuWG+n9e0LmK2PJ4eFlb2t3JRlnWVR0usGxgFMkP6C41UhGyfk
         xQmnwfCKGjn89HMET90a5XPZMaMF3MavmfOFhHu5jUf2A9tTAn2nIFMmNmmru0r0+2bC
         zF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G66SjSU43T2mv6UBUeBfbX+1AifLt/+MnLhSLyRgI78=;
        b=WjOKJkVsc5eNj+j8uxkTiproval1+AnTg/CdFWXPogzHQ2GuTKuR/PkX3GrDSIIzWC
         Kb8DqK1qZn8BCwj3WZ9nLM0RzXUCG9hrHEHBUyksNTUcFQcl5UGxOKz7UT4JeHPZ/Oqj
         8lun8e4fzxpG/tflgtpexWM6JC0gXryKJANg+X0Pc3SvGx4640kzzSeChZj+mmREbDYS
         j1SXJVzfSxbb6hDuF64Wg66HNG6P+T4vU6RGDbFJEUSZQWj3BDv75wbGGucPOfpZJ2LI
         KI9xAc2DkTaWR5xRUIq3zQTvS0ffgtcBsXVpqD+/OC8Dgem63YZNvEebHaFU8qdI2UR+
         ZtTQ==
X-Gm-Message-State: AOAM5305qy+gbkg8DSyAJw0uzqLZ5vKGlHDxQ3A23G/pwsCnIOnCt7Da
        C0y7U1k2uC2oQXkzgj3lx7mpBnUpyxGu13QIZ6y/YQ==
X-Google-Smtp-Source: ABdhPJyD4KFiGReaovO1UDEL47qfWeKRfC6oWdRGfPoqOKKA64ZTZJ9no3Z2XY2kc5ZKwkrQ5PUPd9borBt4xVvGNc0=
X-Received: by 2002:a05:6902:120e:: with SMTP id s14mr3325866ybu.277.1638317923319;
 Tue, 30 Nov 2021 16:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20211125141817.3541501-1-eric.dumazet@gmail.com> <6e94236d-7e91-80a6-f55d-15bd503e52c4@intel.com>
In-Reply-To: <6e94236d-7e91-80a6-f55d-15bd503e52c4@intel.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 Nov 2021 16:18:31 -0800
Message-ID: <CANn89i+ORhnmsJ-mVp2OH2ZThUq_k1j_6-CK79Tv1BL+5eqDGg@mail.gmail.com>
Subject: Re: [PATCH] x86/csum: fix initial seed for odd buffers
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 2:16 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/25/21 6:18 AM, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > When I folded do_csum() into csum_partial(), I missed that we
> > had to swap odd/even bytes from @sum argument.
> ...
> > Fixes: df4554cebdaa ("x86/csum: Rewrite/optimize csum_partial()")
>
> Hi Eric,
>
> That Fixes: sha1 doesn't match anything that I can find.  Should it be
> Fixes: this commit:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/core&id=d31c3c683ee668ba5d87c0730610442fd672525f
>
> I'm happy to fix it up when I apply it.  Just wanted to double-check
> what you intended.

II think you are right, the sha1 I gave was from my local tree, I
forgot to rebase, sorry for the confusion.
Thanks !
