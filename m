Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8061C54FA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiFQPfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiFQPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:35:43 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467523BC9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:35:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id t1so7866598ybd.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aIKnwKkhzdC958qsh/vVhbGBEqfmlkokiLIf9TRq+B8=;
        b=nQdZTTAQ6ceFqR+sZ6oSkoAhXkBjUpnxm76h7VUqgfr9EK+LTZpkPJ5WXXgpYgNNuD
         kZRh/VcWDLCa29F9i4Y+VNEXUUau4Twkjc8CIo8+7JAuvQlArxy5+vJ1r9+ABefa7EGA
         o7VVphjiFVt9zhEMhhizfN8+OTfOYqQMMZ8ON/HRjwNRDUPW2bjv9wZDVGq+S438svib
         aIiOASrHMUBuTUfG/fHTN9IkCBjOShOn0Iq/YpRZisvKjJl4OpBq1z+dJmBGtAoizioS
         k9XLpwI0BD32Eo8evKItPhvJh58Mpr9OJc1dmL7+CFt9HNh3YFUB9Azewj+pPp5CTS/W
         4XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aIKnwKkhzdC958qsh/vVhbGBEqfmlkokiLIf9TRq+B8=;
        b=MQQIVoLUllys7X3P1IyRD67rpcX2DsjgnqvuTHg6BgB/7CZ9KDhrgxTlhgbzdIR83/
         x6yFly+Z4pwHlAjbVD4S3xhvTzZDH5Xa5VxjfCUubACQilCjUzQb3QTNBYy/2YST1cHf
         ofEIpqr1RdRZeMlCDFEvBWs2VbOZisjrvHFDJ4SqXMQrgcWYO9xyxl25X0LSpSjoKcyz
         7yIJAleJR7TnYlN+gXp33iOwa8Vo4wvXYOp5UnVGvRR5I2n79vIy7TOfsPL/UO5waEER
         PX+bdh0FbDmTbNdqQZpFCztZBhFbEAdZP3tOdcUwDB3jtOOusGwV8Zc2sV55BCnXixH/
         HPOQ==
X-Gm-Message-State: AJIora8b9FuhbUJt26ZpGC0EV4wCw1FP4fWgj9Hnjr/mCTjLt5CV0DuK
        OcsSI3rHig4mGq0rNPF1qUecS4Vhd7fhPE3hqmx0Sw==
X-Google-Smtp-Source: AGRyM1u9XrHBU4jlEh1QMP3HKiifx5SdWYnGCzxMmE2gjby8m7cSgwi4JqVc8Xz9AGlYrNtmsyITEse+cD/zMx7R2Ro=
X-Received: by 2002:a05:6902:1007:b0:665:197a:a3a8 with SMTP id
 w7-20020a056902100700b00665197aa3a8mr11539927ybt.274.1655480141505; Fri, 17
 Jun 2022 08:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com> <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 Jun 2022 17:35:05 +0200
Message-ID: <CAG_fn=U4hETfYrRbZMJ2xEEgP+FzWmYX+u+Kr=x0NkytU6nGfg@mail.gmail.com>
Subject: Re: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
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

On Fri, Jun 10, 2022 at 4:35 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Linear Address Masking mode for userspace pointers encoded in CR3 bits.
> The mode is selected per-thread. Add new thread features indicate that th=
e
> thread has Linear Address Masking enabled.
>
> switch_mm_irqs_off() now respects these flags and constructs CR3
> accordingly.
>
> The active LAM mode gets recorded in the tlb_state.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>


> +#ifdef CONFIG_X86_64
> +static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
> +{
> +       return mm->context.lam_cr3_mask;
> +}

Nit: can we have either "cr3_lam_mask" or "lam_cr3_mask" in both places?



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
