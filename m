Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE00E510A32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354896AbiDZUVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbiDZUVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:21:06 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810F7366A7;
        Tue, 26 Apr 2022 13:17:58 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v65so17247170oig.10;
        Tue, 26 Apr 2022 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5CTXaz+V6AADkCyMRViJwbGXG2CrQ/Q0Z8NFjTN9J94=;
        b=WqjlarLpd346YItChEmX1w1yTnpCSQvtL62OnCdSsFFteTGymSg1O5fZ3b/6Gy9E/d
         /EUOL1uRAjD+zJ/b3Ekm79vyfpl9c0JmDYRPS9hpUF5OXa6FNcQ8uRfp0GVbYWqNDDFD
         lg6JGxxkzaCPbGrriu4hqDk7oZBA31wW7B9jfjaQHQJ7rWENHTK3CqbcDSANrBlBcXGr
         3EXpAf10Cecy3nzRH39rnFeD+jDzG06J2+LiDox7Ts/7XA2ZE7bZ7q27K+g4XdPcJMnu
         ByfgYqbh7VMCKwDtYqLheWh9KciQAHaod4LQLrOz9y0UfvgNtVd8bzmQ6qDJEzuff/4e
         Ggag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5CTXaz+V6AADkCyMRViJwbGXG2CrQ/Q0Z8NFjTN9J94=;
        b=mKvSQRPN12+30ZCORhmZepdtqeH4z7Yb1pLHeiwyJe9ly0/vrNgZhSWfolrOWwIOeM
         2po+BeZpxMZQ/NNS4KB/Rv6aS9XfDqhCQlR9vDBdnBN3BJp+DI9mhmJyrHpYRMOTafUZ
         xecVBZ075A/DJnIks2M91Zt4t2f2HbfKXhuvdZcQSf7EFDzvlN/b/bhJh+prV0PEQuYL
         /kh+uiWr8qd3D8LMeOUCzB+yIstMkr13xL931G+O7hxScJL8WipmB/gm8qEH5yId3HsJ
         9vjaPPj66XAFIJ+XeDkbgjQYJvFJHrjJPpm33166zQjWG7GKuo/OUjcOzpPMjobsqRNu
         9IuQ==
X-Gm-Message-State: AOAM5305hEXBS2FQFz7rLqYB9SWx3f27xuCNzB7CTfEHiVqB+jNhRgB9
        uIinizTLHA81CMycrpSijgc=
X-Google-Smtp-Source: ABdhPJxlVQ24ZRLfHmX0K72G/7Bd7V0I9z01BMMNhFrpjI25E6aMB2ih6RvjvUQw1Qf992I1nEvEXw==
X-Received: by 2002:a05:6808:1202:b0:2f9:c7b4:fd56 with SMTP id a2-20020a056808120200b002f9c7b4fd56mr11287188oil.55.1651004277905;
        Tue, 26 Apr 2022 13:17:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k124-20020aca3d82000000b002ef4c5bb9dbsm5171253oia.0.2022.04.26.13.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:17:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 13:17:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (dell-smm) Warn if SMM call took a very long
 time to execute
Message-ID: <20220426201755.GN4093517@roeck-us.net>
References: <20220426200320.399435-1-W_Armin@gmx.de>
 <20220426200320.399435-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426200320.399435-4-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:03:20PM +0200, Armin Wolf wrote:
> If a particular SMM call takes a very long time to execute,
> the user might experience audio problems. Print a warning
> if a particular SMM call took over 0.250 seconds to execute,
> so the user can check whether or not possible audio problems
> are caused by this driver.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index f13902414615..b960330eaded 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -49,6 +49,9 @@
>  #define I8K_SMM_GET_DELL_SIG1	0xfea3
>  #define I8K_SMM_GET_DELL_SIG2	0xffa3
> 
> +/* in usecs */
> +#define DELL_SMM_MAX_DURATION  250000
> +
>  #define I8K_FAN_MULT		30
>  #define I8K_FAN_RPM_THRESHOLD	1000
>  #define I8K_MAX_TEMP		127
> @@ -239,6 +242,9 @@ static int i8k_smm_func(void *par)
>  	pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x  (took %7lld usecs)\n", eax, ebx,
>  		 (rc ? 0xffff : regs->eax & 0xffff), duration);
> 
> +	if (duration > DELL_SMM_MAX_DURATION)
> +		pr_warn("SMM call took %lld usecs!\n", duration);

pr_warn_once, maybe ? If this happens, it will happen a lot, and it doesn't
add much if any value to keep reporting the problem.

Guenter
