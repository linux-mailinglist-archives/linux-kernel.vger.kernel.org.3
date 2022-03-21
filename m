Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D974E2355
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbiCUJaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiCUJaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:30:14 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D4411A2D;
        Mon, 21 Mar 2022 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1647854925; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVrCF/2V/G1E36VXuX6ssaft/908rYw10LtHewuhQpk=;
        b=HQJDghqRuYk7vr/fYw9xIQ6EefAjPgNraYg1zhVIO5ZaS0EjoS3CwCzI8vqadWft6Tu4f8
        XhFwafzjwwCOJanoC31t+YmIBOCPjB/fVp+5RZs1qwRs5k/ZO48C5V91eOXaYn/19qT8C2
        yHw7CsNWRxGQ3GyMtJJWuPfH8twYQwc=
Date:   Mon, 21 Mar 2022 09:28:36 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] iio: dac: ad5592r: Fix the missing return value.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Zizhuang Deng <sunsetdzz@gmail.com>, Jonathan.Cameron@huawei.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Paul Cercueil <paul.cercueil@analog.com>
Message-Id: <OZ839R.NWJC2LY54LGX@crapouillou.net>
In-Reply-To: <20220320152047.2a04a62e@jic23-huawei>
References: <20220310125450.4164164-1-sunsetdzz@gmail.com>
        <20220320152047.2a04a62e@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dim., mars 20 2022 at 15:20:47 +0000, Jonathan Cameron=20
<jic23@kernel.org> a =E9crit :
> On Thu, 10 Mar 2022 20:54:50 +0800
> Zizhuang Deng <sunsetdzz@gmail.com> wrote:
>=20
>>  The third call to `fwnode_property_read_u32` did not record
>>  the return value, resulting in `channel_offstate` possibly
>>  being assigned the wrong value.
>>=20
>>  Signed-off-by: Zizhuang Deng <sunsetdzz@gmail.com>
> Hi,
>=20
> Definitely rather odd looking and I think your conclusion is correct.
> +CC Paul for confirmation that this isn't doing something clever..

It's been a while, but I don't think there was anything clever going on=20
here - so the patch is fine.

Cheers,
-Paul

>=20
>>  ---
>>   drivers/iio/dac/ad5592r-base.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/iio/dac/ad5592r-base.c=20
>> b/drivers/iio/dac/ad5592r-base.c
>>  index a424b7220b61..4434c1b2a322 100644
>>  --- a/drivers/iio/dac/ad5592r-base.c
>>  +++ b/drivers/iio/dac/ad5592r-base.c
>>  @@ -522,7 +522,7 @@ static int ad5592r_alloc_channels(struct=20
>> iio_dev *iio_dev)
>>   		if (!ret)
>>   			st->channel_modes[reg] =3D tmp;
>>=20
>>  -		fwnode_property_read_u32(child, "adi,off-state", &tmp);
>>  +		ret =3D fwnode_property_read_u32(child, "adi,off-state", &tmp);
>>   		if (!ret)
>>   			st->channel_offstate[reg] =3D tmp;
>>   	}
>=20


