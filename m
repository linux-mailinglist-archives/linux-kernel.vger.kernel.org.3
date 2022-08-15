Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8A592EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiHOMQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiHOMQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:16:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CB8101F3;
        Mon, 15 Aug 2022 05:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CDCC6119B;
        Mon, 15 Aug 2022 12:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B54AC433D6;
        Mon, 15 Aug 2022 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660565782;
        bh=nfbt+cMYBqWgl0fPp91G7ZvYuKe2jGdemUvUTgTKcck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WOZiCy6Nd2UcpBAsjq8fyZyu5zousJCj2105E4SuqFOFlZLsN8TYWrddzmWZAwphg
         jqVxMEOo/Ip8nIaMjGCCHgDmO/MM4E+fi/kNljYYeZKYsCYX0mF8R162H8aGki0Vn6
         +4l9ntWb3zP3hoKT3/7bwqvoqyhGo87JcOLLUYDSjgYO8vNuylc8MMbYs8jcOWJzRA
         cea79+GSP4DRX5pho4OyO6QlflqVOFPjdYs9+13nH5W0k6r9BmYob0MS/pxuXGnBmM
         YkP211PE6LOWHrA4wQ6fVgdThadC1wCSPobjyQRmETrFx/Cu/yCt2+Kp++gwTfNh+y
         JneIwD/T61Wow==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oNZ12-0034zE-5V;
        Mon, 15 Aug 2022 13:16:20 +0100
MIME-Version: 1.0
Date:   Mon, 15 Aug 2022 13:16:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     lewis.hanly@microchip.com
Cc:     linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        conor.dooley@microchip.com, daire.mcnamara@microchip.com
Subject: Re: [PATCH v6 0/1] Add Polarfire SoC GPIO support
In-Reply-To: <20220815120834.1562544-1-lewis.hanly@microchip.com>
References: <20220815120834.1562544-1-lewis.hanly@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <727f07f843a9d06d84c1c28c3b905a4c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lewis.hanly@microchip.com, linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org, linus.walleij@linaro.org, brgl@bgdev.pl, linux-kernel@vger.kernel.org, palmer@dabbelt.com, conor.dooley@microchip.com, daire.mcnamara@microchip.com
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

On 2022-08-15 13:08, lewis.hanly@microchip.com wrote:
> From: Lewis Hanly <lewis.hanly@microchip.com>
> 
> 
> Add a driver to support the Polarfire SoC gpio controller.
> Tested with latest 5.19 kernel.
> 
> MPFS gpio interrupts are connected to IOMUX configured by system
> register GPIO_INTERRUPT_FAB_CR(31:0). Interrupt connection for
> some GPIO's to the PLIC (Platform Level Interrupt Controller) can be
> shared (not directly connected) or direct if connection is available.
> 
> previously upstreamed dt-bindings: gpio: microchip,mpfs-gpio.yaml
> 
> Changes in v6
> Fixed typo causing compile issue with kernel 6.0-rc1

3 versions in just over 5 hours. How about taking a step back
and *wait* for people to review this code? It isn't like this
is going to be merged tomorrow anyway...

The expected rate for new versions of a patch is about once
a week (see Documentation/process/submitting-patches.rst).

         M.
-- 
Jazz is not dead. It just smells funny...
