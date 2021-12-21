Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737EE47BF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhLULuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhLULuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:50:55 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:50:54 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id m186so12238181qkb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKZ8wh0vEyxLoOe3LBJ6ThWF5mIZ4gbWo8APS57Mm8M=;
        b=Jd1uTy1JRrmHdPcFFIsZq749jq/CtC/Rp4s0R1mc5ZO/q3oK4ZEYpD5543YGLMFgO8
         JbKMH7ryERfcsfhZvcvDsrOtd/Jq6vnn3A0NNC7qy0QvSeg9vuDTehD9BL88fp5HvQ5f
         pJ78E7VasK/iOOhDzTXw1qW/l68akb68II4jhtRd/8bcoo9l2qzEcMosFk0MXaa+yrxJ
         D2+6G8eHTge171lcQJzriqC0KHMgulniroOjJTafJLfH6u5VMS8UOKODY6bl1GiL9SNO
         DL2pxW/IIjueDmEOpHXC3q/0242Y3J6zqEo9XdS67SOG60wmNBm8K0P5W++1DeXB5FQ7
         W4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKZ8wh0vEyxLoOe3LBJ6ThWF5mIZ4gbWo8APS57Mm8M=;
        b=oxhDckylmG8AdVUtuikXzhXbh1+pP3y1wyngMgrOmmEAxHIfIul8FVXi6Uyl+BAiSu
         l8hFfC5n8EuzOUR+RUfiadTZkDfl+Jgh1AEWaNq7z79wAD9u7Wiwl4GcxYv6+9sbcya7
         Iew+Fx3m1A5u/88kfedfylis4r2tiP/XWtpJo8UlmPrfjEqSKVI2ReNQu5HepA8gcpwS
         zFZwqgRb7bFGTlriQYT1RW2F5KXf78h74zlE6Gp7EiBap1aoZlbFWQ3cqxnYerqCWK9E
         nLB+aTg1x023doNaFLfhm5e5G4eU19EXk4V6rMF57+uVEA8LWLZUXQqKMsw9Cs/5HZSm
         yLiQ==
X-Gm-Message-State: AOAM532fDPer9MlmwepH/H17Ekw5DeQAewGkUV7Kl/HsHVmPYXuYmAt0
        lhn4gG4taUQh8LmZ/6bfJTSVfcuYJ8iIoZF8gOPElg==
X-Google-Smtp-Source: ABdhPJy4MUzwx2jiDyi7gJ4y7Eu2oiaPZ1Lus01kUEzpRBeRMB8BMvku025lqY/xLE25HL5MSSrenP9TYC9xIf8wZNM=
X-Received: by 2002:a05:620a:2955:: with SMTP id n21mr1581145qkp.581.1640087453160;
 Tue, 21 Dec 2021 03:50:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <516dc726dc6311d8bb9f1a90258190f628a3b636.1640036051.git.andreyknvl@google.com>
In-Reply-To: <516dc726dc6311d8bb9f1a90258190f628a3b636.1640036051.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 21 Dec 2021 12:50:17 +0100
Message-ID: <CAG_fn=UJErkCbrF5f6RW8RbvKLV3k6Gxb-ZrjPMMbS5MvNtN0Q@mail.gmail.com>
Subject: Re: [PATCH mm v4 26/39] kasan, vmalloc: unpoison VM_ALLOC pages after mapping
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:02 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Make KASAN unpoison vmalloc mappings after they have been mapped in
> when it's possible: for vmalloc() (indentified via VM_ALLOC) and
> vm_map_ram().
>
> The reasons for this are:
>
> - For vmalloc() and vm_map_ram(): pages don't get unpoisoned in case
>   mapping them fails.
> - For vmalloc(): HW_TAGS KASAN needs pages to be mapped to set tags via
>   kasan_unpoison_vmalloc().
>
> As a part of these changes, the return value of __vmalloc_node_range()
> is changed to area->addr. This is a non-functional change, as
> __vmalloc_area_node() returns area->addr anyway.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
