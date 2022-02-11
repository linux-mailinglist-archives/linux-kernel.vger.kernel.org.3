Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF74B2EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353351AbiBKUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:49:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352252AbiBKUtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:49:09 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07063CFD;
        Fri, 11 Feb 2022 12:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6fNwGptWAccaPA+3rpFHDZ0IemC3Vppb+fXZ7fXi+PU=; b=cLQOOYgFu0UVKZSfvnvJWIBDKx
        BSNHvPFBrDewixb42dc68+D97DYF+4dGQDZoCEU2HU/+TCbGS3hJ4Hvh3x1WeH2u0l1aHTlOtlfOI
        XaRi3MQ5Oo7zAVkAOP5GZ76NlXwNEjW5lOHtG90gAUkdMDMovgH/z4NDjnJ43Cjxb9No=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55278 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIcql-00067M-Mr; Fri, 11 Feb 2022 15:49:04 -0500
Date:   Fri, 11 Feb 2022 15:49:03 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20220211154903.c3ff6e38058508116e637411@hugovil.com>
In-Reply-To: <20220211203520.3902374-1-hugo@hugovil.com>
References: <20220211203520.3902374-1-hugo@hugovil.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH 00/14] rtc: pcf2127: add PCF2131 driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 15:35:06 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series adds the driver for the PCF2131 real-time clock.

Hi,
sorry, I forgot to add the V2 prefix to all the patches in this serie. Please ignore them, I will resend them with the proper [PATCH v2...] prefix.

Hugo.


> This RTC is very similar in functionality to the PCF2127/29 with the
> following differences:
>   -supports two new control registers at offsets 4 and 5
>   -supports a new reset register
>   -supports 4 tamper detection functions instead of 1
>   -has no nvmem (like the PCF2129)
>   -has two output interrupt pins instead of one
>   -has 1/100th seconds capabilities (not supported in this driver)
>   -pcf2127 has watchdog clock sources: 1/60,   1, 64 and 4096Hz
>    pcf2131 has watchdog clock sources: 1/64, 1/4,  4 and   64Hz
>   -watchdog value register cannot be read after being set
> 
> Most of the register addresses are very different, although they still
> follow the same layout. For example, the time/date and tamper registers
> have a different base address, but the offsets are all the same.
> Consequently, the source code of the PCF2127 driver can be easily adapted
> to support this new device.
> 
> This patch series need the following patch to be applied first:
> [PATCH] rtc: pcf2127: fix bug when reading alarm registers
> Link: https://patchwork.ozlabs.org/project/rtc-linux/patch/20220208162908.3182581-1-hugo@hugovil.com/
> 
> Patches 1 to 6 modify the existing pcf2127 driver to make it more generic
> and able to support multiple variants, like the PCF2131. This is done
> mostly by using offsets instead of absolute hardcoded register addresses.
> 
> Patch 7 add actual support for the PCF2131.
> 
> Patch 8 configures all interrupt sources to go through the INT A pin.
> 
> Patch 9 changes the PWRMNG bits to be the same with the PCF2131 as they
>       are with the PCF2127/29 (different default values).
> 
> Patch 10 allow to confirm PCF2131 device presence by reading the reset
>       register fixed pattern.
> 
> Patch 11 adapt the time/date registers write sequence for PCF2131 (STOP and
>       CPR bits).
> 
> Patch 12 add support for generic watchdog timing configuration.
> 
> Patch 13 add a new flag to identify if device has read support for reading
>       watchdog register value.
>       Since the watchdog value register cannot be read on the PCF2131 after
>       being set, it seems that we cannot detect if watchdog timer was
>       started by bootloader. I am not sure what is the best way to handle
>       this situation, suggestions are welcomed.
> 
> Patch 14 add the dt-bindings for the PCF2131.
> 
> I have tested the driver using a PCF2131-ARD evaluation board connected to
> an NXP imx8mp evaluation board:
>   - Time get/set ok;
>   - Alarms get/set ok
>   - Timestamp 1 to 4 ok
>   - IRQ alarm ok
>   - Watchdog ok
>   - Also tested successfully with "RTC Driver Test Example" from
>     Documentation/rtc.txt
> 
> I have not tested the driver on PCF2127 or PCF2129 hardware as I do not
> have either one of these devices. However, I compared the registers
> read/write access addresses and values before and after modifying the
> driver by simulating I2C read and writes for some operations (probe, read
> time), and they are the same (apart from new read/writes for all variants).
> 
> Thank you.
> 
> Link: [v1] https://patchwork.ozlabs.org/project/rtc-linux/patch/20220125200009.900660-2-hugo@hugovil.com/
> 
> Changes for V2:
> - Add cover letter (in V1, was mailed only to my email address, and not
>   to RTC mailing list and maintainers)
> - In general, fix and improvements after I have tested on real hardware
> - Fix alarm interrupt A/B mask setting for PCF2131:
>   PCF2131_BIT_INT_AIE must be cleared, not set, to enable interrupt.
> - Remove low_reg validation: only check if TS interrupt flag is
>   defined, as low_reg is defined at address 0 for PCF2127/29.
> - Change PWRMNG value for PCF2131: default is different than PCF2127/29.
> - Adapt time/date registers write sequence for PCF2131 (STOP and CPR bits).
> - Map all interrupt sources to INT A pin
> - Read and validate PCF2131 device presence from RESET register
> - Adapt watchdog configuration for PCF2131
> 
> Hugo Villeneuve (14):
>   rtc: pcf2127: add variant-specific configuration structure
>   rtc: pcf2127: adapt for time/date registers at any offset
>   rtc: pcf2127: adapt for alarm registers at any offset
>   rtc: pcf2127: adapt for WD registers at any offset
>   rtc: pcf2127: adapt for CLKOUT register at any offset
>   rtc: pcf2127: add support for multiple TS functions
>   rtc: pcf2127: add support for PCF2131 RTC
>   rtc: pcf2127: add support for PCF2131 interrupts on output INT_A
>   rtc: pcf2127: set PWRMNG value for PCF2131
>   rtc: pcf2127: read and validate PCF2131 device signature
>   rtc: pcf2127: adapt time/date registers write sequence for PCF2131
>   rtc: pcf2127: support generic watchdog timing configuration
>   rtc: pcf2127: add flag for watchdog register value read support
>   dt-bindings: rtc: pcf2127: add PCF2131
> 
>  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  |  19 +-
>  drivers/rtc/Kconfig                           |   4 +-
>  drivers/rtc/rtc-pcf2127.c                     | 940 ++++++++++++++----
>  3 files changed, 769 insertions(+), 194 deletions(-)
> 
> -- 
> 2.30.2
> 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
