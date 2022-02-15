Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3BC4B633B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiBOGDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:03:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBOGDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:03:09 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F13B716A;
        Mon, 14 Feb 2022 22:03:00 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id qk11so21560314ejb.2;
        Mon, 14 Feb 2022 22:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=m/+GWq7LGPjn6L3TlGLfnYbRWnVKngkEcYqskuqOhA4=;
        b=4M5sgZS04S0gcHTSLfDQwi3pdk1yrLGYURwUoRcY8wdwoCHwrfW/H//ftgWv+o5j3N
         R4c4a8UXP/BEKn17hsAqE1keTKg7KaWuI44eObDSKs65IOS9DM72KYwK9TuCQI+oFid+
         nfcfNkfMJhUI2imDZchc5vakgrZaHIH8KuHn3x3zajSzzjidMG/Lr5OSXhHujS/PAVES
         rr1bFOga/yAlldsYbOFolOl4llTd9GoWhty5UWMP/zMEpXdqzIoGcf0yMbWPhUH11hXT
         wqPZ6TOnGxNCJqPeJ0E0iehjkgYaTYl0DR4cmg+kB82HCUO3KRp/kBh79jVKVq6ysB1k
         Cu3g==
X-Gm-Message-State: AOAM533lHcXNimA8jbVqJfVJXLZDBWoTEOsEa8t0TTwex0hvkcTSDtj2
        F2VHwwSB754U9i6ix3mt4XA=
X-Google-Smtp-Source: ABdhPJwbXMZT0RA9BZurHDr47BqekBgRBAtuwCP+LWOn/a1Eqe9/WxyjJQ/QPlk8dsnOlZPfOkwhqA==
X-Received: by 2002:a17:906:9b93:: with SMTP id dd19mr1704122ejc.308.1644904979061;
        Mon, 14 Feb 2022 22:02:59 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id tc26sm1451637ejc.167.2022.02.14.22.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 22:02:58 -0800 (PST)
Message-ID: <621e2079-567c-6954-9744-c51748dd48dd@kernel.org>
Date:   Tue, 15 Feb 2022 07:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] tty: serial: 8250: add missing pci_dev_put() before
 return
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Qing Wang <wangqing@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1644890454-65258-1-git-send-email-wangqing@vivo.com>
 <67ace5d3-02b3-034d-969f-9a05bbdd8e30@kernel.org>
In-Reply-To: <67ace5d3-02b3-034d-969f-9a05bbdd8e30@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 02. 22, 6:55, Jiri Slaby wrote:
> On 15. 02. 22, 3:00, Qing Wang wrote:
>> From: Wang Qing <wangqing@vivo.com>
>>
>> pci_get_slot() increases its reference count, the caller must
>> decrement the reference count by calling pci_dev_put()
>>
>> Signed-off-by: Wang Qing <wangqing@vivo.com>
>> ---
>>   drivers/tty/serial/8250/8250_lpss.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_lpss.c 
>> b/drivers/tty/serial/8250/8250_lpss.c
>> index d3bafec..57e462f
>> --- a/drivers/tty/serial/8250/8250_lpss.c
>> +++ b/drivers/tty/serial/8250/8250_lpss.c
>> @@ -149,6 +149,8 @@ static int byt_serial_setup(struct lpss8250 *lpss, 
>> struct uart_port *port)
>>       /* Disable TX counter interrupts */
>>       writel(BYT_TX_OVF_INT_MASK, port->membase + BYT_TX_OVF_INT);
>> +    pci_dev_put(dma_dev);
> 
> 
> What about the "return -ENODEV" few lines above?

On the top of that, the code stores the pointer to the dev:
param->dma_dev = &dma_dev->dev;

So we should likely put the device in ->exit(), not ->setup().

thanks,
-- 
js
suse labs
