Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF6847F14D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 23:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhLXWKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 17:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLXWKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 17:10:42 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A01C061401;
        Fri, 24 Dec 2021 14:10:42 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r5so8481500pgi.6;
        Fri, 24 Dec 2021 14:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6injo+Q0oQXSDRi2mhIPBwQgXLxhoXVMLzA0WkpHeDY=;
        b=F4V5fLr+C+bYxQEbZjs1QZZKOPrJBa6a9wxAPU/DI2smTDl5poSSxqYXYdi3fG/KnY
         uhpW7DFuUTOC5a12LxRvq9yS3e1pnlZokOIFmMJt/gIHyWYJGMhb2JXAfoQ1oyBNeeSI
         qJvwxVbsD6YM/qydjdiisqJnbpqhdjEuha0RRDfn0zw38BJKFCW4aXEzcMPj3/VUTiPm
         ODzXBJs8hBGaAygXWOlZX6iiFHj5TeXeXyoctPUsSzOumy8ZceQcdOBNwzeXq3weLFBj
         cC2S5CtjYXKEVDf5Lo1n0+iSw9nnLhxgiAaggj8FWU11EH4X3nFKGPkAYScba7VJwThp
         jmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6injo+Q0oQXSDRi2mhIPBwQgXLxhoXVMLzA0WkpHeDY=;
        b=gNF9uBwVxjtZrQUsOB3j+5YavwgFleNWtcUSBFM7lPStOOaQp7G0ue+OgiXLMp7vuH
         EpjUQVVB9nO+gcBpzhPXVcez6hPNQnt3ZnOIFr2FCLy74I7z3wMh5ewrArMG83rv6Fq0
         dstIBNTQmdISt39eBoyoPbTQ52XDCDiWojTGfQTwJ2LOYrBen+p3lX8IvADG0Tav1VpS
         vll9V25ZAX4ITf5SwllgyQlAeMQ29dBuucYj9LqXxEOi4TdlDVV1WBx6A0ktlsYEqhhZ
         2XbuLfAjoaumrA/REGKtIW7uVht8fqAki6908Lti7cu5qkLEpLHLLXAdhqZW181UozKy
         /PNg==
X-Gm-Message-State: AOAM531YKwaA3oQQifd9mK+xri6ShP8ywm7JbX8qOgdB3vlMhsmqacVj
        kiTpGROvcNKjHSlnNUHg1Qg=
X-Google-Smtp-Source: ABdhPJwOEDLL+5KHSOXoX9xSPyIvBIekEcBsor9cESLEHqbU3LM3Tfuk2VzCfhPeiSC4UOosWHEDWA==
X-Received: by 2002:a63:4554:: with SMTP id u20mr7445295pgk.463.1640383841570;
        Fri, 24 Dec 2021 14:10:41 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id k8sm4617958pjs.53.2021.12.24.14.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 14:10:41 -0800 (PST)
Message-ID: <3913a3c2-2ae9-00a2-6c08-bab2afaa7cb3@gmail.com>
Date:   Fri, 24 Dec 2021 14:10:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 02/10] serial: 8250_bcm7271: Use platform_get_irq() to get
 the interrupt
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-serial@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224142917.6966-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211224142917.6966-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/24/2021 6:29 AM, Lad Prabhakar wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
