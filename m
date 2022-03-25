Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B738C4E7D5F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiCYTkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiCYTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:43 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC53D1C4043
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:19:45 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 5so14981106lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LCFeUuL1wHZygJUNv7IbXrchIqyIDdGk//PwJLZZTyM=;
        b=uwfJCfYYvYUrn6+Hm3sKiXtmdHuH0BohUJnPw8GYLTauSBUNDkcY4iPwKi9bBhYY+g
         LWeFP8plZdMGdbclLcaB61DrybK+yPHmVkr9LURQ4iE05M1Qop102HqCZyDhY08YlYHC
         sGTLBwmF2Nrzu3JOkZTyVH9vqaehkmR894icKKkmljFYO0Yv/YBRWcT9qFx1j/hBLMD2
         dXfJGzT9mtjnl0KXxAa0W2AKXdrO2mhdgG9XzpXS25pDjZ0eSWeYLWkfRQ98oKHmqrbN
         0WI3PIpYjcvyvP8GwIBQgJiFTPjEhnd1t2u4Ukl/PJWWSd+FbkG+/RGn2saKTUXrlPVG
         1unQ==
X-Gm-Message-State: AOAM530kjSu8CfhfiIToYq8AWqBisYrPC2mtoA1+jZjY745GecKKyKWe
        rTijNAV+e5cl/rl5mYU645k3ld7/3YjU9Q==
X-Google-Smtp-Source: ABdhPJyv9k5MR7nZBdcLPf4KryqF222cdIsjAx1jjv/2ZlzGKqL7eln18chyFPaZjezdCK2bgrVdZg==
X-Received: by 2002:a50:ed91:0:b0:419:979a:ac57 with SMTP id h17-20020a50ed91000000b00419979aac57mr83065edr.206.1648234022401;
        Fri, 25 Mar 2022 11:47:02 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id v1-20020a1709064e8100b006e07d033572sm2173180eju.33.2022.03.25.11.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 11:47:01 -0700 (PDT)
Message-ID: <4032ca01-0576-aed6-fb22-426842852b70@kernel.org>
Date:   Fri, 25 Mar 2022 19:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/3] sound: usb: Add vendor's hooking interface
Content-Language: en-US
To:     Oh Eomji <eomji.oh@samsung.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        JaeHun Jung <jh0801.jung@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
 <CGME20220324081212epcas2p4d2ed1f3a1bb020606cf65016efec085b@epcas2p4.samsung.com>
 <1648109444-196321-2-git-send-email-eomji.oh@samsung.com>
 <Yjwsh4N6dFKvWGav@kroah.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <Yjwsh4N6dFKvWGav@kroah.com>
Content-Type: text/plain; charset=UTF-8
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

On 24/03/2022 09:32, Greg Kroah-Hartman wrote:
> On Thu, Mar 24, 2022 at 05:10:42PM +0900, Oh Eomji wrote:
>> In mobile, a co-processor can be used with USB audio to improve
>> power consumption.  To support this type of hardware, hooks need to
>> be added to the USB audio subsystem to be able to call into the
>> hardware when needed.
>> 
>> The main operation of the call-backs are: - Initialize the
>> co-processor by transmitting data when initializing. - Change the
>> co-processor setting value through the interface function. -
>> Configure sampling rate - pcm open/close - other housekeeping
>> 
>> Known issues: - This only supports one set of callback hooks,
>> meaning that this only works if there is one type of USB controller
>> in the system.  This should be changed to be a per-host-controller
>> interface instead of one global set of callbacks.
> 
> Sorry, but this limitation alone means that this is not going to be
> able to be accepted.  Almost all real systems have multiple USB
> controllers in the system and so, this will break in very bad ways on
> the majority of devices in the world.
> 
> Please fix this up and make this per-USB-controller, as was
> requested the last time this series was published.

This is a v2 (not v1) and Greg asked this already:
https://lore.kernel.org/all/YiW6ZqnINsOSyN+z@kroah.com/
That time, it was left without an answer.

Ignoring feedback and resending does not help in getting patches
mainlined. :(

Best regards,
Krzysztof
