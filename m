Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA5464937
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347687AbhLAH74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:59:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46988 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241918AbhLAH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:59:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D3ADB81DBF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06FBC53FCC;
        Wed,  1 Dec 2021 07:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638345392;
        bh=YIpWN6VqxtRIuZ9JFyJq6g5vNEOScuV8zlmA+SfEbN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lMfpFSEzRswgHGsN/VkIaisQ94bJ4xf5q6bictbEL3dUy6uMAlJuWB5lM7fhoGQCr
         08Knp8RekYjwfG53l80qMqL+Azz4hP1RRlluJJbjlxy3QF2e8VDQ8ls2q4BAtrXrQT
         SHCP69GZgwd3L6KC2BKzt1tQv8eCEINxw2clIPBeWW2ejYQSnrrFSoa3ez9AzH8BF7
         gzNmHdM7LTBYKtdHRNUvDJQ6zsGQ1fHPBz1LnlhHCqII9fBM704y0dH2F6MTzmMIU5
         MZQxSQaN+ox7FIcU4mgwODaVulEByk90nL9hb960nQyntxJDU5KD3qrfCzsG8oBGEi
         h9t/t0x6iU/rw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1msKTe-0094ry-2D; Wed, 01 Dec 2021 07:56:30 +0000
MIME-Version: 1.0
Date:   Wed, 01 Dec 2021 07:56:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org,
        jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        torvalds@linux-foundation.org, tsbogend@alpha.franken.de,
        vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 09/15] irq: arm: perform irqentry in entry code
In-Reply-To: <59cb8da0-7dbd-6e70-56be-a40615fd694b@arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-10-mark.rutland@arm.com>
 <0efc4465-12b5-a568-0228-c744ec0509a3@arm.com>
 <20211022153602.GE86184@C02TD0UTHF1T.local>
 <1dc39ac9-1a05-cf8d-2aef-633903a6338d@arm.com>
 <20211022175854.GK86184@C02TD0UTHF1T.local> <87tuh8uchn.wl-maz@kernel.org>
 <cada0034-7427-f4ae-0f88-7bbb1be2b1a5@arm.com>
 <87ilxnc21r.wl-maz@kernel.org>
 <c43c8c0e-946e-93c6-00d0-f015f948833a@arm.com>
 <59cb8da0-7dbd-6e70-56be-a40615fd694b@arm.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <78cc83d10cb6d251e53f5947ddc52735@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: vladimir.murzin@arm.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu, catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com, guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, nickhu@andestech.com, palmer@dabbelt.com, paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org, shorne@gmail.com, stefan.kristiansson@saunalahti.fi, tglx@linutronix.de, torvalds@linux-foundation.org, tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-30 08:49, Vladimir Murzin wrote:

> One month and a week later...
> 
> I observe that in terms of performance
> 
>    MRS       r0, ipsr
> 
> is equivalent to readl_relaxed(BASEADDR_V7M_SCB + V7M_SCB_ICSR)
> 
>    MOV.W   r3, #3758153728
>    LDR.W   r0, [r3, #3332]
> 
> Old compilers can produce less performant sequence like
> 
>    LDR      r3,0xbcc0
>    ADD.W    r3,r3,#0xaf00
>    LDR      r0,[r3,#0]
> 
> So, what would be your preference?

If there is no significant overhead to reading the MMIO register
and that you see a benefit in enabling COMPILE_TEST, then this
probably is the way to go.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
