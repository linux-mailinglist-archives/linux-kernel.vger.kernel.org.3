Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681044B5009
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346871AbiBNMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:25:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiBNMZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:25:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4591496BE;
        Mon, 14 Feb 2022 04:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644841501;
        bh=Fak+dbExGOZ07P1gnc7sCEysNldJ4ZpEDwX7tWfcyo8=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=N87ZkYop7eOEFmJvR3tJ54DnyuLogrHU4CE4i7c+X75ON4KDzUDQAuyLjlwm3RvP3
         dO/ODPcfGAOuKpaPUmZu8g6Si6VhmBBaQCKuWH4M3rXB+3pgAnKyyn+l/Hu8QS2UEX
         iDaAc0HI7yPa7SNqAuwh/B0JFMlJGsiUQXd2NP2I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV63g-1nkVER1UCE-00S71B; Mon, 14
 Feb 2022 13:25:01 +0100
Message-ID: <4c716eda-a081-2ae3-9358-a5e35bd4d951@gmx.de>
Date:   Mon, 14 Feb 2022 13:24:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] serial: parisc: GSC: fix build when PCI_LBA is not set
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
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
In-Reply-To: <e8781486-b3ce-b2dd-2c84-f0b2a651556f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ObnMNwgldS8Xvoy6lwypakDHtckj/V7UeOhxkKbSbkIHzZqc639
 5CD/NFh5VzPArlYH8b8qpgDiF0xPIs7LXit1CVsbw7xzIWo9aGbZYeeTxEqcBEhepugh3vt
 jjb7SgMk1LOezKu4I446ZYUTHzhsxikKl5+Ok7P57QGmVJ3/+oBiFDgGLrCxgTGvIs8NcCl
 VnqU2E7cSNpZmt1U/E/yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qq3VSzRFxL8=:dTLoZMrC99uN14T/0LUlyb
 EBRTlrKJUjX2z31XkQNAhJmKFoWgIXsx619cva0AZReRpTZmzSoT0NIs4D/QnafusH4imIqGo
 HTSHY/U3qq2EHE36H+rt4Efzi8aApt4T8OyfXJmiKkD/OASkAHafDR1pmNTOouuqFk2jseLzg
 Q16Z40+UBxPTOlC69igdg6oN5NTA5w6IcrmIiIYiDIXwkGiu3CgD17zdw59aDltJjMmQHLSjU
 zqvzjVIto63G5B8C/7SSjiD16ObgE0KxiXY2ZFISieAfPqLopu+vY9WCz5s3twLoWFQ3rO0Qx
 hvmmdR5Oeu/O4Y9VEpW1QgdUPZcDzak/JGIR7pSAFoQz52goxxoVNUfrWCnqRf8zpoxlXNR+Q
 LTZ+g3tzeyTVyMLLPBp5ZDoIAzYo6zrhef9efy/SH4iWhTgLzwNOt1PNxktfKKdFvIh1gacUo
 AEHcnDKyi5ASqYih4tmy9c0eLYOQmPYMwjpVykfnsyPAK/pEXGA0el1CNj7/+jmk2bL7+h3Ik
 T0rv6ss8nQS2+H6OZ4h3/ZECgqV6ewPsN4rOd1MlWChO/M+I40CI3AuOeBdUxmE82Th6Trd0y
 kc3bSY+Lw8AyvGbPSdQg/7OGL19jp48OxEwMiMq1haCW5jVZxOoRieXjMTZNtBmtItPvJk3hD
 IUl+7A1/baTia7skv0F/7P2ZmQQgkk2Xcpoo9CruIpdq7GsEWFcYXEWgGPfB/PRHD4qBkT2rv
 J4dSs4IETIOyvp0LF3aaLOokLK1J8+xzcYvPIpDXtsnhJCldDU7rjbKGTcEWxcPkls73KFSDn
 ZDrXu6c7PAwfEJH9fHcIqEe4G0TvHPFVEQuW5ZHABHGZfgVhe8RBggI19L6zVyNidxIJZpLmi
 G9y2MxR08TSZd7MmiflF6mnO7XzXd+3SjJSmveRN3w+FD1GZs0K2CPU7jmw8JZovxbrWr9CJV
 mmH8HfKw19zoMNZ7VocTbmNNj9TZZPM8W57MNTIms1D4e6+FLhbYDNciT2uKmf8APbNVEhzLe
 AG3r5T7o0SLzhDzQwBIeieAnmAG2IzEG0ekMLNvujYlpHlhzy0/Wnp6ThnF1nRYr4DNkXmC8v
 6BMWjDRl39/X/w=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 13:05, Helge Deller wrote:
