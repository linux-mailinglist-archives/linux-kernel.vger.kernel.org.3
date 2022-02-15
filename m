Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81B64B7637
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbiBOQtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:49:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239641AbiBOQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:49:00 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9951AC12F9;
        Tue, 15 Feb 2022 08:48:50 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id o10so15304125ilh.0;
        Tue, 15 Feb 2022 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVNa8VSn91ahuDas6Q5c0c7M86VbUIOrBrr7Lsj6DYI=;
        b=PJDVFdbVGvtaA9kJk1qSkNbj2TZJQK5Mesv4NIHxeYbJjjsrvieJhKSRKVXt6TY5qE
         liHaAXttXZkNvNs1PuyLiH5sYg3h7nVrZTs/mbhPPbQIEu98CvEiHYU4MoLF7eZlXo02
         OOV2CBDh3w0126BeK/5eIbxlEmvYr4Xs8bfZaVeS9IX/k9xlrXHL/i7XSE6lOB8CsFou
         f+HwKwGMZLBvxkr1l+9WBL6JIebLLsTnOIXNVGoFQbxPgu3BI93LHZyoT61o3C4xQj+g
         S4onaRA3VmSZqMXHYDDXcsGNiV/OW7jzV3v/escGendjwkt2o8Ko874lbpHrzRnToXht
         Mytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVNa8VSn91ahuDas6Q5c0c7M86VbUIOrBrr7Lsj6DYI=;
        b=jH+7fT2muAmEgfCkZ2zmlChMJc3M/aBDqzpB4Yg5vTW14R+hRR7JvIbww6N7M1sLZa
         i8FLsuXwusM++e1aOmJUNEs9em+M4AFH+csnELKBQuyxnSmD7vt627As9L0BCj/IPn1l
         kfrE8g+jEVe8VpLXLnqPINzH/naXtonD46nHMjo7Nfy6pSOCcN7y2qv/gBZWWwD5uRhF
         EG6kGOkc6LeshjlSpi7KdRFuzxrIoTj0YoNw+ge6tNl9MNZw/WRpJ709uVrwCgYKEJpz
         5NFDBqRSsN505EdLEWK+kdlANiE05z7Lcn1RXjzC1WSNggbXDoftwKJvZFh5/mck1fsP
         ZM5Q==
X-Gm-Message-State: AOAM5308nqnrM74sDjL4/TuQoahUp7f8mlM+zGzru6oXnZ1PDHIQS+0f
        DGeg58XX72ZEctOQJOao8JH3xN4nrWXpbBhYSdzpfgsu9uShBqd4/Eo=
X-Google-Smtp-Source: ABdhPJzymnqvOR8CKBiej0duKzd4TqeQtGYPKBaMhp/OB51xLEndFfIOeke7AoujuH13SWODXChgu1WA4elZudT6SiM=
X-Received: by 2002:a05:6e02:1887:: with SMTP id o7mr3086428ilu.169.1644943729176;
 Tue, 15 Feb 2022 08:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20220211001345.3429572-1-gch981213@gmail.com>
In-Reply-To: <20220211001345.3429572-1-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 16 Feb 2022 00:48:38 +0800
Message-ID: <CAJsYDVLyasPAmgxguqLznORC2SihKHRLrFFw5nHbepJvu0va3Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: mt7621: do memory detection on KSEG1
To:     linux-mips@vger.kernel.org
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi!

On Fri, Feb 11, 2022 at 8:14 AM Chuanhong Guo <gch981213@gmail.com> wrote:
>
> It's reported that current memory detection code occasionally detects
> larger memory under some bootloaders.
> Current memory detection code tests whether address space wraps around
> on KSEG0, which is unreliable because it's cached.
>
> Rewrite memory size detection to perform the same test on KSEG1 instead.
> While at it, this patch also does the following two things:
> 1. use a fixed pattern instead of a random function pointer as the magic
>    value.
> 2. add an additional memory write and a second comparison as part of the
>    test to prevent possible smaller memory detection result due to
>    leftover values in memory.
>
> Fixes: 139c949f7f0a MIPS: ("ralink: mt7621: add memory detection support")

I misplaced a bracket in this Fixes tag.

> Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>  arch/mips/ralink/mt7621.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index d6efffd4dd20..12c8808e0dea 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -22,7 +22,9 @@
>
>  #include "common.h"
>
> -static void *detect_magic __initdata = detect_memory_region;
> +#define MT7621_MEM_TEST_PATTERN         0xaa5555aa
> +
> +static u32 detect_magic __initdata;
>
>  int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  {
> @@ -58,24 +60,32 @@ phys_addr_t mips_cpc_default_phys_base(void)
>         panic("Cannot detect cpc address");
>  }
>
> +static bool __init mt7621_addr_wraparound_test(phys_addr_t size)
> +{
> +       void *dm = (void *)KSEG1ADDR(&detect_magic);
> +
> +       if (CPHYSADDR(dm + size) >= MT7621_LOWMEM_MAX_SIZE)
> +               return true;
> +       __raw_writel(MT7621_MEM_TEST_PATTERN, dm);
> +       if (__raw_readl(dm) != __raw_readl(dm + size))
> +               return false;
> +       __raw_writel(!MT7621_MEM_TEST_PATTERN, dm);

Someone on Github notified me that this second test pattern is incorrect.
I actually mean to use ~MT7621_MEM_TEST_PATTERN here.

I'll send a v2 fixing both issues.

--
Regards,
Chuanhong Guo
