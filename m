Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8505AD9B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiIETfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIETfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:35:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56508192A1;
        Mon,  5 Sep 2022 12:35:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso12907779pjh.5;
        Mon, 05 Sep 2022 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7aEZor/0qSkVunoEHgQL2gSUt5mSZZxwcIrLRXXUv74=;
        b=kRz+EoKgbH/v5V+kWM9vI7suLFWPqh1wudHhCQsgYyToXNdfTMF3zkd+cxvGSDzDMg
         aV6HTEv+679+PSU/eajuEECNA5Tzi63P2u7ABofOyv+D57Tac8hnxfRh1VQhASbh+H2T
         cXTOTBvHFjMjMQWlLbr7neEN9hS+5zCzekuUSZjeKCJ5iPKlrTViWBE6u6+1xHBDqacf
         qr87isKsFggMsY4gH6JVNBJhTsBX7r2Op1Wwlzvm9hfMwa/iBu3UAFi08/6ylcVtvF9Y
         RdblgSyTuBK8BKb4mUwnden63M+73w2Cz4cZ3zSynyWKOsNJDLPHGEM5bUsuwOD4IzAc
         e3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7aEZor/0qSkVunoEHgQL2gSUt5mSZZxwcIrLRXXUv74=;
        b=hOhlAiPJZk9r0jPioRD+AnpnkO8yMRN7B1jIlC29rqVdJMmh9Kf7+ihhA3HKjKGqIU
         tDrqdJXT1hFVRh2RZq8toMB98eQjRJe7mfCD9CXmiZ1GejZ05sWUu1yfTuU4JOtYPewM
         bp7fxNQ41BRBbQNRhDMW5Z9ZLYMVnhqGIdAAWMfGrslE+eIIv13vFgiws+kdHqY7wfR5
         dV/CRtwtLPa5PFsvsn8vyPNCgtf1tbirm7vvdU8PCkmMu7TJ0E6UvzT/T58dauwuSzzJ
         zMX19ttvlIbYMEt3OdRksT53n95QqaNltSd551xRXXI6Ry5mXdrERu3/sn8i7+Bh+0nA
         AYoQ==
X-Gm-Message-State: ACgBeo0+ckiURzZgiqCYej8/eUCtIDkO5UOwl6Bm9+gJY7ioQNwmr4hc
        w5QsuJqbQz/6MDBEw72nrqs=
X-Google-Smtp-Source: AA6agR4nlC4q69eore5Hr67VeZeR0yfg6hIFeNYOz0SHVfhiZE5g9P4b0kNnrVIkGs2dos0edLe7LA==
X-Received: by 2002:a17:90a:cf06:b0:200:22cc:9380 with SMTP id h6-20020a17090acf0600b0020022cc9380mr13257332pju.43.1662406545578;
        Mon, 05 Sep 2022 12:35:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id z127-20020a623385000000b0053abb15b3d9sm8433309pfz.19.2022.09.05.12.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 12:35:45 -0700 (PDT)
Date:   Mon, 5 Sep 2022 12:35:42 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/1] Input: icn8505 - Utilize acpi_get_subsystem_id()
Message-ID: <YxZPjsRJXJijZ/K3@google.com>
References: <20220905172001.69244-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905172001.69244-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Sep 05, 2022 at 08:20:01PM +0300, Andy Shevchenko wrote:
> Replace open coded variant of recently introduced acpi_get_subsystem_id().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/input/touchscreen/chipone_icn8505.c | 29 ++++++---------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/touchscreen/chipone_icn8505.c
> index f9ca5502ac8c..bb5e63b87c5d 100644
> --- a/drivers/input/touchscreen/chipone_icn8505.c
> +++ b/drivers/input/touchscreen/chipone_icn8505.c
> @@ -364,32 +364,19 @@ static irqreturn_t icn8505_irq(int irq, void *dev_id)
>  
>  static int icn8505_probe_acpi(struct icn8505_data *icn8505, struct device *dev)
>  {
> -	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -	const char *subsys = "unknown";
> -	struct acpi_device *adev;
> -	union acpi_object *obj;
> -	acpi_status status;
> -
> -	adev = ACPI_COMPANION(dev);
> -	if (!adev)
> -		return -ENODEV;
> +	const char *subsys;
>  
> -	status = acpi_evaluate_object(adev->handle, "_SUB", NULL, &buffer);
> -	if (ACPI_SUCCESS(status)) {
> -		obj = buffer.pointer;
> -		if (obj->type == ACPI_TYPE_STRING)
> -			subsys = obj->string.pointer;
> -		else
> -			dev_warn(dev, "Warning ACPI _SUB did not return a string\n");
> -	} else {
> -		dev_warn(dev, "Warning ACPI _SUB failed: %#x\n", status);
> -		buffer.pointer = NULL;
> -	}
> +	subsys = acpi_get_subsystem_id(ACPI_HANDLE(dev));
> +	if (IS_ERR(subsys) && PTR_ERR(subsys) != -ENODATA)
> +		return PTR_ERR(subsys);
> +
> +	if (IS_ERR(subsys) && PTR_ERR(subsys) == -ENODATA)
> +		subsys = kstrdup_const("unknown", GFP_KERNEL);

Do we really need kstrdup_const() here? This makes me wonder if we need
to also have error handling here, and if we going to tip some automated
tools by not having it. Why can't we simply assign the constant here
(and continue using kfree_const() below)?

I think this is the case where PTR_ERR_OR_ZERO() might help avoid
multiple IS_ERR/PTR_ERR:

	subsys = acpi_get_subsystem_id(ACPI_HANDLE(dev));
	error = PTR_ERR_OR_ZERO(subsys);
	if (error == -ENODATA)
		subsys = "unknown";
	else if (error)
		return error;

>  
>  	snprintf(icn8505->firmware_name, sizeof(icn8505->firmware_name),
>  		 "chipone/icn8505-%s.fw", subsys);
>  
> -	kfree(buffer.pointer);
> +	kfree_const(subsys);
>  	return 0;
>  }
>  

Thanks.

-- 
Dmitry
