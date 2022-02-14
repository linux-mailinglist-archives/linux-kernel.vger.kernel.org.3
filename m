Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2A4B59E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiBNS37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:29:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245266AbiBNS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:29:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B460DAC;
        Mon, 14 Feb 2022 10:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644863369;
        bh=2Oe69+MHLDiamZ+2fbh46K9b90yf+diNILJSlNDYeaU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=khqmvqAbKBT8ECK7rw/9I9bQUZbjco785NF2BcXsgrtORRzd5Q2DM/cRCpoNgEQM6
         cyLuRIE2gMg5Da9AIR+0gjjMDUjH9y82YXSyzJPBl6z3OqW3gB3A2mdRvPCzTMWi+s
         yeUbf08VDppmDWsYS1VM4pR6x4R0ksIvq8X5YumQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1nJx5E1jUH-000JLM; Mon, 14
 Feb 2022 19:29:29 +0100
Message-ID: <e9b503e0-19b9-68a4-1edc-646abc279b5a@gmx.de>
Date:   Mon, 14 Feb 2022 19:29:21 +0100
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
 <1e43c3b9-c5b7-de77-dd28-981d60a4d97d@gmx.de>
 <0ffc9f5f-546a-a797-01bf-d62953e6d26c@infradead.org>
 <e8781486-b3ce-b2dd-2c84-f0b2a651556f@gmx.de>
 <4c716eda-a081-2ae3-9358-a5e35bd4d951@gmx.de>
 <e99b77aa-7742-08f5-8acc-3ff381d1b17f@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <e99b77aa-7742-08f5-8acc-3ff381d1b17f@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hg9cH3SBBQvG6gSf4Z11oAIl6AEzxHxwieXB1WHx2fLJ6DE6/KA
 c6xAHmtwjyj7at3FeY0gumrvPaQ7gnLX9LBl1RazAZInYO6J1ue0sdPKjFhrE/QGkSLhGcH
 /IY135g8qUUY/1vqQEQiR+LcbvU0u0YKb0T0khLuv4EW358KAnFYuNr8WPTaIU8GGgCLJEp
 ZLXOLNlIz4mKMjYwJofag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aJdZRDr7mcA=:lqv8Hd7u8/6loRdWh3yOv9
 pEGZCmyqqA590VYCRbtqIcvsvudHh9YJJgemiRNCtLhL96f+BEN+9fVzYqSdcSJQPs74zj4iV
 XFIQUMxdqAwx6VjEnIej0+QT4BNtJsbFfGJa0o4V9PvOtLk07Op8kE2I/wtEfkXu4Zgddje4B
 eeiS5T9iuvh9I07YfWQbyqLiwKwkIV99+bCjCIOz0S68Rr1fqVqk6wRr5Ea4x/dFHiFqPqJdc
 1H8HnaCy+kZaJbRlTnIqXUst1ziGWSDhqgOBPe6UR70iws+P4u0RuyLHhNpxU6b5wvrQSAtZF
 6/Y7UTnIwrf/pVltsq732NlxWAvWeGpbszEE8jy0ouYw3K1c4M4GAC0/12l+kiZoLn+p/9ukl
 3A6kq9XQqfNe+W8ZaLMyYdsGZYgRuflg9q6kZ8rpeJhBP+WMwo9dRdQIqH0J8qD5OZWrl0FfT
 k3Ud0U6Os71T9kJVBwg1BaigT783jBY61NsKYrOBeYyoHm41DFVRg6Yv44YfYTYrLsDqLJ90H
 oldBRpN2rNGkNoSYbd2hol0iz8YsCNH6Dn4RdRoMDZ3G1foGSvTIvfSAiCq3PQ2R72f7R1hr5
 NcldKAa1Je465lYwCKcWHdZ9LPo6AvSROjpBJpSQVESLYq1BONf8/KDiwmXXA0/DUusKUxjwW
 wHaqsPCEEdmXJiFY9zFUbVaVCPoNGwp0rZROLCNFbChArlvEj3vudS2HMb22jiHKna8+7MgO2
 RWAlI3IRKngF+Ay/EE2ymzOpXm+ZkhCpCLN5tIjujrk19/vTFObN+zOlmKrO5JDe2y/kO9rMP
 q4MiX3A4NaeMFD/qJ3pVxD2J6wjwXs/WHdXXOMMoH5gfBfv5Ciqra7J4dba3zYzxUFwFvGKhf
 CRIq7t2UVfAUuLYzxvH91cisClspZH1r3DXgN0cHA2HZVsR+F3jmNbSAZdT90cAaUSWDE65Qg
 i+Oomk2BsTtUPBQuZIB1730cuXe0eLvWVnlMksz5UYMEqnXcovZDIu2LkMiDbZ4QAHuL1OWVG
 xwadyVsE6nEd2jDFjFU8SEPUvPY9v7jlPcC9AIrqcmw9yUn1ws0nA4vy2XT9sX46NVQmC2ilA
 Fv1b0ZmJ+g5f00=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 18:47, Randy Dunlap wrote:
