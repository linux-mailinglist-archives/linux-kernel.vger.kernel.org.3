Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65BE56257C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiF3VnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiF3VnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:43:08 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0160AB3E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:43:07 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31780ad7535so6238957b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMHt42bJ1YlW7qsjn88JwOKrZtD6Yx+xury8B4lI9tk=;
        b=QZX9HPFJkD9+fzjjZWsSCiOlE2J/2LsSXswBgBMfa0v9fHzcoWvnjb3VEHfacRDxYt
         p83HHAoDzMPStKdrx0jpo73c8H8L9bqEGASwti9PF8dOP3fCoFE5oH/ju2WQmAQFEEIu
         2Xz2bGf3ke5KIZ7wLDOHukz6+UP1FeL/mHrTRw4YBe0bei7LrMaWHv9MK4+4nSVTMqqG
         ymgvGNvQO0Nd0WelNyhtBiIiaOFrQcB9iNsxPXb3n1Ms9Cifpj/jY5RcFc0VRFuYaxzm
         5n57zZG1SqXMuAv13Cm4jvQDrnSDsKNEgKpD6Nce8ZdKUymPJnZdqir5kYHPe0ea6UPb
         aTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMHt42bJ1YlW7qsjn88JwOKrZtD6Yx+xury8B4lI9tk=;
        b=mzOD/MHWbDe94L0KnIbUB4RSOXttoAOmXnhZI8LKicT2eyoZFQohrWzUSVKq3bjNlj
         RMDA+jbN8ZOBA1m7inKbuc2V0dvaqD3cKJbB+xdu7FBkeHUul/ltHRmiu3EmRHIO+nzh
         8mFZazWgf9hRBBdooGQGuzwLzPiudfjTZrWRtQytgP985Bze2UViEEd/7Qm5TCJHmQg2
         ek7CrgWmHFLeE+naV/Ff3CBwm7MBel9kj7HaLxSproIg+R0N6Hhn7G+/NpH6ONzfG1Zo
         3jc4mzqn0ICdck3cqKygXHh3QWKAGT/ZhxVUn4fZVBRMRzC3a2EHMuBqYrJlhPLtVcad
         eReQ==
X-Gm-Message-State: AJIora9lTLG67uXfBtlHCYC/xtW+1a0OCXP+0sNeLus6BFAB8j352wz2
        Uv3QGNpb1Gt+neZbOwlT4Qgo3g+9aOtpJ5V89NM=
X-Google-Smtp-Source: AGRyM1t2UrK1hzV79ai9XXNCfm4iNtTsbANUmoYqfQmUHleEfY0pxh0cpqQXRU3xd7K+u5jePVWW1lw/QC+ZRlYpm3Q=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr12916894ywj.195.1656625386155; Thu, 30
 Jun 2022 14:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220629235326.480858-1-justinstitt@google.com> <20220630195738.904505-1-justinstitt@google.com>
In-Reply-To: <20220630195738.904505-1-justinstitt@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 23:42:28 +0200
Message-ID: <CAHp75VfYPfvcySRJboSO8YsXTfO61j7QM=mYrDDPJquRAwzw0A@mail.gmail.com>
Subject: Re: [PATCH v2] lib/test_printf.c: fix clang -Wformat warnings
To:     Justin Stitt <justinstitt@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 9:59 PM Justin Stitt <justinstitt@google.com> wrote:
>
> changes from v1:
> * moved NOWARN macro definition to a more appropriate location
> * using __diag_ignore_all (thanks Nathan)
> * using local scoping for code blocks instead of __VA_ARGS__ (thanks Nick)
> * indented affected test cases (thanks Andy)
>
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Somehow you replaced the commit message with a changelog. On top of
that, I didn't suggest anything important here, so to me it is
considered as a credit in the changelog (see previous sentence as
well).

-- 
With Best Regards,
Andy Shevchenko
