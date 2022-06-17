Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FF054F7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381684AbiFQM5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiFQM5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0A047AEF;
        Fri, 17 Jun 2022 05:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E28D61F93;
        Fri, 17 Jun 2022 12:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02C8C3411B;
        Fri, 17 Jun 2022 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655470625;
        bh=Bag8zwyhT9U8BMerjXOApyrnlO7JcS/Hr2CorYNNMwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=spG7m69WD1WO8UoOYUOzv9EgwcVwI7m0c6B3o2WLnoIUVyYzNyRsg04fSg9lJ/5Ub
         Yy7qftI/lK3toSRGGJ9hpvcrrFwjEIs0MGxuY1goYc2G6DkCIJQ/+inOH823N9okMg
         5OE1sdcQaUtqbgPK9CwoYamVtGC8QS5hrXCE7+vRVRd+mUg1N34fvNtlElIt55q9SW
         sN5gJ416axSb92DnSSUVCyO9SCIL5glPNEIP0htPyF1Rtj+mB9e0ehkY7JnwlrcByL
         1xGhlRzvsjBK00O99R/l6xrW5Evmh/80aT+LuALQrLJo98hBHvroIswnWTn0M77Kn9
         3y/y44E7/velQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o2BX4-001IoW-Og;
        Fri, 17 Jun 2022 13:57:02 +0100
MIME-Version: 1.0
Date:   Fri, 17 Jun 2022 13:57:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, paul@crapouillou.net,
        andy.shevchenko@gmail.com, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] pinctrl: ingenic: Convert to immutable irq chip
In-Reply-To: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com>
References: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <75d6d91d786cf992f6c36bddb2c6a2b9@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: aidanmacdonald.0x0@gmail.com, linus.walleij@linaro.org, paul@crapouillou.net, andy.shevchenko@gmail.com, linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17 13:28, Aidan MacDonald wrote:
> Two cleanup patches for pinctrl-ingenic.
> 
> v2:
> * Add print_chip callback to avoid changing /proc/interrupts output
> * Add patch to use irqd_to_hwirq()
> 
> Aidan MacDonald (2):
>   pinctrl: ingenic: Use irqd_to_hwirq()
>   pinctrl: ingenic: Convert to immutable irq chip
> 
>  drivers/pinctrl/pinctrl-ingenic.c | 64 +++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 24 deletions(-)

For the series:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
