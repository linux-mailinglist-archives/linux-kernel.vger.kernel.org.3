Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045EB513A44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350326AbiD1Qsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350307AbiD1Qs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:48:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C61F620
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:45:13 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7c57ee6feso59554687b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fknn/A/aplgNNNjRdKgmyiKBYINuUEGbLWPpyif/20A=;
        b=YO0d6jn5JI0W4xsSc8R1h/QVhlsSt/vXkx3iVg0uuWwmX20u45FXXDzERAG7QLf1Aa
         snhbD5GzCEhp8b6azJRRaQmdO67ExxDaAW27X16YqAYFnvsvYk77FzRfGGIvwOb+3m7r
         RSaLU7zu5JDLsj+n+seTPDfTd808rKCaVootnkDFNFj0aRy9KKMdLQi0O3Coq/FIyXIH
         OaEWPH7isC5+jmTM2+wz1u+w6tQeoy/NoVS4ectyJSI/9Pv4v7khyLMN9Wf+cnOQ/Bov
         cy0UZvGxeeyTA9Ff+jgaYmKYk1DlrGo4UfS+6d3SpZRY7IL720YKQh7f/6ixRVTWcFnJ
         Aogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fknn/A/aplgNNNjRdKgmyiKBYINuUEGbLWPpyif/20A=;
        b=6NjJ80MKgtv9j6ooigfdoTkX8jWONBmbPdVDcjexzih29si1CBzBf+14wE0t/5/xfx
         7Fs9+ggc1LD//EOm0nhn9HtEnRxerFUt8fF+VUJ9KsZ9tjyuEWC8WFut4wZuYGZMZr07
         RimyO7KLbFw6421uwvh69AWOGnKbEx21n2DANwmNlYMGuDnzqh0EBgRTIPx9mZ2j11d1
         B4FgbTKRXUXHaEBzbmMgyCnT5zkWDZaxzhVrO7F1Y/Wbe7EnKPuIRuGONp66cyLkEsMc
         bsPF5t4HTqYb9Dh905SJSZB/43JOlE0r0SDhaBMRtjbNrlnEAo6EJZW8tbuQKbfMI7Zi
         SvIQ==
X-Gm-Message-State: AOAM533iR3yYc2suzPlQc3hn1PQBmttZz7rcGlOdocUoBgCCwVYbB4GK
        UcX1KCwWHuwkXrwLta2OiudKaESF2l1jjVRR5wAr3A==
X-Google-Smtp-Source: ABdhPJwv9QJkwVyiIDw3emBO7qrkmvxIR8bSM0H70yzxZTC6aeFEY6iG/nvH3n6rHMvBWI/i6JhEbNn4x2yDxfRm+qg=
X-Received: by 2002:a0d:d615:0:b0:2f7:cdc9:21c0 with SMTP id
 y21-20020a0dd615000000b002f7cdc921c0mr25441432ywd.486.1651164312085; Thu, 28
 Apr 2022 09:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <3167cbec7a82704c1ed2c6bfe85b77534a836fdc.1651162840.git.andreyknvl@google.com>
 <c4105419650a2a8d9f153f55b5e76f4daa428297.1651162840.git.andreyknvl@google.com>
In-Reply-To: <c4105419650a2a8d9f153f55b5e76f4daa428297.1651162840.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 28 Apr 2022 18:44:36 +0200
Message-ID: <CAG_fn=Vy+GuQ0YCCvU1i2fwO35ZWbE3MqK9if6+iX4q5_3mTRA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kasan: give better names to shadow values
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 6:22 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Rename KASAN_KMALLOC_* shadow values to KASAN_SLAB_*, as they are used
> for all slab allocations, not only for kmalloc.
>
> Also rename KASAN_FREE_PAGE to KASAN_PAGE_FREE to be consistent with
> KASAN_PAGE_REDZONE and KASAN_SLAB_FREE.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
