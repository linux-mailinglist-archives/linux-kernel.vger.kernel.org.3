Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E147F14F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 23:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhLXWME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 17:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhLXWMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 17:12:03 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05365C061401;
        Fri, 24 Dec 2021 14:12:01 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id g2so8484500pgo.9;
        Fri, 24 Dec 2021 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8Q9rJlUXSRgbhz8EFCRzzeIiJprfQp4GPhKMSBPYpkE=;
        b=UKuLj8YfeWXLMwA8QCvyYIWWUy67vGEJdJ2flNwpc574CQmzyKPwy2wXLOTKklUnor
         AWELYw8a8krkgkJgsTkdRMsrqJG6W4QsOGm45YMtQ3/Y4FBHlZ6yR2k4gvcKNYuOj7JO
         GJYRTFEr/AU9eV9/A22wM8Qrs2sC60c0Mr6Hl9/Urkw/hUybMKqUtrs21XfUEiUJmfQR
         Qs44JYJdPvdX4CPydLwPXpKCjfK6EDysC4A7/bKYJvJmR+sT+Akmh9zEZ9cfif4xHSNr
         sAyMEanNRGFhDuCQAqMr6odA/vI6yHGGnYST37inkCOdEuZU3e7xTpscAuXgbQOFUv25
         wTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Q9rJlUXSRgbhz8EFCRzzeIiJprfQp4GPhKMSBPYpkE=;
        b=jQBqT0DQTtBHq6dcXsqC9bB6aMjQr8t1COY5UhaZYBWHL8hL0qPHvXt8UgVdRbtYiy
         sFBuVf2cXgC0OBk0iLnxV4O5jKv8gUZHcm+W5OqNUQuZwOFRzFwt67cPX2lB8xVEMQj/
         hUwm0cXbhHBw10SgviQnHzqvOYBTEVWPTpGM5U1MgUDCWh7jGtDFREsSMIOClYYlbRNh
         EveP6V84cZJ+4DQu0tkD3o1se4WyFIo7OqBri68uHsmTG9acPcFdJpbVRla5u3rzPBxz
         vqFTnp5BspnZnNxS99+jvV7+0EDGdpu/OkBfhaEqmyX1njXBIqOWu+5meiHhlkd5vzhL
         iX7g==
X-Gm-Message-State: AOAM5312nbMH6Pv837JBkGQxuL4Zg05iI88g4hUvvtmXpvAqV1wxNVGY
        GXwFObhUwha6xGEQWRULs+CYDdyXDyI=
X-Google-Smtp-Source: ABdhPJyuz7FSv6unXXhlUtdH6M65fdUCmw1lGbEnSUTip8lZ4gDL7sQew0PcIeZYeRql0Y31/Qw3Dg==
X-Received: by 2002:a05:6a00:8cc:b0:4a8:262:49e1 with SMTP id s12-20020a056a0008cc00b004a8026249e1mr8200515pfu.28.1640383920498;
        Fri, 24 Dec 2021 14:12:00 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id g21sm10126471pfc.75.2021.12.24.14.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 14:12:00 -0800 (PST)
Message-ID: <00032713-ba91-008f-e7a7-f846b2554cbd@gmail.com>
Date:   Fri, 24 Dec 2021 14:11:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 03/10] serial: 8250_bcm7271: Propagate error codes from
 brcmuart_probe()
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-serial@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20211224142917.6966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224142917.6966-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211224142917.6966-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/24/2021 6:29 AM, Lad Prabhakar wrote:
> In case of failures brcmuart_probe() always returned -ENODEV, this
> isn't correct for example platform_get_irq_byname() may return
> -EPROBE_DEFER to handle such cases propagate error codes in
> brcmuart_probe() in case of failures.
> 
> Fixes: 41a469482de25 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
