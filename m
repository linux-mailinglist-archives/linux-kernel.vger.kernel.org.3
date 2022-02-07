Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF074AC99C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiBGTdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbiBGTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:31:16 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454BC0401E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:31:15 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 30676 invoked from network); 7 Feb 2022 20:31:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1644262271; bh=NcB9gVIjMBjGgdZ9AjtkcBv3gMoo7EkfWZ8DssZzUZc=;
          h=Subject:To:Cc:From;
          b=gVZCqvKDnZVfPgusVMyDK+QwLyDaymw9BcNNOa6OTYRNXvtiuDu6jCuH58VoEv1M3
           tk8R0vinsLujdFXbUywNyiivhhmoiMhV4j2SXQipxq3wZaly+OkEGvJcxvXuMaqEIq
           yKhkD0CmidAj351JzJWsqN/ni+FrWH28+Hcqg8fQ=
Received: from aaem217.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.116.217])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <hdegoede@redhat.com>; 7 Feb 2022 20:31:11 +0100
Message-ID: <b0642e67-7752-8d27-9e67-7e9a493adb08@o2.pl>
Date:   Mon, 7 Feb 2022 20:31:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] x86/Kconfig: move and modify CONFIG_I8K
Content-Language: en-GB
To:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <markgross@kernel.org>
References: <20220207182940.242838-1-mat.jonczyk@o2.pl>
 <43bfd6d9-58a3-6f9c-0848-4ef147552afb@redhat.com>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
In-Reply-To: <43bfd6d9-58a3-6f9c-0848-4ef147552afb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 39cfd62f4e752cf0cc3fb42c12cb8ded
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [UUNE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 07.02.2022 o 19:51, Hans de Goede pisze:
> Hi,
>
> On 2/7/22 19:29, Mateusz Jończyk wrote:
>> In Kconfig, inside the "Processor type and features" menu, there is
>> the CONFIG_I8K option: "Dell i8k legacy laptop support". This is
>> very confusing - enabling CONFIG_I8K is not required for the kernel to
>> support old Dell laptops. This option is specific to the dell-smm-hwmon
>> driver, which mostly exports some hardware monitoring information and
>> allows the user to change fan speed.
>>
>> This option is misplaced, so move CONFIG_I8K to drivers/hwmon/Kconfig,
>> where it belongs.
>>
>> Also, modify the dependency order - change
>>         select SENSORS_DELL_SMM
>> to
>>         depends on SENSORS_DELL_SMM
>> as it is just a configuration option of dell-smm-hwmon. This includes
>> changing the option type from tristate to bool. It was tristate because
>> it could select CONFIG_SENSORS_DELL_SMM=m .
>>
>> When running "make oldconfig" on configurations with
>> CONFIG_SENSORS_DELL_SMM enabled , this change will result in an
>> additional question (which could be printed several times during
>> bisecting). I think that tidying up the configuration is worth it,
>> though.
>>
>> Next patch tweaks the description of CONFIG_I8K.
>>
>> [snip]
> For other reviewers, the only consumer of the CONFIG_I8K
> option is drivers/hwmon/dell-smm-hwmon.c
> which has a couple of:
> "#if IS_ENABLED(CONFIG_I8K)" checks to enable its old
> legacy /proc/i8k interface.
>
> So this move definitely makes sense.
>
> I wonder if it would not be better to just completely drop
> the old  /proc/i8k interface though ?

No!!! I use it. The problem is that the laptop (2010-ish Dell Latitude E6500)
has only three fan power levels: off, mild and full. So I think it is
not well-suited to traditional fancontrol. On the other hand,
i8kmon (slightly modified), which is designed for a small number of fan power levels,
works well.

> With that said, this series looks good to me, so:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> for the series.

Thanks,

Mateusz

> Regards,
>
> Hans
>
>

