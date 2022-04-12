Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708E84FEB15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiDLXoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiDLXn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:43:29 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69806EBAC6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:25:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 17so236497lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEf3ghNJkoFaoWuY+1wI1QnhHwrm43YYsrClV3MyqfI=;
        b=REbi327RrkR6HSTgkHSf+nZ3SQfIOuOq2YEO+YINnAhIuEKbRbk23Oj4KWA5yWFdXF
         pBvcZAq7HFUQl0JgP0of0X9f+/dcqWixfDipfytfFy4mshNdYQsjyIWrzcStRvzJxz72
         pzBvPQjmX1wRRKbyjJuqOV/6DQkkGws4nvIkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEf3ghNJkoFaoWuY+1wI1QnhHwrm43YYsrClV3MyqfI=;
        b=wMmZrLhoPusyb5gjH6G+n8vbBnNIazHQjYAXPIQ4i4+QG7tho7CfWkn4efsK2hjogI
         VthZXvwHPxc4w13lKcddqe6F4QgA41fqvKxVENT6DT62wG49y3Lh6e1eppP9kPfkNWTN
         lyelf+lNfcYyODjhRxcFr2gQORQYMiQZbZosuzw/kstvhfJd+B0y/OgCjgLlESM7ZyKC
         b4EMT8VGp51rSOJHqQ44TEubHbtIkIU7frtX7SByx4bXfhhwNttLg/W/XC2cJ1YyPbBJ
         Z57HRsqjccUHv2F8cklwx5XOCjPXoVJN4Q1T4/3ruvD788wXIdQ3E2SzODPsxjoW5KSK
         BZkg==
X-Gm-Message-State: AOAM5324avWeS1cx39fO6nlgOiQKuXIUq3sDjWEt9GuxoFNsCg3/e5Q2
        2g3ZueA8EwydOzVl0eOjWVai+M+NdBp98ECX
X-Google-Smtp-Source: ABdhPJy5NyPw4C81VjTM7ObOP4ccxsGyGvbGoOMHDyyGsjfyxN2iJkmXo4SZAwHTztXoN1q4sQ/XBg==
X-Received: by 2002:a2e:918d:0:b0:24c:84ca:199b with SMTP id f13-20020a2e918d000000b0024c84ca199bmr125278ljg.339.1649805920474;
        Tue, 12 Apr 2022 16:25:20 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id z7-20020a195047000000b0046bb9225f5fsm407771lfj.234.2022.04.12.16.25.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 16:25:19 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id x33so545314lfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:25:18 -0700 (PDT)
X-Received: by 2002:ac2:5483:0:b0:46b:9dc3:cdd4 with SMTP id
 t3-20020ac25483000000b0046b9dc3cdd4mr11503890lfk.542.1649805918419; Tue, 12
 Apr 2022 16:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
 <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
 <alpine.LRH.2.02.2204120520140.19025@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiJTqx4Pec653ZFKEiNv2jtfWsNyevoV9TYa05kD0vVsg@mail.gmail.com> <alpine.LRH.2.02.2204121253260.26107@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204121253260.26107@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Apr 2022 13:25:02 -1000
X-Gmail-Original-Message-ID: <CAHk-=whu4qvXYPwh3HS1bcJMOuMiap_g8=EqcHb7P3TQyvM6Cw@mail.gmail.com>
Message-ID: <CAHk-=whu4qvXYPwh3HS1bcJMOuMiap_g8=EqcHb7P3TQyvM6Cw@mail.gmail.com>
Subject: Re: [PATCH] stat: fix inconsistency between struct stat and struct compat_stat
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
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

On Tue, Apr 12, 2022 at 7:42 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> As long as both major and minor numbers are less than 256, these functions
> return equivalent results. So, I think it's safe to replace old_encode_dev
> with new_encode_dev.

You are of course 100% right, and I should have looked more closely at
the code rather than going by my (broken) assumptions based on old
memory of what we did when we did that "new" stat expansion.

I take back all my objections that were completely bogus.

             Linus
