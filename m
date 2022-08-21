Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE96259B1F7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiHUEwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 00:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUEv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 00:51:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE731EAEC
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:51:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m2so7277624pls.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=DoP5D0q5uq10qPqKZyI8ZyeoJp/Fm4FVEA1pggc97RE=;
        b=myAtWZPR3n2L5a2uXfJkMWGR1ztcMZm5w845T3S6uVau8vS/bEloJxXmvk6cvOi/3Y
         E19RlwtXTNJft6W4h+x1f7xelNtq42/Y4bOagZ+HJsxvIw+xW2YEgCZUzDCeN6Og8GWv
         1Z0qv42RbhuhUL0E7okkfc9i8muWpJQdIPbfH7FPZPWbPRSFqQzNRpMfxTaPX8lfitzB
         sKqE2X1LnQFKNp/pM/j3ZitgA1TmaM5JmfNklWdaY+0x7Llktl4uKmsPWmd6zm/VvSlF
         uG8OCYBDRf051vU4P/4DmgFkeMmqIYqKYNyYdRZ2OwzJjc+sOyuu+T5H1HKAnzaS6C09
         CJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=DoP5D0q5uq10qPqKZyI8ZyeoJp/Fm4FVEA1pggc97RE=;
        b=HRNv1/voWtIL/FFlexsPEfjQQbPHDovg2zBwGNqNgUwWMtC12vb/lcTXH5JXw4LZtf
         W7/8Vl07F5uUyNccdxevv5l5s0O7wTmNbhau/UqZHoy3bRrnfoWHUFfnVVImj9xO196s
         3NL45n3UGAGRp6funVMHYNF5+lE9AinX3/PLs6vZnc9qWe684f6H0ZN93k4HxOXbbC9Q
         jju42xv2f2OiIh7VBESOjsN3dNAnUt6s/O/e64vlTMd38ERSf5WwV7Cg1ZS2ZZhDJUYq
         my5in4hD74b6Zbp1V6ysxKJ6R/FBqMRR/DOO/s8dU90F840jJSl90IwdBEYmFEwzl2ca
         rP8Q==
X-Gm-Message-State: ACgBeo2sZ2Qsitqva8EUXq5dmNB1lFgZWM0X7ifLVKWaCKxfVsSXLToY
        BAxRmGvtoUQ2f6F8AyivYos=
X-Google-Smtp-Source: AA6agR6jFTcZ38ScQNkrKXr9tieWyesl9/CP4JCgWrO8XmdgeujTnsAPTI9TZJ5xdUsgbrPSe5e6Hg==
X-Received: by 2002:a17:90a:c402:b0:1f7:75ce:1206 with SMTP id i2-20020a17090ac40200b001f775ce1206mr16667833pjt.68.1661057516936;
        Sat, 20 Aug 2022 21:51:56 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2c40:97f7:f170:cdca])
        by smtp.gmail.com with ESMTPSA id n126-20020a622784000000b0053291ddd8e5sm3633772pfn.40.2022.08.20.21.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 21:51:56 -0700 (PDT)
Date:   Sat, 20 Aug 2022 21:51:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rustam Subkhankulov <subkhankulov@ispras.ru>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] platform/chrome: fix double-free in
 chromeos_laptop_prepare()
Message-ID: <YwG56T86sYkH/eCw@google.com>
References: <20220813220843.2373004-1-subkhankulov@ispras.ru>
 <YvnS7IKr/9VhffHX@google.com>
 <7d4dd8009a777a7d32f4872dc0285878dbbb91b8.camel@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d4dd8009a777a7d32f4872dc0285878dbbb91b8.camel@ispras.ru>
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 08:05:13PM +0300, Rustam Subkhankulov wrote:
> On Mon, 2022-08-15 at 05:00 +0000, Tzung-Bi Shih wrote:
> > Alternatively, I would prefer to fix the double-free by setting
> > `i2c_peripherals` to NULL after [1].
> 
> Since 'cros_laptop->num_i2c_peripherals' is assigned with nonzero value
> (otherwise the code on 'err_out' is not executed), setting 
> 'i2c_peripherals' to NULL after [1] will cause dereferencing of 
> NULL pointer in chromeos_laptop_destroy() at [2]. 
> 
> [1]:
> https://elixir.bootlin.com/linux/v5.19/source/drivers/platform/chrome/chromeos_laptop.c#L787
> [2]:
> https://elixir.bootlin.com/linux/v5.19/source/drivers/platform/chrome/chromeos_laptop.c#L860
> 
> > After a quick glance, I found an invalid memory access at [2] if
> > `i2c_peripherals` is NULL (see [3]). 
> 
> After applying the patch, there will be no invalid memory access at [2]
> if 'i2c_peripherals' is NULL, because in this situation 
> 'cros_laptop->num_i2c_peripherals' is zero and there is no single 
> iteration of the loop.

Yes, we should either reset both cros_laptop->i2c_peripherals and
cros_laptop->num_i2c_peripherals on error, or avoid setting them until
we are sure that we are not getting an error. I think prefer the latter.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
