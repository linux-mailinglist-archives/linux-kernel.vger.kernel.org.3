Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9122477A16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbhLPRM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbhLPRM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:12:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDFEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:12:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38A5061EC7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C57C36AEA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639674776;
        bh=Gam0vMqxhg3fMjDM2J47EzqX0PN7wLTKmYA/31ba58w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HP0cXDDZy1D3XSP3jdFORP8HgsxHZhpZblqZY0DfkkbyaQqjrCnvHnS+0AcKR3mcs
         pivQ1/BMk/vbP8BgCFAKz0C0arKhx6oiHQmfMtwvhxUAHZwVuyX2vCNakbPorbaIhx
         geA4DRj2BonR1m5p3kBwS87kaPVh9eHKKeKnMKSLJSz8yKmVGHt1Nwoj2wi/9R06di
         PkSA+1SCvnRUoOIfAxrh4C9UrdW32ZfRNy/oQVfycjby/xBgkzuGzO9xZmCzQMEplx
         s93WlOZhToTnkTd48T5nz0AFu7TzmGesJEm8uNUVUKkVA3+RhUMZIERZHexW3ciPKK
         PXRE/vFyUzQWA==
Received: by mail-ed1-f51.google.com with SMTP id z5so90149350edd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:12:56 -0800 (PST)
X-Gm-Message-State: AOAM532RKNyDIgegoV0vmzquIWgRqZj/SU85yutA+5vLi3hzXey+Pz/g
        XEZOGy8vQv8eI9r97R8HKCSX9jLdcqXBLDPUrQ==
X-Google-Smtp-Source: ABdhPJy4K3dx/sGYsqhgV8wmgEjIFmcECrjgBYyz626Gzm6BptoFhZ4nX7fCOtS+OYoICFzMNreYe6y8UhoeNM6ETho=
X-Received: by 2002:a17:907:94c2:: with SMTP id dn2mr16290161ejc.325.1639674774860;
 Thu, 16 Dec 2021 09:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20211216161603.983711-1-steven.price@arm.com>
In-Reply-To: <20211216161603.983711-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 16 Dec 2021 11:12:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZBsJxy8h5EQf0wwfioWS-Kx9i=0cQ7p4FHckEXstGiw@mail.gmail.com>
Message-ID: <CAL_JsqKZBsJxy8h5EQf0wwfioWS-Kx9i=0cQ7p4FHckEXstGiw@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Avoid user size passed to kvmalloc()
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:16 AM Steven Price <steven.price@arm.com> wrote:
>
> panfrost_copy_in_sync() takes the number of fences from user space
> (in_sync_count) and used to kvmalloc() an array to hold that number of
> fences before processing them. This provides an easy method for user
> space to trigger the OOM killer (by temporarily allocating large amounts
> of kernel memory) or hit the WARN_ONCE() added by 7661809d493b ("mm:
> don't allow oversized kvmalloc() calls").
>
> Since we don't expect there to be a large number of fences we can
> instead iterate over the fences one-by-one and avoid the temporary
> allocation altogether. This also makes the code simpler.

Doesn't the BO lookup suffer from the same issue?

Rob
