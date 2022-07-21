Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9285857D4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiGUUlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUUlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:41:50 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058C18F50B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:41:49 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i7so2130728qvr.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MY3kboTjNAZXbrK31xdc4/MyqehNd793LiUl2690CR8=;
        b=V6UHbJdA6E3eNP/Ito/PHrAmnT5s2OUvqIpOIiXwGUSNLtENrmuYbzZPhGbDIKZz/2
         lW/sFCtVKkEFIXrzgRUYwvhgWeR9y0DDhuoqBxrztTVnAguGUiK5ZBQJBPm+dhxTEfZv
         oDFj5/yaOZ5MMqBgQ6EVJ2taS9AQmIlRtZLQQF228pp2np7/AaHk95h72d5VY+lvugd8
         YDdu5bcWxRe+4/Jq6su8eU5EC9E/WLL2zKal95Xd9c79wvQkx17g0e1SAzzPsBUsL1aM
         D7OTA3JMES64hS+DNL7jVOKYKSJbItEGTML21ZX/Uuzfs6bGbr09OIC3Xus3KhDzHjx3
         66Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MY3kboTjNAZXbrK31xdc4/MyqehNd793LiUl2690CR8=;
        b=2IfPoNXut1RWs4XHsXLkzDU7bJKtEsjFg9sFDLa0IvAtKar6sx+vUQIf6WqOg+XFpm
         BeXSxsOaJOE3uVacze117mgcaFSby6ozBLmRp/TBwgmtnuIjuzfP6q9DBbSxJjtVc/S4
         KSHhGRa5FVmjJl2agP/nXk9S4UaS4sBloWRFMxHfbBWGBTMLTpfbSIvrfKo2/X6T8QOe
         JbWJo688SSN0AZMMz7LqScglju2brERdopgI9MufeYlHB8o5ll9TvGoU2ri35MjaA1l+
         0lJh5UhlOYaGIzlnzl0BN7KntLwbXkq8DZb8ImRFFZ1U+sqNyYZArD6HmqH+/yUqcp2y
         ClTw==
X-Gm-Message-State: AJIora9Mdaw+nmc08j6DpgU4o4BUydkj98pX60tjdjiljEq95K9PiH4K
        Z730PRqITwO1stNs1dsuciBPreTVCZsCXmO0ed0=
X-Google-Smtp-Source: AGRyM1tpSTjXo+QY23OBrYISb3s/V15DU+goarp18y+HIgvy+HW7FE77o+1cNzildmLY1JWlMNImd7rjJbsDOzKDLJU=
X-Received: by 2002:a05:6214:2a4c:b0:472:f8bf:ca74 with SMTP id
 jf12-20020a0562142a4c00b00472f8bfca74mr323196qvb.111.1658436107864; Thu, 21
 Jul 2022 13:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658189199.git.andreyknvl@google.com> <0e910197bfbcf505122f6dae2ee9b90ff8ee31f7.1658189199.git.andreyknvl@google.com>
 <CANpmjNMrwXxU0YCwvHo59RFDkoxA-MtdrRCSPoRW+KYG2ez-NQ@mail.gmail.com>
In-Reply-To: <CANpmjNMrwXxU0YCwvHo59RFDkoxA-MtdrRCSPoRW+KYG2ez-NQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 21 Jul 2022 22:41:36 +0200
Message-ID: <CA+fCnZcT2iXww90CfiByAvr58XHXShiER0x0J2v14hRzNNFe9w@mail.gmail.com>
Subject: Re: [PATCH mm v2 30/33] kasan: implement stack ring for tag-based modes
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 1:41 PM Marco Elver <elver@google.com> wrote:
>
> > +       for (u64 i = pos - 1; i != pos - 1 - KASAN_STACK_RING_SIZE; i--) {
> > +               if (alloc_found && free_found)
> > +                       break;
> > +
> > +               entry = &stack_ring.entries[i % KASAN_STACK_RING_SIZE];
> > +
> > +               /* Paired with smp_store_release() in save_stack_info(). */
> > +               ptr = (void *)smp_load_acquire(&entry->ptr);
> > +
> > +               if (kasan_reset_tag(ptr) != info->object ||
> > +                   get_tag(ptr) != get_tag(info->access_addr))
> > +                       continue;
> > +
> > +               pid = READ_ONCE(entry->pid);
> > +               stack = READ_ONCE(entry->stack);
> > +               is_free = READ_ONCE(entry->is_free);
> > +
> > +               /* Try detecting if the entry was changed while being read. */
> > +               smp_mb();
> > +               if (ptr != (void *)READ_ONCE(entry->ptr))
> > +                       continue;
>
> I thought the re-validation is no longer needed because of the rwlock
> protection?

Oh, yes, forgot to remove this. Will either do in v3 if there are more
things to fix, or will just send a small fix-up patch if the rest of
the series looks good.

> The rest looks fine now.

Thank you, Marco!
