Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AAA48A6FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiAKFDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiAKFDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:03:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88637C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 21:03:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a18so61304891edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 21:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35NPA15rIkTZFtz4gqGNN7SOblvU+RJZkToSumWgjhg=;
        b=aJ2ii7bA+WaMOzGYCwzcbfOA05gLTXSruke0Cmojk5a7t7B3r+L+OAWokMCmg44Et7
         WzT20SgbMwEswfObDCdhe7A0d4nEtmAn+ScFpoO7VF0smJHcskfK9jsMevY0nmqEk4S1
         K0JVR5i0jBri0SNpA5zfs+3qA1PFCIgJQg2z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35NPA15rIkTZFtz4gqGNN7SOblvU+RJZkToSumWgjhg=;
        b=QdxsnXazJbuK7gjxku6wWxUnwaRUFfgpXZ7SZT+9iykb1AOiUxpR6TV+xaU9OI4RSO
         k+NKT/WEOcKlqzYYGMYQfYFiH/8FBxBxh8DlLbQRbpreuPi4cvVTGuqDEmfPm70fjAQv
         SELT65eaasMAbQvCdBG8gsw2bcsW3dJlMFdgS5J64S3p5WrI5u/okJ2yPgtwHSnng5fl
         jrYARFIT8Yn3brt8lBtlgD2lskwVfEJpDXuV6Ns4tHl7uHe7hP0HlZIOML0bMLh8tKJ5
         xgWeXr+a5oxi8GbL9B4GekD/Xhp5j4r6D9RRntqoJ3RjF/L/s0c8vK+BXrUr5ZG06/1S
         VvUg==
X-Gm-Message-State: AOAM533YxPlENzJofKkXA3VjhqZKyPTx+Fg4EQmGM/j2YO5NNAF8STSU
        +76o7bN7SIid5jxkAQzZymOu5pEr0X2tKCQRgO4=
X-Google-Smtp-Source: ABdhPJzIAyGhvHMRzS0DaEDm0W8FJGqcz9FU9C1XPcneG70Y5DntnXi8xudTL8vII0Dcg+flVYD+Lw==
X-Received: by 2002:a17:906:c441:: with SMTP id ck1mr2197091ejb.257.1641877383898;
        Mon, 10 Jan 2022 21:03:03 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id e26sm4502125edr.82.2022.01.10.21.03.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 21:03:03 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id h10so20570678wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 21:03:03 -0800 (PST)
X-Received: by 2002:a5d:6c68:: with SMTP id r8mr2161062wrz.281.1641877383117;
 Mon, 10 Jan 2022 21:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20220110025203.2545903-1-kuba@kernel.org> <CAHk-=wg-pW=bRuRUvhGmm0DgqZ45A0KaH85V5KkVoxGKX170Xg@mail.gmail.com>
 <20220110205603.6bc9b680@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20220110205603.6bc9b680@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 21:02:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieO-N=XD73D=OKJ88Y_=GiF9OGm2yg3s_nvafPxAFYwg@mail.gmail.com>
Message-ID: <CAHk-=wieO-N=XD73D=OKJ88Y_=GiF9OGm2yg3s_nvafPxAFYwg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 5.17
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 8:56 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
>   The only explanation I can come up with it's that it was
> done so that people running olddefconfig right after the per-vendor
> split was introduced wouldn't lose all drivers.

Yeah, I think that was the reason. Don't hide existing drivers behind
vendors that got turned off.

I think it would probably be fine to have entirely new vendors (ie "no
existing drivers") default to 'n' when added, just to cut down on the
huge amount of driver questions.

But right now they all act the other way around, and are just a way to
explicitly turn off questions for a vendor you know you don't care
about.

It does perhaps get a bit confusing if some vendors are 'default y'
and others are 'default n'. It's easy enough to explain at the time
when that vendor is added, but then ten years passes, and somebody
asks why something like DEC or 3com is 'default y', while soem big new
vendor migth be 'default n'.

So I dunno.

            Linus
