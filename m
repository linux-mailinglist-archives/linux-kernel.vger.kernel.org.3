Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580AD4B5913
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356518AbiBNRsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:48:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiBNRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:48:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8265513D24;
        Mon, 14 Feb 2022 09:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jf26SR0VOk2Ttx4bLUgslnrc0FG1tgPsF93W1r8Fc3g=; b=K/N2UQO5molLQ1PtwJu4bqdv4o
        9UTyh9eK6Q8XZpBGqa7moqNNS6aHZnDEvlikUY2ao3blfvJbxAv0SbBHRMBtz1NSiM8J2uIPvcV1s
        ZjGU5dxiKBdguPvrZWHaWkORdPW5vPss7hMOymxMJIlPLjdNboW1lre7TfNRzR9q5lNpfNNysqZEa
        gAeI2uok73jm2eWuS64GGB01vUPzsvCHCrMqb/gojDAUTvEzU09q2iMGAWn4aonc29fg3o3laj/wU
        R1DITYgLffCgCec8O2+SaAJCZsCq8Abe3++WfGgRLjFf4CVyCX57rJbt1wXOI2R/BCHBFGa0ih6zk
        X3+5ei2w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJfS7-009xdB-KQ; Mon, 14 Feb 2022 17:47:55 +0000
Message-ID: <e99b77aa-7742-08f5-8acc-3ff381d1b17f@infradead.org>
Date:   Mon, 14 Feb 2022 09:47:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] serial: parisc: GSC: fix build when PCI_LBA is not set
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20220213193903.8815-1-rdunlap@infradead.org>
 <0baabcbc-196e-08fa-e2db-b7e925993cc1@gmx.de>
 <55c73cb4-21ae-7307-7b14-a19cf270f4d6@infradead.org>
 <1e43c3b9-c5b7-de77-dd28-981d60a4d97d@gmx.de>
 <0ffc9f5f-546a-a797-01bf-d62953e6d26c@infradead.org>
 <e8781486-b3ce-b2dd-2c84-f0b2a651556f@gmx.de>
 <4c716eda-a081-2ae3-9358-a5e35bd4d951@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4c716eda-a081-2ae3-9358-a5e35bd4d951@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On 2/14/22 04:24, Helge Deller wrote:
> On 2/14/22 13:05, Helge Deller wrote:
>> On 2/14/22 01:15, Randy Dunlap wrote:
>>> Hi,
>>>
>>> On 2/13/22 14:15, Helge Deller wrote:
>>>> On 2/13/22 22:07, Randy Dunlap wrote:
>>>>>
>>>>>
>>>>> On 2/13/22 12:35, Helge Deller wrote:
>>>>>> Hi Randy,
>>>>>>
>>>>>> On 2/13/22 20:39, Randy Dunlap wrote:
>>>>>>> There is a build error when using a kernel .config file from
>>>>>>> 'kernel test robot' for a different build problem:
>>>>>>>
>>>>>>> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC3':
>>>>>>> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>>>>>>>
>>>>>>> when:
>>>>>>>   CONFIG_GSC=y
>>>>>>>   CONFIG_SERIO_GSCPS2=y
>>>>>>>   CONFIG_SERIAL_8250_GSC=y
>>>>>>>   CONFIG_PCI is not set
>>>>>>>     and hence PCI_LBA is not set.
>>>>>>>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>>>>>>>
>>>>>>> Making SERIAL_8250_GSC depend on PCI_LBA prevents the build error.
>>>>>>
>>>>>> It maybe makes the build error go away, but ...
>>>>>>
>>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>>>>>>> Cc: Helge Deller <deller@gmx.de>
>>>>>>> Cc: linux-parisc@vger.kernel.org
>>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>> Cc: linux-serial@vger.kernel.org
>>>>>>> Cc: Jiri Slaby <jirislaby@kernel.org>
>>>>>>> Cc: Johan Hovold <johan@kernel.org>
>>>>>>> ---
>>>>>>>  drivers/tty/serial/8250/Kconfig |    2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> --- linux-next-20220211.orig/drivers/tty/serial/8250/Kconfig
>>>>>>> +++ linux-next-20220211/drivers/tty/serial/8250/Kconfig
>>>>>>> @@ -118,7 +118,7 @@ config SERIAL_8250_CONSOLE
>>>>>>>
>>>>>>>  config SERIAL_8250_GSC
>>>>>>>  	tristate
>>>>>>> -	depends on SERIAL_8250 && GSC
>>>>>>> +	depends on SERIAL_8250 && GSC && PCI_LBA
>>>>>>>  	default SERIAL_8250
>>>>>>
>>>>>> The serial device is on the GSC bus, so if you make it
>>>>>> dependend on the PCI bus it will not be useable on machines
>>>>>> which only have a GSC bus...
>>>>>>
>>>>>> We need another patch.
>>>>>> Do you have a link to the build error?
>>>>>
>>>>>
>>>>> No, it's from the other build error that you just replied to,
>>>>> where the incorrect compiler was used.
>>>>>
>>>>> I'll recheck it and reconsider what to do, if anything.
>>>>
>>>> Ok, thank you!
>>>
>>> I dunno what to do. This:
>>>
>>> #ifdef CONFIG_64BIT
>>> 	if (!dev->irq && (dev->id.sversion == 0xad))
>>> 		dev->irq = iosapic_serial_irq(dev);
>>> #endif
>>>
>>> makes it look like 64BIT requires IOSAPIC (hence PCI_LBA).
>>
>> Although I think all 64bit machines have a PCI bus, the better
>> fix is that the driver should only call iosapic_serial_irq(dev)
>> if CONFIG_IOSAPIC is set. This patch fixes the build:
>>
>> -#ifdef CONFIG_64BIT
>> +#ifdef CONFIG_IOSAPIC
>>         if (!dev->irq && (dev->id.sversion == 0xad))
>>                 dev->irq = iosapic_serial_irq(dev);
>>  #endif
> 
> That was not fully correct.
> It needs to be:
> 
> #if defined(CONFIG_64BIT) && defined(CONFIG_IOSAPIC)
> 
> Otherwise you'll get an undefined reference in the 32-bit build.

Sure, I can send such a patch.
I would have used a bigger hammer and done something like

	depends on IOSAPIC if 64BIT


Just for info, how would dev->irq be set for CONFIG_64BIT
when CONFIG_IOSAPIC is not set?


thanks.
-- 
~Randy
