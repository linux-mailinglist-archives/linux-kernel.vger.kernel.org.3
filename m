Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E55A2900
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbiHZOCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245361AbiHZOCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:02:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446AC04D1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:02:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso4480344wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=eCr/Ohj0kZaDpLmya5seSXAptOWWnifNHkRP0hKQPHU=;
        b=q0qzPf1nziC/DQNNLVQLS+/5Uc0MBYAygLzDVbUqGH/1jeVvU3gGjUoeZ+BOZ4o++H
         c3WMDjYshzjJEJlsFC+QdF9+Rt5odJ94r+B4wk+pXrYeY8lRuwQxGr+SXiTaY+J0kqOb
         3+OvtWjevF4RZnx1GlufEIFATNt6jgMYJusBNIfEzhhNvFJep8AKG7OYQiwDh1IvLcCE
         dLTRaM9frO9cjymw9bF2Lo/yW1L+C7Ryfb5Nl01+j7N8ket9PRAWuXMx8IF8zzocMNZN
         G9TJHA2P/fZWgH8pKQVPNHnXU2xbqsbTlH2mdbYojIwqoWzY1xDza1Dy/0wR4mWT/eKa
         sPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eCr/Ohj0kZaDpLmya5seSXAptOWWnifNHkRP0hKQPHU=;
        b=elqDIGo6+f0PYz6d9UiFVQfH5Ci0GwMvcr9EhITqFWKfzjI2Y2TouxPFqfa4Uynn9l
         A6W7Pt3X9yI5aR4YZA/hCCM9+hHR3AHIQ0hJMc5HQTsPe12nBH+duI9K8PClAR7E3Et2
         QBBYv4x06RSYbodvfcsDmd/uzpdTXkSDxE6boGXyoEr08FLc9Ol/YRNQZHEqLpQ4I/y8
         hscvbYC5Z8vRDMSt9hN4XBotwod7rEwqBFzXnFxGr6oGBKpZnyAF1qYPLm5r4FWKvFyd
         irg/Q3ccQQN1JCvGrMZTdRTUanMUSotO/RsfVjAzdp1thBTzdKaYb31Q6hP0GRLS56vQ
         BmXg==
X-Gm-Message-State: ACgBeo1twlZ0c4T0bYNKS/jjaxU25n4fouGJugNJw9eNFYoxvyYnA7i0
        Bjt025vsKg067MjlqMjwbHGmXQ==
X-Google-Smtp-Source: AA6agR7/NSeMRDVgG/yEJTSWQZQkmxXOs1otSi8LjI4tN8VM5kuDlQbvNw8kIMB+wkzE5oVTFW5Lgg==
X-Received: by 2002:a05:600c:1009:b0:3a5:4512:5f71 with SMTP id c9-20020a05600c100900b003a545125f71mr11571178wmc.134.1661522539663;
        Fri, 26 Aug 2022 07:02:19 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id bi24-20020a05600c3d9800b003a4efb794d7sm2850243wmb.36.2022.08.26.07.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 07:02:18 -0700 (PDT)
Message-ID: <ac5d557b-ca4e-3e8e-9956-c6c5754fe5a7@baylibre.com>
Date:   Fri, 26 Aug 2022 16:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/4] thermal: mediatek: add support for MT8365 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
References: <20220720181854.547881-1-aouledameur@baylibre.com>
 <20220720181854.547881-3-aouledameur@baylibre.com>
 <67796aa8-6509-620f-f96a-ff22218f1b0c@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <67796aa8-6509-620f-f96a-ff22218f1b0c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 7/21/22 18:37, Krzysztof Kozlowski wrote:
> On 20/07/2022 20:18, Amjad Ouled-Ameur wrote:
>> From: Fabien Parent <fparent@baylibre.com>
>>
>> MT8365 is similar to the other SoCs supported by the driver. It has only
>> one bank and 3 actual sensors that can be multiplexed. There is another
>> one sensor that does not have usable data.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Just like in all other cases - you miss your SoB which is necessary for
> the chain.

Right, will add my SoB in V3, thank you!

Regards,

Amjad

>
> Best regards,
> Krzysztof
