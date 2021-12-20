Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBB447AE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhLTPBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbhLTO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:58:32 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A62C06139A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:50:14 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y22so39418941edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sp8lrqTjH4tVEgy9/yn4LBGgEPK1p0BL+G9kAR2qkM=;
        b=2/vdq9148EAdfRpKl6tYPEzDbfFu13ViRxqVWcSnjBotLg94Wx/ThILPI9po2jYS/r
         88a94qWtaic2hcHfXvAwMb2xTymT7xcHELJlfoNSgogwh1BMe7Ebdo7j+jK+Br63Rvsm
         FhfEtBiDGkl9bHtQHCMzs5ZuRbPp5fevGMZoi59Z88KsyG0axZeKbQ5ERzJ899oGbvGy
         vpE7U87LI9bnB3E49ZpU8zhzyZR3JKyomD1Qh8WmaZQKsIOkafWe2STcWIjOO+Mv1aNU
         ow5grn1kYOTlpF9Xh5pHxjcP2RzwoYUpLg+n/2dLaICwAw4bMAM3HUWM3PS4QJ72iCSL
         5M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sp8lrqTjH4tVEgy9/yn4LBGgEPK1p0BL+G9kAR2qkM=;
        b=U57WYdAO/Onb+g5tvzHUGy5ay/bPXjzqUBmQy3XHsWQYCVsBatFTLXs++LgCNsbvu5
         U1McqV8f2KYHlQmdF+pjtSwmx6fIxmeyRfoMLBMDPZqRyfimyaSnAB3rhw29mKEfUtUf
         qJTjqjLn7iSc+FdXlNcxPUmbKlv2jRHCW+EO4fG5vxokXYrOFn1svgh1XYXj6Ip1duKr
         xN2hiwujQ4B8ulgZIBSltul1aS2JgDuXsH6BMIDuUSGbNfztOCcuNUeWrZ509GbqJz7R
         9WTvwqHhJnkwYpMincaRzPGfQZVDmKw4BE2yj6ckBhLKbuA+YqqTYVMXRNmxsam4oBzc
         z0+Q==
X-Gm-Message-State: AOAM532psdFOPmzOi+lVWih4oajLmXTh9qH1Yz22SZLZbvKdC2+O2lmo
        +PxHI6u88q/xex4SIjWfIyy1c/0D5jgyxn1uKVYQ1A==
X-Google-Smtp-Source: ABdhPJyMcS0XdQOUX70jwFfNF+jSawe7Vvo1hbs0CHqHEfUeODevfaejc/+ceii7yoZJZQEWFGqjVMtOEj2zRBDNVB0=
X-Received: by 2002:a17:906:249a:: with SMTP id e26mr13252984ejb.492.1640011813155;
 Mon, 20 Dec 2021 06:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20211213094036.1787950-1-daniel@0x0f.com> <20211213094036.1787950-5-daniel@0x0f.com>
In-Reply-To: <20211213094036.1787950-5-daniel@0x0f.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 20 Dec 2021 15:50:02 +0100
Message-ID: <CAMRc=Md_2b-sBnPQL-E59byYSv+Z0+d3V8JrbPqpGSMjGS+tgA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] gpio: msc313: Add support for SSD201 and SSD202D
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:40 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> This adds GPIO support for the SSD201 and SSD202D chips.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

I applied patches 1-3. This triggers a bunch of checkpatch errors.
Please address them and resend this single patch.

Bart
