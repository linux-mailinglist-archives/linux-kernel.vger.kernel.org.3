Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A2D55B404
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiFZUTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiFZUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:19:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9814EEA8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:19:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sb34so14946766ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nu9/GNmE/6Ec+yjhAIVpoKG+URCXP5VRgR+sJEJG8es=;
        b=GS6ies+w8dks9EOoUgtl81vz5KmxCBNl3MtTNDunbS5G09OfLVE9+pe01sIcgRSP7j
         y2J+Vbd+0ANVyGZFeU9/mcuuqzKgarpxGzeqzj4N4+QeDP5xIp9KeumK23Th9eQALYwY
         J7gFRWMFWHj8uHEIQIbQ+W5/Q2J/F6JU3i8qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nu9/GNmE/6Ec+yjhAIVpoKG+URCXP5VRgR+sJEJG8es=;
        b=BiTheDpoRCESFJZORJqcVg0uf+ZbC7aoqBcz67SykDx7rTuNItPWMFxL9oF4spbJEb
         2KtFvOybiF38ks+5EZ51+2d5bRBFZh0sHP58cOLvx4uDOt2jRvNuuuFJUSXKyGczWB/j
         atKF+G8ppvLNMNU2jmt7YuUv04Ft06sdi+KMVyQu+AdHZM17zGentrx+y+tHpaqDxAbm
         WaL6/hNaxLBgDw9f+H4xP2IaIrt+y7ygvb+QcHch3BymwgeBn8ZFHfBUMduhjBQqSw26
         J8RqG/MHDyFWnqFIuPpQrNDG0nS0VXbA85RiMq4DFLg6CKOkBo89AKwz34KNTZqZwi+Z
         6r8w==
X-Gm-Message-State: AJIora9gqwpSSb18pERxKBjKzxjm2kfa8p5f8lTGs9Whd8VpWYRnEEoh
        lDh0pLS9X58tLRxif+hs56ZfIev6KM/2pqDf
X-Google-Smtp-Source: AGRyM1svf7hGrq1ZqXPgocTR4QRjlbxlmSZl3Gf8leNGYy9I2pQcZGcwZddGC7SlM4vobNBHw1Howg==
X-Received: by 2002:a17:907:6e06:b0:726:29f0:78d5 with SMTP id sd6-20020a1709076e0600b0072629f078d5mr9622225ejc.186.1656274779880;
        Sun, 26 Jun 2022 13:19:39 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id bl24-20020a170906c25800b00704757b1debsm4105751ejb.9.2022.06.26.13.19.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 13:19:38 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so4418747wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:19:38 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:3a0:2da6:d173 with SMTP id
 a1-20020a05600c068100b003a02da6d173mr15926468wmn.68.1656274777880; Sun, 26
 Jun 2022 13:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com> <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
 <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
 <20220621005752.ohiq5besmy3r5rjo@moria.home.lan> <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
 <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com> <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
