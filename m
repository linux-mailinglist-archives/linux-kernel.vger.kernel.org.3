Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DFD4A8833
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352079AbiBCP7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbiBCP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:59:46 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E17C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:59:46 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 124so9687298ybw.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZlW9nTzqiP82XOUyxs3nRynux9nbwxL4Q5qCa2/9ng=;
        b=kfge2IWtu3BmEiJsl+2poWE1AcoqBZWlXmdfkZjN8VwzHfq09mN6SUpWTUR5lKTKuk
         vr4+4/h9UfMQmUtgSkJ0Nkf+RztJ0/WOsZiWYNr9q5kumYTVc9WPDnQnRhcZAuhAh+0d
         IPXEwjRUPwK0fNbIgRSz86Jkw2O+VBkLG4zg4aed16C4UwgsCx6SIViwDc6+D9+ZPFmU
         SsxuclPlYAQ/ubOkC0doBwqsXKRt59tbbADBBNIgcUVy47kqMJfY7fRe/cdphIyU0F+O
         WVv6U65owm7quPChBeKi95P4N4LtW5eW5ekr/UpzFBPJ+vjCVLVrb0cArkPwM7JjWpQi
         JunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZlW9nTzqiP82XOUyxs3nRynux9nbwxL4Q5qCa2/9ng=;
        b=ftZMHn86dxscGVAAwqK6v6QzuuA9LjexU78PCTsuw2PxPCxI4fS9ebGsfBBEYTJz86
         SHFRC8FOkP8f39YAd3jJ5ir8QGr/+BwYtOuCx9S+zIlDWrNFtWyGM+xDNH+XJMs+Djpi
         lJXyQvUjqay5c6QQC8SVtHZke8gD6T385vg7/ehK5uR2v7Ts3Pvp47zyuKHo6wwxDe9U
         0vBdA/DWpDptFa5BCOlh8NFLtwwj/guVunR01FRG6iiZ20g3YQjZFxbVOtHS+n56LIgz
         hUXFJ5hRXUJdeksuasTNgBVuml/SOYYjZQpEzrMqBLmoBmilwb6J+Rk8or6VdwVqZmHb
         wLTQ==
X-Gm-Message-State: AOAM530jsmz2GKt0ZTLdK1fjQ9+HnNQaueZ5fOqdBC1Qhkggigy3NWb2
        gHqYmCVnloRyM83gl/IQT5TYXdsoJu0iiA5SG5r3rQ==
X-Google-Smtp-Source: ABdhPJwxctVyhczd5Vsao4vH0OpNLnZ31ThKwaMgIW7/rtBe9J3D/uJZQUOq4C7vDEtlNsjGsqNblnJMKrZpTG3V5Wo=
X-Received: by 2002:a0d:c7c2:: with SMTP id j185mr4794755ywd.105.1643903985178;
 Thu, 03 Feb 2022 07:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20220203153731.8992-1-dongli.zhang@oracle.com> <20220203153731.8992-2-dongli.zhang@oracle.com>
In-Reply-To: <20220203153731.8992-2-dongli.zhang@oracle.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 3 Feb 2022 07:59:34 -0800
Message-ID: <CANn89iLB-zmM1YTn4mjikMLhZwQ6fQUAHeCBznLuvE=gB2R-sg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] net: skb: use line number to trace dropped skb
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Joao Martins <joao.m.martins@oracle.com>, joe.jin@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 7:38 AM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
> Sometimes the kernel may not directly call kfree_skb() to drop the sk_buff.
> Instead, it "goto drop" and call kfree_skb() at 'drop'. This make it
> difficult to track the reason that the sk_buff is dropped.
>
> The commit c504e5c2f964 ("net: skb: introduce kfree_skb_reason()") has
> introduced the kfree_skb_reason() to help track the reason. However, we may
> need to define many reasons for each driver/subsystem.
>
> To avoid introducing so many new reasons, this is to use line number
> ("__LINE__") to trace where the sk_buff is dropped. As a result, the reason
> will be generated automatically.
>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  include/linux/skbuff.h     | 21 ++++-----------------
>  include/trace/events/skb.h | 35 ++++++-----------------------------
>  net/core/dev.c             |  2 +-
>  net/core/skbuff.c          |  9 ++++-----
>  net/ipv4/tcp_ipv4.c        | 14 +++++++-------
>  net/ipv4/udp.c             | 14 +++++++-------
>  6 files changed, 29 insertions(+), 66 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 8a636e678902..471268a4a497 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -307,21 +307,8 @@ struct sk_buff_head {
>
>  struct sk_buff;
>
> -/* The reason of skb drop, which is used in kfree_skb_reason().
> - * en...maybe they should be splited by group?
> - *
> - * Each item here should also be in 'TRACE_SKB_DROP_REASON', which is
> - * used to translate the reason to string.
> - */
> -enum skb_drop_reason {
> -       SKB_DROP_REASON_NOT_SPECIFIED,
> -       SKB_DROP_REASON_NO_SOCKET,
> -       SKB_DROP_REASON_PKT_TOO_SMALL,
> -       SKB_DROP_REASON_TCP_CSUM,
> -       SKB_DROP_REASON_SOCKET_FILTER,
> -       SKB_DROP_REASON_UDP_CSUM,
> -       SKB_DROP_REASON_MAX,
> -};


Seriously, we have to stop messing with things like that.

Your patch comes too late, another approach has been taken.

Please continue this effort by providing patches that improve things,
instead of throwing away effort already done.

I say no to this patch.
