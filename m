Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA25AAC55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiIBKYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiIBKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:24:16 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977C1BCC29;
        Fri,  2 Sep 2022 03:24:14 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id kk26so2889316ejc.11;
        Fri, 02 Sep 2022 03:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ubw4OAqYosXzoND9JMZTiJy0l/yQs/77EKbKqKbW0YY=;
        b=BP2DZRPFf2sbOz8D9ICcUh7PSy1faNf/HDwU2zjY0QpLEYUzZcLSpSwA8byECDqifB
         GTLeB6zIdfhi9QSKZxBhu3lTYh1wxN4Hs0v1519Zo3Wollw7gcYYDrby1Zi0c4cYatoF
         gcqKk7seReSKQGmTKB+lB7ewZwFYPk2MxzFvt8VptUAmgJj3/7enhgut/t0MgcaoDus2
         361w9kJ6cXKJ4H7DmvEbbtKcxRtS7XxHBB1Ak4s07ks0qYcH7AYe11MueMN5hLyV+ga6
         xnWIVWGABa7t+5H60W+XIx57RQcXngb3+QhirOI4DJyyWzwaH1oudFIGADTvE97lJpdU
         LfMA==
X-Gm-Message-State: ACgBeo0OWS9j0TUblJOlsbOIUHyKmybeYl0Mfo16R1/w3BHGaUsfRaI8
        ZgNDikuYDbGNslX/qbJpN8U=
X-Google-Smtp-Source: AA6agR4ms7cVIiIp5M+0RzQlzueDIm22Ha8OGxxaGw+kpc4gvcmdlMOJOBV04pyZflw71zqaYkOJaQ==
X-Received: by 2002:a17:906:dc89:b0:731:67eb:b60b with SMTP id cs9-20020a170906dc8900b0073167ebb60bmr25914231ejc.614.1662114252520;
        Fri, 02 Sep 2022 03:24:12 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id f21-20020a056402195500b0043ba437fe04sm1163463edz.78.2022.09.02.03.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 03:24:11 -0700 (PDT)
Message-ID: <ebbcb006-b0ec-0e17-577b-7149b47b07cd@kernel.org>
Date:   Fri, 2 Sep 2022 12:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/3] tty: serial: introduce transmit helper generators
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220901110657.3305-1-jslaby@suse.cz>
 <20220901110657.3305-2-jslaby@suse.cz>
 <61411321-285d-ec3e-2d92-e93b0e95631@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <61411321-285d-ec3e-2d92-e93b0e95631@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 09. 22, 12:22, Ilpo Järvinen wrote:
> On Thu, 1 Sep 2022, Jiri Slaby wrote:
> 
>> Many serial drivers do the same thing:
>> * send x_char if set
>> * keep sending from the xmit circular buffer until either
>>    - the loop reaches the end of the xmit buffer
>>    - TX is stopped
>>    - HW fifo is full
>> * check for pending characters and:
>>    - wake up tty writers to fill for more data into xmit buffer
>>    - stop TX if there is nothing in the xmit buffer
>>
>> The only differences are:
>> * how to write the character to the HW fifo
>> * the check of the end condition:
>>    - is the HW fifo full?
>>    - is limit of the written characters reached?
>>
>> So unify the above into two helper generators:
>> * DEFINE_UART_PORT_TX_HELPER_LIMITED() -- it performs the above taking
>>    the written characters limit into account, and
>> * DEFINE_UART_PORT_TX_HELPER() -- the same as above, except it only
>>    checks the HW readiness, not the characters limit.
>>
>> The HW specific operations (as stated as "differences" above) are passed
>> as arguments to the macros. They are:
>> * tx_ready() -- returns true if HW can accept more data.
>> * put_char() -- write a character to the device.
>> * tx_done() -- when the write loop is done, perform arbitrary action
>>    before potential invocation of ops->stop_tx() happens.
>>
>> Note that the above macros are generators. This means the code is
>> generated in place and the above 3 arguments are "inlined". I.e. no
>> added penalty by generating call instructions for every single
>> character. Nor any indirect calls. (As in previous versions of this
>> patchset.)
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>
>> Notes:
>>      [v2] instead of a function (uart_port_tx_limit()) in serial_core,
>>           generate these in-place using macros. Thus eliminating "call"
>>           penalty.
>>
>>   Documentation/driver-api/serial/driver.rst |  3 +
>>   include/linux/serial_core.h                | 86 ++++++++++++++++++++++
>>   2 files changed, 89 insertions(+)
>>
>> diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
>> index 23c6b956cd90..25775bf1fcc6 100644
>> --- a/Documentation/driver-api/serial/driver.rst
>> +++ b/Documentation/driver-api/serial/driver.rst
>> @@ -78,6 +78,9 @@ Other functions
>>              uart_get_lsr_info uart_handle_dcd_change uart_handle_cts_change
>>              uart_try_toggle_sysrq uart_get_console
>>   
>> +.. kernel-doc:: include/linux/serial_core.h
>> +   :identifiers: DEFINE_UART_PORT_TX_HELPER_LIMITED DEFINE_UART_PORT_TX_HELPER
>> +
>>   Other notes
>>   -----------
>>   
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index 6e4f4765d209..715778160ae1 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -646,6 +646,92 @@ struct uart_driver {
>>   
>>   void uart_write_wakeup(struct uart_port *port);
>>   
>> +#define __DEFINE_UART_PORT_TX_HELPER(name, port, ch, tx_ready, put_char,  \
>> +		tx_done, for_test, for_post, ...)			  \
>> +unsigned int name(struct uart_port *port __VA_OPT__(,) __VA_ARGS__)	  \
>> +{									  \
>> +	struct circ_buf *xmit = &port->state->xmit;			  \
>> +	unsigned int pending;						  \
>> +	u8 ch;								  \
>> +									  \
>> +	for (; (for_test) && (tx_ready); (for_post), port->icount.tx++) { \
> 
>> + * The functions in parameters shall be designed as follows:
>> + *  * **tx_ready(port):** the function shall return true if the HW can accept
>> + *    more data to be sent. This function can be %NULL, which means the HW is
>> + *    always ready.
> 
> So if tx_ready can be NULL, how does that for() loop above work??

Sorry, the docs is wrong (corresponded to v1). I fixed it locally already:

https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=989c488c69faf2987648e09358c79d75b4a3b5c7

thanks,
-- 
js
suse labs

