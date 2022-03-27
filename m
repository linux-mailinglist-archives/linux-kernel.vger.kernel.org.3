Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754CD4E8970
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiC0S46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiC0S44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 14:56:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB113CC5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:55:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z92so14621953ede.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9jZT/F4OuvTWinj/4kyo7RTjCqhoAmZjhkuTv218Ss0=;
        b=ot2UiTDqKuVgbHqLcpKcD8FNSYlrEKRh8nWvOwUZZQ2/p+E9q/lG7e+JFOBTXiehZB
         /kdDUA79wyzla1bJfxl/sZKMnDCP6h2Pm7bN5evpXRAitC43bs2kPEsDvNWBrks8wZVH
         ly/wBsIi9P3aZ5eKs8oC/lWn4o5bVShZCYJU6XITKFDZ0j7o5SSBTw1f3KXFTNe37wUR
         GTV398CXlJN+iegOHbxsGZQisLmwPhqF49ZOLfWXnPUNPAcFvwZC+CtVg5D1vLoJJcqY
         D/ds3QLJjVnSpgCZCghSZq78U6rlkHAS6h8x3Zp73VdOumVM3CEM1VuCX6bKp8/eQ0k3
         optA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9jZT/F4OuvTWinj/4kyo7RTjCqhoAmZjhkuTv218Ss0=;
        b=h6DATy43qjz5Vt81d4Om6lKgJEb1FKVgkrly/YnnqddokKfOactRufJ7Vn0pAM1Yv6
         kxPL4a/wF9GKnv8aE8rUOlc44ITlKCMNH9OzmsYFJ0S0e6FbLrqIdd3hHqXzhDeEHC5b
         lcib6MjyAmwsBGP6Zx3QOq78lwFjDy0fGc2F73EPpu2PbWv6seCGt04swbcUp4Meg7QL
         fQ+TE/BldJWI5fXSyPMWC5l9gUcZdnD1ckqYxKr4W8Kr+RXcDiPHFeSDZFeqV0Vdmu/9
         WHm2EOb7OCXPh5Axo9cRwioUMrmNgN8yojdUqlvDFaYe+nI1fOKJKY449mx0TENfpevJ
         EWdQ==
X-Gm-Message-State: AOAM5315e/Me+FJGD04OJC3Y6Xp0Sv1yHDs3j8YFc5qmNAWsslxNw5vs
        hesR5OPvc8iz+/4QYVGbovo=
X-Google-Smtp-Source: ABdhPJy6mytjbW/1ka7wniFkXmQR6R8f1Qd9T5ckVn2k58DaRXENJtEmyrv4h+O+ehtY6GIL3dhN7g==
X-Received: by 2002:a05:6402:60e:b0:419:d2e:bcea with SMTP id n14-20020a056402060e00b004190d2ebceamr11867910edv.326.1648407314617;
        Sun, 27 Mar 2022 11:55:14 -0700 (PDT)
Received: from gmail.com (0526F2AE.dsl.pool.telekom.hu. [5.38.242.174])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm4891461ejz.199.2022.03.27.11.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 11:55:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 27 Mar 2022 20:55:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [GIT PULL] x86/core for 5.18
Message-ID: <YkCzCrfMY/HavlLm@gmail.com>
References: <20220326152646.GT8939@worktop.programming.kicks-ass.net>
 <CAHk-=whhG15HiqR+WM5M2mMy9F17yVdT8_M0ra0tGJS+5ibrdw@mail.gmail.com>
 <20220327082217.GU8939@worktop.programming.kicks-ass.net>
 <CAHk-=whzW56xChey=k+9KeK_NFxWLfZrt5UWvVjTxYbHLP1Nwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whzW56xChey=k+9KeK_NFxWLfZrt5UWvVjTxYbHLP1Nwg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Mar 27, 2022 at 1:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Duh! I pushed the tag to the wrong repo (peterz/queue.git)... I just
> > pushed it out to tip/tip/git as well, so hopefully it should all work
> > now.
> 
> Thanks, looks good.
> 
> There's a few merges that don't have good explanations ("avoid conflicts" 
> really is not an explanation on its own), but those weren't actually 
> yours.

Ok, these were probably mine:

  9cea0d46f52f Merge branch 'x86/cpu' into x86/core, to resolve conflicts
  8c490b42fe91 Merge branch 'x86/pasid' into x86/core, to resolve conflicts

Will add more verbose conflict merge explanations going forward.

Thanks,

	Ingo
