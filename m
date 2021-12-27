Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD14047FC66
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhL0MCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhL0MCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:02:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160C3C061401
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 04:02:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t18so31879830wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 04:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=xkc8SKUPYzJLLeRWgMJMh/IdK4g8gIh52fq2aT0Flxo=;
        b=oub0ntE58NXbt0tUZ2DHgu52WmkJ96Px7RyPUiH/Q45xLY2pW6tqCIrZOujPWVEzip
         fmZ8HNj4/G9CwhZm64IyN/9lOnt7u4Wn+nKhXvT0c/6TewDOwDV38imcK3WJCCn4YLD3
         EdWbW2Bu3oAXUq4gNLAEiy7K7SC1Xma3Vd6h7SKl5GhLpwiCRQETLHE+djyrpmNtHzGG
         zOBzfZhd8a7t3ukuk8WbAyTuv+b/MtiDXCXSxnWcOno87kAko0jEM74W7lkWPLPgcZ0v
         1L95fmZQsBt5tQTjK99nRjr5wApbKevpvSRTcGjtefn3S0gJeq3RE/mMaYfdj6W0EVg5
         Gqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=xkc8SKUPYzJLLeRWgMJMh/IdK4g8gIh52fq2aT0Flxo=;
        b=pimINnrvDwZcoxOHJuxwy2RavkmNFJPBAoCNKBN8L+Bk4lFXR8UPMZxpkvlZV1wDD1
         gT+q7CbppjjeA1bVGrXCJc34wRgcptn8+41ZZqC2KJrkz2V2LREACM/JfWcPke/9wc5o
         DT0FYC0SYWSTkyt+hnccBtmobX8TLy3JInQ0Mx8PFVHTseQ0yeFnEBjVB9WkNMGpnm46
         JbEWo/2qWreaO3w2Ml9iTppUJAFiPixoQak2/eKzy4zdvWxtXRPbFHl0JULi5DXXIrfX
         zz9G8nDhcZtRXG4DQdsunsD6FJU/4kZhKgBhjKgtCDwWfdP1uZrR72bUmKA/3ZbFLtrp
         7CRQ==
X-Gm-Message-State: AOAM533H9Y4Xa2tbDqDU335UXCIT0CBQHPrAp5IW85mMpQxg0j+fqz4y
        rzqNzy9g4qvC5Viaz7ILr6lQBw==
X-Google-Smtp-Source: ABdhPJyK3jVzmRJ1bHzkXpI+GlgYyNXvk0veyzs681rdxTKfvgfVYTo9TD5WLJ8FwhhUNcM2Rcq/FA==
X-Received: by 2002:a5d:5262:: with SMTP id l2mr12549749wrc.141.1640606523406;
        Mon, 27 Dec 2021 04:02:03 -0800 (PST)
Received: from localhost ([2a04:cec0:10c6:6fed:3056:9d74:5100:5bd5])
        by smtp.gmail.com with ESMTPSA id v1sm17460961wru.45.2021.12.27.04.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 04:02:03 -0800 (PST)
References: <20211221071634.25980-1-yu.tu@amlogic.com>
 <20211221071634.25980-4-yu.tu@amlogic.com>
 <CAFBinCB9Fre9Lea2CAm_8o8g1e3o8oX4ZONbN_bhykNXoFHDdQ@mail.gmail.com>
 <e041c9ed-ff42-a7e7-2fc5-03c96cc69a88@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 3/3] tty: serial: meson: add UART driver compatible with
 S4 SoC on-chip
Date:   Mon, 27 Dec 2021 12:58:34 +0100
In-reply-to: <e041c9ed-ff42-a7e7-2fc5-03c96cc69a88@amlogic.com>
Message-ID: <1jzgomz26b.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 27 Dec 2021 at 14:56, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Martin,
> 	Thank you very much for your reply.
>
> On 2021/12/25 1:25, Martin Blumenstingl wrote:
>> [ EXTERNAL EMAIL ]
>> Hello,
>> On Tue, Dec 21, 2021 at 8:17 AM Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>> The S4 SoC on-chip UART uses a 12M clock as the clock source for
>>> calculating the baud rate of the UART. But previously, chips used 24M or
>>> other clock sources. So add this change. The specific clock source is
>>> determined by chip design.
>> Does the new S4 SoC use an external 12MHz XTAL or does it use a 24MHz XTAL?
>> If there's still a 24MHz XTAL then I think this description is not
>> correct - at least based on how I understand the UART controller.
>> 
> The S4 SoC uses 12MHz(UART_EE_A_REG5[27]=0x1,the bit is set in
> romcode). This register description is the same as the G12A and G12B you
> know.
>
>> SoCs up to GXL and GXM had an internal divide-by-3 (clock divider) in
>> the UART controller IP and an external 24MHz XTAL.
>> This was not configurable, so the clock for all baud-rates had to be
>> derived from an 8MHz (24MHz divided by 3) clock.
>> With the A311D (G12B, which is still using an external 24MHz XTAL) SoC
>> the UART controller gained two new bits - with configurable dividers -
>> according to the public datasheets:
>> UART_EE_A_REG5[26]:
>> - 0x0: divide the input clock by 3 (meaning: this internally works
>> with an 8MHz clock)
>> - 0x1: use the input clock directly without further division (meaning:
>> this internally work with an 24MHz clock)
>> UART_EE_A_REG5[27]:
>> - 0x0: use the clock as configured in UART_EE_A_REG5[26]
>> - 0x1: divide the input clock by 2 (meaning: this internally works
>> with an 12MHz clock)
>> While writing this email I did some investigation and found that
>> UART_EE_A_REG5[26] is used in the vendor kernel even for GXL and GXM
>> SoCs.
>> So this probably has been introduced with the GXL generation (and thus
>> is missing on GXBB and earlier SoCs).
>> Also UART_EE_A_REG5[27] seems to have been introduced with the G12A
>> generation of SoCs (not surprising since G12A and G12B peripherals are
>> very similar).
>> Does the UART controller not work with divide-by-3 (as we have it
>> today) or are these configurable dividers to reduce jitter?
>> 
> The UART controller can work with divide-by-3.
> The chip history as you described above, the current reason for using 12MHz
> clock is really what you call reduce jitter. The UART mainly connects to
> Bluetooth and uses typical baud rates of 2Mhz, 3MHz and 4MHz, so 12MHz is
> used as the clock source.

Looks to me that the clock divider above should be modelled properly
with CCF. If you wish the initial Romcode setting to remain untouched,
then don't put CLK_SET_RATE_PARENT to stop rate propagation.

CCF will figure out what the internal rate is. You don't need to device
tree data if things are done properly

>> Best regards,
>> Martin
>> 

