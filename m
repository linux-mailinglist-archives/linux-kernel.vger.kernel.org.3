Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364ED475A68
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbhLOOQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243238AbhLOOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:16:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B1C061574;
        Wed, 15 Dec 2021 06:16:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4F1AB81F2B;
        Wed, 15 Dec 2021 14:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508B2C34604;
        Wed, 15 Dec 2021 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639577802;
        bh=+nz7RZhA7PNYQ3kHJ5aSxlmtw3+mRphPVl6qCtqz4g8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rF3t5+EPP3FurVZG4kPwI4Cjsm1uNzFsg4t54faS6x5eg+/+IHAu9VduWBJjHz3yB
         Ju1YMFtJ8gLSTIzV33N0dJ2JBl2u7DrqHRgSnKX6EuKzpClp2id+1q2/KtNERtAxes
         cZjphA/0QNdZdAP4yFzlkOtSFAw0X2fbhUPcdWIl9+Sk0k8W40TPzDXKn2AB4/tuOC
         xHgOGW3NG3JS0cKLddPwIzoBQLN1b6rcAgmYW8LgZ9D5bGcJa1Mt3nE8mAKLm/PBIj
         DjxTPDGrAj6mbqoO0F8Ak6bOG1+f3PhDTIxJE9578t+FjD1RARU+mJvLf/BmPErL15
         FFLHadL4IUmow==
Received: by mail-ed1-f53.google.com with SMTP id b7so16085913edd.6;
        Wed, 15 Dec 2021 06:16:42 -0800 (PST)
X-Gm-Message-State: AOAM5332tJUNYkMXLTqL1dxOBlwN5TeT6fOLJyh6apvoMjOCitbwEcPw
        wDypHOB5p2Fh0eQPiyoUILjG2rwvEqUlpQX2QQ==
X-Google-Smtp-Source: ABdhPJy5cKCi6PavSzQ3HfyWq+w3HuOgZ4cI+2hIjfFBbkxg5Vxy0bdMbVrRZj4aBX6HGwMRz8xJYLa8EKkug7BCiHM=
X-Received: by 2002:a17:907:94c2:: with SMTP id dn2mr10770171ejc.325.1639577800600;
 Wed, 15 Dec 2021 06:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20211214202652.3894707-1-robh@kernel.org> <871r2emazp.fsf@mpe.ellerman.id.au>
In-Reply-To: <871r2emazp.fsf@mpe.ellerman.id.au>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Dec 2021 08:16:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+gFrL1EjjTEYAtk=XHXPBWn070n7CjycULx2tG987oGw@mail.gmail.com>
Message-ID: <CAL_Jsq+gFrL1EjjTEYAtk=XHXPBWn070n7CjycULx2tG987oGw@mail.gmail.com>
Subject: Re: [PATCH v3] of/fdt: Rework early_init_dt_scan_memory() to call directly
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 4:13 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Rob Herring <robh@kernel.org> writes:
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 5e216555fe4f..97d7607625ec 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1078,49 +1078,50 @@ u64 __init dt_mem_next_cell(int s, const __be32 **cellp)
> >  /*
> >   * early_init_dt_scan_memory - Look for and parse memory nodes
> >   */
> > -int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
> > -                                  int depth, void *data)
> > +int __init early_init_dt_scan_memory(void)
> >  {
> > -     const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> > -     const __be32 *reg, *endp;
> > -     int l;
> > -     bool hotpluggable;
> > -
> > -     /* We are scanning "memory" nodes only */
> > -     if (type == NULL || strcmp(type, "memory") != 0)
> > -             return 0;
> > +     int node;
> > +     const void *fdt = initial_boot_params;
> >
> > -     reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
> > -     if (reg == NULL)
> > -             reg = of_get_flat_dt_prop(node, "reg", &l);
> > -     if (reg == NULL)
> > -             return 0;
> > +     for (node = fdt_node_offset_by_prop_value(fdt, -1, "device_type", "memory", 6);
> > +          node != -FDT_ERR_NOTFOUND;
> > +          node = fdt_node_offset_by_prop_value(fdt, node, "device_type", "memory", 6)) {
>
> The 6 there doesn't work on my machines.

Crap! I meant to keep the original version and just fix the return.

>
> It needs to match the trailing NULL, so 7 or sizeof("memory") works.

That's what I get for trying to look thru libfdt to see what it wants.
Seems to be strlen() on property names and strlen()+1 on values.

Rob
