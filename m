Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD703579FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiGSNrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiGSNrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:47:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E83B957;
        Tue, 19 Jul 2022 06:00:54 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BDD0D6EE;
        Tue, 19 Jul 2022 15:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1658235651;
        bh=NaOscEIHC5O24TXksqWYtEboYMXHlx2oB97W0F6IY8w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dFWoS2rZVpHFtVt7rIYOMrlYIRQuyc5o9bz8WI5Nawbw1STQsLY3tEFFp+Ty5+TtU
         59FcNYbXCQdmhhJLy+QWYUTr06zhYISeVHTBXGXtAnoXXMg9wf3AcMHWRYqbXynn0J
         W9L3JwsVaqBoPSU+IYmEHp1mPEGj4SPS8jRAkHTg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220719071721.703986-1-yangyingliang@huawei.com>
References: <20220719071721.703986-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] media: vimc: fix wrong pointer passed to PTR_ERR() in vimc_create_links()
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     mchehab@kernel.org, yunkec@google.com, skhan@linuxfoundation.org
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Tue, 19 Jul 2022 14:00:48 +0100
Message-ID: <165823564899.2228597.7310111477254228194@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Quoting Yang Yingliang (2022-07-19 08:17:21)
> It should be 'ret_link' passed to PTR_ERR().
>=20
> Fixes: d534b9520a12 ("media: vimc: add ancillary lens")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

I believe this patch is correct, and it even has a fixes tag, which is
perhaps one up on the previous one [0] from Hans, though I think he
perhaps sent that before d534b9520a12 was even pushed

But Hans' patch was sent first, so it might be ahead of the race.

[0] https://lore.kernel.org/linux-media/4fd23b1c-8a0a-1691-a4f9-526ec99bd19=
3@xs4all.nl/


But for which ever one gets chosen:

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>


> ---
>  drivers/media/test-drivers/vimc/vimc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/=
test-drivers/vimc/vimc-core.c
> index c73f91947f44..2ae7a0f11ebf 100644
> --- a/drivers/media/test-drivers/vimc/vimc-core.c
> +++ b/drivers/media/test-drivers/vimc/vimc-core.c
> @@ -211,7 +211,7 @@ static int vimc_create_links(struct vimc_device *vimc)
>                         media_create_ancillary_link(ved_primary->ent, ved=
_ancillary->ent);
> =20
>                 if (IS_ERR(ret_link)) {
> -                       ret =3D PTR_ERR(link);
> +                       ret =3D PTR_ERR(ret_link);
>                         goto err_rm_links;
>                 }
>         }
> --=20
> 2.25.1
>
