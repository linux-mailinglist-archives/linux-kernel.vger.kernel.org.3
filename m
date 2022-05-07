Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D1D51E980
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446877AbiEGTil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiEGTik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:38:40 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1216461;
        Sat,  7 May 2022 12:34:52 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z18so11414404iob.5;
        Sat, 07 May 2022 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EPV1tq5iQXlN5o6u1uQKnVmh0mUhbd20VSUHlRWzR4=;
        b=XbTM0zfScOdFdmLSSMqukZ6pOzmwioBml4veUlxHOy266LjxBFfGSEPYC5D/IQfJf+
         zaGPrj3WjWCmCSNC5McZkV7h5LieXldIxEH38S27pa/fFiudoY77V0/YQKMfeNj4J+6C
         zEhLBbhp/RxFL8fa11IrD2M0xq/cni+w3FSOkNeUvyGIIWSxsr+tbkTp/YkP1QMKKIuT
         tuSxl/x9LLEjrJ8+vKX8uqeTcrWdMZs3+w9BCjliUmpjsAAtlJig0NT8MYpa/WeoS7Co
         +bO3HiqrFzsdhSfHh3iuPzGpyr988APcKIE9bHG0nfDtIwLV+Gccxvw/w1fNcR9pmvgD
         MqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EPV1tq5iQXlN5o6u1uQKnVmh0mUhbd20VSUHlRWzR4=;
        b=G9LawHmUBxqlLBWjw3uIg/Afz1PWj9GnZHPOuVWhnsjIlKnedK3ARrZLMtZit6NqiL
         EBU0cjGfqAZ3VAJGy5IUsvZM0bSoL/VfjKW0yfdFHh9m/QCYi7s7gcNCxDC+290McuKp
         +f5hqE5fvjAy9O+BArQeyxh28ZjXUzpJzIh3+mbFnHI7ZbDE+k/6fMIYbxGZfMj7X8Xz
         sfpOhnKb4JCQ/sphw3ZtkVgf6sz8Ep/g7TyZWqVnGB7NY8ug+/lR/EjQMH4NhzFWx0SP
         GR4hG/Rh6VDw0w9HqufZWU7XVKkV/KQCai4PLcs6PpP4MYBxMqrS5yEtWJuadt/KCsKK
         lCyQ==
X-Gm-Message-State: AOAM5326q2bkx3M3ZDOT/eMw2IP3xR7OhebYVbwFk2xv7JDo1Ft1/iuN
        zrUg7nca3Z27Cyurivuv04kPbrxU0VmUQj7r6AhFWRwbv3+3yAwIwmTcXw==
X-Google-Smtp-Source: ABdhPJyloaPRyyYq3HykEn0aOwDUfRTl2CP9U9E60ul60PYjWeGpZThuzpON/w1g41EQhu/47C+p5umydPohoNy7Syo=
X-Received: by 2002:a05:6602:1341:b0:637:d4dc:6f85 with SMTP id
 i1-20020a056602134100b00637d4dc6f85mr3588894iov.155.1651952092210; Sat, 07
 May 2022 12:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-8-ojeda@kernel.org>
 <CAHk-=wh00UW9i+hGYjmLZW5MOAti9FFBarGBL909k5PfH4r2fg@mail.gmail.com>
In-Reply-To: <CAHk-=wh00UW9i+hGYjmLZW5MOAti9FFBarGBL909k5PfH4r2fg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 May 2022 21:34:42 +0200
Message-ID: <CANiq72nhKFFVHA9ZAfWw7=RTTcp_TUsgh8ENGsF8Gn_Qi=D2CQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/23] rust: import upstream `alloc` crate
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Sat, May 7, 2022 at 7:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I agree whole-heartedly with the "import the original, do the
> required changes separately", but I would like to see that original
> import really explicitly clarify the license status, and not require
> people to dig for it through external links.

Yeah, I should have noted the license in the message since now, with
the split patch, we do not even have the SPDX identifiers.

I can also add an explicit mention to the `README.md` file in the next
patch too.

Thanks for taking a look!

Cheers,
Miguel
