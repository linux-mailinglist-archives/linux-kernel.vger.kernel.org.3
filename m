Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619394FBB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345067AbiDKLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiDKLvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44409D9C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649677748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C47F8Jf0+w7gVUhWNRSlQXSM6c8V9lKVzHcSZtA8aT0=;
        b=i4+XMYwRcRsSg7lek1mECoSYLKQhPo9tBffAc2q3qnNRh+U4ZoyTHKyPD9uDkiSYpzjrQ7
        TWKWd27tx9+8SZLeBNtN7dz5/qOE9gCPzyzqEjkJCMvomVAMGTroh4ZKNubWVHG3y2bOYF
        SrjZDgkx7DCIoKBNKSqjcRInOEm7xMM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-KOuiRmhtN9acozLuIR2Epg-1; Mon, 11 Apr 2022 07:49:06 -0400
X-MC-Unique: KOuiRmhtN9acozLuIR2Epg-1
Received: by mail-qv1-f71.google.com with SMTP id kd20-20020a056214401400b00443c252b315so15415480qvb.23
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C47F8Jf0+w7gVUhWNRSlQXSM6c8V9lKVzHcSZtA8aT0=;
        b=ptdu9lSS7w0chBKOw3HbziYl9MGL35ENyZIABQ1uomHLlOL8qYPoG486O4W1BR1qO+
         ptRUH/5/fNCUKprGbGXNSLnP5kvQLQiAhEGYTIz3/aB2akDDEmwb0oibc1GH1nc4w790
         oyVbZDG/nSOTThTP3qtxxqzWfdFOgTPi7bEiuc8O1NbRecIKxmguIhwz+D9cGnqtnIX5
         OR7UMMdDXuXwaGC/TmQ+qxA2A8ZfQI+Lz/C/jh/l/1i0mKnT+QPd1UhZNV9KP0HnD6TQ
         HZcvYK8T6KcYfxRcLNc/WCgSSt+Tu3p8osLw8D6Lts2kLmMH3YuZvceeCOq0LRNvojfq
         RD7w==
X-Gm-Message-State: AOAM530NxahtGkR9HWqmIfVoHM7NiOTTryp2i46r0DaYr29oA3hD4CQk
        J4SxYBge7irEKqYe3UDeYv28WBtO59Il5o9+jmdyou8y81wtvA6dx93334jJf5ygDaBN++uq8dh
        qNSsCZn7JnGhhi8HDQp9FMF18
X-Received: by 2002:a05:620a:471e:b0:69c:2e29:7b4c with SMTP id bs30-20020a05620a471e00b0069c2e297b4cmr1110890qkb.65.1649677746252;
        Mon, 11 Apr 2022 04:49:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcqVRzfFf+DL9+gv5UvinGvDX/+g+sbF3Fgbqad296zbxs7VMoB+NJJ4/qusVtoIB9uMIObg==
X-Received: by 2002:a05:620a:471e:b0:69c:2e29:7b4c with SMTP id bs30-20020a05620a471e00b0069c2e297b4cmr1110871qkb.65.1649677746034;
        Mon, 11 Apr 2022 04:49:06 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r123-20020ae9dd81000000b0069c362d5cb6sm138083qkf.105.2022.04.11.04.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 04:49:05 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: udc: clean up comments
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, joel@jms.id.au,
        andrew@aj.id.au, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        alcooperx@gmail.com, christophe.jaillet@wanadoo.fr,
        cai.huoqing@linux.dev, benh@kernel.crashing.org,
        neal_liu@aspeedtech.com, miles.chen@mediatek.com,
        balamanikandan.gunasundar@microchip.com, macpaul.lin@mediatek.com,
        s.shtylyov@omp.ru, jakobkoschel@gmail.com,
        stern@rowland.harvard.edu, quic_wcheng@quicinc.com,
        yashsri421@gmail.com, rdunlap@infradead.org,
        linux-geode@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20220410150828.1891123-1-trix@redhat.com>
 <YlQBgnjpkSurf9PZ@smile.fi.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ecd8609b-2c52-5fb8-7820-191559d76011@redhat.com>
Date:   Mon, 11 Apr 2022 04:49:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YlQBgnjpkSurf9PZ@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/22 3:22 AM, Andy Shevchenko wrote:
> On Sun, Apr 10, 2022 at 11:08:28AM -0400, Tom Rix wrote:
>> SPDX
>> *.h use /* */ style comments
>>
>> For double words, remove
>> with, also
>>
>> Spelling replacements
>> wayt to way
>> wakup to wakeup
>> Contrl to Control
>> cheks to checks
>> initiaization to initialization
>> dyanmic to dynamic
> Something really wrong with indentation above.
>
> ...
>
>>   drivers/usb/gadget/udc/amd5536udc.h       | 2 +-
>>   drivers/usb/gadget/udc/aspeed-vhub/core.c | 2 +-
>>   drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 2 +-
>>   drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 2 +-
>>   drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 4 ++--
>>   drivers/usb/gadget/udc/at91_udc.c         | 2 +-
>>   drivers/usb/gadget/udc/bdc/bdc_core.c     | 4 ++--
>>   drivers/usb/gadget/udc/core.c             | 4 ++--
>>   drivers/usb/gadget/udc/trace.h            | 2 +-
> I believe that Greg's bot asks to split on per-driver basis.
> OTOH I don't see anything that can be problematic if in one
> change. So, it's up to maintainers then.

Yes, whatever folks want. I can split these.

I have been cleaning up the comments in other areas and am trying to 
strike a balance between too big of a patch vs peppering with many 
single changes.

Tom

>
> ...
>
>> --- a/drivers/usb/gadget/udc/amd5536udc.h
>> +++ b/drivers/usb/gadget/udc/amd5536udc.h
>>    * amd5536.h -- header for AMD 5536 UDC high/full speed USB device controller
> At the same time you may drop the filename(s) from the file(s) as this very
> one shows why it's good not to have a filename inside file.
>

