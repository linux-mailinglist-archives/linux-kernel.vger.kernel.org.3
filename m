Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A944D3B82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbiCIU7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbiCIU7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:59:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F2862A1B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:58:21 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r7so5957035lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rb1xRrIzaTsXw5ggh9HnMsREf0OUT8EznCjFLR6Tke0=;
        b=XZFXja1i5rQb5XdOAmekW9zg/6hHAdnoz1qTfYcCGVqEela6f+IXzW/TDT5tOM1/lY
         mnlzGppp2H6pBA/Un3GU+l/f2ye3YXwiPbEstAnFSeyuj9kJFvMZCgVXKfit2c0fgo2B
         ZVSmJ5e2eppMQoSI6c9JeU6WDhCTVZwrMtOXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rb1xRrIzaTsXw5ggh9HnMsREf0OUT8EznCjFLR6Tke0=;
        b=0oCRuWySnDZY0ihiaT0GBBLAH7VzMPVKy1t5IgcQBkXLQChyGzxCo4B6IZZc3oSQSN
         ZsPJ0kBUbk4yw1tzJLXWmxqYAt8uh4LK0K9o1gYh5gDh+gtrEYl4mMGpIyi4DyxWOMf3
         YWaO6p5oE1FHMxg1WVUvmA/UWY0SchjQOIXaEI9xK6N03w1EvY5uWVoQ+t5JBjgDHgMP
         kUiZ6gFz/qSgRWXCTmRCKgcGNPlSMBrbbSg8gUfZzOVmFSIZYmfPtH5CZMGpXAjH8dTq
         qVYLo5xs4RdHPFfkISGXMFRUPyKrxYEnQhG7jV+445mpXpGA9X5NAPnKR17smeB7WCy8
         DqAw==
X-Gm-Message-State: AOAM531eHeq4Eo32CVgtHrNF1zEJ1fTHfPSNhlm8CZ76/bzq5X9l2ylf
        u3yymLKU6/7cT/kEKAoXqYijpApFia+Wb3wwzsY=
X-Google-Smtp-Source: ABdhPJxbXUMIV5oWrab+e7sOkgcIvihO61Cgq+K4JicrjFKGCZK7uVqdQpoZteArEsYs0ce6fWclUA==
X-Received: by 2002:a05:6512:3890:b0:448:21bd:28d with SMTP id n16-20020a056512389000b0044821bd028dmr919962lft.376.1646859499560;
        Wed, 09 Mar 2022 12:58:19 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id bu20-20020a056512169400b0043eaf37af75sm580625lfb.199.2022.03.09.12.58.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:58:18 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id bu29so6048215lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 12:58:17 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr940626lfi.52.1646859496995; Wed, 09 Mar
 2022 12:58:16 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org> <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87fsnsdlqg.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87fsnsdlqg.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:58:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHmg7UGPotZpvWsztW-p75yFCSNxwyAkBq1-OzuOZrMQ@mail.gmail.com>
Message-ID: <CAHk-=wjHmg7UGPotZpvWsztW-p75yFCSNxwyAkBq1-OzuOZrMQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Removing tracehook.h
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
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

On Tue, Mar 8, 2022 at 4:16 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> While working on cleaning up do_exit I have been having to deal with the
> code in tracehook.h.  Unfortunately the code in tracehook.h does not
> make sense as organized. [...]

Thanks, that odd naming has tripped me up several times, this looks
like an improvement.

                  Linus
