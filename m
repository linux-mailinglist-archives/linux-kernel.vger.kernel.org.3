Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0B4734A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbhLMTGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbhLMTGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:06:05 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9436C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:06:04 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so56302409edu.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeg0qZoqwBz2YeITn5N/MdhGJK25+H4D5wmM2wOoIDQ=;
        b=eq/NYPxr+/3OXWhGOjuz7PoDcEoOxFDTk8/gC8xQriKEUka73c3Egjtm++qkWh/blv
         /tuskbqyiivPHlT0BQLVcts8BsayE5ce7IDChuYdfquWaAdh1WSt38alodQHeG4+xIUp
         w1A63XOlsc2pCYT1nXFNPllugkOK3vHyTecLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeg0qZoqwBz2YeITn5N/MdhGJK25+H4D5wmM2wOoIDQ=;
        b=7xIqxGH9y2J7tSH4RpCW/rL0l5p+wDYxf5qUYAd1jvl8tmWPUYbzodfSffdWpNBEk0
         DPvydpakcTg8/QKMLojYc8UyJfUitL7DBG2qKPPdLJhmmiLDOOFbixhKq+w2KDnPo5f3
         oMrnbOJ68cuDwmllb0CLIQTq8yVUK60LoHZD4A+6QcUaSTjbcjNU9YS07f1ucY4DeZGq
         /DawSpnUlq9y/bruzUeQw0QHentwjfaw32JKPI6Xg25FCDTj8Q5Dw9YV8PmLWQxFT2FW
         2xXzbHdgfN9NoJDxgikV2zwt5rI+05CBh9ZZg6YHf2O0z7niEOqHVj+A2AGWoc6Yoepo
         MMAg==
X-Gm-Message-State: AOAM531lbz1J7VptOW5N/gg1v++baHLDBdebrgXvMXabvjOMA+tvFOy4
        nkX1gTqMv9+T+2FycAmITWmzp9zuX82yNsjO
X-Google-Smtp-Source: ABdhPJwKT94+x16rHes04NMjHTGs/BqMhpN16ZLzVdSBnyP1v7aszQEjleRit50eCQvVJMax5MS0/Q==
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr843307edb.368.1639422363289;
        Mon, 13 Dec 2021 11:06:03 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id e28sm454304ejm.136.2021.12.13.11.05.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 11:06:00 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id d24so28878143wra.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:05:59 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr365289wra.281.1639422359361;
 Mon, 13 Dec 2021 11:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20211213092930.763200615@linuxfoundation.org> <CADVatmPsqW050=k07RDChjnf_F+MJfkLzHiRcdeoWQ7Mws_qMw@mail.gmail.com>
 <CADVatmMMe7NGpX9CcViLrhxP69gJ6m+9rViEVuh0E6j1QXGDVg@mail.gmail.com>
In-Reply-To: <CADVatmMMe7NGpX9CcViLrhxP69gJ6m+9rViEVuh0E6j1QXGDVg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Dec 2021 11:05:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh14HQZHWr=aNjpKrq-dP51iA6YbL3LmZGEVsOkWL-9XA@mail.gmail.com>
Message-ID: <CAHk-=wh14HQZHWr=aNjpKrq-dP51iA6YbL3LmZGEVsOkWL-9XA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/74] 4.19.221-rc1 review
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:59 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> >
> > Just an initial report. mips allmodconfig is failing with the following error.
>
> Ignore this please. I am not seeing the error on a clean build. Need
> to check what went wrong with my build script.

The gcc plugin builds often fail if there's been a gcc version update,
and you need to blow the old plugins away.

We do not have the full dependencies for system tools, and that might
happen with other incompatible system updates too.

But practically speaking, the gcc plugins are the only thing in the
kernel build that regularly cause problems.

             Linus
