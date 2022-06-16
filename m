Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96D54E9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiFPTTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiFPTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49FB55498
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:19:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w27so3483694edl.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpcGuEMSHNtJO6AL8yUFZTbd1w1Zp8LDaZt4zG7HQg8=;
        b=egGfdeT+mpO40XdFqHUt/mNRkwROuAaGPwmvBbc9V8CKQtgzMIeJ5dydpj2F6YqAWD
         jWaLyXMYcKZAUkbCHTdiuA4JkddfCRJMKfg3Rr2z7QYsJo+0kuIs2gL8w23PGhI7/UU1
         zp0PY/UWDuWBbGaf5HZQqxyladpYTQRU+gj7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpcGuEMSHNtJO6AL8yUFZTbd1w1Zp8LDaZt4zG7HQg8=;
        b=tIyi1aW2+E8kUrrU/DzetbUqTtpXwu54e4Fp+Wr1l8SohjU03Q7ILHIX9EUG3MRhRP
         mBk1TTIc7JIcK7Kd9zUP5QeizgsrGHLO0CtiEATauG136WxXWc9AuEanM1YlnfbqKNp6
         Wy4o60QswaiOsgsETNF6lYif/7mklR6ve9u4m6bTAL2XufjVTTUfG2x+VaGMZYiqqeyt
         25geK5b26d4XF0cO9qzxy9HvXF2afbvYAuMpjVKHs3JVjh6eBLmHAbyKJOizq1L6ItOp
         ZtmuK2fSHQnz3I+BeBxz3CwvkVdRccerml14PEGsS99nxJpiEO6VSAIEZ3O2tpqpByqO
         4gFQ==
X-Gm-Message-State: AJIora8CsMeV8AWI/nGXMAOWZ2Q3v/gedOZ9vtQ/8jEJewsTnU5BYJeD
        TWW+QJlqPPVoUl2+l2xXbnQLcJNuplNbSK6V
X-Google-Smtp-Source: AGRyM1sKdczklSjtx9f9RcireLDCs9ku45Sy2khR2rFrC+gzGE4YzlHKLKLILFI+wg/dpvcGSiP1Xw==
X-Received: by 2002:a05:6402:2714:b0:431:6a31:6530 with SMTP id y20-20020a056402271400b004316a316530mr8376771edd.245.1655407156090;
        Thu, 16 Jun 2022 12:19:16 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id y21-20020a056402441500b0042dcbc3f302sm2395462eda.36.2022.06.16.12.19.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 12:19:14 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id o8so3076928wro.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:19:14 -0700 (PDT)
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id
 10-20020a5d47aa000000b002185ac8f3a8mr6159072wrb.442.1655407153820; Thu, 16
 Jun 2022 12:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220616143617.449094-1-Jason@zx2c4.com> <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com> <YqtKjAZRPBVjlE8S@casper.infradead.org>
 <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
 <Yqtd6hTS52mbb9+q@casper.infradead.org> <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
 <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
In-Reply-To: <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Jun 2022 12:18:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi28vwsG-JNJEz_kc=qwPkYtYfh_14eHOUZsaGESDBDBA@mail.gmail.com>
Message-ID: <CAHk-=wi28vwsG-JNJEz_kc=qwPkYtYfh_14eHOUZsaGESDBDBA@mail.gmail.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In that situation, we'd probably just see "long long" being 128-bit
> ("I32LP64LL128").

Looking around, it looks like people prefer "long long long" (or in
the kernel, just "u128") for this, because so many have already gotten
used to "long long" being 64-bit, and 32-bit architectures (where
"long" is 32-bit and "long long" is 64-bit) are still relevant enough
that people want to keep that.

             Linus
