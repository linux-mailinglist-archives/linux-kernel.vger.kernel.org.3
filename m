Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57F514958
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359241AbiD2MeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359174AbiD2MeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:34:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B58567A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=cf+KDXJI4wkmbU7OdoHHLR/cXtVxtK7S51UOvLfdoAY=; b=i9
        uzb+BzyHswZ0FopHMlj9Sd6WwBQTTNZkISdSlSCOqJLFaX8bPUdzBW/sLHt6hQU0Njmk0exQjSOri
        GiMxXk506nlCbULXBVZ6nEo5hIHIpaV8mvbIIZh2ZIsJJpS8Uf7QlAzlK9ZBdYq/fWuEbQq8zMLFJ
        KAhHZITb+l2ijjo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nkPlt-000ThK-I0; Fri, 29 Apr 2022 14:30:53 +0200
Date:   Fri, 29 Apr 2022 14:30:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip/armada-370-xp: Do not allow mapping IRQ 0
 and 1
Message-ID: <YmvafYwhtIoaOMmk@lunn.ch>
References: <20220425113706.29310-1-pali@kernel.org>
 <20220425113706.29310-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425113706.29310-2-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 01:37:06PM +0200, Pali Rohár wrote:
> IRQs 0 and 1 cannot be mapped, they are handled internally by this driver
> and this driver does not call generic_handle_domain_irq() for these IRQs.
> So do not allow mapping these IRQs and correctly propagate error from the
> .irq_map callback.

So you are referring to this?

                /* Check if the interrupt is not masked on current CPU.
                 * Test IRQ (0-1) and FIQ (8-9) mask bits.
                 */
                if (!(irqsrc & ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)))
                        continue;

                if (irqn == 1) {
                        armada_370_xp_handle_msi_irq(NULL, true);
                        continue;
                }


Should the two FIQ interrupts also return -EINVAL?

       Andrew
