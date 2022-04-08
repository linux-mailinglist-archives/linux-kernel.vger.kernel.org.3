Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0576E4F95AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiDHM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiDHM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506AD33DC8A;
        Fri,  8 Apr 2022 05:26:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 781F9620B6;
        Fri,  8 Apr 2022 12:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D980DC385A1;
        Fri,  8 Apr 2022 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649420802;
        bh=S3ySNvfP+7/EjC7ydSU5pgHi80ITmCMi6D5xYdpcZfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pf/0VyasQmdk2dqcdDNTe6uD8ftrzrsCh9VZZ27cOntYN0Q9oSzNI+YcPrybBbcnv
         TQes4oCXUSO7OQqbrWM2RERmLKTV531tUey0rnkiL7POktivIVi4rCjIR0RwqIK2Z8
         pRk7HKhWYdMMTGCAxLHik6UQ2Ib9Q3jsNwRBsE9TxkJHR2QL0usfROCkzNS2r2RZGw
         6rXis+KDt40iE+Bg1xL2irIs4nKCYwQbDTrzP02+IE/BTdrNt2/BPp6y7xQXjynniK
         7+v2+HLGjeyHcH/lgSqu82WWznfZzJOrd98bLngMah+77+7PIIpEF8Eswi/R6nMH58
         ZuyINO7fu77kw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ncnhI-002lRF-Hu; Fri, 08 Apr 2022 13:26:40 +0100
MIME-Version: 1.0
Date:   Fri, 08 Apr 2022 13:26:40 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 10/10] Documentation: Update the recommended pattern
 for GPIO irqchips
In-Reply-To: <CAHp75Ve5tMyUdj-cYV0pzL4zvVitTwC_gGv50-ZHTETiiQSbeA@mail.gmail.com>
References: <20220405135444.199295-1-maz@kernel.org>
 <20220405135444.199295-11-maz@kernel.org>
 <CAHp75Ve5tMyUdj-cYV0pzL4zvVitTwC_gGv50-ZHTETiiQSbeA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <84a1ed7e4442e04e16730ae112a43aea@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, jeffrey.l.hugo@gmail.com, tglx@linutronix.de, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-08 12:33, Andy Shevchenko wrote:
> On Wed, Apr 6, 2022 at 1:57 PM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> Update the documentation to get rid of the per-gpio_irq_chip
>> irq_chip structure, and give examples of the new pattern.
> 
> ...
> 
>> +  static void my_gpio_mask_irq(struct irq_data *d)
>> +  {
>> +      struct gpio_chip *gc = irq_desc_get_handler_data(d);
>> +
>> +      /*
>> +       * Perform any necessary action to mask the interrupt,
>> +       * and then call into the core code to synchronise the
>> +       * state.
>> +       */
>> +
>> +      gpiochip_disable_irq(gc, d->hwirq);
> 
> (1)
> 
>> +  }
>> +
>> +  static void my_gpio_unmask_irq(struct irq_data *d)
>> +  {
>> +      struct gpio_chip *gc = irq_desc_get_handler_data(d);
> 
>> +      gpiochip_disable_irq(gc, d->hwirq);
> 
> (2)
> 
>> +      /*
>> +       * Perform any necessary action to unmask the interrupt,
>> +       * after having called into the core code to synchronise
>> +       * the state.
>> +       */
>> +  }
> 
> If (1) and (2) being the same is not a mistake (typo) it probably
> needs additional explanation.

Well spotted, this is definitely a copy-paste issue.
I'll fix this locally.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