> On 2/14/22 01:15, Randy Dunlap wrote:
>> Hi,
>>
>> On 2/13/22 14:15, Helge Deller wrote:
>>> On 2/13/22 22:07, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 2/13/22 12:35, Helge Deller wrote:
>>>>> Hi Randy,
>>>>>
>>>>> On 2/13/22 20:39, Randy Dunlap wrote:
>>>>>> There is a build error when using a kernel .config file from
>>>>>> 'kernel test robot' for a different build problem:
>>>>>>
>>>>>> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.=
LC3':
>>>>>> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>>>>>>
>>>>>> when:
>>>>>>   CONFIG_GSC=3Dy
>>>>>>   CONFIG_SERIO_GSCPS2=3Dy
>>>>>>   CONFIG_SERIAL_8250_GSC=3Dy
>>>>>>   CONFIG_PCI is not set
>>>>>>     and hence PCI_LBA is not set.
>>>>>>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>>>>>>
>>>>>> Making SERIAL_8250_GSC depend on PCI_LBA prevents the build error.
>>>>>
>>>>> It maybe makes the build error go away, but ...
>>>>>
>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>>>>>> Cc: Helge Deller <deller@gmx.de>
>>>>>> Cc: linux-parisc@vger.kernel.org
>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>> Cc: linux-serial@vger.kernel.org
>>>>>> Cc: Jiri Slaby <jirislaby@kernel.org>
>>>>>> Cc: Johan Hovold <johan@kernel.org>
>>>>>> ---
>>>>>>  drivers/tty/serial/8250/Kconfig |    2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> --- linux-next-20220211.orig/drivers/tty/serial/8250/Kconfig
>>>>>> +++ linux-next-20220211/drivers/tty/serial/8250/Kconfig
>>>>>> @@ -118,7 +118,7 @@ config SERIAL_8250_CONSOLE
>>>>>>
>>>>>>  config SERIAL_8250_GSC
>>>>>>  	tristate
>>>>>> -	depends on SERIAL_8250 && GSC
>>>>>> +	depends on SERIAL_8250 && GSC && PCI_LBA
>>>>>>  	default SERIAL_8250
>>>>>
>>>>> The serial device is on the GSC bus, so if you make it
>>>>> dependend on the PCI bus it will not be useable on machines
>>>>> which only have a GSC bus...
>>>>>
>>>>> We need another patch.
>>>>> Do you have a link to the build error?
>>>>
>>>>
>>>> No, it's from the other build error that you just replied to,
>>>> where the incorrect compiler was used.
>>>>
>>>> I'll recheck it and reconsider what to do, if anything.
>>>
>>> Ok, thank you!
>>
>> I dunno what to do. This:
>>
>> #ifdef CONFIG_64BIT
>> 	if (!dev->irq && (dev->id.sversion =3D=3D 0xad))
>> 		dev->irq =3D iosapic_serial_irq(dev);
>> #endif
>>
>> makes it look like 64BIT requires IOSAPIC (hence PCI_LBA).
>
> Although I think all 64bit machines have a PCI bus, the better
> fix is that the driver should only call iosapic_serial_irq(dev)
> if CONFIG_IOSAPIC is set. This patch fixes the build:
>
> -#ifdef CONFIG_64BIT
> +#ifdef CONFIG_IOSAPIC
>         if (!dev->irq && (dev->id.sversion =3D=3D 0xad))
>                 dev->irq =3D iosapic_serial_irq(dev);
>  #endif

That was not fully correct.
It needs to be:

#if defined(CONFIG_64BIT) && defined(CONFIG_IOSAPIC)

Otherwise you'll get an undefined reference in the 32-bit build.

Helge
