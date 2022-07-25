Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098F65803B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiGYRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiGYRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:55:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32112DCD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:55:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id oy13so22005981ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+z0yI+NAqz0lPQPD4syMpiD1j+8nivCsbBCUwKqe0Ak=;
        b=KRkDc/OFjCjIVxf6SMkfjIbwIzymd1SWb4ElZZsKGbEm4YuraBqK4/cpQJMrJpGSXL
         Q51/VYhxX+SQBqccvrxNiKd1yRZqCEp8/BFdJ9o3xwfW2QMtB/QNrLLlDuSt+QT4V41v
         Mi0O/AqQjhMdc2W8TG4laeAgLgDfveK/X083w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+z0yI+NAqz0lPQPD4syMpiD1j+8nivCsbBCUwKqe0Ak=;
        b=DmiGwBE+xeg4dO7IA9BOoJnbU4yZ0FuyV/PxCQUkkEDcYXGzYI4kZ4zyI12P8JZT/j
         JOZ6Olzyzp4LFgEF3lD9nrREadqpCWDDo8jAqGU4V/Wo9Z58b/+UWjhRwEtfy4uV7k/M
         lF4Yq8tqoy/QlPVcowwBFITH477pPFf+4PnSNtvcU5zCm58q6eKP+cun5whGtwMFwUoI
         eSPk/PuVGmgCviGrT7i4hbmchb/8FKw/+6AG+QYbY7Q4Sx0QIsgdeaSsd5/MKP/E3sZ6
         KkfC0xVsp3QQic1imvQJGeVEm5Jdg7fomLKc3Te3LjjQqIGrkRql2S5CO5Q24e5zeaMQ
         EdNg==
X-Gm-Message-State: AJIora9KohmMoEFo3U7gmu/abLCYEJYVCvwsMb/ofOoAORYh3uix0LSv
        N3Y5EMQ1wxuVPAVvgv8sFl/yefX4HIFLPv5A
X-Google-Smtp-Source: AGRyM1uatBAWfrYv67EWLuH6lGTAW6bSojm4q26JdPzZO0hWA3PJYS32M3rZxF69XdUGu6fuuPOyrA==
X-Received: by 2002:a17:906:ff48:b0:72f:10c:bb3f with SMTP id zo8-20020a170906ff4800b0072f010cbb3fmr11086487ejb.718.1658771736067;
        Mon, 25 Jul 2022 10:55:36 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id i8-20020a056402054800b0043bb71edd36sm7508214edx.44.2022.07.25.10.55.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 10:55:35 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id m17so16792498wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:55:35 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr8525307wry.97.1658771734719; Mon, 25 Jul
 2022 10:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
In-Reply-To: <20220725161141.GA1306881@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jul 2022 10:55:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
Message-ID: <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
Subject: Re: Linux 5.19-rc8
To:     Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 9:11 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> BUG: KFENCE: out-of-bounds read in _find_next_bit_le+0x10/0x48

Ok, I was hoping somebody more ARMy would look at this, particularly
since there is no call trace beyond the actual fault.

So it shows that it happens in _find_next_bit_le(), but not who called it.

It does show "who allocated the page", and I can see the message that
is printed afterwards, so it comes from that

   static void __init test_bitmap_printlist(void)

function, so I guess we know the call chain:

  test_bitmap_printlist ->
    bitmap_print_to_pagebuf ->
      scnprintf "%*pbl\n" ->
        pointer ->
          bitmap_list_string ->
            for_each_set_bitrange

and I think I see what's wrong in there. That thing does

             (b) = find_next_bit((addr), (size), (e) + 1),      \
             (e) = find_next_zero_bit((addr), (size), (b) + 1))

for the end of the range, and looking at the oops, the instruction
that oopses is

         ldrb    r3, [r0, r2, lsr #3]

where 'r2' is the bit position, and 'r0' is the start of the bitmap.

And:

> r10: 00000000  r9 : 0000002d  r8 : ef59d000
> r7 : c0e55514  r6 : c2215000  r5 : 00008000  r4 : 00008000
> r3 : 845cac12  r2 : 00008001  r1 : 00008000  r0 : ef59d000

Lookie here: r1 contains the size, and r2 is past the end of the size.

So pick your poison: either the bug is in

 (a) the bitmap region iterators shouldn't even ask for past-the-end results

     I've added Dennis Zhou who did that first
bitmap_for_each_set_region() in commit e837dfde15a4 ("bitmap:
genericize percpu bitmap region iterators"), and Yuri Norov who
renamed and moved it to for_each_set_bitrange() in commit ec288a2cf7ca
("bitmap: unify find_bit operations").

or

 (b) the ARM find_next_bit() implementation, which doesn't check
whether the position is past the end

     I've added Russell King (ARM stuff) and Catalin Marinas who
touched that last many many years ago in 8b592783a2e8 ("Thumb-2:
Implement the unified arch/arm/lib functions")

I think it's arguably a little bit of both, but mostly (b).

Note how the genetic find_next_bit() (and _find_next_bit()) does

        if (unlikely(start >= nbits))
                return nbits;

but the arm version of it does not.

I think the fix might be something like this:

  diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
  index b5e8b9ae4c7d..b36ca301892e 100644
  --- a/arch/arm/lib/findbit.S
  +++ b/arch/arm/lib/findbit.S
  @@ -83,6 +83,8 @@ ENDPROC(_find_first_bit_le)
   ENTRY(_find_next_bit_le)
                teq     r1, #0
                beq     3b
  +             cmp     r2, r1
  +             bhs     3b
                ands    ip, r2, #7
                beq     1b                      @ If new byte, goto old routine
    ARM(                ldrb    r3, [r0, r2, lsr #3]    )

but my ARM asm is so broken that the above is just really random noise
that may or may not build - much less work.

I'll leave it to Russell &co to have a tested and working patch.

Hmm?

                    Linus
