Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A446E4B5402
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355461AbiBNO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:57:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiBNO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:57:11 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BBE3A7;
        Mon, 14 Feb 2022 06:57:04 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q204so20114184iod.8;
        Mon, 14 Feb 2022 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wjjfBJTHVR77cJojmNBJ1i5dhw4Qwn0QVEdcG6oxsc=;
        b=hh4pBTf9ur8dzkv51kW/C+DeY33uYcyBGBgg0VR1XnIoc23JbQX3XKwApsVcVk7fm6
         p6+5IfZT+Imfn2M1Cmqvz2nI7NyGHGAj7wdElysReCLzKzOUfD92u7eFTeyXM9gY/qq4
         9x/ptYrJNoJ0vaypJp9aK8LRC1ZyyMFy52YjL6M8DbKVrIkXRcJjoYlqXpk6ALNJ/nI5
         Sb24Jfbfy7wUCnX/2lzOO2Fg9hNSb98JRvJlZ87tOqGQ6bcH47vKVVNEzTwi9K8VpUiC
         bTtU/76ut22G7XPCZgO2BQxhRpkVX2k0L2M9sDgB6m9LzLVYRWBUI7VS8sGvYSOUQ1kF
         Vbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wjjfBJTHVR77cJojmNBJ1i5dhw4Qwn0QVEdcG6oxsc=;
        b=2LxT4VqpttlZA7zVULNg+W/FIXyZuAT/qrWlnMNaFpzBuzsOci/F+tFY47IvkDPwGD
         xSBzF6MegsSIE+ylYrETxv9yXtxibVR7nIIKN/Z3KqkLt9dVQiJmYIcbJsi5zkeFT2cE
         lYeDiNypZEeHgNm9b01Yv0pIypOFfvh3JPntdbi8n6Q8bQsweQRYGTwKH+3Vka4YT4XT
         EgpFn5McQHeYsuL2YCJt7Unlu6hXQCGQ5dVR5qRI6R1ypWQ+9PwY5MvZKufj0vPQ3ZH/
         xbtIo3i3Hnho/gSDShiuG6SaRE1OBe8d2R9L7dKEuBeebZuviGdDOYnKsA5/emnLwkfR
         GWkw==
X-Gm-Message-State: AOAM533jaYvG9t0wpyGhIgMyhzITeeOugCrfB5ajdFSCoDVfJCSz4Wg5
        cCrTPf3X8hfP4s78Y3EEelI3pSs6QgVEkSWjkIE=
X-Google-Smtp-Source: ABdhPJxosHBxj7hqy29aVW0n1kT3sjEYloRtO4mxkIDCxuCvExFgJ3l36E9TCrzrRfRbsh9bHnRvN8PMuenDg6H3xSA=
X-Received: by 2002:a02:aa09:: with SMTP id r9mr13122jam.199.1644850623735;
 Mon, 14 Feb 2022 06:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-1-ojeda@kernel.org> <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com> <CANiq72mwkSo-W3QcyMnQ-o1COA5YJt1Ab9Xti7cdG6Krz3Sj7w@mail.gmail.com>
 <Ygpe/zalrTRFpNwg@smile.fi.intel.com>
In-Reply-To: <Ygpe/zalrTRFpNwg@smile.fi.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Feb 2022 15:56:52 +0100
Message-ID: <CANiq72==eqLQ56=1+gpBRUipNw=Bv0BSqRapm=va4wWNsjVmMw@mail.gmail.com>
Subject: Re: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Mon, Feb 14, 2022 at 2:55 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I see, thanks for elaboration!

Anytime!

Cheers,
Miguel
