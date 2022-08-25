Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B885A1C82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbiHYWiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHYWir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:38:47 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C1C650B;
        Thu, 25 Aug 2022 15:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1661467121; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=81tAzyX6vmMMXSu5G9Xt3iMuENk882wIj9/gOruorls=;
        b=STdIaKKUyluAxWIOcQOLRU+HdeAVuf7zQH2rFsIM52apQS5Npwq1YBcLs+V7/4YecZ2wrZ
        PLauyCY0erFnKknRHBIDgh57+1YvpNnKgc7jBLth3ghWvygUwQZ4H/ZZ12dXadK8+JmDiZ
        1yt4tmbuEVUdLSE0tIkR5T6x1iqKByk=
Date:   Thu, 25 Aug 2022 23:38:31 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] mmc: jz4740_mmc: Fix error check for dma_map_sg
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7807HR.GJGCCUV9UJJL3@crapouillou.net>
In-Reply-To: <20220825074008.33349-3-jinpu.wang@ionos.com>
References: <20220825074008.33349-1-jinpu.wang@ionos.com>
        <20220825074008.33349-3-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Le jeu., ao=FBt 25 2022 at 09:40:08 +0200, Jack Wang=20
<jinpu.wang@ionos.com> a =E9crit :
> dma_map_sg return 0 on error.
>=20
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/mmc/host/jz4740_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/jz4740_mmc.c=20
> b/drivers/mmc/host/jz4740_mmc.c
> index b1d563b2ed1b..dc2db9c185ea 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -298,7 +298,7 @@ static int jz4740_mmc_prepare_dma_data(struct=20
> jz4740_mmc_host *host,
>  {
>  	struct dma_chan *chan =3D jz4740_mmc_get_dma_chan(host, data);
>  	enum dma_data_direction dir =3D mmc_get_dma_dir(data);
> -	int sg_count;
> +	unsigned int sg_count;
>=20
>  	if (data->host_cookie =3D=3D COOKIE_PREMAPPED)
>  		return data->sg_count;
> @@ -308,7 +308,7 @@ static int jz4740_mmc_prepare_dma_data(struct=20
> jz4740_mmc_host *host,
>  			data->sg_len,
>  			dir);
>=20
> -	if (sg_count <=3D 0) {
> +	if (!sg_count) {
>  		dev_err(mmc_dev(host->mmc),
>  			"Failed to map scatterlist for DMA operation\n");
>  		return -EINVAL;
> --
> 2.34.1
>=20


