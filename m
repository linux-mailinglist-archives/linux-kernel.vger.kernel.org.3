Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B826A4B5776
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347981AbiBNQyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:54:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiBNQyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:54:12 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C94E65151
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:54:04 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ECC323F1AE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644857642;
        bh=Z4S/EJbvQ1weqsHWE/JQuNYq7y3Ue8zFIgR4/tFO2mA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=J0qkiwb6AibsOrSjn/aEavL3of8cxZDZue0oxMGcMbYUUqHCVMjWfyunYxmlUqho4
         1weusaZwbF42fsAd24g72p+sQDNXg3JGt4xJC5dXGaJ2CgjEp70LHdPLCYtgw8gqmZ
         Ehnhw/LfLy+rqLw8NiJMZw4Aat1+jB8/VtqC9xhvH5aD+jA3SdPYtiXck2Xtg99ZPW
         atpff4/eP+lNEWJz4SC17FiM9Cgs2ptWBoNJJKQWxttz4k64cs313j1C1EE/fj6QxY
         WymKBKH0BNoOVsH1RF8QfKQ2HqINbRcZtQFmeSWQ8MNjlJEhPEemOiSDdvOz3ymGzT
         UcE3Ameh4aJbw==
Received: by mail-wm1-f71.google.com with SMTP id r16-20020a05600c2c5000b0037bb20c50b8so5243674wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z4S/EJbvQ1weqsHWE/JQuNYq7y3Ue8zFIgR4/tFO2mA=;
        b=f9MF7lIcKHCVvjt4dR/sWoDh8q51LODZL5iK+j2UX1RK9Y84zqj2sf5/3XfsOZCLr2
         C8/JNFkIGYScO5Y7xXRptSXY+ydns5o1h8MBeZZP65lGxQFp45PbfE5hBuyZ+cLqkfnx
         HJiBrC4DhOcutoljtVXYA8t5vJefM6i0WzT92aPSf98jA8uVYiwQHit+M2XIxGeaBxGX
         lilSM4I7d7PxQ87efUyEvSfkKBTNbvBCXOIMGZ8Gcx0mXLRvIIcWGoQj2OICfrm6YO+X
         Nq55XH9zJ4ASsNLZH949+uga/uHbJfInyuYpUuMzmv3xwQVqVhlp7yIP99Yfyc9HNDdJ
         J66g==
X-Gm-Message-State: AOAM532D/A0/P6XTEsMfhszgbd1wsp2gzaW1Ah4rNNSuyKFigiLeWVRR
        ApLl2Z3gSE9G8mEbS9lTyjlL6XE7ZKkN1yFAMle+WfMev/l0ej4eA/UfdNgQuoG6NpH87DHm7Fh
        h3Ff3kra1TDCCcemodQW/MCpsTYeo5hjST5kA3LWfqg==
X-Received: by 2002:a5d:4485:: with SMTP id j5mr406252wrq.495.1644857642743;
        Mon, 14 Feb 2022 08:54:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSf3b2QSKeODIAdKKEC369EQy5hjdyp/pGhW6kuWrBv4X2cL2F9qX6q7z2Gv0yC52ifPjbYQ==
X-Received: by 2002:a5d:4485:: with SMTP id j5mr406243wrq.495.1644857642592;
        Mon, 14 Feb 2022 08:54:02 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id y17sm12488792wma.5.2022.02.14.08.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:54:01 -0800 (PST)
Message-ID: <79ecad6e-d9c9-c798-0933-43da4dff9dd6@canonical.com>
Date:   Mon, 14 Feb 2022 17:54:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max14577: convert to
 dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <20220111174337.223320-4-krzysztof.kozlowski@canonical.com>
 <YgqGy7a/kq2+jZQm@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgqGy7a/kq2+jZQm@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2022 17:43, Mark Brown wrote:
> On Tue, Jan 11, 2022 at 06:43:36PM +0100, Krzysztof Kozlowski wrote:
> 
>> +    required:
>> +      - regulator-name
> 
> Why is regulator-name required?  While it's a good idea for users to
> document names for supplies on their boards it shouldn't be a
> requirement or something that a driver would care about.

Indeed, there is no need for requiring the name. I guess I copied it
from other schemas.

I think this was not applied yet, so I'll send a v3.

Best regards,
Krzysztof
