Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02D469069
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhLFGjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbhLFGjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:39:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9BC0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 22:35:42 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso10055543pji.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 22:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KPdiesTGFrti81pgW4AEjO6kQFUIykLCsbuWcjx17rA=;
        b=rZli6EDigXFG27bzDSZQq52FY8dmCj96XtbZHhJMK74MibdPrQXPvjYM8IFIBeoy7G
         ELX67VAl1IhSwAsJyvpaDrK25ZagcRg/4EErvPzXoDyP3q8bHb+wOynD31OSykroYOxK
         lfYN9OpzObX20WGnZ0F7+PByA1iBsyVA5L4kibkq/tGhd6M2RxeaBYS+76I0dFOtvdpD
         h5LNbaGbq35rqy+8HlU/SDFPrMTE+nwU1OR/bCCwQOhBJoTEDHMbz+OUao0axYCtwLJn
         cDmwfjgwj7ycRs0s49eqjcj8hGM8UtTAeYQ9Mkru3davaUViOj/92KLqpyRC61IrMbiN
         rNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KPdiesTGFrti81pgW4AEjO6kQFUIykLCsbuWcjx17rA=;
        b=s8+QA4gjEdCExQBGu7QE7Z9vnT25tfKOwbwqczXQk/76TS4Slj8fexUqAicuuvDnsN
         NoGwtIT383xdOpfeBVa5MMkAmMBNmPFKJMqFztaOPe6pZ2sCg+AHkc3JPKftMSALxQhG
         qT5vOA7NcOLH7w/4/G5Vqs4FurPkTKrsms/4T7QLA0hpvtP3RMn69M6qqeUWDEtcOHdC
         HDQxVaQYHUHWR7HeKcXvYcyot/8f6CEqPKA8ko8vZL98ce81hA1L0HL6bKPfl6m3x/ZV
         dB6ooa6XIij9mmWVNLU6unvUXBQs8fUoO23j2TiQrMI3Pa2VWfLXe0qdqsNW6Nw+dCUU
         KtvA==
X-Gm-Message-State: AOAM53104qqVf5GnLTv4F9uemrASNNNXQ1Zv8lSmZUjeQFvHdaltmZSC
        R4K5b4uv9Mst1hqdaV7t54DtWA==
X-Google-Smtp-Source: ABdhPJxIn+T1ulljaVquO7/zIEGGcd3t1MxTGYPJTWFTd/hcSgAywdj9YmAB95HC9kupiqItPilxxQ==
X-Received: by 2002:a17:90b:155:: with SMTP id em21mr35817743pjb.12.1638772542189;
        Sun, 05 Dec 2021 22:35:42 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id k2sm11945931pfc.53.2021.12.05.22.35.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Dec 2021 22:35:41 -0800 (PST)
Date:   Mon, 6 Dec 2021 14:35:35 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 1/3] irqchip: Pass platform_device pointer to init_cb
Message-ID: <20211206063534.GK10105@dragon>
References: <20211202122122.23548-1-shawn.guo@linaro.org>
 <20211202122122.23548-2-shawn.guo@linaro.org>
 <b221fec0-43d0-537d-d78e-84da10a9c2d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b221fec0-43d0-537d-d78e-84da10a9c2d7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 09:52:55AM -0800, Florian Fainelli wrote:
> On 12/2/21 4:21 AM, Shawn Guo wrote:
> > It makes sense to just pass device_node for callback in IRQCHIP_DECLARE
> > case, but not so much for IRQCHIP_PLATFORM_DRIVER one, because
> > platform_driver probe/init usually needs device pointer for various
> > purposes, e.g. resource allocation, service request, device prefixed
> > message output, etc.  Create a new callback type irqchip_init_cb_t which
> > takes platform_device pointer as parameter, and update the existing
> > IRQCHIP_PLATFORM_DRIVER users accordingly.
> > 
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Could you copy all recipients on all 3 patches plus your cover letter
> next time so we have the full context? Thanks!
> 
> [snip]
> 
> >  
> > -static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
> > +static int __init bcm7120_l2_intc_probe_7120(struct platform_device *pdev,
> >  					     struct device_node *parent)
> >  {
> > -	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
> > +	return bcm7120_l2_intc_probe(pdev->dev.of_node, parent,
> > +				     bcm7120_l2_intc_iomap_7120,
> >  				     "BCM7120 L2");
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
> which would be completely superfluous now that we pass a platform_device
> directly. Can you rework your patch so as to eliminate that
> of_find_device_by_ndoe() (and the companion put_device call)?

Firstly, I do not see any companion put_device call in the driver.
Secondly, the existing code seems to have some problem in the "out"
order.  The out_unmap should go before out_free_l1_data, right?

@@ -329,13 +323,13 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 
 out_free_domain:
        irq_domain_remove(data->domain);
-out_free_l1_data:
-       kfree(data->l1_data);
 out_unmap:
        for (idx = 0; idx < MAX_MAPPINGS; idx++) {
                if (data->map_base[idx])
                        iounmap(data->map_base[idx]);
        }
+out_free_l1_data:
+       kfree(data->l1_data);
 out_free_data:
        kfree(data);
        return ret;

Shawn
