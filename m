Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A734B3E91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbiBNAPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:15:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiBNAPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:15:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354251E6B;
        Sun, 13 Feb 2022 16:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Z0izQ77ae4vChC3LwyWqgLvukFSg3zMmsdvzhzmiFoA=; b=G4PjChidQJRQi2NVbEZyyeTMh0
        X3UnnyyM3mGdXXgMo0LWl183MPMT8g3EXPa3KE0DjsPHnONFIk222ugmAT5hhJDMvFz8UICd6/ZDx
        iqv0fCaOtwmv7OM4QCJ+Nxg+mBTEtuYgxHzuLl6im3XTnRr8LfuVEASoC7gSty9nGAlSyUgnfcBqv
        VCQsfW6XkWeUqKEtOWVULZ3ofuIbx2tQ4WoQKEGa06pbwQBg5uoGB8t3rWQ6zX6GPRxXuhWobPNaU
        lqs+zlhZL9P+P+hpMmwyPjmD8WO0JsFOjY++AHcqKPu6E5Ux0aDg2ZiwkXS7DJwwWT5j64DiASMin
        A+ji6evw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJP1g-00CNcF-C5; Mon, 14 Feb 2022 00:15:32 +0000
Message-ID: <0ffc9f5f-546a-a797-01bf-d62953e6d26c@infradead.org>
Date:   Sun, 13 Feb 2022 16:15:27 -0800
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1e43c3b9-c5b7-de77-dd28-981d60a4d97d@gmx.de>
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

Hi,

On 2/13/22 14:15, Helge Deller wrote:
> On 2/13/22 22:07, Randy Dunlap wrote:
>>
>>
>> On 2/13/22 12:35, Helge Deller wrote:
>>> Hi Randy,
>>>
>>> On 2/13/22 20:39, Randy Dunlap wrote:
>>>> There is a build error when using a kernel .config file from
>>>> 'kernel test robot' for a different build problem:
>>>>
>>>> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC3':
>>>> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>>>>
>>>> when:
>>>>   CONFIG_GSC=y
>>>>   CONFIG_SERIO_GSCPS2=y
>>>>   CONFIG_SERIAL_8250_GSC=y
>>>>   CONFIG_PCI is not set
>>>>     and hence PCI_LBA is not set.
>>>>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>>>>
>>>> Making SERIAL_8250_GSC depend on PCI_LBA prevents the build error.
>>>
>>> It maybe makes the build error go away, but ...
>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>>>> Cc: Helge Deller <deller@gmx.de>
>>>> Cc: linux-parisc@vger.kernel.org
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: linux-serial@vger.kernel.org
>>>> Cc: Jiri Slaby <jirislaby@kernel.org>
>>>> Cc: Johan Hovold <johan@kernel.org>
>>>> ---
>>>>  drivers/tty/serial/8250/Kconfig |    2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> --- linux-next-20220211.orig/drivers/tty/serial/8250/Kconfig
>>>> +++ linux-next-20220211/drivers/tty/serial/8250/Kconfig
>>>> @@ -118,7 +118,7 @@ config SERIAL_8250_CONSOLE
>>>>
>>>>  config SERIAL_8250_GSC
>>>>  	tristate
>>>> -	depends on SERIAL_8250 && GSC
>>>> +	depends on SERIAL_8250 && GSC && PCI_LBA
>>>>  	default SERIAL_8250
>>>
>>> The serial device is on the GSC bus, so if you make it
>>> dependend on the PCI bus it will not be useable on machines
>>> which only have a GSC bus...
>>>
>>> We need another patch.
>>> Do you have a link to the build error?
>>
>>
>> No, it's from the other build error that you just replied to,
>> where the incorrect compiler was used.
>>
>> I'll recheck it and reconsider what to do, if anything.
> 
> Ok, thank you!

I dunno what to do. This:

#ifdef CONFIG_64BIT
	if (!dev->irq && (dev->id.sversion == 0xad))
		dev->irq = iosapic_serial_irq(dev);
#endif

makes it look like 64BIT requires IOSAPIC (hence PCI_LBA).


> By the way, I just sent another patch (and added it to the parisc for-next tree)
> which should at least give a better error message if someone uses the wrong compiler:
> https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?h=for-next&id=b160628e9ebcdc85d0db9d7f423c26b3c7c179d0

Yes, I applied that, but that's not the problem here.
It is a 64BIT config and parisc64 compiler.

-- 
~Randy
