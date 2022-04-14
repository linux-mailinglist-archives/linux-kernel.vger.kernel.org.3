Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4758A500830
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbiDNIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiDNIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:25:09 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F45DA0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:22:45 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 07E191B002EF;
        Thu, 14 Apr 2022 11:22:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1649924560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYkKCNJTlijY39vvp5OIY+Ckmri6Ev74aKWsd1JHd/s=;
        b=e+TfM2wal2N7qhp3PDhUDxeGg0o+fXMRmR0beBy4JOjors5QTXR88FLPCjZoxJ+9+wZ+5w
        /tCrBM5TAUikVPkgq196aH5/S0gLYZci9xLwNNJfphHlZfRi0DIjJJt00udKKHvJGdB6Q3
        YKkvnbkTdmhGmJhnpxgS6dXHMraUHn0CEBWcUXsdSWhcLiCbvprZXNT0X5tKYSHSPd2MA6
        AiaECi/UOcVyyT7y1iRwElUVTsMbOLNdthCJY8s9WAyeKiJ+pJcfqmrIgrDPjF2IQpyEoq
        UAS9YNY43QTcrpSe6PTPGamAHepyTjFUW9N4Xhclpt7nEgVoJlWR2mFHA9AbPg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 97609634C91;
        Thu, 14 Apr 2022 11:22:39 +0300 (EEST)
Date:   Thu, 14 Apr 2022 11:22:39 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov7640: Use ARRAY_SIZE instead of manual checking
Message-ID: <YlfZz+j/KSl1joHT@valkosipuli.retiisi.eu>
References: <20220317144714.47442-1-mosescb.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317144714.47442-1-mosescb.dev@gmail.com>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1649924560; a=rsa-sha256;
        cv=none;
        b=ZxGzYidSEx+F6jCtlIQ7jNuENqk9rJUjkASVBXmtKz3e982+bNFp+yMlQ6BxIFTsvCT3+x
        IjhW/IrECXUHF9aDjOwLP6yuC1/MPGiADGGLZ+kjVxaEIkngYP7Sf2O4PYwhSFlbtLWrER
        6etULUE1maFR8fYf8IADt9hFc8zW1f2CqSYSE7H6Lfqo7sAAhTnf3iH1h1R+MNSuCJEOo8
        BU5ERtoUGbTFyJdhhyIv1xp0Z+K58FGVH188vdi/its34H3b28vL6ITVCZDADKz/Qwgn8/
        FY+r4GB0WubSLchRXNMGEIejL0o8JGsE01E2PG5o/bHBLaE9ZbU6BddIsOrj4w==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1649924560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYkKCNJTlijY39vvp5OIY+Ckmri6Ev74aKWsd1JHd/s=;
        b=Rq3z61ikFNeZ7rbL/vX2GFOe0Pb0wXm/dQTg7uZ2cb5oRZQ0A5IHMxgnT0cFPyEeDAEWvc
        /WUPsLo4fOJJqE3h7aHlQctq0Ly/FMVP5+21H2rkBmz3NaZMnU9cqEm0ZPhrwY1FT8m0Mn
        NUkGSb/bJq7zTn8Bf99m3QwdBrZh2JtvAKDgG4Ex2JBAf/p9sReVjsiS75hYID9EpD+W9h
        C5Fe1sJAmRVBHg2arMxhEU1eDkpvOtIneNyBTqjixsWPX+eps53IGxRtW7rXwDQ9I38RMw
        /WP7nyGcLVhY3UUiGPPgznh1V+saLBX2U/76tzNCUGNpkGSzjlbiVHlH/fEcVg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moses,

On Thu, Mar 17, 2022 at 03:47:14PM +0100, Moses Christopher Bollavarapu wrote:
> Currently, the driver ends the reg-val list with a 0xFF as a check to stop
> the loop. Instead an array of reg-vals can be used to avoid this check,
> by using the ARRAY_SIZE(arr) macro to obtain the length of the array and
> iterate over it.
> 
> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> ---
>  drivers/media/i2c/ov7640.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov7640.c b/drivers/media/i2c/ov7640.c
> index 010803d58ce8..977cd2d8ad33 100644
> --- a/drivers/media/i2c/ov7640.c
> +++ b/drivers/media/i2c/ov7640.c
> @@ -13,23 +13,28 @@
>  MODULE_DESCRIPTION("OmniVision ov7640 sensor driver");
>  MODULE_LICENSE("GPL v2");
>  
> -static const u8 initial_registers[] = {
> -	0x12, 0x80,
> -	0x12, 0x54,
> -	0x14, 0x24,
> -	0x15, 0x01,
> -	0x28, 0x20,
> -	0x75, 0x82,
> -	0xFF, 0xFF, /* Terminator (reg 0xFF is unused) */
> +struct reg_val {
> +	u8 reg;
> +	u8 val;
>  };
>  
> -static int write_regs(struct i2c_client *client, const u8 *regs)
> -{
> -	int i;
> +static const struct reg_val regval_init[] = {
> +	{0x12, 0x80},
> +	{0x12, 0x54},
> +	{0x14, 0x24},
> +	{0x15, 0x01},
> +	{0x28, 0x20},
> +	{0x75, 0x82},
> +};
>  
> -	for (i = 0; regs[i] != 0xFF; i += 2)
> -		if (i2c_smbus_write_byte_data(client, regs[i], regs[i + 1]) < 0)
> +static int write_regs(struct i2c_client *client,
> +		const struct reg_val *rv, int len)

Please align to opening parenthesis on the next time. Somehow checkpatch.pl
doesn't seem to complain about this. I.e.

... func(arg1, ...,
	 arg2);

Applied.

> +{
> +	while (--len >= 0) {
> +		if (i2c_smbus_write_byte_data(client, rv->reg, rv->val) < 0)
>  			return -1;
> +		rv++;
> +	}
>  	return 0;
>  }
>  
> @@ -56,7 +61,7 @@ static int ov7640_probe(struct i2c_client *client,
>  	v4l_info(client, "chip found @ 0x%02x (%s)\n",
>  			client->addr << 1, client->adapter->name);
>  
> -	if (write_regs(client, initial_registers) < 0) {
> +	if (write_regs(client, regval_init, ARRAY_SIZE(regval_init)) < 0) {
>  		v4l_err(client, "error initializing OV7640\n");
>  		return -ENODEV;
>  	}

-- 
Regards,

Sakari Ailus
