Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BE347E995
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbhLWWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhLWWxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:53:07 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC5C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:53:07 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id x32so20483401ybi.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcEv8EcLJVrHvC/I5/J7MwrmBXZn8X2kMKVjuhCef14=;
        b=Y1aTx1YrmjZq5GG2AVe7+K3dzJAMOMWNq8DYehXq7+z97i1nm+M2Ea2sAzDUXJjKp2
         GnNc4dqe1KYLwgMy+pKHEvAj0hVHmofr0XHbr5dtZTeDL13QlJbENdsPTdkpu+VOA+BD
         ReleBwzcVXENo4HNU9m2daQiGj+nPgn1x0LWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcEv8EcLJVrHvC/I5/J7MwrmBXZn8X2kMKVjuhCef14=;
        b=As8h9wSznfAYRwy/nc69u0R77j3tr7S9AbdBj8E007DWk0jyVmuj5nclvURRM8XfIx
         r1PxX9wWbW+hsNcBu27JAd5UdfelJvBpURclnWv1qoTOCDNbHKD3PsRg8nttMyoklMqq
         kC66y0JlvnGAd3cgrBpARakEQNIdXwB9rYM/IFn7xxo0mKHoLIkIjgV4frXUVJf+pwvU
         S0A4CSnH1s0s6bciXHFXw158iOzt+5d73jiCaTKLl5t9pp3Ud3b1BhWOiK+HSIUDRBea
         aoUsBP9ncpJClZCqaQMu2MtFJlC6Vy2B49LknnX6EPLTV0BfMkXTgoq75atf/Vx5/+ZG
         Nq6Q==
X-Gm-Message-State: AOAM532BtZBZwvRQoOIsi+zzmAyy+tbxgv/DtByRoFTGr05bZO3tVN/1
        IuyQLRU97sX2Nblt857rkIzq8m61j6CPcIDxpsNmp62XjJU=
X-Google-Smtp-Source: ABdhPJwE+p02x6CD8c8Z3xtjknTsne4NEUfj3GqbYLVPV1vZGGJhs3fskI38m4tdIitm33R3WVJMb3Q0j+4HsaVIBw8=
X-Received: by 2002:a25:d84a:: with SMTP id p71mr93571ybg.693.1640299986168;
 Thu, 23 Dec 2021 14:53:06 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi3bzd4P0nsyZe6P6coBCQ2jN=kVOJte62zKj=Q8iJCSOQ@mail.gmail.com>
 <CANn89i+mhqGaM2tuhgEmEPbbNu_59GGMhBMha4jnnzFE=UBNYg@mail.gmail.com>
In-Reply-To: <CANn89i+mhqGaM2tuhgEmEPbbNu_59GGMhBMha4jnnzFE=UBNYg@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 23 Dec 2021 14:52:55 -0800
Message-ID: <CABWYdi0qBQ57OHt4ZbRxMtdSzhubzkPaPKkYzdNfu4+cgPyXCA@mail.gmail.com>
Subject: Re: Initial TCP receive window is clamped to 64k by rcv_ssthresh
To:     Eric Dumazet <edumazet@google.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:10 AM Eric Dumazet <edumazet@google.com> wrote:
> Stack is conservative about RWIN increase, it wants to receive packets
> to have an idea
> of the skb->len/skb->truesize ratio to convert a memory budget to  RWIN.
>
> Some drivers have to allocate 16K buffers (or even 32K buffers) just
> to hold one segment
> (of less than 1500 bytes of payload), while others are able to pack
> memory more efficiently.
>
> I guess that you could use eBPF code to precisely tweak stack behavior
> to your needs.

Adding ebpf for this is certainly an option and it seems similar to
TCP_BPF_SNDCWND_CLAMP. I can certainly look into crafting a patch for
this.

Is it not possible to do anything automatically to pick a bigger
window without ebpf? When the scaled window is first advertised in the
very first ACK, the kernel already has the SYN ACK skb from the other
end of the connection. Could the skb->len / skb->truesize ratio be
looked up there?

Increasing tcp_rmem (the middle part specifically) is a lower entry
barrier than making ebpf involved, and it can really help with latency
even for human use cases like opening a website across the ocean.
