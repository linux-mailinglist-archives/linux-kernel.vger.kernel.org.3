Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0C570631
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiGKOvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGKOvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:51:23 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ADD6F7DE;
        Mon, 11 Jul 2022 07:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657551065; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CtOhyY8tw1d/3sC1XUFXtOgWlKyvIdoW1+4kYxFZPBOS86WIwkQcL+bzHtrnflgoXijSfWoyhOadbn59TeSSBMwLyvuxBCSGSwAFwHp9JzDcQfmViYYIHcRo6JCzzlgVwXNsHXuqnUDCo5/Rybxlf1r8mOaRtmTVIkihCQQpuRg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657551065; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=kHaUrv/fHFhGn0jk2BItTI4SaLYRb9P62fgiGu23lW0=; 
        b=XvF4T6aLrwrrGsw5UP+RkcsfIulaHMaROi9VSSV1xMz1fQntieMfF3f+6Cll8Asqw+SULPG8ltc0ZSmYhsQ0Urj2efjRQZSptsHAZ5SHKIBAHfKYEY3lCQXpru9UdRqSfKsvy8eyxZG3TsTw9PeLiSgwDk3/SGvR1101tT7OmkQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657551065;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=kHaUrv/fHFhGn0jk2BItTI4SaLYRb9P62fgiGu23lW0=;
        b=YHrBm/1VIbeMyvVrhtTMs7qWopIUA2LBW5p0ofgHxOThqYkebGQx02DCMLUTMCiJ
        C1giCpknR4Ce+lUkw81ZNB/qD60wodwSRfFiuzbCRanHvglfyN/NrWuOjeAmZBZmYxh
        2bwNNBgkDmKk5YSWzQSKmQ0F2mVpjjvXhOoVP+aw=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1657551064920476.90017022843904; Mon, 11 Jul 2022 07:51:04 -0700 (PDT)
Date:   Mon, 11 Jul 2022 22:51:04 +0800
From:   Li Chen <me@linux.beauty>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Li Chen" <lchen@ambarella.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "DTML" <devicetree@vger.kernel.org>,
        "Linux-MM" <linux-mm@kvack.org>
Message-ID: <181edbe0f3d.e1336ef3387914.4730240512950880256@linux.beauty>
In-Reply-To: <CAK8P3a1WbJSWHsfegTtLhzSRwAoN8WfdezTTedRk9-FCiM8+GA@mail.gmail.com>
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-2-me@linux.beauty> <CAK8P3a1WbJSWHsfegTtLhzSRwAoN8WfdezTTedRk9-FCiM8+GA@mail.gmail.com>
Subject: Re: [PATCH 1/4] of: add struct page support to rmem
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your review!
 ---- On Mon, 11 Jul 2022 21:36:12 +0800  Arnd Bergmann <arnd@arndb.de> wrote --- 
 > On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:
 > 
 > > +config OF_RESERVED_MEM_DIO_SUPPORT
 > > +       bool "add Direct I/O support to reserved_mem"
 > > +       depends on ZONE_DEVICE && ARCH_KEEP_MEMBLOCK
 > > +       help
 > > +          By default, reserved memory don't get struct page support, which
 > > +                means you cannot do Direct I/O from this region. This config takes
 > > +                uses of ZONE_DEVICE and treats rmem as hotplug mem to get struct
 > > +                page and DIO support.
 > 
 > This probably does not need to be user visible, it's enough to select it from
 > the drivers that need it.

When you say "user visible", do you mean the config can be dropped or something else like Kconfig type other than bool?

 > 
 > > @@ -72,7 +72,6 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 > >         rmem->size = size;
 > >
 > >         reserved_mem_count++;
 > > -       return;
 > >  }
 > 
 > This change is not wrong, but it does not belong into the same patch
 > as the rest, just drop it.
 > 
 > > +/**
 > > + * get_reserved_mem_from_dev() - get reserved_mem from a device node
 > > + * @dev: device pointer
 > > + *
 > > + * This function look for reserved_mem from given device.
 > > + *
 > > + * Returns a reserved_mem pointer, or NULL on error.
 > > + */
 > > +struct reserved_mem *get_reserved_mem_from_dev(struct device *dev)
 > > +{
 > > +       struct device_node *np = dev_of_node(dev);
 > > +       struct device_node *rmem_np;
 > > +       struct reserved_mem *rmem = NULL;
 > > +
 > > +       rmem_np = of_parse_phandle(np, "memory-region", 0);
 > > +       if (!rmem_np) {
 > > +               dev_err(dev, "failed to get memory region node\n");
 > > +               return ERR_PTR(-ENODEV);
 > > +       }
 > > +
 > > +       rmem = of_reserved_mem_lookup(rmem_np);
 > > +       if (!rmem) {
 > > +               dev_err(dev, "Failed to lookup reserved memory\n");
 > > +               return ERR_PTR(EINVAL);
 > 
 > This needs to be a negative error code rather than the positive EINVAL.
 > No need to initialize rmem=NULL first if you override it here.
 > 
 > > +       if (likely(reserved_mem_dio_in_region(pfn << PAGE_SHIFT, PAGE_SIZE, rmem) <
 > > +                  0))
 > > +               goto out;
 > 
 > It's not performance critical, so just drop the 'likely()' and put the
 > rest into one line.
 > 
 > 
 > > +       if (page) {
 > > +               *page = pfn_to_page(pfn);
 > > +               get_page(*page);
 > > +       }
 > > +
 > > +       ret = 0;
 > > +
 > > +out:
 > > +       pte_unmap(pte);
 > > +       return ret;
 > > +}
 > 
 > Should you perhaps return an error when 'page' is NULL?
 > 
 > > +#ifdef CONFIG_OF_RESERVED_MEM_DIO_SUPPORT
 > > +int reserved_mem_dio_mmap(struct file *file, struct vm_area_struct *vma, struct reserved_mem *rmem);
 > > +void *reserved_mem_memremap_pages(struct device *dev, struct reserved_mem *rmem);
 > > +#endif
 > 
 > The '#ifdef' check can be dropped here, declarations are normally
 > not hidden like this.
 > 
 >          Arnd
 > 

These will be fixed in v2.

Regards,
Li
