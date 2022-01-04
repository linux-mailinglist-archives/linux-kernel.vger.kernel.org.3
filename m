Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD205483D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 08:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiADHnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 02:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiADHnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:43:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EF3C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 23:43:09 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id p7so58569351ljj.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 23:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgKwWZIfcsw72ZHfRdvesZsrrJZ1f8dTTxjt4J+BNV4=;
        b=X1ob57L7f7pUYK9slUoi/6n/KdzlJZAH8oS41+fUBZrebkN3Jnk2uaUo6PEJFCsaUx
         zcPjGMq4Kp7cO3mAF8RhPxz3hDyy64IWH4viwJceKGUJZlgsF9B3sEJDeAKfMKIZiboU
         6CpumNRlrBIBJG0KASIkN0/5UCUtgBpFO8+Xt16kpgHQM7cSI8PDNwSKBxGLM1FOz0qD
         Y3nhvzScK/BTQb1cIrUde5TyCbBSCRqkLXhZ6QbnNyOn49n+c1Ss1yAizUgMpLKYZYns
         +WIDARIMUXhTMkCfFwFme7n+TFF3gO93EtOBE6Sdcs3LU8YN7bpf5nct2QHtI71vKdrV
         aPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgKwWZIfcsw72ZHfRdvesZsrrJZ1f8dTTxjt4J+BNV4=;
        b=mYv9KdxBL0ygMqftfQxftT2vz/xPUuTk/WK3eYrD+GxU/aGfYLXqUZy9Q1u9u+J4Hs
         hOecBk6KD1M6L7xty8eUrzbU2hlxma5g5rWnUFIpjl0SRTFI/IF+T9PmvO+H76K2RwXX
         CIM9QSPxZkE5Ye5grtTRFmNH/LItknO3ZwEuVVkuZdxvOJtRS07W2vhvT/YP2h5c86jd
         7k90tMZN0KwZrZ6NVGZsfRHVIX6DDXJ4Kk9lcSi65jBzRsWQYeyIU6M+u3CsUvs/oVQS
         sjqBl+HSKm1YxrjpAWJXEApxbcJogbG0IVSHRXY+FVTbo58Op4K3zQMbBlWP5I8Vg1dw
         q6qg==
X-Gm-Message-State: AOAM53343CXB7X4i3n0VPkBgPOwLT930ETj6fXQWFJRR4jkvEcxheMqr
        q6ovy0SZlnclcFpKwcneV7HyXljnxe+XZVtHWrKpXA==
X-Google-Smtp-Source: ABdhPJzTcr2rRRGYiX1ocR9ztRnmH4dD/4uUxGjd34ka6S9DtNKHuHT8CJGQDqdSwIr3ls+LKbpZ96lYXoI18cN1eoE=
X-Received: by 2002:a2e:9901:: with SMTP id v1mr40463499lji.61.1641282187995;
 Mon, 03 Jan 2022 23:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20220104073545.124244-1-o451686892@gmail.com>
In-Reply-To: <20220104073545.124244-1-o451686892@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 3 Jan 2022 23:42:56 -0800
Message-ID: <CALAqxLVSaZywOOnF=67X+gu9eo+ZmKQmW3wUOOKEM0rUZ4K5gg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: cma_heap: Fix mutex locking section
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        christian.koenig@amd.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 11:36 PM Weizhao Ouyang <o451686892@gmail.com> wrote:
>
> Fix cma_heap_buffer mutex locking critical section to protect vmap_cnt
> and vaddr.
>
> Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma_heap implementation")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Looks good to me!  Thanks so much for sending this in!

Acked-by: John Stultz <john.stultz@linaro.org>

thanks again
-john
