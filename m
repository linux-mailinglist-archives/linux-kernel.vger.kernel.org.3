Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F02656D68D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiGKHRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiGKHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:17:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015ACB88
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:16:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z12so5768650wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WMKXC/CrO8TFuSStLrqF4pYNeJ++sg15iQVdB0X3y2w=;
        b=MAT3q+tvzelkP/ihsVVGZKRX6VylytNw69A/UVyxVokb+uWoYhXgxC7gId0gucGtbw
         qXn6hTMac9HoQJAU1gSpvvoANI3ftpDGER+FnQtV5m6ZOqU2HTjN7s6UVExuSPtR3dlk
         2K0D1XfOA5wCLsl/QkRCf7hcPEl88prSkHlJ7wXzpdsyIRuGS03idUXkhuvyaf/MG2dN
         uwSAmnP/idrHvE6Yc1mce4eCPCZj0CSZF7VvYEHmFX8fMoMWF/g3fNVM53QoGU7Eo/XH
         5vP39dBb0RLYablFPV6BChEHY/w4Px00r94MCG1cYyn+B7Bt1ks/Kg8VU2trrCKPp/pV
         EKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WMKXC/CrO8TFuSStLrqF4pYNeJ++sg15iQVdB0X3y2w=;
        b=ahMXObUkrCQHEtKze0b+QKnt68iQTuPs3iVbxcqUdJZc7buQTigskZfNibn3eRIFUB
         Z86ewcyvsCGw6i6w1YlPFwzDGNVPdAphJwtbq+/H3PMfWvmjM0yPLarnUT9nbqpal23J
         OkoYQGYXQya4ZfZvcOPBttd/Ez+Kk91w33/G1BfV5HOHa9su0LPi8EmfvkC0c6RD0Bpp
         yPiB7X7jr90xrA8fNCOYmTicWudMy26S1NfF3WCN0Yp4h64OUdM1XzuVxn38qAEJgcsN
         Oc2k4q9JSZePWCPFyxPNcorybHfFGvHIndYt5mUC1d/KD54WiLmJGKpp/QZbQ6fqrDNb
         PJzg==
X-Gm-Message-State: AJIora+OxYTZAwKa9Bz2cYnPCoDe1EpQkFpzZ4vJYv3EQ+38Ifr+DIzr
        Hx6XuSq0uZHrLvAfwKDOfCntWw==
X-Google-Smtp-Source: AGRyM1vwpD/Paz66pDg0ey2IPGYpSQPw9+x6o2VbkWNUAV0qwxZCVsDvMOzyQGXAEgsmZhqeEiBbGQ==
X-Received: by 2002:a5d:6489:0:b0:21d:a9a1:3511 with SMTP id o9-20020a5d6489000000b0021da9a13511mr1683287wri.626.1657523818555;
        Mon, 11 Jul 2022 00:16:58 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c3b08000000b003942a244f40sm9522298wma.25.2022.07.11.00.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 00:16:58 -0700 (PDT)
Message-ID: <b9c97f5e-ca61-ee91-0cb7-a426a921474c@sifive.com>
Date:   Mon, 11 Jul 2022 08:16:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] of/irq: parse interrupts-extended during irq init
 heirarchy calculation
Content-Language: en-GB
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220708165225.269192-1-ben.dooks@sifive.com>
 <CAL_Jsq+TZpAK-X02ANoYBMfUKkwPh3Z-gjGjim6WwFwsMa7zSA@mail.gmail.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <CAL_Jsq+TZpAK-X02ANoYBMfUKkwPh3Z-gjGjim6WwFwsMa7zSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 22:49, Rob Herring wrote:
> On Fri, Jul 8, 2022 at 10:52 AM Ben Dooks <ben.dooks@sifive.com> wrote:
>>
>> When the irq controler code works out the heirarchy for initialialisation
>> it only looks at interrupt-parent properties, but controllers such as the
>> RISC-V PLIC use a extended-interrupt property and therefore do not get
>> properly considered during initialisation.
>>
>> This means that if anything changes in the driver initialisation order
>> then the PLIC can get called before the CLINT nodes, and thus interrupts
>> do not get configured properly and the init continues without noticing
>> the error until drivers fail due to having no interrupts delivered.
>>
>> Add code to the of_irq_init that checks for the extended-interrupt
>> property and adds these parent nodes so that they can be considered
>> during the calculations of whether an irq controller node can be
>> initialised.
> 
> Isn't this already fixed by commit e91033621d56 ("of/irq: Use
> interrupts-extended to find parent")?

I didn't notice that commit, have been holding onto some of these
patches whilst sorting out permission to send.

The only thing my version does better is that it checks all of the
interrupt-extended contents so if there was a system with multiple
parents then we wouldn't consider them.

-- 
Ben

