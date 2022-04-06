Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E04F5DD5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiDFMYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiDFMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:22:59 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B775DB4BC;
        Wed,  6 Apr 2022 01:07:34 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id n6so2513001ejc.13;
        Wed, 06 Apr 2022 01:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iOgrKLV2a4LHZWuaU0zd4hmFB+3+hL8SxL1QKpt1vFw=;
        b=Aeu0h6eoM3DuD02xlZdprKNSyY6HFgcAKRfyttW8MkDO7zFCP9YDSWeJydn0npQfMw
         u6HYqON/EDXyOOhjyRFO6jBvp2t94Qgz/nRfPt2sW2+V6RRwTWBJ5CZIVRZxHLEeDnmx
         x04k4IpxMrwjJ5SAAE/mAGVeTsFDT2rZFLlBlOxlf37VJ6KDp0n8SYSJQCvk5Dph0iWj
         yBO/QJ5RuGqm0/9W3EM2R1j5ApwIINjTaa8sSivzhuIfMj29neSwFnMhKtNrkWSAua63
         EmxUdN+vvO3X9ax6wOm8NmOZkdNMmWhILn5HlBDrMGofw6w171i92QTfl2vPFHtlqUKR
         uVWA==
X-Gm-Message-State: AOAM533tZBGsSOeh7HTXbaYnk7pIIlcQSaTHZfkXgfHL/9og6e0sBZpf
        Gu5mOYy+Ajnlw7hGXhrDKGQ83vNpqQs=
X-Google-Smtp-Source: ABdhPJwgTUFvg/eSX3csMe5evjOo9LmO3q9dhkvN2Iw+ERs2TBcEZaZRM7zyBJuvJ462spR/0PyR/g==
X-Received: by 2002:a17:907:7245:b0:6e4:b142:f736 with SMTP id ds5-20020a170907724500b006e4b142f736mr7316050ejc.58.1649232453089;
        Wed, 06 Apr 2022 01:07:33 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090630c500b006e8044fa76bsm1918181ejb.143.2022.04.06.01.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:07:32 -0700 (PDT)
Message-ID: <cffdfa4c-57f8-a8f7-758e-2975b91d7b92@kernel.org>
Date:   Wed, 6 Apr 2022 10:07:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] tty: Add lookahead param to receive_buf
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
References: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com>
 <20220405102437.4842-2-ilpo.jarvinen@linux.intel.com>
 <YkxoR+jA9tDJOqNU@smile.fi.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YkxoR+jA9tDJOqNU@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 04. 22, 18:03, Andy Shevchenko wrote:
> On Tue, Apr 05, 2022 at 01:24:36PM +0300, Ilpo Järvinen wrote:
>> After lookahead for XON/XOFF characters is added by the next
>> patch, the receive side needs to ensure the flow-control
>> actions are not retaken later on when those same characters
>> get read by TTY.
>>
>> Thus, pass lookahead count to receive_buf and skip
>> flow-control character actions if already taken for the
>> character in question. Lookahead count will become live after
>> the next patch.
> 
> ...
> 
>> -static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
>> +static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
>> +				       bool lookahead_done)
>>   {
>>   	struct n_tty_data *ldata = tty->disc_data;
>>   
>>   	if (I_IXON(tty)) {
>>   		if (c == START_CHAR(tty)) {
>> -			start_tty(tty);
>> -			process_echoes(tty);
>> +			if (!lookahead_done) {
>> +				start_tty(tty);
>> +				process_echoes(tty);
>> +			}
>>   			return;
>>   		}
>>   		if (c == STOP_CHAR(tty)) {
>> -			stop_tty(tty);
>> +			if (!lookahead_done)
>> +				stop_tty(tty);
>>   			return;
>>   		}
> 
> Wouldn't be cleaner to inside out the conditionals?

Seconded.

> 	if (I_IXON(tty)) {
> 		if (lookahead_done) {
> 			// Can be joined, but I think this is better

I would join them, IMO it'd be still easy to read and to follow too.

> 			if (c == START_CHAR(tty))
> 				return;
> 			if (c == STOP_CHAR(tty))
> 				return;
> 		} else {
> 			if (c == START_CHAR(tty)) {
> 				start_tty(tty);
> 				process_echoes(tty);
> 				return;
> 			}
> 			if (c == STOP_CHAR(tty)) {
> 				stop_tty(tty);
> 				return;
> 			}
> 		}
> 	}

thanks,
-- 
js
suse labs
