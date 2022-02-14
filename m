Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF374B4FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352551AbiBNMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:06:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiBNMGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:06:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF8A2AE2;
        Mon, 14 Feb 2022 04:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644840351;
        bh=iB8OA7D0RPbBYZw3mdJlg01reTkb29jHogKxVACPhTw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=OenWcuLMGt2uduq7nlLu7kit96MI0NFWOvjLO63AXuEDiL+G29sUBOfYkZ3c244Ii
         hHNivhHSUbUbTo4ZroumI3+HOCehNvNFknAoQOKo9QlRPMQqtc6P85IA86NG44GfT2
         8bMXPf22gEoxwqPnZs5/QQRnnAbFaXl0OY+MzS5U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1niqln2u2W-00TmbU; Mon, 14
 Feb 2022 13:05:51 +0100
Message-ID: <e8781486-b3ce-b2dd-2c84-f0b2a651556f@gmx.de>
Date:   Mon, 14 Feb 2022 13:05:44 +0100
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
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <0ffc9f5f-546a-a797-01bf-d62953e6d26c@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jm09AfvxANKB8kN/320M0GbFGeYK7enhOSfkBNyQ53NKzSNvdFD
 5/jXs2bugiVxb9wQFuk07gJBtXpQXN6HJJIbVun4ZmRTZW9/PyGpj50ATAxhAt05LnHQcpR
 gijF/IC2juBW0HoFTkqxfP3QmWqkEs174C/gTfJ6gig7QR6RIB4hCvBkAFGnGYmE2UF0F4I
 R+5jhE6xcaAvFobN7Zvpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+tdk/YGpEOA=:yKMigYhL6mILNuRG8p0ETZ
 M7x8FfuBBEPf80MLZMUbJsyMG5VKOvMA9zNG8QJQDNaPPkcryP7a1RiCwjlCDYECFXKd0hB45
 b6s5KNXZhUkrTLq23qA/mebx7N+AKJi46lAnXKH/mMppSsWLCgxafPrxF2IuSHMeR+P2IwVSy
 gCfGPpcsv87jR/mqAB+iNkZmqJ7sAHZjVrtUxsFIGGJkmmQus6hHmw+TfFpawClT9LyjGd4Gx
 QuI2JjmU8ERxlREDHTNsRgB6FsrzA8fp+0InGt3i/AtylGxb248L2AwEoIjLR1Sh6t4kIFDlN
 U3N/Ey5Ne+TEXkWeTP3qsZCVwPZHi8trOs8jFhpTVwWW1R2cZBO05VYx/+MoUmVsvHdlsSZhs
 NpRwGpfQ2gUfcspiACzole5eGJfd9HtfLcnIQVIQvmNhhHPQMbNlmSfsaQr4cLLGZfwrcs6sa
 QI9NzB9ymr9SVNycTWEqPQuFXrsdfOyBBuRul1NUnIe2UwHvNdK4oXZhjr+R3e0jR6fM7Nz9S
 rvj01ncx6F1y3lyldEYSZeeOT0ko8NIjJXo5NT5VgPpYPjjecYQiZ5uznSrZs0DU1ia6HNiRi
 uesAicAO0JBvSj1NkC5wdsIBt1nVXjmmEmOidwrAK9v+8Cs3fm24vKvFZbSyn7acydDbaHygr
 RrAkLtd7aSB0Nsa6+76CsIjMIVLe9aJUm2Tou1vdo4Yeg/HbPt8YSxm3X5er5m/pL0EpGXrNa
 zH41J6aKoXB20kkZkJfWrxt1QpqrvmkDwhU76+2vwaFz+VxJJiLHDZwBt7K8bP18c0+RqsQoi
 yT1V48cb1GVcYSIKvtzAwiaxB2ajAT7o+knVaaJHvbMD1FEXAaZFBi3p19syYvRPRDXstP5OJ
 rbu/cFFeddh3ejZmysY5E5xQ4pMxs7OAISGnL29RpvRT83dfngzLbzq/Jj90QYusl3F3mCIq1
 3dT1R6TkmZJuksTg1Dj4uF0nj8LsWku/EhsNtnGXG4rILTa9aBis8hGDtcITS8ombYS4HnxoZ
 9lfoQCk0uvvjjvfPfgmjBH2yH7WIrX3AOyWeGmQO65tuOtRkW9e5ELlRIZmhAt27Zfeqedw8X
 6pyveJKjY2zp2Y=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 01:15, Randy Dunlap wrote:
