Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED6533DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbiEYNc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbiEYNcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:32:52 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C383632A;
        Wed, 25 May 2022 06:32:49 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 98BBB24000B;
        Wed, 25 May 2022 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653485567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K2LLmMdA4vHYK7N2vJ1T6WRKIiii8VMOFALIJtd4D6w=;
        b=WLizWyxeP8bSi00jmOplHPRDBzG6UMRAOcv+dJ6Gxr4Z8ybrBSyOf/pnL1ON4vwvw3fdti
        hTwIqRcWcMTTjOrzDOOiRbeEj/1dxPACkT5XfxFZTX3/kRJ/6yZ9hKRJfRA81CF+7+oQ9F
        N5bwEZNQMxXm/HzdjcRZnAwxC7qDtBoMXa5zImRXdshOAzpPeMJCUAYE2D2lly6xkidzxL
        SRLTfH/77Lgi+b1J7nBH8Np1KznlniCOV1s0voi4+y5zwS7W9RSRuUTMiVKs26jo3fbRb4
        E+66YLaKF53MT+zSK2XLB7k1EPQ5TGXdVJnOKcgVEN762+9mAxGhMLtXd/iABg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Starke <daniel.starke@siemens.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] tty: n_gsm: Debug output allocation must use GFP_ATOMIC
In-Reply-To: <20220523155052.57129-1-tony@atomide.com>
References: <20220523155052.57129-1-tony@atomide.com>
Date:   Wed, 25 May 2022 15:32:46 +0200
Message-ID: <87sfoxyby9.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> Dan Carpenter <dan.carpenter@oracle.com> reported the following Smatch
> warning:
>
> drivers/tty/n_gsm.c:720 gsm_data_kick()
> warn: sleeping in atomic context
>
> This is because gsm_control_message() is holding a spin lock so
> gsm_hex_dump_bytes() needs to use GFP_ATOMIC instead of GFP_KERNEL.
>
> Fixes: 925ea0fa5277 ("tty: n_gsm: Fix packet data hex dump output")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>


Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>


> ---
>  drivers/tty/n_gsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -459,7 +459,7 @@ static void gsm_hex_dump_bytes(const char *fname, const u8 *data,
>  		return;
>  	}
>  
> -	prefix = kasprintf(GFP_KERNEL, "%s: ", fname);
> +	prefix = kasprintf(GFP_ATOMIC, "%s: ", fname);
>  	if (!prefix)
>  		return;
>  	print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET, 16, 1, data, len,
> -- 
> 2.36.1

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
