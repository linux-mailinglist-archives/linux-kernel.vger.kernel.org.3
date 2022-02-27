Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643734C5C98
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiB0Pel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiB0Pej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:34:39 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7588747065;
        Sun, 27 Feb 2022 07:34:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E09D3423CD;
        Sun, 27 Feb 2022 15:33:56 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220224130741.63924-1-marcan@marcan.st>
 <20220224130741.63924-4-marcan@marcan.st> <87mtif2eoz.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 3/7] irqchip/apple-aic: Add Fast IPI support
Message-ID: <d0e2a08e-79d6-03e8-09a2-bb634fa3c23c@marcan.st>
Date:   Mon, 28 Feb 2022 00:33:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87mtif2eoz.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 23.39, Marc Zyngier wrote:
> On Thu, 24 Feb 2022 13:07:37 +0000,
>>  		if (!(pending & irq_bit) &&
>> -		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit))
>> -			send |= AIC_IPI_SEND_CPU(cpu);
>> +		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit)) {
>> +			if (static_branch_likely(&use_fast_ipi))
>> +				aic_ipi_send_fast(cpu);
> 
> OK, this is suffering from the same issue that GICv3 has, which is
> that memory barriers don't provide order against sysregs. You need a
> DSB for that, which is a pain. Something like this:

Doesn't the control flow here guarantee the ordering? atomic_read() must
complete before the sysreg is written since there is a control flow
dependency, and the prior atomic/barrier dance ensures that read is
ordered properly with everything that comes before it.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
