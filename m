Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41174877A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiAGMrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:47:07 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52848
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231891AbiAGMrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:47:06 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 871954001C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641559625;
        bh=mw0ExawwR8ahd9kK1BIGn/SS/zU5Dv8XgcJ3wXAs/II=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=U0wKWHqcpGm/m+00m1PkET9TAVO1BlVbVgB4HVn7x8iXja77UaTu6IJFhaCUkvpXh
         0QPLXd9eHk86R8sVAKvuItU+lz62HvFpBnfexDk7i3Hb6JOvfnBavQ/MDnTuHAUZ7A
         xFvRWEdvUyQueOWzdwK5HdrWgupNdraQVIQrDGS5bhXuAWsZrNhWp1HBsSW1k6EjVS
         887SaP0Ioc4C26bLHekWAN5K7vwh8u7dy6jxkcoWZOpxZPVkNaulT70DTa2fhdSsb0
         8Q4GvnrvT+FAOeSwi/NyoOy82OHnd5kTuzeijznImSqES1ztiV+QEUSQAYOt9SihXT
         e9Uz5j2P8y6zA==
Received: by mail-wm1-f71.google.com with SMTP id m19-20020a05600c3b1300b00346af84fd7dso771875wms.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 04:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mw0ExawwR8ahd9kK1BIGn/SS/zU5Dv8XgcJ3wXAs/II=;
        b=bjmLbRXiZWdWZKAAsCbFRkICgRE3/cWHJ4Lnr38r8CdKFfsMIRyIG6S3F3gYrCYRg4
         cxi1Qbm21ys2X1jk/FZQ3f0u08uexttI+N1Berv59me55zR1nI5ykxwTcPlc48ElZTDc
         4XkxttnulIHyqlEsT7bJredURyIZyavmouVFHskK92tfkfPd1NAtVzhsLLdnhqopBOxz
         kF+JiQRLgO7GOGjOecwCM5/BivD3NkFHyVtGBq61UaPjBPmh2VDr5WF+9wrbxGzgoloR
         YbdrX/wPdVAO3iZt/p5Rw1vCGdidJy0ypRPprU9AZlBphKwt2E8XeqdLYdQyA1xA/cx+
         +fHw==
X-Gm-Message-State: AOAM530zDGTINmeo3yxS6kXzoXf33MJMs81RVLyU4/jkqq+LBvtDCBx4
        gG7e3f3Sw2dyvvtSq4lbU74MJqZ+8Qp7/a3d8rzklHEPTOzqFUC1jMUwu506hGJwY4WKCmCcEHV
        UKI27996THY0s1qpdsuZn5yP0w6o7y3h53jdCR0i5Xg==
X-Received: by 2002:a1c:7908:: with SMTP id l8mr10769064wme.16.1641559624910;
        Fri, 07 Jan 2022 04:47:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2FsvDO60VgGxZNwGuql9jeQSwLbf8fwlr9vig9/8LpbnhuhXAEvvUqztMYtnXUorH1j6+bA==
X-Received: by 2002:a1c:7908:: with SMTP id l8mr10769046wme.16.1641559624685;
        Fri, 07 Jan 2022 04:47:04 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id y8sm5941569wma.19.2022.01.07.04.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 04:47:04 -0800 (PST)
Message-ID: <99115cc4-32f6-d217-68be-33256a6993a8@canonical.com>
Date:   Fri, 7 Jan 2022 13:47:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 0/7] arm/arm64: dts: Remove unused num-viewport from pcie
 node
Content-Language: en-US
To:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux@armlinux.org.uk, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, nobuhiro1.iwamatsu@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20211229160245.1338-1-jszhang@kernel.org>
 <d3cb7b8439ee3d06@bloch.sibelius.xs4all.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <d3cb7b8439ee3d06@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2021 17:50, Mark Kettenis wrote:
>> From: Jisheng Zhang <jszhang@kernel.org>
>> Date: Thu, 30 Dec 2021 00:02:38 +0800
>>
>> After commit 281f1f99cf3a("PCI: dwc: Detect number of iATU windows"),
>> the number of iATU windows is detected at runtime, what's more,
>> the 'num-viewport' property parsing has been removed, so remove the
>> unused num-viewport from pcie node(s).
>>
>> It's too late for linux-5.17-rc1, I will rebase and send out v2 if
>> necessary when 5.17-rc1 is released.
> 
> Please no.  This only makes the device trees unnecessarily
> incompatible with older kernels

Anyone who is running a new DTB with older kernel is doomed anyway, not
only because of this change but hundreds of other similar cleanups, e.g.
making DTS conforming to dtschema. Are you sure there are such use cases
of using new DTB with old kernel? I cannot imagine making a stable
product with such scenario...

> and other OSes that do rely on the
> "num-viewport" property.

Right. We should have move the DTS out of the kernel when it was still
small. :)

> It really doesn't hurt to keep this property
> even if future Linux kernels no longer look at it.

For Exynos PCIe, the property is still required by bindings, so
definitely it cannot be removed from DTS. I did not check the other
bindings.

Best regards,
Krzysztof
