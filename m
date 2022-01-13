Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F39D48E0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiAMW4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiAMW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:56:54 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF942C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:56:53 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id m1so701618ybo.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdLBfNgvUFOklxfhjYz1A331Y+Tddvzy2s727R0/HE8=;
        b=PaOKxkfRo0RD1yP5Lci3dW1kXB/cJTOcNZQvZ9RQUkQKshA0+wDBoSVu93Vdd4sjCQ
         ZN0YK0AAeNpUNnEffpHDVQQ9cWvFob1RfEBnrE4h3c0I6h5Gp0gEpBH6jmlozSQzy8re
         Zuw+nuGbKb9Y5sf9F0vUT2gdUp9S5evflDKg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdLBfNgvUFOklxfhjYz1A331Y+Tddvzy2s727R0/HE8=;
        b=SjXFkyA+hekJyP51J0S+MPcB3yXha91VJ9+E8Ag6WJepYTwbdkUk6oiDeUR6Gd2s1W
         qtRmKlub5yb2tJ3uV2qEO8bvIw00ZW7OND67tV23E/kb/CMoZL18DL1BN/MTJ9tlpTu4
         tfj7URlM5zsN9Htwy74wi1uCHj0CZVcTo9NBo04aPfFBKFpZz66lIsQMgliTQ9FoWkI2
         aTfQF0Ej+Tc/LpYwPAB5XF8s+Zw1fX3X+tLWk2GlpKXaSfTNZu/+ct/jqqRCBfnGK93Y
         tQLoPnJvXCLkgzhlSHIUe3QhBlB9dEOh008w9xfjQDJybuLvDbth65Q7+eWUaCzQQEtT
         a6uA==
X-Gm-Message-State: AOAM531ZteCBggRj+TxAL7Zg6/z4BE5vlrtgvWf3EkPTRqAhe2aGNf39
        GztaBED/J8SFCy6sZpqYwkMoPjj2Wvjme/VNQ9M4zQ==
X-Google-Smtp-Source: ABdhPJzGbrMynQ7+aMQIVDpW80Bpn1ZGmuWQ9yG5AskVlcM5ahCzRUbFTotiM58HTj+CFF9MGCzUOQ3Jrtn2rS/lwO8=
X-Received: by 2002:a25:7482:: with SMTP id p124mr8486408ybc.266.1642114612866;
 Thu, 13 Jan 2022 14:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20220111192952.49040-1-ivan@cloudflare.com> <CAA93jw6HKLh857nuh2eX2N=siYz5wwQknMaOtpkqLzpfWTGhuA@mail.gmail.com>
In-Reply-To: <CAA93jw6HKLh857nuh2eX2N=siYz5wwQknMaOtpkqLzpfWTGhuA@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 13 Jan 2022 14:56:42 -0800
Message-ID: <CABWYdi0ZHYvzzP9SFOCJhnfyMP12Ot9ALEmXg75oeXBWRAD8KQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tcp: bpf: Add TCP_BPF_RCV_SSTHRESH for bpf_setsockopt
To:     Dave Taht <dave.taht@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 1:02 PM Dave Taht <dave.taht@gmail.com> wrote:
> I would not use the word "latency" in this way, I would just say
> potentially reducing
> roundtrips...

Roundtrips translate directly into latency on high latency links.

> and potentially massively increasing packet loss, oversaturating
> links, and otherwise
> hurting latency for other applications sharing the link, including the
> application
> that advertised an extreme window like this.

The receive window is going to scale up to tcp_rmem[2] with traffic,
and packet loss won't stop it. That's around 3MiB on anything that's
not embedded these days.

My understanding is that congestion control on the sender side deals
with packet loss, bottleneck saturation, and packet pacing. This patch
only touches the receiving side, letting the client scale up faster if
they choose to do so. I don't think any out of the box sender will
make use of this, even if we enable it on the receiver, just because
the sender's congestion control constraints are lower (like
initcwnd=10).

Let me know if any of this doesn't look right to you.

> This overall focus tends to freak me out somewhat, especially when
> faced with further statements that cloudflare is using an initcwnd of 250!???

Congestion window is a learned property, not a static number. You
won't get a large initcwnd towards a poor connection.

We have a dedicated backbone with different properties.
