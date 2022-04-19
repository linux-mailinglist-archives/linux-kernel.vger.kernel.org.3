Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3356D5068D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348766AbiDSKgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbiDSKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:36:32 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C829CBE;
        Tue, 19 Apr 2022 03:33:49 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23J7fDmK031408;
        Tue, 19 Apr 2022 12:33:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=/0f8BK/00om3y8sdVovlGdI6C+1xGoO5boVdTyUCN+I=;
 b=V9/TLbBSjUecSD3V5L03FnZNkfHdQH+bnk3tN/YrY9SKITLEiVEfbZyUUa1hni4mQg4+
 9uEv7dSUXEuEonS/cWuF6yUC5UYS3KxIlQqDB/JY9Gam6AnDa5yynod06mUz7hzhBppO
 VEKE/x8oxQGSIKmyzqFTsGTuykSgrZNQWPEy5lqAbIc+Euw1QIatOw8AZBkVl/NkBYma
 OmTMoKJlvDRSylbwxG56FbZnJ5tvQlSLnqdiO4mInI1nBy09II8Fn1n1cIEP47Yc2ISG
 6u46RxBO4SNPf4ckMiDCMH8Ck6Jggrb0P2nfamTzPcM5gOWfCcStwD04cxhwZUbekNOm Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fh09rf2qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 12:33:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EEE34100034;
        Tue, 19 Apr 2022 12:33:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E5FB320B860;
        Tue, 19 Apr 2022 12:33:34 +0200 (CEST)
Received: from [10.201.20.168] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 19 Apr
 2022 12:33:34 +0200
Message-ID: <1a3bbcf1-bc03-f3e0-a70b-1e7c47d38b59@foss.st.com>
Date:   Tue, 19 Apr 2022 12:33:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 1/3] serial: stm32: remove infinite loop possibility in
 putchar function
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220419085330.1178925-1-valentin.caron@foss.st.com>
 <20220419085330.1178925-2-valentin.caron@foss.st.com>
 <CAMuHMdVCeuC5qStugnssWKUeOVWxd_3XyYtS0mrZpqQVaXAP2w@mail.gmail.com>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <CAMuHMdVCeuC5qStugnssWKUeOVWxd_3XyYtS0mrZpqQVaXAP2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_04,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 10:59, Geert Uytterhoeven wrote:
> Hi Valentin,
>
> On Tue, Apr 19, 2022 at 10:54 AM Valentin Caron
> <valentin.caron@foss.st.com> wrote:
>> Rework stm32_usart_console_putchar() function in order to anticipate
>> the case where the character can never be sent.
>>
>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> Thanks for your patch!
>
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -1640,10 +1640,16 @@ static void stm32_usart_console_putchar(struct uart_port *port, unsigned char ch
>>   {
>>          struct stm32_port *stm32_port = to_stm32_port(port);
>>          const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
>> +       u32 isr;
>> +       int ret;
>>
>> -       while (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
>> -               cpu_relax();
>> -
>> +       ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr, isr,
>> +                                               (isr & USART_SR_TXE), 100,
>> +                                               STM32_USART_TIMEOUT_USEC);
>> +       if (ret != 0) {
>> +               dev_err(port->dev, "Error while sending data in UART TX : %d\n", ret);
> Does it make sense to print this message, i.e. will the user ever see it?
> Or is the failure above temporary?
> I assume that you have seen this trigger?
>
>> +               return;
>> +       }
>>          writel_relaxed(ch, port->membase + ofs->tdr);
>>   }
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
Hi Geert,

The failure is temporary. It can appears when the uart is too slow to 
send data.

I never tested the case, but I prefer to show a message to know if the 
console loses a character.

Thanks,
Valentin


