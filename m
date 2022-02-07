Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD1F4AC858
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbiBGSOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356060AbiBGSIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:08:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0B4C0401E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:08:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so6339412pja.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYdhIytWWvNZPQpgxc7JanMz43mOjz+UXOqpB/Si8gY=;
        b=R93xjTEs3HgPo29762m4uqHy6DgEIiw341Wvf7q57zjQt/fMOf/vIggnLWq+UIkvE2
         ItYfM1ocg4jOoHter+LGmVVn+56WIrTresjlRqOzDpxhR2gE2Z7XKfivMQnYws3oBpcN
         Wnp4OjEX2kVSHOm5wWUaWUQHoBL2pZOajsCNpVYP+2s7M4Pt370NfYYH6tCLMb0ePa8z
         HUeyronXi33SaNNHMgqIF/E3v+pRpLWgtLiP7uZ593CHEdxKAHCZRXlItwp/sNFJZgmH
         Q6m9V+2GxeMGSIE/EyF8AlQqUfCTIeQOL4NCF8eo53fHgen+/6rfpdiFIvCtnwfrEBzm
         8haA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYdhIytWWvNZPQpgxc7JanMz43mOjz+UXOqpB/Si8gY=;
        b=JKN5IdyL7Lo88aaho89CPJK/69UwNGSEon6B4H63y2jKeiuqd1mD0mzuzC4qPGso+d
         ZrOu3skOR0gZw6klaSxXsLZRsB4LmKAUpGJoPVZgV1bHcH5c6aEsjOl2DGnQ+1osfXWX
         sCtCnQF4ZtTUYbOuB/vS3U3+NmilvwFrOIBPgRY/y5iVcimPID5sTnLv992p0AntwxzI
         Ljdr040gVUpWxMvmEEQQx2dafh2Xrr3W7pIyz8FT+9ouvyC9VZ5h3S3TKYFkPGhZw5QW
         K5GKXY4vT0X/Dbq9hxUXqfyf5SzEMWDQfEnK4awhyLBZ1/eVmAZyjPrqTS/RIM8trsH6
         nqCA==
X-Gm-Message-State: AOAM530OT62pLgkoNU6Dk8OmhiKRu/Xmm4/oDFNpoKyL8yB/rz3uw0Ko
        OwDOwF4j2ciBSvw/tmArwS0CF8ihIT1dE9ZvrP+bvg==
X-Google-Smtp-Source: ABdhPJzkFzzjmqODkvgrvwQLNfbzdHBUvOVv75drXwoWtoHzOi4Qr8amdduzRjHB4i+xpu3YrgRs1ma/CEMYchNDNj0=
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr121877pjb.93.1644257320409;
 Mon, 07 Feb 2022 10:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-3-hch@lst.de>
In-Reply-To: <20220207063249.1833066-3-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Feb 2022 10:08:29 -0800
Message-ID: <CAPcyv4i3hJR9WBh6PFN9VgA0p3x4Vvgdy6T3b-3_bP_LaPK9fg@mail.gmail.com>
Subject: Re: [PATCH 2/8] mm: remove the __KERNEL__ guard from <linux/mm.h>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6, 2022 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> __KERNEL__ ifdefs don't make sense outside of include/uapi/.

Yes.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
