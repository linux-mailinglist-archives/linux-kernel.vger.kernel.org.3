Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E144BDFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbiBUJI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:08:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347405AbiBUJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:01:21 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA48D27FFA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:56:26 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id y6so32810269ybc.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OndnQyyeZ+3miOBGH8r6YA5jEmN8diDxn0ywrPw5RbI=;
        b=r6XMOfHzsmunjQCdPWXKqKJJSdVe93vRBmWw6iI1QxXHltVnhZpxKeWCtl7rSxd0Bn
         mFUYcsOQqjEaS/Bv6wJk/92zkAidghrW340oHGbb5ManDIB2en1xC4wgOelHIAlcYyHa
         dfFj5hJlT1gEYCm0PxhPN04HwwkZP87C7+Agp3qZgexrPgMKo0FIFqFJ+QdRWGHwKIVB
         ouXuzHFimH7skVcB7Stkb5IwMYuNu0/mElIuXEnTy2Q6UGiZrTAluuWZ/bHs75x6gcAG
         j1wkxtI807p6h8tYlOxGFzMMnjg2eRNb1RhegCUnklr/K2Myfn2kOH4iQ6nTGrWyZkIG
         VDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OndnQyyeZ+3miOBGH8r6YA5jEmN8diDxn0ywrPw5RbI=;
        b=tJ4OMyMXzpf7PoTaYPRNh5wMu17O2JwfNi0yRWxwbvX1DcrGFcLnk0vEE5/bYYVTfj
         GVLMYJWs7DCttqWkGzIRdxDL7j9Gyib9x6NXg1UTUWNi+5WAd09RHVxMwel2wzSVxUAg
         wklbZFh4jgmZ/d3I9TMI36L17cJSb3YNllpXFY1kcferhGHMLNjKQ7Agub7LO/xdm7Yy
         +wQveetv/6b+fiizj6F/+r9Ef1Mo59etefvTrlKPUXm0pP4Etz5uXejYRxVBCe6CcK6f
         0RB3Xj9ew90SmCbRyizd9tkwPx/wj3wGy6VTvUecrrL71HCc/LKJrqf8WsLxgay6L7Xv
         uSkw==
X-Gm-Message-State: AOAM532cdk7sv5kavEJp668I5PkHn5BJ2Yex0bZRi7sOymII+ZQsZy+8
        4EMxngqtlOAdDAN+g4TwCF479/G7VxWwPDJ72iv4EQ==
X-Google-Smtp-Source: ABdhPJxB+3u+xxR3NhROqHvmP4nDRvqNXs+Id/6TJtmzlWKjUapRxI31nEF87zsJAwMIUO24apW79b/nJxngD/X62RQ=
X-Received: by 2002:a25:3542:0:b0:622:caf1:2c88 with SMTP id
 c63-20020a253542000000b00622caf12c88mr13329448yba.625.1645433774543; Mon, 21
 Feb 2022 00:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20220221065525.21344-1-tangmeng@uniontech.com>
In-Reply-To: <20220221065525.21344-1-tangmeng@uniontech.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Feb 2022 09:56:03 +0100
Message-ID: <CANpmjNNTsj-+=BBbt2pcbrqwOmiixjc6fE=Q=JoT=2kQfR0y_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: remove unnecessary CONFIG_KFENCE option
To:     tangmeng <tangmeng@uniontech.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 at 07:55, tangmeng <tangmeng@uniontech.com> wrote:
>
> In mm/Makefile has:
> obj-$(CONFIG_KFENCE) += kfence/
>
> So that we don't need 'obj-$(CONFIG_KFENCE) :=' in mm/kfence/Makefile,
> delete it from mm/kfence/Makefile.
>
> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Looks reasonable, thanks.

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kfence/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kfence/Makefile b/mm/kfence/Makefile
> index 6872cd5e5390..0bb95728a784 100644
> --- a/mm/kfence/Makefile
> +++ b/mm/kfence/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -obj-$(CONFIG_KFENCE) := core.o report.o
> +obj-y := core.o report.o
>
>  CFLAGS_kfence_test.o := -g -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  obj-$(CONFIG_KFENCE_KUNIT_TEST) += kfence_test.o
> --
> 2.20.1
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220221065525.21344-1-tangmeng%40uniontech.com.
