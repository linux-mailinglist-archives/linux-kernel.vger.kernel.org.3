Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C814EB4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiC2VEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiC2VES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:04:18 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819161890D3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:02:31 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 17so25117077lji.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEwk7SrxDcAHsz5P6yvShZS2UUbPB9dkayWlCIySMzM=;
        b=D/vCUe70JJj14QeGDq8uJpv7OGdDwFZj+0xhDISmJwIcY5H34S6kNGfMJXMstxOeNG
         cDhKpYNXjr11RSDmJHCWNRWtPx9oppar7CVul0HuYtRST0w36CWc5oznwKMEkkxZMNBm
         G+Alu2njjX2zbbyPWOPxoIPPFHjdjfLuLk1ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEwk7SrxDcAHsz5P6yvShZS2UUbPB9dkayWlCIySMzM=;
        b=5QnTa4LXCuwupg1muo0pTtxXhLj62KCtwEjcVbgNLlAPiVPIKWjgEnZOC6+jw6rJnE
         vbAkETq4YBpNf/2UlKVyB6cmbdaGV9EAWy0O55WaNAzxUBQX12BCN42nvMqUgWMwIrBR
         JtofSWUTfQuJfvG5vjQX84s0yi5Mp0SxlUFJJR1kNNE2JT9Lh2J7lADAr3MZGdpUYg/K
         Z28TXFkCN6FI5Glf4cmbgFkPkkSJpa7MNGM5MOdJDRD8m3GaYWoY3wnUXcC1W/ZfQ5p5
         hV9RqFv41WAfq5TjiQk4OZXi3kNxMgk00u5rH8V2Rj6qAjbLXLOvmmobsd+7sEfdZ5D0
         rMyA==
X-Gm-Message-State: AOAM532GLkzrfm+38+TGy+J9Bb1VK45Gq3RyYZDwE0K/pGOeQIQGKXoZ
        cWiZo7h9tv59YX8M086T/vVwRoShwtZYKvfD
X-Google-Smtp-Source: ABdhPJyzSAArcoK5GM5+2D20aSjQoOPbf+v6uXFJT/gb90ziSlxS+WE7CfBzLbjfbBv1xxnwzHp80g==
X-Received: by 2002:a2e:9e13:0:b0:247:e32a:ddce with SMTP id e19-20020a2e9e13000000b00247e32addcemr4439510ljk.9.1648587749443;
        Tue, 29 Mar 2022 14:02:29 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id bg19-20020a05651c0b9300b002497beec608sm2200582ljb.87.2022.03.29.14.02.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 14:02:28 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w7so32432664lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:02:28 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr4395142lfv.52.1648587748065; Tue, 29
 Mar 2022 14:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com> <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67>
In-Reply-To: <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 14:02:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
Message-ID: <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     Fedor Pchelkin <aissur0002@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 1:43 PM <aissur0002@gmail.com> wrote:
>
> As for the solution you proposed, I agree with it: definitely the problem
> was caused by an incorrect alignment of max_fds. Frankly speaking, I
> didn't know that
> > sane_fdtable_size() really should never return a value that
> > isn't BITS_PER_LONG aligned
> because there is no explicit alignment of max_fds value in the code as
> I can see.

Yeah, I think a lot of it is implicit and historical knowledge. Much
of it is basically just part of the whole "all bitmap operations act
on arrays of 'unsigned long'".

That whole bitmap base type is perhaps not as well known as it should
be, but it's one reason why the allocation granularity really *cannot*
be a byte - because on big-endian machines, the next bits you need is
not "one more byte". So on a 64-bit big-endian machine, the least
significant bits are not one byte away, but seven bytes away.

Of course, big-endian is fairly rare these days, so your "copy one
more byte" would have worked in practice on most machines out there.
Which together with "it's hard to hit this situation in the first
place" would have made it really hard to notice that it didn't
_really_ work.

I will apply that ALIGN() thing since Christian could confirm it fixes
things, and try to add a few more comments about how bitmaps are
fundamentally in chunks of BITS_PER_LONG.

             Linus
