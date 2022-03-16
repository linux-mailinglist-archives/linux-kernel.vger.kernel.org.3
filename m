Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69784DB4F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiCPPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357296AbiCPPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:32:55 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFC46D1A5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:31:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id r127so2118016qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fvUEMkANfvf1LokJRMq/1veBU2UqMcQQnQtywgAigRI=;
        b=d80bWadomzISLDXuQxFymTYBDQhXnZ/mtf4OPE9nlrZvuhycUpl2BR/lqMnLjFexkA
         cz93kqCvObc57xjq3czpcd98F7WCOFLuTgy89Jlu6YiZaWR2qG0Ofnh/IIB5sGS8QDPH
         s555AxxndZayMBMuqYX5BZcSh8qXJgPIWcuQZRYjU8hFtQWRxN0tFuvz9gBlyKOYnsNj
         5LlQJ43C8qjEsJsEDf9UsdLk4X4pPb0gdjfO2INSV/eYPE5WvVjZ2V5sknTYvu+WAiyJ
         mcmAI/v9qLw+9b2EW07rneccOuXY1qFjZ2eolCpce3CmVpz0L3ggkcNBfYKzX82tzc5t
         C77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fvUEMkANfvf1LokJRMq/1veBU2UqMcQQnQtywgAigRI=;
        b=kCN4MP6NqQU9D52rg/RffC03AlPRD0TZ8J0d0cHHmgCvWwajeWNBrvGy2X7K5BtGtn
         JKz0nwTKes4hjEa0bciSQRNeiVY+cyZO+zBXKGb8CGFvNJ5PGHGti8UGYaO4UExPgTyj
         kUfvcEL9hWKbRmZGKVMsbVhqZo7XGIY6cfkFrVOBZ+JTQt7VAlXHYTxUM4ScDc0rNYxE
         s/tZmv8U08xAb4NLXBkaKlcoqLN3pX9DmDQHKQIcvPuhg1Jleu6PkuC+af5oOlXwZiAx
         RKYIZzZ0DoL3UYJjmppnBHdL4bl45+NthiISd81Dd1ztRU2CDNk87OBCfWb1hWMb9pWC
         uvNQ==
X-Gm-Message-State: AOAM530hTtengVCP2otZenWsyzLeDiFOf/x7XdWqKRowiF5lpFKzcSK7
        SWoqrsG+hKpnWb2BON5I2gU=
X-Google-Smtp-Source: ABdhPJzL0GnhUQijBfqEnzCXk3OMwUE1pADaOHXgKMBoVfqrxenHsrvZfR3aDWQ5vPE7LyP/+hd7bw==
X-Received: by 2002:a05:620a:2808:b0:67d:730d:d4e4 with SMTP id f8-20020a05620a280800b0067d730dd4e4mr244493qkp.431.1647444697108;
        Wed, 16 Mar 2022 08:31:37 -0700 (PDT)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id k10-20020a05622a03ca00b002e0684cf81fsm1475321qtx.73.2022.03.16.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:31:36 -0700 (PDT)
Date:   Wed, 16 Mar 2022 11:31:34 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Roger Quadros <rogerq@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: ti: omap-usb2: Fix error handling in
 omap_usb2_enable_clocks
Message-ID: <YjIC1hWuVN3qkdqx@shaak>
References: <20220316024155.23464-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316024155.23464-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 02:41:53AM +0000, Miaoqian Lin wrote:
> The corresponding API for clk_prepare_enable is clk_disable_unprepare,
> other than clk_disable_unprepare.
> 
> Fix this by changing clk_disable to clk_disable_unprepare.

There seems to be a typo in the first sentence of the commit message.
Maybe something like this would do:

	The corresponding API for clk_prepare_enable is clk_disable_unprepare.
	Make sure that the clock is unprepared on exit by changing clk_disable
	to clk_disable_unprepare.

> 
> Fixes: ed31ee7cf1fe ("phy: ti: usb2: Fix logic on -EPROBE_DEFER")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Other than that,

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> ---
>  drivers/phy/ti/phy-omap-usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
> index 3a505fe5715a..31a775877f6e 100644
> --- a/drivers/phy/ti/phy-omap-usb2.c
> +++ b/drivers/phy/ti/phy-omap-usb2.c
> @@ -215,7 +215,7 @@ static int omap_usb2_enable_clocks(struct omap_usb *phy)
>  	return 0;
>  
>  err1:
> -	clk_disable(phy->wkupclk);
> +	clk_disable_unprepare(phy->wkupclk);
>  
>  err0:
>  	return ret;
> -- 
> 2.17.1
> 
