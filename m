Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC1500AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiDNKGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiDNKGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:06:36 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B6B6E543;
        Thu, 14 Apr 2022 03:04:11 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkvn5pty0gzs3nltj987t-3.rev.dnainternet.fi [IPv6:2001:14ba:4457:9640:1e2d:1f75:a607:ef37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 5BECA1B00330;
        Thu, 14 Apr 2022 13:04:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1649930649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcY9Hn0kFsYZKs9iRJ4rMEvAPY/YiAmALNRWdF31xqs=;
        b=EioSbMxzRTGOf7AOKfgY2lXah52UX+0og7pS5RzUHaJJSY5xLiYrP+Cbt2zmwgdgWAICVp
        WChOftqZcYpL/pHOp8OHMBYKc3qwCTI/UMKM2pKfolilyeHtpLf9FFlLVaL9RSD2RpGLcb
        LW3E+CXVjoYd7YRzcsHU8GhtoAlgEvmo+xrLLk3KcM3XA/wFAQ/poUlEvNos66d5emOgUt
        2QsMEymzB/BFs6a3fwbcMq/6qIxwFVAjV5jSbj2qhH6uD3KAru1cJ5TqdxVqF2VNeNpZTx
        Qqm5+9PaewIe9pM4ETwKFcV2E6Gdyq69654kQvR3No3z/ElPJ9yv1Vn3VqBDjQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id D13DD634C91;
        Thu, 14 Apr 2022 13:04:08 +0300 (EEST)
Date:   Thu, 14 Apr 2022 13:04:08 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     trix@redhat.com
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, hverkuil-cisco@xs4all.nl, vrzh@vrzh.net,
        laurent.pinchart@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RESEND PATCH] media: staging: atomisp: rework reading the id
 and revision values
Message-ID: <YlfxmADBx+xItHVJ@valkosipuli.retiisi.eu>
References: <20220329232526.3238181-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329232526.3238181-1-trix@redhat.com>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1649930649; a=rsa-sha256;
        cv=none;
        b=M8v7f23tp47ubtX9I/wBhl1zWMNisSqp49W4EpfzUxNYPDMlBoEiwL2akN8/lvB5ixU5XK
        IQ0ycrK4yF8w14IfUox9rYv3gmJsJb87fxV2+3dG4lv90N7c7cdEMFI/WnL/Vd8HP2vots
        6eK4EPo37hNuPw+cUeMtd14bpDGeTlzN9eY5Lr49IJ+dqOqad50lMsdumyeBDuQaVH0kdi
        XWnh4N5oLGq4ddBVNINNmhgpmMCYpgwl59rteXPD/kVyd9bWXR8ShzhCQoztf+rBNxYE71
        376A5TAKSj/FnJt9lXURB4Cud9XyjrFKaYSntdW40cOgQApQmwyeTyUKmeZxhA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1649930649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcY9Hn0kFsYZKs9iRJ4rMEvAPY/YiAmALNRWdF31xqs=;
        b=wcIv6A3QlIhhOPXVNxC4qJxXjFG8q4ozO0xQOnN6ln6620AueRX70JZwy4jAfMK0BOStSN
        eMEYi+aHMkXYPupTnDgTrHGvbRdv6njF9EzgRlHZ44xffkOykIHNWhue9iewDpZD0TJXZp
        cPhVxnTqrno7WQUz/nbm24+N7DerdH3plXb5XXFkYm4HDiWwr2+J+3kPcZCSgF+8wH961t
        Dg0tS4envVgQB7TgMj9ZWgJanVf8Pp04AG+FU2IxYHsVlZPXLGH7Z9ATimi0+X7aQchzLS
        wt7jpIH0dXxWASdW/Gg/PS4xQfsqPw5kNfdrAYIbAiJBB8+UL4hLtIdWIntaUg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, Mar 29, 2022 at 04:25:26PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this representative issue
> atomisp-ov2722.c:920:3: warning: 3rd function call
>   argument is an uninitialized value
>   dev_err(&client->dev, "sensor_id_high = 0x%x\n", high);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> high and low are only set when ov2722_read_reg() is successful.
> Reporting the high value when there is an error is not
> meaningful.  The later read for low is not checked.  high
> and low are or-ed together and checked against a non zero
> value.
> 
> Remove the unneeded error reporting for high.  Initialize
> high and low to 0 and use the id check to determine if
> the reads were successful
> 
> The later read for revision is not checked.  If it
> fails the old high value will be used and the revision
> will be misreported.
> 
> Since the revision is only reported and not checked or
> stored it is not necessary to return if the read with
> successful.  This makes the ret variable unnecessary
> so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  .../media/atomisp/i2c/atomisp-ov2722.c        | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> index da98094d7094..d5d099ac1b70 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> @@ -906,22 +906,17 @@ static int ov2722_get_fmt(struct v4l2_subdev *sd,
>  static int ov2722_detect(struct i2c_client *client)
>  {
>  	struct i2c_adapter *adapter = client->adapter;
> -	u16 high, low;
> -	int ret;
> +	u16 high = 0, low = 0;
>  	u16 id;
>  	u8 revision;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
>  		return -ENODEV;
>  
> -	ret = ov2722_read_reg(client, OV2722_8BIT,
> -			      OV2722_SC_CMMN_CHIP_ID_H, &high);
> -	if (ret) {
> -		dev_err(&client->dev, "sensor_id_high = 0x%x\n", high);
> -		return -ENODEV;
> -	}
> -	ret = ov2722_read_reg(client, OV2722_8BIT,
> -			      OV2722_SC_CMMN_CHIP_ID_L, &low);
> +	ov2722_read_reg(client, OV2722_8BIT,
> +			OV2722_SC_CMMN_CHIP_ID_H, &high);
> +	ov2722_read_reg(client, OV2722_8BIT,
> +			OV2722_SC_CMMN_CHIP_ID_L, &low);

You should check the return value as it's an entirely different problem not
being able to access the device than reading back wrong identification
information.

>  	id = (high << 8) | low;
>  
>  	if ((id != OV2722_ID) && (id != OV2720_ID)) {
> @@ -929,8 +924,9 @@ static int ov2722_detect(struct i2c_client *client)
>  		return -ENODEV;
>  	}
>  
> -	ret = ov2722_read_reg(client, OV2722_8BIT,
> -			      OV2722_SC_CMMN_SUB_ID, &high);
> +	high = 0;
> +	ov2722_read_reg(client, OV2722_8BIT,
> +			OV2722_SC_CMMN_SUB_ID, &high);
>  	revision = (u8)high & 0x0f;
>  
>  	dev_dbg(&client->dev, "sensor_revision = 0x%x\n", revision);

This will also mean failure to read the revision is reported as revision 0.

These were the problems that pre-existed the patch, so if you're willing to
address these, please send v2 (would be nice). I can also merge this.

-- 
Kind regards,

Sakari Ailus
