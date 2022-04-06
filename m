Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B576F4F5C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiDFLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbiDFLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:33:03 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6495549FA0B;
        Wed,  6 Apr 2022 01:21:16 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id ot30so2589755ejb.12;
        Wed, 06 Apr 2022 01:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gwHQbPUCA95cMcvHayfyBMUngTXbYPcEVQeXfQ7AKpk=;
        b=Ow2XpmvYum8Ub38aKVzErMFis8H3RH804wGNnh4D8c5QnRkY2HQLBr0xQt26dfqaRM
         IaXHd3pUX/hjOEJgrqQhPf4jLbhh5+QCxss6nsPl+4c6cL/mvdpuGFyDvHi6qxxPoCRk
         qghtig/xBcvLY3K6FjGt88XJTVEuzxLbIX5ZNluvdhL5rlig4RndgZnUV4lJDKUOSTx1
         T68UpmgXWi3is6ngfx/Rz4vNNwpSCZ3gUj7TkVt8qWOdFCJp5qZKf5dMOhhFxhN28k4X
         bgLrfbKuR6uOhiA/B6tl3GwFX+xZusKb0EV2UPVNsBi3ea17AQ/MAQyYlwrcXgu0b1OC
         950g==
X-Gm-Message-State: AOAM5331XX7lGiRjF1QZgTE+mQTiQfMvx+IspwAvvlUSU58rbp76yfrc
        0ZLassW/K2zx7/kGSAkRiBRLIDayIzc=
X-Google-Smtp-Source: ABdhPJy6UW+ZK3rGaHWe2T0tIJe9hyy4wFTb9nXZmP8D3JgQ2W0Ksz3zKneZjLOAHt3dVLS3yQipzQ==
X-Received: by 2002:a17:907:2d8d:b0:6df:a06c:7c55 with SMTP id gt13-20020a1709072d8d00b006dfa06c7c55mr7244819ejc.325.1649233273709;
        Wed, 06 Apr 2022 01:21:13 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id dn4-20020a17090794c400b006dbec4f4acbsm6382356ejc.6.2022.04.06.01.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:21:13 -0700 (PDT)
Message-ID: <fce9c28e-a334-3c70-3a6a-8812f11d8fc7@kernel.org>
Date:   Wed, 6 Apr 2022 10:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] tty: Implement lookahead to process XON/XOFF timely
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
References: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com>
 <20220405102437.4842-3-ilpo.jarvinen@linux.intel.com>
 <YkxqGDsURPpkDM5W@smile.fi.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YkxqGDsURPpkDM5W@smile.fi.intel.com>
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

On 05. 04. 22, 18:11, Andy Shevchenko wrote:
> On Tue, Apr 05, 2022 at 01:24:37PM +0300, Ilpo Järvinen wrote:
>> When tty is not read from, XON/XOFF may get stuck into an
>> intermediate buffer. As those characters are there to do software
>> flow-control, it is not very useful. In the case where neither end
>> reads from ttys, the receiving ends might not be able receive the
>> XOFF characters and just keep sending more data to the opposite
>> direction. This problem is almost guaranteed to occur with DMA
>> which sends data in large chunks.
>>
>> If TTY is slow to process characters, that is, eats less than given
>> amount in receive_buf, invoke lookahead for the rest of the chars
>> to process potential XON/XOFF characters.
>>
>> The guards necessary for ensuring the XON/XOFF character are
>> processed only once were added by the previous patch. All this patch
>> needs to do on that front is to pass the lookahead count (that can
>> now be non-zero) into port->client_ops->receive_buf().
> 
> ...
> 
>> +static bool __n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
>> +					 bool lookahead_done)
>> +{
>> +	if (!I_IXON(tty))
>> +		return false;
>> +
>> +	if (c == START_CHAR(tty)) {
>> +		if (!lookahead_done) {
>> +			start_tty(tty);
>> +			process_echoes(tty);
>> +		}
>> +		return true;
>> +	}
>> +	if (c == STOP_CHAR(tty)) {
>> +		if (!lookahead_done)
>> +			stop_tty(tty);
>> +		return true;
>> +	}
>> +	return false;
>> +}
> 
> Looking into this I would first make a preparatory patch that splits out
> current code into something like
> 
> static bool __n_tty_receive_char_special_no_lookahead(struct tty_struct *tty, unsigned char c)
> {
> 	...current code...
> }
> 
> Then in the patch 1 you add
> 
> static bool __n_tty_receive_char_special_lookahead(struct tty_struct *tty, unsigned char c)
> {
> 	...
> }
> 
> static bool __n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
> 					 bool lookahead_done)

This should be dubbed better. Maybe n_tty_receive_char_flow_control()?

And I would place the if (I_IXON(tty)) to the caller. I am a bit lost in 
this pseudo code, so maybe this doesn't make sense in your proposal. I 
have something like in my mind:

if (I_IXON(tty))
   return n_tty_receive_char_flow_control();

Historically, these n_tty_receive* function names were a big mess. Don't 
produce more of that by simply prepending only "__".

> {
> 	if (!I_IXON(tty))
> 		return false;
> 
> 	if (lookahead_done)
> 		return _lookahead();
> 
> 	return _no_lookahead();
> }

thanks
-- 
js
suse labs
