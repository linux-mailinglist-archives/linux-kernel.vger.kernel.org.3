Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27636528AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343810AbiEPQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343797AbiEPQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:43:54 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B23C4A7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:43:52 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7FBB7240007;
        Mon, 16 May 2022 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652719431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKC2n8siaU3/m8tasFcxJwqALcqLnpcBpiJpKXLsFnY=;
        b=LJKjhlCNv/6SLWNzKJbI8MOcEldHlSz24SX5QSvzlGevtWd6vdTvBou5qZVoCqnAKWm/OT
        bV50TUXCGYQYd8g1kLGEgDAP7nJXxLH9yutuAS6A1b1oddUg+6ap+M/LgXJDZAeOMPywHZ
        aMIKdpI3GouO3qpi+OCaVIxm23MMt/3CU9OB2lPQOjTK7at9diypdLBq8yeqNp49SzRvvH
        cxAi8yMOxCdW130g2JZGhtkLmCCj9aGnVPGrTL1Aw67Qo9FWQo8+zl3Aub2Bd6WlHxksFl
        EqRFRPlS+d8nHBVKjV1bEQn2JLpqlzXZP4cCe2TgUpPzQFhFjZo0aF19LGp8Tg==
Date:   Mon, 16 May 2022 18:43:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH -next v2] mtd: st_spi_fsm: add missing
 clk_disable_unprepare() in stfsm_remove()
Message-ID: <20220516184348.77f5b39d@xps-13>
In-Reply-To: <20220516092911.953066-1-yangyingliang@huawei.com>
References: <20220516092911.953066-1-yangyingliang@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

yangyingliang@huawei.com wrote on Mon, 16 May 2022 17:29:11 +0800:

> Clock source is prepared and enabled by clk_prepare_enable()
> in probe function, but not disabled or unprepared in remove
> function.
>=20

Applied to mtd/next, thanks!

> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>   make the commit message and title more proper.
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_sp=
i_fsm.c
> index 983999c020d6..d3377b10fc0f 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -2126,6 +2126,8 @@ static int stfsm_remove(struct platform_device *pde=
v)
>  {
>  	struct stfsm *fsm =3D platform_get_drvdata(pdev);
> =20
> +	clk_disable_unprepare(fsm->clk);
> +
>  	return mtd_device_unregister(&fsm->mtd);
>  }
> =20


Thanks,
Miqu=C3=A8l
