Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868CE5203D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbiEIR4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239788AbiEIR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:56:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23C2BFBE7
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 10:52:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bx33so7117817ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAaeELHVcQouTEd0XSCIAgD8jqgghoqAvViW4eNJ0ec=;
        b=b4o6yjanW6bwSXzeQddKdzJxs16LrwT2UIXAETG9ofvsVHdkcnTr0T5o6JTUSUSE2i
         qgKhEe/Z5Xcja1V2L0Ue+Ehk04kB2pz9pB82cVQgO4nOKfeuxKNE7ZICwRtrlSHV16Hw
         9+nUcwNaRkCd/xkufp5ozkCgdLhZhB1SK+7yBNQVXdtA2Vz1Hm7UikX9VjShaRZmrcjo
         RfhzezkdcQuRk7C2Bwo/Ph8L1kFONuZVoW5r0wh7jyQY2m44LBYr2tsA+1VzbA94c3nX
         IWMAZGr+UJW++q+lNKw7iUm90EVcYp8LIeNNadEwWcFLagXSZ2Xx2ESyUnGyoaBHSeZB
         ou8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAaeELHVcQouTEd0XSCIAgD8jqgghoqAvViW4eNJ0ec=;
        b=x1gcSqV9aMP/Kf4HQjub6wb5o5ihtfO91Z3T7RWbe1JxjriWDNoIcDLi/qmBBkPNZF
         aKTjTiHGFYbenrmJXYaHbGSnO29+1QBpIHP/HhO6bsiKFdgb3+SfzSJMASKOckICVSF6
         C9SvWEKewj0O/ZxfbvTbHcxPndrlsAKuIqwwtPHSEnFU67QxYcJO9v16UIHxVDCeoF/e
         GejsGYiQ/gMlTn7fZY58nIjoGzXmCF4EHW/vJ7xKAg1KTVG+yLM6SOyhtztJ+9jDhJbC
         OIuX4HOVcdrB9TFIKdNrdrnHmy91li07zSfFGJqJm4F3pTN6ZzyJ2ETsFFGjB69RvLpi
         Rd6g==
X-Gm-Message-State: AOAM531k2jOhLHRF8f1SqBPXaXmUvqikrAtyI3pGM/nhJcltRLLUY56Y
        yJP6zMPgMsTFSRHx/jHvlIDwbBqzj/8KIflc1TU0pw==
X-Google-Smtp-Source: ABdhPJxLDecK/fKBw2N/qZ9TbLTDtmzVJuxz6GHpR6z+gjd7Z7RShlYqQPsE9j+pLQmgJXqupOfPVeK3DlL9oESmh5A=
X-Received: by 2002:a2e:9345:0:b0:24b:451:7ce1 with SMTP id
 m5-20020a2e9345000000b0024b04517ce1mr11278276ljh.258.1652118762240; Mon, 09
 May 2022 10:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-24-ojeda@kernel.org>
 <202205070050.A870AEAC6@keescook> <YnYqHSVakm1EAo5a@kroah.com>
In-Reply-To: <YnYqHSVakm1EAo5a@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 9 May 2022 10:52:30 -0700
Message-ID: <CAHRSSExk=cnJDUdxChf3H283rumV1M_SL4T9seSLEBVDxcrhzw@mail.gmail.com>
Subject: Re: [PATCH v6 23/23] [RFC] drivers: android: Binder IPC in Rust
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Wayne Campbell <wcampbell1995@gmail.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 1:13 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 07, 2022 at 12:55:17AM -0700, Kees Cook wrote:
> > On Sat, May 07, 2022 at 07:24:21AM +0200, Miguel Ojeda wrote:
> > > From: Wedson Almeida Filho <wedsonaf@google.com>
> > >
> > > A port to Rust of the Android Binder IPC mechanism.
> > >
> > > This module is a work in progress and will be sent for review later
> > > on, as well as separately from the Rust support.
> >
> > Is any functionality missing for this driver compared to the C driver?
>
> There is no binderfs support, which would be a major regression if it
> were to be added.
>
> And odds are the new binder additions in the past few months are
> probably not included here either.
>
> There is a binder regression test in Android that can be run to test all
> of this to see what is missing.  That should be a good test of
> compatibility.

There are a set of tests in the Android tree at
frameworks/libs/native/binder/tests, but just booting and having a
usable device with this version replacing the C version is pretty
impressive. Can you boot and run a real device with this?

>
> thanks,
>
> greg k-h
