Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236C84D57C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345495AbiCKB6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345582AbiCKB6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:58:11 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C30119D624
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:57:01 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id b188so7869245oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYmIXqGoP18VRv8GkXhEyrdmBAb5Sj51YjCRhrfnyCU=;
        b=UGR4hg7JGEyj5FStkRpY9WIuMMQwsLO5XjqKrJ1IytrD2WEwb++4ThYnP+bPWy7K3n
         3nId0tS8PoBY1seJ/fDAoaNW5D2HeT5+Em4agfYD+yNRJufAIMxeGLefO1S/OfQTti3q
         GjxxVD+ufIDzBKGHuuwzUoqPMetmNybncnfP02labX0KUJARz/SD4GO5NEbE9R8XC4K5
         DFt4aOlH8LuuCw67BbnkrLm4IqgrJ/fjvILsP2AgW553tjl7Es1IzCIqI7L96LZhOlIE
         pKTErC3wrOLUUk2SNMoZve4WaUha0cCMLh4xhhPe8Qy6c35MYo14OgoBo3AY1Nzat9B7
         GSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYmIXqGoP18VRv8GkXhEyrdmBAb5Sj51YjCRhrfnyCU=;
        b=6HgvSNPciQQ3J1ZghegKjQJDLZ6QbP55z1q9m3YjiUe9Wc/5vD1B4R5wZPJcEAhTuo
         mwvK9ritctk9AdYGW/4czSy9V9KJJA3ny9NFG/kDdYYnzS5lD6sEFJNvXqcF+hJkaeBO
         wKKOAhACiNth6/2UJL3B9+uUeTj6M0qHfPxsX+sC6SdGr0vXRG6xJg53pt4WUFAdLUAL
         lm/LLq2PIa82qJeTWX6HUh4Nj4G0pem3bF0/pqYG1wsfPqQoRqIl1gC4PSkogZhsl4X1
         kax8ykj05yqN1/p3loilxVFIOTtpKYayRXrJBALYwBezZb+2yO4M8+G71WujS9FK7wgd
         I+YA==
X-Gm-Message-State: AOAM531E94G7WuK6LPQFjGHlUfcbwQQusCE36GvqJX20sTpHTi0sqHeO
        k0YM315h23MbfOQMtcOwF18fPoJQSPA=
X-Google-Smtp-Source: ABdhPJzB592mysFn9oE13RiW1HT6RiVvGe7i0vIoCvDktvlr1mcYcbmQE/S+t+fIeyVHsVu26yd94A==
X-Received: by 2002:a05:6808:d51:b0:2d5:3fbe:7d43 with SMTP id w17-20020a0568080d5100b002d53fbe7d43mr11666035oik.118.1646963820470;
        Thu, 10 Mar 2022 17:57:00 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id dv1-20020a056870d88100b000d9e83cacf8sm2917358oab.9.2022.03.10.17.57.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 17:57:00 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id s35-20020a0568302aa300b005b2463a41faso5338106otu.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:57:00 -0800 (PST)
X-Received: by 2002:a81:6357:0:b0:2d7:2af4:6e12 with SMTP id
 x84-20020a816357000000b002d72af46e12mr6731354ywb.317.1646963397784; Thu, 10
 Mar 2022 17:49:57 -0800 (PST)
MIME-Version: 1.0
References: <CAF=yD-LrVjvY8wAqZtUTFS8V9ng2AD3jB1DOZvkagPOp3Sbq-g@mail.gmail.com>
 <20220310232538.1044947-1-tadeusz.struk@linaro.org>
In-Reply-To: <20220310232538.1044947-1-tadeusz.struk@linaro.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 10 Mar 2022 20:49:21 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdFoTTqqL5CxCbL4gEg4-QvUQzQSM+45G9XL0BtLs7fGA@mail.gmail.com>
Message-ID: <CA+FuTSdFoTTqqL5CxCbL4gEg4-QvUQzQSM+45G9XL0BtLs7fGA@mail.gmail.com>
Subject: Re: [PATCH v3] net: ipv6: fix skb_over_panic in __ip6_append_data
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     kuba@kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+e223cf47ec8ae183f2a0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 6:26 PM Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
>
> Syzbot found a kernel bug in the ipv6 stack:
> LINK: https://syzkaller.appspot.com/bug?id=205d6f11d72329ab8d62a610c44c5e7e25415580
> The reproducer triggers it by sending a crafted message via sendmmsg()
> call, which triggers skb_over_panic, and crashes the kernel:
>
> skbuff: skb_over_panic: text:ffffffff84647fb4 len:65575 put:65575
> head:ffff888109ff0000 data:ffff888109ff0088 tail:0x100af end:0xfec0
> dev:<NULL>
>
> Update the check that prevents an invalid packet with MTU equall to the
> fregment header size to eat up all the space for payload.
>
> The reproducer can be found here:
> LINK: https://syzkaller.appspot.com/text?tag=ReproC&x=1648c83fb00000
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
>
> Reported-by: syzbot+e223cf47ec8ae183f2a0@syzkaller.appspotmail.com
> Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>

Acked-by: Willem de Bruijn <willemb@google.com>

small nit: "equal to the fragment" and all these Cc:s aren't really
needed in the commit message.

I don't think we'll find a commit for a Fixes tag. This goes ways back.