In-Reply-To: <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 13:19:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
Message-ID: <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
Subject: Re: [RFC[ Alloc in vsprintf
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: multipart/mixed; boundary="000000000000c9d81005e25f851c"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c9d81005e25f851c
Content-Type: text/plain; charset="UTF-8"

On Sun, Jun 26, 2022 at 12:53 PM Joe Perches <joe@perches.com> wrote:
>
> In a reply to the printbufs thread, I wrote a proposal to use an
> alloc to reduce stack in vsprintf when CONFIG_KALLSYMS is enabled.
>
> No one has replied to this but I think it's somewhat sensible.

I think that's a bad idea.

Those things are *literally* called from panic situations, which may
be while holding core memory allocation locks, or similar.

The last thing we want to do is make a hard-to-debug panic be even
*harder* to debug because you get a deadlock when oopsing.

(And yes, I realize that the symbol name lookup can have problems too,
but thats' kind of fundamental to %pS, while a kzmalloc isn't.

Now, you are correct that the stack buffer is annoying. But I think
the proper way to fix that is to say "we already *have* the target
buffer, let's use it".

That does require teaching the sprint_symbol() functions that they
need to take a "length of buffer" and return how much they used, but
that would seem to be a sensible thing anyway, and what the code
should always have done?

It's bad policy to just pass in a buffer without length, and I think
it was always broken. Nasty. That KSYM_SYMBOL_LEN is magically taking
care of it all, but it's ugly as heck, wouldn't you say?

NOTE! The attached patch is completely broken.  I did not do that
interface change to the kallsyms code. The patch is literally meant to
be just an explanation of what I mean, not a working patch.

                  Linus

--000000000000c9d81005e25f851c
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l4vr87ma0>
X-Attachment-Id: f_l4vr87ma0

IGxpYi92c3ByaW50Zi5jIHwgMTggKysrKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saWIvdnNwcmlu
dGYuYyBiL2xpYi92c3ByaW50Zi5jCmluZGV4IDNjMTg1M2E5ZDFjMC4uMDMyZmE4YmM1NzUyIDEw
MDY0NAotLS0gYS9saWIvdnNwcmludGYuYworKysgYi9saWIvdnNwcmludGYuYwpAQCAtOTgxLDcg
Kzk4MSw3IEBAIGNoYXIgKnN5bWJvbF9zdHJpbmcoY2hhciAqYnVmLCBjaGFyICplbmQsIHZvaWQg
KnB0ciwKIHsKIAl1bnNpZ25lZCBsb25nIHZhbHVlOwogI2lmZGVmIENPTkZJR19LQUxMU1lNUwot
CWNoYXIgc3ltW0tTWU1fU1lNQk9MX0xFTl07CisJdW5zaWduZWQgbG9uZyBtYXhsZW47CiAjZW5k
aWYKIAogCWlmIChmbXRbMV0gPT0gJ1InKQpAQCAtOTg5LDE4ICs5ODksMjIgQEAgY2hhciAqc3lt
Ym9sX3N0cmluZyhjaGFyICpidWYsIGNoYXIgKmVuZCwgdm9pZCAqcHRyLAogCXZhbHVlID0gKHVu
c2lnbmVkIGxvbmcpcHRyOwogCiAjaWZkZWYgQ09ORklHX0tBTExTWU1TCisJbWF4bGVuID0gZW5k
IC0gYnVmOworCWlmIChtYXhsZW4gPiBzcGVjLnByZWNpc2lvbikKKwkJbWF4bGVuID0gc3BlYy5w
cmVjaXNpb247CisKIAlpZiAoKmZtdCA9PSAnQicgJiYgZm10WzFdID09ICdiJykKLQkJc3ByaW50
X2JhY2t0cmFjZV9idWlsZF9pZChzeW0sIHZhbHVlKTsKKwkJbWF4bGVuID0gc3ByaW50X2JhY2t0
cmFjZV9idWlsZF9pZChidWYsIG1heGxlbiwgdmFsdWUpOwogCWVsc2UgaWYgKCpmbXQgPT0gJ0In
KQotCQlzcHJpbnRfYmFja3RyYWNlKHN5bSwgdmFsdWUpOworCQltYXhsZW4gPSBzcHJpbnRfYmFj
a3RyYWNlKGJ1ZiwgbWF4bGVuLCB2YWx1ZSk7CiAJZWxzZSBpZiAoKmZtdCA9PSAnUycgJiYgKGZt
dFsxXSA9PSAnYicgfHwgKGZtdFsxXSA9PSAnUicgJiYgZm10WzJdID09ICdiJykpKQotCQlzcHJp
bnRfc3ltYm9sX2J1aWxkX2lkKHN5bSwgdmFsdWUpOworCQltYXhsZW4gPSBzcHJpbnRfc3ltYm9s
X2J1aWxkX2lkKGJ1ZiwgbWF4bGVuLCB2YWx1ZSk7CiAJZWxzZSBpZiAoKmZtdCAhPSAncycpCi0J
CXNwcmludF9zeW1ib2woc3ltLCB2YWx1ZSk7CisJCW1heGxlbiA9IHNwcmludF9zeW1ib2woYnVm
LCBtYXhsZW4sIHZhbHVlKTsKIAllbHNlCi0JCXNwcmludF9zeW1ib2xfbm9fb2Zmc2V0KHN5bSwg
dmFsdWUpOworCQltYXhsZW4gPSBzcHJpbnRfc3ltYm9sX25vX29mZnNldChidWYsIG1heGxlbiwg
dmFsdWUpOwogCi0JcmV0dXJuIHN0cmluZ19ub2NoZWNrKGJ1ZiwgZW5kLCBzeW0sIHNwZWMpOwor
CXJldHVybiB3aWRlbl9zdHJpbmcoYnVmLCBtYXhsZW4sIGVuZCwgc3BlYyk7CiAjZWxzZQogCXJl
dHVybiBzcGVjaWFsX2hleF9udW1iZXIoYnVmLCBlbmQsIHZhbHVlLCBzaXplb2Yodm9pZCAqKSk7
CiAjZW5kaWYK
--000000000000c9d81005e25f851c--
