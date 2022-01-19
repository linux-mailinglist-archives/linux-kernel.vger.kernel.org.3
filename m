Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4796A49365E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352518AbiASIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:33:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59424 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352496AbiASIdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:33:00 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220119083258euoutp0123b21182a25812bceb92df69ce26e9f9~LnuEES_dr3064330643euoutp017
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:32:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220119083258euoutp0123b21182a25812bceb92df69ce26e9f9~LnuEES_dr3064330643euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642581178;
        bh=7PC9bmfxlBSCF7k36OSQOIqNBLsSmFfnE+giFS1uhX4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=MQjXBZfvU7Gcvddea/zVAWQE7lIQygyObkdYYKTA+URpfDFT4TtgRmFVCgmmw1OJ+
         WW2yFiathsfJF+fJ/btIJzVZaFBw7SdtuR0XKs82nXkqZdFnd2ENztkDgeofU3o4mj
         BTdFdd2xSagwV0oHkBTIczlk7lPK4ObvIedppdeI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220119083258eucas1p13532fe48b6a1e13007f57c93e41aac5f~LnuDvwH322985729857eucas1p1k;
        Wed, 19 Jan 2022 08:32:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F8.E4.10260.9BCC7E16; Wed, 19
        Jan 2022 08:32:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220119083257eucas1p1f4ba3fca2d85c786e73284fbcfcf6a98~LnuDYy64z2703427034eucas1p1s;
        Wed, 19 Jan 2022 08:32:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220119083257eusmtrp24ea3e5b51e195638b935ced9ce1b5527~LnuDYG6e70619406194eusmtrp27;
        Wed, 19 Jan 2022 08:32:57 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-f7-61e7ccb9f7f3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.22.09522.9BCC7E16; Wed, 19
        Jan 2022 08:32:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220119083257eusmtip2a4d02a3aa0ce0c9ae2b08ecd7b91dfef~LnuC6iX3_1993419934eusmtip2B;
        Wed, 19 Jan 2022 08:32:57 +0000 (GMT)
