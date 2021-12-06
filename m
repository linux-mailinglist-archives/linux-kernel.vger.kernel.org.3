Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07C546A3F1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346816AbhLFS1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:27:20 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39506
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345780AbhLFS1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:27:19 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 90AC53F1B6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638815026;
        bh=m+Y+zzpIB5GIy+YUjbHo+5oo+uTb5hKaf1A0Q7oyy+s=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
         In-Reply-To:Content-Type;
        b=PdbKZg3FnucDabPOIEUCAXgRJMO5aLObkHd6jQIagFMjBN2uhNpZgEjeYDUVbCYIW
         /2ZBlPWDsibhjv9cLZEX6fvr4TBRgVSgO1oIVja5dxKvy6fovKQAD+wyqj2+qJZ8op
         iy5sIZHi3gr+XiQHXM4yMAYiy+i1iFeZ4vEcqSN8r+5o99y0gyR5xM5SS1+j5tWUeR
         Q7krGj2okn161XWXtl4rBCjrLd1U+ec9hn7wmJcGXvX9kOCfm55ay6TTpNqobjTHL7
         sxZxaIhUIB9+jMtuQ3yyKggrS0aIUCBg+zmjjFfnf0dPBGJgH3ACRCmL5s3ptV33UN
         tnsCVM+b2CpBw==
Received: by mail-lj1-f197.google.com with SMTP id s16-20020a2ea710000000b0021b674e9347so3751823lje.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=m+Y+zzpIB5GIy+YUjbHo+5oo+uTb5hKaf1A0Q7oyy+s=;
        b=VAwcLd7/t31Q4ziJu2laWaw+pmgtYKsOz4UPFirp1oeFt3eIFbb2Iz+WRBJhwJoGqm
         nTRMQP4N4IFBWRcjyka8GRSvR3Kf16WotB8FgIFHWVDF+KmiVYGKJ3fsOFms3shsnV0k
         usNhmGrGJIDoOH6S319EVW/SSGiFndXyMTmc/R1yrkUGnxNGPu3kAd1V9u6GOH9OTDLK
         s4pHUh+iCX2eHFPqzuT+CrL54mi7ba6KTCNFzLpeG2ZkpnpdftPjTAhYsx/BhGOsRPgu
         DJe6eD+TrxQfOtNKsrQBVt0RrcRfUInIbfWxujUfW2gPUlSrL47gykMHGCTQhhQyyJ/O
         TCWw==
X-Gm-Message-State: AOAM532c/kVt7LDjcPAsZrmUBwDOUfH9HzuHFX6x7MyGFk5ekdlUB9wn
        zo1VyP3OOZzf3VizIatdHLthRyQ+1CbNlNJ69UyvUS87cviaumdhNuvklUHJSXaoBPrxfLfU0UA
        +dkSyvcmznGoQ2r+G0YSD2HwjDmlTLx4LjjxOarOLFA==
X-Received: by 2002:a05:6512:4017:: with SMTP id br23mr36582977lfb.270.1638815025837;
        Mon, 06 Dec 2021 10:23:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsda21I2pfpKdjSZzpnnNHKn2hzGNbL7KfVX1haF180FhDWe9RMB4LGNKD3NaXvvmyV+VvtA==
X-Received: by 2002:a05:6512:4017:: with SMTP id br23mr36582939lfb.270.1638815025529;
        Mon, 06 Dec 2021 10:23:45 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b12sm1422783lfv.91.2021.12.06.10.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 10:23:44 -0800 (PST)
Message-ID: <14731ee8-bc9a-8973-2bcf-e7a771ac3c07@canonical.com>
Date:   Mon, 6 Dec 2021 19:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 0/5] soc: samsung: Add USI driver
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20211204195757.8600-1-semen.protsenko@linaro.org>
 <fb31a159-6d2e-6c9a-439f-f19ef4fd4732@canonical.com>
