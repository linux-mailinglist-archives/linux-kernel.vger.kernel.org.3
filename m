Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16F24DAECD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355304AbiCPLWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348209AbiCPLWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C8403EA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEFC561675
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3710CC340E9;
        Wed, 16 Mar 2022 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647429690;
        bh=Q+NvgF0zYejOPS1VXG3MwVNsPgDrDn5hU0O3zmq6r3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AFZus2/9RBLfz6eYhYJJ4MY6cUpZgQtvtsIa+vHsxZRzaaSVIXIg7KS/s65Iyx6zj
         UnEL8GK58gCaNfZyvhhiZYVe5wIDQBvI7f1nEkrZWPA3U88oOeBhZkLd+uhdcAGOid
         9h+bh4RRUDFJrQ70I8DHgcZ5lO6WvszPEfwBGaSjyVV0NORd3HPRQEwLlPQ0RNjDMY
         K8Wv42jjHk/R8yBqfsBAnYJ5qgN0HsnLGs9YierItA7+fzs30vJ/aYS0MAz1lIIsfL
         nJj9HBbBrAwQyNuN8FikvBXz6PdO6v6vvLUwzh05GOOZmSxHgTRZ5KSKIg9rGpDi+7
         kN9exHwsxsh/g==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nURiZ-00Etdy-Nq; Wed, 16 Mar 2022 11:21:27 +0000
MIME-Version: 1.0
Date:   Wed, 16 Mar 2022 11:21:27 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric Auger <eric.auger@redhat.com>." <oupton@google.com>
Subject: Re: [PATCH 2/3] irqchip/gic-v3: Detect LPI invalidation MMIO
 registers
In-Reply-To: <20220315165034.794482-3-maz@kernel.org>
References: <20220315165034.794482-1-maz@kernel.org>
 <20220315165034.794482-3-maz@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a00f3045e881378de849bcbc0377ae07@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, andre.przywara@arm.com, tglx@linutronix.de, oupton@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-15 16:50, Marc Zyngier wrote:
> diff --git a/include/linux/irqchip/arm-gic-v3.h
> b/include/linux/irqchip/arm-gic-v3.h
> index 12d91f0dedf9..aeb8ced53880 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -127,6 +127,8 @@
>  #define GICR_PIDR2			GICD_PIDR2
> 
>  #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
> +#define GICR_CTLR_IR			(1UL << 1)
> +#define GICR_CTLR_CES			(1UL << 2)
>  #define GICR_CTLR_RWP			(1UL << 3)
> 
>  #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)

As Oliver pointed out in [1], this is bollocks, and the two
new bits are swapped. I've now fixed that locally.

Thanks,

         M.

[1] https://lore.kernel.org/r/YjEeNThfYFtTffWz@google.com
-- 
Jazz is not dead. It just smells funny...
