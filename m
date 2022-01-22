Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE1496D17
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 18:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiAVRbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 12:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiAVRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:31:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B87C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 09:31:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C82EB80AB0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 17:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4540EC004E1;
        Sat, 22 Jan 2022 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642872664;
        bh=0hN1VsC/xpkg7gWRCxW4wR6tPARMWomUHwGf0DD6mXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ubdqqI4nBASfgeMaxVdxA6FHmngMdGeULanaOyEDlKxugdVhdmPObkFYNDCyjnUOn
         j3zf8E1KkYFmbiJqpccKwStxHv02f1E8tK6AHPfe5m9d24gnwxRElxbnPvqLur44zb
         ueik0+BaJ1NIYtOahOwDtWYlRyrSHDTkz5C4f5c0DZJLpEPhaKjK2By7ylmBZJ6SJm
         rEgVJRxd9WxV1mardJRXLXua1ZOOzV4lDfjsblVCAUWT8N5D8kX6TH3CZI31wAOKkH
         DEvyDasN1nYli1f/RvPa5KF+plgbnjhhPzZHkNHRfms019FkKSzJnqbSQUUPWtbcsF
         o3DFXEX2g1orA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nBKEA-00270F-A5; Sat, 22 Jan 2022 17:31:02 +0000
MIME-Version: 1.0
Date:   Sat, 22 Jan 2022 17:31:02 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jay Chen <jkchen@linux.alibaba.com>
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Reset each ITS's BASERn register
 before probe
In-Reply-To: <20220122163712.1141635-1-maz@kernel.org>
References: <20220122163712.1141635-1-maz@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a19d7f44abfd38eb429e33d4886518e3@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, kernel-team@android.com, lorenzo.pieralisi@arm.com, jkchen@linux.alibaba.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-22 16:37, Marc Zyngier wrote:
> A recent bug report outlined that the way GICv4.1 is handled across
> kexec is pretty bad. We can end-up in a situation where ITSs share
> memory (this is the case when SVPET==1) and reprogram the base
> registers, creating a situation where ITSs that are part of a given
> affinity group see different pointers. Which is illegal. Boo.
> 
> In order to restore some sanity, reset the BASERn registers to 0
> *before* probing any ITS. Although this isn't optimised at all,
> this is only a once-per-boot cost, which shouldn't show up on
> anyone's radar.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Jay Chen <jkchen@linux.alibaba.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20211216190315.GA14220@lpieralisi
> ---
> 
> Notes:
>     * From v1: Fail probing if any ITS fails to reset.
> 
>  drivers/irqchip/irq-gic-v3-its.c | 111 +++++++++++++++++++++++++------
>  1 file changed, 92 insertions(+), 19 deletions(-)
> 

[...]

>  static void __init its_acpi_probe(void)
>  {
>  	acpi_table_parse_srat_its();
> +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
> +				  its_acpi_reset, 0))
> +		return;

Nah. This is obviously broken.

I'll repost something once I have actually tested it on an ACPI box.

         M.
-- 
Jazz is not dead. It just smells funny...
