Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA45486D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbiAFWlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245175AbiAFWlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:41:51 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F77C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 14:41:51 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id p8-20020a9d7448000000b005907304d0c5so4739113otk.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 14:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=M/V4Wjfyo18bTikH9NYxnHYJO0tsMqyd6tXw2lTn6vE=;
        b=EXHsoUeH66JqaH2HpGhkYwFCU2FRBAYpJaRuLID26wTTZpoZMfXI6MmZw22roIu2Uq
         2tul1PjvFEzOp4d8uBKxlUJdkzsi8Sb5oITtEpmDvlJE7QVisyRxC5twRyythq3LygCm
         Csq325cn22hhhPBguna4xuZynn5ka3rjxrFNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=M/V4Wjfyo18bTikH9NYxnHYJO0tsMqyd6tXw2lTn6vE=;
        b=Rim/EAeOgA0vPkpP0Bj/6Ha3fo1XzJRvATUqW8gdwK4OyPaQv4UWQbxdGepdkUqveZ
         a+Hemyv+R/u7xBwpIA0glkVYLnvkw4kVDxJSpCXfvDrybWsApKvLlLQEwuACLCPu9LDm
         rMULK+K5JMrqf7cdmjWD7zOjN0KInKvlhXIkNdU/MFc+z4Xp0CxUU0M5MTp8GpmYwP9x
         ydOOMPrIxgkbaX2j4PyuBDhCVOBi6X6CyvxUJHRQjhJYCpvS0kZAiQsJx1KsX9wFKdbZ
         +XkqMgDk4LinZ+b9/ZhbiekQzsRsqMhIyy5gyWz6gAj9pnmBKV3qK37uCbcJ+5/I9ctG
         jeLg==
X-Gm-Message-State: AOAM530Q/g6HQkV/PS/awBtNkD0XKuzdPr1q7w5rgHxm6gPRVm9YgxLz
        hp//NdZzwM/XiQcPQsmfmLilFRdbcxRS1mWckhc9bw==
X-Google-Smtp-Source: ABdhPJwSwJ6XcLmL5YtElFS860gXojQ9PDX3GJYQjIGZ1zbMIid3zSRnWo+YF56+Z5tPopUGo8u4R88Et+bubSDlEec=
X-Received: by 2002:a9d:1a6:: with SMTP id e35mr3633790ote.77.1641508910884;
 Thu, 06 Jan 2022 14:41:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jan 2022 14:41:50 -0800
MIME-Version: 1.0
In-Reply-To: <Ybt2FlgxnuNdZV68@kernel.org>
References: <20211215195354.634746-1-swboyd@chromium.org> <Ybt2FlgxnuNdZV68@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 6 Jan 2022 14:41:50 -0800
Message-ID: <CAE-0n512KdseK72bf0HgV4SP7+szydap1X2jWzE1eNYP0dCBgw@mail.gmail.com>
Subject: Re: [PATCH v3] of/fdt: Don't worry about non-memory region overlap
 for no-map
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Rapoport (2021-12-16 09:23:34)
> On Wed, Dec 15, 2021 at 11:53:54AM -0800, Stephen Boyd wrote:
> > In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> > already reserved regions") we returned -EBUSY when trying to mark
> > regions as no-map when they're in the reserved memory node. This if
> > condition will still trigger though if the DT has a /memreserve/ that
> > completely subsumes the no-map memory carveouts in the reserved memory
> > node. Let's only consider this to be a problem if we're trying to mark a
> > region as no-map and it is actually memory. If it isn't memory,
> > presumably it was removed from the memory map via /memreserve/ and thus
> > can't be mapped anyway.
>
> I don't see /memreserve/ removing memory from anywhere. What do you
> mean here?

