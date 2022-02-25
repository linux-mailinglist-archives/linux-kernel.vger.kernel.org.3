Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E644C5118
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiBYV7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiBYV7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:59:16 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27FD18CC18;
        Fri, 25 Feb 2022 13:58:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8F85241F28;
        Fri, 25 Feb 2022 21:58:37 +0000 (UTC)
To:     Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220224130741.63924-1-marcan@marcan.st>
 <20220224130741.63924-3-marcan@marcan.st>
 <Yhk54H989MfhGMcu@robh.at.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 2/7] dt-bindings: interrupt-controller: apple,aic2: New
 binding for AICv2
Message-ID: <67171c2a-7601-6dfb-92b3-24c1ca971995@marcan.st>
Date:   Sat, 26 Feb 2022 06:58:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <Yhk54H989MfhGMcu@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2022 05.19, Rob Herring wrote:
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: apple,t6000-aic
>> +      - const: apple,aic2
> 
> I feel I was sold on Apple doesn't change h/w and we're the 2nd chip in 
> and the h/w changed. Just my musings, but aic3 will be rejected. :(

Well yes, after not changing hardware for N phone/tablet generations,
they figured out they *finally* had to make some changes for real
desktop chips... (t8103 was a tablet chip they shoehorned into laptops;
t6000 is the first real laptop/desktop chip). This isn't the 2nd chip
in, this is the 26th chip in or so, and yet it's called AIC2 (by Apple
even)... We aren't starting from chip #1, just the first chip they
decided to *let* us put Linux on.

It's pretty clear that the t6000 changes were made with future-proofing
in mind. I guess we'll find out in a couple weeks, since the rumor mill
says M2 is coming. If I'm right and we end up needing *zero* kernel
changes to boot on M2, will you be happy? ;-)

>> +  apple,event-reg:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Specifies the offset of the event register, which lies after all the
>> +      implemented die register sets, page aligned. This is not computable from
>> +      capability register values, so we have to specify it explicitly.
> 
> If this is last, then couldn't it be a 2nd 'reg' entry?
> 
> 'page aligned' is ambiguous. I assume that means 16K since that's what 
> Apple uses, but I might assume 4K not knowing that.

16K, and yeah, it could be a 2nd reg entry if you think that works
better. Makes sense.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
