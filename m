Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC584C6168
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiB1Cst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiB1Csr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:48:47 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C831A826;
        Sun, 27 Feb 2022 18:48:08 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 7B336516;
        Sun, 27 Feb 2022 18:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1646016488;
        bh=/iervmZzRL0Mt5kpC3j8ZiRbpDgGTMM0VaPpylf5tJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJjeBa0PqiIPgHj9xQr4Sl7aIEu8ufRb7o8PjRh9Zgo3XBWsk2SDHUB0UarokWdO1
         dO0u2xCPJ76B3QJc8ropLkDBqt/9Xvkq98/Mr+tB5BgfydrmeQpumdUkI/RiTtiIxL
         fkelbIxetoTFB86c5AF1TbWuRHDbIFJT3lHBXcRE=
Date:   Sun, 27 Feb 2022 18:48:05 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Renze Nicolai <renze@rnplus.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] hwmon: (nct6775) Add i2c support
Message-ID: <Yhw35Wq5r5KiNWyM@hatter.bewilderbeest.net>
References: <20220226133047.6226-1-zev@bewilderbeest.net>
 <2620147.mvXUDI8C0e@natalenko.name>
 <YhrFizhgOpZbi3dE@hatter.bewilderbeest.net>
 <4719747.31r3eYUQgx@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4719747.31r3eYUQgx@natalenko.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 01:38:31PM PST, Oleksandr Natalenko wrote:
>Hello.
>
>On neděle 27. února 2022 1:27:55 CET Zev Weiss wrote:
>> On Sat, Feb 26, 2022 at 04:14:12PM PST, Oleksandr Natalenko wrote:
>> >Hello.
>> >
>> >On sobota 26. února 2022 14:30:42 CET Zev Weiss wrote:
>> >> Hello,
>> >>
>> >> This patch series augments the existing nct6775 driver with support
>> >> for the hardware's i2c interface.
>> >
>> >Is it something I can test on my ASUS Pro WS X570-ACE board as an ordinary user, and if so, how?
>> >
>>
>> You could certainly test that the nct6775-platform driver still works as
>> it did previously, which would be good to confirm -- you'll need to
>> enable CONFIG_SENSORS_NCT6775_PLATFORM now to build it.
>
>Ack.
>
>>  From what I've been able to find about that board though it looks like
>> it doesn't have a BMC, so testing the i2c driver on it probably isn't
>> going to be possible.  (Even if it does in fact have a BMC, it would
>> require at least a partial port of OpenBMC or similar, and re-flashing
>> your BMC firmware with that, and is hence a non-trivial undertaking.)
>
>It should have, the BMC is based on RTL8117, although I have no idea if it is something that can be called true IPMI as I've never enabled/used it.
>

Ah, interesting -- I hadn't heard of that chip before, and web searches 
mostly seem to turn up discussions of that particular board (and sibling 
models), so I guess it's probably not very widely used elsewhere.  It 
does appear to run an OpenWRT-based firmware with source available 
(https://gitlab.com/gplmirror/rtl8117), though apparently with a rather 
old (4.4) kernel (and with added fun goodies like what looks to be a 
partial implementation of an in-kernel VNC server??).

So I guess in theory if you were feeling adventurous and wanted to 
backport these patches to that kernel, recompile the firmware, and flash 
the result onto your hardware you could *maybe* test out the i2c driver, 
though it's probably a much deeper rabbit hole than is likely to be 
worthwhile, and with significant risk of leaving your hardware in an 
awkward (potentially bricked) state if things go awry, so it's not 
something I'd recommend taking on casually.  There would also still be 
the process of figuring out at what i2c bus/address the Super-I/O chip 
lives for the rtl8117, if its i2c interface is even attached at all, 
which I don't think is guaranteed -- the rtl8117 might not need it if 
it's not in charge of thermal monitoring/fan control on that board, and 
even if it is handling that it might have a direct connection to the TSI 
interface instead of going through the Super-I/O chip as is done on the 
ASRock boards I'm familiar with.


Zev

