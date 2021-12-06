Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C050246950D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbhLFLf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhLFLf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:35:56 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7620AC061746;
        Mon,  6 Dec 2021 03:32:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DBE7AEE;
        Mon,  6 Dec 2021 12:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638790344;
        bh=Rl8RZWbWzjXWNEacH6rhciAmEKhl7aRUVxoFGhBU+KM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gNDTRwKs6y+VX7MJoxeybmDaWrUCurehHD0HlVjAyysZ+IT5v7dyS94GvUOgRGK1p
         dgUmpRm8b+O3mnNYQo+xhJqtj/8oGx2UGvNRFepOR2Hwq2aONTuie5EgeWHnkpDojB
         ZGXSke6tCiQ3/eXWwK0HBiX8k+omwoZZ1bw685cU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211206104315.12516-1-amhamza.mgc@gmail.com>
References: <163878547435.2211244.3536763956780138208@Monstersaurus> <20211206104315.12516-1-amhamza.mgc@gmail.com>
Subject: Re: [PATCH v3] media: venus: vdec: fixed possible memory leak issue
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        stanimir.varbanov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amhamza.mgc@gmail.com
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Date:   Mon, 06 Dec 2021 11:32:21 +0000
Message-ID: <163879034159.2211244.5962318772307516005@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ameer Hamza (2021-12-06 10:43:15)
> The venus_helper_alloc_dpb_bufs() implementation allows an early return
> on an error path when checking the id from ida_alloc_min() which would
> not release the earlier buffer allocation.
>=20
> Move the direct kfree() from the error checking of dma_alloc_attrs() to
> the common fail path to ensure that allocations are released on all
> error paths in this function.
>=20
> Addresses-Coverity: 1494120 ("Resource leak")
>=20
> Fixes: 40d87aafee29 ("media: venus: vdec: decoded picture buffer handling=
 during reconfig sequence")
>=20

No need for blank lines between those tags, and when someone provides a
Reviewed-by tag, you can collect it into your patch for future versions
unless you feel you've modified the patch so much that it doesn't apply
anymore.

So this can still be added (no need to repost to add to this patch, I
believe the integration scripts likely pick up tags added to a patch,
but won't pick up ones added to previous versions).

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
>=20
> ---
> Changes in v3:
> Updated description and added fix tag
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
