Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ADE4A91DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356367AbiBDBHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353229AbiBDBHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:07:52 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE98C061714;
        Thu,  3 Feb 2022 17:07:52 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c188so5555009iof.6;
        Thu, 03 Feb 2022 17:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqefIdeVL2wI+DwvB62OMGgdDa6H4u4FEw5VtwaQZaY=;
        b=Besvg7YSquJmk8Q/loW/yn4blaDryem68uUPME0EqybIjflP/f/MEmM1VJuCa0l9Qp
         o/lcjmMPouZ8HqTTh7cfDVSwZXn0hYBUBa7Nln9ThLI54zllCE9armDl3n6BQ9Q2xhmr
         DMSN2Z0mLfSqkeyIYamT7k+WhWDi4KwvSPf+CEN3LVyY3MI2/4ui1/Kku+oImpyTCen4
         ijyIQoLsYJmu1oCiOh5Zl6nhShMCeVnxFbidTsSyWVvATQeqne8eQt0UPjA/oR0Cz0xy
         NZfeEVUGoKu8lNfvPzfUKRwoBlOalQItVQsibSwj1CZiGWIyMxT8nZCER4hUGmQvHx32
         Y/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqefIdeVL2wI+DwvB62OMGgdDa6H4u4FEw5VtwaQZaY=;
        b=ZzJYnF5d62AdVZQybZbxyU99N/dySakENUy2ti4hzwzZIwI+4N2Mjds8BdsjHRp3hf
         YmVPTrT2E8hohMfQsWQUOispO0rVG2tSs7OCP8cxoZaMefcqng2HuHfXwqRhqOeyTAan
         KtI4uI84m3Eyl0CSsbuj4kUARq+hlsih4psRlDtqrttqdtEVUS6kofTl0MDX4oFTezOg
         AE9WaEBbdYzWsXwWz7Yj5T0wXrxMX6P8IgnLBGks2hypN4aYRFk8/ER9fw9SDosON54g
         6hldqo4mQtU9dxCEfUvQJ/ldQX4ECLDwGsAFuSIZUTHcVDmim9Bq5iS02Fln2zZ0cjKE
         7Ecw==
X-Gm-Message-State: AOAM533JvavBSJxKY5tVs1ITN7JuG2k81pM8fDHuCeffYcNzkiDsm3cC
        aW0E7HpkYp/aR28vO+gLK/SW0uhqDqubKyXvGf0=
X-Google-Smtp-Source: ABdhPJzEN5d0Bt98thIEc9Uezwh/6R+2lP9mNdmyVMD/wnvEdrfVANxAknyo0cLuI0CB10D33HGHz6jAlL20NuOJ5BA=
X-Received: by 2002:a05:6638:134a:: with SMTP id u10mr282776jad.264.1643936871675;
 Thu, 03 Feb 2022 17:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org>
 <20220203173307.1033257-3-keescook@chromium.org> <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
 <202202031301.437D8FD3@keescook>
In-Reply-To: <202202031301.437D8FD3@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 4 Feb 2022 02:07:40 +0100
Message-ID: <CANiq72nYuWJDESJKOzgtarM5QeGVe3DVik3HZyOEXUdNK8QfeA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 10:04 PM Kees Cook <keescook@chromium.org> wrote:
>
> That might be an issue, but the *real* issue is the implicit mutation of
> the function into an inline with _additional_ arguments. i.e.
>
> char *strcpy(char * POS p, const char * POS q)
>
> is really
>
> char *strcpy(char * const p, const char * const q, size_t __size_of_p, size_t __size_of_q)

Shouldn't that be

  char *strcpy(char * const p, size_t __size_of_p, const char * const
q, size_t __size_of_q)

? i.e. the docs point at this but say:

  "...and implicitly pass the result of this call in as an invisible
argument of type `size_t` directly after the parameter annotated with
`pass_object_size`."

Cheers,
Miguel
