Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DDD4D3853
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiCIR5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiCIR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:57:38 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FDE5FB6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:56:38 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 61F433F60B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646848594;
        bh=ywWEngNkae6mKxGv+1cfuhQRhz77SMjtBbNBkeG8nw8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=opxAkGKE+ANGbqE49XImtNzXdL7bDDrHuO1RdyspQC+zv1qhaIIyXgBbuwyDwB73H
         qnW+8+FNZ/bmrxXH6RmWuODDskvbsW6eGzoc5lhuHJvnmziHW4n11RTJOWXbvzr+4x
         xWo0xd8vdVnODOQMcClcLBBN9pA5wKJ5SzEpPG7H5ABfoB5lpgUcy090leozq7kGBJ
         gbIrINqtVVsk5X8aeHXg1LncpeYCN+NSL4Cz9ov+aH6ylU6GkYEUtzUg52J1VdX0UH
         xKWzv6bFoboi31uCzipgbHw+O6qV5XiDp7mhb7QRiy0IJQb6plEaLA6Wxc2ma2s/H0
         m165q81/QzTBw==
Received: by mail-ej1-f69.google.com with SMTP id go11-20020a1709070d8b00b006cf0d933739so1714725ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ywWEngNkae6mKxGv+1cfuhQRhz77SMjtBbNBkeG8nw8=;
        b=cKyoX4+wEV4lOdWkQQTQjpMnsOvJ17M/S31L5ccnvi5ojEFwWHRwJEkJTI09Rs9Dfp
         D76n5Sy03RZCMYL8gCla40Kd9COTiWgkSJDSElC7A98lu1vHCtageqxQv+fdJxRYJPGV
         DAI5pXQvDLn+Uv9ZGYUa/bmkQ1jM5efiN8jcMntlymKrk1s7D8Erh39st5zuyub1PXd2
         lmYirFLkVdcSbzwgAPqSOk/G8xJwT9r8I1UvJABs1Zgc6ino6eu0I6UdBl4qamLDp486
         v6Z908ik4N1o46sk3AoK5B0qx+RBlByigtwLBmacN9quMaaHajZ3I2uYCnsCLFBLnP3T
         KYIQ==
X-Gm-Message-State: AOAM533E23wTFTUcrjSjtOMO+T4XJA7GkkFdfk2XcEjz2vLKuloT4jw4
        S1Soc3zhQ3+vz9IszEWPCZ2nW1vQi41yCn7m2idMwTEpXGrlSeBjst+i3IB9oJPCG9XkMVzr1+d
        GZpFWm+ds9sX+v9X7UU95v3I8227z3QYurbc9Dy9lEA==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr866310ejs.105.1646848593329;
        Wed, 09 Mar 2022 09:56:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwN6yRIxH1ByXIFcKPd19wdA/C3x9ZhriHZnykAidYhzyn7sr4M8QeESi5VszJkWH2JSACfjQ==
X-Received: by 2002:a17:906:69d1:b0:6ce:7201:ec26 with SMTP id g17-20020a17090669d100b006ce7201ec26mr866289ejs.105.1646848593018;
        Wed, 09 Mar 2022 09:56:33 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id h8-20020a50ed88000000b004160630c980sm1095553edr.62.2022.03.09.09.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 09:56:32 -0800 (PST)
Message-ID: <6867439a-b995-86e7-6136-bcb8709eeb90@canonical.com>
Date:   Wed, 9 Mar 2022 18:56:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 14/26] usb: gadget: s3c-hsudc: remove usage of list
 iterator past the loop body
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Greg Kroah-Hartman <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <a3fb72da-a9e3-04af-fa19-62765bf81c2b@canonical.com>
 <B269AAED-135D-4EAB-AA7C-26219581FB40@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <B269AAED-135D-4EAB-AA7C-26219581FB40@gmail.com>
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

On 09/03/2022 18:36, Jakob Koschel wrote:
> 
>> On 9. Mar 2022, at 18:25, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
>>
>> On 08/03/2022 18:18, Jakob Koschel wrote:
>>> If the list representing the request queue does not contain the expected
>>> request, the value of the list_for_each_entry() iterator will not point
>>> to a valid structure. To avoid type confusion in such case, the list
>>> iterator scope will be limited to the list_for_each_entry() loop.
>>>
>>> In preparation to limiting scope of the list iterator to the list traversal
>>> loop, use a dedicated pointer to point to the found request object [1].
>>>
>>> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
>>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>>> ---
>>> drivers/usb/gadget/udc/s3c-hsudc.c | 12 +++++++-----
>>> 1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
>>> index 89f1f8c9f02e..bf803e013458 100644
>>> --- a/drivers/usb/gadget/udc/s3c-hsudc.c
>>> +++ b/drivers/usb/gadget/udc/s3c-hsudc.c
>>> @@ -877,7 +877,7 @@ static int s3c_hsudc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>>> {
>>> 	struct s3c_hsudc_ep *hsep = our_ep(_ep);
>>> 	struct s3c_hsudc *hsudc = hsep->dev;
>>> -	struct s3c_hsudc_req *hsreq;
>>> +	struct s3c_hsudc_req *hsreq = NULL, *iter;
>>> 	unsigned long flags;
>>>
>>> 	hsep = our_ep(_ep);
>>> @@ -886,11 +886,13 @@ static int s3c_hsudc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>>>
>>> 	spin_lock_irqsave(&hsudc->lock, flags);
>>>
>>> -	list_for_each_entry(hsreq, &hsep->queue, queue) {
>>> -		if (&hsreq->req == _req)
>>> -			break;
>>> +	list_for_each_entry(iter, &hsep->queue, queue) {
>>> +		if (&iter->req != _req)
>>> +			continue;
>>> +		hsreq = iter;
>>> +		break;
>>
>> You have in the loop both continue and break, looks a bit complicated.
>> Why not simpler:
>>
>> if (&iter->req == _req) {
>> 	hsreq = iter;
>> 	break;
>> }
> 
> Ultimately I changed this based on the feedback from Linus
> (Link: https://lore.kernel.org/linux-kernel/CAHk-=wheru6rEfzC2wuO9k03PRF6s3nhxryCAnwR5bzKwPV2ww@mail.gmail.com/).

Not cleaner to me at all, but it's all personal opinion. :)

>>
>> ?
>> Less code, typical (expected) code flow when looking for something in
>> the list. Is your approach related to some speculative execution?
> 
> no relation to speculative execution.
> 
> I have no preference for one over the other, so I'll just change it to
> however it is desired.
> 
> It would just be great to have a (somewhat) consistent way so I can prepare
> the rest of the patch sets accordingly.
> 

Yeah, I understand. The code itself looks good, so:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
