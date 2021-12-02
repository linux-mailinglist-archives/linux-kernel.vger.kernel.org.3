Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86B5466A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376694AbhLBTNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:13:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34556 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376361AbhLBTNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:13:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D31AB627CD;
        Thu,  2 Dec 2021 19:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43917C00446;
        Thu,  2 Dec 2021 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638472207;
        bh=EteNjkTKqOyKSgfA1TAsf+sxa9xkY4eJ2j/1WLoz584=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NRgz+2YKsw7JBre8+DtUxj2QEvWFPU7h1J81nWiHFanbkoLfyzK71P8ge/smwsNvv
         AsjRCxXC6M3bCCHJFvjJI+bxONpDm+aPdG+RPB1n6D9TwRwUbHEZ9HYEFRM/Bb0Jzk
         hoTrORi5bWGrO74PHKKRUVrXTF7Hyvjfw4JqwvZH4LTSEIEzpy7GVmGG8jn0WQB27u
         tmZ3d0tW6AiSZA/klaOArnjjPyYYfFSMfRzNdeq1yPisVINrwS3v/pF8F2OrX4HFY+
         PqhKMMVN65WfEoOrDceTAaFqzEf7oAfg/hVKHbOJfT0eRbSCs0LaTEr+naLqIPft0C
         qlbvcz1pU63NQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1msrT2-009REe-Kt; Thu, 02 Dec 2021 19:10:04 +0000
MIME-Version: 1.0
Date:   Thu, 02 Dec 2021 19:10:04 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 1/3] irqchip: Pass platform_device pointer to init_cb
In-Reply-To: <b221fec0-43d0-537d-d78e-84da10a9c2d7@gmail.com>
References: <20211202122122.23548-1-shawn.guo@linaro.org>
 <20211202122122.23548-2-shawn.guo@linaro.org>
 <b221fec0-43d0-537d-d78e-84da10a9c2d7@gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <fa6ae407c1da16e571aaf04eb424fecd@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: f.fainelli@gmail.com, shawn.guo@linaro.org, tglx@linutronix.de, quic_mkshah@quicinc.com, bjorn.andersson@linaro.org, loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, claudiu.beznea@microchip.com, narmstrong@baylibre.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-02 17:52, Florian Fainelli wrote:
> On 12/2/21 4:21 AM, Shawn Guo wrote:
>> It makes sense to just pass device_node for callback in 
>> IRQCHIP_DECLARE
>> case, but not so much for IRQCHIP_PLATFORM_DRIVER one, because
>> platform_driver probe/init usually needs device pointer for various
>> purposes, e.g. resource allocation, service request, device prefixed
>> message output, etc.  Create a new callback type irqchip_init_cb_t 
>> which
>> takes platform_device pointer as parameter, and update the existing
>> IRQCHIP_PLATFORM_DRIVER users accordingly.
>> 
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Could you copy all recipients on all 3 patches plus your cover letter
> next time so we have the full context? Thanks!
> 
> [snip]
> 
>> 
>> -static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
>> +static int __init bcm7120_l2_intc_probe_7120(struct platform_device 
>> *pdev,
>>  					     struct device_node *parent)
>>  {
>> -	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
>> +	return bcm7120_l2_intc_probe(pdev->dev.of_node, parent,
>> +				     bcm7120_l2_intc_iomap_7120,
>>  				     "BCM7120 L2");
> 
> If you look further into that driver, you will see that we do something
> like this in bcm7120_l2_intc_probe:
> 
>           pdev = of_find_device_by_node(dn);
>           if (!pdev) {
>                   ret = -ENODEV;
>                   goto out_free_data;
>           }
> 
> which would be completely superfluous now that we pass a 
> platform_device
> directly. Can you rework your patch so as to eliminate that
> of_find_device_by_ndoe() (and the companion put_device call)?

Or just adopt the same construct in the MPM driver. At this stage, 
drivers
requiring a platform_device are the minority.

         M.
-- 
Jazz is not dead. It just smells funny...
