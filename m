Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484C75AA338
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiIAWkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiIAWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:39:59 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357BED77
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:39:49 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 996A35FD02;
        Fri,  2 Sep 2022 01:20:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1662070821;
        bh=m5OzpCBY5xuE3jZorKIuqGspvcaOEVjupOFluo1gzrU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=G3OFzgQkpGjifs5r0QrT0Ybal5rKvuS7+y48W5JZTIpRHNucQSLqMKX7F93vALHS8
         V0+nFJ/jiuV9V7NRbnM6hLMd5u82WEXwElnjTLaVoUCkLf9skJ95DkuirO/I0Yrb3f
         fo4w4Npq3RKHlNoUiD+sPnN535RYXo+OGJA7im3GlqoN4KgOWqfLehzlseyEhWdKoG
         mY+2rKhnryvQSgY7+rnuTp9gNy6cx7LLZgbRr2oA3krOPMcyBhuAwSVQ+Zc4eXcORL
         cdew1ud0LTZhfOSAxDEic9negx7xzGLgR87LOH3lH/OuqNBVjAmfABVidlqmFPZ9lO
         INtqN7d7srjxQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Sep 2022 01:20:20 +0300 (MSK)
Date:   Fri, 2 Sep 2022 01:20:20 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/3] regmap: trace: Remove useless check for NULL for
 bulk ops
Message-ID: <20220901222020.2iumldsfuhpseqci@Rockosov-MBP>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20220429
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/09/01 19:49:00 #20211246
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:23:34PM +0300, Andy Shevchenko wrote:
> If the buffer pointer is NULL we already are in troubles since
> regmap bulk API expects caller to provide valid parameters,
> it dereferences that without any checks before we call for
> traces.
> 
> Moreover, the current code will print garbage in the case of
> buffer is NULL and length is not 0.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/regmap/trace.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
> index 04329ba68ec5..e92edc4f4ca5 100644
> --- a/drivers/base/regmap/trace.h
> +++ b/drivers/base/regmap/trace.h
> @@ -82,8 +82,7 @@ DECLARE_EVENT_CLASS(regmap_bulk,
>  		__assign_str(name, regmap_name(map));
>  		__entry->reg = reg;
>  		__entry->val_len = val_len;
> -		if (val)
> -			memcpy(__get_dynamic_array(buf), val, val_len);
> +		memcpy(__get_dynamic_array(buf), val, val_len);
>  	),
>  
>  	TP_printk("%s reg=%x val=%s", __get_str(name),
> -- 
> 2.35.1
> 

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

-- 
Thank you,
Dmitry
