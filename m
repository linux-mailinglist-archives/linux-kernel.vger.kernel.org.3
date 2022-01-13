Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C8C48E0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbiAMW5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbiAMW45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:56:57 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:56:57 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c10so19440201ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bon9YcmX/y5D1KBEnXS+OkpAMntSiR3cXQ8BTUvnYhM=;
        b=gJjEeWN2CtncUTotnkgzNkHxlG72MyBpgrLJb9Nl2PNDxicwcmCK0a9uCErJ06dpzA
         CQEXTevDF/ZVeyTZXMfu3luczwEvZKZB0OeYNXJzV21s9lo3uhsOj3wPSdSfLYJMeJ7M
         fvhD6aC7wD3rFe9beiG0O+3SYJv4WuEVkdGHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bon9YcmX/y5D1KBEnXS+OkpAMntSiR3cXQ8BTUvnYhM=;
        b=Ank6J3r2ThbbquCSOPCI4K7CGemqpcWgZzOGlHNG+ciwypUcGktDwm8tw1IT06JD+N
         hK86iMY+C3j+WCdJRQjOamTk6f6spcNEuU+2MGqFmD20xgrIiE0q8l/meHxTTtnueJDe
         /BKQQ8pwdGX9NWTXN0LXlNj5Ajh25KPyzAYwca2YrHkScKUDu4sm2uIiWDGe+VM/UnbS
         ePbFE1NRUgjH8HfFnc/ldIpQ60FyRMYAiv7YI64ptg2AILhVp9Qk3jtC43wvfx6qFRKt
         ZVuvRQexg53clokO4OUAxPckhCJ2hTn/dQRRZ+cn1y7zUl8L0bz4HK4RP5dtkjc8kODz
         vqPg==
X-Gm-Message-State: AOAM532ULpVMtxdAVB4r87wekO1IFFI9oqm5cxiJe7LpuBIgxlpqu5YZ
        jzMJIn061ZPptwpZTHFUwl6DsUUguaSTp9kU7D5VHg==
X-Google-Smtp-Source: ABdhPJzjrCAifnr19GnfNi4829y4uYxHdb0KmI+Wiwk1pCGhRpocjwX2ciPGWC4WNw2pbw4hx/4vPh/xbofjDbU4c9o=
X-Received: by 2002:a25:5088:: with SMTP id e130mr9213643ybb.158.1642114616327;
 Thu, 13 Jan 2022 14:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20220111192952.49040-1-ivan@cloudflare.com> <CAPhsuW5ynK+XZkUm2jDE2LcpMbqPcQJDJHmFyU_WbBQyBKN38g@mail.gmail.com>
In-Reply-To: <CAPhsuW5ynK+XZkUm2jDE2LcpMbqPcQJDJHmFyU_WbBQyBKN38g@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 13 Jan 2022 14:56:45 -0800
Message-ID: <CABWYdi27jpMC=trg1PDzFVPkOUyMshWUzdmKLc7tq35hCnjdAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tcp: bpf: Add TCP_BPF_RCV_SSTHRESH for bpf_setsockopt
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
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

On Tue, Jan 11, 2022 at 1:48 PM Song Liu <song@kernel.org> wrote:
>
> I guess this is [1] mentioned above. Please use lore link instead, e.g.
>
> [1] https://lore.kernel.org/all/CABWYdi0qBQ57OHt4ZbRxMtdSzhubzkPaPKkYzdNfu4+cgPyXCA@mail.gmail.com/

Will do in the next iteration, thanks.

> Can we add a selftests for this? Something similar to
>
> tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c

I have the test based on the tcp_rtt selftest. Do you want me to amend
my commit with the test and resend it as v2 or make it a series of two
commits?
