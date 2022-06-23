Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83DD557419
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiFWHld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiFWHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:41:30 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B94667F;
        Thu, 23 Jun 2022 00:41:27 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id mf9so18885457ejb.0;
        Thu, 23 Jun 2022 00:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZVb61+LDQ60uMHssCxzA52VpodCYtCxPvKQczsoS/1g=;
        b=HVWh8WCV4xy7bwrZ3xEvdRWTNk5kEm3FXnxFq4ihWOrrn9kk3KuCoV/ksv8uKbudbl
         iNbcC2GktafzMDmPsuAyb2Xi2M++IFJIt99XQTjtK/QTRnkqZq1uu0N13yqf+gYLal/y
         b9EpkZB/keHs07v4PobB2pSDCJTZ4bUODzYatpy6LvCEN+coSAeqK5URr9Hu5C69gzXm
         FZtPtzlt+Gry6wEZe9hXzFS6Tw7kkfjiqPX05zfsAfErIiGnQu783ab/tqCDbxLi3tKP
         Pxm5HXyQ8dadPzH/cKh74rmx5XuPqLvt/W2vVWLDKk+UxtYZtMS7E/wG9km1eBiAjwyy
         UiKA==
X-Gm-Message-State: AJIora/RWe5uxmqLhB9S4upxtihkhNB57foyrPlfeBrfn8YpwRhh6bPw
        uwryPUXtnMzEFllUSpmxkd0=
X-Google-Smtp-Source: AGRyM1s2wuY4k6dNlSI0R4cdqh9+8L6y5hbgB1bq0e+g38e35h84OG+g2Wa3dMgBb5qJWTGviQlp0A==
X-Received: by 2002:a17:906:6a1c:b0:70a:fd95:ee6a with SMTP id qw28-20020a1709066a1c00b0070afd95ee6amr6940892ejc.36.1655970086067;
        Thu, 23 Jun 2022 00:41:26 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b006f3ef214de7sm10485403ejc.77.2022.06.23.00.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:41:25 -0700 (PDT)
Message-ID: <03467516-3962-4ff2-23d2-2b3a1d647c5a@kernel.org>
Date:   Thu, 23 Jun 2022 09:41:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 6/6] serial: Consolidate BOTH_EMPTY use
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org, sparclinux@vger.kernel.org
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
 <20220621124958.3342-7-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220621124958.3342-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 06. 22, 14:49, Ilpo Järvinen wrote:
> Per file BOTH_EMPTY defines are littering our source code here and
> there. Define once in serial.h and create helper for the check
> too.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> --- a/arch/mips/ath79/early_printk.c
> +++ b/arch/mips/ath79/early_printk.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/io.h>
>   #include <linux/errno.h>
> +#include <linux/serial.h>
>   #include <linux/serial_reg.h>
>   #include <asm/addrspace.h>
>   #include <asm/setup.h>
> @@ -29,15 +30,15 @@ static inline void prom_putchar_wait(void __iomem *reg, u32 mask, u32 val)
>   	} while (1);
>   }
>   
> -#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
> -
>   static void prom_putchar_ar71xx(char ch)
>   {
>   	void __iomem *base = (void __iomem *)(KSEG1ADDR(AR71XX_UART_BASE));
>   
> -	prom_putchar_wait(base + UART_LSR * 4, BOTH_EMPTY, BOTH_EMPTY);
> +	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY,
> +			  UART_LSR_BOTH_EMPTY);
>   	__raw_writel((unsigned char)ch, base + UART_TX * 4);
> -	prom_putchar_wait(base + UART_LSR * 4, BOTH_EMPTY, BOTH_EMPTY);
> +	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY,
> +			  UART_LSR_BOTH_EMPTY);

Two observations apart from this patch:
* prom_putchar_wait()'s last two parameters are always the same.
   One should be removed, i.e. all this simplified.
* prom_putchar_wait() should be implemented using
   read_poll_timeout_atomic(), incl. failure/timeout handling.

thanks,
-- 
js
suse labs
