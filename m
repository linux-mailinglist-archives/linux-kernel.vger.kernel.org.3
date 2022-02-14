Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9A4B500F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353043AbiBNM2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:28:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBNM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:28:07 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214FF13E25;
        Mon, 14 Feb 2022 04:28:00 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p63so19518112iod.11;
        Mon, 14 Feb 2022 04:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvWQQ93GGa/cxhrbK4uZHPlLGYXs90RAcFEchHXtn+s=;
        b=WelbK5oWneqgW3bTeoMBlpxWwUO1QgFcC8F9BXY10Fpd/GXLzy8bypglGZ61WkYivm
         V4jzCCE/xtJy3cMwyowQqQ1B9iEQnwI/3f5Aa6gvV8oK+09vOMrWb7lsErW4DlQc07U5
         LrijO3RyDDSV80qiRuKfinwQrEj8MrQaqTC6SuAMp0JjZMj4oEmVSzIW56Rf8T4/yJ6c
         FgpxcH0SU3caPqLherBcyzZAyyTsusueoMz3OSYI2cWFCB2lvsLDxMwP/gUMNbHwAzCi
         7FcQYKiMH4zCCDKylMWO/K+CKRNB0Gl12+/UsBylytuaxihkQS7UkTXxP5Z/hmsC6YHv
         aZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvWQQ93GGa/cxhrbK4uZHPlLGYXs90RAcFEchHXtn+s=;
        b=3Jb3Ia33BGuGFUy1GKkB/lVPc1YAZHS67Rlvi4JQAweN/r+1EbHkgg8M12qePZUT4W
         LEUyPrw39YXPnf3oYPa/CSsBwPmPtHNkaF2cLu9E+Lv0Ggns0FnYTMdRUFW1k0A3h0K/
         /sygVbHxg746KrvPHt5VQFUZmYVC8aPclrWLe2kS/I2JUWPmhfQaUZ4O3DWwA7yoV9m/
         BwIX5zOgL7mxPSjOIVw/Ogwh7IooFZvBRu2Q0Qxw7cWB+bbjn9RxvEfNFB5wco+XOHSw
         dK4ZK6Ilb4xXgmRBJojl9XUilfb/BxGweTQYI1RKAssXoHQtzT1ZFlJpXSbm31CSTmVo
         PRYw==
X-Gm-Message-State: AOAM532MAeyBWE8FBZJBVTGumPnbKVreTxupmPEjag5MvlscolzrRYEF
        zceioYi6+eYwjfVRu6W5y/5Z8oDwAHVGg/8InOgW8mpXTE0=
X-Google-Smtp-Source: ABdhPJz+8EOyoQjWdVYWF+DJmxzChqKM9QGjxymG++sF8/eFcWcj9lLTDgfo2dBDoPwIw793n3ekmd/i5hII0SE70AY=
X-Received: by 2002:a05:6638:382a:: with SMTP id i42mr8339322jav.256.1644841679469;
 Mon, 14 Feb 2022 04:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-1-ojeda@kernel.org> <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com>
In-Reply-To: <YgosclY9ebD3t020@smile.fi.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Feb 2022 13:27:48 +0100
Message-ID: <CANiq72mwkSo-W3QcyMnQ-o1COA5YJt1Ab9Xti7cdG6Krz3Sj7w@mail.gmail.com>
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

Hi Andy,

On Mon, Feb 14, 2022 at 11:19 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Not sure I understand this...
>
> ...together with this in the current SoB chain.

From my reading of `Documentation/process/submitting-patches.rst`,
this is the case I have to use:

```
Example of a patch submitted by a Co-developed-by: author::

    From: From Author <from@author.example.org>

    <changelog>

    Co-developed-by: Random Co-Author <random@coauthor.example.org>
    Signed-off-by: Random Co-Author <random@coauthor.example.org>
    Signed-off-by: From Author <from@author.example.org>
    Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
    Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
```

Do you think another case applies?

> I'm wondering if you considered to use %pV.

Please see Rasmus' reply, i.e. we are using Rust's own formatting
machinery (the compiler validates the format string and creates an
object that represents the formatting to be done).

Thanks for taking a look!

Cheers,
Miguel
