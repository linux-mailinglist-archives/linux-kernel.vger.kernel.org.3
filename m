Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B733D5318D4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiEWUbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiEWUbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:31:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C3A473AD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:30:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i40so20592060eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nbUGzUOgeo3D78bqQ+maj5c5YVeZLaDtwoE3ePbgRg=;
        b=UoRh6ARF5eMZ2C6FMreRbDTlJm162xJ1tuzyHrHmFT/3Q36IbQO9iSO2ULmDGIDVQH
         b7CHe+V1XXW6hofsd5knxDERRWblVFbDlw294mOlszSHwfFAt+Ooh53PQLXip6K0VKv8
         P9wJy/F05fNoQo2LWS9tCQ4RrwAvpIXtMAvY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nbUGzUOgeo3D78bqQ+maj5c5YVeZLaDtwoE3ePbgRg=;
        b=REYqELFZBd4PGB8wXY0jLZiLdTtUTzR2VCXWPqZxLigfJy4VTPgeS6BNs3Kym6h+uR
         ItU9126aTEEc5E/tQf9CH/s9ORJXgn/hyOB0K4woH7RRg0gRn6ZIrceqA9noBp0vIoTk
         zaclwhC7U7FSfHGuk0ZKrJtBh0K9L3cfxt+3PeH/dClzTcW0ual5X3rkSxMx2sNTHyPW
         JLXPIvTbkSdw1PczHaGA+ORduf6L/KDYZBatRd4apKTY3iuIglp9rnfjckNPqky05XJy
         KMLoTP0lmKg8sJKkR1OjPNHT14RtvBI4GBF2F0Dv6HKAE8xhLRFRdebBbS5uDUIPfebF
         RTfQ==
X-Gm-Message-State: AOAM5335T9ThbYDcFdN0TNgssOfwWkIVMlVIA5c3rRECiNVTE42RVy+U
        omH0h/fUhySav++0yRls1FUfC3Ncxzf5aeejMas=
X-Google-Smtp-Source: ABdhPJxPHKH8vihPrZ/y3FXXHQtaX2w5uonzXwKn7sAsfMEhlFJv5Zrgv05+nIFskEaToZb58ow4/w==
X-Received: by 2002:a05:6402:34c2:b0:42b:66d3:7b07 with SMTP id w2-20020a05640234c200b0042b66d37b07mr7649696edc.275.1653337855486;
        Mon, 23 May 2022 13:30:55 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id ta16-20020a1709078c1000b006fec27575f1sm2721525ejc.123.2022.05.23.13.30.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 13:30:54 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id s28so22811622wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:30:54 -0700 (PDT)
X-Received: by 2002:a5d:58cc:0:b0:20e:643d:e46a with SMTP id
 o12-20020a5d58cc000000b0020e643de46amr19712672wrf.97.1653337853963; Mon, 23
 May 2022 13:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220520182428.GA3791250@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgpAHhPVSqBWb4gYT=CRJzKAZ4inmrL_kcpeNWGkcg3pg@mail.gmail.com>
 <20220523195605.GA13032@1wt.eu> <20220523202336.GB13032@1wt.eu>
In-Reply-To: <20220523202336.GB13032@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 13:30:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiX8P8atcx9at_N=-8pjU-d5cG509E=oZHfsVb1R41RZQ@mail.gmail.com>
Message-ID: <CAHk-=wiX8P8atcx9at_N=-8pjU-d5cG509E=oZHfsVb1R41RZQ@mail.gmail.com>
Subject: Re: [GIT PULL] nolibc changes for v5.19
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, May 23, 2022 at 1:23 PM Willy Tarreau <w@1wt.eu> wrote:
>
> So I've figured it again. When you run:
>
>    make tools/help
>
> you get the help of tools/ commands, [..]

You speak the words, but you don't actually look at what it does.

Try it.

Yes,  "make tools/help" works. Yes, it lists targets, and talks about
how you can use the "<tool>_install" target.

But none of that then matches the rest of what you write.

You talk about nolibc_headers". That's not something that is actually
listed in the help at all.

So please, can you read your own email message as somebody who doesn't
actually know the code, and try the commands you talk about, and see
the disconnect here?

                  Linus
