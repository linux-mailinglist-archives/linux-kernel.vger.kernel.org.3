Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA55060E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbiDSA1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiDSA1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:27:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A211FA51
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:24:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u7so26673592lfs.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=md4M0Y06YB9OwRf1R9+bPl4STANxF+Va3/xyN7ba6pk=;
        b=YHnXBJFEjNeWLyKdoGJR+IzEBZ9L2j8NK6AQmfP7o0gC2RYvJmv5M5CsqaSmsoSanK
         SzE8eW1lYQqdm1V2biGeFhg45yH3PhMA6bcbPKzrCNdzRN8HI6iQOLsh023owaOqWvmd
         GrAyY7jzy++wQ4CGTLA7J2/MUu03/G1YWD6YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=md4M0Y06YB9OwRf1R9+bPl4STANxF+Va3/xyN7ba6pk=;
        b=qGiKf98F0vd+hnXiyTR1yyQlfdky+CSUZVQ7BBb99VBrJ8BN4QkziS0dPoqrnBd/Zu
         tIaBTdr8D17/uoKt9xOq7IvV2wc5PNqp7vF4VJr+MkcBqCEvs063r2ELA3joTOTDnUPb
         L9XnUtQcwTMItK2qOPyu6828urYQGeb+kRhMmStaZ76j/GlGoQkio7U8y17lP26V1Xzo
         G0nFnw35LOfRcJFJB/tvhEON4NGzdYZzFG7Uy9vw/448da8gnMRZ0xQsiQCw1TqujFn6
         rokon9cEThKXKoxW6u146SmFL7b6JZ2hG0Qm/QoPTHFTapIctYSXUbMQTB/VxarBK/Qi
         udMQ==
X-Gm-Message-State: AOAM5301/snJcxBtLtgRwF9SXVDK3+X0RAHZp2h1/Ra2U4YBI+L5RoMk
        evK7Pa+g6nWSA2xJxSj1IXFuDr0mayd/nAwyOIw=
X-Google-Smtp-Source: ABdhPJyfAjvR9Q/f9MkLgHcwd7hWnqHzoVxybonlM/pDx4vjiS1Rzsa4Oh0n6KY9EI7meY9VzB1oOQ==
X-Received: by 2002:a05:6512:4c7:b0:46d:3cf0:4346 with SMTP id w7-20020a05651204c700b0046d3cf04346mr9432732lfq.216.1650327870118;
        Mon, 18 Apr 2022 17:24:30 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id l28-20020a19495c000000b0044a8abcb589sm1351827lfj.186.2022.04.18.17.24.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:24:29 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d6so8984483lfv.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:24:29 -0700 (PDT)
X-Received: by 2002:a05:6512:2291:b0:46b:b72b:c947 with SMTP id
 f17-20020a056512229100b0046bb72bc947mr9478367lfu.531.1650327869174; Mon, 18
 Apr 2022 17:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
 <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk> <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
 <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk> <b0167ea3-55ae-5e4e-7022-4105844b0495@kernel.dk>
In-Reply-To: <b0167ea3-55ae-5e4e-7022-4105844b0495@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Apr 2022 17:24:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqzkoYZ06Bn0Owy-tQt_jK1uSTFd6awUQAAGK4rysD1Q@mail.gmail.com>
Message-ID: <CAHk-=whqzkoYZ06Bn0Owy-tQt_jK1uSTFd6awUQAAGK4rysD1Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2=5D_fs=2Dwriteback=3A_writeback=5Fsb=5Finodes=EF=BC=9AR?=
        =?UTF-8?Q?ecalculate_=27wrote=27_according_skipped_pages?=
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
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

On Mon, Apr 18, 2022 at 3:20 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Here's the thread:
>
> https://lore.kernel.org/all/1295659049-2688-6-git-send-email-jaxboe@fusionio.com/
>
> I'll dig through it in a bit, but here's your reasoning for why it
> should not flush on preemption:
>
> https://lore.kernel.org/all/BANLkTikBEJa7bJJoLFU7NoiEgOjVHVG08A@mail.gmail.com/

Well, that one was triggered by that whole "now it can happen
anywhere" worry that people had.

So yes, IO patterns are a worry, but I think the bigger worry - even
back then - was that preemption points can be pretty much anywhere in
the code.

              Linus
