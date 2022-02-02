Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45014A7A21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbiBBVTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiBBVTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:19:49 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AD7C061714;
        Wed,  2 Feb 2022 13:19:49 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y17so490056ilm.1;
        Wed, 02 Feb 2022 13:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1f3qkBr7OwcMuEx7wDz36wE1LVweMZmBxkf7MbPeZyY=;
        b=FW3cbUBB7agROZ5YjTp7b4wsXG8Zt/C3ptprYzXJKdtvPFTcrX4Afpqs/7NS0o+/vE
         jJsIE6EDQb7vXkcYP4K+7r7iydD7Ze+2DI4m1g1gypljaI34DYo3pml8tDShbPTwYwQR
         Y5Q/+q4U9oYRq9zmfzxVrrKBbuu8oz3uFgyuUnzt/v/cL6uVTNyOB4OneO53sQT1Vo1D
         lMRJ8D40UcPgYxD3SRwynNM6V2lPtVR6JyM7Lmw03ey4Yh2r855NYSl837GElvTPH8F9
         EiuVUBLvwyKelinM55k0PZ1TuyQrDYT42NL1Dsey6+ck8I1lgr1WdovEBekVjCGeqt2X
         v45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1f3qkBr7OwcMuEx7wDz36wE1LVweMZmBxkf7MbPeZyY=;
        b=ZXVf3GkS94ZhtIprnax0lEvVLf/Xs5eZn7smjTS2wnoo1audi+biRXKHVSQJ3dFuez
         6kIZ5IavTMISd9aMwsUv7AmfyYdbVriSjvV6bcSsL8NaCrDRbL3H8+9rFhzoY49L9ic9
         YB6Tb09lZALJI2vcABhSKcuKwVtFkzsrb6X7W8nqvrjI3mR2zZlyI3lMC2Sx/ydNBmi8
         2EkmYjZrOt9i7+8V7xs78l/UggTMnyTBRR9CIrBig40xQuBH35QbqtXcHtGr33qmn90I
         ylRWWWvWTCvBD9QOcEQ7No64QP/PXUMsdKi1rtDZKaKwRf88/UxZbpmKQRTVWFNs3fIN
         38FA==
X-Gm-Message-State: AOAM531HFy8LlnJ9wbaPG2hUjQq/e8cZl1KGoaQjnhjCqfLXSfEhyMHC
        eSoiq35iWjzLz9KEjcUVfMOwrrXj+kMw+OEEpqY=
X-Google-Smtp-Source: ABdhPJwltdwbEUw1cD6vun2+dt9kM8XuGcKuEW6K+qmiH1QnB8UKmy7cfDAtdjSF3hCiPhz+q6+7gGJ4BjDsp+QuIoI=
X-Received: by 2002:a05:6e02:80d:: with SMTP id u13mr18427272ilm.151.1643836788498;
 Wed, 02 Feb 2022 13:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20220202003033.704951-1-keescook@chromium.org>
 <20220202003033.704951-2-keescook@chromium.org> <CANiq72n1d7ouKNi+pbsy7chsg0DfCXxez27qqtS9XE1n3m5=8Q@mail.gmail.com>
 <202202021307.75435AF9@keescook>
In-Reply-To: <202202021307.75435AF9@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Feb 2022 22:19:37 +0100
Message-ID: <CANiq72kw_=6HfSbVJovxQuJwYT8sQ2TNnyRa8gr6v1i5Jws9ZA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Compiler Attributes: Add Clang's __pass_object_size
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 10:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> It's the kind of detail I feel like I might forget a month from now, so
> I added it as a bit of a hint. If you think it's too redundant, I can
> leave it off.

If you think it is valuable having it nearby (e.g. when inspecting the
definition of the attribute in a call site), then it is fine having
them -- I am all for documentation (and we could consider having a
small summary/one-liner for all attributes). But, in general, I would
avoid repeating all the compiler docs (or, if needed, we could fix
those upstream if they are not clear etc.).

Thanks!

Cheers,
Miguel
