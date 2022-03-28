Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D621D4E8B78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 03:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiC1BNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 21:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiC1BNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:13:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C198A4EF71;
        Sun, 27 Mar 2022 18:11:36 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t2so11142983qtw.9;
        Sun, 27 Mar 2022 18:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KtsnSy9eDNDheJpfFbAak/H2pkDZ6a4cufga2qircQ0=;
        b=Uu9nf9ZsRA5F7g2AqCTnuAhuGg1Y4Zi54ZHXwmXpmbMHpTWNaFHjYrE5pu/8834SFm
         iQF4P36pTxGUD/q43x8ON73Csy4DV99NFlfMgJbgqZUxMU+o+BwtED7V7DZU0AyWKlZf
         2fqMv/pPrGud3phFu8G2xJgFhqxPIvUqde0iW7f5bw9+RotoVhn6ybyNbu4GgZltrLFh
         mAmJCw3sJbSp5Pi4os4iEuTgxSvk+bfGgY3SWu1Z3WudnEypCOJKhCjwr39NJZuLWPjF
         NPkkcKzLuRkwMCwbApihVgEMGG862iJREvsga6rz/TeqU8Mg4uw6s9N/QNFgxAZud8EY
         0e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtsnSy9eDNDheJpfFbAak/H2pkDZ6a4cufga2qircQ0=;
        b=NwZiiVSv2MzRydV2ozAyNxh1zLQ49jde/+YRPwgkzHrGl7Ae57nofiYzsCAjMXlUUv
         +xLPDQ2YTVwybghR4nC0GiPWu9IiQ+1Rb8c8ZzJGZuvffTXDWq65deN4lE0rsV7B0Tm4
         gmXAsHBmRrqcE1PY+ZJZwPK5hYbcm7S5NtZp7Ozrm38hUw/OD19UmHWdDSxtUC+lojgb
         ryNTpdFgXM1mEcEpqtzyHH+jElvvwAAzE1crixCRI5vpKUfkzGC3POfaHjB+ALQafrDe
         laAd+ZObxGbKehcMteKtMd7ksbT6ApgVhvb8YIsWDwZTX7bcN+F7Ai1RBLUskDu0kgT4
         oeJA==
X-Gm-Message-State: AOAM532tApzKVrZWSOJOBqioJq5bKSZSPqN6+jG7PQqV6EcZcoSbklJX
        7+4A/PxpIgMjxlDi4//bPn8=
X-Google-Smtp-Source: ABdhPJwgFJFjW4jIXkf4oGFMdCNFSc2ftB3G5GuhsYddulUJCyoUheALpHxUNK4OEnpcSKNHnkUjDw==
X-Received: by 2002:ac8:5805:0:b0:2e1:cea3:3ca2 with SMTP id g5-20020ac85805000000b002e1cea33ca2mr19355247qtg.33.1648429895838;
        Sun, 27 Mar 2022 18:11:35 -0700 (PDT)
Received: from localhost ([98.242.64.6])
        by smtp.gmail.com with ESMTPSA id g200-20020a379dd1000000b0067d76e714f5sm7315986qke.35.2022.03.27.18.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 18:11:35 -0700 (PDT)
Date:   Sun, 27 Mar 2022 18:11:33 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/bitmap.c make bitmap_print_bitmask_to_buf parseable
Message-ID: <YkELRUfrwSYap4Mr@yury-laptop>
References: <f6372a2f880c6e8597a8f070eb031d4cd451d37e.1648291287.git.mchehab@kernel.org>
 <CAHp75Vc50ko7F0ZT_uWf6+f3atj0mg+RdFP9-sX_PLUtPqk3Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc50ko7F0ZT_uWf6+f3atj0mg+RdFP9-sX_PLUtPqk3Eg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 11:04:21PM +0300, Andy Shevchenko wrote:
