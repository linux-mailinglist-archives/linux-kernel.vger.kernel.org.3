Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779A0480295
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 18:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhL0RGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 12:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhL0RGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 12:06:01 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C0C06173E;
        Mon, 27 Dec 2021 09:06:01 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id t18so20361070uaj.1;
        Mon, 27 Dec 2021 09:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/Jl9rD98P7u8+W/KPfuS6926/YvVcB+fWGfP5gXmcTo=;
        b=DDIfjCIH8zwOvNzVxa6/z0ntzbksgSSL55dovlZgWOtGSrp3q1ZaH60trhPrBO7InU
         VQzMnJflyMmq1QzPT7DEvhz62ejT/hFT0wjAjxwDXWyaPtjdk5Zi8t5nAy/6/jv76drI
         M9izPrQFhzXJCFjuvZ6thVvLO6WMqpQa1emRr/faWqTsHilWmOgaKDoE6iEMFYq8rx6x
         Ys1H9LtoD+fHreydGZ+bsh6TW1LLAI90CgvBxyVxyJKZhXp7ph/ujC1j74L22ZWv9PHX
         R6TGHEHxozjoooC98744KFk42Cdo+KUCfaMoA3Z3SErBc3wxVKqUdtqrhndUDDgmdg26
         29Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Jl9rD98P7u8+W/KPfuS6926/YvVcB+fWGfP5gXmcTo=;
        b=ABWCJq/4DtR1dEV4LdeONtZYqDxXIlyXHyeDxBTsn/fp8djfsf/iIoBeqSvxVS5TE3
         Z8YCvQ04nt8Z4vw5oMQuOnOGAUofF7OnqhnItAhbvnbVdKichSUFFTQargL2DWlYLHH0
         GIK2M4CIsL1vwOcPhzwij14uwFf8Wjsu+RcJPlwLMWQiMe23GmABURMlqVVWlZTdjxA4
         b2C4BLma0ZIRdnthVNB9NNDr8SqPonPD51LbWTRIREIvNJJ0rmjDgRmFDgvw5/77VdUL
         aR6NQRqVuPEzcBgjuW+z4RbPZV3BtJ4cZyzN2h2SI7Oc8GblVyViztmszarQMgmfUmhg
         kAgQ==
X-Gm-Message-State: AOAM5334EeI07KTHGGCx4GFM1G7BMJ1sHIMb29aythZVjkrNKGPnTOvu
        R0U7WAzlvSbGIkJk/wJpnww=
X-Google-Smtp-Source: ABdhPJy0eYa4Kbf89/rW9lywsPSxvgEPpudw09MmZke+H+vogBjO7hdxao99ZqQw5ZKvwLE0rweVqg==
X-Received: by 2002:a9f:2322:: with SMTP id 31mr5172057uae.133.1640624760159;
        Mon, 27 Dec 2021 09:06:00 -0800 (PST)
Received: from [10.230.29.137] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 92sm3030310uar.19.2021.12.27.09.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Dec 2021 09:05:59 -0800 (PST)
Message-ID: <ee2d9730-6f7c-a210-8949-0eb2edd9b22e@gmail.com>
Date:   Mon, 27 Dec 2021 09:05:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 5/9] mtd: rawnand: brcmnand: Allow working without
 interrupts
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
 <20211223002225.3738385-6-f.fainelli@gmail.com>
 <CAHp75VeLAuGbeh+DJ=Oox5o8vdt=iLxr80sS3RrZbdJ9smh4OA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAHp75VeLAuGbeh+DJ=Oox5o8vdt=iLxr80sS3RrZbdJ9smh4OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/25/2021 9:45 AM, Andy Shevchenko wrote:
> On Sat, Dec 25, 2021 at 1:41 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> The BCMA devices include the brcmnand controller but they do not wire up
>> any interrupt line, allow the main interrupt to be optional and update
>> the completion path to also check for the lack of an interrupt line.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
>> -       unsigned int            irq;
>> +       int                     irq;
> 
> instead.,,
> 
>> +       ctrl->irq = platform_get_irq_optional(pdev, 0);
>> +       if (ctrl->irq >= 0) {
> 
> ret = ...
> if (ret > 0) {
> 
> And drop 0 from the equation, OF never uses 0 as valid vIRQ.

OK but the point of this patch series is to allow the use of the 
brcmnand driver in a configuration without OF. I don't really see the 
point in continuing to use unsigned int instead of just letting 
request_irq() play through and tell us if the interrupt descriptor was 
valid later on.
-- 
Florian
