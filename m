Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499FF59934F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbiHSDIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiHSDIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:08:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC493719C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:08:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w19so6528699ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AE/ftuwKTJyqoHkKwv3H2Zvrr3X4oHwXNDtYqedvApI=;
        b=e/Wrh3pjzSXdVCzel9j/4R0SNFqW/Zmyfzu5/oE48EM2fENB0p1G3tiq4Ja99r8B4/
         T3IZUk36zwEc/rDW5B3Umlp3VKD3eGja3D00j9YxcGiMqQtovNCQ1rNEu3pyUJwx7JUN
         rMHVn+LGSpUZdsMaT0wCR+M6NPe/YujzHeIAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AE/ftuwKTJyqoHkKwv3H2Zvrr3X4oHwXNDtYqedvApI=;
        b=vDob59uXq37ZFZ0xc3bkLCZfyQkU6rpng6IOQRw3Fxl4QElFFMlh9DkPyhGs9rQ83F
         xUoBiAeo8t8qYSXjxvUndgfoh7g+SwbG+kcbTjsKGIuIg/z7mkQ7B3x9sq9/FDPPbjdh
         CyXweXXk6zIfkdHYX7/6HdRi07cXPrVzorSGUZHgKiXK9Y+KX/Z+N3LnlXO3kEm7lr5X
         rhAH0mrLtO6YJ3oDbgdciYBlESmppDhdTJ7Veo5oC5TggjVdmCdL2ABRUimqv4dh0JOE
         6IN08kcB0MRbmo/B2+XekoryN8q8DJb7fH/XX/ZlJK5wpctgx8DBvmx8g2mrrNCTlOtT
         2qAw==
X-Gm-Message-State: ACgBeo0V8IH8CkxVg9aFjeARBNJAn+oy0XJxEr7o6OAIbiL4jJshiHEL
        aFVwhJEFp8A7sA9P7xUGye4owMjwZ2CBbP+O
X-Google-Smtp-Source: AA6agR4u7Hi1vQ77ZLVgzFwwQqaljS3ZwbCaGQfr00gIc5BUTyN5xEredp0LmLdfrnmUcsbnDXYvMw==
X-Received: by 2002:a17:907:20d1:b0:731:5169:106b with SMTP id qq17-20020a17090720d100b007315169106bmr3619889ejb.667.1660878507600;
        Thu, 18 Aug 2022 20:08:27 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id ku7-20020a170907788700b0073d15dfdc09sm237856ejc.11.2022.08.18.20.08.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:08:25 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id k9so3731454wri.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:08:24 -0700 (PDT)
X-Received: by 2002:adf:b343:0:b0:225:1a75:2a9a with SMTP id
 k3-20020adfb343000000b002251a752a9amr2873297wrd.281.1660878504523; Thu, 18
 Aug 2022 20:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <Yv71VPSjyy26v/Xu@ziqianlu-desk1> <Yv71qbuHkSsLGhvJ@ziqianlu-desk1>
In-Reply-To: <Yv71qbuHkSsLGhvJ@ziqianlu-desk1>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 18 Aug 2022 20:08:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieSGev8B_Xq3R55gkNLU=cuo+idJtMJYqQ+EAJ4HeJgA@mail.gmail.com>
Message-ID: <CAHk-=wieSGev8B_Xq3R55gkNLU=cuo+idJtMJYqQ+EAJ4HeJgA@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/mm: Use proper mask when setting PUD mapping
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     security@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 7:30 PM Aaron Lu <aaron.lu@intel.com> wrote:
>
> -                       prot = __pgprot(pgprot_val(prot) | __PAGE_KERNEL_LARGE);
> +                       prot = __pgprot_mask(pgprot_val(prot) | __PAGE_KERNEL_LARGE);

The patch looks "ObviouslyCorrect(tm)" to me, but I have to admit that
I absolutely hate how we use the pte helpers for all the levels.

It gets even worse when we do that

                        set_pte_init((pte_t *)pud,
                                     pfn_pte((paddr & PUD_MASK) >> PAGE_SHIFT,
                                             prot),
                                     init);

on the next lines, and I don't understand why this doesn't use
"set_pud_init()" here.

It's probably something obvious, like "using set_pud_init() would mean
that we'd have to cast the *second* argument instead, because we don't
have a pfd_pud() function".

But it all makes me go a bit eww, and also makes me suspect I am
missing something else too, and that my "this looks
ObviouslyCorrect(tm)" is thus worthless.

Also, I don't understand why we use that __PAGE_KERNEL_LARGE at all.
We already have a valid set of protection bits, that had gotten
properly masked previously.

Isn't the only bit we actually want to set "_PAGE_PSE"?

IOW, I get the feeling that that patch should instead just be

-                       prot = __pgprot(pgprot_val(prot) | __PAGE_KERNEL_LARGE);
+                       prot = __pgprot(pgprot_val(prot) | _PAGE_PSE);

and we should never need to mask anything off at all with
__pgprot_mask() - the bug was really that we set way too many bits.

But again, I *also* have the feeling that I'm missing something important.

Ingo, Thomas, any others who know this code better than me by now - comments?

                Linus
