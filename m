Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67214B3DAB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiBMVHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBMVHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:07:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524CD53726;
        Sun, 13 Feb 2022 13:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=TpeZJruUWIHQrec6INjMOe3tJKkfB5AtMyx8DX9DlJQ=; b=dTCnjumE+jgwvROuWmmif1aESN
        vamLKBGywF3n4msqcO1hqQlg3Utk9zzASDP2EubYBsL3TbKCYnmtcwYIGBHTJCfUKfHLP+75IgcO8
        /KAyFEY3DjtaqJT2eD+6SanPhJHnXB+ZvYdy1Ja2yjg1Z3BMghBBQ6co8QaBpcWOWinNfZyn/553i
        S/Ah2RB5DVgDhpRc/4+byLkmxMjAduxMaI517+NyE3GhAH1nOrZ7Ffa9QWqDazxK8pv1bQ8RykO5S
        9o6LF/Itgzohg3df0FZr0Nf3N6yYfAIl9JZ2PMQI3DJgL8fUduCB6MYKKCwfP9O1bILBR+GnQvahT
        C5PC0Uvg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJM5M-00CHWi-Vl; Sun, 13 Feb 2022 21:07:09 +0000
Message-ID: <55c73cb4-21ae-7307-7b14-a19cf270f4d6@infradead.org>
Date:   Sun, 13 Feb 2022 13:07:04 -0800
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0baabcbc-196e-08fa-e2db-b7e925993cc1@gmx.de>
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



On 2/13/22 12:35, Helge Deller wrote:
> Hi Randy,
> 
> On 2/13/22 20:39, Randy Dunlap wrote:
>> There is a build error when using a kernel .config file from
>> 'kernel test robot' for a different build problem:
>>
>> hppa64-linux-ld: drivers/tty/serial/8250/8250_gsc.o: in function `.LC3':
>> (.data.rel.ro+0x18): undefined reference to `iosapic_serial_irq'
>>
>> when:
>>   CONFIG_GSC=y
>>   CONFIG_SERIO_GSCPS2=y
>>   CONFIG_SERIAL_8250_GSC=y
>>   CONFIG_PCI is not set
>>     and hence PCI_LBA is not set.
>>   IOSAPIC depends on PCI_LBA, so IOSAPIC is not set/enabled.
>>
>> Making SERIAL_8250_GSC depend on PCI_LBA prevents the build error.
> 
> It maybe makes the build error go away, but ...
> 
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: linux-parisc@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-serial@vger.kernel.org
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: Johan Hovold <johan@kernel.org>
>> ---
>>  drivers/tty/serial/8250/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20220211.orig/drivers/tty/serial/8250/Kconfig
>> +++ linux-next-20220211/drivers/tty/serial/8250/Kconfig
>> @@ -118,7 +118,7 @@ config SERIAL_8250_CONSOLE
>>
>>  config SERIAL_8250_GSC
>>  	tristate
>> -	depends on SERIAL_8250 && GSC
>> +	depends on SERIAL_8250 && GSC && PCI_LBA
>>  	default SERIAL_8250
> 
> The serial device is on the GSC bus, so if you make it
> dependend on the PCI bus it will not be useable on machines
> which only have a GSC bus...
> 
> We need another patch.
> Do you have a link to the build error?


No, it's from the other build error that you just replied to,
where the incorrect compiler was used.

I'll recheck it and reconsider what to do, if anything.

thanks.

-- 
~Randy
