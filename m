Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35701471C3B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhLLS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhLLS3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:29:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C96C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:29:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o20so45854062eds.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzMrK0Bg1r1Iu+weufQ9dNYIZjGWQ6qcmxZmbk2obMs=;
        b=LudSmqsTJD4KidyI3QagbIOCWT3Sw607/rHpko4Ll1pg1fz3F5Jj1vBo1NoBCdqiGV
         +o3ySX4SBsUoLyDzSJeugVr8sQjjtteg8PYKjiASelQrm/hyIULP48toi9Mq4RdrEXrd
         8BwJHA+BJeRHIK3X5hsmjNezth0949wNI0LQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzMrK0Bg1r1Iu+weufQ9dNYIZjGWQ6qcmxZmbk2obMs=;
        b=bAjKDZjjsbvdaYhe0rXYjaBk5mq5/bgEDrTRDUs8VN8a0Dbj5I1/FM6MG/02QwJdy5
         GKeRyB1bskoQuUGTnoKtZ3//Z26l0GJeumN1GZ7eIAgijcsj1GPANSb+RoaUwOT/Ha1N
         s4EFDXA6xvkyGOLMsB1vCwr6npoiDsmsAt2fka80q4rlJFBtzgWJtaiKalb7J32wlbx3
         IYFaH46h+kC72DRieSCsZ2VaaKGctW6xvJUPTA1bh4RUBdErHFe4fbTG4yF1fXDwL/wt
         9tIWE3B+KaXd4Mmk/Duy/9uYFRia0FwblMeoAQXEl82IelFerbYoNy5aCWySINYXXmfP
         dwmA==
X-Gm-Message-State: AOAM532CXOdF0cMz3Wr5sg8k3oBm3QpAaeiC1AB2uVQzUm6SSK7lY1e6
        KG0XLbaAsU3Gcg7y+XPb7VmSzegTmbRHoERg
X-Google-Smtp-Source: ABdhPJyOeVoX0Vyvzp7m9+bLbD2NAWj5PNUSW1TPl8QcXpGtGXqVbvuSPXwn9iFnv0RTKT9uN7xg4w==
X-Received: by 2002:a17:906:55d7:: with SMTP id z23mr38788672ejp.393.1639333757902;
        Sun, 12 Dec 2021 10:29:17 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id n8sm5176673edy.4.2021.12.12.10.29.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 10:29:17 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso12608843wmr.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:29:17 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr32073895wmq.8.1639333757179;
 Sun, 12 Dec 2021 10:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20211211173447.4155374-1-hjl.tools@gmail.com> <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
 <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
In-Reply-To: <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Dec 2021 10:29:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEgwj3DGZai2GF9+z-FCSS455kGZ9z2g1qtdPLPWpvxQ@mail.gmail.com>
Message-ID: <CAHk-=wiEgwj3DGZai2GF9+z-FCSS455kGZ9z2g1qtdPLPWpvxQ@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 5:52 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Sat, Dec 11, 2021 at 11:38 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Why not let it segfault?
>
> Why let it segfault?

That's not my main worry - what if somebody has a code section with a
zero vaddr and intentionally put the entry at the beginning?

Maybe it's not supposed to work by some paper standatd, but afaik
currently it _would_ work.

All these things are relative to the load address, so a zero e_entry
doesn't mean NULL, and may be a perfectly valid address.

No?

            Linus
