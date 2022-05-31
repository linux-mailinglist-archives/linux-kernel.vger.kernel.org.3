Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D655253897F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbiEaBOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiEaBOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:14:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082527CFA;
        Mon, 30 May 2022 18:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gsnt3wfiKRAab7rr7vUW+4Raj9NNf1/lCz5wRmAZR48=; b=bQjGi7blPlXV2JUQ6O8EUC+c2o
        tjOoSwNX6Lp55gRcTsFBmqDgynTd0ybRbRFB46OcpKMHt+QKqY4gCGbtZvLgE3JQ+8K633uUC3qZD
        sb+2uQi0r2uza62Fnc24ybiG7nv2FkUZIXaPgQI9wXXVOywFF5T/j8hxJRvDZj9o0S3pmP2xFDOQM
        5Y9BzzYiIxeBKKHLy3Aa0DTZWzGkc5+jzKB6OzOClS3nw1Y8N+dXpwIoIG4VfYQ1McIgrikdJXYB3
        tuIld4NQu1mqd64F3xX1fO+icAXFKmHSRr/tMrqm/DffbgvzngLnJvg2cyXWfSU6mclc9hycUZaQA
        Fi8xaKwA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvqSx-004vxT-9o; Tue, 31 May 2022 01:14:35 +0000
Message-ID: <3b783435-e734-5391-e758-d709e0462839@infradead.org>
Date:   Mon, 30 May 2022 18:14:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v16 4/4] m68k: introduce a virtual m68k machine
Content-Language: en-US
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alessandro Zummo <a.zummo@towertech.it>
References: <20220406201523.243733-1-laurent@vivier.eu>
 <20220406201523.243733-5-laurent@vivier.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220406201523.243733-5-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/6/22 13:15, Laurent Vivier wrote:
> diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
> index eeab4f3e6c19..188a8f8a0104 100644
> --- a/arch/m68k/Kconfig.machine
> +++ b/arch/m68k/Kconfig.machine
> @@ -149,6 +149,23 @@ config SUN3
>  
>  	  If you don't want to compile a kernel exclusively for a Sun 3, say N.
>  
> +config VIRT
> +	bool "Virtual M68k Machine support"
> +	depends on MMU
> +	select GENERIC_CLOCKEVENTS
> +	select GOLDFISH
> +	select GOLDFISH_TIMER
> +	select GOLDFISH_TTY
> +	select M68040
> +	select MMU_MOTOROLA if MMU
> +	select RTC_CLASS
> +	select RTC_DRV_GOLDFISH
> +	select TTY
> +	select VIRTIO_MMIO

This select VIRTIO_MMIO can cause a kconfig warning:

WARNING: unmet direct dependencies detected for VIRTIO_MMIO
  Depends on [n]: VIRTIO_MENU [=n] && HAS_IOMEM [=y] && HAS_DMA [=y]
  Selected by [y]:
  - VIRT [=y] && M68KCLASSIC [=y] && MMU [=y]


> +	help
> +	  This options enable a pure virtual machine based on m68k,
> +	  VIRTIO MMIO devices and GOLDFISH interfaces (TTY, RTC, PIC)

The sentence above needs an ending period ('.').

> +
>  config PILOT
>  	bool

-- 
~Randy
