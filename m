Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835FC4E1DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbiCTVMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbiCTVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:11:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63D1160C20;
        Sun, 20 Mar 2022 14:10:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v22so4472364wra.2;
        Sun, 20 Mar 2022 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SnrtPlmOffeZj6T7GE+tanB2uK1Y6oGCWk5gspUCR0Q=;
        b=dgDD7JBM5aF973Pd+bCKYP7HarHcawC9pIaR0mu/mSl7zG7daUDk3Ai8g+EdRhnhtG
         VGMUW5/JrtAtJ9QOXbM796A0wnAd2HdQ36ezr32V3Rmz+CeCof1/iOXUT3rToMJK/Gw/
         zJfjoh+cQ+jgJAX+DcGqJTx29ahYIB7vZin9eof4ufDYkpLOHmNMpYE9P7TMFgvI5EGD
         D5ghqND03oNtKXoeEvYS3igEYKK/dOQj67ybvZzY1YdA7I//3JuRG/WCnAiv/chCGibt
         tdzasKtdOPuNC3aTRvPQTt4qRK57U3jo3Wgw81T6QxydahCV0mGI28XP/QwEojzZcNP1
         3UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnrtPlmOffeZj6T7GE+tanB2uK1Y6oGCWk5gspUCR0Q=;
        b=kPK0nhGzD4GMo6Fs/DKL3QgVwhQyn0tG4qtZ1YKR3vySZHUAeoDS07ev0eU+0pLRXv
         XzqdGlZ3scqCL17m2osxWVfRDswnv23hJQEiMJUAybFpr4/PvVgdINfWwiOMg3PgriNc
         4vmkozMZPxN+TVzX6KXkTmkXDkG8/quEi8adTbjC8Yt7IFQ8ZVh1bUwxC5+hkjVXe6V5
         qwXfN6GNQ2EalW5ur1om5KgkY++xSc05h/SZDvOJmAVJKC4yjKJrWQJZp+Z3QLJK7T37
         bLSiSdG69ym8k4eFM5bcxrmvDsiR+csX1XeB7XOW+zBhJRPwLRNCwVmuAxN0+fU+SnzI
         YtSw==
X-Gm-Message-State: AOAM533Ps60O2NwOXzIAoyehneBqtCRAmBfKK4sBtaXfB7Wj/r/vP697
        xrmjQSb4CYnE6rRbtA/0dWw=
X-Google-Smtp-Source: ABdhPJwiU+n1q6r5/cPaRlWWrMm2PghCqUJO1nCR4tiXAbP510ymFnq2c37jzDiAJb/5AXhuZnU7Ow==
X-Received: by 2002:a05:6000:1e09:b0:204:44a:7837 with SMTP id bj9-20020a0560001e0900b00204044a7837mr5438144wrb.6.1647810634467;
        Sun, 20 Mar 2022 14:10:34 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4348000000b00203dbfa4ff2sm11613911wrr.34.2022.03.20.14.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:10:34 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: sun6i-rtc: include clk/sunxi-ng.h
Date:   Sun, 20 Mar 2022 22:10:32 +0100
Message-ID: <2620573.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20220320210905.6606-1-alexandre.belloni@bootlin.com>
References: <20220320210905.6606-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 20. marec 2022 ob 22:09:04 CET je Alexandre Belloni napisal(a):
> This solves:
> >> drivers/clk/sunxi-ng/ccu-sun6i-rtc.c:334:5: warning: no previous
> >> prototype for 'sun6i_rtc_ccu_probe' [-Wmissing-prototypes]
>      334 | int sun6i_rtc_ccu_probe(struct device *dev, void __iomem *reg)
> 
>          |     ^~~~~~~~~~~~~~~~~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c index 712fda22efd5..8a10bade7e0d
> 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> @@ -9,6 +9,8 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> 
> +#include <linux/clk/sunxi-ng.h>
> +
>  #include "ccu_common.h"
> 
>  #include "ccu_div.h"




