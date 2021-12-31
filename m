Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4FF4824C1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhLaQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhLaQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:15:33 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3749C061574;
        Fri, 31 Dec 2021 08:15:32 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso30829545pjc.4;
        Fri, 31 Dec 2021 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7V0XYvSQllW1asiJq2TwrZzb2iweWy325alsPxk79I8=;
        b=KFZApj0nXujFf8KygHjxyI9V1L49TwoYY3FhyKjB4EIBKugxBAh/2r1ggyRyrB581y
         YZYlMJTHkmfhEDT+U0pEjcWfPnvdUZ1RhydhehusFnMXLrSKwWg9hbw42h5HBF9Rc8Zi
         Htxm9uemlsK7xPj/fQnnMVX2LxZZt5qtL/NZ9tH2j3700dwIwJYJK/Q0ZPdLTr/OJlrP
         iagjeZ3DuGJAXs2gzrC+w+8Yu2hnWz9VufdsStu6nKEE030EEtFEHK75SXhmocziw+5B
         DlX73OPQXt0hU7REp/sa8g+JHbqVv5Y4r7oF1dphNhBvDkZxQ5p/Yn+ciewIJ7LTH2uI
         hE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7V0XYvSQllW1asiJq2TwrZzb2iweWy325alsPxk79I8=;
        b=Nmb9PW1GB3ovemxQDfoNqeJcsBGtHa+xA2BhSeCUhYUc1U1wHH4DV/E88+m05qRRMo
         0vMlWsWm9npGjjOs+S6Mr78yPhUD0vrR3O4q4irrScTCQ7hoNW0dSj7ZQmMYw25wn24N
         egH8FvWTBbzvYIFyxxstX1aDgS6WHRL5Y/L5DvOIe1K6mbd5wNazOTVVPEoVS4qskLQK
         sTC1qRIdPDsB3P8VmF2k7FO6KfWpSYkNId6mWyo7nbTK6BOh0tIewF8Eo50EDMGUvA1B
         FO3KrOgixn/ihy078/lmO798hVowTmprXNm2oQszGxqhaUH6HwkjkPYm1nNmYDRC3J7i
         Wwkg==
X-Gm-Message-State: AOAM532Os3OUD4Ej12seJDZCbTyBk/LsCknjK3YQb1b77p9jgX/a2Mx0
        fyfbLp6jJQmuACGq4wcFkcfU0PAxf7yn6w==
X-Google-Smtp-Source: ABdhPJwpQuByjh94s1QN76QOXfydEXQn4XX87z7SGF1v61lX0SBkKiKLaqHpXNoRt9sz9SgOIMS7gw==
X-Received: by 2002:a17:902:e801:b0:149:14a4:b764 with SMTP id u1-20020a170902e80100b0014914a4b764mr35794643plg.51.1640967332143;
        Fri, 31 Dec 2021 08:15:32 -0800 (PST)
Received: from [0.0.0.0] (ec2-16-162-143-64.ap-east-1.compute.amazonaws.com. [16.162.143.64])
        by smtp.gmail.com with ESMTPSA id e15sm31441978pfv.23.2021.12.31.08.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 08:15:31 -0800 (PST)
Subject: Re: [PATCH v3 2/2] usb: gadget: clear related members when goto fail
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        jj251510319013@gmail.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211230051132.21056-1-hbh25y@gmail.com>
 <20211230051132.21056-3-hbh25y@gmail.com>
 <Yc4MeIt6JygZ6CrY@rowland.harvard.edu>
 <CAOo-nLLpNfHzrOyF4P0XvFK1h+J+aZqGL+AqmZP2PG6C=rcFjg@mail.gmail.com>
 <Yc8odYb41iNuQ16J@rowland.harvard.edu>
From:   Hangyu Hua <hbh25y@gmail.com>
Message-ID: <268b05c1-846e-c229-277c-140c13fc87dc@gmail.com>
Date:   Sat, 1 Jan 2022 00:15:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yc8odYb41iNuQ16J@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I get that. I will fix and resubmit my patch.

Thanks again.

On 2021/12/31 下午11:57, Alan Stern wrote:
> On Fri, Dec 31, 2021 at 10:31:51AM +0800, Hangyu Hua wrote:
>> On 2021/12/31 上午3:46, Alan Stern wrote:
> 
>>>> @@ -1892,7 +1895,12 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
>>>>       }
>>>>       return value;
>>>>
>>>> +fail2:
>>>> +    dev->dev = NULL;
>>>> +fail1:
>>>> +    dev->hs_config = NULL;
>>>
>>> It is not necessary to have all these different statement labels.  You
>>> can simply have "fail:" clear all three pointers.
> 
>> I don't think so. It is not necessary to clean all three pointers if
>> some of them aren't kbuf. I think it may be better to keep their own
>> pointers.
> 
> If the pointers aren't set to a region inside kbuf then they are
> meaningless.  There is no reason to keep the old values.  It is better
> to avoid multiple unnecessary statement labels.
> 
> Alan Stern
> 
