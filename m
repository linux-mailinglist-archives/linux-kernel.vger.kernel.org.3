Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D594A50D4E9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiDXTxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiDXTxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:53:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D633113F6B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:50:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so5177643ejj.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmTw1a3cXWEdJuo5jLxVYG9+0t7TfLjj7xZjD5d7KU0=;
        b=Tkc1geR52mL1eHBIeDO0XVOmiFXCFA7T1H8DVGwEIkRIYCaCN6MyH7vi4P0I8JMQ+C
         PJrW0GUKHl/2oG9RUb3dA43QvIqyGjpmGjmHRpae9C7rtOyeLHdKz0MqewJfWv24Bw5/
         Ns7nxDT6jbS72Rc8Pm01s8gUi4ZQfe8uJ9Xv5aD1BQNMQTMQOIGDHh6T2VkjR0l9lDN+
         6LRp8pQyLCJpeCO+ogwS0tSEv3wRvaVCHqdqzPRBKOjqoDm8q+ziamR+o5NJ5mbOy484
         0Jwa/4wMVh09PkhmPeK3aEtLsdhbA6N8SKDZRj5XzS0jTJXFRsKPcdJ6p9eyNXA1WePv
         ep3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmTw1a3cXWEdJuo5jLxVYG9+0t7TfLjj7xZjD5d7KU0=;
        b=xs7xJIJTqi2At4VjzZ9X6hZc7qvZdT8ZI8zSQQ8fKFR6VeY/KKSRDt3G8MQLIVlVyR
         +Jq7/XWx1bp6oXNW+8LaF/CnjeWxk/zw1zUZDSD/8QYwXNIwgMv/fdAs+QqcR4QpvUGk
         VjUq2EHCDINIRF0kLzMA1Z4ijzUekhl2ZdyRWQmL1eGjhrQ5aNopSzI2PwYT5OuJRowK
         PtiEsRNYNM+WqlwQQV14d29166h3QwTCilY2W9Rsf6yRb9CDT+9798YIHIAJEU7fe7sa
         twJtcTQdZym9ElxWYTmoyS5C6WQEq4ONdLJC8dHQJ8dWUE17cV0T/NEzcKVeZanCeZ3i
         3qbw==
X-Gm-Message-State: AOAM532yD1KAKWNtmhrDwJWzG5mi2FWsnaJEy/QisOOJD23ORGv7d4rJ
        m6o5auL4XfTpRsy9FIsFTB4=
X-Google-Smtp-Source: ABdhPJxVCzu1SCuRlkHLi9y47tFtrClwhJDDPTTX72ySghCaAsZoYOIsD5osaGclr1SKLFVzpUCMqA==
X-Received: by 2002:a17:906:4783:b0:6d0:9b6e:b5a5 with SMTP id cw3-20020a170906478300b006d09b6eb5a5mr13608722ejc.526.1650829822433;
        Sun, 24 Apr 2022 12:50:22 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090622c600b006f3876cd90csm1068241eja.198.2022.04.24.12.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 12:50:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        kernel test robot <lkp@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] irqchip/sun6i-r: Use NULL for chip_data
Date:   Sun, 24 Apr 2022 21:50:20 +0200
Message-ID: <2626773.mvXUDI8C0e@kista>
In-Reply-To: <20220424173952.36591-1-samuel@sholland.org>
References: <20220424173952.36591-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 24. april 2022 ob 19:39:51 CEST je Samuel Holland napisal(a):
> sparse complains about using an integer as a NULL pointer.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  drivers/irqchip/irq-sun6i-r.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
> index 4cd3e533740b..a01e44049415 100644
> --- a/drivers/irqchip/irq-sun6i-r.c
> +++ b/drivers/irqchip/irq-sun6i-r.c
> @@ -249,11 +249,13 @@ static int sun6i_r_intc_domain_alloc(struct irq_domain 
*domain,
>  	for (i = 0; i < nr_irqs; ++i, ++hwirq, ++virq) {
>  		if (hwirq == nmi_hwirq) {
>  			irq_domain_set_hwirq_and_chip(domain, virq, 
hwirq,
> -						      
&sun6i_r_intc_nmi_chip, 0);
> +						      
&sun6i_r_intc_nmi_chip,
> +						      NULL);
>  			irq_set_handler(virq, 
handle_fasteoi_ack_irq);
>  		} else {
>  			irq_domain_set_hwirq_and_chip(domain, virq, 
hwirq,
> -						      
&sun6i_r_intc_wakeup_chip, 0);
> +						      
&sun6i_r_intc_wakeup_chip,
> +						      NULL);
>  		}
>  	}
>  
> -- 
> 2.35.1
> 
> 


