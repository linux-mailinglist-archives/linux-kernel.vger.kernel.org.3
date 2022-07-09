Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F13056C6E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 06:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGIE2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 00:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGIE2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 00:28:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C4F5F9D;
        Fri,  8 Jul 2022 21:28:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l12so359288plk.13;
        Fri, 08 Jul 2022 21:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P1ZmRAMQkKi+73jDKOIxJoV5SeHUxQ3O93b7K+9df6Q=;
        b=Sit6D4+D1IB11o9WUsG0USK8bmhZeOQMlIsXx5F/g1jWh9wShUczZQaKcpSDGwB4Gy
         xaRu+h0b6KwoNLvnxguvheLxaqD7/8aWeFp+eona6sOeWEydZJBFa1Q081VQGejzv9T2
         eeBIwAZQ4ofhcNaOiF5PcMiBV3DWTkGUApnOqpUD78jcCyWTO4y16Jf62zxLcGAn18Oy
         AGNqPNPxEJ5VqFbkSB4UxRoKtTywJcP/4Jyy5mLr7E69nujYaui7zlbyI2Tdxjdn5ywr
         96HY3RetQcLVmn4VDH1mn2LsiR2B+mi+2RUeMH3+SJYQE+UcwCcQ8BPVP9NaR5vLMwHd
         jdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P1ZmRAMQkKi+73jDKOIxJoV5SeHUxQ3O93b7K+9df6Q=;
        b=0wi/pTmZNFm7uF4JwygkbBBQRleBlfircXUlgNWDTkG6P3L0N5eohSiNsIc/7bcYwA
         6BiX3GqD/WovJAnTJoRFI8ubSKKpFJ4diBV1L5MXzIGevirxnvwHSnHjS2hCWgwgNVjh
         0/5F0eTbIHGzuokjnmusE4ys89lmD/9MEfxRj+8cFOrg2D0A3CbvAtLSQRj26DTWzk22
         1nnIHFbvytDB9XNgWAfdKjJQ2NWg+A76JdyiYW2ijpK1ifJ9cVVJUk5myrIGJZNkSWNG
         NxJystBLe5xGsMtHPEj7E3UE3uD9mx1AbYmBnuz2Kf65EDIlSQTcPr1F++xnBhKjxaVR
         jhWw==
X-Gm-Message-State: AJIora9WvlnPJ4awRjD5xrxr5BiD74lcEMUC0Z/15i4kZmn1wEDdADkc
        sOGp4BkJ8YNs5XuaZvwIs0M=
X-Google-Smtp-Source: AGRyM1t00kPzOqjiMw+aqKWQ/Di9XwgqWq0GXN4A6dkrdxlf+Q1NjP//JJDZF59HpfioK/NADLijEg==
X-Received: by 2002:a17:90a:eb17:b0:1ef:81d5:1fd0 with SMTP id j23-20020a17090aeb1700b001ef81d51fd0mr3936069pjz.29.1657340910456;
        Fri, 08 Jul 2022 21:28:30 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5011:9ea9:1cc2:a4c0])
        by smtp.gmail.com with ESMTPSA id u3-20020a627903000000b00528999fba99sm423242pfc.175.2022.07.08.21.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 21:28:29 -0700 (PDT)
Date:   Fri, 8 Jul 2022 21:28:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] i2c: Make remove callback return void
Message-ID: <YskD6/4iDgiIkV2G@google.com>
References: <20220628140313.74984-1-u.kleine-koenig@pengutronix.de>
 <20220628140313.74984-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628140313.74984-7-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:03:12PM +0200, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> The value returned by an i2c driver's remove function is mostly ignored.
> (Only an error message is printed if the value is non-zero that the
> error is ignored.)
> 
> So change the prototype of the remove function to return no value. This
> way driver authors are not tempted to assume that passing an error to
> the upper layer is a good idea. All drivers are adapted accordingly.
> There is no intended change of behaviour, all callbacks were prepared to
> return 0 before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
...
>  drivers/input/joystick/as5011.c                           | 4 +---
>  drivers/input/keyboard/adp5588-keys.c                     | 4 +---
>  drivers/input/keyboard/lm8323.c                           | 4 +---
>  drivers/input/keyboard/lm8333.c                           | 4 +---
>  drivers/input/keyboard/mcs_touchkey.c                     | 4 +---
>  drivers/input/keyboard/qt1070.c                           | 4 +---
>  drivers/input/keyboard/qt2160.c                           | 4 +---
>  drivers/input/keyboard/tca6416-keypad.c                   | 4 +---
>  drivers/input/misc/adxl34x-i2c.c                          | 4 +---
>  drivers/input/misc/bma150.c                               | 4 +---
>  drivers/input/misc/cma3000_d0x_i2c.c                      | 4 +---
>  drivers/input/misc/pcf8574_keypad.c                       | 4 +---
>  drivers/input/mouse/synaptics_i2c.c                       | 4 +---
>  drivers/input/rmi4/rmi_smbus.c                            | 4 +---
>  drivers/input/touchscreen/atmel_mxt_ts.c                  | 4 +---
>  drivers/input/touchscreen/bu21013_ts.c                    | 4 +---
>  drivers/input/touchscreen/cyttsp4_i2c.c                   | 4 +---
>  drivers/input/touchscreen/edt-ft5x06.c                    | 4 +---
>  drivers/input/touchscreen/goodix.c                        | 4 +---
>  drivers/input/touchscreen/migor_ts.c                      | 4 +---
>  drivers/input/touchscreen/s6sy761.c                       | 4 +---
>  drivers/input/touchscreen/stmfts.c                        | 4 +---

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
