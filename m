Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC50A5689F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiGFNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGFNr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:47:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD1DEF2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:47:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m184so8891053wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=oUwD/AXk3hn18jg9g8hVaPoJbhZdU+eC6asfRcw/JZ8=;
        b=OV6NQ+wPRl2SEbWwcpJRPhyEuZ8cg8yTsJqgVyKnZOK2UthzIAwcDwB3+WLL18sjlb
         /C16E768PD8WDWQUV6iOuuogcZaJTm3BQQsDxPgatCYJKd+jgAHy1Tif+KBTazTMIlG/
         kxGvrZ0Tvh2dHNnjY8fuDHaK5o5kkwzA5t881UFs5Y/G0C1qj/QbDh/lehUdLme1OnUm
         YpZ2RKUuGtPpgDS7hss+aISwdPO9egSp90BXGcvs1tYhm0cVrJ80C2ATmvjFYErITX1w
         ajhAeUc+2+ukI2+7/Coim6NfRFcDUpiexL3hP8VSfhXG28L4D0jNDHs4VXRANYAZ2PQm
         L6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=oUwD/AXk3hn18jg9g8hVaPoJbhZdU+eC6asfRcw/JZ8=;
        b=j42Mv0csPN9zCufqAr8YH11aswa7tq757qDDDpdmfq87E4kqxmKq2dA9CqFh/rEeo4
         5n9E1fpKaSu49sAPBpfj1C6Z9HdE1Tq1EUZVIP8SUTeB7kNsvB+eUKI2EBZCtWmccaj5
         wZzhsZQEx/WHdWsQQl3We94wfyGz1MQHaRZ2U1Xj13ZtvITxo1akibxDrRJzxUAX1Dlu
         NvxMw0lfVtiOvSNULowZXLd8w6X2KNFHxyZRJAPIqt0UFB88YWyIUtsvqCVM/LPR3AGr
         soSVUdu4eRPxhiJ2aYjNruDquKECXkYKYiaXzP4aqufrEgn7OSthQbhEj1Z0rWdAkvmf
         JRmg==
X-Gm-Message-State: AJIora8S1cL7ZhTHsigXp/6R4x7fRu1lUMKEXS4Eucs9vdUIJ9ee1Ap5
        gV4T8GKiP16zt5xXNJOE8ffw9w==
X-Google-Smtp-Source: AGRyM1uUD5fUICbLUxi3NjNN7CjKDLK0xdLSPc5G0890T3qq/ARu1rv+irGhKla3vDPUN0DyFqatKQ==
X-Received: by 2002:a7b:c413:0:b0:3a1:8f03:29d0 with SMTP id k19-20020a7bc413000000b003a18f0329d0mr29344119wmi.160.1657115273408;
        Wed, 06 Jul 2022 06:47:53 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id v192-20020a1cacc9000000b003975c7058bfsm26068541wme.12.2022.07.06.06.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:47:53 -0700 (PDT)
References: <20220705142444.17063-1-pboos@baylibre.com>
 <f756b2d5-56e7-6e52-2739-eca4bb33508b@baylibre.com>
 <1jmtdnwd7y.fsf@starbuckisacylon.baylibre.com>
 <20220706124139.GB492220@roeck-us.net>
User-agent: mu4e 1.8.3; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philippe Boos <pboos@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: meson: keep running if already active
Date:   Wed, 06 Jul 2022 15:24:27 +0200
In-reply-to: <20220706124139.GB492220@roeck-us.net>
Message-ID: <1j8rp6z720.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 06 Jul 2022 at 05:41, Guenter Roeck <linux@roeck-us.net> wrote:

> On Tue, Jul 05, 2022 at 09:29:35PM +0200, Jerome Brunet wrote:
>> 
>> On Tue 05 Jul 2022 at 16:39, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> 
>> > Hi,
>> >
>> > On 05/07/2022 16:24, Philippe Boos wrote:
>> >> If the watchdog is already running (e.g.: started by bootloader) then
>> >> the kernel driver should keep the watchdog active but the amlogic driver
>> >> turns it off.
>> >> Let the driver fix the clock rate then restart the watchdog if it was
>> >> previously active.
>> >> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
>> >
>> > Please drop this review tag since it was done off-list
>> 
>> Indeed a review was done off-list.
>> 
>> Reviewed-by says a review has been done. I was not aware this applied to
>> public reviews only. I probably missed that, would you mind pointing me
>> to that rule please ?
>> 
>
> Public or not doesn't really matter. However, you can only apply a
> Reviewed-by: tag (or any tag, really) if you explicitly received one.
> The exchange seems to suggest that you did not receive that tag.

Philippe did receive that Reviewed-by. I gave it to him.
Doing his first public patches, he first requested a review off-list to
try to get things right and not bother people too much (so much for that :/)

> Please never add any tags on your own.

He did not.

>
> On the other side, if the reviewer did send a Reviewed-by: tag off list,
> I would kindly ask the reviewer to not do that in the future to avoid
> misunderstandings.

No worries. That being said, I have gone over 

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

It just says that Reviewed-by sent on the list should be collected for
the following version. Nothing against adding the tag if the job has
been done, on or off list. Same goes for Suggested-by, Tested-by, etc.

If I missed something or it is non-written rule, please let me know.

> If you don't want your Reviewed-by: tag attached to
> a patch, don't send one. Not everyone will even realize that you sent
> your tag off-list, and no one can be expected to know that you didn't
> really mean it when you sent your tag.

I do want Philippe to add it. I would not have given it the first place
if it was not the case.

>
> Thanks,
> Guenter

