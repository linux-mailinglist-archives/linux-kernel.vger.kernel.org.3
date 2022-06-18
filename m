Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C91550629
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 18:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiFRQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 12:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiFRQqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 12:46:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4529582;
        Sat, 18 Jun 2022 09:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2F63B80A72;
        Sat, 18 Jun 2022 16:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC689C3411A;
        Sat, 18 Jun 2022 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655570774;
        bh=O2RJ2eqglnM+kXxDGHgy56LBtlq6DELn/lrQeHUDxv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HSHjkS30t9lRlmWfuNd2+3ndOnL233B8tJTKTstwSQEXz/p0ev/9xBUXnDLI3JnAt
         tgiQg1Ed+OwoUAfebcbycWuP5kw8/8aaLK69+goSvkTnrVIwV8VJrDEXPg1N5xpqQZ
         jcsfsq5dZ2Ufsfp9u5/rymT5eW8lbLRCPo7pgfvgZhF1H6+KgrKhk3F6iXoEeslOXm
         YguscccVN2SiiHoj1yTTwGWdUHEborey8nWc14i0FpCT/hrTjgIQWPZsK6T1f32klW
         vcG3VZIH99wDv4K8jrKYoLlhNoUjs7rOaU2vdATNIbqR0xfJayFbRdqQCyk+sOfJvg
         B9BMo7SbSFszg==
Date:   Sat, 18 Jun 2022 17:55:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-iio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proximity: vl53l0x: Make VDD regulator actually
 optional
Message-ID: <20220618175530.2106129e@jic23-huawei>
In-Reply-To: <20220614112049.302278-1-luca.weiss@fairphone.com>
References: <20220614112049.302278-1-luca.weiss@fairphone.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 13:20:50 +0200
Luca Weiss <luca.weiss@fairphone.com> wrote:

> Contrary to what the naming might suggest, devm_regulator_get_optional
> returns -ENODEV in case the regulator is not found which will trigger
> probe error in this driver.
> 
> Use devm_regulator_get instead which will return a dummy regulator that
> we can just use as if it was a proper regulator.
> 
> Fixes: d3d6dba56dab ("proximity: vl53l0x: Handle the VDD regulator")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> @Jonathan: As discussed in the other email, maybe you want to
> adjust/remove the "Fixes:" tag. Your call.
Applied to the togreg branch of iio.git.

> 
>  drivers/iio/proximity/vl53l0x-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 3b7a33ff601d..c7c4d33d340f 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -237,7 +237,7 @@ static int vl53l0x_probe(struct i2c_client *client)
>  				     I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -EOPNOTSUPP;
>  
> -	data->vdd_supply = devm_regulator_get_optional(&client->dev, "vdd");
> +	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");
>  	if (IS_ERR(data->vdd_supply))
>  		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
>  				     "Unable to get VDD regulator\n");

