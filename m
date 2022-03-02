Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B654CA041
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiCBJFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiCBJFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:05:35 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4135BA774
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:04:52 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d07ae0b1c4so9212767b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajh49HUN2jOeJwe8QVjB+EI+fly4//JbkBLG+IQiIPU=;
        b=puSAp0DDhyTfJTMteggoCfmaroqG9Bd83woqT1+ecwVnSMOz4NOAI1hVlrA7EJ0uu6
         rd0AZgCJDKrlhh4kb7QAV8uMet94acVR5/2WM4Atp3deKT1wY7j+ELAfHGaNXd4mMDJK
         BajEn+yE8vV1d9t4RFsPrgNkOOARDMlQugQh8J5J6EHpGtrorGA168s40KWDERwNgChA
         9UEUUK+b8skWpe8reAeGLpXgj/lGjLreCMfXVc3KBXCp9WzMNe1DBKJqIWTbiDXKvZle
         +NYb6VQvNzFCmSrfZ6FGtOkfyshQzET/w8Efzz7pT0D2dMiePR+MLH2F5caOgC98Sqvy
         LVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajh49HUN2jOeJwe8QVjB+EI+fly4//JbkBLG+IQiIPU=;
        b=Ndv7bhM+gL5Fhpd2eRc6SGPI7uu2SyBtUbegbS5J4vJdLm3GGPjZWb+n9fVWPUZUIx
         wn9wxhosqwmL5drGrYPwCtKm56uSS0ZsjreQoMqyU59+LOoSmrpWqC5AlhpRFdzgndRE
         yRX2AFddWr8KM73WM7Y24w1JOKnXraagupNJ1kfXAaGJ9u/qh0UkoFRvFLKnvwVoqmiJ
         XWq+6CKRQxtTDeS3xcT+HZo3t6h6JUGNmJG49Idqzm34uxUIVgAI/Uh/hrR70sgicPgx
         vuOWZri2/T6qDD9U+d9MemQfIrFBO4g3lV9V8BYtXL5mYILMb1mEvNP4S7N6I2ldLZDI
         921Q==
X-Gm-Message-State: AOAM530PQiYnKAVspTuAaeZfSzJuO8O7WlVq7rKTGABf8KP0pORtpUg1
        nOuiArPh1tpOdtKfOUJt1nybef0Y0RBjI51GTy3/rQ==
X-Google-Smtp-Source: ABdhPJyLEQmmTXDYryjyOY0Ssw7a98ehyZfqW2jGmK1L9EcEwHV/nS/34D2WNfpfOR/mnkdrdf8y11TfNduPX6lMEXE=
X-Received: by 2002:a0d:c3c1:0:b0:2db:e196:74c with SMTP id
 f184-20020a0dc3c1000000b002dbe196074cmr6592558ywd.35.1646211892096; Wed, 02
 Mar 2022 01:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20220302082145.12028-1-linmiaohe@huawei.com>
In-Reply-To: <20220302082145.12028-1-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 2 Mar 2022 17:04:15 +0800
Message-ID: <CAMZfGtXPS1SOKC2AnNEmcVqtsVgX6Vmm++FfjcFrZyLAAJ369g@mail.gmail.com>
Subject: Re: [PATCH] mm/huge_memory: make is_transparent_hugepage() static
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, william.kucharski@oracle.com,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 4:22 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> It's only used inside the huge_memory.c now. Don't export it and make
> it static. We can thus reduce the size of huge_memory.o a bit.
>
> Without this patch:
>    text    data     bss     dec     hex filename
>   32319    2965       4   35288    89d8 mm/huge_memory.o
>
> With this patch:
>    text    data     bss     dec     hex filename
>   32042    2957       4   35003    88bb mm/huge_memory.o
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
