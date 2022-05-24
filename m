Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC67532F13
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiEXQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiEXQgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:36:12 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094D6642F;
        Tue, 24 May 2022 09:36:10 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a8so2993252ilh.3;
        Tue, 24 May 2022 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmFSjcbYRYlOqfImBD2OeIVBU5WwbZg80H+QTxIdQPU=;
        b=mciQwgJaWq7HwzCb8KvTWDOP2zWsZae+0/adx/6lhqIctodu1qtPPyt9035Cze/Heq
         q35dm9UuaPHLZLxslEs1mbzpfW0TzsemtzTvDrqYKDEX1J1zJ13XrgZQSrM+vfhTzy4C
         Oc6SYF046ZDQbKLW8q/ei3gbmKf2rvK5wXHg/tSqupWjXPFraQtswRs1pUvA3IEedGzm
         GkZi47JeJ57CgAwMFGZGs8QTBhrI20LU1R+O7cHBhNmu7eRby+yApmVKjdwWIQjK9SvR
         4tdUt7NdsurhQt9cPFItmCZbejv69RNe0mXJggwt1K6z4bIo3UBLr19BpJcve0SPA2J8
         Gang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmFSjcbYRYlOqfImBD2OeIVBU5WwbZg80H+QTxIdQPU=;
        b=zV3t5uE0teQqsagfoYOvD1GgiSa7TjkoZyGLUMUXanJf7vz+P49agNhi4YbJp290NR
         21uettTLLWfCP3BPGxFUjevOw8JEvwLEoO0bAjxiVV4/q0L04FDAxagQzdJalZz5zZvu
         X5bf9yYZ3T7L12bUf+qeS5apVENE/NIT89YtvmCmzVRO7uKxVxPDaXdA9toVe9PBxKxd
         op2Pp5Ym23lKGhkfP0AFik9tL4YJMQ7sQ+ReFWWFXaXL9yQbc2qHrM5Cicm7IJnIf2zc
         az2eUVq5/7oV1gFd4/yDFUf/1f29NZRb4yRdHGcPiQX59ZiuDV0AtxmadQ13bPbBtGTl
         cf9g==
X-Gm-Message-State: AOAM531FBKUQjMwy6ACJt/XDpjfRGdgZwC4bdMaMqhW5Rzjy08Aza/cK
        X1pTXWceqzJr67s5Xyp4XPK8a6ZMvMGTchLJTa8=
X-Google-Smtp-Source: ABdhPJywJhE/YIF+b6PILr84uXn8uYcGO+p8BLwgZ+ThM3pV+lrwRjWdVZdHbYceReu8+NDab6Yvf1ef2V1xhADA4Is=
X-Received: by 2002:a05:6e02:1c88:b0:2d1:87ea:18c with SMTP id
 w8-20020a056e021c8800b002d187ea018cmr9279443ill.321.1653410169415; Tue, 24
 May 2022 09:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-16-ojeda@kernel.org>
 <9ff72e47bf89977efe00df6db6ebbdd7b22a9972.camel@perches.com>
In-Reply-To: <9ff72e47bf89977efe00df6db6ebbdd7b22a9972.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 24 May 2022 18:35:58 +0200
Message-ID: <CANiq72ktk0_drMnCCJGMRhQ6SCDEgz1R1Lc0bDSWjsAHgvdbhA@mail.gmail.com>
Subject: Re: [PATCH v7 15/25] scripts: checkpatch: diagnose uses of `%pA` in
 the C side
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
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

On Mon, May 23, 2022 at 4:17 AM Joe Perches <joe@perches.com> wrote:
>
> How many developers are required for a trivial patch?

We are sending the core series as a team, so by default I acknowledge
all the maintainers. But yeah, I could drop some of the
Co-developed-by's.

> and this should now use elsif

Yeah, will change.

By the way, I also thought about skipping the warning if the error is
there, e.g. wrapping everything else in an `else`, if you prefer.

Thanks for the very quick review!

Cheers,
Miguel
