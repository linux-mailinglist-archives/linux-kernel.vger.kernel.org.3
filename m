Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2183583973
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiG1HZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiG1HZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:25:04 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B965FACC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:25:00 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o15so1914617yba.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqbTPnu/pF8QmgHbRP8i1nrgyN4MT+vnZXxtlSHsiqQ=;
        b=VewyJ/sVeC7InlsSQY+xSUTa3nYrK8MeWNU/9DRxadnqc/Klin7RZ7b71WD6zlS2qb
         /nybS4oInzn2EGTy+/E02X8xhsa0HA8nTuSZsctgnQ+XmmvHvZFTsKVOaosYzrNAAcxS
         FPWCC72qMO2O8aTQJmy/lY8e/IGlEDhNGyMgetbi5iHGwmFKZCnuNm0+LGYGOVFHoGga
         KXX4Rx6hCU8wMcSV/LR80VISzczb6RuvO2SEpRdDMQjBn64uU2o6JPkG3umiAD58iUKP
         jb2zQtO7XY0861h1sKzxtzaxxScD6uMiCvjF2N4V87x5YxxrY0WE6FzcefRo0+wkCck4
         Wr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqbTPnu/pF8QmgHbRP8i1nrgyN4MT+vnZXxtlSHsiqQ=;
        b=Ur7PaHXbv1Ox/Ny08BvAqCt4jhJU+BmM9IgNScS5j1N2fJtwZ48txPOuDohrCR5tH8
         3O53DKYCImIvVXvMl3lLL+vTS4RaIzlRb5EJu3Z2yujOaU+BMzWB73C1c3KWqqLd6IiX
         MK29JKQZtAEUFrDSjTZ6OUYR5zFFrEy3pP6A+2vYuyKFpF54K6+3KvupGbiqAIpE7t6v
         hwSPoPERygUkNIn0OdJ6USNyfwl0yAneRLSf2ZGNCa14zXQpl4IxcHsc4qMryDloQvTp
         3GpNbKEAexyQylNYowWmEeR3O8z27IZA3uKwXkbkmZ3q8evYrUF6jwSET0b33JDMfEsM
         rgMg==
X-Gm-Message-State: AJIora9oQ7wX7c32ZaJ0eQclx2zQOpgBlpKzSwX/9bCYWr6Xd+eh+rTI
        JewZcox7OWg/EHjbuQIf70myZQq4MizwHUf219R8nA==
X-Google-Smtp-Source: AGRyM1tUJyUp0XN9AAL3dwtyYS4a1TOP3kLFuLBQARCl6OlLfC+vDA9Li4tyxFcSLMMsGMGXivCQSd3FWYtWgFVlFH0=
X-Received: by 2002:a25:ad16:0:b0:671:75d9:6aad with SMTP id
 y22-20020a25ad16000000b0067175d96aadmr7997719ybi.143.1658993099072; Thu, 28
 Jul 2022 00:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220727234241.1423357-1-imran.f.khan@oracle.com>
In-Reply-To: <20220727234241.1423357-1-imran.f.khan@oracle.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 28 Jul 2022 09:24:22 +0200
Message-ID: <CANpmjNNmD9z7oRqSaP72m90kWL7jYH+cxNAZEGpJP8oLrDV-vw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/kfence: Introduce kernel parameter for selective
 usage of kfence.
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     glider@google.com, dvyukov@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 at 01:43, Imran Khan <imran.f.khan@oracle.com> wrote:
>
> By default kfence allocation can happen for any slub object, whose size

s/slub object/slab object/

> is up to PAGE_SIZE, as long as that allocation is the first allocation
> after expiration of kfence sample interval. But in certain debugging
> scenarios we may be interested in debugging corruptions involving
> some specific slub objects like dentry or ext4_* etc. In such cases
> limiting kfence for allocations involving only specific slub objects
> will increase the probablity of catching the issue since kfence pool
> will not be consumed by other slub objects.

Have you seen this happen? The "skip already covered allocations"
feature should take care of most of these issues filling up the pool.
Have you tried adjusting kfence.skip_covered_thresh?

Or put another way: with your patch, have you been able to debug an
issue you haven't before? Typically this is not how KFENCE is meant to
be used if you know there's an issue; at that point your best bet is
to build a KASAN kernel and boot that. Of course that may not always
be possible, but there are other knobs you can tweak
(kfence.sample_interval, kfence.skip_covered_thresh).

Your patch only makes sense in a "manual debugging" scenario, and not
quite what KFENCE was designed for (deployment at scale).

