Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1094C512D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiBYWGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBYWGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:06:05 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC391F083F;
        Fri, 25 Feb 2022 14:05:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5FEBE42037;
        Fri, 25 Feb 2022 22:05:28 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] irqchip/apple-aic: Add support for AICv2
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220224130741.63924-1-marcan@marcan.st>
 <20220224130741.63924-8-marcan@marcan.st> <87lexz2cgv.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <4fbeeae8-0b56-e665-744f-6a1ca2b24f9e@marcan.st>
Date:   Sat, 26 Feb 2022 07:05:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87lexz2cgv.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2022 00.27, Marc Zyngier wrote:
> On Thu, 24 Feb 2022 13:07:41 +0000,
> Hector Martin <marcan@marcan.st> wrote:
>> -	/*
>> -	 * Make sure the kernel's idea of logical CPU order is the same as AIC's
>> -	 * If we ever end up with a mismatch here, we will have to introduce
>> -	 * a mapping table similar to what other irqchip drivers do.
>> -	 */
>> -	WARN_ON(aic_ic_read(aic_irqc, AIC_WHOAMI) != smp_processor_id());
>> +	if (aic_irqc->info.version == 1) {
>> +		/*
>> +		 * Make sure the kernel's idea of logical CPU order is the same as AIC's
>> +		 * If we ever end up with a mismatch here, we will have to introduce
>> +		 * a mapping table similar to what other irqchip drivers do.
>> +		 */
>> +		WARN_ON(aic_ic_read(aic_irqc, AIC_WHOAMI) != smp_processor_id());
> 
> Don't you have a similar issue with AICv2?  Or is it that AICv2
> doesn't have this register?

No concept of individual CPUs in AICv2 at all, so no WHOAMI register
either :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
