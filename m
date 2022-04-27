Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA0851129A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358893AbiD0Hhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358880AbiD0Hhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:37:40 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69F48D6B7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:34:29 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id w17so1790052ybh.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MeaX4XdIMOSF04IoR3Cab+z51sfQuXXpK7U3HQj8e9Y=;
        b=hrx36cVw/CY8EF92h5eVbLNh7vWB+J2wMLxiihlJLMVIrB09HKNrVpmudoLr6cBTkF
         dTD6fYbQbe//a0D1xDVLTbodu6ak07ePMkofE2pde60ZH/ukdZz5XN8c6kU2mc3qEZo5
         IGs0I08RMsWPfVww55ImcBBESzBwMpqhQDuPMQcURMIlO243HR8YWJ4VVm95ZBkByJNn
         5Jw/jgkylrTeEs743xCSQYs9OOVwUqaThcN3etmD+rUK/H6GAaplb9PN9xKPUTvs+8ws
         Z1aFBFXccngNPA6LZWxQe3E77+EM2vY7X3Ec8JdBjBlCh+VatF138DxaOSrj/cUGcUa+
         qPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MeaX4XdIMOSF04IoR3Cab+z51sfQuXXpK7U3HQj8e9Y=;
        b=yjU17KBVcHVas6SJg+vptMuD2nn74h2iGWsUkMDDREWseyX8YOdcF08Xn7nK97Y2mb
         LwbaRzvKN6H9S6CDbLN15PJB923EtrDnNSYUkg4T/tK9luc0E7RwwEERzOHwiriAmBoe
         ZBVrKE7L6sTk02cN9w74MYEV7xYAhveJEbvgPStmk2PaDrGDhPysAghp8YbCcCK9wsdX
         aPIImC7JK9etrel+dkZQrimK5VU2OCzjq4zbixwU/coklJPQ3YpJ5AvmZVYg5WL2NQLu
         WyDIAiLsFzhof07wHktjtv/beJvJ+/1If2R/XGHxH8Of30YXZPVCzzikEVJ3orugTgUA
         MKZg==
X-Gm-Message-State: AOAM531Sn+jTg5Vt57mlfU37c8sNd0y1b97yDZm8F/t6Kw3w/5B4bUwh
        IqSD7iXpDq4c+NsKw99AxClks7Ai8vrsaRbqWZr8/A==
X-Google-Smtp-Source: ABdhPJw9A1Am1YqwfUuHH25Kgd2alp4pSOBVU71IoXBxNEVLye8foPf3rKxSyf4BvnRSRdqbNgOHt/92tIlzULZ1jNY=
X-Received: by 2002:a25:cc0b:0:b0:648:4590:6cb6 with SMTP id
 l11-20020a25cc0b000000b0064845906cb6mr15972505ybf.87.1651044868807; Wed, 27
 Apr 2022 00:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220427071100.3844081-1-xu.xin16@zte.com.cn>
In-Reply-To: <20220427071100.3844081-1-xu.xin16@zte.com.cn>
From:   Marco Elver <elver@google.com>
Date:   Wed, 27 Apr 2022 09:33:52 +0200
Message-ID: <CANpmjNM8hKG+HH+pBR4cDLcU-sUWFO6t4CF89bt5uess0Zm3dg@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: fix a potential NULL pointer dereference
To:     cgel.zte@gmail.com
Cc:     glider@google.com, akpm@linux-foundation.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 at 09:11, <cgel.zte@gmail.com> wrote:
>
> From: xu xin <xu.xin16@zte.com.cn>
>
> In __kfence_free(), the returned 'meta' from addr_to_metadata()
> might be NULL just as the implementation of addr_to_metadata()
> shows.
>
> Let's add a check of the pointer 'meta' to avoid NULL pointer
> dereference. The patch brings three changes:
>
> 1. Add checks in both kfence_free() and __kfence_free();
> 2. kfence_free is not inline function any longer and new inline
>    function '__try_free_kfence_meta' is introduced.

This is very bad for performance (see below).

> 3. The check of is_kfence_address() is not required for
> __kfence_free() now because __kfence_free has done the check in
> addr_to_metadata();
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Is this a static analysis robot? Please show a real stack trace with
an actual NULL-deref.

Nack - please see:
https://lore.kernel.org/all/CANpmjNO5-o1B9r2eYS_482RBVJSyPoHSnV2t+M8fJdFzBf6d2A@mail.gmail.com/

> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  include/linux/kfence.h | 10 ++--------
>  mm/kfence/core.c       | 30 +++++++++++++++++++++++++++---
>  2 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 726857a4b680..fbf6391ab53c 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -160,7 +160,7 @@ void *kfence_object_start(const void *addr);
>   * __kfence_free() - release a KFENCE heap object to KFENCE pool
>   * @addr: object to be freed
>   *
> - * Requires: is_kfence_address(addr)
> + * Requires: is_kfence_address(addr), but now it's unnecessary

(As an aside, something can't be required and be unnecessary at the same time.)

There's a reason it was designed this way - is_kfence_address() is
much cheaper than a full call.

>   * Release a KFENCE object and mark it as freed.
>   */
> @@ -179,13 +179,7 @@ void __kfence_free(void *addr);
>   * allocator's free codepath. The allocator must check the return value to
>   * determine if it was a KFENCE object or not.
>   */
> -static __always_inline __must_check bool kfence_free(void *addr)
> -{
> -       if (!is_kfence_address(addr))
> -               return false;
> -       __kfence_free(addr);
> -       return true;
> -}
> +bool __must_check kfence_free(void *addr);

There's a reason is_kfence_address() is inline here, because this
function is actually called in relatively hot paths, and a simple
load+cmp is much cheaper than a call!

>  /**
>   * kfence_handle_page_fault() - perform page fault handling for KFENCE pages
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 6e69986c3f0d..1405585369b3 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -1048,10 +1048,10 @@ void *kfence_object_start(const void *addr)
>         return meta ? (void *)meta->addr : NULL;
>  }
>
> -void __kfence_free(void *addr)
> -{
> -       struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
>
> +/* Require: meta is not NULL*/
> +static __always_inline void __try_free_kfence_meta(struct kfence_metadata *meta)
> +{
>  #ifdef CONFIG_MEMCG
>         KFENCE_WARN_ON(meta->objcg);
>  #endif
> @@ -1067,6 +1067,30 @@ void __kfence_free(void *addr)
>                 kfence_guarded_free(addr, meta, false);
>  }
>
> +void __kfence_free(void *addr)
> +{
> +       struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> +
> +       if (!meta) {
> +               kfence_report_error(addr, false, NULL, NULL, KFENCE_ERROR_INVALID);
> +               return;
> +       }
> +
> +       __try_free_kfence_meta(meta);
> +}
> +
> +bool __must_check kfence_free(void *addr)
> +{
> +       struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> +
> +       if (!meta)
> +               return false;
> +
> +       __try_free_kfence_meta(meta);
> +
> +       return true;
> +}
> +
>  bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs *regs)
>  {
>         const int page_index = (addr - (unsigned long)__kfence_pool) / PAGE_SIZE;
> --
> 2.25.1
>
