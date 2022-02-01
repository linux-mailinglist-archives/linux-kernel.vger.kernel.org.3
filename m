Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A144A57E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiBAHhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:37:42 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55888
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234996AbiBAHhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:37:39 -0500
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A20953F33A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643701053;
        bh=RPRvR9h0sqEY3BztfrrZpWvb2ynNRmBl0rQCLPnBj/g=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Qs4BlX2kBYqjx31CFH1X4KmRI+coA0WjBwEEdfK3c2uBaHwGrYI4sYaLQxutF3j6O
         ma/J4nXuy1VYWGEvizyl6EZV0igl94+JkWxhTeyTZVTwZuXsfk5LGtIECT7OlQR1pc
         AqKZBtr/axPxulstn75nX8CgrTrR9Hl3oF7HxyiBl4kuu4rQCJRuwpTbhzhhcs8+Q6
         aeEAcwMYuROFPURJ+Zx4/G03ZoLUZ3NaKCGNvTKYnukVAQvHigPm7OwnT5D0XCvnA8
         S/HmkigJhL/a3bQG7LKu7H7vbpxMBKJ2ySMP2b7J39sj173DH15sPJ087q2LsKNYhQ
         wIphrF4nYUZzQ==
Received: by mail-ej1-f71.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso6137100ejj.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:37:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RPRvR9h0sqEY3BztfrrZpWvb2ynNRmBl0rQCLPnBj/g=;
        b=CZUJrvR+aJnPhyYCyD+56exdtqhiWLQNRvyjb/nH6kRg2suSP4Z/HhBCR8k18a38w1
         xQdbtlgPUPJM/iZyOpdmw618GzyXRon7e2M0cPSDuRMGtALIS1Vvs1DJkYibLc/maF3q
         tk57q6UF8kavSCQIViFOI6xmVbuDlSRudxRM5V2pGK6Ht7XqiXESyyGnrwuSG9huVRfe
         HfvrXCfCZv2bC+OTkbC4uqwtBhlka7dnP1TF4JILumNnE4aPJpWTzEXPEePRNiMvMzwp
         9aXrfuxtYlQJGeWFc1NZjLHqeeWu4aGc8axkpHgTsc1hwHkpj6ms5zbelsquZGIWV/Ng
         H3FQ==
X-Gm-Message-State: AOAM53375InE6EZbibsowkIpnZ0ffqCv3mMJ1E2qxSFx/5c7eBs2XOXv
        6r8jVrUnEwxZbFoZHcWHIU5glPv+TDM4IXCxwThUV7e6eXoJ5P0VLZENZkSptrHnhA9m+tbCKLt
        6Q1H0zdGlfW7Ukklg9Fcp08/Re9lsN8HhLh2nS9Ybcw==
X-Received: by 2002:a17:906:1e14:: with SMTP id g20mr18883237ejj.251.1643701053287;
        Mon, 31 Jan 2022 23:37:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdBOrUNwjS7G2zy8TMHS3gDIoDuZnHB5qetY+xmbLyj+/+QOcDDs71Opq3V/kdsUTieqf06w==
X-Received: by 2002:a17:906:1e14:: with SMTP id g20mr18883221ejj.251.1643701053098;
        Mon, 31 Jan 2022 23:37:33 -0800 (PST)
Received: from [192.168.0.74] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h7sm14184838ejk.69.2022.01.31.23.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 23:37:32 -0800 (PST)
Message-ID: <0b771c5a-1fe0-0fa8-a635-18e0417c7e65@canonical.com>
Date:   Tue, 1 Feb 2022 08:37:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Adding architectural support for HPE's GXP BMC. This is
 the first of a series of patches to support HPE's BMC with Linux Kernel.
Content-Language: en-US
To:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <nick.hawkins@hpe.com>
 <20220125194609.32314-1-nick.hawkins@hpe.com>
 <CAK8P3a0ccoH_sNE9eWxQnWHEWNBPFL6k4k6mku=cHs_fRfnL-w@mail.gmail.com>
 <CA8148A1-578E-4621-9714-45AB391C353A@hpe.com>
 <2f4dd91a-e4ad-2559-f65e-914561de4047@canonical.com>
 <015EB9CD-ADB9-4C12-BD3F-78268E849884@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <015EB9CD-ADB9-4C12-BD3F-78268E849884@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2022 19:52, Verdun, Jean-Marie wrote:
> Hi Krzysztof
> 
> We made some progress during the week-end and took the decision to breakdown the dts as you recommended (one dtsi for the SoC, and one dts per system board, we will start with the dl360 Gen10 server). We will send you some updates during the week, as I need to validate a few things with some of my colleagues regarding the partition tables definition which we kept (for the moment) into the ASIC definition, as all our implementation are using currently the same partition table.
> 
> We also removed many of the warning generated by the dtc compiler.
> 
> We will probably send the driver code at the same time than the dts update (or the next day). There will be a few of them including
> 
> - gpio
> - hwmon
> - udc / usb gadget
> - umac
> - i2c
> - watchdog
> - fbdev
> - kcs
> - vuart
> - spifi
> - clock
> 
> So as to simplify your understanding
> 
> - GXP is the name of the SoC. It has multiple implementations, which are currently compatibles. I don't think for the moment that we need to distinguished them. We might have a GXP v2 coming up but not before a certain amount of time which is far enough.
> - This SoC is used to implement BMC features of HPE servers (all ProLiant, many Apollo, and Superdome machines)
> 
> It does support many features including:
> - ARMv7 architecture, and it is based on a Cortex A9 core
> - Use an AXI bus to which 
> 	- a memory controller is attached, as well as multiple SPI interfaces to connect boot flash, and ROM flash, a 10/100/1000 Mac engine which supports SGMII (2 ports) and RMII
> 	- Multiple I2C engines to drive connectivity with a host infrastructure
> 	- A video engine which support VGA and DP, as well as an hardware video encder
> 	- Multiple PCIe ports
> 		- A PECI interface, and LPC eSPI
> 	- Multiple UART for debug purpose, and Virtual UART for host connectivity
> 	- A GPIO engine
> 
> Hope this help,
> 

Thanks, this helps, but it should be in the cover letter of the pathshet
plus some parts of it (subtract) in commit adding the new SoC support.


Best regards,
Krzysztof
