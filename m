Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA23D5672E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiGEPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGEPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:42:59 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78541A060
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:42:58 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id b85so9264881yba.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kUzw94hBwwicZTDoD8iw9qTQlYL+xAA3YQavMnnyh1w=;
        b=AdcOA4QW2Wt+aFRE/Osn5xOa+MNHAKfkNyzyPxkICiLjpU9bC1Ch5pGQcjRiFcmSwf
         cXPsCL/4kYVrt6xMAWwlTuRE2425XdvSJBS+NDRf5TVTK9IMWOwKMaYvLFU6zI5LrN78
         /Bz/XqsCDZSa5klnv3S1fsMIuLQ09cWtt8G125L/vkRD49CytleRK1kfzEkpLQoJEpum
         GaUsVbq4DAEFC/LiygZQUgqxK4+CXib0RNbrelev3p6lfgfEsRUn5ndALcU0RbroKb7H
         TFpA1AFf96ihtdPKx7kl0iTfBCZMSG0YTMHtoU3bhh0XZzWz2HVYWFg4Vu8z1eHdMLf9
         yXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kUzw94hBwwicZTDoD8iw9qTQlYL+xAA3YQavMnnyh1w=;
        b=gzOuRTq5wXNF0DcOPDFlhPiwh6jNKG7/iRo5of3qKNXbiYBrjUvPLkG0zh9XAyljQz
         Wi3rSqfrjnfJmwvkC4GcU8JmiYU0gt923GwlGzA2kBaE1xCcfJ2HdSobQGQS4aPOb8us
         /y8XzKkTyt9EbbcMqW8kRGSOILSPfcQGJo0aZG1K5FxZ7XB/0RKjaTSdsmybf9IaLpZc
         58aG7Y2e2V91ov8FfABAL77bNiLXGDT0UXR9Ju0hCauyFLyn7xHXdzQqqmWT7jYxWwbA
         h+TZaDW9bgiwJmVD8SK+W/JsiLO5koDpgL7XxxI62k+Lu9CxXxeTnqolyxIk0BkvDF7G
         +yjA==
X-Gm-Message-State: AJIora+YnH+vKg9bnjmHnpnTQpNZCyMdOx76UadUh3RDpfCxxtoSy+/3
        w4JeTD9xdiNtmAWluHZehMOUXtnzQTvLJbo2C459Jw==
X-Google-Smtp-Source: AGRyM1udkVPlO63GfC4BLkNT9+dM2vQq6XSD4NXMR7yGY2lS9BL5p9z+pJY4uHpYS5xTpp/Nst2jDjRknGYXzO6pxHw=
X-Received: by 2002:a25:a345:0:b0:66c:c670:6d13 with SMTP id
 d63-20020a25a345000000b0066cc6706d13mr39257526ybi.307.1657035777884; Tue, 05
 Jul 2022 08:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com> <20220622162230.83474-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220622162230.83474-4-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 5 Jul 2022 17:42:21 +0200
Message-ID: <CAG_fn=WgyitSd9h2ni2xpBBvgnoGTcwZOpWyNE5QRSRn+PcC=A@mail.gmail.com>
Subject: Re: [PATCHv4 3/8] mm: Pass down mm_struct to untagged_addr()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Kirill,


> diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> index feeb935a2299..abc096a68f05 100644
> --- a/lib/strnlen_user.c
> +++ b/lib/strnlen_user.c
> @@ -97,7 +97,7 @@ long strnlen_user(const char __user *str, long count)
>                 return 0;
>
>         max_addr =3D TASK_SIZE_MAX;
> -       src_addr =3D (unsigned long)untagged_addr(str);
> +       src_addr =3D (unsigned long)untagged_addr(current->mm, str);

In a downstream kernel with LAM disabled I'm seeing current->mm being
NULL at this point, because strnlen_user() is being called by
kdevtmpfs.
IIUC current->mm is only guaranteed to be non-NULL in the userspace
process context, whereas untagged_addr() may get called in random
places.

Am I missing something?



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
