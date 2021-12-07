Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DD946C20D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhLGRtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbhLGRtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:49:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80548C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:45:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y13so59906869edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCz8dGlbcF+sMn1q+rwc1GqBThV14yxrl/bbuNcC8yg=;
        b=YO5EjeN1u4d1oNpRT1doTRBON845Y7orrNijyuDtDONnciEIfIPav5TWcm3vRfGEo4
         PdmedxTKjCGmD8y2kpaQqLeDigWtuTSI7VsieaLeOeCjePWL7oSibmGiEDUBbmHJTZVQ
         ebZxToLSOoL9OOkmCSdKvGQbqtUJLJNS5Zqr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCz8dGlbcF+sMn1q+rwc1GqBThV14yxrl/bbuNcC8yg=;
        b=NFxFc06ztdmEilgE4ikhDhF/vsXI4+89jBZAtwA1hWEidC9wZ6w99VJwbqwmPJJXoT
         4SBVS5LH6mudumNTF0GR4lZnZzW789rusKwfGNrNoy73h0HoyLLLaXE/aUyR5bGA5BnV
         oNDAAeACAoygPMYhNSWhzB56NGnH1qPMqK2h7DmxGhnrqJUJeoa0L++20Ccpm5cReGty
         4N+SX0q03gnZuzBmHhATHkFz25xfE1Bf7bqOGOK+64+9YhOBgzjuGk4lSOfLxg1D2VtC
         3OsHJPPoSvDw9HF9wJgWNTlWrIbNCDkLlZNDNsVpHfp7PSMZMf1Iy1/kWcKI9GkyTEPc
         Livg==
X-Gm-Message-State: AOAM530NW1cx20Fn0junI1Y4BmydnFDPIWz9sKOKFjMkchmz8dWkY8Ux
        DXVm5tptO/0TFtgqou8xi3qXLxSFGB5rEGDp
X-Google-Smtp-Source: ABdhPJx+kLwY6TSrekYgDj9t23nOzYdSFnobZvG4ZROtw/VQTRQM6bBVwZmyJ0tC9+ieudgPqK5mpA==
X-Received: by 2002:a17:907:3e8f:: with SMTP id hs15mr897256ejc.251.1638899146828;
        Tue, 07 Dec 2021 09:45:46 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id nd36sm144983ejc.17.2021.12.07.09.45.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 09:45:46 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id o13so31032998wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:45:45 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr53850398wrn.318.1638899145701;
 Tue, 07 Dec 2021 09:45:45 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net> <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
 <Ya+RPbdgEn6l6RbS@hirez.programming.kicks-ass.net> <CAHk-=whkx24ON4Ow0xkz-FSyb6nsZxxps5gEh7gCaSOvq4MNMw@mail.gmail.com>
In-Reply-To: <CAHk-=whkx24ON4Ow0xkz-FSyb6nsZxxps5gEh7gCaSOvq4MNMw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 09:45:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHtZqTdZYv7o7cKyj9rozWeX+MrYCPpo0ik3kHWRdFdw@mail.gmail.com>
Message-ID: <CAHk-=wjHtZqTdZYv7o7cKyj9rozWeX+MrYCPpo0ik3kHWRdFdw@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 9:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In the case of "dec_and_test" the "decrement to zero" case may not be
> hugely exceptional, but if you do the same for "increment with
> overflow protection" you do end up having the two different "zero vs
> too big", so it would actually be more consistent, I think..

Hmm.. Of course, that "increment with overflow protection" might not
actually want two targets in the first place, so maybe this argument
is BS.

Particularly if you can do the "zero or overflow" case with just one
test, maybe you really do want both cases to be one single error case.

And then your "refcount_dec_and_test()" with a return value (for
decrement to zero) and a separate error case (for errors) looks fine.

               Linus
