Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4807F49D2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbiAZTzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbiAZTzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:55:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89B3C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:55:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id n10so712715edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDOhpqDLAkmVNH0vSKJoGMou1SGqznw9FL9tts+vhro=;
        b=pk7kVJBIVlARurWljVTuYqW6e9/jhw0DpwpRvNzFAwwMjW7CJN9QYc5+ablTU8ExNw
         YnjgmMVS+c4tUnC+cGYGxu89gK/xkRz5f1irk8HUJdyF8JvPcdIplIbxX54exyKv+9hO
         IiAfL4Exm3Jy34fbBrKIK1fPhixkzPZFmCU9HPxs191eGw1V4AkEvxE+WJcz29D2nD11
         uoI9j3OkdZh/ptyRswPcP435zDLxYSrTxnrRVia4OgvMYuarlTNCxa6Rc6OHRSDfPtIS
         ab4nyCOgMr9QtUfptZuL6ZvK61bW6UtJcV1hSxWDHsMzgQAq2mMyRpoxO1aY8Ujb4rsv
         cqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDOhpqDLAkmVNH0vSKJoGMou1SGqznw9FL9tts+vhro=;
        b=ITt35p6Hq/UDs75SQZntXwfz4WEmw3A9/SxhNfJBgwlZzXAj6cpOzfNPQ/b4oAXhqz
         YWTnbWKt378hoVJaSwbevX/b1o/OvLOkeqeOxhxclOpRIL6aFxf2AI97pn4mfyKN+hAR
         yZSn04FydAFvVXUQMhVYilFT4yz4NZiIvlu+ApPYK7i65Ijv6Uz6RgPnFhau3ZPev5zQ
         bGDwm4jtGrtBfRYqlBM3Bp7JRRdeXn5/IDKNF3PxWMaQ910cW/gZcM/ouJfkEY0gVyg1
         hiIlLd2lK695+lcBSKeWmPzs60jbCrbq5wtd+lmDmv2iOMLxrSHY5I6euy0H6V1i8aes
         3B1A==
X-Gm-Message-State: AOAM533JvXYvZf671FLM3zjDHqfGDXqqOCoyhyT52/+U0mjzZ0N4AmQI
        PrIVaFtHwPcZN+kcZpSPKv4LXCOP2E15E9CYGUDvxw6b0jI=
X-Google-Smtp-Source: ABdhPJx4K0Neb27vIAtnMj1Uwp4kN8pHfXJ2st4oEx9Np1EhPwv8cyi4bSuNBisch9FfiGH1BktGNVqU9yuOH6bHmEM=
X-Received: by 2002:a50:eb46:: with SMTP id z6mr520229edp.229.1643226951036;
 Wed, 26 Jan 2022 11:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <CABVgOSnY8Ctc9vuVX+Fjmmd3L5kpXnzMXJQ0LPXAgmjCKsrYYw@mail.gmail.com>
 <CAGS_qxqx+wcruc7DAD9TQjk27OF+VDo1n9S6atRx+dDG5cr=6g@mail.gmail.com>
In-Reply-To: <CAGS_qxqx+wcruc7DAD9TQjk27OF+VDo1n9S6atRx+dDG5cr=6g@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 26 Jan 2022 11:55:39 -0800
Message-ID: <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: tool: drop mostly unused KunitResult.result field
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 9:19 AM Daniel Latypov <dlatypov@google.com> wrote:
> > That being said, I can live with the current solution, but'd ideally
> > like a comment or something to make the return value Tuple a bit more
> > obvious.
>
> A comment to explain that Tuple == multiple return values from a func?
> Or something else?

Friendly ping.
Do we want a comment like this?

# Note: Python uses tuples internally for multiple return values
def foo() -> Tuple[int, int]
   return 0, 1

I can go ahead and add that and send a v2 out.

FYI,  if you do this in a REPL
>>> a = foo()
>>> type(a)
<class 'tuple'>

The syntax for `a, b = foo()` is just using Python's unpacking feature, i.e.
b, c = (1, 2)

So it's all just syntactic sugar around tuples.

>
> Also ah, I thought we had more instances of multiple return in kunit.py.
> Looks like the only other is get_source_tree_ops_from_qemu_config().
> isolate_ktap_output() technically shows this off as well, but via yields.
>
> >
> > Thoughts?
> >
> >
> > -- David
