Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755F74761A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbhLOTYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhLOTYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:24:04 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F82C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:24:03 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso26106179otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 11:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4oNE1iW7fibm0JJSOAeZkA5i+qpsLKvVpg5qQJEMx1s=;
        b=idSHJ0iBYtTO2VOINlCC7ggUbxrlJGzd+MwOgeTiX2o84FEG+2LCaBSntbM4yYApNx
         pU08zuty86DGrPfpjIim5ZucDY0xhiqYUJyYVEMEugao+wjdF9VjK9S7sKZ1M0iFHUwj
         LHboTT++hMyhWGxsd5G/7YKRvp8S+L04QdM8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4oNE1iW7fibm0JJSOAeZkA5i+qpsLKvVpg5qQJEMx1s=;
        b=wdmqeedAdYOsUMsIdTjU5Mscy8iOSCapJDXHG2BWfBC/vFzYvevsxLQWX9RG6Y1m6n
         v8oGdhNuJxmqkxfVNUzT/2tQgyT1+3riJQm/C70+eTjCdVmO7SDFpNH7O0hC8ldzGpg5
         HAPNLmoxenRIDPmq7L6irErTW4PmKAzsYCGGtWk8CARzPXnYBewVtwxEO9DtoLDYQamJ
         UzaeICeobNHsR828xnNN1fEPI0bfg14QOiAkVwNhncfL09iJJT56SOng6l+O1JIICa4I
         99JIHeUdQTRWpCM3VtLt5nfkUjcYBjaApCwn+9UttZdrW9crC8Gfl8NdxM49kgmZBrbX
         j3rg==
X-Gm-Message-State: AOAM5333Ov5466AC50j+MJpdPuMC6iWHm0Pxrez8ojepqHzwHcKRE0H7
        9A4DsYQvZI2xMJ/xcAFxrT9WXYJJp2IJ51iyFDrNpw==
X-Google-Smtp-Source: ABdhPJxRwz9EiCEDTkqlQNhiXAVAW/lfF7Zrmuc9kI3QyvYrdf80wlkYOfGCjkUEztp2Ax8gD+K+x9qrzzfZwjyXPdk=
X-Received: by 2002:a9d:70ce:: with SMTP id w14mr9815391otj.77.1639596243072;
 Wed, 15 Dec 2021 11:24:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 11:24:02 -0800
MIME-Version: 1.0
In-Reply-To: <Ybm9F5AdCSGz6IwN@kernel.org>
References: <20211215072011.496998-1-swboyd@chromium.org> <Ybm6KQiS7B28QOSW@kernel.org>
 <Ybm9F5AdCSGz6IwN@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Dec 2021 11:24:02 -0800
Message-ID: <CAE-0n53NX0i3Jem+VJ3pE4HOpwYkWDfr=Vf3zd59RSE4-yr5aQ@mail.gmail.com>
Subject: Re: [PATCH v2] of/fdt: Don't worry about non-memory region overlap
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

Quoting Mike Rapoport (2021-12-15 02:01:59)
> On Wed, Dec 15, 2021 at 11:49:37AM +0200, Mike Rapoport wrote:
> >
> > On Tue, Dec 14, 2021 at 11:20:11PM -0800, Stephen Boyd wrote:
> > > @@ -482,9 +482,11 @@ static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
> > >     if (nomap) {
> > >             /*
> > >              * If the memory is already reserved (by another region), we
> > > -            * should not allow it to be marked nomap.
> > > +            * should not allow it to be marked nomap, but don't worry
> > > +            * if the region isn't memory as it won't be mapped.
> > >              */
> > > -           if (memblock_is_region_reserved(base, size))
> > > +           if (memblock_overlaps_region(&memblock.memory, base, size) &&
> > > +               memblock_is_region_reserved(base, size))
>
> One more small thing. Maybe add pr_warn() here?
>

There's already a print in __reserved_mem_reserve_reg() when this
function returns an error so it doesn't seem very useful to add another
print.