> This patch introduces a kernel parameter slub_kfence that can be used
> to specify a comma separated list of slabs for which kfence allocations
> will happen. Also introduce a sysfs parameter that can be used to re-enable
> kfence for all slabs.
>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> ---
>
> I am also working on getting kfence enabled for specific slabs using
> /sys/kernel/slab/<slab_name>/kfence interface but in the meanwhile
> I am sharing this RFC patch to get some early feedback. Especially
> if this feature makes sense or if there is any better/existing way to
> achieve similar end results.

Do you need the slab restriction from boot? Because if not, I'd much
rather prefer the /sys/kernel/slab/<slab>/.. option; in that case,
it'd also be easier to flip the slab flag to SLAB_SKIP_KFENCE, and
none of the "kfence_global_alloc_enabled" code is needed.

Then if you want to only enable KFENCE for a few select slab caches,
from user space you just write 1 to all
/sys/kernel/slab/<slab>/skip_kfence, and leave them 0 where you want
KFENCE to do allocations.

>  .../admin-guide/kernel-parameters.txt         |  5 ++
>  include/linux/kfence.h                        |  1 +
>  include/linux/slab.h                          |  6 ++
>  mm/kfence/core.c                              | 86 +++++++++++++++++++
>  mm/slub.c                                     | 47 ++++++++++
>  5 files changed, 145 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 98e5cb91faab..d66f555df7ba 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5553,6 +5553,11 @@
>                         last alloc / free. For more information see
>                         Documentation/mm/slub.rst.
>
> +       slub_kfence[=slabs][,slabs]]...]        [MM, SLUB]
> +                       Specifies the slabs for which kfence debug mechanism
> +                       can be used. For more information about kfence see
> +                       Documentation/dev-tools/kfence.rst.
> +
>         slub_max_order= [MM, SLUB]
>                         Determines the maximum allowed order for slabs.
>                         A high setting may cause OOMs due to memory
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 726857a4b680..140fc4fe87e1 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -125,6 +125,7 @@ static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp
>  #endif
>         if (likely(atomic_read(&kfence_allocation_gate)))
>                 return NULL;
> +

Why this whitespace change?

>         return __kfence_alloc(s, size, flags);
>  }
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0fefdf528e0d..b0def74d9fa1 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -119,6 +119,12 @@
>   */
>  #define SLAB_NO_USER_FLAGS     ((slab_flags_t __force)0x10000000U)
>
> +#ifdef CONFIG_KFENCE
> +#define SLAB_KFENCE            ((slab_flags_t __force)0x20000000U)
> +#else
> +#define SLAB_KFENCE            0
> +#endif

Consider flipping this around and making this SLAB_SKIP_KFENCE, which
would be more intuitive.

>  /* The following flags affect the page allocator grouping pages by mobility */
>  /* Objects are reclaimable */
>  #define SLAB_RECLAIM_ACCOUNT   ((slab_flags_t __force)0x00020000U)
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index c252081b11df..017ea87b495b 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -132,6 +132,8 @@ DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
>  /* Gates the allocation, ensuring only one succeeds in a given period. */
>  atomic_t kfence_allocation_gate = ATOMIC_INIT(1);
>
> +/* Determines if kfence allocation happens only for selected slabs. */
> +atomic_t kfence_global_alloc = ATOMIC_INIT(1);

This does not need to be atomic (kfence_allocation_gate is atomic
because it needs to increment), just use normal
READ_ONCE()/WRITE_ONCE() on an ordinary bool. But I'd also prefer if
we don't need any of this if you go with the SLAB_SKIP_KFENCE version.

>  /*
>   * A Counting Bloom filter of allocation coverage: limits currently covered
>   * allocations of the same source filling up the pool.
> @@ -1003,6 +1005,14 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>                 return NULL;
>         }
>
> +       /*
> +        * Skip allocation if kfence has been enable for selected slabs
> +        * and this slab is not one of the selected slabs.
> +        */
> +       if (unlikely(!atomic_read(&kfence_global_alloc)
> +                   && !(s->flags & SLAB_KFENCE)))
> +               return NULL;
> +
>         if (atomic_inc_return(&kfence_allocation_gate) > 1)
>                 return NULL;
>  #ifdef CONFIG_KFENCE_STATIC_KEYS
> @@ -1156,3 +1166,79 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
>
>         return kfence_unprotect(addr); /* Unprotect and let access proceed. */
>  }
> +
> +#ifdef CONFIG_SYSFS
> +static ssize_t kfence_global_alloc_enabled_show(struct kobject *kobj,
> +                                         struct kobj_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", atomic_read(&kfence_global_alloc));
> +}

