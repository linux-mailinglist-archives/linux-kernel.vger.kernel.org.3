Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207FF47D45F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhLVPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:49:28 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42474
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236544AbhLVPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:49:27 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 699FE3F1B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 15:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640188159;
        bh=5hgZLopSA5RqgA5GFHhtSYmuF7JejYilzaVDTyDa+yI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=MNZ7qT8MlPQEZ1DmwvoR5wrHvhh5o5dNXaYIqReBfbK2WN5vykz3hNnK+LoIM0ltV
         pi9k2MPyKZBqot1hBUZIEr9K8spi8j2UtstCxb/NqcWKZIhkTR3Tqzab4AZEKAQQFQ
         hOH0BNy2txjDrFCS7g3ClE838r/mTmkNlc+Izr9m3g2tZKRx7Wj0W9tszPFan7I2V7
         icAiDTKaaxbzbIJxrLkNyMM+zco26TKcy2FbOJ8mvPi8ykuvaeoiueJYB+8F1XuwQu
         KUwaeM/jzG9SrTGEJ6UGgRSe2hjSLCVIj3Qc/jI0rjDE9OSmNWc5TTTSftMSniY69b
         MJl5oHxulh6WA==
Received: by mail-lj1-f200.google.com with SMTP id bd7-20020a05651c168700b0022d71e1839bso357628ljb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 07:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5hgZLopSA5RqgA5GFHhtSYmuF7JejYilzaVDTyDa+yI=;
        b=CpC5HNYeaJl9LIK2EAswpln4sebNnqXfOuoq/VI5Sbp+vzDu9e2JeqZnHPo0p6zweR
         Pyv2mzbT5P1vcVP0HkW2kzUeJTe2852I0WsFAMLsrhY9bAQ6DrEhheJpgxcr+VznMg3X
         hw5l8U/ZxDg5ypxxUWod0XFnBBA5bYwlWYmDnx1xUBuZYcHBko/zFutL+DMDNjIm+2dQ
         WgI1QpEyMASjjcjCfjSdfYeNfc/sZfhyDtDv56MHlxhX99OtmL3Ml7+ftd1lyl+LeOWH
         83DUZ/tkTcA7SyMhHQtnXbTZ9wcIlEDdP+wvp+uIT/leE911fP6Y/1VDS1a/SnCKm9tz
         VKow==
X-Gm-Message-State: AOAM5335sQ2Gxl3DVL6u9/8Q6I4whCW1Vo2RkhihbvfH42Vb4TWKl9e3
        lqwZI68LTJXHX9pbU5yji4dj7ASXq8nPqc5mm65kGIZ5/vNbKnDpBFhhsSDnjF0G/xVdHu4uZ6b
        //b2o49guWExj3oJNtdxa/39vQhmt9mWpqSjfxKMsDg==
X-Received: by 2002:a05:6512:3baa:: with SMTP id g42mr2755875lfv.651.1640188158869;
        Wed, 22 Dec 2021 07:49:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwr7cmepBfwLxRYZ+54oFEjSLqgBl8VM/NyfSsn8HLpTn8R8don1yxBiII9LLz1nQ7T4lVUA==
X-Received: by 2002:a05:6512:3baa:: with SMTP id g42mr2755857lfv.651.1640188158623;
        Wed, 22 Dec 2021 07:49:18 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id c36sm247915lfv.193.2021.12.22.07.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 07:49:17 -0800 (PST)
Message-ID: <a1ef85b2-25a9-dbdf-c6b0-b645d1c1aad6@canonical.com>
Date:   Wed, 22 Dec 2021 16:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 3/4] memory: omap-gpmc: Use a compatible match table
 when checking for NAND controller
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Roger Quadros <rogerq@kernel.org>
Cc:     tony@atomide.com, robh@kernel.org, kishon@ti.com, nm@ti.com,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211221131757.2030-1-rogerq@kernel.org>
 <20211221131757.2030-4-rogerq@kernel.org>
 <51b8e895-95e1-0024-1457-ec534985c9f0@kernel.org>
 <20211222151823.77179b74@xps13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211222151823.77179b74@xps13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2021 15:18, Miquel Raynal wrote:
> Hi Roger,
> 
> rogerq@kernel.org wrote on Tue, 21 Dec 2021 22:01:28 +0200:
> 
>> Hi Miquel,
>>
>> On 21/12/2021 15:17, Roger Quadros wrote:
>>> As more compatibles can be added to the GPMC NAND controller driver
>>> use a compatible match table.
>>>
>>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>>  drivers/memory/omap-gpmc.c                   | 6 +++++-
>>>  drivers/mtd/nand/raw/omap2.c                 | 5 +----  
>>
>> Will need your Ack for this one as well. Thanks :)
>>
>>
>>>  include/linux/platform_data/mtd-nand-omap2.h | 9 ++++++++-
>>>  3 files changed, 14 insertions(+), 6 deletions(-)  
>>
>> cheers,
>> -roger
>>
>>>
>>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>>> index 624153048182..d19ffc895e5b 100644
>>> --- a/drivers/memory/omap-gpmc.c
>>> +++ b/drivers/memory/omap-gpmc.c
>>> @@ -2091,6 +2091,7 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>>  	u32 val;
>>>  	struct gpio_desc *waitpin_desc = NULL;
>>>  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
>>> +	bool is_nand = false;
>>>  
>>>  	if (of_property_read_u32(child, "reg", &cs) < 0) {
>>>  		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
>>> @@ -2183,7 +2184,10 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
>>>  		}
>>>  	}
>>>  
>>> -	if (of_device_is_compatible(child, "ti,omap2-nand")) {
>>> +	if (of_match_node(omap_nand_ids, child))
>>> +		is_nand = true;
>>> +
>>> +	if (is_nand) {
> 
> nitpick: why this intermediate variable?
> 

Indeed, it looks useless. I think it is left-over from previous version.
I will remove it while applying.


Best regards,
Krzysztof
