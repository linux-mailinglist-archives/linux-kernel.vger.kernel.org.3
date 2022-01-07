Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32D487E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiAGVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiAGVW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:22:59 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4CC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:22:59 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id i14so8689843ioj.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLPG68maHzuWQkm+1YT+E6wsnchCrh1nEIPBO2jLick=;
        b=ZUSjKTHkRHJvy2UfGzJr1qPKAQ9x2xc6LT2yVEJn/JlYNQ43chWeUkOVGmqJA9gSoA
         qQRsliX1Tz6To1gwCxVfxt3X3xor8NZ0fFGvpqI2zIHPUKCAUOZsdBz2gftGHoTf/CMA
         77MEFoTnyeYciVlgnsgmsQ2rQpslfmFAO5mhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLPG68maHzuWQkm+1YT+E6wsnchCrh1nEIPBO2jLick=;
        b=TXivBNfwXGcp5LHvPtDyaKibT0MOc/Q1+TO7OKbg0QcFHE0xnamN11yz8DhssBePSv
         R77Y7y90jTP/qRq6iKVdYUFIJQWKnPqXnuNwDaj7b54KuE4apDDXWumJnViIqxQ0KQNg
         NybwMgQy1B0aXTk45MpzhJ9kUCYxrJnfIin4bqGObfgPaGm6xoJ8UVS1VPtYF3AwWSJv
         FTkRIGAbs7IhsDzdhcLBC/F4NjEv46ohzZvzDxt8UaGpbWnvzg6Ab7ijzUFhbsxkEX2t
         O7Yu/eLm+5TKb8NSHLgTsfFywLXiwNzTT0dqSMcEBhJNxbA3pX0fzMywpXSwSYa8TlMk
         cAFA==
X-Gm-Message-State: AOAM532gwvuxGmt5E+WVWJUUsv9v8V1POLAxPTV3bNySSRXk/01Y/QOL
        WcaPgnYGDuM3Xdw4kGEObLEgLa4GjVj7QA==
X-Google-Smtp-Source: ABdhPJyJjHdRLuhz0QsHy1pDxjmMLYkGvwussb9t3C6E1UKGyYj3x3S0stRoiY1jrMxDQFZqGcLYvQ==
X-Received: by 2002:a5e:d502:: with SMTP id e2mr31187298iom.118.1641590578259;
        Fri, 07 Jan 2022 13:22:58 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id g11sm3395549ild.52.2022.01.07.13.22.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 13:22:57 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id 19so8715861ioz.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:22:57 -0800 (PST)
X-Received: by 2002:a02:c60e:: with SMTP id i14mr25520700jan.207.1641590577234;
 Fri, 07 Jan 2022 13:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20220107200417.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
In-Reply-To: <20220107200417.1.Ie4dcc45b0bf365077303c596891d460d716bb4c5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Jan 2022 13:22:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W5fHP8K-PcoYWxYHiDWnPUVQQzOzw=REbuJSSqGeVVfg@mail.gmail.com>
Message-ID: <CAD=FV=W5fHP8K-PcoYWxYHiDWnPUVQQzOzw=REbuJSSqGeVVfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ath10k: search for default BDF name provided in DT
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 7, 2022 at 12:05 PM Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> There can be cases where the board-2.bin does not contain
> any BDF matching the chip-id+board-id+variant combination.
> This causes the wlan probe to fail and renders wifi unusable.
> For e.g. if the board-2.bin has default BDF as:
> bus=snoc,qmi-board-id=67 but for some reason the board-id
> on the wlan chip is not programmed and read 0xff as the
> default value. In such cases there won't be any matching BDF
> because the board-2.bin will be searched with following:
> bus=snoc,qmi-board-id=ff
> To address these scenarios, there can be an option to provide
> fallback default BDF name in the device tree. If none of the
> BDF names match then the board-2.bin file can be searched with
> default BDF names assigned in the device tree.
>
> The default BDF name can be set as:
> wifi@a000000 {
>         status = "okay";
>         qcom,ath10k-default-bdf = "bus=snoc,qmi-board-id=67";

Rather than add a new device tree property, wouldn't it be good enough
to leverage the existing variant? Right now I think that the board
file contains:

'bus=snoc,qmi-board-id=67.bin'
'bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=GO_LAZOR.bin'
'bus=snoc,qmi-board-id=67,qmi-chip-id=320,variant=GO_POMPOM.bin'
'bus=snoc,qmi-board-id=67,qmi-chip-id=4320,variant=GO_LAZOR.bin'
'bus=snoc,qmi-board-id=67,qmi-chip-id=4320,variant=GO_POMPOM.bin'

...and, on lazor for instance, we have:

qcom,ath10k-calibration-variant = "GO_LAZOR";

The problem you're trying to solve is that on some early lazor
prototype hardware we didn't have the "board-id" programmed we could
get back 0xff from the hardware. As I understand it 0xff always means
"unprogrammed".

It feels like you could just have a special case such that if the
hardware reports board ID of 0xff and you don't get a "match" that you
could just treat 0xff as a wildcard. That means that you'd see the
"variant" in the device tree and pick one of the "GO_LAZOR" entries.

Anyway, I guess it's up to the people who spend more time in this file
which they'd prefer, but that seems like it'd be simple and wouldn't
require a bindings addition...

-Doug
