Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6D580C18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiGZHD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbiGZHDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:03:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3775D2A248;
        Tue, 26 Jul 2022 00:03:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z18so4289742edb.10;
        Tue, 26 Jul 2022 00:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4juQ+UUYqXqOV8yvo6wGfQMMUNtrJT+iRWdiY2vqHs=;
        b=R9sGeh1gKxSuoQsPRZXjKlx0z2KEJFAIOsxx8YEm55nrWhMpAJluZvj9BFa+a61dBm
         adI6e/DfxNMp/OzCkAQtCAA0wBwf015Ggmv5YdcZJ6xEstf2TvMWATqfnbDhqvnMFMRq
         pvtGK2FEj3BKRwsySc71hTSImIcjc38V0SArALCT56CKEqgxZguzyyAusmreGyCRp/Ma
         KOLgxk7x72kVuCyZK1eJwekGVqo1rew5jcct6GMDh34dgOsMndSXR74N1TvwBxaSA385
         sPrfkCJKyMUT7DazVKzRxNkGzW9sRLZcopzvMGzRwF0mdJUZO4ZFJXinqmqjX+uawO2T
         meUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4juQ+UUYqXqOV8yvo6wGfQMMUNtrJT+iRWdiY2vqHs=;
        b=4Of4TvCuAUYTVWXPWwwID5bTlQc9U+Fk/BLRSUNSlsy2Sbm4gVKEAr2SfJAwMXiRiN
         mLajxoCoaKhbUHpO3u46H/vdS0eSN/HA24w90ENUwEMQXhiF832bqHmbqNzS6MhXoIV/
         LVGHvz+/CPE/ailok+HH5LOk/r6N3Qj+s5o6u0Og0hV6jPW/sAZAOnLk4kdgSOYD29Tg
         NsgdMSHfcAafzy+8a338wS4prYtYsC763MGL1+wu9HkOhSc7zOIGESqI/KNEmfcE2ujZ
         9+Qp7pk+WM4VxFOoLq3MZXzPc8kKbf1bJloKUv//YVi1y6QxylKsj3ki/BFn+0L46MeK
         c6Kg==
X-Gm-Message-State: AJIora8g6w5DRMbsrodJv47xwWn/HPb45XrFQYRTZZ+5nUoWNhUYN+C8
        GrzGpS45ySBfO+I4orE+o9qi9havd8M9aw/e50I=
X-Google-Smtp-Source: AGRyM1t+avVUAoUo0hDEYCzNMM/R5ElMmPg+SzrC+8UjKke6i3i+beOpp/24gBY0dP3kUxdPoHmRk5z8W+oUw49EmC4=
X-Received: by 2002:a05:6402:1768:b0:43b:c4b0:ffd3 with SMTP id
 da8-20020a056402176800b0043bc4b0ffd3mr16475456edb.163.1658818998928; Tue, 26
 Jul 2022 00:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
 <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com>
 <CAHp75VfaExrFYto7LWa5Vnbm6JbiAqtutKmk0HzfeHmmi3PwOg@mail.gmail.com>
 <CACRpkdYHgD-fmt_2PWJrmyGY=AOP0Z+4jTkH=n3wJ+a0aApqcg@mail.gmail.com>
 <CAHp75Vf_aDSocdB7R6zKFwEOBRwq0w2m6GdCM-5ujKoz4bGiqQ@mail.gmail.com> <CAHp75VfJvkm1LaVtD8BE9y1fsaJ2ToLqQ3H8dY4SshBfE6vtJw@mail.gmail.com>
In-Reply-To: <CAHp75VfJvkm1LaVtD8BE9y1fsaJ2ToLqQ3H8dY4SshBfE6vtJw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 09:02:42 +0200
Message-ID: <CAHp75Vef7xb+PbHKN_mkycm-ga-YACeYqy3YvkirsGs4YGrxZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jul 26, 2022 at 9:00 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 26, 2022 at 8:54 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jul 26, 2022 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:

...

> > See Figure 7 and Table 9 in the datasheet you linked to. When STR is
>
> Table 9 --> Figure 9
>
> > low, the data is not changed. Maybe it's not clear in this datasheet,
> > I found somewhere
> > in a more clear table.

Ah, Table 3 shows that.

> If you have hardware and an oscilloscope you may test it. We will know
> for sure :-)



-- 
With Best Regards,
Andy Shevchenko
