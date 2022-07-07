Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADFC569C00
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiGGHoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiGGHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:44:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9219E3204E;
        Thu,  7 Jul 2022 00:44:15 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5214622239;
        Thu,  7 Jul 2022 09:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657179853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry/TMI/eWL85gcozfg1uWSD2ye3/l0xcunEjU54fQPg=;
        b=odKhJD6n87UZ4JiQC862oVYU9J5Txi/LL+1t/ioit6Ib3TCW+LT2SH7H2rygfR1mEe52cn
        aXbq2Slohtc9VnHRtv0B8rrq9CG+80jeIWnJm9IPlLQk83Po2hNaQo/1HBiVuxm5olvQtz
        47IEZoxKESOavNkd2xtKurQ1UeNpTq4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Jul 2022 09:44:13 +0200
From:   Michael Walle <michael@walle.cc>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] gpio: regmap: Support registers with more than one
 bit per GPIO
In-Reply-To: <DfKGwB5bggV3msX63bZrjjUX37ipAwv7@localhost>
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-2-aidanmacdonald.0x0@gmail.com>
 <4c9092d20a35ef3fd6a1723e07adad79@walle.cc>
 <R11Wg2gY4kEFeq6ZSy2mXbGejo7XRfjG@localhost>
 <4ca4580a3f5157e3ac7a5c8943ef607b@walle.cc>
 <DfKGwB5bggV3msX63bZrjjUX37ipAwv7@localhost>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e3e3b4ed3b05368266d871e45235c899@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-06 22:46, schrieb Aidan MacDonald:
>> Am 2022-07-04 18:01, schrieb Aidan MacDonald:
>>>> Am 2022-07-03 13:10, schrieb Aidan MacDonald:
>>>>> Some devices use a multi-bit register field to change the GPIO
>>>>> input/output direction. Add the ->reg_field_xlate() callback to
>>>>> support such devices in gpio-regmap.
>>>>> ->reg_field_xlate() builds on ->reg_mask_xlate() by allowing the
>>>>> driver to return a mask and values to describe a register field.
>>>>> gpio-regmap will use the mask to isolate the field and compare or
>>>>> update it using the values to implement GPIO level and direction
>>>>> get and set ops.
>>>> Thanks for working on this. Here are my thoughts on how to improve
>>>> it:
>>>>  - I'm wary on the value translation of the set and get, you
>>>>    don't need that at the moment, correct? I'd concentrate on
>>>>    the direction for now.
>>>>  - I'd add a xlate_direction(), see below for an example
>>> Yeah, I only need direction, but there's no advantage to creating a
>>> specific mechanism. I'm not opposed to doing that but I don't see
>>> how it can be done cleanly. Being more general is more consistent
>>> for the API and implementation -- even if the extra flexibility
>>> probably won't be needed, it doesn't hurt.
>> 
>> I'd prefer to keep it to the current use case. I'm not sure if
>> there are many controllers which have more than one bit for
>> the input and output state. And if, we are still limited to
>> one register, what if the bits are distributed among multiple
>> registers..
>> 
> 
> I found three drivers (not exhaustive) that have fields for setting the
> output level: gpio-amd8111, gpio-creg-snps, and gpio-lp3943. Admittedly
> that's more than I expected, so maybe we shouldn't dismiss the idea of
> multi-bit output fields.

I'm not dismissing it, but I want to wait for an actual user
for it :)

> If you still think the API you're suggesting is better then I can go
> with it, but IMHO it's more code and more special cases, even if only
> a little bit.

What bothers me with your approach is that you are returning
an integer and in one case you are interpreting it as gpio
direction and in the other case you are interpreting it as
a gpio state, while mine is more explicit, i.e. a
xlate_direction() for the direction and if there will be
support for multi bit input/output then there would be a
xlate_state() or similar. Granted, it is more code, but
easier to understand IMHO.

-michael
