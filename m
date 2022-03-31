Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5534EDA64
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbiCaNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCaNVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:21:50 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B451184B77;
        Thu, 31 Mar 2022 06:20:03 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x9so16712923ilc.3;
        Thu, 31 Mar 2022 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qI4/BzfKEkPH9iOW5F30cxLQKnAua7M62vUC8CH6ij4=;
        b=fMkjsiqJXh/HuY2J0jAtlImPMR787h7K/zkt1C+F75EkXR9aVtUN/ydW3qOMTrMe94
         QwbDNYH4FbH/PJx9ERaKBCxP2CtMmwyclzudSU4E+DNIvVfbNBF3ddDQ6u5GSa69KOma
         yDWYgo02rNTWRVB5yJKz4Fw7SlLH9DJD/XAxAdkaeS+JjcfjA3pAeWG5vDfEvMn3kfnw
         PSaT6zH83DYS/cFFP7n3RGWGSMxiVVPSp23ToKQ+QdmkpfCx5JAKDV+fOwg5GU0SvOdM
         8I2lkvA8EA89VFOilVfJITD7pu5ePj7VLqxw8MEUIur+6yclKO6+kmrvyhAmv8kuKy+w
         qBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qI4/BzfKEkPH9iOW5F30cxLQKnAua7M62vUC8CH6ij4=;
        b=bx+tbgjKqQ5MgqXAZZTWnCNuYZ8hVjzp+4BTO8AB3VeGRgKTuzuEgMoi+pfP5b0oqE
         y3RHzzhJR+DADzjxeCQYSX1og/1R7RrLmaJqTm4nNuQbUY61oBZ0ZaKfbKwaG9qU1ER6
         fBAqogOgtQzEha4iPCZJhktQ1YuysznkipbhuiqVMX3CtrQHJQ/B4hgrN2NeRRF9M2Lj
         6yNsrt2DXWm8niaOTe08DZ9JI/xEDxJb6dhfMdJw6QkIjuyZlCVQUinNEGvjZSg+hOUg
         pBiJmvX3TIqAPMWEHJuzq6r5ghBYeqVnIoWYbZhJoDAezJdhPrRV0nNTT+3kpU4iKxGc
         5muA==
X-Gm-Message-State: AOAM531g1m+bkjHAVlL2bxVwdKeu694JbluGy72q8YFp0k6/Lt7iAvFC
        H9bP3SwJrhVnBNKxEeC2cHVgpqUHa/k94UOYIas/lH7Xid0=
X-Google-Smtp-Source: ABdhPJzqNqNXkQgzmRZAsMPsfvwS4pmR9v2mVghCxjW9pymUlJ6yptmxbtLm4r9BAwf/zUTMKBY7jSh0x1+0ynVYju0=
X-Received: by 2002:a05:6e02:1609:b0:2ca:4ad:ef09 with SMTP id
 t9-20020a056e02160900b002ca04adef09mr495134ilu.72.1648732802496; Thu, 31 Mar
 2022 06:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220317181032.15436-1-ojeda@kernel.org> <20220317181032.15436-7-ojeda@kernel.org>
 <YkWhs1GffuUmZ4SC@kroah.com>
In-Reply-To: <YkWhs1GffuUmZ4SC@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 31 Mar 2022 15:19:51 +0200
Message-ID: <CANiq72mxXY_4wXZPO5VCX76G168X0gynO=n=1xP2shVWBm+yeA@mail.gmail.com>
Subject: Re: [PATCH v5 06/20] rust: add `alloc` crate
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>
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

Hi Greg,

On Thu, Mar 31, 2022 at 2:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is a huge patch.  Why not break it into 2, one that adds what is
> upstream, and then the second adds the "stuff on top" that you need for
> the kernel.  Otherwise it's hard to know what is, and is not, upstream
> for us to be able to review from a kernel point of view.

That is a good idea, will do.

There are some files from upstream that we do not need, so they are
already deleted here (e.g. collections), thus what I will do is send
the first patch without those already and then another patch with the
modifications/additions we did. If you prefer to see the deleted files
in an intermediate step, I can also do that.

> I think you are trying to do this with the "kernel" keyword, but if so,
> why are you picking a "since" of 1.0?  None of that is described in the
> changelog :(

Exactly, I used the "kernel" string to have the additions clearly
marked. The `stable`/`unstable` attributes are required in the
standard library -- here the "1.0" is just a placeholder.

I will expand a bit on this in the split patches approach that you
suggest above.

Thanks for taking a look!

Cheers,
Miguel
