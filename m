Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AF947C2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbhLUPdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbhLUPdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:33:21 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772DBC061574;
        Tue, 21 Dec 2021 07:33:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x7so5655575lfu.8;
        Tue, 21 Dec 2021 07:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=FjVlZpnpY4Z310rhKXul6hLFct/iU830gKgqrVH+cMc=;
        b=MNC9sks+TavMz/UTXnnP9c9gy3MFbqvM73x2uvgzjByMorOfPlOHYb/p8/9CX1hb+d
         +GAXa2M0D96vRqtbPWq7gAJldAwt8F/guZJQVdbuoGZZPyZ69SoVCnm0/wMsx5Lc81Xm
         WxFoFmOZ0y82trShQW4eZqgzXAjffMh9CVj27XTLNg3jXVlU9aoJ/bnobDuMzD5ymC7R
         vfuQ/iknPxcJpvcBJihV/VfWZKp3+BZVP3xcTIo6SJ5FPo3wgJaRLOIRCpOWU1uK5X0r
         YjStTb8E94xULg2jAxFO+gWwqv8CjpS5XGvZYX9XYraZFt50L+3AOil1sjw4puaSuB2l
         H/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FjVlZpnpY4Z310rhKXul6hLFct/iU830gKgqrVH+cMc=;
        b=Y7NQvnZEgMPxrl4NwRY4+FJhFAL55ycte+Id625RQlh88C1dC8jlQwRIaLeACEfl91
         Au+VzOrwJl+2Zcv5svzPgHygNPCj9sg/MmtDqxuVyE7U0moQ5Q00qY9Z/SUcuDHTlpLC
         9Qrk7uWZWZ4vF6W8ntcU9s3y4X+QlovBt1DwbkTWMf/8eV5aZJOQdoOatd495JgWnKAH
         BsMeBDbZ0xTmRGjzEfbebsQR5gEM7XpGPxUSd7No8jebkLhlLa+czHLyAwblGZpYIQFg
         YUhasiPtMstydi5H/98PFmE5gar/IeQ0Y0SqDooGnlrFOiGFTV8YL0pIgGKpDRZ8423y
         L4Jg==
X-Gm-Message-State: AOAM533upMpLKXqJjJMs2rWbapDgLT0ARbs+xeE1dDfw58VDMSnQEhvU
        UfRrZPWRFjrBiGBZP+sol9I=
X-Google-Smtp-Source: ABdhPJxGH9fJxCgJTHdyBCbGxtJaXgQRFGvDM9RlVccZ929DQy80oSK9LxHsX/03MMs6nTipuYM21w==
X-Received: by 2002:a05:6512:2601:: with SMTP id bt1mr3453703lfb.400.1640100799808;
        Tue, 21 Dec 2021 07:33:19 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id k3sm2760634ljn.55.2021.12.21.07.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:33:19 -0800 (PST)
Message-ID: <e6167555-6425-4457-254d-8cba61153b1a@gmail.com>
Date:   Tue, 21 Dec 2021 16:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH 2/2] nvmem: expose NVMEM cells in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <YcF4E82M89huIbSD@kroah.com>
 <3cb1d0a4-6e20-f751-6d66-c1487ef31f30@gmail.com> <YcF+g0ra5tttXOQF@kroah.com>
 <0527135c-35f5-bc63-edb3-81cb03eb03f6@gmail.com> <YcHPGQ0FH0kTzpbq@kroah.com>
 <ab52292c-3065-789b-d5ae-ef24bab5fc90@gmail.com> <YcHWVMa6vjz3Gp51@kroah.com>
 <d626c2c2-5071-522f-330f-688254087d74@gmail.com> <YcHkS0iDUhplbqUc@kroah.com>
 <76fae18d-f4aa-450d-b8ba-19fda137fe25@gmail.com> <YcHwPt2Uc8KSy3lG@kroah.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <YcHwPt2Uc8KSy3lG@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.2021 16:18, Greg Kroah-Hartman wrote:
> On Tue, Dec 21, 2021 at 04:09:13PM +0100, Rafał Miłecki wrote:
>> So both: kernel and user space need to access U-Boot environment
>> variables (NVMEM cells). Each for its own purposes.
>>
>> Kernel goes first so it needs its own parser of NVMEM content (data).
>>
>> User space can either: get NVMEM cells exposed by kernel OR parse NVMEM
>> content on its own. I thought it'd be nice to avoid parsing code
>> duplication in user space and let kernel expose NVMEM cells.
> 
> Ah, so you already have the data parsed, and you just want to also
> expose it to userspace.  That makes more sense (sorry, it's been a long
> day of reviewing crappy patches, not yours of course...)
> 
> So sure, you can dynamically create attributes and then add them to the
> device before you register it with the driver core.  Be sure to
> initialize them properly with the call I pointed out previously and you
> should be good to go.  You will have to keep a list of them around and
> then free them yourself when the device is cleaned up, so watch out for
> that.
> 
> And again, don't use a binary attribute, that's not what it is for.

Thanks for review & discussing this! I really appreciate you getting
this patch details out of me so it's clear how to proceed.

Lesson learnt: spend more time on describing my commits.