Message-ID: <4b337d6c-fac5-5c12-7f62-f70c09fc2518@samsung.com>
Date:   Wed, 19 Jan 2022 09:32:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] media: videobuf2-dma-contig: Invalidate vmap range
 before DMA range
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220119081417.20604-1-senozhatsky@chromium.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djPc7o7zzxPNJjRY2Zxct0bFouVq48y
        WVyceZfF4vKuOWwWPRu2slo0TT/IZrF74yI2i8+t/9gcODxmN1xk8dhxdwmjx+6bDWwenzfJ
        eZz6+pk9gDWKyyYlNSezLLVI3y6BK+Py6a9sBd38FYt/NDI3MO7m6WLk5JAQMJH4fm0Ncxcj
        F4eQwApGiaYps1ggnC+MEhtffmKHcD4zSizfvQ+ojAOs5dIVZYj4ckaJVf3fWCGcj4wSP8/O
        YgaZyytgJ/Fu/x5WEJtFQFVi3p817BBxQYmTM5+wgAwSFUiS6GlxBgkLC0RJ3GtdyQZiMwuI
        S9x6Mp8JxBYRqJP4+n0p2EXMAnsYJW5s+gxWxCZgKNH1tgvM5gTatfXxJVaIZnmJ7W/nMEP8
        9oJDYtMZGQjbReLhzS+sELawxKvjW9ghbBmJ/ztBlnEB2c2MEg/PrWWHcHoYJS43zWCEqLKW
        uHPuFxvI1cwCmhLrd+lDhB0l/s8+xgYJFT6JG28FIW7gk5i0bTo0sHglOtqEIKrVJGYdXwe3
        9uCFS8wTGJVmIYXKLCTvz0LyzSyEvQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIE
        JqPT/45/3cG44tVHvUOMTByMhxglOJiVRHil6p8lCvGmJFZWpRblxxeV5qQWH2KU5mBREudN
        ztyQKCSQnliSmp2aWpBaBJNl4uCUamDamm/5Z1J4fendeVWLXzg+3rr0plrAnrNCW5tm/Hs3
        Lcn3iqYCl7306sZSYdbEr7XbJ3Ik3ltyMLpmM6PInzfTeKOZFIWZT+tkf9HsPu1y+Mj7d1X7
        z3EYz3Y4uqywY45HgKkJY86RrXZ3lBr3/Yx9Mfv0Ceuas5q/f0nt/cnydFVnyqXnsoEic8qz
        DB7rP9m/LZUnyYeD/WL39Xcb3LMbMhoeP2d7Eq3lvcpk3dX2GY/3ln24qvHdrvF5y/Sd7P99
        Ba3nTD2TcCS2vutyufGp+0L9T5WCpn1Ikppy4qycaFv6njs3VtaoTfivzb7oUq1tWrKJv/UC
        mT/HOHPbE7WE7ysrLImZesG1dMaudNMjSizFGYmGWsxFxYkAlqro+LUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7o7zzxPNJj+W8ni5Lo3LBYrVx9l
        srg48y6LxeVdc9gsejZsZbVomn6QzWL3xkVsFp9b/7E5cHjMbrjI4rHj7hJGj903G9g8Pm+S
        8zj19TN7AGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
        vl2CXsbl01/ZCrr5Kxb/aGRuYNzN08XIwSEhYCJx6YpyFyMnh5DAUkaJt322ILaEgIzEyWkN
        rBC2sMSfa11sXYxcQDXvGSW+7T7KApLgFbCTeLd/D1gRi4CqxLw/a9gh4oISJ2c+AasRFUiS
        aDjWzQZiCwtESTzoXQ0WZxYQl7j1ZD4TiC0iUCcxZd1bdpAFzAL7GCU6311nhNg2kVGibVor
        WDebgKFE19suMJsTaPPWx5dYISaZSXRt7WKEsOUltr+dwzyBUWgWkkNmIVk4C0nLLCQtCxhZ
        VjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTG37ZjPzfvYJz36qPeIUYmDsZDjBIczEoivFL1
        zxKFeFMSK6tSi/Lji0pzUosPMZoCQ2Mis5Rocj4wAeSVxBuaGZgamphZGphamhkrifN6FnQk
        CgmkJ5akZqemFqQWwfQxcXBKNTD1zjv+3Sug1JyrMM/yv8jCC6XLRcUX1HxMsd5cnXDvk6zG
        0sKsJoaNM9p+yB3n32qooaHxZP3DWZyrfLpu2f9p3nl0J4PV2RWKWnp7HuwMWr2mTOBf/46E
        nbXsLGukny44fcxordQPNbs7Fi5rpQ/OP/xsu5nDh3mlLm+/Rn2+FqV6Sks2569kgsRu9fdZ
        VV0tOiZe+39Gr5x0c27eEa6MR/6PF7ssutVnLJUSKWO8W37Hko54Xnah1okCUXPOL72/XuPP
        zIkisd0lT2b8fLw80+pdT+12OYNHTo+iLpnaXo9m7jxYejo2JMjr1iPGsDln3wruvjJZ+GtI
        h5qy0bE7Z8/7dy1aXJ/usV3tQnm3EktxRqKhFnNRcSIAc1Le4kgDAAA=
X-CMS-MailID: 20220119083257eucas1p1f4ba3fca2d85c786e73284fbcfcf6a98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220119081426eucas1p14b7ae75dfefd3a268fc7d5b4e5d84eb2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220119081426eucas1p14b7ae75dfefd3a268fc7d5b4e5d84eb2
References: <CGME20220119081426eucas1p14b7ae75dfefd3a268fc7d5b4e5d84eb2@eucas1p1.samsung.com>
        <20220119081417.20604-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.01.2022 09:14, Sergey Senozhatsky wrote:
> Christoph suggests [1] that invalidating vmap range before
> direct mapping range makes more sense.
>
> [1]: https://lore.kernel.org/all/20220111085958.GA22795@lst.de/
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Right.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   .../media/common/videobuf2/videobuf2-dma-contig.c    | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index 7c4096e62173..0e3f264122af 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -132,12 +132,12 @@ static void vb2_dc_prepare(void *buf_priv)
>   	if (!buf->non_coherent_mem)
>   		return;
>   
> -	/* For both USERPTR and non-coherent MMAP */
> -	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
> -
>   	/* Non-coherent MMAP only */
>   	if (buf->vaddr)
>   		flush_kernel_vmap_range(buf->vaddr, buf->size);
> +
> +	/* For both USERPTR and non-coherent MMAP */
> +	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
>   }
>   
>   static void vb2_dc_finish(void *buf_priv)
> @@ -152,12 +152,12 @@ static void vb2_dc_finish(void *buf_priv)
>   	if (!buf->non_coherent_mem)
>   		return;
>   
> -	/* For both USERPTR and non-coherent MMAP */
> -	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
> -
>   	/* Non-coherent MMAP only */
>   	if (buf->vaddr)
>   		invalidate_kernel_vmap_range(buf->vaddr, buf->size);
> +
> +	/* For both USERPTR and non-coherent MMAP */
> +	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
>   }
>   
>   /*********************************************/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

