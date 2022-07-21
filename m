Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2B757C2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiGUDty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiGUDtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:49:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAFB45996;
        Wed, 20 Jul 2022 20:49:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y9so586709pff.12;
        Wed, 20 Jul 2022 20:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IhGndbcR3r1FDnhh3JNd9RckhpCoqpWOwPcG1TQZ3SY=;
        b=ASmnKm3TxcgaKpbrSK1DdfQza5i2zhoec+W2MZa/oEmT7NEJjMv5+zox8VZv19ocwh
         bMGiC1ENawk1x3aKc0pvKC86ERo1oiKo7//5F3qaoL/KBBXPeT+hDDTEbY9eiPSzrFWX
         LEZRpK9ncIUKcBu1RYXeswpKHZlHz2SG1PJwKOsKkNXEc/rE5AQ1NwasUbWt+IqPlSDe
         f5ueqqA+m2lZlLrw6eNw0X4iEX3ISYNW2bQ3FMYuYSdhjF851sKWFitT0z9U+3WLQa55
         8bPFMfow7d8ObPSYSKiYbEMrysp/Vkq25sGnyR49Rdr6vfQNatDWW6pAdqOJ9CyXXw1w
         VPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=IhGndbcR3r1FDnhh3JNd9RckhpCoqpWOwPcG1TQZ3SY=;
        b=sq86u0XHfKuS3c2ppjprm9KZDYJ8bbC0mUJ0GafooLbFiXZzyjkHRMIsnIvpB/ctlr
         qr307995uzCDvwgp/Ka+DCcoO9pNgs7jGqzzp1+l0oZ339M4uJuw1OJt+FRBdFsMtFpB
         cSO2ztWZfddaCEa9RokWGj8qQyJXiIX6Vcdmt7TciVVoSDglqyeZhLEAfjbNutm0QUWD
         HFuj+EUwDa2Ybu9EXVh/og4uZhXghmH7EyN+Uk/E7rwkaQ76Mu8zOJSvufGxF9eIUn0V
         f77nTrkMOmrhPO3j49U3Kt8umeApQ2zVi6Zlvw/j5KNqtHecv6yNlz2Q12nOcpHHkDa+
         tyZw==
X-Gm-Message-State: AJIora9k6IAItkI19sqaoaaxsKVCwU2L0ED0EkEy4oVtJoEYVRlqLppv
        wcwjis39HDktCcJdrbVbUdOun1Nou5V2RQ==
X-Google-Smtp-Source: AGRyM1tMSWVSmGatmv43AyRP8GID+Ov9Iki8PppurPj99s0mjpw22LjyH13wodRtIj9/V9FJF7o57Q==
X-Received: by 2002:aa7:8811:0:b0:52a:b0a4:a324 with SMTP id c17-20020aa78811000000b0052ab0a4a324mr42543906pfo.63.1658375387861;
        Wed, 20 Jul 2022 20:49:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b0016be96e07d1sm361930plh.121.2022.07.20.20.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 20:49:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 20 Jul 2022 20:49:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) increase fan tach period
 (again)
Message-ID: <20220721034946.GA1644072@roeck-us.net>
References: <20220714142344.27071-1-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714142344.27071-1-fercerpav@gmail.com>
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

On Thu, Jul 14, 2022 at 05:23:44PM +0300, Paul Fertser wrote:
> The old value allows measuring fan speeds down to about 970 RPM and
> gives timeout for anything less than that. It is problematic because it
> can also be used as an indicator for fan failure or absence.
> 
> Despite having read the relevant section of "ASPEED AST2500/AST2520 A2
> Datasheet – V1.7" multiple times I wasn't able to figure out what
> exactly "fan tach period" and "fan tach falling point of period" mean
> (both are set by the driver from the constant this patch is amending).
> 
> Experimentation with a Tioga Pass OCP board (AST2500 BMC) showed that
> value of 0x0108 gives time outs for speeds below 1500 RPM and the value
> offered by the patch is good for at least 750 RPM (the fans can't spin
> any slower so the lower bound is unknown). Measuring with the fans
> spinning takes about 30 ms, sometimes down to 18 ms, so about the same
> as with the previous value.
> 
> This constant was last changed in
> 762b1e88801357770889d013c5d20fe110d1f456.
> 
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>

I did not get any further feedback, so:

Applied to linux-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 3cb88d6fbec0..d11f674e3dc3 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -159,7 +159,7 @@
>   * 11: reserved.
>   */
>  #define M_TACH_MODE 0x02 /* 10b */
> -#define M_TACH_UNIT 0x0210
> +#define M_TACH_UNIT 0x0420
>  #define INIT_FAN_CTRL 0xFF
>  
>  /* How long we sleep in us while waiting for an RPM result. */
