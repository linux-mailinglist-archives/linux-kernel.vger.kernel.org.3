Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1E54637F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348122AbiFJKYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245446AbiFJKYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:24:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B528DFB7;
        Fri, 10 Jun 2022 03:24:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d19so16618899lji.10;
        Fri, 10 Jun 2022 03:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mQkg5BFcWf589C+wuulEqAsCmR3RQXLtbhuR5v5QD+Q=;
        b=l2+IJM229M3SPHh7e8DgjWAjrbApaXeUGaYU6B5FfKIRrgDeAvXZz+caPFdCePZGus
         n3EBieDnYjrDEyRGGEJQbvZN3361ADG9TH8Iqc9aE6nntloE6GkBfJd3V4VFDIyQlVNq
         u2gINhMYrP2b3WjmrU9JB2J7/aRQhnCccMo5YGL7+NfX/4uamau/Io1PLJIf5vrLKMbd
         dXNNhY8WgG3z79hP/kXytEFUPY5uwrbjaa9Vy71yiRRBhhsmBsumQvQ2k+R1kZXIWMaS
         MoGr8/iuiM92eAZ9i/zyVXKybD6gRV7dnxtIqEbNshK8dENbhQ8pcV9QsXih/cuXS+2c
         OUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mQkg5BFcWf589C+wuulEqAsCmR3RQXLtbhuR5v5QD+Q=;
        b=NyXQMlobysz246+GiVNy0Y4p9FB3/Ak7fItUFTunlJW7WDMARviESTW1fk7xU0QAVS
         ueZsrJkvsqBpJQfXp653Wo3qoU8Jao401rKSQAjg2RgcdXJzbdIH05iUB0xJDpzhKY8O
         6aJb7+4CEuFDHJH1+M66UNR0Ud0bAfB2ey5g/H6xzy7Ycr1yU/0/Hf+eAfeH7eqjAofD
         uQe8xVEQCnbP/slrrC8Q7RzL1mZxfi/H/8UT/jzpBltqwGJvznVAKa/W+0t9JLq0YuOj
         kqxiMGDhdgJcr73c0+5eFU3R0ImglSXN53AmE84b4vRVvtQ4u13DWFhVW1oABUcvIRcL
         +92Q==
X-Gm-Message-State: AOAM533Ny1KoXeYgVkqoE3o8UpTwsns/XI0hdjPbjb2xCQyyZsj9PthX
        nsRJuyKZJ4dYSIgbKqXFKIM=
X-Google-Smtp-Source: ABdhPJxgxcCtlb5Z+Y7tZ/ZH2Zooff5ggN8+p1CIxsDICuK0H9aEHtzuS0DOVgFRxpWe3OivTBz9zg==
X-Received: by 2002:a2e:b8c4:0:b0:258:f008:5b75 with SMTP id s4-20020a2eb8c4000000b00258f0085b75mr189727ljp.189.1654856682873;
        Fri, 10 Jun 2022 03:24:42 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id d21-20020a05651c089500b0025567827117sm4064786ljq.13.2022.06.10.03.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 03:24:42 -0700 (PDT)
Date:   Fri, 10 Jun 2022 13:24:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Marek Vasut <marek.vasut@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 2/8] clk: vc5: Fix 5P49V6901 outputs disabling when
 enabling FOD
Message-ID: <20220610102440.ubejkcbkwb7wgah6@mobilestation>
References: <20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru>
 <20220610072124.8714-3-Sergey.Semin@baikalelectronics.ru>
 <eb0cbc41-2868-4cbf-9fbf-eeabd25dda04@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0cbc41-2868-4cbf-9fbf-eeabd25dda04@omp.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 01:03:10PM +0300, Sergey Shtylyov wrote:
> On 6/10/22 10:21 AM, Serge Semin wrote:
> 
> > We have discovered random glitches during the system boot up procedure.
> > The problem investigation led us to the weird outcomes: when none of the
> > Renesas 5P49V6901 ports are explicitly enabled by the kernel driver, the
> > glitches disappeared. It was a mystery since the SoC external clock
> > domains were fed with different 5P49V6901 outputs. The driver code didn't
> > seem like bogus either. We almost despaired to find out a root cause when
> > the solution was found for a more modern revision of the chip. It turned
> > out the 5P49V6901 clock generator stopped its output for a short period of
> > time during the VC5_OUT_DIV_CONTROL register writing. The same problem has
> > was found for the 5P49V6965 revision of the chip and the was successfully
> 

>    s/was found/been found/, s/the was/that was/?

Right. Thanks.)

-Sergey

> 
> > fixed in commit fc336ae622df ("clk: vc5: fix output disabling when
> > enabling a FOD") by enabling the "bypass_sync" flag hidden inside "Unused
> > Factory Reserved Register". Even though the 5P49V6901 registers
> > description and programming guide doesn't provide any intel regarding that
> > flag, setting it up anyway in the officially unused register completely
> > eliminated the denoted glitches. Thus let's activate the functionality
> > submitted in commit fc336ae622df ("clk: vc5: fix output disabling when
> > enabling a FOD") for the Renesas 5P49V6901 chip too in order to remove
> > the ports implicit inter-dependency.
> > 
> > Fixes: dbf6b16f5683 ("clk: vc5: Add support for IDT VersaClock 5P49V6901")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> [...]
> 
> MBR, Sergey
