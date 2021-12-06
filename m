Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACB546930A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbhLFJ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:59:27 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51312 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241537AbhLFJ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:59:26 -0500
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A231AEE;
        Mon,  6 Dec 2021 10:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638784556;
        bh=2r2GbxKPhAXxZ+3+KQwXXGF+wPCJfkbsKIZdCqfP92s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jJk0GK7FHXCO6ICbi9MU00/GN5O9WqEm/xEaSgXHQD8qDzLHLcUE0s4IGD9Obv9+j
         8F6bkzoTcayk7sOLiC9NC9lDW/1oXB+I/jLzMWNFJR66Y0RUAgwalqmjES2VBNkxBH
         756RKU5JdlvejPdEu25vyLA0WvX+aEEwxfCN0XPc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211204205504.6550-1-amhamza.mgc@gmail.com>
References: <163864977875.3153335.18099399866051099554@Monstersaurus> <20211204205504.6550-1-amhamza.mgc@gmail.com>
Subject: Re: [PATCH v2] media: venus: vdec: fixed possible memory leak issue
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amhamza.mgc@gmail.com
To:     Ameer Hamza <amhamza.mgc@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org,
        stanimir.varbanov@linaro.org
Date:   Mon, 06 Dec 2021 09:55:54 +0000
Message-ID: <163878455464.147210.11589283989656931183@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ameer,

Thank you for investigating the alternative suggestion I made.

Quoting Ameer Hamza (2021-12-04 20:55:04)
> Fixed coverity warning by freeing the allocated memory before return

We could probably say that fixing the coverity warning isn't so much the
target of the patch as fixing the memory leak. It's just helpful that
coverity spotted it for us.


I'd write:

The venus_helper_alloc_dpb_bufs() implementation allows an early return
on an error path when checking the id from ida_alloc_min() which would
not release the earlier buffer allocation.

Move the direct kfree() from the error checking of dma_alloc_attrs() to
the common fail path to ensure that allocations are released on all
error paths in this function.

> Addresses-Coverity: 1494120 ("Resource leak")
>=20
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>

Of course having suggested it, I believe this is the right fix so:

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> ---
> Changes in v2:
> move kfree() immediately after kfree() as suggested by Kieran Bingham
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/=
platform/qcom/venus/helpers.c
> index 84c3a511ec31..0bca95d01650 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -189,7 +189,6 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *in=
st)
>                 buf->va =3D dma_alloc_attrs(dev, buf->size, &buf->da, GFP=
_KERNEL,
>                                           buf->attrs);
>                 if (!buf->va) {
> -                       kfree(buf);
>                         ret =3D -ENOMEM;
>                         goto fail;
>                 }
> @@ -209,6 +208,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *in=
st)
>         return 0;
> =20
>  fail:
> +       kfree(buf);
>         venus_helper_free_dpb_bufs(inst);
>         return ret;
>  }
> --=20
> 2.25.1
>