In-Reply-To: <fb31a159-6d2e-6c9a-439f-f19ef4fd4732@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2021 17:24, Krzysztof Kozlowski wrote:
> On 04/12/2021 20:57, Sam Protsenko wrote:
>> USIv2 IP-core provides selectable serial protocol (UART, SPI or
>> High-Speed I2C); only one can be chosen at a time. This series
>> implements USIv2 driver, which allows one to select particular USI
>> function in device tree, and also performs USI block initialization.
>>
>> With that driver implemented, it's not needed to do USI initialization
>> in protocol drivers anymore, so that code is removed from the serial
>> driver.
>>
>> Because USI driver is tristate (can be built as a module), serial driver
>> was reworked so it's possible to use its console part as a module too.
>> This way we can load serial driver module from user space and still have
>> serial console functional.
>>
>> Design features:
>>   - "reg" property contains USI registers start address (0xc0 offset);
>>     it's used in the driver to access USI_CON and USI_OPTION registers.
>>     This way all USI initialization (reset, HWACG, etc) can be done in
>>     USIv2 driver separately, rather than duplicating that code over
>>     UART/SPI/I2C drivers
>>   - System Register (system controller node) and its SW_CONF register
>>     offset are provided in "samsung,sysreg" property; it's used to
>>     select USI function (protocol to be used)
>>   - USI function is specified in "samsung,mode" property; integer value
>>     is used to simplify parsing
>>   - there is "samsung,clkreq-on" bool property, which makes driver
>>     disable HWACG control (needed for UART to work properly)
>>   - PCLK and IPCLK clocks are both provided to USI node; apparently both
>>     need to be enabled to access USI registers
>>   - protocol nodes are embedded (as a child nodes) in USI node; it
>>     allows correct init order, and reflects HW properly
>>   - USI driver is a tristate: can be also useful from Android GKI
>>     requirements point of view
>>   - driver functions are implemented with further development in mind:
>>     - we might want to add some DebugFs interface later
>>     - some functions might need to be revealed to serial drivers with
>>       EXPORT_SYMBOL(), and provide somehow pointer to needed USI driver
>>       instance
>>     - another USI revisions could be added (like USIv1)
>>
>> Changes in v3:
>>   - Renamed compatible from samsung,exynos-usi-v2 to samsung,exynos850-usi
>>   - Used clk_bulk API instead of handling each clock separately
>>   - Spell check fixes and coding style fixes
>>   - Improved dt-bindings doc
>>
>> Changes in v2:
>>   - Renamed all 'usi_v2' wording to just 'usi' everywhere
>>   - Removed patches adding dependency on EXYNOS_USI for UART/I2C/SPI
>>     drivers
>>   - Added patch: "tty: serial: samsung: Fix console registration from
>>     module"
>>   - Combined dt-bindings doc and dt-bindings header patches
>>   - Reworked USI driver to be ready for USIv1 addition
>>   - Improved dt-bindings
>>   - Added USI_V2_NONE mode value
>>
>> Sam Protsenko (5):
>>   dt-bindings: soc: samsung: Add Exynos USI bindings
>>   soc: samsung: Add USI driver
>>   tty: serial: samsung: Remove USI initialization
>>   tty: serial: samsung: Enable console as module
>>   tty: serial: samsung: Fix console registration from module
>>
> 
> All this looks good to me. The serial driver changes should come
> together with this one (usi driver is now a dependency for them). If I
> am correct, mention this please in future cover letter (if there is such).
> 
> I will still need DTSI changes for Exynos Auto v9 and confirmation that
> is not being used downstream and breaking DTB ABI is okay. Because this
> will be a non-bisctable and also a DTB ABI break.

+CC Arnd and Olof,

Dear Arnd and Olof,

The patchset discussed here reworks recently added USI code to Samsung
Exynos UART driver in a non-bisectable and ABI-breaking way. The
existing code in serial driver was added in v5.15-rc1, however first
user - Exyons Auto v9 - appeared in v5.16-rc1.

The bisectability and ABI break will affect only newly upstreamed
Samsung Exynos SoC, so for now only Exynos Auto v9.

The early code has some drawbacks and limitations which came up now when
we want to extend the USI code to support more blocks (I2C, SPI) and
devices (including older Exynos chipsets). Therefore I am planning to
make an ABI break of this features because:
1. The code was added recently (v5.15-rc1) and users even later (v5.16-rc1).
2. Even though code was merged, I consider it still development phase.
Kernel development goes very fast and we do not defer patches waiting
for perfect solution.
3. There are no known out-of-tree users of this because this is fairly
new. For this I am waiting for confirmation from Chanho (and/or other
Samsung folks). I don't expect there are out of tree users because any
mobile or automotive product will take Samsung vendor sources and recent
kernels are not a base for Samsung vendor kernels.
4. Keeping it backwards compatible will be a pain.

The alternative is to keep old code in Samsung Serial driver and try to
detect the case when driver is probed in old way (with old DTB). This
won't be trivial, because there will be no properties change, but
devicetree hierarchy change like:

from:
soc@0 {
  serial@0xabcd0123 {
    ...
  }
}

into:
soc@0 {
  usi@0x12345678 {
    serial@0xabcd0123 {
      ...
    }
  }
}


Are you okay with such planned ABI break?

Best regards,
Krzysztof
