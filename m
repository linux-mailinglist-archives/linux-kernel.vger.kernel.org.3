Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613AD508D79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380492AbiDTQja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355833AbiDTQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:39:28 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25C646641;
        Wed, 20 Apr 2022 09:36:41 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id r85so2650954oie.7;
        Wed, 20 Apr 2022 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=LtN43ptZpChL4HMkRBH+p5UBu3nyeujomu6ywnqweqo=;
        b=P6g5wUYRUG8UiZJ8dZavDPfe2M/RqtDZtCNXdLkxvUmcG+YoJTaZY4JbhuCtUH32im
         ExwfFrDfPDa+LMYF9j4M4Pmanf8UoCF2EmVpmNxtlJ57o2IXYpmiaL/Lp1yKTDUf6A+f
         Hq771sDtxJp8DaaWauAKy87qSCgTxpWIX7uVgUkvSNcG6bIX91p9ZwAh0YVnt1Oro6qP
         i9lgm2X52Ym/VoDRzdUn8vOUW0Lvx9TGui5tLQCjeuqex5WqXe6sPUPohNj9IPBFJtqr
         C6dou/1TGPsj1gMazbJuLiEu11ZEvpqelchzYijVZVriK1yDAfmzjxmumfoeMG9NMRvY
         cvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=LtN43ptZpChL4HMkRBH+p5UBu3nyeujomu6ywnqweqo=;
        b=ApZluiGuNODya3N8OVxtzl532yYtZtP89HlzSVxomEccJzbHsnUoMvbGtDLgUCeQhH
         SW32ZAgkilYDWYKmxoD+2QvZ4fpWKWReq0zZhJ57/MTcZ7kv/ERNL9txIm4spfjO3naQ
         pCEJZetFimX0DcHPDxRo4v2jU1HPozFFieF5BpbAqVeMqGjZD+sbRi+s73S8mGJmw94k
         dZNO5YGbRYdIjU52jvCg4AX4ngIByg0hT/3XD3y9ionxs2MfuSrfQuNuTDrW6Mye+2bk
         Ui5G9fk1vuB6dpiCIAKqY0PZGWPWzTcZinBlRva5bgjasf79iYp2aUS5GKbhm1/Wy5Xx
         1rMA==
X-Gm-Message-State: AOAM533xZm4yZo5Dh7HXGK/qeyE8ZEMEwbsQ6UkI/cPMu9htj7JIiXlJ
        T5PuLEj8IVOjC1/RJQ5QUCU=
X-Google-Smtp-Source: ABdhPJyWK1OsNQJdBQphXe2m41cnqxM5TA+Lp+s8MD2wHqs6yEGUplyXE/PnSGsdMPYIYWg+Ebd8HA==
X-Received: by 2002:a05:6808:1590:b0:322:a515:4624 with SMTP id t16-20020a056808159000b00322a5154624mr2191845oiw.164.1650472601049;
        Wed, 20 Apr 2022 09:36:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o16-20020a4a3850000000b0033a3c291f3esm4031024oof.40.2022.04.20.09.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 09:36:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d84f994d-e291-84d0-5576-571984cf5018@roeck-us.net>
Date:   Wed, 20 Apr 2022 09:36:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Harders, Nick" <nicholas.harders@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
 <20220420150156.47405-6-nick.hawkins@hpe.com>
 <7d039d13-8512-29a8-31d1-48284d561bf0@roeck-us.net>
 <PH0PR84MB17181A87E72D66C7F669F90288F59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
In-Reply-To: <PH0PR84MB17181A87E72D66C7F669F90288F59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 09:08, Hawkins, Nick wrote:
> 
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
> Sent: Wednesday, April 20, 2022 10:53 AM
> To: Hawkins, Nick <nick.hawkins@hpe.com>; Verdun, Jean-Marie <verdun@hpe.com>; Harders, Nick <nicholas.harders@hpe.com>; joel@jms.id.au; arnd@arndb.de
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>; Rob Herring <robh+dt@kernel.org>; linux-watchdog@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
> 
> On 4/20/22 08:01, nick.hawkins@hpe.com wrote:
>>> From: Nick Hawkins <nick.hawkins@hpe.com>
>>>
>>> Add the hpe gxp watchdog timer binding hpe,gxp-wdt.
>>> This will enable support for the HPE GXP Watchdog
>>>
>>> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>>>
>>> ---
>>> v2:
> 
>> v3 and v4 changes are missing.
> 
> I considered this the second attempt with a valid patchset but I will change this to v4 and add v3 v2. Should I make a v5 to say I updated the patch message?
> 

Sorry, I can't parse your statement. If there was no change in v3 and v4,
the change log for v3 and v4 should say "no changes in v3 and v4".
If the changes were made in v3 and/or v4, the change log should say that.
If the patch was added in v2/v3/v4, the change log should say that.
Either case, the last version in the change log should match the version
in the subject. Reviewers won't otherwise know how to match the patch
version with the change log. They will have to dig up v1..v3 to compare
the versions and find that out what exactly changed where (and why).
In my case, that commonly translates to "move patch to the end of my
review queue" because I just don't have the time to do that.

Guenter
