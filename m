Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72153467BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382225AbhLCQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345203AbhLCQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:56:52 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2E6C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:53:27 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso4160952otf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qpCvSmXosx1WH8jKO1/esH6bI+63Y23SrI45rVdnNE8=;
        b=dsc1rSwQ61xSHEZWCXJkzlb8DGemiMujE7SoQTc9e5sfDFaOeWc9lXtcTAk6LJlkO8
         0aVZZaWz6NKE85HP1zrt0BUvRtsB4oITNjqOuO6pOxaBfRsgNHKx0+L9PTvL8FPBUPwh
         dm1OIaR7ShKERlxpc5okWaiJiueamY3UII8HTxM74lIQ7fnVxwjN22sfeK9FlPq31iI0
         0DbGqMs2H6wjAXZCvNpsdOqpa6IUEMksy/5qS3d3GSN6s8fgIm5Mrx+1dJvZ9JieuY7K
         wcq6ZRtIIp/9D9PaKMxLSyMjCks66on3dPfnQPV3s5ikujBaQvDeva/dhkubjFHchYi5
         u45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qpCvSmXosx1WH8jKO1/esH6bI+63Y23SrI45rVdnNE8=;
        b=jt5GqmS4PaLC1ikx3Je/cauum1HJMrpe7tT3HdwW/8M5G/BQRVhfFUfWgY9zw/wUQE
         JPBobm1It2q/rB1nZ6IbDGAoUjGr3OXl9l9o7dqKM+TAd+ZSWu7Qr0s/DwzjZjJe67Ja
         d5Igd2tuZ1q0a+CpN1VRZEY3/KU0iuRAdiFHAB6/TcVOUlEsXdS6low7zQu0hYLaxFyt
         Ja60DnIt/7UjBm5frht1GYhgbOEa+APCjU0w6VGPx6rpsZ7NyemFfhktN2HpZujS5/YD
         6z2h0N6WNvfY82huvMbQqR01qWNtJWKM5ltUNEi33tHblL6GpVdKpTIgGZGKSk3yRtUJ
         Q0Hw==
X-Gm-Message-State: AOAM532nCmNZM0Sa1aPhQ/YvbqJe97r+tNjpE/LOkz3RlUZvr2TyhmNR
        mPWnEdyuthHERU1lTzqlWlwlx4Qh6fJL54Wm/+S7+Q==
X-Google-Smtp-Source: ABdhPJzRAC70hV/vdXCu824GJhpmhteP0JzcwqqihmbC7A5owodohjiSu47SEwBa1GAo9AMopTEOhXq/48Rqtq3cVGQ=
X-Received: by 2002:a9d:2ae1:: with SMTP id e88mr13032680otb.157.1638550406487;
 Fri, 03 Dec 2021 08:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20211203093000.3714620-1-keescook@chromium.org>
 <CANpmjNPCjXp_0iQjdznpvS2vF-VvDkxJrtWnBAoj6TAU488VAQ@mail.gmail.com> <CE7F1A95-67C7-4BDA-B803-D93901EC2378@chromium.org>
In-Reply-To: <CE7F1A95-67C7-4BDA-B803-D93901EC2378@chromium.org>
From:   Marco Elver <elver@google.com>
Date:   Fri, 3 Dec 2021 17:53:15 +0100
Message-ID: <CANpmjNMCrLU0J3W+-=wihEaHXMytSfNy=iu-8-oO8JDvEUYAJw@mail.gmail.com>
Subject: Re: [PATCH] lib/test_ubsan: Silence compile-time array bounds warnings
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2021 at 17:21, Kees Cook <keescook@chromium.org> wrote:
> On December 3, 2021 2:49:53 AM PST, Marco Elver <elver@google.com> wrote:
[...]
> >Are there other warnings or only the one for the fsanitize=3Dobject-size
> >test? I think this is fine if there are other warnings.
>
> I will double check, but I think it's only the object-size test, which se=
ems to confirm my suspicion that -Warray-bounds provides sufficient coverag=
e and object-size can be removed.
>
> I have another patch I intend to send today for the sk_buff/sk_buff_head =
issue, as -Warray-bounds warns for that as well.

Nice.

Do you want to send the patch removing UBSAN_OBJECT_SIZE, or shall I
do it? Perhaps it ties in better with the rest of your patches which I
have no state of.

> >But, if it's only about the fsanitize=3Dobject-size test, I'm going to
> >propose something more drastic. :-)
>
> Are there any cases where object-size does a run-time check that couldn't=
 be done at compile time? That's the only reason I could see to keep it at =
this point, as -Warray-bounds can do the compile time checks.

No, I don't think so.

I stared at the LLVM code several times now, because I still couldn't
quite believe it myself, but I think it really doesn't do any dynamic
checks. Hence, why below I say it should have been a compiler warning.
As mentioned in the bugzilla bug, there's a FIXME in the LLVM code to
do a dynamic check with the help of fsanitize=3Daddress, but that never
happened. And that doesn't make much sense anyway if fsanitize=3Daddress
(viz. KASAN for us) is already on and does checking itself.

> >I had wanted to wait a bit and dig a little deeper, but I just posted
> >part of my analysis here:
> >https://bugzilla.kernel.org/show_bug.cgi?id=3D214861#c4
>
> Thanks, I'll refer to that in my sk_buff patch. It seems -Warray-bounds s=
uffers from the same conservativism about object casts, which is frustratin=
g on the one hand since the warning can be a false positive (cast vs access=
), but on the other, it does call attention to fragile arrangements which m=
aybe could do with adjustment.
>
> >My proposal is to remove UBSAN_OBJECT_SIZE and its related tests. The
> >bugzilla bug goes into the details, but the TLDR is:
> >1. fsanitize=3Dobject-size is incomplete,
> >2. it should have been a compiler warning,
> >3. for everything else there is KASAN which detects real OOB,
> >4. for GCC we already disable UBSAN_OBJECT_SIZE.
>
> And maybe:
> 5. -Warray-bounds provides the same coverage and is about to be enabled g=
lobally.

Yup, in which case the compiler warning already exists and point #2
above is moot.

Thanks,
-- Marco
