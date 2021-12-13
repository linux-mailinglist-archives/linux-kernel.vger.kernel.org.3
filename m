Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6FD4733B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbhLMSL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241748AbhLMSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:11:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838F9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y13so54523352edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4UW5j/DAkCc/GJX2BUX/yWktradTQUMy+BaoVEG+EJA=;
        b=EsIDxTg9CzNw4fJQWE8yFlSW6OFoIiLaFGpckLNKFe2tqJdUO0ynkfmVVm93UsMh+c
         HXfoCPxe1k5weQNgLDnjDECOV3RwiU4dqTI27KtEHSyTUY9HD5XG/PItS3PFYoSqdqXX
         m9RvezfM6xyFjN8mDwIGPk60/0ELYdZqDrzFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4UW5j/DAkCc/GJX2BUX/yWktradTQUMy+BaoVEG+EJA=;
        b=Pxh6OSqMkSjMc2DHdDnlSMhhdYs9LTlngU0dROe750bAoqVVfHB3k0MpWxJlqBCUSV
         mMU6Lhs60sNzA0vhvPyDAQYAaVoCVqqNHQMwoR7Tp91x3Nj2+/EWFs1Bg/Ryzfj49FxJ
         gQU9c2cS3IArZmmhBMzsg0MDgRj82ExW8MAXWlgUhxtdB/EDpo+pxPMxeeySCjaGoP4K
         aKH1zvF1EQ6lHYSnMQjRJyRgSnUfvXWuwqu4likToG8kCeQcN5XhcrBNYcURfuul1gFH
         vsX0bqNNNtEKRiN9zPc6TJkKsJAXLho0vgHxPalwtLgzjNzbG0q/OwIN8NsaEi+wBQdW
         Zo4A==
X-Gm-Message-State: AOAM53057HxPD8VdKkyn9M8WdBlpnpvLPpaAcieKhtsyANdC8JsxE3n1
        S59ZyJQtdGdqNl+oGNVCzyzq42Tz73sAREwq
X-Google-Smtp-Source: ABdhPJxCgam30WJufAe/ye/ZUG9uVzHhuvpMkLsndQFvLh8Cfjet6O+NLi4+J38hqxwvPCXc68Ge2g==
X-Received: by 2002:a17:907:3e14:: with SMTP id hp20mr10187ejc.576.1639419106510;
        Mon, 13 Dec 2021 10:11:46 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id jy28sm5980430ejc.118.2021.12.13.10.11.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 10:11:45 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id a18so28528571wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:11:45 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr86021wra.281.1639419104933;
 Mon, 13 Dec 2021 10:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20211210161618.645249719@infradead.org> <20211210162313.857673010@infradead.org>
 <20211213164334.GY16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211213164334.GY16608@worktop.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Dec 2021 10:11:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjc+mr_Rh++5pPDkNFuceyPwFxCtzp124AppBLgbVVV0A@mail.gmail.com>
Message-ID: <CAHk-=wjc+mr_Rh++5pPDkNFuceyPwFxCtzp124AppBLgbVVV0A@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] atomic,x86: Alternative atomic_*_overflow() scheme
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 8:43 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> So Marco was expressing doubt about this exact interface for the
> atomic_*_overflow() functions, since it's extremely easy to get the
> whole ATOMIC_OVERFLOW_OFFSET thing wrong.

I missed that discussion (maybe it was on irc? Or maybe I just get too
much email).

Anyway, my preferred solution would simply be to make the ref-counting
atomics use a different type.

Voil=C3=A0, problem solved. You can't really misuse them by mistake,
because you can't access it by mistake.

Sure, it could be a wrapper around 'atomic_t' on architectures that
end up using the generic fallback, so it might be as simple as

   typedef atomic_t atomic_ref_t;

in some asm-generic implementation, although I suspect that you'd want
type safety even there, and do

  typedef struct { atomic_t atomic_val; } atomic_ref_t;

But then on x86 - and other architectures that might prefer to use
that offset trick because they have flags - I'm not sure it even makes
sense to have anything to do with 'atomic_t' at all, since there would
basically be zero overlap with the regular atomic operations (partly
due to the offset, but partly simply because the 'ref' operations are
simply different).

(Wrt naming: I do think this is more about the "ref" part than the
"overflow" part - thus I'd suggest the "atomic_ref_t" rather than your
ofl naming).

            Linus
