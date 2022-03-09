Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEA64D2DC8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiCILRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiCILRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:17:18 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E38C13CEF8;
        Wed,  9 Mar 2022 03:16:17 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id A5184180;
        Wed,  9 Mar 2022 03:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1646824576;
        bh=2rBQwW6XLcpw4ODkOdsflYm4tk7ggmr+Vf8x3pA/P28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLXlT0JXfyWFQWXjSjTrNjnb29G/Q0bzDRzgGUzkFG8fwIOUlus/wLRqWAI+uJdOn
         2AvhQ/s+b2Y9gNX0k+8to702LN4j+F7fk3iNjElxL7zRaKoEh7PKKZGXzYT06rrSvb
         yrUsGapPgahYv00aTjW6hAVlTb+GfvukwVztwMd8=
Date:   Wed, 9 Mar 2022 03:16:12 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Rob Herring <robh+dt@kernel.org>,
        Renze Nicolai <renze@rnplus.nl>
Subject: Re: [PATCH v2 0/6] hwmon: (nct6775) Convert to regmap, add i2c
 support
Message-ID: <YiiMfJV3bjUmoUcV@hatter.bewilderbeest.net>
References: <20220309005047.5107-1-zev@bewilderbeest.net>
 <05667284-42f7-0df2-8fa0-463ad6ad9601@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05667284-42f7-0df2-8fa0-463ad6ad9601@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:12:32AM PST, Paul Menzel wrote:
>Dear Zev,
>
>
>Am 09.03.22 um 01:50 schrieb Zev Weiss:
>
>>This is v2 of my patches to add i2c support to the nct6775 driver.
>>
>>Changes since v1 [0]:
>>  - Added preparatory patch converting driver to regmap API [Guenter]
>>  - Replaced ENOSPC with ENOBUFS and removed WARN_ON() in
>>    nct6775_add_attr_group() [Guenter]
>>  - Added dedicated symbol namespace [Guenter]
>>  - Removed nct6775_write_temp() and nct6775_update_device() symbol
>>    exports [Guenter]
>>  - Reordered patches to put dt-bindings patch first [Krzysztof]
>>
>>The nct6775-platform and nct6775-i2c drivers have both been tested on
>>the NCT6779D in an ASRock ROMED8HM3 system and the NCT6798 [1] in an
>>ASRock X570-D4U (the latter thanks to Renze, CCed); both seem to work
>>as expected on both systems.  I don't have access to any asuswmi
>>hardware, so testing of the nct6775-platform driver on that to ensure
>>it doesn't break there would be appreciated (Oleksandr, perhaps?).
>
>I have an ASUS F2A85-M PRO with that Super I/O. (It’s running coreboot 
>right now, but I can test with the proprietary vendor firmware, if you 
>tell me what and how I can test this.
>

Hi Paul,

Thanks for offering to test!  I don't see the F2A85-M PRO listed in the 
asus_wmi_boards array, so (unless there's some alternate model name it 
also goes by that's in that list) I don't think it will provide coverage 
for the asuswmi code, but additional testing of the platform driver 
would still be good anyway.

To try it out, first apply the patch series on top of Guenter's current 
hwmon-next tree (it's based on commit 5d4a2ea96b79).  You'll need to 
enable both the existing CONFIG_SENSORS_NCT6775 Kconfig option as well 
as the new CONFIG_SENSORS_NCT6775_PLATFORM.  Then compile, install, and 
boot into the resulting kernel.  If you set 
CONFIG_SENSORS_NCT6775_PLATFORM=m (compiling it as a module) you'll need 
to run 'modprobe nct6775-platform' to load the module, after which 
running 'sensors' from the lm-sensors package should show sensor 
readings from it -- if things are working right, it should behave pretty 
much exactly as the driver did prior to these patches.

However, since posting the v2 patch series I realized I bungled 
something in the regmap conversion (patch 2 of the series), so before 
compiling you should also apply this small fixup (which will be included 
in subsequent versions of the patchset):

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index cb3958c977fa..5801aa9d60ee 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1150,7 +1150,7 @@ static int nct6775_write_fan_div(struct nct6775_data *data, int nr)
  	if (err)
  		return err;
  	reg &= 0x70 >> oddshift;
-	reg |= data->fan_div[nr] & (0x7 << oddshift);
+	reg |= (data->fan_div[nr] & 0x7) << oddshift;
  	return nct6775_write_value(data, fandiv_reg, reg);
  }
  


Thanks,
Zev