> Hi Helge,
>
> On 2/14/22 04:24, Helge Deller wrote:
>> On 2/14/22 13:05, Helge Deller wrote:
>>> On 2/14/22 01:15, Randy Dunlap wrote:
>>>> Hi,
>>>>
>>>> On 2/13/22 14:15, Helge Deller wrote:
>>>>> On 2/13/22 22:07, Randy Dunlap wrote:
>>>>>>
>>>>>>
>>>>>> On 2/13/22 12:35, Helge Deller wrote:
>>>>>>> Hi Randy,
>>>>>>>
>>>>>>> On 2/13/22 20:39, Randy Dunlap wrote:
>>>>>>>> There is a build error when using a kernel .config file from
>>>>>>>> 'kernel test robot' for a different build problem:
>>>>>>>>
>>>>>>>> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function =
`.LC3':
>>>>>>>> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>>>>>>>>
>>>>>>>> when:
>>>>>>>>   CONFIG_GSC=3Dy
>>>>>>>>   CONFIG_SERIO_GSCPS2=3Dy
>>>>>>>>   CONFIG_SERIAL_8250_GSC=3Dy
>>>>>>>>   CONFIG_PCI is not set
>>>>>>>>     and hence PCI_LBA is not set.
>>>>>>>>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>>>>>>>>
>>>>>>>> Making SERIAL_8250_GSC depend on PCI_LBA prevents the build error=
.
>>>>>>>
>>>>>>> It maybe makes the build error go away, but ...
>>>>>>>
>>>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com=
>
>>>>>>>> Cc: Helge Deller <deller@gmx.de>
>>>>>>>> Cc: linux-parisc@vger.kernel.org
>>>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>>>> Cc: linux-serial@vger.kernel.org
>>>>>>>> Cc: Jiri Slaby <jirislaby@kernel.org>
>>>>>>>> Cc: Johan Hovold <johan@kernel.org>
>>>>>>>> ---
>>>>>>>>  drivers/tty/serial/8250/Kconfig |    2 +-
>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> --- linux-next-20220211.orig/drivers/tty/serial/8250/Kconfig
>>>>>>>> +++ linux-next-20220211/drivers/tty/serial/8250/Kconfig
>>>>>>>> @@ -118,7 +118,7 @@ config SERIAL_8250_CONSOLE
>>>>>>>>
>>>>>>>>  config SERIAL_8250_GSC
>>>>>>>>  	tristate
>>>>>>>> -	depends on SERIAL_8250 && GSC
>>>>>>>> +	depends on SERIAL_8250 && GSC && PCI_LBA
>>>>>>>>  	default SERIAL_8250
>>>>>>>
>>>>>>> The serial device is on the GSC bus, so if you make it
>>>>>>> dependend on the PCI bus it will not be useable on machines
>>>>>>> which only have a GSC bus...
>>>>>>>
>>>>>>> We need another patch.
>>>>>>> Do you have a link to the build error?
>>>>>>
>>>>>>
>>>>>> No, it's from the other build error that you just replied to,
>>>>>> where the incorrect compiler was used.
>>>>>>
>>>>>> I'll recheck it and reconsider what to do, if anything.
>>>>>
>>>>> Ok, thank you!
>>>>
>>>> I dunno what to do. This:
>>>>
>>>> #ifdef CONFIG_64BIT
>>>> 	if (!dev->irq && (dev->id.sversion =3D=3D 0xad))
>>>> 		dev->irq =3D iosapic_serial_irq(dev);
>>>> #endif
>>>>
>>>> makes it look like 64BIT requires IOSAPIC (hence PCI_LBA).
>>>
>>> Although I think all 64bit machines have a PCI bus, the better
>>> fix is that the driver should only call iosapic_serial_irq(dev)
>>> if CONFIG_IOSAPIC is set. This patch fixes the build:
>>>
>>> -#ifdef CONFIG_64BIT
>>> +#ifdef CONFIG_IOSAPIC
>>>         if (!dev->irq && (dev->id.sversion =3D=3D 0xad))
>>>                 dev->irq =3D iosapic_serial_irq(dev);
>>>  #endif
>>
>> That was not fully correct.
>> It needs to be:
>>
>> #if defined(CONFIG_64BIT) && defined(CONFIG_IOSAPIC)
>>
>> Otherwise you'll get an undefined reference in the 32-bit build.
>
> Sure, I can send such a patch.

Thanks!
I see you sent it in a seperate mail.
I can take it through the parisc tree.

> I would have used a bigger hammer and done something like
>
> 	depends on IOSAPIC if 64BIT
>
> Just for info, how would dev->irq be set for CONFIG_64BIT
> when CONFIG_IOSAPIC is not set?

All found devices in the parisc system are in a device table.
The serial driver scans those against the ones listed in
serial_tbl[] and lasi_tbl[], and hand over the parisc_device
pointer which usually has the irq set.
In case the device is connected via iosapic and hasn't an irq
already set, iosapic_serial_irq() is called to find the irq.
The
 	depends on IOSAPIC if 64BIT
would have dropped *all* serial ports on 64bit kernels, even
those which are on the GSC bus.

Helge