I mean that memory in /memreserve/ is marked as reserved via
early_init_fdt_scan_reserved_mem() calling
early_init_dt_reserve_memory_arch(). I failed to mention that this
region isn't part of the memory the DT tells us exists in the /memory
node. That's the real problem. My bootloader is trying to be helpful and
removing a range of memory that shouldn't be mapped from the /memory
node.

 localhost ~ # hexdump /sys/firmware/devicetree/base/memory/reg
 0000000 0000 0000 0080 0000 0000 0000 8000 0000
 0000010 0000 0000 c080 0000 0000 0000 207f 0000
 0000020 0000 0100 0000 0000 0000 0100 0080 0000

Another solution would be to remove 'no-map' from the reserved memory
nodes that overlap with the /memreserve/ ranges. I'd rather not do that
though in case the bootloader that injects the /memreserve/ and fills in
the 'reg' property of the /memory node decides to stop doing that. It
also doesn't really make sense that no-map would care if the region
isn't memory to start with because the property is telling us to skip
mapping that region of memory into the kernel's direct mapping. By
definition if it isn't in /memory it won't be mapped anyway.

Let me reword this to be more precise. How about this?

----8<----

In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
already reserved regions") we returned -EBUSY when trying to mark
regions as no-map when they intersect with reserved memory. The goal was
to find bad no-map reserved memory DT nodes that would unmap the kernel
text/data sections.

The problem is the reserved memory check will still trigger if the DT
has a /memreserve/ that completely subsumes the no-map memory carveouts
in the reserved memory node _and_ that region is also not part of the
memory reg property. For example in sc7180.dtsi we have the following
reserved-memory and memory node:

      memory@80000000 {
          /* We expect the bootloader to fill in the size */
          reg = <0 0x80000000 0 0>;
      };

      smem_mem: memory@80900000 {
              reg = <0x0 0x80900000 0x0 0x200000>;
              no-map;
      };

and the memreserve filled in by the bootloader is

      /memreserve/ 0x80800000 0x400000;

while the /memory node is transformed into

      memory@80000000 {
          /* The bootloader fills in the size, and adds another region */
          reg = <0 0x80000000 0 0x00800000>,
	        <0 0x80c00000 0 0x7f200000>;
      };

The smem region is doubly reserved via /memreserve/ and by not being
part of the /memory reg property. This leads to the following warning
printed at boot.

 OF: fdt: Reserved memory: failed to reserve memory for node
'memory@80900000': base 0x0000000080900000, size 2 MiB

Otherwise nothing really goes wrong because the smem region is not going
to be mapped by the kernel's direct linear mapping given that it isn't
part of the memory node. Therefore, let's only consider this to be a
problem if we're trying to mark a region as no-map and it is actually
memory that we're intending to keep out of the kernel's direct mapping
but it's already been reserved.

---8<----

> >
> > Changes from v2 (https://lore.kernel.org/r/20211215072011.496998-1-swboyd@chromium.org):
> >  * More details in commit text
> >
> > Changes from v1 (https://lore.kernel.org/r/20210520012731.3731314-1-swboyd@chromium.org):
> >  * Use memblock_overlaps_region instead of memblock_is_region_memory()
> >  * Add more details to commit text
> >
> >  drivers/of/fdt.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index bdca35284ceb..c736e5bcc2f6 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -482,9 +482,11 @@ static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
> >       if (nomap) {
> >               /*
> >                * If the memory is already reserved (by another region), we
> > -              * should not allow it to be marked nomap.
> > +              * should not allow it to be marked nomap, but don't worry
> > +              * if the region isn't memory as it won't be mapped.
> >                */
> > -             if (memblock_is_region_reserved(base, size))
> > +             if (memblock_overlaps_region(&memblock.memory, base, size) &&
> > +                 memblock_is_region_reserved(base, size))
>
> Apparently I'm missing something, but sc7180.dtsi has memory @80000000 and I
> cannot find anything that calls memblock_remove() in DT processing.
>
> How is that memory@80900000 does not overlap with memblock.memory?
>

There's no size filled in for the sc7180.dtsi file.