> On Sat, Mar 26, 2022 at 8:39 PM Mauro Carvalho Chehab
> <mchehab@kernel.org> wrote:
> >
> > The documentation of such function is not on a proper ReST format,
> > as reported by Sphinx:
> >
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:532: WARNING: Unexpected indentation.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:526: WARNING: Inline emphasis start-string without end-string.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:532: WARNING: Inline emphasis start-string without end-string.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:532: WARNING: Inline emphasis start-string without end-string.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:533: WARNING: Block quote ends without a blank line; unexpected unindent.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:536: WARNING: Definition list ends without a blank line; unexpected unindent.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:542: WARNING: Unexpected indentation.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:536: WARNING: Inline emphasis start-string without end-string.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:536: WARNING: Inline emphasis start-string without end-string.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:543: WARNING: Block quote ends without a blank line; unexpected unindent.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:552: WARNING: Unexpected indentation.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:545: WARNING: Inline emphasis start-string without end-string.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:545: WARNING: Inline emphasis start-string without end-string.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:552: WARNING: Inline emphasis start-string without end-string.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:552: WARNING: Inline emphasis start-string without end-string.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:554: WARNING: Block quote ends without a blank line; unexpected unindent.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:556: WARNING: Definition list ends without a blank line; unexpected unindent.
> >     Documentation/core-api/kernel-api:81: ./lib/bitmap.c:580: WARNING: Unexpected indentation.
> >
> > So, the produced output at:
> >
> >         https://www.kernel.org/doc/html/latest/core-api/kernel-api.html?#c.bitmap_print_bitmask_to_buf
> >
> > is broken. Fix it by adding spaces and marking the literal blocks.
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Thanks!
> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Applied to bitmap branch
https://github.com/norov/linux/tree/bitmap

Thanks,
Yury

> > ---
> >  lib/bitmap.c | 33 ++++++++++++++++++++-------------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > index 0d5c2ece0bcb..8ebe508580ea 100644
> > --- a/lib/bitmap.c
> > +++ b/lib/bitmap.c
> > @@ -527,33 +527,39 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> >   * cpumap_print_to_pagebuf() or directly by drivers to export hexadecimal
> >   * bitmask and decimal list to userspace by sysfs ABI.
> >   * Drivers might be using a normal attribute for this kind of ABIs. A
> > - * normal attribute typically has show entry as below:
> > - * static ssize_t example_attribute_show(struct device *dev,
> > + * normal attribute typically has show entry as below::
> > + *
> > + *   static ssize_t example_attribute_show(struct device *dev,
> >   *             struct device_attribute *attr, char *buf)
> > - * {
> > + *   {
> >   *     ...
> >   *     return bitmap_print_to_pagebuf(true, buf, &mask, nr_trig_max);
> > - * }
> > + *   }
> > + *
> >   * show entry of attribute has no offset and count parameters and this
> >   * means the file is limited to one page only.
> >   * bitmap_print_to_pagebuf() API works terribly well for this kind of
> > - * normal attribute with buf parameter and without offset, count:
> > - * bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
> > + * normal attribute with buf parameter and without offset, count::
> > + *
> > + *   bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
> >   *                        int nmaskbits)
> > - * {
> > - * }
> > + *   {
> > + *   }
> > + *
> >   * The problem is once we have a large bitmap, we have a chance to get a
> >   * bitmask or list more than one page. Especially for list, it could be
> >   * as complex as 0,3,5,7,9,... We have no simple way to know it exact size.
> >   * It turns out bin_attribute is a way to break this limit. bin_attribute
> > - * has show entry as below:
> > - * static ssize_t
> > - * example_bin_attribute_show(struct file *filp, struct kobject *kobj,
> > + * has show entry as below::
> > + *
> > + *   static ssize_t
> > + *   example_bin_attribute_show(struct file *filp, struct kobject *kobj,
> >   *             struct bin_attribute *attr, char *buf,
> >   *             loff_t offset, size_t count)
> > - * {
> > + *   {
> >   *     ...
> > - * }
> > + *   }
> > + *
> >   * With the new offset and count parameters, this makes sysfs ABI be able
> >   * to support file size more than one page. For example, offset could be
> >   * >= 4096.
> > @@ -577,6 +583,7 @@ static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> >   * This function is not a replacement for sprintf() or bitmap_print_to_pagebuf().
> >   * It is intended to workaround sysfs limitations discussed above and should be
> >   * used carefully in general case for the following reasons:
> > + *
> >   *  - Time complexity is O(nbits^2/count), comparing to O(nbits) for snprintf().
> >   *  - Memory complexity is O(nbits), comparing to O(1) for snprintf().
> >   *  - @off and @count are NOT offset and number of bits to print.
> > --
> > 2.35.1
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