Why do you want to make this a sysfs param? Have a look at the top of
the file where we add parameters via module_param(). These can be
written at runtime as well as specified as a kernel command line
param.

> +static ssize_t kfence_global_alloc_enabled_store(struct kobject *kobj,
> +                                          struct kobj_attribute *attr,
> +                                          const char *buf, size_t count)
> +{
> +       struct kmem_cache *s;
> +       ssize_t ret;
> +       int val;
> +
> +       ret = kstrtoint(buf, 10, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val != 1)
> +               return -EINVAL;
> +
> +       atomic_set(&kfence_global_alloc, val);
> +
> +       /*
> +        * If kfence is re-enabled for all slabs from sysfs, disable
> +        * slab specific usage of kfence.
> +        */
> +       mutex_lock(&slab_mutex);
> +       list_for_each_entry(s, &slab_caches, list)
> +               if (s->flags & SLAB_KFENCE)
> +                       s->flags &= ~SLAB_KFENCE;
> +       mutex_unlock(&slab_mutex);
> +
> +       return count;
> +}
> +
> +static struct kobj_attribute kfence_global_alloc_enabled_attr =
> +       __ATTR(kfence_global_alloc_enabled,
> +              0644,
> +              kfence_global_alloc_enabled_show,
> +              kfence_global_alloc_enabled_store);
> +
> +static struct attribute *kfence_attrs[] = {
> +       &kfence_global_alloc_enabled_attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group kfence_attr_group = {
> +       .attrs = kfence_attrs,
> +};
> +
> +static int __init kfence_init_sysfs(void)
> +{
> +       int err;
> +       struct kobject *kfence_kobj;
> +
> +       kfence_kobj = kobject_create_and_add("kfence", mm_kobj);
> +       if (!kfence_kobj) {
> +               pr_err("failed to create kfence_global_alloc_enabled kobject\n");
> +               return -ENOMEM;
> +       }
> +       err = sysfs_create_group(kfence_kobj, &kfence_attr_group);
> +       if (err) {
> +               pr_err("failed to register numa group\n");

numa group?

> +               goto delete_obj;
> +       }
> +       return 0;
> +
> +delete_obj:
> +       kobject_put(kfence_kobj);
> +       return err;
> +}
> +subsys_initcall(kfence_init_sysfs);
> +#endif /* CONFIG_SYSFS */
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..7ee67ba5097c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -645,6 +645,7 @@ static slab_flags_t slub_debug;
>  #endif
>
>  static char *slub_debug_string;
> +static char *slub_kfence_list;
>  static int disable_higher_order_debug;
>
>  /*
> @@ -1589,6 +1590,27 @@ static int __init setup_slub_debug(char *str)
>
>  __setup("slub_debug", setup_slub_debug);
>
> +#ifdef CONFIG_KFENCE
> +extern atomic_t kfence_global_alloc;
> +
> +static int __init setup_slub_kfence(char *str)
> +{
> +       if (*str++ != '=' || !*str)
> +               return 1;
> +
> +       slub_kfence_list = str;
> +
> +       /*
> +        * Disable global kfence usage if specific slabs
> +        * were specified in bootargs.
> +        */
> +       atomic_set(&kfence_global_alloc, 0);
> +
> +       return 1;
> +}
> +__setup("slub_kfence", setup_slub_kfence);
> +#endif
> +
>  /*
>   * kmem_cache_flags - apply debugging options to the cache
>   * @object_size:       the size of an object without meta data
> @@ -1653,6 +1675,31 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>                 }
>         }
>
> +       /* Check if kfence has been enabled for this slab */
> +       iter = slub_kfence_list;
> +
> +       while (iter && *iter) {
> +               char *end, *glob;
> +               size_t cmplen;
> +
> +               end = strchrnul(iter, ',');
> +
> +               glob = strnchr(iter, end - iter, '*');
> +
> +               if (glob)
> +                       cmplen = glob - iter;
> +               else
> +                       cmplen = end - iter;
> +
> +               if (!strncmp(iter, name, cmplen))
> +                       flags |= SLAB_KFENCE;
> +
> +               if (!*end)
> +                       break;
> +
> +               iter = end + 1;
> +       }
> +
>         return flags | slub_debug_local;
>  }
>  #else /* !CONFIG_SLUB_DEBUG */
> --
> 2.30.2
>
