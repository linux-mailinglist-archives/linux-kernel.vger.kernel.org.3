Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7D4BD138
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbiBTUNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:13:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbiBTUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:13:22 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796B37A20
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:13:00 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p22so14960801lfu.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFxI/E7GISHQoZSmk/0oS8AXoqkjxl7Cu/QeFTvV0Ys=;
        b=dnnhS450j/2Trb5ywwsqiILXa4WHzzPx8XIZdP4lB5VS0nlDpw5/RaI8iGmnF1bKXp
         BgJWyyrTd0n645DBU7Uv8OvZfuXr+eHfrWRH146QMxFda/S1HQav7o94a3+46wRg8tGK
         lMjskL7Lbw91TY3BtMevVeE9MtjinmRyll0kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFxI/E7GISHQoZSmk/0oS8AXoqkjxl7Cu/QeFTvV0Ys=;
        b=amwWklAx9knydQmV5RTfl0J0lyqZb2KGl68p8eHqyZ9xGmuGiRIRsDWna7pkA4aTZ4
         Z9vcTXBD2vA0BDJWECYfHgmOBdp0rD4FPDbkZQQR8K6IDwCc1Bqol6SiX4Kqs/D7FkaO
         rFZSBxgukhRYFI2ErrzbEnm8I4aZkKQm6sQfQGKdRUedZKz3t8fbFDVCSSCOcQ5GqILq
         g45nSNyYCxKNYyl3E/LvkveMiCnau66PfnDEKjA3Wo+jbrh+KNtkGZNDNELzMHAQ2Tz3
         Obme0E2390Gl/ZshKZag5k54VkkDqQp8pF6FVoIs57Swuq9z77TEAf/qdKp+9ZVJzpxu
         uxwA==
X-Gm-Message-State: AOAM530YV9sQ0BIRHzkVL4p2Bob3U1A8oywMBwisLy304I071FfdUWfA
        mr6jDO9oJeKg3WScnbosla/xOT8sE7c37KhY
X-Google-Smtp-Source: ABdhPJx/RBWFJLBjgQJ2Ry9R8JKPd83a0F9gebMFSYdlNlBwD5soTLZo1dQKTmSa9XslmS5xc4Ie1Q==
X-Received: by 2002:a05:6512:3a85:b0:443:9610:6a63 with SMTP id q5-20020a0565123a8500b0044396106a63mr11766417lfu.507.1645387978449;
        Sun, 20 Feb 2022 12:12:58 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id f19sm666782lfh.264.2022.02.20.12.12.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:12:57 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id g39so14908825lfv.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:12:57 -0800 (PST)
X-Received: by 2002:ac2:4211:0:b0:438:2f1:83c4 with SMTP id
 y17-20020ac24211000000b0043802f183c4mr12021984lfh.435.1645387977368; Sun, 20
 Feb 2022 12:12:57 -0800 (PST)
MIME-Version: 1.0
References: <YhIq94B0MpYGrEm2@zn.tnic>
In-Reply-To: <YhIq94B0MpYGrEm2@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Feb 2022 12:12:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whi4n6xvy99U-q_GrR_hHk8es4GtDKtywiL5nRFUWroAQ@mail.gmail.com>
Message-ID: <CAHk-=whi4n6xvy99U-q_GrR_hHk8es4GtDKtywiL5nRFUWroAQ@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC fix for 5.17
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
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

On Sun, Feb 20, 2022 at 3:50 AM Borislav Petkov <bp@suse.de> wrote:
>
> please pull a fix for a long-standing, hard-to-catch issue in the EDAC
> weird struct allocation code, for 5.17.

Heh. Yeah, that was subtly buggy.

Side note: the comment says that it will align to at least as much as
the compiler would do, but then it does something different, eg

        if (size > sizeof(long))
                align = sizeof(long long);
        ...

and it might make sense to use "__alignof__()" instead of "sizeof()"
just to make the code match the comment.

For example, on 32-bit x86, "sizeof(long long)" is 8, but
"__alignof__(long long)" is only 4.

And then we have m68k..

Or maybe the comment should be fixed instead, and talk about "natural
alignment" rather than "compiler alignment".

             Linus
