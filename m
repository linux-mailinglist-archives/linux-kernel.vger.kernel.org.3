Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6958C90B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbiHHNJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiHHNJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:09:24 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E10C5FC3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:09:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m22so6324031qkm.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=k1TjY5xnUjj1+/lGv63az2dDWuyn6OfPi4lM94OvKo0=;
        b=ocX3tr6UAOXM+/EHhgRkxtM3sBtmGi/VrgUunTLQT51ax9Q1eLj3Do7ry4Vy400/m/
         Wlcj7KVQWHLQT/lDEJY6TzG/1bYb0kSXJdOv0mh4tH5mhHB0tmO0Bby6cyW+FZ1IgGLk
         wTZTyz58ArM1xsrs+cJCogjAb1aLEy86FJAlQmSdXQh6ff66VhqTgIJdP1IcXXLYpKlw
         5SQTwjTvoeI7jUcS/8sHDYyQbA3Ty+2Xk8cmBn6WQV/nN8KBDgjSAcD3IQAZfr7r3k0/
         Wb8cHfrFqbH9DV+ADZ2JE3cBtzRmzjWK2XC2k1iMmr2q9/biWR443vbwsAPVxCAYqGIh
         +AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=k1TjY5xnUjj1+/lGv63az2dDWuyn6OfPi4lM94OvKo0=;
        b=04aWPKZOs3RUzNGa4hgzSkCjINqGhzQu4tEWyh7GYLl8NnaxpNYGPEnDvgjvN27Xq0
         r4r++m+L4NOIFLI9F3XcCHKP4+8lgn9MS+FD4lMNMcew8cvpE6fsvDK/+qEmFDshjG4q
         F0Ej5qA7C8FGEM9wbWAn/yPyGobEuyPiVYjZ0h+YjYt8p4IMLEImtZ48TBrI3S+q1zFQ
         9fi+UUlFSgYGP6bn1nJ1DJv3aZHTNjyVEVrVzp7TBCeleSPYEMxOh4hsSAD/c836NM0w
         ws/V5kvmtjdISdjVzns7EJ+/aAdJXJEROldIyhm7xRSIXbz0aa3cohOW6oeZuSYkAoU9
         z40w==
X-Gm-Message-State: ACgBeo3qZzL9Vm6lxQrla7U3z9w1mTnY+NZAlHlurgUQwOj7CPMfIls+
        qMjRZBMil9M6abC+Zt6ikfK2vWlUEbSfKXCW6Y7lRpFFGWj7Ew==
X-Google-Smtp-Source: AA6agR52jCYQmK91d+3J+37DS5UfX6aS2qv32j0yjdMuOGHhlM5SQAU4RO4uAaaZpEIP3vyPaOcx4dh6fMPqRsLNC+A=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr14097277qkp.504.1659964158541; Mon, 08
 Aug 2022 06:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220808024128.3219082-1-willy@infradead.org> <20220808024128.3219082-6-willy@infradead.org>
In-Reply-To: <20220808024128.3219082-6-willy@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 15:08:41 +0200
Message-ID: <CAHp75VfCLTMERQ7O01jA2ybRFAreeY3306A07M2rsR0Q+BH90g@mail.gmail.com>
Subject: Re: [PATCH v5 05/32] lib/string_helpers: string_get_size() now
 returns characters wrote
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andy@kernel.org>
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

On Mon, Aug 8, 2022 at 4:41 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> From: Kent Overstreet <kent.overstreet@gmail.com>
>
> printbuf now needs to know the number of characters that would have been
> written if the buffer was too small, like snprintf(); this changes
> string_get_size() to return the the return value of snprintf().

the the --> the

Acked-by: Andy Shevchenko <andy@kernel.org>

> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> ---
>  include/linux/string_helpers.h | 4 ++--
>  lib/string_helpers.c           | 7 +++----
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index 67de398944e8..52e0f1d283b9 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -19,8 +19,8 @@ enum string_size_units {
>         STRING_UNITS_2,         /* use binary powers of 2^10 */
>  };
>
> -void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
> -                    char *buf, int len);
> +int string_get_size(u64 size, u64 blk_size, enum string_size_units units,
> +                   char *buf, int len);
>
>  #define UNESCAPE_SPACE         BIT(0)
>  #define UNESCAPE_OCTAL         BIT(1)
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 7be20bcc6137..d247bf945f16 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -33,8 +33,8 @@
>   * at least 9 bytes and will always be zero terminated.
>   *
>   */
> -void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
> -                    char *buf, int len)
> +int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
> +                   char *buf, int len)
>  {
>         static const char *const units_10[] = {
>                 "B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
> @@ -127,8 +127,7 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>         else
>                 unit = units_str[units][i];
>
> -       snprintf(buf, len, "%u%s %s", (u32)size,
> -                tmp, unit);
> +       return snprintf(buf, len, "%u%s %s", (u32)size, tmp, unit);
>  }
>  EXPORT_SYMBOL(string_get_size);
>
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
