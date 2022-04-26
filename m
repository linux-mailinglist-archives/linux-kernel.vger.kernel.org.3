Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE3510938
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354251AbiDZTl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354165AbiDZTlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:41:25 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1918FAD83;
        Tue, 26 Apr 2022 12:38:16 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 587D21BA;
        Tue, 26 Apr 2022 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651001896;
        bh=0/xW5YXm98VDV8HncQuBWEbdx7lEyK7iJy3W3BVLhnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMHQf6pNKw2cRdvulbPi/kjrFzyVJRiY9ldKlILkY+jbUo0IVMzDKoYhm5cNEyZMS
         PlTMstxErCIk4VDgdyCKeAe5xstMJbUyUgBrwBrd6W/EdOh0L1NxNtHcrMg7+KPRc1
         2bqnLSxDzQP0usxOicxJLZ4leieK73Kkw8ELCQtU=
Date:   Tue, 26 Apr 2022 12:38:12 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, webmaster@kernel.org
Subject: Re: [PATCH v3 0/6] hwmon: (nct6775) Convert to regmap, add i2c
 support
Message-ID: <YmhKJMebdVAzIGd8@hatter.bewilderbeest.net>
References: <20220426071848.11619-1-zev@bewilderbeest.net>
 <YmetYjSKFs+WWwYz@hatter.bewilderbeest.net>
 <dd522f49-89b6-14b2-c402-9cfc93b51d4b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd522f49-89b6-14b2-c402-9cfc93b51d4b@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 01:57:40AM PDT, Guenter Roeck wrote:
>On 4/26/22 01:29, Zev Weiss wrote:
>>[Adding korg webmaster re: list infrastructure]
>>
>>On Tue, Apr 26, 2022 at 12:18:42AM PDT, Zev Weiss wrote:
>>>Hello,
>>>
>>>This is v3 of my effort to add i2c support to the nct6775 hwmon
>>>driver.
>>>
>>>Changes since v2 [0]:
>>>...
>>>- Renamed drivers and Kconfig symbols to keep existing platform
>>>  driver as "nct6775" (SENSORS_NCT6775) and the core module as
>>>  "nct6775-core" (SENSORS_NCT6775_CORE) [Guenter]
>>
>>Unfortunately while this was a simple enough change to make (a few 'git mv' commands and a handful of actual text changes), it ballooned the size of the diff for patch 5 to the point that vger bounced it for exceeding the 100K message-size limit.  As far as I can tell it looks like it went through elsewhere, but does leave a bit of a gap in the public list archives -- please let me know if there's anything I should try in terms of re-sending it.  (The only combination of 'git format-patch' flags I've been able to find that gets it back down to approximately its previous size is '-B -D', which isn't so useful for actually applying.)
>>
>>I'm not sure how critical a limit that 100K is, or if it's something we might consider raising a bit?
>>
>
>You could split it up further. For example, you could introduce
>the include file first. Also, please run checkpatch --strict on
>your patches. I don't care about commenting the mutex, but there
>should be no double empty lines. Also, while you are at it,
>it would be great if you can add another patch to fix the
>
>WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using octal permissions '0644'.
>
>warnings.

Ack -- hadn't been aware of the --strict flag for checkpatch, thanks.  
I'll do that in v4.

>
>Anyway, I wondered what changed... oh, I see. You didn't rename
>nct6775.c. I didn't suggest that. The new file name was fine.
>I only asked you to change the Kconfig symbols, not the file names.
>It is ok and actually desirable to change the file names.
>The platform driver module can and should still be named nct6775;
>that can be handled in the Makefile with something like
>
>nct6775-objs := nct6775-platform.o
>obj-$(CONFIG_SENSORS_NCT6775)  += nct6775.o
>

Got it, will revert to the previous file names, which should sidestep 
the message-size problem.


Thanks,
Zev

