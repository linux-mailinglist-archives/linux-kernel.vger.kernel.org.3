Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F774D36B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiCIR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbiCIR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:26:55 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDB3939A1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:25:56 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A2F073F79B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646846752;
        bh=w8PSCKHgDHhX5Fk0xr0ksja4KZOk9BnJpb1vWvY5lY0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jVcjgyyR1ErHJvmdajevlKSPULJKAB6Y+cceZ1UVwa051jQtwOPQpFOgo2/chKC6C
         NcYqRCSnCBnnaUveb/PsphCXKWotiqXU8i9yT+b8tJwbdZW990iJ8FWStFvegIKyWb
         S8NPh6XRCpNLLUZuCKAMtxrdTPTFkbH9D0OpLY4oZBx8Mbuz2zBm22rHBEvjUXx5VE
         5c5WXP05EzH2T4RnHh+kk8753kg1O7sqPxQjHKdk5rXZMV0ozAkzRknEF+gUhLmN3d
         gnx2iWNX6uZBF+L1wLyLjtYrhQo6pDCyjLP64SXzurpd30pEtOgQ0HZ/10MOBVafYe
         L9mCSIZwuuzKA==
Received: by mail-ej1-f70.google.com with SMTP id l24-20020a170906a41800b006da873d66b6so1666096ejz.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w8PSCKHgDHhX5Fk0xr0ksja4KZOk9BnJpb1vWvY5lY0=;
        b=54n6XlSCz/XcZ41wS6Hp9Hh6s8jmq/kbQ/tXjWRIOGy6J694jB0RwQHad1OW3f6eDr
         01OAeB+EVZXz7fCKo+VgZDy4z8jnMZJX2eSdZckDOu+HW6j3ClNYHKLr+A6WeJgq/JH5
         Pa2ohgKYoY+C4rNUIqR/O7fsi2crTIWU9Y2bMl3pcWoI/P+O7ibj+SA4IMK4Gvumxu4G
         PfciLggYG2iqGBBOgQDnsjKKQsqPMCwQ0jdJ3H/dVH1WumdETARKfICPilApQaNh7seC
         j7Kr7sxSpBXQdFoGYtl2EVSfVd3YY7tHJ2pPUGosj1ynGa/QGx9lio/kiIPxs+POb5xz
         G1OQ==
X-Gm-Message-State: AOAM5314i3SNyLZB/RiUnoXmPM3Q3vVbh6gcX/o9yJ/rbryV/5UMROhu
        oCzk93PsqW7y6jkYxNcRMJdcJO++4Cdi2Cb3Alqh6oYf5ToEPz5D3LtXszg19mFUG9FYhnZPTNy
        E6bkYAvK6jLWMzwqkNaaoFkq08ZMvKrf6r2ovfBTtPQ==
X-Received: by 2002:a17:906:c1d6:b0:6d6:e0a3:bbc7 with SMTP id bw22-20020a170906c1d600b006d6e0a3bbc7mr776332ejb.484.1646846750459;
        Wed, 09 Mar 2022 09:25:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6x1VsSMjgBumRVLSBZgLWkRJGulfHwx4sCPHBQhOxMdDxarTS5BRj0fuRAdgAZPDfSlJmjg==
X-Received: by 2002:a17:906:c1d6:b0:6d6:e0a3:bbc7 with SMTP id bw22-20020a170906c1d600b006d6e0a3bbc7mr776305ejb.484.1646846750255;
        Wed, 09 Mar 2022 09:25:50 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id o2-20020a50d802000000b00410d7f0c52csm1103696edj.8.2022.03.09.09.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 09:25:49 -0800 (PST)
Message-ID: <a3fb72da-a9e3-04af-fa19-62765bf81c2b@canonical.com>
Date:   Wed, 9 Mar 2022 18:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 14/26] usb: gadget: s3c-hsudc: remove usage of list
 iterator past the loop body
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220308171818.384491-1-jakobkoschel@gmail.com>
 <20220308171818.384491-15-jakobkoschel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220308171818.384491-15-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 18:18, Jakob Koschel wrote:
> If the list representing the request queue does not contain the expected
> request, the value of the list_for_each_entry() iterator will not point
> to a valid structure. To avoid type confusion in such case, the list
> iterator scope will be limited to the list_for_each_entry() loop.
> 
> In preparation to limiting scope of the list iterator to the list traversal
> loop, use a dedicated pointer to point to the found request object [1].
> 
> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/usb/gadget/udc/s3c-hsudc.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
> index 89f1f8c9f02e..bf803e013458 100644
> --- a/drivers/usb/gadget/udc/s3c-hsudc.c
> +++ b/drivers/usb/gadget/udc/s3c-hsudc.c
> @@ -877,7 +877,7 @@ static int s3c_hsudc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  {
>  	struct s3c_hsudc_ep *hsep = our_ep(_ep);
>  	struct s3c_hsudc *hsudc = hsep->dev;
> -	struct s3c_hsudc_req *hsreq;
> +	struct s3c_hsudc_req *hsreq = NULL, *iter;
>  	unsigned long flags;
>  
>  	hsep = our_ep(_ep);
> @@ -886,11 +886,13 @@ static int s3c_hsudc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  
>  	spin_lock_irqsave(&hsudc->lock, flags);
>  
> -	list_for_each_entry(hsreq, &hsep->queue, queue) {
> -		if (&hsreq->req == _req)
> -			break;
> +	list_for_each_entry(iter, &hsep->queue, queue) {
> +		if (&iter->req != _req)
> +			continue;
> +		hsreq = iter;
> +		break;

You have in the loop both continue and break, looks a bit complicated.
Why not simpler:

if (&iter->req == _req) {
	hsreq = iter;
	break;
}

?
Less code, typical (expected) code flow when looking for something in
the list. Is your approach related to some speculative execution?

>  	}
> -	if (&hsreq->req != _req) {
> +	if (!hsreq) {
>  		spin_unlock_irqrestore(&hsudc->lock, flags);
>  		return -EINVAL;
>  	}


Best regards,
Krzysztof
