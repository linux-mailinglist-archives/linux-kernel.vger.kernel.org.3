Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569A4509AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386856AbiDUItn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386852AbiDUItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:49:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC47B1F8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:46:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bv16so5610101wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Z1R8XAgRO1RY9ptbheHK+UH29R2eRMz8Ro595MvYVes=;
        b=aOom/33qqLb3Lfu2zcsAjrk7UdXHJJVRy0kJNKJDjgPslzoTYHMMljkC085jJpJYR4
         EegA7KKwIkF+/1WfHa3PQDt8NPu1ipsKPgiV9Avgu/YlXoYfX3R3pVRdtMLK0PAE95+G
         UHsar2YSfO7sL93bYGnai0RpaCTbEzQAbufLW2NgH5woKN7/5vWtjkeIg6qBaVFU9VPh
         Er2VeFX0ErcmUSIvBehlMeYXwv74Smim+58XkpaLUxJJBJDykvoLxNjR1g9kU7+ERwWU
         wOq/Kfa6Rk9IbqfWUUDvnYA5BPRNIkFSag2Qr75UmCf3pYTGplwMsiLgofgIOxNEtMbH
         LLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Z1R8XAgRO1RY9ptbheHK+UH29R2eRMz8Ro595MvYVes=;
        b=o/hE6IPPMxVduEM0TJDCXTEKeXUaX9k2NENfTQpng0cHpYRWiTUqYs6HhakATperkh
         k376Vm//XaIIL3EjNLbGnnlebCQ5XI+JkXWTyoW128vMdqwau5kgmvBEuIypm788V2h9
         6JVirDb3jgptvLD1tE7WFSFWzV7V3K/+a61SSqCdJLgJrNLQKuCPN+PBWN8xX95HgcAg
         wYoFQe2DL30bGkzu1SqXxqEKwFVuvBoLc0zRsagKMUHCe7eUSc7KlU8XzxIwoF7TVHoe
         EEfoE5ug69XY43YsdqbLygXFTRRMCOx14eViI62/6rLSuCWWeWNzKZpIyzg5oED+DAt7
         94kA==
X-Gm-Message-State: AOAM531v0ieDNYT1dmzZTLJm0Zxb6E1g6DK5PCNEmUX7jYp+8OMCrzDG
        P352alx+dCTGU3MMXpEb6ULZ8w==
X-Google-Smtp-Source: ABdhPJzkRWJgbzkZ114xvkXhqIqlkVxz401XfIJZslOH3Cuuu/rWZ1ncxnciYetQhmsi7vVlYYPT2w==
X-Received: by 2002:a05:6000:c4:b0:20a:bfeb:68dc with SMTP id q4-20020a05600000c400b0020abfeb68dcmr1261741wrx.488.1650530810597;
        Thu, 21 Apr 2022 01:46:50 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:35ba:2677:956:980d? ([2001:861:44c0:66c0:35ba:2677:956:980d])
        by smtp.gmail.com with ESMTPSA id b14-20020a7bc24e000000b003899c8053e1sm1675671wmj.41.2022.04.21.01.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 01:46:50 -0700 (PDT)
Message-ID: <ea86eee0-409c-2d19-3669-35a8eaded53e@baylibre.com>
Date:   Thu, 21 Apr 2022 10:46:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 1/2] tty: serial: meson: Add a 12MHz internal clock
 rate to calculate baud rate in order to meet the baud rate requirements of
 special BT modules
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yu Tu <yu.tu@amlogic.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220418053202.24528-1-yu.tu@amlogic.com>
 <20220418053202.24528-2-yu.tu@amlogic.com>
 <CAHp75VeW65dV9jJu8-yUWME+XKnaxZBu5Zv8iEJxP2dizA=HUg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAHp75VeW65dV9jJu8-yUWME+XKnaxZBu5Zv8iEJxP2dizA=HUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 18/04/2022 14:09, Andy Shevchenko wrote:
> On Mon, Apr 18, 2022 at 8:50 AM Yu Tu <yu.tu@amlogic.com> wrote:
>>
>> A /2 divider over XTAL was introduced since G12A, and is preferred
>> to be used over the still present /3 divider since it provides much
>> closer frequencies vs the request baudrate.Especially the BT module
> 
> 'e. E' (mind the space)
> 
>> uses 3Mhz baud rate. 8Mhz calculations can lead to baud rate bias,
>> causing some problems.
> 
> ...
> 
>> +struct meson_uart_data {
>> +       bool has_xtal_div2;
> 
> I would prefer to see this as an unsigned int and with a less
> particular name, e.g. xtal_div would suffice.
> 
>> +};
> 
> ...
> 
>> +               unsigned int xtal_div = 3;
> 
>> +               if (private_data && private_data->has_xtal_div2) {
>> +                       xtal_div = 2;
> 
> Better to define privata data always

While I'm in favor of defining private data, here 3 and 2 are actually the values
2 and 3 used to divide.

The code is easy to read and we quickly understand this value is the clock divider.

> 
> 
>> +                       val |= AML_UART_BAUD_XTAL_DIV2;
>> +               }
>> +               val |= DIV_ROUND_CLOSEST(port->uartclk / xtal_div, baud) - 1;
> 
> 

