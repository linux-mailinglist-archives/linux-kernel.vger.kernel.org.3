Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D78E58192D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiGZRwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiGZRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:52:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CFA30547
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:51:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b11so27456388eju.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hcX6KhTdKn6IT76TuXIYyUYZUxfTYB2Bq37rQdhdSs=;
        b=eU/+AXbmekdCbS2NFUEiOSvMmjEigZ6X0kwEp7iDmjuhNdkDjIuw/a96LINx4vugdR
         ggY6L6kQUqT0tLYJXasbz8wYdzTz1I53MA4m7tvoOAIIwvp4pAUTJBntOt9WsG6q/Cfr
         XtVYFrL4K7ykWK3zLl17V7gh5qOTa76q1ETJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hcX6KhTdKn6IT76TuXIYyUYZUxfTYB2Bq37rQdhdSs=;
        b=0r9rHjXRJ+IJd+swEVHZBuAor64furoVowSmga1wzGmp8ZNs9BeoGLtU6f9zUMMaaW
         6l+/b3pOnJsfHOTQ+cBNksRRnGnVaDh4F5vPRdUWxH4MZ2eu/mjmc40AeXp3Vkj6LSi0
         BT6bvKIaeZvagzFln3b23EhPcIID9B2DgzfxfqKXDv7Wq3f+M0NGAXL25CsAP7EckbcW
         hb46EbDf0QP8HLYIxAlPL8bjE72O0VUq1PHPD4l7vif1qq5fh/VoYnKfP6zrVLgonmQ1
         NV8/jzcyNy5BXh0qaOjolhsRJCXXMT53gvjFmhRdsmROcdai3GkXwyi/k4Zcl8jdmTsl
         lFvg==
X-Gm-Message-State: AJIora9SYpyfQknCdkVJrlnyVR9v3vYgRcubAwAAgEJrp4J1p/y6lPWc
        wfslUwrPqWVJrLc5gxb4kZNRkImrd+fiV8rq
X-Google-Smtp-Source: AGRyM1uhwLowyKm8K/tddasr8Ky9H6CECn/CH0tOG9W86P8QrpDXs0yKwkVyxPHxjvAkbpVb6z9L7A==
X-Received: by 2002:a17:907:980b:b0:72b:215c:7933 with SMTP id ji11-20020a170907980b00b0072b215c7933mr15037304ejc.431.1658857878705;
        Tue, 26 Jul 2022 10:51:18 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906200a00b0072b41776dd1sm2228766ejo.24.2022.07.26.10.51.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:51:18 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso1190587wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:51:18 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr259800wmf.38.1658857877756; Tue, 26 Jul
 2022 10:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net> <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora>
In-Reply-To: <YuAm5h1B6bsrR/9q@fedora>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jul 2022 10:51:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
Message-ID: <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
Subject: Re: Linux 5.19-rc8
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:39 AM Dennis Zhou <dennis@kernel.org> wrote:
>
> Are we okay with adding the contract find_*_bit() operations must handle
> asking for past size properly? FWIW, we'd have to modify most of the
> iterators in find.h.

So I think we're ok with it, if only it makes the macros simpler.

I also think we should probably look at the m68k case, because while
that one seems to not have the bug that the arm case had, if we remove
the arm case the m68k code is now the only non-generic case remaining.

And it just makes me go "maybe we should get rid of the whole
'override the generic code' thing entirely?"

I don't think that inlining the first word (like the m68k code does)
is worth it, but it *is* possible that the architecture-specific
functions generate better code for some common cases, so I think this
is a "needs looking at the generated code" and not just a blind
removal.

              Linus
