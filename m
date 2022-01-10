Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1B48A2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbiAJWZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbiAJWZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:25:18 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7CC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:25:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a18so58511404edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8TsWXEfioEfTTK1VDo1lBOqjBTxLrtfK2ag/gwU0Pqc=;
        b=oJ/N1I5VcUaJhr7iJ+kzTzypJazZyuPseg2YMALCEdLKvYFIJxCSUmNV511Z4kpZVk
         JzmcBEe8o4qej9RH1rHOkiB723+S+Rmj2OVk9MYKGurCoA/1XwJSO1kUg0ZsvZepBW/D
         DaigJame+QZp3TU/9fmf8yHIesGHhBV8YwvYJ8ToK6+a5QNPuNdCwbp0i56ynigKr61y
         G3YKkmku0KWvDv4CQf392La3PGTfXW5lJPTuEIcg9I5mbVIlL1PlzUPcM+8BBNvyXZzP
         iSGJlPlNl/Vu/IkiWoC1ThZFlr3UPd7zmnNNqVERmxSNH8ezGAmv6maQMm0UD/OIwx62
         u9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TsWXEfioEfTTK1VDo1lBOqjBTxLrtfK2ag/gwU0Pqc=;
        b=Zuu2XO2cUKYdC0s9mNVX+bDxBWgmnlRK6R2dqaOyaEU7Lvy0/HFlxuTs6J+ZT6TiCs
         Lhr55hgcpF1FY230dn2SUmN+EX0s8xs/Qd2b6AhoK6u2o2Bt8YE3eT68b4sYsVgG4wQb
         N7h+6UE9SMeB36ZrL2RnILlxZ+gFIVZcoFbqWgl8TsU8ZSLfrJA/3oSTg2GDlaErXp1K
         fma1FnovyB96OnhmoVVpMeo1Vg8yu6mW0GsYpnVq1EkrRIpqmlFGTYZ4haQAeYz7AxWq
         yyU1TtjXsyW6M5hAF3Linp4rtrWFoFQZD1yjyoCick12j3uLRec6AaRdiddmWtHb6VZF
         5uvw==
X-Gm-Message-State: AOAM530UXJMuepAsG9968MGDiXhtk12rsmrvOGEy8V6+QnrCeU69ltK7
        n7eMGrPQDd0uFwD3M7FVkM/m1xuPPiU4rFc0uf/mew==
X-Google-Smtp-Source: ABdhPJz/NhDGIg2gfV2mdOsT01yHlsQNq5QJDnIeRGtDliqArx9qwtiFbzpMs4IfWW2ENR4oBVpBN0uZZs3adk2GwAs=
X-Received: by 2002:aa7:db8f:: with SMTP id u15mr1681805edt.36.1641853516933;
 Mon, 10 Jan 2022 14:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-2-dlatypov@google.com>
 <CAFd5g46RUc-v0GmjAEFggmgMxE7Ya_MCwMPO4YMEuFac49XLAw@mail.gmail.com>
In-Reply-To: <CAFd5g46RUc-v0GmjAEFggmgMxE7Ya_MCwMPO4YMEuFac49XLAw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 10 Jan 2022 14:25:05 -0800
Message-ID: <CAGS_qxo63enQyrEO7YOL75oGUsuzbntty-C60Z+==L59qKyBtw@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: add example test case showing off all the
 expect macros
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 2:14 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Jan 7, 2022 at 8:23 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Currently, these macros are only really documented near the bottom of
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html#c.KUNIT_FAIL.
> >
> > E.g. it's likely someone might just not realize that
> > KUNIT_EXPECT_STREQ() exists and instead use KUNIT_EXPECT_FALSE(strcmp())
> > or similar.
> >
> > This can also serve as a basic smoketest that the KUnit assert machinery
> > still works for all the macros.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
>
> I still don't like how much this bloats the example test; aside from
> that, this looks good.

Agreed, it does add bloat.
I just wanted something *somewhere* I could use to smoketest the later changes.
I just remembered how people weren't very aware of the _MSG variants
and thought this could help.

If others have a preference, I'll happily move out and into kunit-test.c.
I'm fine either way as I initially was going to put it there to begin with.

>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
