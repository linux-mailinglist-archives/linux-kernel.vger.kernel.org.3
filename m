Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904DE4C0EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbiBWJJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiBWJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:09:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12128021C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:09:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id x15so4042665wrg.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uhQ2XTHzgwwh3IfSpyyiABP4apEdC3n0uRKIA365nw8=;
        b=yX7IDc6xgr2DIKYR1fbQdrsvoUEjEPM1JMICqwirtbbhG6Kkujf20LxovE/4LyHp86
         WRTevNNne+t4clDGmaDCAoCdMUC/M3I8wEtIhi1huBATspu/YvOfPPGXKES+9IlrA65w
         EXoVM6ESTjP9rO5vMWBYxQCFnWTAruvdxZNUDQFmuPR8eRcRdAQK2GehMRaXRZvx8lHL
         X7scUpwu7mdXWM8MWFPjsjQB5ji6ERhWdJFnQOMjEa0/CW6aB/A8Z+0X/UK+apIoPao5
         sfMnODhvNAUrgOqsX08SWAqSFTPhm3wk6PxcYF5Xl9lSSE2zpYYEzi6qZd0hSRnIBSjm
         6oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uhQ2XTHzgwwh3IfSpyyiABP4apEdC3n0uRKIA365nw8=;
        b=uaZ0OyC7gKgLXNt7e4Ej/Gco6XhaRY4zaImJFSnWeamq04svpVLnrXvnp5LW+x32Tt
         qRFqhHQXMSYO8xZzafu3bgFXE1/b4/nZIZ2vNt8GFDd8zvR8yDYlOXSfnkz07P/ts+XT
         wY8UviTULcfY2wbPTddFERNOIMI2wNV+Tc1sD/260ELlYe33GFZ0BVPBxkbBzpqCwCDa
         6Y8PD5Bb9zClF4gor7av/3x0GEsTbU7qF2mJtmafGoMSWkU224Ms5DyCYU1eSb7HeK9D
         FjgS9EG3zHf3q8LFB5HRaJzF0NYnTzgoTj4pLzE4lenDJozPMzRYxuH7w+lv48KPFsj9
         wOng==
X-Gm-Message-State: AOAM530T7gS1ytzgwT038yXzNtZ04TAOnQvmG1QQnAtfecfzcsZ0uR4E
        MyQLDVRSr6CS2MFOnL4OkptYFg==
X-Google-Smtp-Source: ABdhPJz4aTObHNoB5pQsllecyuXgnwlJz4HBUpJXFkjadBwKL0W5K/YET+9QFNOJiVbsLvUssTBxUA==
X-Received: by 2002:a5d:4b4c:0:b0:1dc:f34a:548 with SMTP id w12-20020a5d4b4c000000b001dcf34a0548mr22346654wrs.554.1645607349429;
        Wed, 23 Feb 2022 01:09:09 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id x2-20020a7bc762000000b00380fd1ba4ebsm526819wmk.9.2022.02.23.01.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:09:08 -0800 (PST)
Date:   Wed, 23 Feb 2022 09:09:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        conor.dooley@microchip.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org, jassisinghbrar@gmail.com,
        thierry.reding@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, geert@linux-m68k.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org,
        lewis.hanly@microchip.com, daire.mcnamara@microchip.com,
        ivan.griffin@microchip.com, atishp@rivosinc.com,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v7 05/11] dt-bindings: pwm: add microchip corepwm binding
Message-ID: <YhX5suBeOgHKqcVa@google.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
 <20220214135840.168236-6-conor.dooley@microchip.com>
 <20220223062018.nbgidqxgh2soz625@pengutronix.de>
 <65edc257-82ec-e100-7a44-5c510aba51ce@canonical.com>
 <20220223082018.degrftmxpk5uc6xn@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223082018.degrftmxpk5uc6xn@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022, Uwe Kleine-König wrote:

> On Wed, Feb 23, 2022 at 08:12:49AM +0100, Krzysztof Kozlowski wrote:
> > On 23/02/2022 07:20, Uwe Kleine-König wrote:
> > > On Mon, Feb 14, 2022 at 01:58:35PM +0000, conor.dooley@microchip.com wrote:
> > >> From: Conor Dooley <conor.dooley@microchip.com>
> > >>
> > >> Add device tree bindings for the Microchip fpga fabric based "core" PWM
> > >> controller.
> > >>
> > >> Reviewed-by: Rob Herring <robh@kernel.org>
> > >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > 
> > > I like it:
> > > 
> > > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > 
> > > nitpick: Put your S-o-b last in the commit log. (This doesn't justify a
> > > resend IMHO)
> > 
> > It should be the opposite - the first. First author signs the patch,
> > then comes review and finally an ack. Putting SoB at then suggests that
> > tags were accumulated before sending patch, out of mailing list.
> 
> well, or in an earlier revision of this patch as is the case here. One
> of the ideas of S-o-b is that the order shows the flow of the patch
> states and if this patch ends in git with:
> 
> 	Referred-by: Rob Herring <robh@kernel.org>
> 	Singed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 	Backed-by: Palmer Dabbelt <palmer@rivosinc.com>
> 	Singed-off-by: Peter Maintainer <pm@example.com>
> 
> I'd expect that Backed-by was added by Peter, not Conor.
> (Modified the tags on purpose to not interfere with b4's tag pickup, I
> guess you humans still get the point.)

I tend to like *-by tags to appear chronologically.

  Suggested              (suggested-by)
  Authored               (signed-off-by)
  Co-Authored            (signed-off-by/co-developed-by)
  Reviewed/Acked/Tested  (reviewed-by/acked-by/tested-by)
  Committed              (signed-off-by)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
