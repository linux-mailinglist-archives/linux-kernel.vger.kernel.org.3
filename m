Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA2489F08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiAJSS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiAJSSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:18:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD9BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:18:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u25so57105461edf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JmRll1Fddx8xTI0EeFA4/9o6886xdpu4qxsEDz1gfE=;
        b=cQUdFQpr2qrrieJa/HYFXAZsYmewFeIRPCYMGI3oLeM71nrA75u1rNyQ7TeYM/ylDl
         HDeABpIxvgkHjxQNWncor28RVo2hrNhBsir2PZ8p7UHFsW7e/I6gslboi7hLX2cOEKjT
         0M9hqcZ6Y/YTHadvA7XxjGqa+QBywwGHEH/vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JmRll1Fddx8xTI0EeFA4/9o6886xdpu4qxsEDz1gfE=;
        b=q2bq+KlBk5K2NJXP5QnURKa2YP3jcZsOOSzacaTsuAD/31iq6Axf2lRdleGwVrFll9
         x0UdbD1l/j5hhj8KGi0tC/tAKM4rFlBGWa7Hc/hz0578ETDWfwbvc9sTFF0L2eHL5Kga
         6XY0mMQ7f8XEXPaFqtuJ1EBC7b8/I6jmBWl8itwWFTZXYQ+0SAfLL9HywAM2Dh7/HRQA
         lAWNJilsPWfFu4jTQjZa/BRSXsVF1OJiwmDldJRZqdJkFXedkUl/ZFk4+JKZFuve2DKb
         FoPIjQJbOPh8gR7Wwua/N16ww2RzG32NiaUVuzftXv5g3x71o6usDNpRubBymfN9UC0a
         6oPA==
X-Gm-Message-State: AOAM530zWBIb3bLAfAQJ9CZtyehSqQ+s/qpXaeZ2ryBDx2z9Xdz04NyS
        h40X3Q21NwMqxk9oe5RWahSBPYbO4N8+tuTUSAw=
X-Google-Smtp-Source: ABdhPJw2FN5nRdLWH7gPOhBU2GmgZUI9k5zpvdlNzES82FlLKOpq42Dw3/qUKuSkHK+vrd4vME5mfw==
X-Received: by 2002:a05:6402:2684:: with SMTP id w4mr839128edd.139.1641838703056;
        Mon, 10 Jan 2022 10:18:23 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id qp24sm2692790ejb.84.2022.01.10.10.18.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 10:18:22 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id q8so28319246wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:18:22 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr686924wrp.442.1641838702400;
 Mon, 10 Jan 2022 10:18:22 -0800 (PST)
MIME-Version: 1.0
References: <YdwVl0H54fmUIux0@zn.tnic>
In-Reply-To: <YdwVl0H54fmUIux0@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 10:18:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+UbGrgH4CzKSoTYGPidyv5isiLMxJKAqnV3NFTiRdaQ@mail.gmail.com>
Message-ID: <CAHk-=wh+UbGrgH4CzKSoTYGPidyv5isiLMxJKAqnV3NFTiRdaQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/cpu for v5.17
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 3:16 AM Borislav Petkov <bp@suse.de> wrote:
>
> - Avoid writing MSR_CSTAR on Intel due to TDX guests raising a #VE trap

This is all fine, but my reaction to this is that I would have
expected it to be either a wrmsrl_safe(), or using an actual CPU
feature check.

Checking for a particular vendor seems a bit hacky. We generally try
to avoid things like that, don't we?

Not a big deal, I just thought I'd mention it since I reacted to it.
And we don't seem to have those vendor checks in any of the other code
that uses MSR_CSTAR (just grepping for that and seeing it mentioned in
kvm code etc)

             Linus
