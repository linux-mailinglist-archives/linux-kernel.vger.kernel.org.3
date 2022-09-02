Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CC5AA958
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiIBICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiIBICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:02:16 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FDAB249C;
        Fri,  2 Sep 2022 01:02:15 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id nc14so2265808ejc.4;
        Fri, 02 Sep 2022 01:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sVHA2PIxhZltK2Dfyk3TDE/QZAokEtcUU7z8nmxHpkI=;
        b=1TPbCNyTsjg8bMU/2NCqFio1rJj4rBYlCW9tWENRbWlyl1CCCg0Uz8yTZN3BzIQQdT
         r7hoS6ogQ1+qcu/6tj0/TUM7wwHtHIwuUrRYQvVm3p1qXFeO7Kq8fzUMg8tMvUXem+jm
         4IbBgcSE3SyToBcR5Ukf3DhuIqJ/cQHWFzSdWRFtQhz512OQO1jOR9nDEjWELeNwvbAu
         Ck4wIRa9Y2DD0HoPShPe0WVNfkarrg71jT+FtJTjrmONoM53gS4ZrLPT04/t8IrLqsOK
         btHUe0w+6Pmj3YAK0QXaGyB8yNTkOPmAQ/UY5D/UmtSj7iP/u+IQByHr6S7NGIYJgTWB
         7czw==
X-Gm-Message-State: ACgBeo1JjJerkexIID0kr0ytwcbrCDNKKH0USqPNLKADVDYrufJkPZyH
        gtYgx/a9PK+9O9ooIQG62RVH4qgimWI=
X-Google-Smtp-Source: AA6agR7CTVOadiUfFEBCaCf//Ww4rYb7KEZxVTfxrvfHvDP4XiRWaJRapgsaEy2aPgJsiLG5Jl67WQ==
X-Received: by 2002:a17:907:3da4:b0:742:747e:4bc8 with SMTP id he36-20020a1709073da400b00742747e4bc8mr11338124ejc.555.1662105733586;
        Fri, 02 Sep 2022 01:02:13 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id dc4-20020a170906c7c400b0073bf84be798sm842218ejb.142.2022.09.02.01.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 01:02:12 -0700 (PDT)
Message-ID: <febf72d0-da17-9325-b65e-e28e2a3b13d3@kernel.org>
Date:   Fri, 2 Sep 2022 10:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/3] tty: serial: introduce transmit helper generators
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220901110657.3305-1-jslaby@suse.cz>
 <20220901110657.3305-2-jslaby@suse.cz> <YxCkqmz32qMAZAPh@kroah.com>
 <e122fe60-484b-fd50-d166-4a21e08d4775@kernel.org>
 <YxGTXK452NwcQEGC@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YxGTXK452NwcQEGC@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 02. 09. 22, 7:23, Greg KH wrote:
> On Fri, Sep 02, 2022 at 07:16:58AM +0200, Jiri Slaby wrote:
>> On 01. 09. 22, 14:25, Greg KH wrote:
>>> Much nicer, but:
>>>
>>>> +#define __DEFINE_UART_PORT_TX_HELPER(name, port, ch, tx_ready, put_char,  \
>>>> +		tx_done, for_test, for_post, ...)			  \
>>>
>>> Do you really need "port" and "ch" as part of this macro?  You always
>>> set that to the same thing in your patches, so is it really needed?
>>
>> Not really, just to make obvious that those are the names that can be used
>> in tx_ready, put_char... I can remove it, if you prefer, of course.
> 
> I'd recommend just removing it as it's a hard macro to read as-is.  That
> would make it a bit more simple as then you are just passing in the name
> and the callback functions, which makes a bit more sense to me.

OK, I'll wait a couple of days if more comments/acks/reviews come and 
will send a v3.

thanks,
-- 
js
suse labs

