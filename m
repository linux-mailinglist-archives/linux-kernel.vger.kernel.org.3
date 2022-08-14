Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD259260A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiHNStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNStU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:49:20 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F760D9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 11:49:20 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j17so4244955qtp.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qzkh6tkTJbyR9Le+Pkhrjrt9I8V0rbFen1/yBuWJ42g=;
        b=CJRxrV+uUAqljv0fFvsbEDpoex/Kx4ewHywpRT36KctDvz32e77w0oMtOAkSZd5ywT
         UI7XS2usZkYjIflLQQHT1ew7DwjT1Eg820JEOtaNbDTr0p/t43hV6Q+QBnlrvkKU3XQW
         eUZ5MGZ0/pu96ItqEXWID00Se2jf5dKTtPXm4S4eOhBiZIjJlGFpBSDD8ZsWcYgYdd0G
         7Yo5jXxmUC2T/zzicrTs5DhwULZN2OYAHbACtCPt5qaBQ3FABOJsuSkNKYcUandx3jxo
         nOh1pUmBwTD339WoQ0OugZWzrMPZQkIG1C5LE2rNkbRNa53rgY9KioaesfluWD7+ndfa
         tYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qzkh6tkTJbyR9Le+Pkhrjrt9I8V0rbFen1/yBuWJ42g=;
        b=xMhOyLlZfKCnIS8Tcq4Ni6+mn6Mfev+9RME4veX0pv39aFqugXYfMjJiRDs4ANYycf
         5dC9b4njCbQBkwQWb6KJhs5ERYp85gJUAlS6JzGtrJMDQsD/4JyzvgIRjjoDSIiO4JPS
         BWu6uPA+eo1GWMwhQHeT4z6kbRmi7JW/bJClZnlMaTZiD/tGXL/q3I4b79lpUs98TnYv
         8J2/RCnqpCEFctyknWosoC1e7wK+F8RZy1MA9LvJjrtpi0FHdGxhExLi3+buV7aKOGVv
         y+3sume9Wi47P5SaqlMlH30d81mldUukusLwJfvkQ1ByMGRC8hlz5ohOFDLOzsq0XTuG
         OruQ==
X-Gm-Message-State: ACgBeo3/BQLWQQu3Ny69sUB+aG6+65N9ACWNz3JZTruYJNGJ/tJPMoFU
        mTfifeishrpNffEJjXITih6uTQQLIO5Ye0krHyU=
X-Google-Smtp-Source: AA6agR6XjTa9TMD/Yv58BQjzH7evg6UC1cPdi1RCaEDkgiX847W88c0dGpT8FenZ3gtDVrCS5QNiM2EzUEIAp3x2OcA=
X-Received: by 2002:a05:622a:48f:b0:343:463:351a with SMTP id
 p15-20020a05622a048f00b003430463351amr11306999qtx.61.1660502958933; Sun, 14
 Aug 2022 11:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220711044711.466822-1-yury.norov@gmail.com> <20220711044711.466822-6-yury.norov@gmail.com>
 <20220729034638.GA2276915@roeck-us.net> <20220813131523.GA2787704@roeck-us.net>
 <CAAH8bW8n+6-4fGYp-g_vXe3XKwC5AV_hCCyzj=h2Wx1XFBK5dQ@mail.gmail.com>
In-Reply-To: <CAAH8bW8n+6-4fGYp-g_vXe3XKwC5AV_hCCyzj=h2Wx1XFBK5dQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Aug 2022 21:48:43 +0300
Message-ID: <CAHp75VemqDc3E88k45bMiaLuBpGmgh81C+pGLD1Ey+V1=AS2cA@mail.gmail.com>
Subject: Re: [PATCH 5/5] lib/nodemask: inline next_node_in() and node_random()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 4:55 PM Yury Norov <yury.norov@gmail.com> wrote:

> I submitted the patch:
> https://www.spinics.net/lists/kernel/msg4468633.html


Just side note: Use lore.kernel.org for reference to the submissions
in the past.

-- 
With Best Regards,
Andy Shevchenko
