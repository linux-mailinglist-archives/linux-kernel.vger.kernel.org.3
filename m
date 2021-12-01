Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7781464B46
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348535AbhLAKMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348512AbhLAKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:12:52 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44746C061756
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 02:09:31 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e11so46968271ljo.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 02:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OUz5GIJwWhsCyqmvdwiSMp+8PenKcEyq20yCWjGw6oo=;
        b=h0Fitg9dKp6Gl/4ZI0YCCzy6luvo1s9aJSiGf6y033HzRqpc5bZcL22MlRCxP3mbCw
         qaFmDSHUWkmclJFd6Gfp/IFpPuiU7sHzEXpo7ODUC+M3ObKQBAze5n0u8m5zdnSf40pd
         rWicWAkANUpI3/KhOCbjO6u0XEmS6Zjz6t6xbahAOXpcxxGSwPHx2ZvT9rC83GjQ/Jyi
         Zs4Tb/H/YaHN/WStBxRlcFz1073veJYxBn+ifRYQ4WrGuao/yfclD+EQY65wwJ1LSDgT
         t35ruCeNnZ7SL3r0UrUHhEBHvQHgn/B3WNXWOVMGwWma20ykKSLR2Leaqfo+hPq4XYAq
         HpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OUz5GIJwWhsCyqmvdwiSMp+8PenKcEyq20yCWjGw6oo=;
        b=rkef7/l1puXDBBv8GBqZ3QUBsMImRMQdKzfO3QWgS+SZBXg4dIdD6SLLAPFLEeUu/u
         ekXWtjQAwfik3gwuP4JrkfXwpXj/hY+N8CgGDdLVcBba5yYqmI8JsRzoYdrF1MD/yrDz
         I8usRaM8NAEnA7rHraIV2eiuoIqu/f6sh+n87vbMkmgWuVX9kXojRlgiW8sxsfhZtnlq
         qkDvUa/bPFAxkOpVyz9hTaUjpcLWpfyl64qnGYCuaZSRHnFdvstILJHOpNgCayQ+ip1v
         2gc8KhPVT5Ox153c0eTmkbooCxYt64zCVfoPPVoeXOtC1xt8an2eUJx37qdJwjN5NQ4y
         tCWw==
X-Gm-Message-State: AOAM532bejZ8lpPxlDssYHD8uv/CIo9+HaHkn+wR4bwkNckWFxXeRhe5
        b2GmJPJLCxxW/yDiV3Ewqfnh4AqKkZQScMc+2x0MoJ1gC4h+eA==
X-Google-Smtp-Source: ABdhPJzDsJHqm+aHiy+lkIXP5Ar3k9o7SMl/nP/3Xx3p2ShJFSukJaXUE1CMRVgy9JAkWUv59xYkYWSvKKpQZ+pGyjE=
X-Received: by 2002:a2e:5850:: with SMTP id x16mr4763005ljd.122.1638353369362;
 Wed, 01 Dec 2021 02:09:29 -0800 (PST)
MIME-Version: 1.0
References: <YaB/JHP/pMbgRJ1O@kroah.com> <20211126074904.88388-1-guangming.cao@mediatek.com>
 <CALAqxLVF1BPznzwjem2BcsDDoo5gMoBqjKEceZDLJan4zCtk3w@mail.gmail.com>
In-Reply-To: <CALAqxLVF1BPznzwjem2BcsDDoo5gMoBqjKEceZDLJan4zCtk3w@mail.gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 1 Dec 2021 15:39:17 +0530
Message-ID: <CAO_48GHxanR=-mN232ANwxQEiBo9zb3WjvO-6WmP6eFYWA1M5A@mail.gmail.com>
Subject: Re: [PATCH v4] dma-buf: system_heap: Use 'for_each_sgtable_sg' in
 pages free flow
To:     John Stultz <john.stultz@linaro.org>
Cc:     guangming.cao@mediatek.com, greg@kroah.com, brian.starkey@arm.com,
        benjamin.gaignard@linaro.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, labbott@redhat.com,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        lmark@codeaurora.org, matthias.bgg@gmail.com, robin.murphy@arm.com,
        stable@vger.kernel.org, wsd_upstream@mediatek.com,
        kuan-ying.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guangming,

On Mon, 29 Nov 2021 at 23:35, John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, Nov 25, 2021 at 11:48 PM <guangming.cao@mediatek.com> wrote:
> >
> > From: Guangming <Guangming.Cao@mediatek.com>
> >
> > For previous version, it uses 'sg_table.nent's to traverse sg_table in =
pages
> > free flow.
> > However, 'sg_table.nents' is reassigned in 'dma_map_sg', it means the n=
umber of
> > created entries in the DMA adderess space.
> > So, use 'sg_table.nents' in pages free flow will case some pages can't =
be freed.
> >
> > Here we should use sg_table.orig_nents to free pages memory, but use th=
e
> > sgtable helper 'for each_sgtable_sg'(, instead of the previous rather c=
ommon
> > helper 'for_each_sg' which maybe cause memory leak) is much better.

Thanks for catching this and the patch; applied to drm-misc-fixes.
> >
> > Fixes: d963ab0f15fb0 ("dma-buf: system_heap: Allocate higher order page=
s if available")
> > Signed-off-by: Guangming <Guangming.Cao@mediatek.com>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > Cc: <stable@vger.kernel.org> # 5.11.*
>
> Thanks so much for catching this and sending in all the revisions!
>
> Reviewed-by: John Stultz <john.stultz@linaro.org>


Best,
Sumit.

--=20
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - LCG, Vertical Technologies
Linaro.org =E2=94=82 Open source software for ARM SoCs
