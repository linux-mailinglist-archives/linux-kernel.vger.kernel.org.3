Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559305AD418
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiIENiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiIENir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:38:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B5E4DF19
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:38:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t5so11365247edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=G6oEhCANh1uMv1tR8inO3nd+yCiqobEBbYQgVB5GUY8=;
        b=tKwz8DerSMphL6l/RVBW5o0aIz2qW1vYWnnV14XirB6PeN/hgu/bsJ86XZHdEFvsAS
         SYB35TC87iM4fj+CfEX2d75YGpeZR0YhjKcz4rxZDYABI3hAjCD1jqp9E4cP8BKyVKd0
         z5rE8PB3RDx+S7gVhbrGHVh3788fFeJUcpTIYpW883MBcwJ7Ksjj+H7/16sK1Vn370WL
         gHU+AjsCztANPCeFVDwlwtsQr9EUdahJOR+3Yy3jupxfeaW5m8V1/ejfs1ddxOClyVes
         Lw5WqUM/RBGepmh9zPAObBTnBTFQq9unxRCrMGFKxUP+kWraKvutYYhXU0q8tTjnz/iB
         ZbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=G6oEhCANh1uMv1tR8inO3nd+yCiqobEBbYQgVB5GUY8=;
        b=q6sNxv66ZS2nsmYSwVlq9f7n1ALW00XcK7H4u72ouI9GjazVUruGY0/xtX+Ry3Y+wd
         YHuU/ILfmSziRl8T3p0qEcD0YFF/X3wQe5MmDVKrAiYQhWWwbi19Hj0u+6SCI2GJZhV+
         rBNKibsVCIP5SETXp4wfPquvn1BYQrV4TnySPNo4pLHOazYw3EG1ih/dXnp/KkAQzsve
         z1Duy/XsQpBTM8sHRxOhfV1tldw+y0qDeLVOdD6h5D6f0T+c0ZkZrPY4q/r6S5fmSs6l
         V8068AaQZrRgqTAnCr621CLLg/4igpmbV9SgVcWwhKHR4sZkxyRj4B6EobgzDAEDAwAm
         oj+w==
X-Gm-Message-State: ACgBeo30ZnGTk3A8wqARYfAAqBrMz36z/b6XB0LGM6GvLYkrVVUYw9Lb
        xXGUAuLO9bSkuzxZgFDEETomtA6ohYXLbMwj6VSKLw==
X-Google-Smtp-Source: AA6agR75cdNdsNymOR00BfzvxWgG66LqBx7L4BcmcLY6lBcsA9C8p60P561uU/gY4NsOlXwOjjG7SSfvIxO91Z4mQXU=
X-Received: by 2002:a05:6402:51d1:b0:448:bed1:269c with SMTP id
 r17-20020a05640251d100b00448bed1269cmr26103860edd.205.1662385117911; Mon, 05
 Sep 2022 06:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220905122754.32590-1-alexander.sverdlin@nokia.com>
In-Reply-To: <20220905122754.32590-1-alexander.sverdlin@nokia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Sep 2022 15:38:25 +0200
Message-ID: <CACRpkdbdKAWfvpG2n-eJPagV3Sx1faaxC9cEFs3PTyDaxETwyQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kasan: Only map modules if CONFIG_KASAN_VMALLOC=n
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     kasan-dev@googlegroups.com,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 2:28 PM Alexander A Sverdlin
<alexander.sverdlin@nokia.com> wrote:

> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
> In case CONFIG_KASAN_VMALLOC=y kasan_populate_vmalloc() allocates the
> shadow pages dynamically. But even worse is that kasan_release_vmalloc()
> releases them, which is not compatible with create_mapping() of
> MODULES_VADDR..MODULES_END range:
>
> BUG: Bad page state in process kworker/9:1  pfn:2068b
> page:e5e06160 refcount:0 mapcount:0 mapping:00000000 index:0x0
> flags: 0x1000(reserved)
> raw: 00001000 e5e06164 e5e06164 00000000 00000000 00000000 ffffffff 00000000
> page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> bad because of flags: 0x1000(reserved)
> Modules linked in: ip_tables
> CPU: 9 PID: 154 Comm: kworker/9:1 Not tainted 5.4.188-... #1
> Hardware name: LSI Axxia AXM55XX
> Workqueue: events do_free_init
> unwind_backtrace
> show_stack
> dump_stack
> bad_page
> free_pcp_prepare
> free_unref_page
> kasan_depopulate_vmalloc_pte
> __apply_to_page_range
> apply_to_existing_page_range
> kasan_release_vmalloc
> __purge_vmap_area_lazy
> _vm_unmap_aliases.part.0
> __vunmap
> do_free_init
> process_one_work
> worker_thread
> kthread
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Thanks Alexander, will you submit this to Russell's patch tracker please?

Yours,
Linus Walleij
