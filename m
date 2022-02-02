Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91404A70FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344195AbiBBMqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234582AbiBBMp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643805959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2MgpqkUcQy8xm2YEczHn5aMWVUVny42CQPa38ApqUo=;
        b=VBp3nBumZQG3y5BnoX/TJeVgV7ojZEiJgWPQPteEpPQVGeGJpsTEWoFLOEYg+/YRSJb25B
        uT4fp4fwhpqVFKc0VJ6jH2Vdn9buQqmTfO8q73JFUutQNEKZakt5g1suy51cpc6k/2k/Ey
        VBfXchn/8ijykm0+MXT5760YX9VhlEE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-2dT8xX2RPAC9InBHVL4mMQ-1; Wed, 02 Feb 2022 07:45:58 -0500
X-MC-Unique: 2dT8xX2RPAC9InBHVL4mMQ-1
Received: by mail-ej1-f70.google.com with SMTP id rl11-20020a170907216b00b006b73a611c1aso8053559ejb.22
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 04:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L2MgpqkUcQy8xm2YEczHn5aMWVUVny42CQPa38ApqUo=;
        b=p/OzGw2gLL4+KSixOzVJxYIRcx8eM7jLzM0W/TyTFVMhVnuBAPWXvcWaW1AY2704Fp
         oNFnAcZ9mU77icuZRfmsyeb3+lxQvK4OuqOHQ1q/wK15SaUEnwQk6zS1h0+ZzHEddv9N
         CbEGSANTi5A7y2sUXM2XXBhZnV91qYtSCHcBbv89HEQ8qF6t3gzOeYKrNlPwZKUMqs8W
         TWpraj4E4J47JEH3hrRcEigKxFxrn7mAlZAaqdt90cunEUT3fZ+iDrhnM9UrP9QXWg1e
         XFHMehAodcR6dHDyF3csP+VaIsJUQWMOo0NqlIPqDGDPdP5if7OKnCS5nmDaKjkeFP7y
         vuBA==
X-Gm-Message-State: AOAM531Aa6qrGebB/BaEFk69rFdqTbLeT64YH2/bERSdELVYMDqNmdNW
        jjSPBprBZwQ1uj/oM6eobF9dk89qcLybU09YJYsCu+Fd9ylBf9RHEgm0Ru5kFOC4hyQRgPyaKfh
        tEc4946UDrz+MBxtWvfIBlcH8
X-Received: by 2002:a05:6402:698:: with SMTP id f24mr30447153edy.159.1643805957168;
        Wed, 02 Feb 2022 04:45:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0BOt5vFNLNoU+2m3VvI1dwFENKVK9kPv+3YXwZ4YNAFwj6bqDiewZqYzq9PKmLgXw0q43hA==
X-Received: by 2002:a05:6402:698:: with SMTP id f24mr30447139edy.159.1643805957039;
        Wed, 02 Feb 2022 04:45:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id q6sm15775628ejx.113.2022.02.02.04.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 04:45:56 -0800 (PST)
Message-ID: <8386b5bf-46bd-5927-9119-cdf77e1df082@redhat.com>
Date:   Wed, 2 Feb 2022 13:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH][next] power: supply: axp288_fuel_gauge: Fix spelling
 mistake "resisitor" -> "resistor"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220202091246.580091-1-colin.i.king@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220202091246.580091-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/22 10:12, Colin Ian King wrote:
> There is a spelling mistake in a MODULE_PARM_DESC description. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Oops my bad, patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/power/supply/axp288_fuel_gauge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> index dcedbc59732d..13be2c1d6528 100644
> --- a/drivers/power/supply/axp288_fuel_gauge.c
> +++ b/drivers/power/supply/axp288_fuel_gauge.c
> @@ -91,7 +91,7 @@
>  
>  static bool no_current_sense_res;
>  module_param(no_current_sense_res, bool, 0444);
> -MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense resisitor");
> +MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense resistor");
>  
>  enum {
>  	QWBTU_IRQ = 0,
> 

