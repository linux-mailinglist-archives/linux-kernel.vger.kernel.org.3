Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F069F4B52B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353707AbiBNOFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:05:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiBNOFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:05:06 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1432EB7;
        Mon, 14 Feb 2022 06:04:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 9so19982944iou.2;
        Mon, 14 Feb 2022 06:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHEGfZ3YRrVciF6Oo6i+MibRKMrhVrq5kkV+eP8TiLk=;
        b=TAOFGbHmG6Cx0rrMUNbeeEYtTCkUNLgBhBRu4cOqLqcE/ScrB523kOUeeQS1syouQj
         KxVY95pUUVjikxNMl1NEv/6faqgWJOCcBlGtKxgNsVbF45yo2Dof7/Z+q8UO+KKAPT7B
         QZEIPguA8QYO9ytJNBTtllbej2ItAF2BoX07tmUUSzRhPqQMJymrtCj9mCELnEvSIPeH
         2CJqdcfPtxQdmuUCYnYpLe6EfUA+ddsWxOidIoeJS4OvpvIMImxCVjZe3oLqE0Tu1evR
         fw3VDnk2Wk3LyGYTzchLNrceZlrK5HZTm4nMIuBOAfN+ZsuMGBOwOAhZyh6aYgASHMIs
         46Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHEGfZ3YRrVciF6Oo6i+MibRKMrhVrq5kkV+eP8TiLk=;
        b=YRpXqUNhBqt2CGfXerbDUcG6zoGyithB/XHs/1wgR+gxpjzjOzF8f1aem6zvZRxPo0
         16WrOFaTmFfth/GvblieZEToj+D84VPkHbZqI9hWCVg70SfQxYzJcW1HKDxIJ+jO/UMJ
         GowNc5yvmT3ffM3ONKwUdOlcAewUFBh3+PJgmgK5stzwGztKZPG5rWaE06am9jSflnr+
         rsdYMNSfDcCdeL/WoVSU9vfmTwZKNjsd8pnlszhHVGIwTVMGPjawWxX0ExOC6/nTytOs
         JmaXWiOZAqu22/8DfweFX1YaWE45Me80xNwB/0cnHBz2ISvMel62BNk2ZEPtRiN8YNrr
         EgPg==
X-Gm-Message-State: AOAM531hWtqr8L0a9RiOhkpbtT585v+Ljd65I977WeHXXjzYpYMK89zQ
        QZv2pznz/E6CEEjtFTlHSHYxy2lC51z/aqbSezE=
X-Google-Smtp-Source: ABdhPJyPke3qs5CLlB/3IzvISs1jcziUjjl48Cutud97xAyt2ICObNZ2ViCm3ZyUsmUIY23at5/aTLV7B3qmZOhZmMM=
X-Received: by 2002:a5d:941a:: with SMTP id v26mr7493818ion.64.1644847498530;
 Mon, 14 Feb 2022 06:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-1-ojeda@kernel.org> <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com> <dc9054f2-5e2b-0ae2-1022-23421668dd05@rasmusvillemoes.dk>
 <2a7dff8e0efb4142849802357284af51@AcuMS.aculab.com>
In-Reply-To: <2a7dff8e0efb4142849802357284af51@AcuMS.aculab.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Feb 2022 15:04:47 +0100
Message-ID: <CANiq72mVsvfdyw8=OtSVbZqm43kjnH2+fUg40_j96BkdM0RtVQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
To:     David Laight <David.Laight@aculab.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:37 PM David Laight <David.Laight@aculab.com> wrote:
>
> Doesn't that stand a reasonable chance of blowing the kernel stack?
>
> vsnprintf() is likely to be on the 'worst case' stack path anyway.
> Anything vaguely like a recursive call, or anything 'stack expensive'
> inside vsnprintf() stands a real chance of overflowing the stack.

There should be no recursion going on, but stack usage could be a
concern depending on what the formatted types attempt to do (thus we
need to be mindful when implementing `Display`) and what the compiler
could possibly generate on a worst case (Gary, bjorn3 et. al. may want
to give details about this).

Cheers,
Miguel
