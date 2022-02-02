Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FAE4A7194
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiBBNaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:30:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43270 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiBBNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:30:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8932461781
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3607C004E1;
        Wed,  2 Feb 2022 13:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643808610;
        bh=QUmAN7TauO102tkxWVNy0kAyLcZR5AmCzj3n4PKFOtU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fyjbHTIDx52d/77Mee2Xf1XJ0t+xmmTXJsZnuVJMDJC/LkFVZM2yGjCHEMdytgN6w
         HeO1x5S2kVot3f128+z/ktpeo1dWHgm39B/dLca8hQy2e/IhWaE8yHQ9gSXwCUjKvS
         g8OnwjaEAajghSg7SKjauEAVilYj0/4bb0XuszxR9AvBiT59yvVxGiAbjcA92Ih7N8
         oePHCKbOi6C/QELF21qdBe6/kruSUaqtaXjS2D4dpTlpv+zNX0Y6uKeNxZvicUcqH2
         SZh95ayxY0iSjKzomqjk8kp/FlBZBuYVBRhQZAosyb7BPfnD05VtSnbjniu22LwKdM
         7tnn6z4Qf2VVg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nFFi4-004uTk-Q2; Wed, 02 Feb 2022 13:30:09 +0000
MIME-Version: 1.0
Date:   Wed, 02 Feb 2022 13:30:08 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        kernel-team@android.com, Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] irqchip/gic-v3-its: Skip HP notifier when no ITS is
 registered
In-Reply-To: <87pmo5o2j7.mognet@arm.com>
References: <20220202103454.2480465-1-maz@kernel.org>
 <87pmo5o2j7.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ac5a68d5d2479b1bdfa3a5bfc8c35033@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, kernel-team@android.com, steev@kali.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-02 12:50, Valentin Schneider wrote:
> On 02/02/22 10:34, Marc Zyngier wrote:
>> We have some systems out there that have both LPI support and an
>> ITS, but that don't expose the ITS in their firmware tables
>> (either because it is broken or because they run under a hypervisor
>> that hides it...).
>> 
> 
> Huh :)

Yeah. Got to love these WoA machines where EL2 hides most of the
useful HW, but also can't be bothered to consistently emulate
the registers they trap (cue the bug that was causing the SMMUv2
driver to explode on store of xzr to an MMIO register). Bah.

> 
>> Is such a configuration, we still register the HP notifier to free
>> the allocated tables if needed, resulting in a warning as there is
>> no memory to free (nothing was allocated the first place).
>> 
> 
> Right, so list_empty(&its_nodes) means no ->pend_page, but still having 
> the
> HP notifier means we hit the WARN_ON(!pend_page).
> 
>> Fix it by keying the HP notifier on the presence of at least one
>> sucessfully probed ITS.
>> 
> 
> That looks fine to me.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
