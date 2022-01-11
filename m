Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A24648AE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiAKNRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:17:15 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39578
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240386AbiAKNRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:17:13 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1026A4005A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641907026;
        bh=p6mppyZ+nRVFw8Ydj5pTS6ZQVVKxfU2Ane2whCQ9DMU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=lCodXJHxFJkZIlCnOoFDD5342RYz7I9V7gXJ/kIcPssWu+mbs7Wu+DS4/saaRXL/0
         LQHBIG6eDMQ9HtQGVIUWaJGgDTC5XOcSDD/F2NGw77ZGZ+m2jrgsthf6tMbsQ4V3Gm
         8XA/cD/P7pfaTcyhEFozqHNwdfUuOjk4/unWOIhecwQY6bob9xlN17FpJ4wzRQnLq1
         RKWseH7+2AX5cbA0jHeqU1Th2cTF2IIwmHxF6MRMbHuzrigH+B9CjIAbIrWVGsxwVl
         6T/KTkimIKgFjFPWmDZo9r2Bwo+MC7gZ5Y7h5D6Du5Nv04oMp5JgWSz6oAdpZXuKuP
         9D4scD6hiu7SA==
Received: by mail-ed1-f71.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so13298779edc.18
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p6mppyZ+nRVFw8Ydj5pTS6ZQVVKxfU2Ane2whCQ9DMU=;
        b=mHqQg5c9StmGzzgfLeeZbKvavCr9U0ZTXWyqTaaouSyeNLXQSDXVVwIjyt1rbMfGlC
         oRXtd2bYpc7h/KyJse/+Sr/yBeyW4qoU451mJ63kRhkM4jK7ly5uRrTenTu7mf05kQ3q
         wqcogB37NQ/EWeJIZx6JIFiR1pnk/oqI0kuHqEmgC4udmmBFZEVXLchibwE9fl9xddC+
         0ubCoBv0IeUWYXNK4fHkQjjgBQKHYm3BUgohdtgrIBGKrstGECP7TFNlF7neWCLH1RTW
         y7kQrQQ3nZ3NuBDwYMgL8z6KSpJWdrgTT0KI++0ZiF7CDH9UW1Wd+DjFxCwWaZJgQ9fv
         JGUw==
X-Gm-Message-State: AOAM532B/HkU5GnqJ+Q7s3KoEbWNPEJA5wuyTlFtmd02jYnXVKcTAup/
        dYoUc3fRd4w6h/XUy35bGWcO+3C2T0SHedD2Ivraljsi6FuX3PJs3ph1ZPow7MPGl0/Jc9gVj6g
        yCq6SRJT6bl9nfBfXeHJM3AMqr+cHdBF6/zr8OTpn+w==
X-Received: by 2002:a17:906:5585:: with SMTP id y5mr3527893ejp.390.1641907025588;
        Tue, 11 Jan 2022 05:17:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+hoh2eS7S/sjXNLrekdX1PFgLfFM4Sh6dBUJxEf+onVQQ6I/vLIGR/vQV6TQ+Cwo9R5kTzA==
X-Received: by 2002:a17:906:5585:: with SMTP id y5mr3527880ejp.390.1641907025464;
        Tue, 11 Jan 2022 05:17:05 -0800 (PST)
Received: from [192.168.0.10] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id kw14sm3574187ejc.68.2022.01.11.05.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 05:17:05 -0800 (PST)
Message-ID: <07cd9a2a-9491-0eb0-1f00-7319f58a508a@canonical.com>
Date:   Tue, 11 Jan 2022 14:17:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Exynos850 and ExynosAuto v9 pinctrl wakeup muxed interrupt
Content-Language: en-US
To:     Chanho Park <chanho61.park@samsung.com>,
        'Sam Protsenko' <semen.protsenko@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
        'Sylwester Nawrocki' <s.nawrocki@samsung.com>,
        'Tomasz Figa' <tomasz.figa@gmail.com>
References: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
 <CAPLW+4nrPKA66GrF4XukyHWHJ=wBycjyK3ZPLCofEFe-VJ9wWg@mail.gmail.com>
 <CGME20220107081617epcas2p402a132bdffaf1ec6f5517c311a60c7d3@epcas2p4.samsung.com>
 <06320ea8-9297-1e90-dafd-978f73c22fff@canonical.com>
 <000a01d805f7$591355d0$0b3a0170$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <000a01d805f7$591355d0$0b3a0170$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2022 08:54, Chanho Park wrote:
>>
>> The error message is valid - correctly points to wrong configuration.
>> All pinctrl nodes should have one interrupt, if they have GPIOs capable of
>> interrupt as a function (usually 0xf as GPIO CON register). Why
>> pinctrl_aud does not have it? Maybe the function EXT_INT (0xf) is not
>> available for its pins?
> 
> Regarding pinctrl_aud, the interrupt number is not defined in interrupt source table because the line is not connected to CPU's GIC. It is directed to the GIC of dedicated audio subsystem which name is ABOX. So, we cannot handle the interrupt of pinctrl_aud even though GPBx_CON registers have EXT_INT(0xf) setting.

Thanks for checking. I will need to include this in the dtschema.


Best regards,
Krzysztof
