Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A663C549F22
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbiFMUbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiFMUaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:30:17 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1347251327
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:20:38 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id i186so6825540vsc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNf+Ql/j9M3Vn23KbuohSdFzXJiSMm4FbEkJFMkKX04=;
        b=LFD5f5sGzeRtIHpKCfZF5wyqKqG9bfNsj60uXrN7M1R800Eu/YEdpUvb+X/6ArMBxW
         Ku4q3Q8JCrCQTy/4/lL8iTtejcGpM5xZGS70hxdwKfJB6rQX+4h7sqMk3+/tsxmo3ex4
         jN3O0CzCqLLdmbxGM8dWsgJ6CiqkB0/A2dzGZKxHwqBMWYQr8XoVivSwoQCVU6bty/k5
         679ip2+IHOsWfc6TYV6iCERLi8u72VacjBPrVSyd3r3lDt1u9NeDyC7/WNWLI5Wvv4Yd
         yK4tIN45bP9H8vdItANiRJ0UFtTyToSY2dWApATFmfNgJ5lLKhn0OgPh3QXOihRozuvQ
         IGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNf+Ql/j9M3Vn23KbuohSdFzXJiSMm4FbEkJFMkKX04=;
        b=RLhCF6QD/m5M8cFdyepfDqZYAA1xXAkI1FMX4ZEySGBIVru2BX9LKKTW6/X71vmH8J
         XhQm1extSU2qXkAVuk/AHt7X2S8poYkCN2HmERc7sWJas7cjMtUW76fDyzWrMquHj3YL
         q6utpC0HEubkkLx7oTqbM+ArNEFJy0WFkzyjdWsUsxvDK4S7cbP+Vyw9QDAQQQPLKl9v
         Vyfr3K9CB1Qk+L96+H6j1IjGMR6WYRiODJ3fEYomdzm8mXjKLq1dOD1ri4mYab02/fe+
         VtXj2HMgGxsOVbubpX1MzoSNqhyyvDP3wykRxOrrZ23Uui/H8ck78OhKse6EILTWZZ3n
         4VWQ==
X-Gm-Message-State: AJIora9mLZCT+vwn9JDe1MBHFWsUbIAHAHLAroGIUvQsCbxcS7jJsA1j
        cYgGPLIa1sFV7lPqMRe+SmGWaM0PPhrYKScGmG6ou/bM6Sw=
X-Google-Smtp-Source: AGRyM1sna9Eq4Osr5KmST24hrtbVcR20wkRP0EMEDMdi9yusF90SuIPxvSPYkdr5Ll1OxtmtIw4/8zG9xxDp0VS2veo=
X-Received: by 2002:a05:6102:2328:b0:349:ed98:2b96 with SMTP id
 b8-20020a056102232800b00349ed982b96mr525017vsa.57.1655148037073; Mon, 13 Jun
 2022 12:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220613112937.65428-1-wang.yi59@zte.com.cn>
In-Reply-To: <20220613112937.65428-1-wang.yi59@zte.com.cn>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 13 Jun 2022 12:20:26 -0700
Message-ID: <CAAH8bW8wD_hsOqtWa-g_1SNWNi7GHzsu9RvL8feY069JPKFWBA@mail.gmail.com>
Subject: Re: [PATCH] bitmap: fix a unproper remap when mpol_rebind_nodemask()
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn
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

On Mon, Jun 13, 2022 at 4:31 AM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> Consider one situation:
>
> The app have two vmas which mbind() to node 1 and node3 respectively,
> and its cpuset.mems is 0-3, now set its cpuset.mems to 1,3, according
> to current bitmap_remap(), we got:
>
>     1 => 3
>     3 => 3
>
> This maybe confused because node 1,3 have already in the new settiing
> region but both nodes are binded to the same node 3 now.
>
> Actually we found the situation on a very old libvirt and qemu, but
> this can be easily reproduced in the current kernel, so we try to fix
> it.
>
> A possible fix way is to ignore the bits in @src have already existed
> in @new.
>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  lib/bitmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index b18e31ea6e66..b77bf1b3852e 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -1006,8 +1006,8 @@ unsigned int bitmap_ord_to_pos(const unsigned long *buf, unsigned int ord, unsig
>   * @dst point to the same location, then this routine copies @src
>   * to @dst.
>   *
> - * The positions of unset bits in @old are mapped to themselves
> - * (the identify map).
> + * The positions of unset bits in @old or bits in @src have already
> + * existed in @new are mapped to themselves (the identify map).
>   *
>   * Apply the above specified mapping to @src, placing the result in
>   * @dst, clearing any bits previously set in @dst.
> @@ -1033,7 +1033,7 @@ void bitmap_remap(unsigned long *dst, const unsigned long *src,
>         for_each_set_bit(oldbit, src, nbits) {
>                 int n = bitmap_pos_to_ord(old, oldbit, nbits);
>
> -               if (n < 0 || w == 0)
> +               if (n < 0 || w == 0 || test_bit(oldbit, new))
>                         set_bit(oldbit, dst);   /* identity map */
>                 else
>                         set_bit(bitmap_ord_to_pos(new, n % w, nbits), dst);
> --
> 2.33.0.rc0.dirty

Regarding the original problem - can you please confirm that
it's reproduced on current kernels, show the execution path etc.
From what I see on modern kernel, the only user of nodes_remap()
is mpol_rebind_nodemask(). Is that the correct path?

Anyways, as per name, bitmap_remap() is intended to change bit
positions, and it doesn't look wrong if it does so.

This is not how the function is supposed to work. For example,
        old: 00111000
        new: 00011100

means:
        old: 00111 000
             || \\\|||
        new: 000 11100

And after this patch it would be:
        old: 001 11000
             || \|||||
        new: 000 11100

Which is not the same, right?

If mpol_rebind() wants to keep previous relations, then according to
the comment:
 * The positions of unset bits in @old are mapped to themselves
 * (the identify map).

, you can just clear @old bits that already have good relations
you'd like to preserve.

Thanks,
Yury
