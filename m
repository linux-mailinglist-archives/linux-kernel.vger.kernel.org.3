Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217EE4853AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbiAENic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240392AbiAENib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:38:31 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510CC061784
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 05:38:31 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y130so93653265ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 05:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXXKQxSnrfnzNLT26Z/C+YfqOKyEAuA8Hi3rJKTlPjI=;
        b=n0Nt+0luPXL1MVhPcfeKZtQl2OHqrTSzNwQ6Fp8NlYhbENRTW/J2VmOZ1voZPTzd4P
         mLy4HiKbaqWiPMT8XLxyrptYAiib+ZuhHj18Nx+H4gG8LwriTCpKwlsdwi28CvWNtXfc
         E9B3Zn83LrWQAkucn2xWcAf82Lf5iSn3z6f+tKtnAw9OyWOat/tLJfLzEwgsepAo3EfF
         8uMxKWtBUulqQeWWB9gBeH1EfC+0UAncJfQcsa24Ok632+9LGzdAQxfAs3ahzJpLG8dd
         DcsF9Lj1WWjKXcre48Dscy4NT3OLVd/AcwjVrckurwXGfuGq2MseXAXXRpVwUZaJDwRP
         WpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXXKQxSnrfnzNLT26Z/C+YfqOKyEAuA8Hi3rJKTlPjI=;
        b=6bzQClUIRjugQkMHq2wQpFk+PdQ980G/+43MKAChbTPocoD86XBshdod2+bb+ZSKYv
         tY0/BHnYYHqauRO0iPYyA3tp22EY0wtJ0UpK6pQTO3B9ItOX0Zfc3e3ia81zChtH9uee
         yCIHOU6Z24zM9spVWY2dp4BCiQHIK9Pd624t+TVoymZNIiPX0rxHjutVI7LfdBG2NEqd
         nxUP4ifYFjL/2T6a+YP+wDFj7jrGtLyyusmxk3LBumN88z+FCceI43m17l2TwUz2fLov
         Tql4g2uXi0khy9XOpTxmDtbqCtxsO/nvUBxB/pgw1mhmMSbS9rP8UiN9fadvAJpLPqyz
         DkwQ==
X-Gm-Message-State: AOAM533iYdNEY0fc1znIzQtbBmeE1DJvA0MvlHb9nHntrDDb8zI6PPeA
        EM4VGoxZkvCn6zlad0784UZoq/GE5xRsB7bvjRRK9A==
X-Google-Smtp-Source: ABdhPJzRc91OKsGekcgrViJCWSaA1uPTMvy5zZaoEZfkMs7vfIxyCJ7aKDPsTrb2ZKxClZdf5nfQLceQvT+R5xudyA4=
X-Received: by 2002:a25:824c:: with SMTP id d12mr53909701ybn.5.1641389909879;
 Wed, 05 Jan 2022 05:38:29 -0800 (PST)
MIME-Version: 1.0
References: <CA+wXwBRbLq6SW39qCD8GNG98YD5BJR2MFXmJV2zU1xwFjC-V0A@mail.gmail.com>
In-Reply-To: <CA+wXwBRbLq6SW39qCD8GNG98YD5BJR2MFXmJV2zU1xwFjC-V0A@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 5 Jan 2022 05:38:18 -0800
Message-ID: <CANn89iLbKNkB9bzkA2nk+d2c6rq40-6-h9LXAVFCkub=T4BGsQ@mail.gmail.com>
Subject: Re: Expensive tcp_collapse with high tcp_rmem limit
To:     Daniel Dao <dqminh@cloudflare.com>
Cc:     netdev <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Marek Majkowski <marek@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 4:15 AM Daniel Dao <dqminh@cloudflare.com> wrote:
>
> Hello,
>
> We are looking at increasing the maximum value of TCP receive buffer in order
> to take better advantage of high BDP links. For historical reasons (
> https://blog.cloudflare.com/the-story-of-one-latency-spike/), this was set to
> a lower than default value.
>
> We are still occasionally seeing long time spent in tcp_collapse, and the time
> seems to be proportional with max rmem. For example, with net.ipv4.tcp_rmem = 8192 2097152 16777216,
> we observe tcp_collapse latency with the following bpftrace command:
>

I suggest you add more traces, like the payload/truesize ratio when
these events happen.
and tp->rcv_ssthresh, sk->sk_rcvbuf

TCP stack by default assumes a conservative [1] payload/truesize ratio of 50%

Meaning that a 16MB sk->rcvbuf would translate to a TCP RWIN of 8MB.

I suspect that you use XDP, and standard MTU=1500.
Drivers in XDP mode use one page (4096 bytes on x86) per incoming frame.
In this case, the ratio is ~1428/4096 = 35%

This is one of the reason we switched to a 4K MTU at Google, because we
have an effective ratio close to 100% (even if XDP was used)

[1] The 50% ratio of TCP is defeated with small MSS, and malicious traffic.


>   bpftrace -e 'kprobe:tcp_collapse { @start[tid] = nsecs; } kretprobe:tcp_collapse /@start[tid] != 0/ { $us = (nsecs - @start[tid])/1000; @us = hist($us); delete(@start[tid]); printf("%ld us\n", $us);} interval:s:6000 { exit(); }'
>   Attaching 3 probes...
>   15496 us
>   14301 us
>   12248 us
>   @us:
>   [8K, 16K)              3 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>
> Spending up to 16ms with 16MiB maximum receive buffer seems high.  Are there any
> recommendations on possible approaches to reduce the tcp_collapse latency ?
> Would clamping the duration of a tcp_collapse call be reasonable, since we only
> need to spend enough time to free space to queue the required skb ?

It depends if the incoming skb is queued in in-order queue or
out-of-order queue.
For out-of-orders, we have a strategy in tcp_prune_ofo_queue() which
should work reasonably well after commit
72cd43ba64fc17 tcp: free batches of packets in tcp_prune_ofo_queue()

Given the nature of tcp_collapse(), limiting it to even 1ms of processing time
would still allow for malicious traffic to hurt you quite a lot.
