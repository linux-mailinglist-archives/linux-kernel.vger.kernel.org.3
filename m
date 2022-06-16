Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B591B54E582
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiFPO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiFPO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:59:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE9A28705;
        Thu, 16 Jun 2022 07:59:15 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru [109.252.136.92])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 193A06601776;
        Thu, 16 Jun 2022 15:59:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655391553;
        bh=480bxtXiQTLxL9SJFuz2MLO035X+tYFjlvxNEbvX1vQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D1dR5eTFuepMuh2aUkqS4+tbq4xK9g2XhmVfvl08dCsjqbS1klllGMoPH56M4ThGF
         QUmRWxqt7Q32NaXKfImOc3m2WpgC32QpI9j18CdzMAwbzfLJOykTSPMuafKg1wfDTi
         oP/DO+a+qqzQ5U16dtaJ3pp31b/PjcPMz3Spu6LNF+H1UxyZU18mfvA5am8NAjZ542
         LGrpVOSinA1tZN8mm0jvNQDK0yRi9PRa5WVZqaQBrnw6DQjlERNNuzEuJXlgWOtDPE
         890Eq0OlS/b0+5VYJhEJe4LzibSR16jA26hQjWfYt/H5+2oUhNcmWRahHwJPW18VEw
         VgqU3QaAbJHfg==
Message-ID: <65fbe95b-241a-c5c5-4eca-d6932e0fd59d@collabora.com>
Date:   Thu, 16 Jun 2022 17:59:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: regression, 5.19.0-rc1 not powering off when hibernated
Content-Language: en-US
To:     Ken Moffat <zarniwhoop@ntlworld.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <YqE22nS9k2+AldI6@llamedos.localdomain>
 <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
 <YqTPlGM9KQ0FqHdc@llamedos.localdomain>
 <YqeUDpo+8RLVKH8r@llamedos.localdomain>
 <YqoLjk8P+fChJ04m@llamedos.localdomain>
 <Yqo4ZTrRZXEvxS36@llamedos.localdomain>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <Yqo4ZTrRZXEvxS36@llamedos.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/15/22 22:52, Ken Moffat wrote:
> On Wed, Jun 15, 2022 at 05:40:46PM +0100, Ken Moffat wrote:
>> On Mon, Jun 13, 2022 at 08:46:22PM +0100, Ken Moffat wrote:
>>
>>>>>> But with 5.19.0-rc1 the screen is blank throughtout the hibernation,
>>>>>> and briefly when restoring (no complaint about that), but when
>>>>>> hibernating it no longer powers off and I have to hold the on/off
>>>>>> switch to power off.
>>>>>>
>>>>>> Is this a known problem ?
>>>>>
> [...]
>> Indeed, on the second attempt I've got a much more likely commit to
>> blame:
>>
>> 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71 is the first bad commit
>> commit 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71
>> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Date:   Tue May 10 02:32:30 2022 +0300
>>
>>     ACPI: power: Switch to sys-off handler API
>>     
>>     Switch to sys-off API that replaces legacy pm_power_off callbacks,
>>     allowing us to remove global pm_* variables and support chaining of
>>     all restart and power-off modes consistently.
>>     
>>     Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Unsurprisingly, with this reverted 5.19-rc2 fails to build.
>>
> It occurs to me that maybe I'm missing something in my .config.
> Since that is 117K, here is the gzipped config from the version that
> git blamed (apart from not powering off, it appears to work ok).

The patch below likely should fix the problem, please give it a try on
top of the 5.19-rc2.

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 20a66bf9f465..89c71fce225d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -665,7 +665,7 @@ static void power_down(void)
 		hibernation_platform_enter();
 		fallthrough;
 	case HIBERNATION_SHUTDOWN:
-		if (pm_power_off)
+		if (kernel_can_power_off())
 			kernel_power_off();
 		break;
 	}
