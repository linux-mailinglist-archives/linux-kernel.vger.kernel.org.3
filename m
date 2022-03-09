Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5F4D3B35
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiCIUiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiCIUiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:38:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB16EDF7F;
        Wed,  9 Mar 2022 12:37:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23408CE1F20;
        Wed,  9 Mar 2022 20:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4062AC340EC;
        Wed,  9 Mar 2022 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646858237;
        bh=6sKfHJveDwgdZ5BM+GvgsVg2EYZLfzyFaL4KGIQ2b1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PhZTGRr5PWwg5/93tz0nPyDv5AqmpXWrvwtTUzfcLd+yaUrFDkgaBKngcrCEIoW66
         39nDbPPRgwNGPR2FdH8TQm2kGNNWdXp5F+XR0tvNkWaOr63DIBuxgOKytysRX83h7n
         e6oPR8QrvNpFcLTtELEEZpq7zPVJ+GzvCnTVxhAo69TXly9BA0Lex2CTkmyGAhk9vU
         S1x/xWyNSgo6ybxw/ra34yrkTx1ZGiF2VOvVbzu7Eu5U0AmE8JGQd8KhIJmsGSYDsT
         TwNqxOFKluhi0ftvzJ/WCpG7lD4Ke2F/XVWXSfgZy70MEBZ0bllEJJg1sXX1yDgvBF
         oZ3Xu4TNeW2wg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nS33a-00DQq3-LT; Wed, 09 Mar 2022 20:37:14 +0000
MIME-Version: 1.0
Date:   Wed, 09 Mar 2022 20:37:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Hector Martin <marcan@marcan.st>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/7] irqchip/apple-aic: Add support for AICv2
In-Reply-To: <YikOZNMmkkDGVhQc@sunset.rosenzweig.io>
References: <20220309192123.152028-1-marcan@marcan.st>
 <YikOZNMmkkDGVhQc@sunset.rosenzweig.io>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <995ddff0ab7b4dae93a1418eb9a0f4c1@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: alyssa@rosenzweig.io, marcan@marcan.st, tglx@linutronix.de, robh+dt@kernel.org, sven@svenpeter.dev, mark.kettenis@xs4all.nl, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-09 20:30, Alyssa Rosenzweig wrote:
>> This also adds support for multi-die AIC2 controllers. While no
>> multi-die products exist yet, the AIC2 in t600x is built to support
>> up to 2 dies, and it's pretty clear how it works, so let's implement
>> it. If we're lucky, when multi-die products roll around, this will
>> let us support them with only DT changes. In order to support the
>> extra die dimension, this introduces a 4-argument IRQ phandle form
>> (3-argument is always supported and just implies die 0).
> 
> Given you have a multidie device in the mail, it's probably best to
> defer merging this series until the multidie code paths are confirmed
> working there?

This code is used on Pro and Max systems, so it has some value as is.
Not to mention that it makes things slightly faster on the original M1
too.

         M.
-- 
Jazz is not dead. It just smells funny...
