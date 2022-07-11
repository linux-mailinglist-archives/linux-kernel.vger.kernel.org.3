Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C34E56D34E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiGKDT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKDT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:19:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6A01261F;
        Sun, 10 Jul 2022 20:19:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d10so3706857pfd.9;
        Sun, 10 Jul 2022 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m/eEy6L4UQDtY1BotOMeI2Dx9g/qzKVSsKl6BSoArx4=;
        b=RNVRb7/2C/VDePY2A2j3+Hr5j2acvuk+T0cl7gnH5KOmZllN9z7uGAjg63goN7sbTx
         Y5gWno53F3aCOfmUpG60OETMOg+fzhOPzpxEpTHqrg+8G6Ye4vtPzwV56IPA3Lkm6XJZ
         P6OKEBFQhvjmjp92V7sOVCbeD71EbgnWrtuhC30xC50zUhmXt4dzb9XPn8OzYVcnp6LF
         aXnWTQZ+kLFELK4XAXp7J5MmZ3/h5J7yqLxaBre2vK2Jezgs9iJ3CE1zWEZxaBMJXgcy
         fUYp6ixv2FIQSDFnfhzHiA6TARlGObHXyCXfwXr8iyRGwzKQetLqGljRirxToYWMzrsX
         WeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/eEy6L4UQDtY1BotOMeI2Dx9g/qzKVSsKl6BSoArx4=;
        b=xzA86qJ/0d+vb4RX321mDJ8FXihJklPL/wfM6wqV7B0FwGy+unoJYFZgK0+IWqL3E8
         CnCRlCKNRjFJ70jfTAhLAMUolHAj804BJeRwRD9r3MMbo8oyihOrpPOEV12m/N4NnVOr
         gPJ+l7wfTtfftUQfhfqk+Vjtdiws9baZGEv7ZRr3VmJ1oNT0H/AyT57jmlW3Gt+oG1S1
         7SrDvzHOWxK6AlN6YYeqBfbRYeUy81VWKec/wepJM5lUMjfMZMSTpoiRJrkn71qwQRj4
         032DtIyrgaleTyyf5fX1rfGvw8IrzIP0Uq7EU1gELLTd2SgwC+HirEb4fTcAZ9rz4Cjm
         KgPw==
X-Gm-Message-State: AJIora+iRCvfSppxNugreFP0KTy2IO0g7BGvjHNaNwJ5g/7MDaaa99za
        0ENEH7Tq29umZZ7WnkfFuxU=
X-Google-Smtp-Source: AGRyM1ssqIuZ1tVfP//Qy3SpP3JG7zS+60OW6FiREVGxNSWo8ISKf53tJ/Jx3GebL7ZTLVU8/g6X6Q==
X-Received: by 2002:a05:6a02:18b:b0:415:c9d:4e3c with SMTP id bj11-20020a056a02018b00b004150c9d4e3cmr13802826pgb.580.1657509564074;
        Sun, 10 Jul 2022 20:19:24 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:fe1c:af2d:8734:b8ac])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b0016bee668a62sm3446057plk.108.2022.07.10.20.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 20:19:23 -0700 (PDT)
Date:   Sun, 10 Jul 2022 20:19:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Liang He <windhl@126.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] input/serio: Fix refcount leak bug in i8042-sparcio
Message-ID: <YsuWuJTQsMlQabqt@google.com>
References: <20220619073036.4067872-1-windhl@126.com>
 <YskI088DEjt39Dqm@google.com>
 <5b7bcbf5.3f6.181e5c0dcff.Coremail.windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7bcbf5.3f6.181e5c0dcff.Coremail.windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 09:37:10AM +0800, Liang He wrote:
> At 2022-07-09 12:49:23, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> >Hi Liang,
> >
> >On Sun, Jun 19, 2022 at 03:30:36PM +0800, Liang He wrote:
> >> In i8042_platform_init() and i8042_platform_exit(), we need call
> >> of_node_put() to keep refcount balance.
> >> 
> >> Signed-off-by: Liang He <windhl@126.com>
> >> ---
> >>  drivers/input/serio/i8042-sparcio.h | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> >> index fce76812843b..a2a9db9220d7 100644
> >> --- a/drivers/input/serio/i8042-sparcio.h
> >> +++ b/drivers/input/serio/i8042-sparcio.h
> >> @@ -108,6 +108,8 @@ static int __init i8042_platform_init(void)
> >>  	struct device_node *root = of_find_node_by_path("/");
> >>  	const char *name = of_get_property(root, "name", NULL);
> >>  
> >> +	of_node_put(root);
> >> +
> >>  	if (name && !strcmp(name, "SUNW,JavaStation-1")) {
> >>  		/* Hardcoded values for MrCoffee.  */
> >>  		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
> >> @@ -139,6 +141,8 @@ static inline void i8042_platform_exit(void)
> >>  	struct device_node *root = of_find_node_by_path("/");
> >>  	const char *name = of_get_property(root, "name", NULL);
> >>  
> >> +	of_node_put(root);
> >> +
> >>  	if (!name || strcmp(name, "SUNW,JavaStation-1"))
> >>  		platform_driver_unregister(&sparc_i8042_driver);
> >>  }
> >
> >There already was an attempt to fix this issue in a slightly better way,
> >unfortunately the original author did not finish the work:
> >
> >https://lore.kernel.org/all/20181212163548.23723-1-tiny.windzz@gmail.com/
> >
> >Thanks.
> >
> >-- 
> >Dmitry
> 
> Hi, Dmirtry,
> 
> Thanks for reviewing my patch code.
> 
> The Li's patch adds a helper and is better than mine.

Right, however there is a compile error in Li's version. It would be
great if someone could finish their work.

Thanks.

-- 
Dmitry
