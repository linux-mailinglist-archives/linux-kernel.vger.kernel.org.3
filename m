Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5841549DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349455AbiFMT3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351737AbiFMT3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:29:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D245DD1D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:54:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c2so8243548edf.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yE1F+T2LeAVJ2bFwOtJHGbp283h9GhemqSHAeGwktA=;
        b=cV5JPzOcrWUkY/YCBj01CplxNVk0Ypz2tEFigoKe7aUyACwfxpLidnfRJxQUvCHXB8
         hXeDqzdFDhPl5UTeyCWepHZO/sI6ZgbBgwwQXwmZisuOyhVixvoN3C2E6lXFMJOFc09R
         /Hv3Nw2iClVxh/V9udd7r9WBzL/nRXXjTHk6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yE1F+T2LeAVJ2bFwOtJHGbp283h9GhemqSHAeGwktA=;
        b=vQqDQU534fPb4TqkwoJZpY5ZMvwr01idJnm9JHi3rdUdJcmHq9KHOzQJeJTCbqXM7w
         Orx7kQ4PvZMAnIq/jYCoetgjobFqRImOvfy0xyisXxb8X21BTEhVXNHb0JZmoGYuXuli
         NPRwV9mYJo5Eh0KXAfx4/kn/BV/qF78DetjqQmcnpniKqkB2QGtD1viuDgWycFrbhM5J
         c2RD3wiIvFRtlV2djcQvzbNzDFUfQPw9oIE/nOyKkNKqMcnKeNvE0Jx8GwH2P+oSXMOJ
         dbmtk8ybiyrU5RjW8wFLdLFA+rY7w5NWa7TshkLCIhfFFGFlKxkt70dFV6YRV3Egoihq
         9gJg==
X-Gm-Message-State: AJIora+09gV78OzAJP4fqkOBjwe7GvsuydC/RkzE8a8mSWh6AAQSyjSX
        Voqt43aCwzuOb3Vtptr2Ldb3AhtDrIVYL1lX
X-Google-Smtp-Source: AGRyM1tjg56jNjPlCziy2KcuLRteGWDzW9zCH31ClOkzgtLqPRlTof6HpD47lOUZsBQMNkERe4VMfA==
X-Received: by 2002:a05:6402:e81:b0:432:7f12:1878 with SMTP id h1-20020a0564020e8100b004327f121878mr1004817eda.179.1655142893265;
        Mon, 13 Jun 2022 10:54:53 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b006feb6dee4absm4102475ejj.137.2022.06.13.10.54.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 10:54:52 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id e5so3404749wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:54:52 -0700 (PDT)
X-Received: by 2002:a1c:5418:0:b0:39c:3552:c85e with SMTP id
 i24-20020a1c5418000000b0039c3552c85emr16162741wmb.68.1655142892217; Mon, 13
 Jun 2022 10:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk>
In-Reply-To: <YqaAcKsd6uGfIQzM@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Jun 2022 10:54:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmCzdNDCt6L8-N33WSRaYjnj0=yTc_JG8A_Pd7ZEtEJw@mail.gmail.com>
Message-ID: <CAHk-=wjmCzdNDCt6L8-N33WSRaYjnj0=yTc_JG8A_Pd7ZEtEJw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fix short copy handling in copy_mc_pipe_to_iter()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 5:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Unlike other copying operations on ITER_PIPE, copy_mc_to_iter() can
> result in a short copy.  In that case we need to trim the unused
> buffers, as well as the length of partially filled one - it's not
> enough to set ->head, ->iov_offset and ->count to reflect how
> much had we copied.  Not hard to fix, fortunately...
>
> I'd put a helper (pipe_discard_from(pipe, head)) into pipe_fs_i.h,
> rather than iov_iter.c -

Actually, since this "copy_mc_xyz()" stuff is going to be entirely
impossible to debug and replicate for any normal situation, I would
suggest we take the approach that we (long ago) used to take with
copy_from_user(): zero out the destination buffer, so that developers
that can't test the faulting behavior don't have to worry about it.

And then the existing code is fine: it will break out of the loop, but
it won't do the odd revert games and the "randomnoise.len -= rem"
thing that I can't wrap my head around.

Hmm?

                Linus
