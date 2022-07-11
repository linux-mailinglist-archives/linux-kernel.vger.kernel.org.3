Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4FC570469
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiGKNgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGKNgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:36:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9285732DA9;
        Mon, 11 Jul 2022 06:36:32 -0700 (PDT)
Received: from mail-yb1-f181.google.com ([209.85.219.181]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1JJC-1o9Fgq37X8-002rHW; Mon, 11 Jul 2022 15:36:30 +0200
Received: by mail-yb1-f181.google.com with SMTP id y195so8798548yby.0;
        Mon, 11 Jul 2022 06:36:30 -0700 (PDT)
X-Gm-Message-State: AJIora+MHLcxvDz7arGYC29Vqqc1ZGJC0Y2KjeacpDKzlPAZbNylK54/
        G4S76UBaxbXMhsw54xF5em4LtDfnstN4caflgTo=
X-Google-Smtp-Source: AGRyM1tvmyWfjf82f5DfzmUlldR8SOU5epceJ5HO7+gjgCpS/5zLrbpHMFqt2IKVqyew31oGn0XpM/p2gIWyEDNyGSY=
X-Received: by 2002:a5b:b47:0:b0:66e:3617:d262 with SMTP id
 b7-20020a5b0b47000000b0066e3617d262mr16460264ybr.106.1657546589339; Mon, 11
 Jul 2022 06:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-2-me@linux.beauty>
In-Reply-To: <20220711122459.13773-2-me@linux.beauty>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Jul 2022 15:36:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1WbJSWHsfegTtLhzSRwAoN8WfdezTTedRk9-FCiM8+GA@mail.gmail.com>
Message-ID: <CAK8P3a1WbJSWHsfegTtLhzSRwAoN8WfdezTTedRk9-FCiM8+GA@mail.gmail.com>
Subject: Re: [PATCH 1/4] of: add struct page support to rmem
To:     Li Chen <me@linux.beauty>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+vSjRl9oSi/iE1EbjAqxe1rh3a2TRjOncdk46lDtTdWea5l0MIM
 t8yIi6JNbiNrhQtaCvubdvxVQ2E03qKvNkj90z8j8DgEPZeDcKVydG9mvptN0/W+UWzD9D9
 c8qsQB7ck8BrM8AJ7CG00OrCyMaa6BkjV/6SlYF21HCqC52uKHn9nvasgnUxzUtHxZhHA8s
 iF2Lwk/IDj4yPFdkoqT2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yWJtuEELCNY=:XS8tS57yqii7qh54aSKa63
 5DMySW79XjC3t2Zu9CGaXpEtXm+HyMgtagXxKDF6q8mhREkJiATr05UA7PMe2jHp7UX9NuipQ
 29FwW6h+c7QgmI/xI5jSbDBisLbMkxnHfr0eVP+rtFKxWIanl3fKKKzom5sNfMOHWByvegS6e
 Rgwi66x9/WFgsNFLqy2w5AABcXHWVN/0y4/J3Sv+4bouUPKy2yUngumSqsQKQQVf/kEBU0Q6J
 q1yB/SELvY6PJv2fRHxpoVVGqracx1D6Zyh8hV0ZYdcUnG1bgTfB4BWyLC/0s3evdWhvnhb4i
 fsgvXI6wGGKChPS0tQ8Pju445hKFk/QERXbhXrLYOK1i1ixgF0WxGQyGxeg0B6uApGGMueXHt
 hCBkPi00SD7NWqKA18pIq2KY35ZKQVQyo83eFC5cVxhIzfhTFmTN+mocJ9x1Twz0NWYU/DU0W
 0foVmExr2n68CznVh0F3I/x/ohfR26yN6UKI8V9KUVJYdbosi/aEiI65l0pu5unFO4GGoI91x
 9Rs/paVHxMMWpqPvDWt5ZuBQ8rarj6knt1QOIeGOsSv/PuL6LdoT437CtlRCOpeVbSKYh91K7
 0vQMUqkGiD8z2/Gj9vMzg7qeBMUc7F33/hAFk6ZPeK2O9imXFj0kWtWjWx7UoybeVpXcKI0E0
 Ux16JJ52Z87yIltKa/W5Vix2xwOnbC5gLwU57Ro9N5p5rivZLXgzV5rBvq8v1de/CL01GyxBW
 OlUH5vfLFLL3x2ZbAnKr8umRo9NZXeSj53MMPwUPmAyymZLw3aDQFqqtEnaUvDAZqM0bdu1WJ
 M0BAvgmjZl2QcdZ8TPqCmAF0MEL3MQkFoDQXI/qWAC4KxKeu4aw0Sy1vSpteR45W7soRj+kNc
 nSmu3Jk2Q3HNs+EaN88g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:

> +config OF_RESERVED_MEM_DIO_SUPPORT
> +       bool "add Direct I/O support to reserved_mem"
> +       depends on ZONE_DEVICE && ARCH_KEEP_MEMBLOCK
> +       help
> +          By default, reserved memory don't get struct page support, which
> +                means you cannot do Direct I/O from this region. This config takes
> +                uses of ZONE_DEVICE and treats rmem as hotplug mem to get struct
> +                page and DIO support.

This probably does not need to be user visible, it's enough to select it from
the drivers that need it.

> @@ -72,7 +72,6 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
>         rmem->size = size;
>
>         reserved_mem_count++;
> -       return;
>  }

This change is not wrong, but it does not belong into the same patch
as the rest, just drop it.

> +/**
> + * get_reserved_mem_from_dev() - get reserved_mem from a device node
> + * @dev: device pointer
> + *
> + * This function look for reserved_mem from given device.
> + *
> + * Returns a reserved_mem pointer, or NULL on error.
> + */
> +struct reserved_mem *get_reserved_mem_from_dev(struct device *dev)
> +{
> +       struct device_node *np = dev_of_node(dev);
> +       struct device_node *rmem_np;
> +       struct reserved_mem *rmem = NULL;
> +
> +       rmem_np = of_parse_phandle(np, "memory-region", 0);
> +       if (!rmem_np) {
> +               dev_err(dev, "failed to get memory region node\n");
> +               return ERR_PTR(-ENODEV);
> +       }
> +
> +       rmem = of_reserved_mem_lookup(rmem_np);
> +       if (!rmem) {
> +               dev_err(dev, "Failed to lookup reserved memory\n");
> +               return ERR_PTR(EINVAL);

This needs to be a negative error code rather than the positive EINVAL.
No need to initialize rmem=NULL first if you override it here.

> +       if (likely(reserved_mem_dio_in_region(pfn << PAGE_SHIFT, PAGE_SIZE, rmem) <
> +                  0))
> +               goto out;

It's not performance critical, so just drop the 'likely()' and put the
rest into one line.


> +       if (page) {
> +               *page = pfn_to_page(pfn);
> +               get_page(*page);
> +       }
> +
> +       ret = 0;
> +
> +out:
> +       pte_unmap(pte);
> +       return ret;
> +}

Should you perhaps return an error when 'page' is NULL?

> +#ifdef CONFIG_OF_RESERVED_MEM_DIO_SUPPORT
> +int reserved_mem_dio_mmap(struct file *file, struct vm_area_struct *vma, struct reserved_mem *rmem);
> +void *reserved_mem_memremap_pages(struct device *dev, struct reserved_mem *rmem);
> +#endif

The '#ifdef' check can be dropped here, declarations are normally
not hidden like this.

         Arnd
