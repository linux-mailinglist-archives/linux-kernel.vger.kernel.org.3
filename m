Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F64F5F94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiDFNOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiDFNMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:12:54 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1685F90BE;
        Wed,  6 Apr 2022 02:50:19 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id g20so1932702edw.6;
        Wed, 06 Apr 2022 02:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PO8bgVYc+6yq/GV1chIgW+khCSDiG15QhmYnAA0FTmY=;
        b=jJY4a1XyPEMAt4EXBRXTFwKg733D9QCnjp+tvaRH5ix3czCPMdBiaFhGrl6pXlKB/9
         pIgnjxa8JfFVfQAwgIa+yBy47KMzwTPmkxQnuQvzyrn+oEZQxnluyC4h/IPHa7c4z2NR
         rCTvZe15XxY1xU7J16/Cyfwek8+3rskF/9+/Y7ujEb9T748yip38DNllJ7bxo5hEoyaS
         vDkrYzSsQy274lfuHEItbgQ1lc4RQtexBjLz75X6JcBPnvEMSKR+KAUAHnR7/qEwx0ny
         e8YLXLYjEoATiKiQJu1bMgT4Jl5h3FA2TZ/bv7Ga4xThOfLL+0tskUwvOT+0sY0JCjeW
         OhaA==
X-Gm-Message-State: AOAM532vz4Dw9LxDqYjIgDKvXTV7NrhizPwW7qr1CpZnTk1DayB8jxj+
        XlFzVyBFD+jgT/b/jPUVL70=
X-Google-Smtp-Source: ABdhPJwDepzSDc+UC30gZbKsINVUj0Z32NzckEH9QLPfmT3vbdsNLWRBxxyj70khlKjB9SmuoiVNsA==
X-Received: by 2002:a50:ed0b:0:b0:41c:cf60:a882 with SMTP id j11-20020a50ed0b000000b0041ccf60a882mr7956124eds.12.1649238539608;
        Wed, 06 Apr 2022 02:48:59 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id sb15-20020a1709076d8f00b006dfe4cda58fsm6356961ejc.95.2022.04.06.02.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:48:59 -0700 (PDT)
Message-ID: <98c359ba-9563-3da0-d968-ae40cee9d45f@kernel.org>
Date:   Wed, 6 Apr 2022 11:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] tty: serial: samsung: add spin_lock for interrupt and
 console_write
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Krzysztof Kozlowski' <krzk@kernel.org>,
        'Alim Akhtar' <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        'Chanho Park' <chanho61.park@samsung.com>
References: <20220406082216.11206-1-jaewon02.kim@samsung.com>
 <CGME20220406081823epcas2p2f7afa27e2402c4fc02c9bee5972bed4f@epcas2p2.samsung.com>
 <20220406082216.11206-2-jaewon02.kim@samsung.com>
 <Yk1NmTdUgMcSIq1O@kroah.com> <042701d84991$ca50d410$5ef27c30$@samsung.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <042701d84991$ca50d410$5ef27c30$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 04. 22, 10:39, Jaewon Kim wrote:
> On 22. 4. 6. 17:21, Greg Kroah-Hartman wrote:
>> On Wed, Apr 06, 2022 at 05:22:16PM +0900, Jaewon Kim wrote:
>>> The console_write and IRQ handler can run concurrently.
>>> Problems may occurs console_write is continuously executed while the
>>> IRQ handler is running.
>>>
>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>>> ---
>>>   drivers/tty/serial/samsung_tty.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/samsung_tty.c
>>> b/drivers/tty/serial/samsung_tty.c
>>> index e1585fbae909..9db479d728b5 100644
>>> --- a/drivers/tty/serial/samsung_tty.c
>>> +++ b/drivers/tty/serial/samsung_tty.c
>>> @@ -2480,12 +2480,24 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
>>>   			     unsigned int count)
>>>   {
>>>   	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
>>> +	unsigned long flags;
>>> +	bool locked = 1;
>>
>> "1" is not a boolean :)
> 
> return value of spin_trylock() is 1 or 0.
> It seems better to keep it as an int than to change it to bool.
> I will return it to int.

Hi, no, do not that. Simply use bool/true/false.

thanks,
-- 
js
suse labs
