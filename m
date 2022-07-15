Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C65576AC6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiGOXeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiGOXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:34:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A153913E1C;
        Fri, 15 Jul 2022 16:34:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso7487532pjk.3;
        Fri, 15 Jul 2022 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HVuLWaX/51pe6iPKpZjM/AG01K4knnM/A3m3uAhbAQs=;
        b=Y8DVxR6sOawVEjaHLCXc1dJoDIL28pl/tbsDsHTC7h8M9ZMK/Qunzt1Po92GRQnLFD
         6ojEkwkeczjtyYJaRbl8xWrbftge7ceHpByaXgFxCAxk6Sjx3upElB7cJR/rUrxf9hxX
         ciMkiXbjnNhK2zMD21wKE+x3C5yqFcvY4UR8CLlzfeHCt7qV427MbwY07hEUr31H31P1
         6s4Z96mQme4sH+7IywQ87UHRW44iZFAfEFakEmCFayGok9AfaFIQw3qoJYJfO3nWhufc
         JUWcqoJqTR/7wsz89CIAMJR49+XZ6FihlU31Z7jsH931f1cgeHt8M2Su1/xGuCLXrgZF
         c1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=HVuLWaX/51pe6iPKpZjM/AG01K4knnM/A3m3uAhbAQs=;
        b=3pbCwChevjPxVRqB3+HNOE6HCOfQQHWuZSSf/NkHb1FJHo0E+4feOsLrMIBttzXCRR
         WyNiZAaZUgfRtAe3SuaVazkGSouMo2QcMT7xcaLplGvioW79Z6xMTuSTKaVGOr6hYhPL
         MGxhneWcsuIG7dSH4y2El5nCBiKeb7e1cvmzbr+qbj0lj/2d9BGeZ/ZvmtyptMmKwBUQ
         2b4QjUyIQNWZX8uYqaxU5HkSGQskgNBmS+LQ0GkChV4ndd+cT1g6Jh1nKZ2OaQT9O8JW
         xVPoERsiok5uI8KbUd4Fc6D9YZImqT4Sx3H07YtkJ6ERcRH0QPwFAqd6n0w+rLreoLe2
         amLA==
X-Gm-Message-State: AJIora8qFF4bLhsHTEJpQlBqVjjHFSN9VVJnizR2cMj435P39DCB6kbe
        Jxj/mmWnpUMhSXGJF03GWcQ=
X-Google-Smtp-Source: AGRyM1uM81+cKbKT3WGocUxAy5d1sDgAAMq6j/VwKs19GHZuTtzSuJ2OhHXu8WyZAUMGVKKTwS1R+w==
X-Received: by 2002:a17:902:d543:b0:16c:3150:9ba1 with SMTP id z3-20020a170902d54300b0016c31509ba1mr16469556plf.13.1657928050099;
        Fri, 15 Jul 2022 16:34:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b0016c2da4e73fsm4170878plg.106.2022.07.15.16.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 16:34:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 15 Jul 2022 16:34:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) increase fan tach period
 (again)
Message-ID: <20220715233408.GA2181024@roeck-us.net>
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

Patrick - any feedback ? Would it be possible to test this change with
Quanta-q71l ? Or do you envision no problems ?

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
