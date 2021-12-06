Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34D84692F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbhLFJws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:52:48 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51252 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241479AbhLFJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:52:46 -0500
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 640C5EE;
        Mon,  6 Dec 2021 10:49:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638784156;
        bh=oaMhsWEtCze9B8DfhiYsjOO/yQpxK0/yYA47gj6keYw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RGj8oAyx/Er6QO5rn12wQ615+iY+AJnk2SLKLZWR0Ne5mX24Y7P7sdb6TzZZtI2Pi
         yNiBLgiKu+IP+VBDGoi591nX9I47M825kCbm9gpWz2P4dJvKpu+ovRErJ3INO20d6w
         pdi2Sy/D+pYBLiWuGqSmKsKJz74iBa+CGpY6+yoY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211205190415.19962-1-jose.exposito89@gmail.com>
References: <20211205190415.19962-1-jose.exposito89@gmail.com>
Subject: Re: [PATCH] media: venus: helpers: Fix memory leak in venus_helper_alloc_dpb_bufs
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        stanimir.varbanov@linaro.org, Ameer Hamza <amhamza.mgc@gmail.com>
Date:   Mon, 06 Dec 2021 09:49:14 +0000
Message-ID: <163878415444.147210.13155524098900308326@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jos=C3=A9

Quoting Jos=C3=A9 Exp=C3=B3sito (2021-12-05 19:04:15)
> Addresses-Coverity-ID: 1494120 ("Resource leaks")

This was also recently posted by Ameer in https://lore.kernel.org/all/20211=
204205504.6550-1-amhamza.mgc@gmail.com/

Regards
--
Kieran

> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
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
>                 }
> --=20
> 2.25.1
>
