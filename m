Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC954DE106
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbiCRS07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiCRS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:26:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A2EDF23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:25:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id z16so10192013pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wq1GZ9FmJNaOPsHCf7hIAuuWdRpL9RI2sxkF+hIIcow=;
        b=L6TJQ4ALkQFTio02kfOl/LvKH8xLaqIUeb5E7TuK0gBuAaxiI14x3yadHrpHm30Nf7
         Sd+wu1HgsWmgESGl6zn6CseGywI9L5PvMdlkCn/w/VAZqL9gXFpnGAhmjt6YswLqk2iF
         kBTCYVHwX2ogRTPke3lRoXhCAlqVbULdL0uNPxwj06gcpqxpxAE+ee84OVp3TWU3ej22
         jIaBPC1sZjYRoSLAVd+8JMKeN1FcPYF0MNVdc+3FNF8tvcvkn/FG8S2dJPsIy7rkBHQ+
         YWi3SYTsu4wZyPCAsFmyRgtr2XpjNG0oVtEvwF5JeCobnl6RA25lGolPMhzeMfaC9Iyg
         1NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wq1GZ9FmJNaOPsHCf7hIAuuWdRpL9RI2sxkF+hIIcow=;
        b=QcKj2RcTgia6SmCok29kdXEnS09Pkc5X0pd1rpxtKNn6Gpz20V7w6ylnv0XvxDlEUO
         9qu6cfxo3Awgjj+L+lNdIdRATv3TJWJ7lsHQVoVKok0EWeKvfEKgFQY59VVSTOwSg7p3
         3sS1r8v0BxyfEyuACFWyVwWHeQ++rR9NvEPmTNyIxh+4wbRqLO53PntHhWtEPmbYg/zU
         BkL1GMsRy4E5NEhICr/uQqeTTc5zH7/G74e0JFhtDpcn9xnb2P0Q2pZedXuTIKj5s1+g
         lKmhslI+dlp9TrAty9sBKYQZ3oPPcyfktf4ntkCfGEFbfbPAVxEl+xZsyxsw4a9p0uj0
         CMTA==
X-Gm-Message-State: AOAM532zAcSQgwZc2nA68D+SjYn0R5BMGRDJrhCdLfDs5n30Q5g/lSBz
        mx9NUQYTSQ4tQVl/n/VYiq9ySk44BUDQ3kWM80m4
X-Google-Smtp-Source: ABdhPJwG95UQYNFuKuFWCvotjqKdxzonqApUV1Y52hrewvuFjuIzo30iBq30MbUPl6pncjAPxlbjjuM5VtbhSokgbnU=
X-Received: by 2002:a63:17:0:b0:37f:f283:24b with SMTP id 23-20020a630017000000b0037ff283024bmr8823934pga.407.1647627936741;
 Fri, 18 Mar 2022 11:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
 <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com>
 <YjSROmYwwGhpsXMl@smile.fi.intel.com> <CAKwvOdkEjrPUL4HuO3UKaUZAzVw=XV1bEOSj6HR5R1WTUSSZ4w@mail.gmail.com>
In-Reply-To: <CAKwvOdkEjrPUL4HuO3UKaUZAzVw=XV1bEOSj6HR5R1WTUSSZ4w@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 18 Mar 2022 11:25:25 -0700
Message-ID: <CAGG=3QVCkF7RdbQ85MtKgUjm8qP79BESAUiGU3wSQc0+ExO0gA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:01 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Mar 18, 2022 at 7:04 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Mar 17, 2022 at 11:11:21AM -0700, Nick Desaulniers wrote:
> > > Our goal is to enable -Wformat for CC=clang.  Please see also:
> > > commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> > > unnecessary %h[xudi] and %hh[xudi]")
> >
> > Not that I agree on that commit for %h[h]x
> >
> >         signed char ch = -1;
> >         printf("%x\n", ch);
> >         printf("%hhx\n", ch);
>
> Will print:
> ffffffff
> ff
>
I noticed this. My first thought was to do something akin to:

  printf("%x\n", (u8)ch);

but went the route of removing the "h" qualifiers to be more in line
with previous fixes. I will be happy to change this patch if that's
what you would prefer.

-bw
