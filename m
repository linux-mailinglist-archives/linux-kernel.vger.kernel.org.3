Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1454D34D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347681AbiFOVHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346410AbiFOVHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:07:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D852B3F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:07:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o33-20020a17090a0a2400b001ea806e48c6so3161175pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pKnerP0WKDal7u9m+LdO1RGs6YAyfysE/6lEFisHbGE=;
        b=OmmPSO6/Zs33wbsY9ITS6D8SOSq9JOR7nnpZO4XjOSntdc7YeAOAeAqJgSx3sDP/GM
         16io1RiVzZEaJSVZhLHfSZRcMv4nxuOK8s6lubp09mybkib+IougP0mAAbxe5FgUFp5Q
         0GHFik+7U3jXhOWnI5+vKSOvMWN4picJxC0E1PDtzymPaI2ZcZufqcqqQtS6xIfpsA1I
         I/ci5Rjd57XtJnc+P0ejkB4unaqFiWH+Ai+y9l07r0Zguqe4kMmz3EWZ1AcrJ5utwV3i
         fqwHlFmik2RvxYWBjHn8IctF6CzLW8bSDpb9lkiaZNhRfhwHtOvjPYlO/XM0EQ942MKW
         8qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pKnerP0WKDal7u9m+LdO1RGs6YAyfysE/6lEFisHbGE=;
        b=w8Z3c0dzo803rYiId2A5hkN6KCXmV3wyk47NrDgFGiAo8V71V9uO3w/HsGTLuX2r6y
         gGfmVKQkR1OcfKqnqYb3xNKj+ndJr6ZDYaDv9DiIG0ApB8LRQ4fE1+ytiAf08fLKD6wi
         YDYiq0JRW5nEQP+EzS9aVkpAtK7jejk4KxvQP6zhlYHJ/GMpjnBS4VwdRAJvt1m0bZlC
         /ptnNnlyrzhh56wZesGCQUuMPd/Z4JY0h03oEvzACkAYs4ijNeq42FthtCQOvupq0Fy5
         zpobmMmNLj/Sf5kD0sL9nNid8nVf0WcQd74G/mz45qu2DLJqyDXNOS3XdCiYaAjpwSsW
         dkag==
X-Gm-Message-State: AJIora8uaRHXdgNjWvBfhP4FuXA7BMTl4+xzqBACasRCQy1dnqx8kcNt
        KL2js8ftF/eYL//lp4hCLc3SGQ==
X-Google-Smtp-Source: AGRyM1vlRZEPwY5tEMVK1om/J+526Yqqn2fwAX3XFEL2wRfvD8/j9jlYoarHUijrUD3PRm+KHR+BXA==
X-Received: by 2002:a17:903:1013:b0:163:e8b9:2429 with SMTP id a19-20020a170903101300b00163e8b92429mr1497693plb.74.1655327227175;
        Wed, 15 Jun 2022 14:07:07 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090a5d1100b001e0d4169365sm2304208pji.17.2022.06.15.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:07:06 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:07:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] mfd: tc6387xb: Drop disable callback that is never
 called
Message-ID: <YqpJ+GDjsMsILL4P@google.com>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
 <20220530192430.2108217-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530192430.2108217-4-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022, Uwe Kleine-König wrote:

> The driver never calls the disable callback, so drop the member from
> the platform struct and all callbacks from the actual platform datas.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-pxa/eseries.c  | 1 -
>  include/linux/mfd/tc6387xb.h | 1 -
>  2 files changed, 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
