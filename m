Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC84A8FF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355146AbiBCVap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355102AbiBCVac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:30:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E9C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:30:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l25so7487621wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=eLtxMu1DHbPYv+1+Wx6o1hY4eDgPaiS8O9Bropk6P00=;
        b=jjqQp65RwA4C4mc/Rti9l3uCj4mwjs/uHYqOgjHGkKlkz2gTrMHZFVgvr5hKtddl5h
         d3FXIeaog2lxw7qEA83v6yihnmz+9eJsO9inTJgrKSnXqZ2cbYz7YwsIV2DpBp64Rnz/
         S0uyL72Z0I4CkJrhG+wOefosqiWkcsLh+JPJP+6ihcyKagrlWTrjCSGx9hdXMZjS6Ddu
         2ORKQ6s8lpE/v7t724o3LKQe+w06DZGEBnuv92XYs50FMN41zE9tlJnRYGeoEWZMFfvR
         vjzStaWrUdLzepgiNi35s/UJ6cHpXPDT5kzxmIAjmDtL3GdRh5SA8LxUeMTs8baDMR5A
         zJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=eLtxMu1DHbPYv+1+Wx6o1hY4eDgPaiS8O9Bropk6P00=;
        b=TfC4fDqslWuq32nnz4rMz4U75Y4YzRsTX7yD+ajSCVkuEw2Q0g/yd+ilUkIPfqU4Iz
         pq0yyqjSzghs2cMFGbPcqZsubFCgfrl4phKcUECjZfIsXpAE4J0cZbk9kF1uiJ199m90
         7Dkzrv+yxUY3zO09bQNT4x3b8tx2hSreHuBXFybGdXGr6Iokdyi67Dqt8iuVHD7r8TF3
         /6eC1PZdk0ZVbLDvylf/kXHySEb6SmhGBOU3HHph3NfsEQeoDkL0PFJ6JY7qkfBJpoZH
         0+XbDXimvVYW/e3zYylF94Ozox+mkFIwjXQellpSQwXMMYXWJGt0ACDv/FSSvxp6ixdQ
         w16Q==
X-Gm-Message-State: AOAM530hb3pPY6Nm5enzQr9byJkxGVSAGF0zvJJk4IAqQw8claL4ZPkE
        CniSei6lTA5hBvEftv4r2PDOzzgA2gPcfA==
X-Google-Smtp-Source: ABdhPJwHtOk3wiYJFKk7sUHXuUR2ebt4vGP9JIISgADFGAnzeBo/VN70wErvywJhnD+BM0wGe++xmA==
X-Received: by 2002:a5d:5344:: with SMTP id t4mr30658226wrv.311.1643923830346;
        Thu, 03 Feb 2022 13:30:30 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id h8sm1945498wre.89.2022.02.03.13.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 13:30:29 -0800 (PST)
Message-ID: <3e4c648f-0869-2e99-35d4-46c883ed2cdc@gmail.com>
Date:   Thu, 3 Feb 2022 21:30:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] media: i2c: Fix pixel array positions in ov8865
Content-Language: en-US
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     sakari.ailus@linux.intel.com, paul.kocialkowski@bootlin.com,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
References: <20220203212303.633399-1-djrscally@gmail.com>
In-Reply-To: <20220203212303.633399-1-djrscally@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry all, missed media...let me resend this.

On 03/02/2022 21:23, Daniel Scally wrote:
> The ov8865's datasheet gives the pixel array as 3296x2528, and the
> active portion as the centre 3264x2448. This makes for a top offset
> of 40 and a left offset of 16, not 32 and 80.
>
> Fixes: acd25e220921 ("media: i2c: Add .get_selection() support to ov8865")
>
> Reported-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
>  drivers/media/i2c/ov8865.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
> index d9d016cfa9ac..53e21ae8e886 100644
> --- a/drivers/media/i2c/ov8865.c
> +++ b/drivers/media/i2c/ov8865.c
> @@ -457,8 +457,8 @@
>  
>  #define OV8865_NATIVE_WIDTH			3296
>  #define OV8865_NATIVE_HEIGHT			2528
> -#define OV8865_ACTIVE_START_TOP			32
> -#define OV8865_ACTIVE_START_LEFT		80
> +#define OV8865_ACTIVE_START_TOP			40
> +#define OV8865_ACTIVE_START_LEFT		16
>  #define OV8865_ACTIVE_WIDTH			3264
>  #define OV8865_ACTIVE_HEIGHT			2448
>  
