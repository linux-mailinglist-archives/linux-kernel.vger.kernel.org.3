Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E27533070
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiEXSbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiEXSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:30:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CD57A83C;
        Tue, 24 May 2022 11:30:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g184so17014190pgc.1;
        Tue, 24 May 2022 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=62oZybgFBxJptBg4w0Na6gq9SY8Uv4M/InFJNbcHhmk=;
        b=VqJQMqdAxeBonlch9i3vHMiugUkHlr9s+Xb5tHFiBx3q9rCtF46NjF73GdAqmImMrm
         8ntyEeZeWjALovaxhWhvgoDKkcE3K8ngjvxaF/J7Q0j6R6/5VjeOY/L8wpSxwr0cwRPD
         FgFhQAldBMml51lQcLdtyO/9NRsyAeJTlyZB6Jmin0/i3tgip6fbqvq3+lM4/m7pw0b+
         fuzRF1/kxwnk4dEu6nwuFZPa/93ipcP9sKJmpGsYyMptT0pnSYH0/xZBV/uZRw5k3Utk
         j7kCKdPBgnsxn3sUh24EbW7l5LO2uVgiRzp5ifdV/Tu1YczHc5C2NmadUJEFGZmRR70N
         EKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=62oZybgFBxJptBg4w0Na6gq9SY8Uv4M/InFJNbcHhmk=;
        b=ONprRaGF63xMOLdJPofaSxnei3jqA3cpaosdjZRAb936yd4cVkb7EnXrdNKXtvOEBv
         p05c39XqdXBhRExVb7XoCyAd1Ughea5AvFMwmsKXWR1vHtk1SE6DRgc6ZI61as3lGX69
         6KtqI0YOcrsGNE0i1h3Hd96TD1O9IB2zPXHyWYdUtIFmXCWOqI5k/qAS4iHUH87AHtnI
         yAbgzzoyijWhwwCwAL0YJUvDPGd1WmuZjoYRMD96kNGU5OMJNjoAr4g6lrGAR4nesfHw
         115RzfcXPQnOOWRHCyBABggYpDZVJTYwycom1YzvFsJFUGF4J+LZWAi/U8rr/YElUoSx
         n5kw==
X-Gm-Message-State: AOAM530t3YohT2pF2fnnr1Sb4vYaSrOdZ6OQzZuL+zWtn53ZSpfj6gRM
        hch4om3WklPALIgubh19eaI=
X-Google-Smtp-Source: ABdhPJyQzpaNFo2nczBx1uzo/ZblhzifGBeJX0dd5t9EA8B0X9nDFpCRi45dZpj58OKrvnw/ibX4YQ==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr29526928pfl.38.1653417055980;
        Tue, 24 May 2022 11:30:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p9-20020aa78609000000b0051878e8cc13sm8091200pfn.116.2022.05.24.11.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 11:30:55 -0700 (PDT)
Message-ID: <b567d6bd-b563-f696-60f2-0fc36261d094@gmail.com>
Date:   Tue, 24 May 2022 11:30:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] MIPS: Rewrite `csum_tcpudp_nofold' in plain C
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.2205222035380.52080@angie.orcam.me.uk>
 <7682977b-5929-890a-3a18-662fbfcede5c@gmail.com>
 <alpine.DEB.2.21.2205241811180.52080@angie.orcam.me.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <alpine.DEB.2.21.2205241811180.52080@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 10:18, Maciej W. Rozycki wrote:
> On Tue, 24 May 2022, Florian Fainelli wrote:
> 
>>>    I have visually inspected code produced and verified this change to boot
>>> with TCP networking performing just fine, both with a 32-bit and a 64-bit
>>> configuration.  Sadly with the little endianness only, because in the
>>> course of this verification I have discovered the core card of my Malta
>>> board bit the dust a few days ago, apparently in a permanent manner, and I
>>> have no other big-endian MIPS system available here to try.
>>
>> How about QEMU is not that a viable option for testing big/little endian
>> configurations?
> 
>   Yeah, for this particular change, sure.  I don't have QEMU set up however
> at the moment and would have to take some time to sort it, and it won't do
> for peripherals it doesn't implement.  The failure is a fresh problem and
> I yet need to figure out what to do about it.  A bad coincidence I guess
> as I have MIPS hardware 10 years older that still goes strong.

If that makes it any easier, OpenWrt has 4 configurations of Malta for 
QEMU which allows you to have at least networking (relevant here) for 
32/64 and le/be:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=tree;f=target/linux/malta;h=90b2913dec291a1926eefc332b90b5842746c6e6;hb=HEAD

Along with a readme file on how to start those platforms:

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/malta/README;h=bbe806de3d6671d69ecc3db0fcfccf9f9176de13;hb=HEAD

It's really easy.
-- 
Florian
