Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA2F5AA729
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiIBFRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiIBFRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:17:02 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1821BA5718;
        Thu,  1 Sep 2022 22:17:02 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id e18so1232636edj.3;
        Thu, 01 Sep 2022 22:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XeKu+qTJ04LpGfaU8mzpIsHanK2YeKifc8Qw+NqHOGk=;
        b=r5yHQ/ydwTv4eudqPNOtiD49jxD0DwlBLHBRNGr9LcLwm0SAVw3vAfnOtb6A0idTia
         t3ET0t5c33T4hYto7tMkWoPkDXwKiidw5o38brsYT3yuwNjJZgGjbmYJ6izhTBfIqn1f
         n6YnBbc4EhcSDEBKvXcAa7xGE4pLhOfBHgzZq38GtDPvi4rzDJEYGzZ3fDg2cjfbQHpe
         hiRGfi9RDE/gE+SlWChdZyPa9zJn2Ylxgf8QOv0D8vcAKN90unuE/ju6WFrOZPeWUbL7
         ywrbbmxeUt7dgqORCE/S8YjSFoBVZqWV7t5eSgHG0/+2EdTcwvBRoL/AoSeNjilZWpM7
         uVSQ==
X-Gm-Message-State: ACgBeo1rJ7OM3IBL1BFr6DRGeXAPMn3CQgvpIwgduV+gFhbrar3KvNGZ
        ue2z7UqBoMZx9V8iGWKE+gzLHnGpoMc=
X-Google-Smtp-Source: AA6agR7zcRg1xtZQaSnEH5F7HoYUUNKhyTlJAuQTNpdO15sPCXwdKygzQKisrhYBDfp/TZEJYLbI9g==
X-Received: by 2002:a05:6402:1f02:b0:445:f674:eac0 with SMTP id b2-20020a0564021f0200b00445f674eac0mr30456039edb.370.1662095820497;
        Thu, 01 Sep 2022 22:17:00 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id kz16-20020a17090777d000b0073c8d4c9f38sm655960ejc.177.2022.09.01.22.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 22:16:59 -0700 (PDT)
Message-ID: <e122fe60-484b-fd50-d166-4a21e08d4775@kernel.org>
Date:   Fri, 2 Sep 2022 07:16:58 +0200
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YxCkqmz32qMAZAPh@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 09. 22, 14:25, Greg KH wrote:
> Much nicer, but:
> 
>> +#define __DEFINE_UART_PORT_TX_HELPER(name, port, ch, tx_ready, put_char,  \
>> +		tx_done, for_test, for_post, ...)			  \
> 
> Do you really need "port" and "ch" as part of this macro?  You always
> set that to the same thing in your patches, so is it really needed?

Not really, just to make obvious that those are the names that can be 
used in tx_ready, put_char... I can remove it, if you prefer, of course.

thanks,
-- 
js
suse labs

