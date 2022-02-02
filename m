Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5152A4A7941
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346943AbiBBUOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiBBUO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:14:29 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77021C061714;
        Wed,  2 Feb 2022 12:14:29 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id w7so519913ioj.5;
        Wed, 02 Feb 2022 12:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWDWaWTdNFsu7zj2/HSMpGB10STG6alwvdijx5cjUpU=;
        b=COSS3HxAtjR8rd0qpXs9u+CYScJTI+x0WMNwVlPbA3D+crcc2CGAwElfdpVOVBapdD
         KWA3jogiyB/OTLPqN4v8xj6Rt/fby7q1UNaBBWm/29vcd4Qr4eO339PSuZb63uuggZQS
         QHyDAXaCUUzOK51hMskU8H3GIU2P4dotISNafBf0nUudOM5ert+oAwS17xUIhulv+oDD
         kUj/9RX0gquNppv9Y1fEVLQIX+kaNHLSUoEWoB5wYJlt4W8KPiUMtlJydGUe34qJhR5+
         b0R0/Mq9v/kUFwmhdApDTy73gbJhuLptH0n2unlok6Zz//j1FW/WFhvzMsxOxoTxp1U5
         2+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWDWaWTdNFsu7zj2/HSMpGB10STG6alwvdijx5cjUpU=;
        b=wKLu/C6CF9oAgec2QDykwnZ30ggPiJZIbYgGmK23XlH1o+o1wMbGghvZ/+4COiBNb6
         UiDJRlLPp7V4A32PBvXsZXYB46/I+kNe+SbMHWK0RtmJctjCAx/bCmRd4v1HH7fqifgY
         R2GCxRx2yOcOOHNic0BKqBwyv71xhYiExsxjhMhMryvj3YqGCQdAh4By+gwN8XrP28Z3
         p6fN2wlbtH2sXBP4tsIweNpxzP65T8Jk13xGYzlnScW4jXKRT7vcINwO+zX/U5QeTcg4
         SOWhq8hwuqMYc+MjVNy9+eA+88HGZ34NNmfrvWF5KUlMrqp37nA5P3oOWr8FWguwsHd5
         fkwA==
X-Gm-Message-State: AOAM5300OMHGhUQl0xvewJk5byPCl8SkjucPTCzV93TT5BfXKmVKexNx
        zJ0rdsxQ58hx+qkdG/YxKjZRzNRPuBzJfXmJEqM=
X-Google-Smtp-Source: ABdhPJzQ2focj1E8ocbpT49mPiCiGeRc/iwUWS1g1pv1rRyQg6vd6MhrYdR65zbsKH9YTxwj7kLrZrHEI9d7vEsQjr0=
X-Received: by 2002:a05:6638:380f:: with SMTP id i15mr15636715jav.308.1643832868972;
 Wed, 02 Feb 2022 12:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20220131204357.1133674-1-keescook@chromium.org>
 <dc86fdf7-3202-e836-6f71-af1e2458b105@rasmusvillemoes.dk> <8e166131c01b4fbc83a1ca95b83bc362@AcuMS.aculab.com>
 <4eb192f15c9078984c5e05a9fdc85ab6a9611717.camel@med.uni-goettingen.de>
In-Reply-To: <4eb192f15c9078984c5e05a9fdc85ab6a9611717.camel@med.uni-goettingen.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Feb 2022 21:14:18 +0100
Message-ID: <CANiq72=CHtyCV3Hbf9cSTpKaqNbZANrcW5uUfwp60G_n8t=USA@mail.gmail.com>
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
To:     "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "David.Laight@ACULAB.COM" <David.Laight@aculab.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 4:43 PM Uecker, Martin
<Martin.Uecker@med.uni-goettingen.de> wrote:
>
> BTW: I think it would be very valuable if WG14 would get
> proposals and/or comments from the kernel community.

Agreed! I am happy to help anyone do so.

(`memset_explicit` and `#once` were inspired from kernel discussions /
use cases)

Cheers,
Miguel
