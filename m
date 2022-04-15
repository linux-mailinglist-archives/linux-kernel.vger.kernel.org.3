Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692D2502FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351662AbiDOUo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbiDOUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:44:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269761BEA7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:41:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o2so15525791lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4lGURfqIvQpYqIQ3phayQfuPvBgeqLLIXwhfGkxtbeY=;
        b=deaMVP98X0xu0zpekmWFQ4SEf5NynnWkUeMdEjpPmyNhZ9ndZB8LHFKW/U2nYrHprh
         Yc1AFRYayI21kAPEh3NE7bDlwsxKjWmcE9iL82hQDuv8Nx5eKcU6h+f63JWZX7yAPtDx
         dUG+ksKovrp84l0VMSDEi2piAgFVFieYV2zZueTv6gcpP1xCmqwF5LA7rpPjGJx23tc8
         A79rH4zmE9mLl1fLFW3U80Sh7evdEgmoCIIKpx5M7HIYyjLOSRn/ptdW0Do3Im4w2dgR
         Vl0DqYK4J9+1c4qWZYPahEr8wf121vf5lnBOLiEsb6r2nGb1pPus16G8KfYdfuuYFo7H
         A5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4lGURfqIvQpYqIQ3phayQfuPvBgeqLLIXwhfGkxtbeY=;
        b=ukxv1dSd/ulOr/XO072UcE3j5HT1NbHNKqQZznMtNDfIocvPgS6AElkewFQxmFm+3G
         9mndKkMLgKNo/W1EC2WzgfWsaVbh/8zaot4wOX41P93+C+ASAPuWz17VNJMdTQNzwsVT
         SHMkWoU/1+5zDdtRRGV4FLxWoXW8UACoGRrtaCIqxKXF+XMWWK4K5wOk0dQ/NhARFsit
         pyad+CKcryrVCScC1SNpUnmDw8k+pIyaaMYpcGxnH80gmN2pqjHZMicbgHN8BIrgd19B
         Iv0bIfCsEdGj5N5Gjez/pR62umlfwcgABB0exxw3jWE69jlZEaW5zv7BtLviBLOnTm/K
         l9Hg==
X-Gm-Message-State: AOAM533NCuUFhyJqRMoxXUNEfvC06yK1RJZ3/Ec0mLJMtXrcVShso1dQ
        i05WW5Oi31rICKiRX/nVqSpJr1JlBMha9WLflBrXIQ==
X-Google-Smtp-Source: ABdhPJy0LHQeK/E+y25nBBVQ9U39uS42RbDJdT0z+a1SFIjidlJlCMAKcOtOnmVH8L+CX3l3oHFWqvNXSNY3BaZR1bw=
X-Received: by 2002:a19:505d:0:b0:46d:167e:b9df with SMTP id
 z29-20020a19505d000000b0046d167eb9dfmr465149lfj.184.1650055314270; Fri, 15
 Apr 2022 13:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
In-Reply-To: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Apr 2022 13:41:42 -0700
Message-ID: <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
Subject: Re: plumbers session on profiling?
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <morbo@google.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>, vladimir.mezentsev@oracle.com
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>
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

(Re-sending with Vladamir's email addr fixed; sorry for the noise)

On Fri, Apr 15, 2022 at 10:54 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Hi Sami, Bill, Jose, and Vladamir,
> Jose and I are currently in the planning process to put together a
> Kernel+Toolchain microconference track at Linux Plumbers Conference
> this year (Sept 12-14) in Dublin, Ireland.
>
> Would you all be interested in leading a session discussing various
> profiling related topics such as:
> * gprofng
> * PGO
> * AutoFDO
>
> Would others find such a discussion useful?
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
