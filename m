Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43031499CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 23:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581929AbiAXWMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453227AbiAXV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:29:05 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B176C01D7F3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:19:05 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id w190so10942714pfw.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EsjxDBMm/CMDAK0wKf2bhoiQ9gqiwqZCH7vh6dCq6Nw=;
        b=GxbNEjo5OWuFsGAJ6mmDLTkptrYH98ruVoE6emQiNyVh4DXl2855c4/nQnzXH8aPBj
         kGbHAZd2bG6QzBtjtiEmzffG2UqPBg9D0nGasTg9KFpQKT10+8tQdS8wmLKb1NeMGNrd
         /kBh1KajfhLWZ9mzXBGIQqfCzQIIT2o+/wQBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EsjxDBMm/CMDAK0wKf2bhoiQ9gqiwqZCH7vh6dCq6Nw=;
        b=DEnoX+kuILLx7kvb6dmFNZeLVxusNnby7jzwlsEg1CZ9g4JDkxaD0B1RAPqDl+uFDY
         Znby2WJSMofvYtNuBlXzgbHjvQMwXIPrMx+RW9YsdkqE7SN147axVIJ/mK7dZMuNd+mx
         WMAXaru96I4fV0fdpVzQWzN5bXELFptFvsGPyy+3Mf53qJHK/y/vVO/9ccMtiTGxvXDs
         oFnh/uUQtgNCkvYuq81FdiAHnAzHPpCoSpZzshln88I/dh21uaYc0y0n8sMHHoRWsrnb
         +Xsgom4MuMdrpsxjTc29YEX1of3Op2buRNMAVjqJm9Os/CYXUqld+bThMz0u3dg9q0th
         i+kg==
X-Gm-Message-State: AOAM531PNHMESOKZR68IdOPRT483qXoEL3q1KDj0uzSGC6S4zViQyD22
        jLK5DXfhwx11dOqc6Jdf8HNkaA==
X-Google-Smtp-Source: ABdhPJxU9wiN3m+FHgY11ltcXHbduJ5dePRdoXqE1S7KFCWXf/pNbiUloQZQu6GMJjMSw1xiM3hh5w==
X-Received: by 2002:a63:7c06:: with SMTP id x6mr588413pgc.316.1643055544483;
        Mon, 24 Jan 2022 12:19:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x23sm3833982pfh.178.2022.01.24.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 12:19:04 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:19:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: greybus: i2c: Use struct_size() helper in
 gb_i2c_operation_create()
Message-ID: <202201241213.82E7D9F598@keescook>
References: <20220121222250.GA73021@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121222250.GA73021@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 04:22:50PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/staging/greybus/i2c.c:111:24: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/staging/greybus/i2c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/i2c.c b/drivers/staging/greybus/i2c.c
> index de2f6516da09..9dfc6791c20e 100644
> --- a/drivers/staging/greybus/i2c.c
> +++ b/drivers/staging/greybus/i2c.c
> @@ -108,9 +108,7 @@ gb_i2c_operation_create(struct gb_connection *connection,
>  		else
>  			data_out_size += (u32)msg->len;
>  
> -	request_size = sizeof(*request);
> -	request_size += msg_count * sizeof(*op);
> -	request_size += data_out_size;
> +	request_size = struct_size(request, ops, msg_count) + data_out_size;

This could still overflow if struct_size() returns SIZE_MAX. Perhaps:

	if (check_add_overflow(struct_size(request, ops, msg_count),
			       data_out_size, &request_size))
		request_size = SIZE_MAX;

I should brush off the saturating arithmetic helpers series:
https://lore.kernel.org/all/20210920180853.1825195-1-keescook@chromium.org/

>  
>  	/* Response consists only of incoming data */
>  	operation = gb_operation_create(connection, GB_I2C_TYPE_TRANSFER,
> -- 
> 2.27.0
> 

-- 
Kees Cook