> Hi,
>
> On 2/13/22 14:15, Helge Deller wrote:
>> On 2/13/22 22:07, Randy Dunlap wrote:
>>>
>>>
>>> On 2/13/22 12:35, Helge Deller wrote:
>>>> Hi Randy,
>>>>
>>>> On 2/13/22 20:39, Randy Dunlap wrote:
>>>>> There is a build error when using a kernel .config file from
>>>>> 'kernel test robot' for a different build problem:
>>>>>
>>>>> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.L=
C3':
>>>>> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>>>>>
>>>>> when:
>>>>>   CONFIG_GSC=3Dy
>>>>>   CONFIG_SERIO_GSCPS2=3Dy
>>>>>   CONFIG_SERIAL_8250_GSC=3Dy
>>>>>   CONFIG_PCI is not set
>>>>>     and hence PCI_LBA is not set.
>>>>>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>>>>>
>>>>> Making SERIAL_8250_GSC depend on PCI_LBA prevents the build error.
>>>>
>>>> It maybe makes the build error go away, but ...
>>>>
>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>>>>> Cc: Helge Deller <deller@gmx.de>
>>>>> Cc: linux-parisc@vger.kernel.org
>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> Cc: linux-serial@vger.kernel.org
>>>>> Cc: Jiri Slaby <jirislaby@kernel.org>
>>>>> Cc: Johan Hovold <johan@kernel.org>
>>>>> ---
>>>>>  drivers/tty/serial/8250/Kconfig |    2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> --- linux-next-20220211.orig/drivers/tty/serial/8250/Kconfig
>>>>> +++ linux-next-20220211/drivers/tty/serial/8250/Kconfig
>>>>> @@ -118,7 +118,7 @@ config SERIAL_8250_CONSOLE
>>>>>
>>>>>  config SERIAL_8250_GSC
>>>>>  	tristate
>>>>> -	depends on SERIAL_8250 && GSC
>>>>> +	depends on SERIAL_8250 && GSC && PCI_LBA
>>>>>  	default SERIAL_8250
>>>>
>>>> The serial device is on the GSC bus, so if you make it
>>>> dependend on the PCI bus it will not be useable on machines
>>>> which only have a GSC bus...
>>>>
>>>> We need another patch.
>>>> Do you have a link to the build error?
>>>
>>>
>>> No, it's from the other build error that you just replied to,
>>> where the incorrect compiler was used.
>>>
>>> I'll recheck it and reconsider what to do, if anything.
>>
>> Ok, thank you!
>
> I dunno what to do. This:
>
> #ifdef CONFIG_64BIT
> 	if (!dev->irq && (dev->id.sversion =3D=3D 0xad))
> 		dev->irq =3D iosapic_serial_irq(dev);
> #endif
>
> makes it look like 64BIT requires IOSAPIC (hence PCI_LBA).

Although I think all 64bit machines have a PCI bus, the better
fix is that the driver should only call iosapic_serial_irq(dev)
if CONFIG_IOSAPIC is set. This patch fixes the build:

-#ifdef CONFIG_64BIT
+#ifdef CONFIG_IOSAPIC
        if (!dev->irq && (dev->id.sversion =3D=3D 0xad))
                dev->irq =3D iosapic_serial_irq(dev);
 #endif

Will you send an updated patch?

Thanks!
Helge
