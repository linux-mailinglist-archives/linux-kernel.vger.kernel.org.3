Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A044BA9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbiBQT3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:29:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbiBQT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:29:35 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A113080D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:29:20 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id c15so934564ljf.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnyxuwnOdncpAS1xjev/hDqsQLHcd0tj4FHfjQh+CjA=;
        b=ccyryMdiEgcpSRhX4gZCak+kU2OOJEhmxeA8qlEM6a2ghuWU8vd7dkFdwO0zJWFCGE
         LZFHOcHEC0222TD79XiavfVFIhgGW/RshNy3NhkdBTcOInA1YOb1YpQKhwsF95d+cEhQ
         ZPUpqx7oG3OqCckvUe/VD6eDfTD/KoBk1AXwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnyxuwnOdncpAS1xjev/hDqsQLHcd0tj4FHfjQh+CjA=;
        b=UbnOG1riuOFM1EODl0GgVFxJQiVLSjrolv4p0rZIGscYmF6h9Ktc1KpXdZ1mQMcLqG
         jkOArhylpPGIhvol5oFgXlPOWnzX92Htfy/FEFmJLO6wtWO6OrG13sGDt+PXYx+yhO3a
         nJwx840UkCNXnpNxKkdC2i/2aD6NMtIxtk64cRpSbz4LUIBnWYibO+cKeDmW59/cLthR
         toBalOgWxMTUtH7kvw0scSiCVPU/xBZPoraCr+OlurHykPaVXZLRPyGjybm4nD/e6lNJ
         fsD2JX8d8byacf4Y5IpUuw4eYGdgS3oesjmT2GPJzfrJvGmL0JaTasN/KBONXR4vHoKM
         qfRA==
X-Gm-Message-State: AOAM531fnzkmhTufX3ycQE3EFUbgtqo2/RxB65tTIiAqITpZPOHDendr
        qkhbqC5qu7IikFkQz4wwBjWaZgJBEcO074Tr
X-Google-Smtp-Source: ABdhPJx95Eo7fU8EXP2q5n/AbQGJhfEGjqTvWhjRG+RedqOlY5Lpq5MdU9N/P+lHpTw6+XkUZT/C2Q==
X-Received: by 2002:a2e:86cb:0:b0:246:12b0:940c with SMTP id n11-20020a2e86cb000000b0024612b0940cmr3235382ljj.40.1645126158866;
        Thu, 17 Feb 2022 11:29:18 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id z18sm46324lfr.256.2022.02.17.11.29.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 11:29:15 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id d23so1103101lfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:29:14 -0800 (PST)
X-Received: by 2002:a05:6512:3042:b0:437:96f5:e68a with SMTP id
 b2-20020a056512304200b0043796f5e68amr3071125lfb.449.1645126154304; Thu, 17
 Feb 2022 11:29:14 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com> <20220217184829.1991035-4-jakobkoschel@gmail.com>
In-Reply-To: <20220217184829.1991035-4-jakobkoschel@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Feb 2022 11:28:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
Message-ID: <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

On Thu, Feb 17, 2022 at 10:50 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> It is unsafe to assume that &req->req != _req can only evaluate
> to false if the break within the list iterator is hit.

I don't understand what problem you are trying to fix.

Since "req" absolutely *has* to be stable for any of this code to be
valid, then "&req->req" is stable and unambiguous too. The *only* way
_req can point to it would be if we finished the iteration properly.

So I don't see the unsafeness.

Note that all this work with "speculative" execution fundamentally CAN
NOT affect semantics of the code, yet this patch makes statements
about exactly that.

That's not how CPU speculation works.

CPU speculation can expose hidden information that is not
"semantically important" (typically through cache access patterns, but
that's not the only way). So it might be exposing information it
shouldn't.

But if speculation is actually changing semantics, then it's no longer
"speculation" - it's just a bug, plain and simple (either a software
bug due to insufficient serialization, or an actual hardware bug).

IOW, I don't want to see these kinds of apparently pointless changes
to list walking. The patches should explain what that SECONDARY hidden
value you try to protect actually is for each case.

This patch is basically not sensible. It just moves code around in a
way that the compiler could have done anyway (or the compiler could
decide to undo). It doesn't explain what the magic protected value is
that shouldn't be leaked, and it leaves the code just looking odd and
pointless.

                   Linus
