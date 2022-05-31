Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DBA5389DF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbiEaCOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiEaCOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:14:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37BE77F22;
        Mon, 30 May 2022 19:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MCE74GR5cd4AP/uMh3B09r7w3iqnVZmjXLrGDc0ll4E=; b=Sp8gIrzZmwjlDwR5gLvzxZlTob
        3lUWElXFB0MMLAjtHo29QD2GCLRRwCdl40feohIHVpqAzHw55Car5/w/8M8myyGDnOu/0tPhIKafr
        LaM26tWBClui7FElSgXvJXAWHOMY2j99Nkfo7OvaL/EPBKk+Ae9aHG4irS4Xh8P11o/ZTR0PvZlIS
        qeIDZOaKwogWNJXWBLOzB8Jfasoj5siKHrCpxTCEUmnK0hM1fcR1M7ElGdev7Ur34ytz5MPozWF3Q
        yHwlZnY9JxNSR9Gad/8mD20qOcH4PQLW4Zj8Q7JFaZA8jWWuxz/t+iehITJIlfud8+Ym5mtV7a0AX
        iPQ/N86w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvrOx-003F1K-W7; Tue, 31 May 2022 02:14:32 +0000
Message-ID: <d2db660d-edaf-c5a0-8c27-ac27f6232fed@infradead.org>
Date:   Mon, 30 May 2022 19:14:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 2/6] drivers/input/joystick: sensehat: Raspberry Pi
 Sense HAT joystick driver
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        linux-input@vger.kernel.org, Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20220419205158.28088-1-cmirabil@redhat.com>
 <20220419205158.28088-3-cmirabil@redhat.com>
 <ecb3f627-3379-1b18-02c0-44782a2623d4@infradead.org>
 <YpV2GNAJQhag9Osu@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YpV2GNAJQhag9Osu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 18:57, Dmitry Torokhov wrote:
> Hi Randy,
> 
> On Mon, May 30, 2022 at 06:26:26PM -0700, Randy Dunlap wrote:
>> Hi--
>>
>> On 4/19/22 13:51, Charles Mirabile wrote:
>>> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
>>> index 3b23078bc7b5..505a032e2786 100644
>>> --- a/drivers/input/joystick/Kconfig
>>> +++ b/drivers/input/joystick/Kconfig
>>> @@ -399,4 +399,15 @@ config JOYSTICK_N64
>>>  	  Say Y here if you want enable support for the four
>>>  	  built-in controller ports on the Nintendo 64 console.
>>>  
>>> +config JOYSTICK_SENSEHAT
>>> +	tristate "Raspberry Pi Sense HAT joystick"
>>> +	depends on INPUT && I2C
>>> +	select MFD_SIMPLE_MFD_I2C
>>
>> Looks like this also needs
>> 	depends on HAS_IOMEM
>>
>> since everything in drivers/mfd/Kconfig depends on HAS_IOMEM and
>> since this 'select' causes a kconfig warning when HAS_IOMEM is not set:
>>
>> WARNING: unmet direct dependencies detected for MFD_SIMPLE_MFD_I2C
>>   Depends on [n]: HAS_IOMEM [=n] && I2C [=y]
>>   Selected by [y]:
>>   - JOYSTICK_SENSEHAT [=y] && INPUT_JOYSTICK [=y] && INPUT [=y] && I2C [=y]
> 
> Do you mind sending a patch?

OK, will do.

-- 
~Randy
