Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A074D4A8D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354033AbiBCU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiBCU03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:26:29 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02FBC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:26:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a28so8385620lfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 12:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oi0WT6RtKYSCLVVcErN1iJ2hhuFG+VqgwHQjpgyVFs=;
        b=Mm52phJLNfjcK4ovXq4DsaG3QHiwJomSpW1FBRJS7+EIygSIgR+8+Qt2oh1fIrTcgo
         O9iHBnuNuft30SObwRl7eNJqy6H2fnWlwqO3XdreGjOYOA+YgbOEVnI8OCh2ZN4BlFo4
         mk2AlVTaTVCeIG8ityYF9mthVuflkz6V+ZKCwGFo95FG1yo+Y7pOueVTW+OmEtiQrmth
         zHOob3/aUidTR+XrYAtwwEURcBuTFGTEX3F9sTN3rL+g+cT0rWp1aBLBh8eUfxvReqz6
         Kq23PWEjmuaRyQuz7VLcQCjvtegaTyjP+Irm6fF8CvBl/2S6I5nGVikD0lHaICoiXdKK
         DUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oi0WT6RtKYSCLVVcErN1iJ2hhuFG+VqgwHQjpgyVFs=;
        b=7cZn7SxGhV4/2Xq3VBoFQxcUb9By/RNUrWSlLAnjrwSf+PjvGjGGqI51vFkk440Hrm
         /7wYEDgbhKJcYZkfHniSfijzusoeGc4MqPDt2sL28ePS39wSM62OU4hhzCvrHZlvzLo7
         BxZof/X5BfvSYJt3b+S/4kY0TWXIobwTGS9PfhEYg4Y3/qh8ovx6tcvvHCZo+JzFVnKK
         N0TURt0qJ7yzcOFq3D4D59/gLFcs8I6jVO4pZvUd7InKlbybzbgtjz1MOcQEzdPkbXxF
         aKRKtfdK4e2GrtCh4BaWxK9slOoKvTVbDBhkwN9Ra8sxnlsB1AkGFVMyeVma7dtsnho6
         KBXQ==
X-Gm-Message-State: AOAM533lDc7Clw9zslmQdqgy4b7XjTwVPgO6FV0i93IuBT+u0EKw1pHm
        veAZQO0sSW+rKSEVnTCLg0e83fgD1k+DUEomMfZaHxJ8BzE=
X-Google-Smtp-Source: ABdhPJwGX975SvZnco4SUKPWlUpkyOX2+VfEHMxaO8GXGqai82myWhS4bR9uSWdSt+Ib4rMIxpNgB7rcdFzNsoAXY3g=
X-Received: by 2002:a19:6449:: with SMTP id b9mr28110189lfj.82.1643919986917;
 Thu, 03 Feb 2022 12:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org> <20220203173307.1033257-3-keescook@chromium.org>
In-Reply-To: <20220203173307.1033257-3-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 12:26:15 -0800
Message-ID: <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> In order for FORTIFY_SOURCE to use __pass_object_size on an "inline
> extern" function, as all the fortified string functions are, the functions

s/inline extern/extern inline/

Yes, they're the same thing, but it sounds backwards when I read it.

> must be marked as being overloadable (i.e. different prototypes).
> This allows the __pass_object_size versions to take precedence.

Is this because of the `const` additions to the function signatures?

-- 
Thanks,
~Nick Desaulniers
