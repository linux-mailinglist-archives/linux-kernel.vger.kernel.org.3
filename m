Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D53551E02C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442993AbiEFUgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344781AbiEFUgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:36:31 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E3E6D3A9;
        Fri,  6 May 2022 13:32:47 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 176FF103201C2;
        Fri,  6 May 2022 22:32:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EB2B611944B; Fri,  6 May 2022 22:32:42 +0200 (CEST)
Date:   Fri, 6 May 2022 22:32:42 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Rutland <mark.rutland@arm.com>, maz@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: Re: [PATCH v2 17/17] irq: remove handle_domain_{irq,nmi}()
Message-ID: <20220506203242.GA1855@wunner.de>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026092504.27071-18-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:25:04AM +0100, Mark Rutland wrote:
> Now that entry code handles IRQ entry (including setting the IRQ regs)
> before calling irqchip code, irqchip code can safely call
> generic_handle_domain_irq(), and there's no functional reason for it to
> call handle_domain_irq().
> 
> Let's cement this split of responsibility and remove handle_domain_irq()
> entirely, updating irqchip drivers to call generic_handle_domain_irq().
> 
> For consistency, handle_domain_nmi() is similarly removed and replaced
> with a generic_handle_domain_nmi() function which also does not perform
> any entry logic.
> 
> Previously handle_domain_{irq,nmi}() had a WARN_ON() which would fire
> when they were called in an inappropriate context. So that we can
> identify similar issues going forward, similar WARN_ON_ONCE() logic is
> added to the generic_handle_*() functions, and comments are updated for
> clarity and consistency.
[...]
>  int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
>  {
> +	WARN_ON_ONCE(!in_irq());
>  	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
>  }
>  EXPORT_SYMBOL_GPL(generic_handle_domain_irq);

Why isn't the WARN_ON_ONCE() conditional on handle_enforce_irqctx()?
(See handle_irq_desc() and c16816acd086.)

I believe the above change causes a regression in drivers/gpio/gpio-dln2.c
such that a gratuitous WARN splat is now emitted.

Thanks,

Lukas
