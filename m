Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33F1506612
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349473AbiDSHlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbiDSHlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:41:21 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C94323155;
        Tue, 19 Apr 2022 00:38:40 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 21so20185212edv.1;
        Tue, 19 Apr 2022 00:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cMIQtXBcL0LX2Xu0lItqcQNjpRN4Lxw6ZeFSuk932VI=;
        b=KNfBwPtL9gAWJtrwVTyI7Xz5sgDN6pWxksXVxeTaI5t4LG96f//Htz8DfpkhjQjfoe
         E9J3G9lh+7h+pRJ4p+7CXQcVugcOLO17fVToup2v0MOQMYiI/iSY8DyZg82tA7n7bRjq
         mM0buaiqLpQnThx91jxrPMUUZ6FRcMjXMR7wRqOsy5cvUReQBkc0a8GAZufqBVujMF2f
         xsDzdQJ42p0TspgKyb8a1CuO7VlnGOq4uVN2+gnpu9Lgcv5FOzyl5k0juvn3l9ZajPSj
         To+FmAymd+gcPw68geaKAuyhE1TFqYiIE2vdxDkP/Yg1kSE39bo+enXx6caBlsDfHv9r
         6mvQ==
X-Gm-Message-State: AOAM533OFrkWvhc+0UBFy+S3n5q+5Eaw9/r+dvt4QtF3W4jNF7Q4B1TB
        AcMpQMhj+ZFGR7Y51risLl4=
X-Google-Smtp-Source: ABdhPJx9uF7mg6dncUt7CC20Ri+ArabDBoEQkVzbHd/rqPriMfROsVzMkJEP2rCKSX2QYiazZ8y76A==
X-Received: by 2002:a05:6402:22c4:b0:41d:78b1:349 with SMTP id dm4-20020a05640222c400b0041d78b10349mr16239817edb.365.1650353918802;
        Tue, 19 Apr 2022 00:38:38 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id p9-20020a05640243c900b0041facb9ac9esm7807362edc.1.2022.04.19.00.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:38:38 -0700 (PDT)
Message-ID: <9af92c78-73a7-d524-182c-3ebffa69b08a@kernel.org>
Date:   Tue, 19 Apr 2022 09:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 1/2] tty: serial: meson: Add a 12MHz internal clock
 rate to calculate baud rate in order to meet the baud rate requirements of
 special BT modules
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220418053202.24528-1-yu.tu@amlogic.com>
 <20220418053202.24528-2-yu.tu@amlogic.com>
 <CAHp75VeW65dV9jJu8-yUWME+XKnaxZBu5Zv8iEJxP2dizA=HUg@mail.gmail.com>
 <d10e27ff-e674-87bd-2c98-63c7040baeb1@amlogic.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <d10e27ff-e674-87bd-2c98-63c7040baeb1@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 04. 22, 9:29, Yu Tu wrote:
> Hi Andy,
>      Thank you for your advice.
> 
> On 2022/4/18 20:09, Andy Shevchenko wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On Mon, Apr 18, 2022 at 8:50 AM Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>> A /2 divider over XTAL was introduced since G12A, and is preferred
>>> to be used over the still present /3 divider since it provides much
>>> closer frequencies vs the request baudrate.Especially the BT module
>>
>> 'e. E' (mind the space)
> My statement is a whole. There should be no spaces.

Period should be followed by a space, of course.

>>> uses 3Mhz baud rate. 8Mhz calculations can lead to baud rate bias,
>>> causing some problems.
>>
>> ...
>>
>>> +struct meson_uart_data {
>>> +       bool has_xtal_div2;
>>
>> I would prefer to see this as an unsigned int and with a less
>> particular name, e.g. xtal_div would suffice.
> I don't have a problem with your suggestion.Let's see What Neil has to say.

Actually why uint provided it's a boolean value? Or do you mean to store 
the divisor directly in this member, Andy?

thanks,
-- 
js
suse labs
