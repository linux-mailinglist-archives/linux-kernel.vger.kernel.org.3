Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA8549B775
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455398AbiAYPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359582AbiAYPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:16:03 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E95AC06177B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:15:58 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id l68so62076123ybl.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2swlk2R1Iyz8CGGk7h2fU+pmuJYKGgtN7VeZzZ2pbkg=;
        b=fxvSYu8hoO0zSxzftetHu2jcfxaoONx5V+3hyQXsdGScaJLj7KE9NaLV+M2LJtLPhJ
         3tAdr8749rMhwIMfinDJEvUTvy8mEp31j5zkl3hQZghV2U2UKJcMOfhrjTbswQ6sgM9M
         fLeckj4cKAC05JqWaa5pun5hZ5IUUkuQcqhju0EoJxMirkmog8yf0n9RA702PlZKdwzn
         gQsgYGjmNp/BxLD8I72FFQh17yB8GS7sAhoQOUUIy1xB8LPwwvboraLwCu56HCDxk8A3
         sI+IPxwPthE1KAPyymnxQUQ5nl3Sg+GruWM6kT9h1ti6uBcp7JUzHjFjzyma/qlDP70X
         4wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2swlk2R1Iyz8CGGk7h2fU+pmuJYKGgtN7VeZzZ2pbkg=;
        b=sBJNPL2QZWjyFJMhH2Jd4jgvRhuw6z+kseM+XYVPR3ZaPG+X2oqmmbisfs0O0MgHmh
         9GZdjI0ZnuCZEEz9G73AUs9N8gYwk97/6G+tmvaPI9Gr5AGbhbMWaN+3RNTH7Inmac2s
         p1QiVPvfbL8QFZuU1cNfcT7sw3IOQsfGeR4Pzg+sjf/WKHDkZCSzdZn1NAii9/wx2nOJ
         wHsIwhn7hFs11FShUhbGY5syX5TL2x13cBMePs70DYbO11sNKfHar8l0WpA9TdtL2gxF
         EbpD6eaNjF3WmpGcYB5CwrE1OkvH6zYkaROjGkW4mYElFGkSORYJl4dirlexaErUExIq
         5sGg==
X-Gm-Message-State: AOAM532mkbjeFGtEMXeHItCb5g47JOkHrPGh+x/sTTdXDKFTaCb+jrIt
        yFdG64RMGFO4ABErpRaKbExd0au0EvdS+/AYwXBQtg==
X-Google-Smtp-Source: ABdhPJyXfD8ePAHH9cNUsegT+6sROb6lqO0h6V0Ib39SEWGy2hreYqGW2GxzdpCUOHPg4yE4IRnL3Y6OHCBs03QSyGI=
X-Received: by 2002:a25:cc47:: with SMTP id l68mr32658286ybf.105.1643123757334;
 Tue, 25 Jan 2022 07:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20220105031242.287751-1-dustin@howett.net> <20220105031242.287751-3-dustin@howett.net>
 <CALtnz63d7utST13=S7UbExDzSE0GnoFA7JowQkkFSqrSUTmCdQ@mail.gmail.com> <Ye95vRREnbaLM+EJ@google.com>
In-Reply-To: <Ye95vRREnbaLM+EJ@google.com>
From:   Dustin Howett <dustin@howett.net>
Date:   Tue, 25 Jan 2022 09:15:45 -0600
Message-ID: <CA+BfgNKRNXVxLhQ2mAxiq-c3ipkFPdYoZee6myO8djmXWnfrYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: reserve only the I/O ports required
 for the MEC EC
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:17 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
>
> The original code:
> - devm_request_region(dev, EC_LPC_ADDR_MEMMAP, ...) and then
> - cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, ...).
>
> After the patch:
> - devm_request_region(dev, EC_HOST_CMD_REGION0, ...) and then
> - cros_ec_lpc_ops.read(EC_LPC_ADDR_MEMMAP + EC_MEMMAP_ID, ...).
>
> Does it work if it reads out of request_region range?
>
>
> The 2 request_region are now guarded by the first "if (buf[0] != 'E' || buf[1] != 'C')".  That is, only non-MEC will request the 2 regions.
>
> Doesn't other MECs (e.g. non-Framework Laptop) need the 2 regions?

So, in both cases this should be legal. Here's why:

The MEC protocol multiplexes memory-mapped reads through the same 8
I/O ports (0x800 - 0x807)
as it does host commands. It works by adjusting the base address,
EC_LPC_ADDR_MEMMAP (0x900),
to 0x100 before it initiates a standard MEC LPC xfer.
See cros_ec_lpc_mec_read_bytes line ~101 (as of 881007522c8fcc3785).

Therefore, the adjusted flow in the patch is:

0. Default cros_ec_lpc_ops to the MEC version of read/xfer [unchanged in patch]
1. Request 0x800 - 0x807 (MEC region)
2. read() using the MEC read function (using only the above ports)
3. if it succeeds, great! we have a MEC EC.
--- if it failed ---
4. Map the non-MEC port range 0x900 - 0x9FF for memory-mapped reads
5. read() using the NON-MEC read function (using ports 0x900 - 0x9FF)
6. if it succeeds, map the remaining host command ports 0x808 - 0x8FF

In short, only non-MEC needs the 0x900 - 0x9FF mapping for "mapped
memory". Therefore we can defer the
port allocation until after we've failed to read mapped memory the MEC way. :)

Based on my understanding of the MEC protocol, non-Framework Laptop
MECs hold this invariant true as well.
They should only need ports 0x800 - 0x807.

Hope that helps!

Want me to send a v2 with updated commit messages?
d
