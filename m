Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E0050361A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiDPLAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiDPLAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:00:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435425A0AB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 03:57:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id n17so6969426ljc.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6jmuQhxjlZyaiauhW3ksOezxG0CdP/I9NiSXgA9JK6A=;
        b=p9igy0WaKtSgvuM+Vgjvowr4iI6JukewIbViqym/RUaHaxUjLNcApkK1uFMcKOYB+K
         zMhSO3mN62uEcOSXDNzz0T1385ojs0ofa/sbBx66yOUepc5GHMdOPCkmVE8vU7fCQTc8
         oXwEMaz9+PEhKLqr2+4PaRyDX2VOODXplZWMLp5AXIPEJl2/GzdEZ0HUoB7ets+eu9mU
         wdXn4/fU/EE5ML+U+Hcsor+qwOYHJ6f+32uWmYsIGzVmCRApvmCRou/nwAiVwohR9gvL
         RTTJoarhVenZx9XiB47cgm1wHEatLKcQRFh1j/SZsGJSZ9BXurXsFE8l5tBI8i5YM5E9
         DjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6jmuQhxjlZyaiauhW3ksOezxG0CdP/I9NiSXgA9JK6A=;
        b=jjzsR/YuSs9CCbVr7FdMwtME+CNI50mUgVWvllnq0hWVLsCsrGueJ19t6BgIEKmpmw
         mOK4l/DAStZWO4gbN7nwfU9a5f7Msjc68HOR+O6CEVDxBqRMaZMUg9XVot5C8RiwCR8F
         abx+KXmvlLNBjLH/6aQg2Q7E3kZCn6wGF6tv0a1niA2Lu8kiO2nxIwKKDwyQSIeX62M/
         y9/hRpcoGWOuZ2amUCDuCYnDNEZXWgTSGDdKFOJ9JWSH+TKOvXfSvZdCQjJmmIiyaLt1
         1+oPa4ZUXO+2abClqNzoq6Vbs3f3vcnBpOrCFz/aGXVXUCg19a5VER/Hb1/0ckc6mdZL
         6yuA==
X-Gm-Message-State: AOAM530GO0btBNx9Fjksss8yMRFpDOmBY/J2rJCFoum2RnmOs9J4xAum
        /7WAPPpywW/FMOPbkT8VYLg=
X-Google-Smtp-Source: ABdhPJzQyR4FP3VLblv2z4wiz/PPqJ2Ndjvb20TUlZYYDW6Pceo9/rpNrzinvXXid0O+WFh9VOyHeA==
X-Received: by 2002:a2e:9101:0:b0:24b:27c:c210 with SMTP id m1-20020a2e9101000000b0024b027cc210mr1858659ljg.134.1650106655322;
        Sat, 16 Apr 2022 03:57:35 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id r18-20020a19da12000000b0047022f82509sm239361lfg.238.2022.04.16.03.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Apr 2022 03:57:34 -0700 (PDT)
Message-ID: <5d9181be-0a02-0623-7741-1d4352d62610@gmail.com>
Date:   Sat, 16 Apr 2022 13:57:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: rtl8712: fix uninit-value "data" and "mac"
Content-Language: en-US
To:     Wang Cheng <wanngchenng@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220414141223.qwiznrwgjyywngfg@ppc.localdomain>
 <68484555-f763-bc42-eb4c-9cea2ee8dadb@gmail.com>
 <20220415095741.3zfuztivtgidvpqc@ppc.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220415095741.3zfuztivtgidvpqc@ppc.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On 4/15/22 12:57, Wang Cheng wrote:
> Hi Pavel, thx for your review.
> 
> Sorry, this patch is just confined to fixing uninit-values with
> modifying the original code as less as possible. It sounds good to
> refactor r8712_usbctrl_vendorreq() with better API.
> 

I understand your idea, but this will just hide the real problem until 
syzbot hit it in different place. So, I believe, it's better to fix the 
root case instead of hiding local cases.




With regards,
Pavel Skripkin
