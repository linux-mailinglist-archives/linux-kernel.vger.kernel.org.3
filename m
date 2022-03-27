Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906014E89EE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiC0UGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiC0UGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:06:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7655A1262C;
        Sun, 27 Mar 2022 13:04:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id pv16so24779678ejb.0;
        Sun, 27 Mar 2022 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohtTOFwdPQ4AOw3GQF3QapgXdCDzfitdYHdMexYJt0s=;
        b=VoQkFMhBgUDHuzvs3mhfiHHPpmStH1xj91457cCibQ50SFqt5Jtw87mJlFR127MmLu
         Ij7yt2ru7DBLU6qsqTAgVWlVSKinUyUODiYpljqzyGYvxOG+0dSljYo7nIvchmTsTd1E
         og0z6dFLrLKbpR7w7o0QRcZoxsH+iqyL1UmuWVS2HY85Z7p1pFM/zoGzEMdq6w+KSW4a
         3XOxzC+0nyP56XAEV5lNXpSu67G0ObDmXI2B664X+94hZ7VuTuVhi+nq0eVP8FhKi+fZ
         zLZU5/YQuUhG6Jz2ZYegPNVMpBJxukxbtBH6Hw4vd31233q1o4YmkgfkswIXFzSYIE4q
         cPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohtTOFwdPQ4AOw3GQF3QapgXdCDzfitdYHdMexYJt0s=;
        b=ty3k+EqpMjkV/49Qu81PFShrMBJZSpqbYPkLEpb9cl80i0gaq4KgYDHktyv9IwEdGZ
         8+wy28ZGqQFvxgbyUf9jtdho2mmSYxv7XQ3qN2y6cJjmUoXcgwDOtWG3afNsm2X84L69
         ybmw6Qhiew6wmCr7bCO1UAOpjaSJ2kz/PZ6ioEr68SNE/3WQrS8cINn7KZ2cFNMBlABs
         DtO5z9bVXRJtqJHAMolgItQuIr2ibR9npGQh1SeKn3Tt/fNyf+9B9tFf4C2eo+KOuPrW
         LAjSO6HtMwFTbiBZJZ2+EY8ixjUN9zfv5cOV9ajVhPaysGhw0a1Os6fTKMSbr87/8Pba
         Lk/Q==
X-Gm-Message-State: AOAM533U9OP94yymxSRpXwBNHzJckKmg/V7Q8scrq/IHmJt14OsZvC18
        fC2RSWNMCl3uBUGvabVYqWMxV29E988y4rzWVlT0sdIuil4=
X-Google-Smtp-Source: ABdhPJyBZUDM7B9ex+Xu4sTigiToYzIpFWAhdJcN22kvx75+VjSKmc9f8txVyQ6ygvykMMrjk4anaB6clFk8v8NsdVI=
X-Received: by 2002:a17:907:9703:b0:6da:6412:508a with SMTP id
 jg3-20020a170907970300b006da6412508amr23819809ejc.77.1648411496962; Sun, 27
 Mar 2022 13:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <f6372a2f880c6e8597a8f070eb031d4cd451d37e.1648291287.git.mchehab@kernel.org>
In-Reply-To: <f6372a2f880c6e8597a8f070eb031d4cd451d37e.1648291287.git.mchehab@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 23:04:21 +0300
Message-ID: <CAHp75Vc50ko7F0ZT_uWf6+f3atj0mg+RdFP9-sX_PLUtPqk3Eg@mail.gmail.com>
Subject: Re: [PATCH] lib/bitmap.c make bitmap_print_bitmask_to_buf parseable
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Mar 26, 2022 at 8:39 PM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> The documentation of such function is not on a proper ReST format,
> as reported by Sphinx:
>
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:532: WARNING: Unexpected indentation.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:526: WARNING: Inline emphasis start-string without end-string.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:532: WARNING: Inline emphasis start-string without end-string.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:532: WARNING: Inline emphasis start-string without end-string.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:533: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:536: WARNING: Definition list ends without a blank line; unexpected unindent.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:542: WARNING: Unexpected indentation.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:536: WARNING: Inline emphasis start-string without end-string.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:536: WARNING: Inline emphasis start-string without end-string.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:543: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:552: WARNING: Unexpected indentation.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:545: WARNING: Inline emphasis start-string without end-string.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:545: WARNING: Inline emphasis start-string without end-string.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:552: WARNING: Inline emphasis start-string without end-string.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:552: WARNING: Inline emphasis start-string without end-string.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:554: WARNING: Block quote ends without a blank line; unexpected unindent.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:556: WARNING: Definition list ends without a blank line; unexpected unindent.
>     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:580: WARNING: Unexpected indentation.
>
> So, the produced output at:
>
>         https://www.kernel.org/doc/html/latest/core-api/kernel-api.html?#c.bitmap_print_bitmask_to_buf
>
> is broken. Fix it by adding spaces and marking the literal blocks.

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  lib/bitmap.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 0d5c2ece0bcb..8ebe508580ea 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -527,33 +527,39 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
>   * cpumap_print_to_pagebuf() or directly by drivers to export hexadecimal
>   * bitmask and decimal list to userspace by sysfs ABI.
>   * Drivers might be using a normal attribute for this kind of ABIs. A
> - * normal attribute typically has show entry as below:
> - * static ssize_t example_attribute_show(struct device *dev,
> + * normal attribute typically has show entry as below::
> + *
> + *   static ssize_t example_attribute_show(struct device *dev,
>   *             struct device_attribute *attr, char *buf)
> - * {
> + *   {
>   *     ...
>   *     return bitmap_print_to_pagebuf(true, buf, &mask, nr_trig_max);
> - * }
> + *   }
> + *
>   * show entry of attribute has no offset and count parameters and this
>   * means the file is limited to one page only.
>   * bitmap_print_to_pagebuf() API works terribly well for this kind of
> - * normal attribute with buf parameter and without offset, count:
> - * bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
> + * normal attribute with buf parameter and without offset, count::
> + *
> + *   bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
>   *                        int nmaskbits)
> - * {
> - * }
> + *   {
> + *   }
> + *
>   * The problem is once we have a large bitmap, we have a chance to get a
>   * bitmask or list more than one page. Especially for list, it could be
>   * as complex as 0,3,5,7,9,... We have no simple way to know it exact size.
>   * It turns out bin_attribute is a way to break this limit. bin_attribute
> - * has show entry as below:
> - * static ssize_t
> - * example_bin_attribute_show(struct file *filp, struct kobject *kobj,
> + * has show entry as below::
> + *
> + *   static ssize_t
> + *   example_bin_attribute_show(struct file *filp, struct kobject *kobj,
>   *             struct bin_attribute *attr, char *buf,
>   *             loff_t offset, size_t count)
> - * {
> + *   {
>   *     ...
> - * }
> + *   }
> + *
>   * With the new offset and count parameters, this makes sysfs ABI be able
>   * to support file size more than one page. For example, offset could be
>   * >= 4096.
> @@ -577,6 +583,7 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
>   * This function is not a replacement for sprintf() or bitmap_print_to_pagebuf().
>   * It is intended to workaround sysfs limitations discussed above and should be
>   * used carefully in general case for the following reasons:
> + *
>   *  - Time complexity is O(nbits^2/count), comparing to O(nbits) for snprintf().
>   *  - Memory complexity is O(nbits), comparing to O(1) for snprintf().
>   *  - @off and @count are NOT offset and number of bits to print.
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
