Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF64B3DF5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 23:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbiBMWPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 17:15:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiBMWPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 17:15:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767BF541A5;
        Sun, 13 Feb 2022 14:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644790512;
        bh=/GuRz1vrm15+tEX8Jbv2LcM92USmJGaAMmozHmwYR98=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LyBWlw2UP7pxemCAbIaRF+07BSsYThs13dE+csFKaPE1m7tR1uDvN3fRZKBQ2c/0+
         JclyjxK7T87eNNvnLrZkd1yyTbiGOHIrEIr4rcD/867u8OVWWiMekeM2mXlbalc4iH
         dISJfabPiepGZ143AZh7STlwFwmvpsETJCntFlXg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.238]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1oD9h70hXp-00yzer; Sun, 13
 Feb 2022 23:15:12 +0100
Message-ID: <1e43c3b9-c5b7-de77-dd28-981d60a4d97d@gmx.de>
Date:   Sun, 13 Feb 2022 23:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] serial: parisc: GSC: fix build when PCI_LBA is not set
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>
References: <20220213193903.8815-1-rdunlap@infradead.org>
 <0baabcbc-196e-08fa-e2db-b7e925993cc1@gmx.de>
 <55c73cb4-21ae-7307-7b14-a19cf270f4d6@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <55c73cb4-21ae-7307-7b14-a19cf270f4d6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gJ0P9y8TH5sSIgBh0gzgU8cCS3hLcXKc+yGMGLvVPHvsnbLMWiP
 2Aew9G+LMzKAcxZ8M7Xnx7Z1gfLj14eQz0ruBbDk0ioUizl/iltCOk3Yj1pTDw6+BmqwCNV
 RndElaC86aqJVyE+0TwlyCYG8kl2IsO5O810v47lNE1ZQ0jUWKjz7gG9KZJErkcUr5pI8Zy
 sCGZvlBUDOVzg9p3I+RZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5CCV3+Y39Fo=:iIDunnDRSK2/K78Y4sQHwC
 j799Dv518khpBHCl0cwgg43WMKdgpBxo/lm2dz+OoP+8y+iEPhdsWI+Hji2OOI+4s60X4e3/j
 0FTum8GnR/sHBOfZ2Wr775KiPE/NdibqvhA0KQ9+ZolTztXrwgzLhvqfkfKkmF/o41Ot/FRkD
 w3/QpXZC1bM8FbiHM9eKYE4aoC2ZObTH8FR2cYlMNfzvrCBOkwm+dFXeJUafj8ACLCuza/yQY
 hz3UVdwMaVKC88KmPijcZEOdyrkSmIkNpNIMbLfssGoZ6ajuPCO6L8Mhkcq9+SNghmWlWdhrJ
 XSPI5w33uMLMN1KOQLvZSLPy7oospUVAYCau6bP7xCgzLpeEOaJonzimCP7eTImHWp9LROMGg
 FpXZKObytyMzsr1mQM5FB4U5ykM4O9j69T9N0WFqrb7LcOkb6lwlZeihXDZV5BfU0plT0ivWt
 itLKO1vIHbU9AYcKSNrwCFO4x9mkIWmfnnCjbo8Lde6T48vxFrb3cWtMRIdjljv0cDNma7ilr
 6m9Vq+S+jGS3FDDudxNbCGnSSP0ItPD473tqd9U7h/AzjeRdXowAFRafaX9EJ/csuTajQ1fIh
 U43TiG24TGYPS0ZGtZz08I4ngenCUS4VYN/zhGaGDcKbhQLHHTl61dyqo9kKeecBPhIL5uAWl
 o8oGkmiAAp2zLeZXkogUbfQkTXL4zU1sDTeFVVCrl4hHqIL1ccKnCvZUlVCttLHXhT1dKOmiC
 I1ZS5eUHI8lixMn7FU3h0ktHQ17uF3ElHRVZenrlR0/UaSzeZ6iBrUAVX5er1fHcKAQ709QBG
 7jR2gl58I1uXhs9+uhjnf5TryHJ1W7TiJj8nSjOv8SgC5hOgjo491BamiNBOFZbIEsVrbbCRK
 kAWWc4s3n4axST8leYqQZ+F+gcZJGH6b3Ynb6kVwHo/4nAt0gE8/pw+AT1MUzWXyyYtQKcE6p
 Faw3pkR8xMXCtiZaf4gLjkZ0Ns9wdL1xIKjLueDxHc77HjC/t8lhC0jbgfdSQmM30g8U0oViD
 sW0oMIfMMi4hjHithfjfeC7xMkzu1bHAFHHZwxOEolP/0HFo/oZo32VdOd7ldOTah47ypdme4
 Z9dRZiNrmBwKvk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/22 22:07, Randy Dunlap wrote:
>
>
> On 2/13/22 12:35, Helge Deller wrote:
>> Hi Randy,
>>
>> On 2/13/22 20:39, Randy Dunlap wrote:
>>> There is a build error when using a kernel .config file from
>>> 'kernel test robot' for a different build problem:
>>>
>>> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC3=
':
>>> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>>>
>>> when:
>>>   CONFIG_GSC=3Dy
>>>   CONFIG_SERIO_GSCPS2=3Dy
>>>   CONFIG_SERIAL_8250_GSC=3Dy
>>>   CONFIG_PCI is not set
>>>     and hence PCI_LBA is not set.
>>>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>>>
>>> Making SERIAL_8250_GSC depend on PCI_LBA prevents the build error.
>>
>> It maybe makes the build error go away, but ...
>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>>> Cc: Helge Deller <deller@gmx.de>
>>> Cc: linux-parisc@vger.kernel.org
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: linux-serial@vger.kernel.org
>>> Cc: Jiri Slaby <jirislaby@kernel.org>
>>> Cc: Johan Hovold <johan@kernel.org>
>>> ---
>>>  drivers/tty/serial/8250/Kconfig |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> --- linux-next-20220211.orig/drivers/tty/serial/8250/Kconfig
>>> +++ linux-next-20220211/drivers/tty/serial/8250/Kconfig
>>> @@ -118,7 +118,7 @@ config SERIAL_8250_CONSOLE
>>>
>>>  config SERIAL_8250_GSC
>>>  	tristate
>>> -	depends on SERIAL_8250 && GSC
>>> +	depends on SERIAL_8250 && GSC && PCI_LBA
>>>  	default SERIAL_8250
>>
>> The serial device is on the GSC bus, so if you make it
>> dependend on the PCI bus it will not be useable on machines
>> which only have a GSC bus...
>>
>> We need another patch.
>> Do you have a link to the build error?
>
>
> No, it's from the other build error that you just replied to,
> where the incorrect compiler was used.
>
> I'll recheck it and reconsider what to do, if anything.

Ok, thank you!

By the way, I just sent another patch (and added it to the parisc for-next=
 tree)
which should at least give a better error message if someone uses the wron=
g compiler:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3Db160628e9ebcdc85d0db9d7f423c26b3c7c179d0

Helge
