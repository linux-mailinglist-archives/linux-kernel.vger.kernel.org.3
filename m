Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D93A55A356
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiFXVJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiFXVJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:09:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410765000F;
        Fri, 24 Jun 2022 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656104981; x=1687640981;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ocdofbPoJSkkH7D2EiI2VUZPxoQiLPz2hq0ijc7qW+g=;
  b=miTzazxeeEf2JVbYO+0urn8P62MOt4wWI5o3F56svl0RtmYqcsoWs9f1
   S8AL9BFq8yEvO0yggsaHbpyHwzzw63tnb7AH/6JY2sWmtYnblu/ToT1Bo
   Oj+cV7+Vj8nBRpP1wv5JBhyXR+bGCwzosgoahYJISTwxszc5BuiOYMbBk
   gorViEnFXUQUzqcEpycpeoAFkUk+qSbdBgfLL9bnw1Pt5HIkNfeA/SrUR
   SEC6vrgqicFDahiX+0G/5PQjp7PH/4g6vI4nZEeo7NIWUnxNRqh2e7yzo
   4fAHX1yAe4VxbyPp0+2kichMSWXxQHWc8gNCgZMQ9b/uaD7b+pVdBd4sF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281140009"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="281140009"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 14:09:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="835281798"
Received: from vhavel-mobl.ger.corp.intel.com ([10.251.216.91])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 14:09:36 -0700
Date:   Sat, 25 Jun 2022 00:09:33 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        speakup@linux-speakup.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: Consolidate BOTH_EMPTY use
In-Reply-To: <03467516-3962-4ff2-23d2-2b3a1d647c5a@kernel.org>
Message-ID: <616c8221-fc6e-1b73-626c-3427c87dddbf@linux.intel.com>
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com> <20220621124958.3342-7-ilpo.jarvinen@linux.intel.com> <03467516-3962-4ff2-23d2-2b3a1d647c5a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022, Jiri Slaby wrote:

> > --- a/arch/mips/ath79/early_printk.c
> > +++ b/arch/mips/ath79/early_printk.c
> > @@ -29,15 +30,15 @@ static inline void prom_putchar_wait(void __iomem *reg,
> > u32 mask, u32 val)
> >   	} while (1);
> >   }
> >   -#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
> > -
> >   static void prom_putchar_ar71xx(char ch)
> >   {
> >   	void __iomem *base = (void __iomem *)(KSEG1ADDR(AR71XX_UART_BASE));
> >   -	prom_putchar_wait(base + UART_LSR * 4, BOTH_EMPTY, BOTH_EMPTY);
> > +	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY,
> > +			  UART_LSR_BOTH_EMPTY);
> >   	__raw_writel((unsigned char)ch, base + UART_TX * 4);
> > -	prom_putchar_wait(base + UART_LSR * 4, BOTH_EMPTY, BOTH_EMPTY);
> > +	prom_putchar_wait(base + UART_LSR * 4, UART_LSR_BOTH_EMPTY,
> > +			  UART_LSR_BOTH_EMPTY);
> 
> Two observations apart from this patch:
> * prom_putchar_wait()'s last two parameters are always the same.
>   One should be removed, i.e. all this simplified.

I noticed this myself but I'm also looking into generalizing wait for tx 
empty somehow if possible (it might not help much here though as this 
seems to be on "early" side of things).

-- 
 i.


> * prom_putchar_wait() should be implemented using
>   read_poll_timeout_atomic(), incl. failure/timeout handling.
> 
> thanks,
> 

