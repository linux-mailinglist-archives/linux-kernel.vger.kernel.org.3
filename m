Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2747AA5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhLTNa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230176AbhLTNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640007024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2EKJ44NVclr39JIBnz6A51WStQAYZHbOe+OWM8qvbU=;
        b=dYUjBkDt1ssGJnahq26RaXEwkRHEGtnJRZTsKtup4BV+7R5yC2e2U9GIiRKcUyC4pJU8/N
        MZef1YeDl/K/KPEFRJeko8Tg8q4UvhalZpwAJbH6vTOBy6GWH1aNDqkO9t9+QJS4pA4hev
        6DpiSzcbZf10a9by1a/b9W86Y8D9V8I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-jv5APi1EMmq25IGRHhcwwQ-1; Mon, 20 Dec 2021 08:30:23 -0500
X-MC-Unique: jv5APi1EMmq25IGRHhcwwQ-1
Received: by mail-ed1-f69.google.com with SMTP id w17-20020a056402269100b003f7ed57f96bso7537003edd.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 05:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z2EKJ44NVclr39JIBnz6A51WStQAYZHbOe+OWM8qvbU=;
        b=lnK4DWL4L2n6AZRt1lJKBkLjaxym4tR4pRBMSjPCw4wfNX8FCUTtsOCpycGNjtsbwJ
         K2TjlHyLiqhA3NKygoL2aTSkAmNEJL42d10KgaH4KdSYu01VKcrr49Gerv0Oawr1q2hE
         g61Zz0JY0/vJVBwbSStqo6NecI9icDf5fBXE2ilovuUbFjyhaGEBNoJyqTWmTr8G3k9T
         sWbcWhssxNAON5TSJC3xzYkKSVHHdCn7xGza+Y6dCt+W5ThEiKIC0tVCAgPMebv8Z9PJ
         Myt1v+FcPDOixlXjeUP1V7XeLsZAZQ3UVsbETwg+7SdRyWpe1tVhOtczoiPW2JwfpiB8
         imjw==
X-Gm-Message-State: AOAM531+IX700VKyF0cVz2EAXf5Uf8876eeQXHkY+bQm7pCjt0staPLs
        cJyEAh1fFwZH4xQoQ3r3D+oZ8FvhG2Bvzw2z/ZW5OmF5XQ5tdMmx8X5WqJavWftsWQHMXZ2qUoP
        UlbGFOcTfSfTPHzhetAzwm9/Q
X-Received: by 2002:a17:906:4788:: with SMTP id cw8mr3409646ejc.232.1640007022261;
        Mon, 20 Dec 2021 05:30:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqgMGNv50pAGIWQ9ZtUDpXvvkrP4KEhKRd2mYFwbqepWudxTftGB+6RrEd2fnS8IYSRqAsDA==
X-Received: by 2002:a17:906:4788:: with SMTP id cw8mr3409633ejc.232.1640007022076;
        Mon, 20 Dec 2021 05:30:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id di5sm5404969ejc.45.2021.12.20.05.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 05:30:21 -0800 (PST)
Message-ID: <e93265b9-7700-fa79-046d-70bb5ec990f1@redhat.com>
Date:   Mon, 20 Dec 2021 14:30:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 1/3] platform/x86: asus-wmi: Join string literals back
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>
References: <20211210163009.19894-1-andriy.shevchenko@linux.intel.com>
 <YcCALCOv46Y0TogB@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YcCALCOv46Y0TogB@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/20/21 14:07, Andy Shevchenko wrote:
> On Fri, Dec 10, 2021 at 06:30:07PM +0200, Andy Shevchenko wrote:
>> For easy grepping on debug purposes join string literals back in
>> the messages.
>>
>> No functional change.
> 
> Hans, any comments on the series?

No comments, the series looks good to me. I plan to another round of
merging pdx86 patches tomorrow and then I plan to pick these up too.

Regards,

Hans

