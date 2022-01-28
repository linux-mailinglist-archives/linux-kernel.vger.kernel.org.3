Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B668D49FFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244075AbiA1SAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235275AbiA1SAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643392799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u+Hmwc9+6O6R90bO9i51djyWsBTgueZPwQigGIkzQcY=;
        b=F4skjyGf/l4LzaJQ7R4iBqESqcW6YAq/mnf16jij3kkXz29kpeXVAw3bC0/WnRHZKk4eqp
        ghqL78vwjb/RCDfDxPwwghAVtheIeixhqxpQ5K94LWKOwXux/aM9QzYIVp8wFfQHaP1NI1
        KUwaZdhk3il+5LY7o+7QVZsIj7XSJXc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-01fRe9lmOkGrm9b6M9o4cw-1; Fri, 28 Jan 2022 12:59:58 -0500
X-MC-Unique: 01fRe9lmOkGrm9b6M9o4cw-1
Received: by mail-oo1-f72.google.com with SMTP id x10-20020a4ab90a000000b002eacf86f7cdso3537835ooo.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u+Hmwc9+6O6R90bO9i51djyWsBTgueZPwQigGIkzQcY=;
        b=KkokuwKpw3enlqj41PEWQqGq/FyXq4QY+jmI09h5wU9f5FGXXWavE/Xd1cX9EANe3p
         zUzcfiR50h/C9Xw1EzkIx4Bdsnfyh8U3q2lAVyRKkyNw5StCe7pqs5AC/P9URpM0SV7k
         T7O2Y0NyorjqyGRcjosQC52JrGokFWYpWy2YmeaH4RZohyKOK3IAgUdfx4znFWeB03rR
         AoUooGKUxhfYwyzJ5FUagbsnAttZAOie1qWobTowE6WufLX/wr0+x0wlEyhqMFOvRnv1
         oZfW2p+wYW+safRk0zBYKooRBRs2M+mKfhnMj9mOiNZKPR99yLTKTloxc1bHvilNAMQB
         gteg==
X-Gm-Message-State: AOAM530WSWXgIm5JRLiWIFacefVwnS4sfIxvX/R4T2ZSFYCMKMAJ4aNQ
        g2YFvyFgRCl5YkEzEU9i44XAY8JTNI9VW61PC+KFft6Gp0D0tTlulRJxdKlI78yNJKkoGrK+g+T
        TMZKQmBFjhXfCN4Eu/CEttZeT
X-Received: by 2002:a05:6830:1091:: with SMTP id y17mr5517932oto.251.1643392798032;
        Fri, 28 Jan 2022 09:59:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7tzvwbAnDL33am0wCZlnAvRFJbSDVAbo5b1w5J/mtfZ8VVd+wV4q4yxN0XRiY8J66auWK3w==
X-Received: by 2002:a05:6830:1091:: with SMTP id y17mr5517919oto.251.1643392797859;
        Fri, 28 Jan 2022 09:59:57 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id l19sm4578463ooa.7.2022.01.28.09.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:59:57 -0800 (PST)
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Bart Van Assche <bvanassche@acm.org>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220127151945.1244439-1-trix@redhat.com>
 <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>
Date:   Fri, 28 Jan 2022 09:59:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/28/22 9:42 AM, Bart Van Assche wrote:
> On 1/27/22 07:19, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> checkpatch reports several hundred formatting errors.
>> Run these files through clang-format and knock off
>> some of them.
>
> Isn't this the kind of patches that carries more risk than value? 
> Additionally, this patch conflicts with a patch series that I plan to 
> post soon.
>
> Thanks,

I have dropped this patch.

Long term, it would be good have a reliable way to automatically fix 
either new files or really broken old files.

So you could do two patches, first would be fixing formatting problems 
and second would new stuff.

As it is your new patch will have to both for now.

Tom

>
>
> Bart.
>

