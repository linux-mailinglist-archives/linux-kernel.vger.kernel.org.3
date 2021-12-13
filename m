Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380BA47371B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbhLMV53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243436AbhLMV52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:57:28 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272B2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:57:28 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p23so20633967iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mm2UWj2YnKjrM1uYfSOmZBTk8qAIxqBQ9/EkHyLqgsc=;
        b=WGDhTKgs1M19F5RLh/ghQTTXHLMg4GO+Va/ZCOqp75D4BcTBFmvAyFOp3iR+playrk
         +T9Jlonuihe3sFoIQtfLQBUohu8R6MPWXzNZhaNBqBECrUwV/Na2RkobDZ+yJfyXhZxj
         Zc1w7LmN3RES+diPh9vZmRrhO4M3O2RsLHNQMUlyr7GwrhegxFvYFO0D6HFmPm55kYk+
         wqrpQ6kQbGTmo893E80CH350LCb6CSWf6u+8JN/zg81wfGaanF15fb4ydtKlCBifJ2nN
         8Ump1PCSItp2r2u16Yqh96q6OGH6wrsF5rdnkfLm4GyeC89cjLQuxKAgQABGwCqzZCgh
         Eu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mm2UWj2YnKjrM1uYfSOmZBTk8qAIxqBQ9/EkHyLqgsc=;
        b=0JXB283t4M+ty8hpy4dYi96schI1MwsHr+Bp3z0NgWGuKMJCYIKAvqwRxX612z3IjY
         rKCKb1CMEZqgOYte19GccTEMT8Ma1DmJR2P4m0YeVg3qWTn8IhDY+CSwV5p3R4wZbe0P
         tjbcO1jrHjOZ9b+RONl6Bu7dB1RDnnxm+s0rtLmNpBIL4zp5bo4rnIGQTWRXqqP0JjcL
         1E4CtQkk5T77jt3hT12ScWTVmLr6BgsY/uXSkqiQV2BN5wL10Ixwp+fSlJtCKfUKbQbO
         Zv1C7kyn7/oMBUfFQzhGQlsb15JJF1i+b7Lc/BpmL3lRF/YvfdbTk2SZXrRSIw8Cy8rI
         OMNA==
X-Gm-Message-State: AOAM530obdu+r+1/IkaFVq8i9WnSdRkFkL+vOpgpb1JzIbdwt6VEOYiJ
        Y1RgvkDGrBwXx3gtJmN5MAc4QANvpr+jTMwBs0k=
X-Google-Smtp-Source: ABdhPJwxpZXrkYa1rZLbVNyZvefzi4hFv2hWb7lsOaLvHUX8W4V9XsbfXmUsLiMSfTJBF8neKVDX8kzVqC7kL2jCyRg=
X-Received: by 2002:a02:830e:: with SMTP id v14mr555545jag.644.1639432647604;
 Mon, 13 Dec 2021 13:57:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638825394.git.andreyknvl@google.com> <a1f0413493eb7db125c3f8086f5d8635b627fd2c.1638825394.git.andreyknvl@google.com>
 <d082aa66-8b6b-2a32-bf7e-8256b9ec3cc4@arm.com>
In-Reply-To: <d082aa66-8b6b-2a32-bf7e-8256b9ec3cc4@arm.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 13 Dec 2021 22:57:17 +0100
Message-ID: <CA+fCnZcY+1xqiTMfwn_NwptsZdK_jW3HM71oL6yQ_3+LOK7Hyg@mail.gmail.com>
Subject: Re: [PATCH v2 24/34] kasan, vmalloc, arm64: mark vmalloc mappings as pgprot_tagged
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 4:17 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 12/6/21 9:44 PM, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > HW_TAGS KASAN relies on ARM Memory Tagging Extension (MTE). With MTE,
> > a memory region must be mapped as MT_NORMAL_TAGGED to allow setting
> > memory tags via MTE-specific instructions.
> >
> > This change adds proper protection bits to vmalloc() allocations.
>
> Please avoid "this patch/this change" in patch description and use imperative
> mode as if you are giving a command to the code base ([1] paragraph 2).

Hi Vincenzo,

Done in v3.

> > These allocations are always backed by page_alloc pages, so the tags
> > will actually be getting set on the corresponding physical memory.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> With the change to the commit message:
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks!
