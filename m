Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43C14D6369
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349213AbiCKO2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiCKO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:28:06 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307C1C7EBE;
        Fri, 11 Mar 2022 06:27:02 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id kj21so4180948qvb.11;
        Fri, 11 Mar 2022 06:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=68CWOwMSv2/Ly+nsrdhsAeru2Ba9NAAn2iQSzGZRvWw=;
        b=e80phwj1YfnVIQkA0sEcVr4EEbmZjZXtR69W+9YTHG9/Xr4JVpWwwJ77ToWSLiWOtp
         lFwbRR4x2S4g0pCpt1e1hZ6tesyDbupxZ6hi9qq21kkwDWcXP9RWpL1P34wesiYo5GIa
         q7zef1mS4kZziRLD/SWaz68A0da3ttJ/1DEwIPUuDGNz5niHr84Olzi7xXtf3UznDb06
         +lN6oO9lmFUPjGoKl2SQmfViF1QdDTf73Djt65lcGWl20lZeB9fVJp2+AFxlDoJmiuls
         T3BHYt6aNgS857fi53WJrz58N+84EdLG/4OiNzShY5eNeeMvg0QPxwQuFUmr0OPJc08D
         W5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=68CWOwMSv2/Ly+nsrdhsAeru2Ba9NAAn2iQSzGZRvWw=;
        b=xIXPddQdjVq6zzlpuqTy7WlSjo3/tNwjpmE2hUns+xYKwxIv+2uP/hx6ueg8qhQjYY
         cYuwrNYyvdiEahHwc1LkPimzCMdypHpb1m2dS+Q6A96rcA9//MtpU5SK1rr70HfEwlzq
         RLz/FTSArI8IB3BCAf+r2oXogyGpIQV0ySoHE06+Lq2M1/oel/odgmK7VlaoEXvSmlgg
         5YL8WbuHlMSg5ZgusUomPfl20wY52InZ3HebQawKe9CfHFsTkJ2Wk9I9zGe2oKEvMQNk
         +oihWjreKWyFELyfpbKE8j+oYIOvb6bCahScE1SlNvTBzlBLVYrOlzCjYenM7CNuUSbQ
         k3Lw==
X-Gm-Message-State: AOAM531+lGfv+bto5SHu+qacgLWHykmMwMo4R43fCzv3dzGBUEcIUnmu
        +qcy6ycZY945LWFr1VCjCloTbw4o+08=
X-Google-Smtp-Source: ABdhPJzYrYxFEBtuEGDzojfs9wfbRWu+moiK6O19yJfnRKv8Pwu9az9Y+jnx54mf4Vuc6/n6OmD2eA==
X-Received: by 2002:a05:6214:21c7:b0:435:3600:c1e3 with SMTP id d7-20020a05621421c700b004353600c1e3mr7871370qvh.127.1647008821732;
        Fri, 11 Mar 2022 06:27:01 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id p7-20020a05622a13c700b002de9f3894c2sm5632761qtk.50.2022.03.11.06.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:27:00 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:26:59 -0500
From:   Trevor Woerner <twoerner@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: 8250_fintek.c: Report chipID
Message-ID: <20220311142659.GA38527@localhost>
References: <20220311070203.18159-2-twoerner@gmail.com>
 <0fb3795e-0ab1-494b-aefd-ccfa78420723@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fb3795e-0ab1-494b-aefd-ccfa78420723@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thanks for your review.

On Fri 2022-03-11 @ 10:21:46 AM, Jiri Slaby wrote:
> On 11. 03. 22, 8:02, Trevor Woerner wrote:
> > Provide some feedback to confirm this driver is enabled, and specify which
> > chip was detected.
> 
> No, we don't do that. In fact, the output is mostly useless as it doesn't
> even tell the user what device this is about.

With this patch, when looking at the kernel's bootup messages one would see:

	[    1.809223] Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
	[    1.814420] Fintek F81865
	[    1.815783] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
	[    1.822078] Fintek F81865
	[    1.823453] 00:05: ttyS2 at I/O 0x3e8 (irq = 10, base_baud = 115200) is a 16550A
	[    1.829813] Fintek F81865
	[    1.831194] 00:06: ttyS3 at I/O 0x2e8 (irq = 10, base_baud = 115200) is a 16550A
	[    1.837556] Fintek F81865
	[    1.838943] 00:07: ttyS4 at I/O 0x2c0 (irq = 10, base_baud = 115200) is a 16550A
	[    1.845350] Fintek F81865
	[    1.846703] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A

…so the grouping would hopefully be a clue, and anyone looking up what a
fintek f81865 is would see that it's a SuperIO chip with 6 UARTs.

Ideally that information would all be on one line for each port. The first
line is what I've added, which specifies the actual device, and the second
line comes from serial_core.c's uart_report_port(). If there were a way to
pass the fintek information to serial_core, or a way to turn off serial_core's
uart_report_port() so I could report it in the fintek driver that would be
better, but neither of those exist.

If I want to know if a kernel has support for a device on my board I would
normally grep the dmesg output and look for a product id, a chip id, or a
manufacturer's name. I thought it was strange that with this driver enabled,
there's no hint that the kernel knows anything about it.

> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >   drivers/tty/serial/8250/8250_fintek.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> > index d9f0e546b1a1..03ad2354d808 100644
> > --- a/drivers/tty/serial/8250/8250_fintek.c
> > +++ b/drivers/tty/serial/8250/8250_fintek.c
> > @@ -155,11 +155,22 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
> >   	switch (chip) {
> >   	case CHIP_ID_F81865:
> > +		pr_info("Fintek F81865\n");
> > +		break;
> >   	case CHIP_ID_F81866:
> > +		pr_info("Fintek F81866\n");
> > +		break;
> >   	case CHIP_ID_F81966:
> > +		pr_info("Fintek F81966\n");
> > +		break;
> >   	case CHIP_ID_F81216AD:
> > +		pr_info("Fintek F81216AD\n");
> > +		break;
> >   	case CHIP_ID_F81216H:
> > +		pr_info("Fintek F81216H\n");
> > +		break;
> >   	case CHIP_ID_F81216:
> > +		pr_info("Fintek F81216\n");
> >   		break;
> >   	default:
> >   		return -ENODEV;
> 
> thanks,
> -- 
> js
