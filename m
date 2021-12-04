Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AF468777
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhLDUdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 15:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhLDUdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 15:33:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDCBC061751;
        Sat,  4 Dec 2021 12:29:43 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 18AB730C;
        Sat,  4 Dec 2021 21:29:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638649781;
        bh=tI1r2v4uMJbswYcNOL1eafqOlKzNWaxrE2NiCINNAT0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CL/Ukw62wHJp3IGXVn3Rnaw3hKADe93qjH+oBABWe5DDAKgn/Nryuk2mcyDLxpD/Z
         5xtBkxI7tZb8nMwffSIx3E+br2xtn4fL05+eHu34ULTZouOYc5ieCp4pSpztPm3gOa
         /PvE0D71PhuQUxR0P4x3KxCwLnp7GZOjhs5gqoUU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211204121123.22180-1-amhamza.mgc@gmail.com>
References: <20211204121123.22180-1-amhamza.mgc@gmail.com>
Subject: Re: [PATCH] media: venus: vdec: fixed possible memory leak issue
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amhamza.mgc@gmail.com
To:     Ameer Hamza <amhamza.mgc@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org,
        stanimir.varbanov@linaro.org
Date:   Sat, 04 Dec 2021 20:29:38 +0000
Message-ID: <163864977875.3153335.18099399866051099554@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ameer,

Quoting Ameer Hamza (2021-12-04 12:11:23)
> Fixed coverity warning by freeing the allocated memory before return
>=20
> Addresses-Coverity: 1494120 ("Resource leak")
>=20
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/=
platform/qcom/venus/helpers.c
> index 84c3a511ec31..344a42853898 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -197,6 +197,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *in=
st)
> =20
>                 id =3D ida_alloc_min(&inst->dpb_ids, VB2_MAX_FRAME, GFP_K=
ERNEL);
>                 if (id < 0) {
> +                       kfree(buf);
>                         ret =3D id;
>                         goto fail;

Indeed, this is definitely a leak here.

Normally I think resources would be cleaned up in the fail path in a
situation like this.

That would then make sure that all paths out of this loop will free on
error.

If buf is null, kfree(null) is a valid noop call, so it will not
adversely affect the kzalloc() fail path.

Given that, I would suspect that a cleaner fix is to move the kfree()
from after  " if (!buf->va) { " to immediately after the fail label so
that both dma_alloc_attrs() and ida_alloc_min() failures are cleaned up
in the same way by the same error path.

That way, if anyone later adds another operation in this loop, it won't
get missed and will also clean up correctly.

Regards
--
Kieran

>                 }
> --=20
> 2.25.1
>
