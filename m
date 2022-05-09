Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DB351FB66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiEILlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiEILli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:41:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CAF20CA53
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:37:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so18992279wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gAzu2oiPvwqDB6ep9R1plS1D4PVcvCYJK3SA9c2e6ws=;
        b=qqvp+rBczXImCRA7dY3ksVgcIYOoCRNkhZh8dUkwnUaE6zBq3kosz6kzlRPsVtkrVh
         fi89vQWHfCtzTFSSPcI4qGrHmmqQqZp3Y1xdSPOMzj/XttPjPsSdT0uMiurDKkT+CKry
         wcmLg42/Gp4QeLb8uSZ980jvJ6fytVkf3554JhzfyR76MceEHrfSLWis3M/RMqpr7zbT
         8ooy880qikdpMxCfg+89iBm9iawogCICZCIrAGzXcX+f0lxXtb0uW6+4QdhcE3dXLViO
         Svcwj7x7To+03kEZVSxEIE6W1481+u4l9/e4xJG4TsSrKwMCy8G5JaW2OhZg5A1qRjUA
         TuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gAzu2oiPvwqDB6ep9R1plS1D4PVcvCYJK3SA9c2e6ws=;
        b=5x/lvfauErGXRlSPzsv8ViemeJdrQdHHbTiU5PDPCtHNboioyjNOXpvJeLBKZ0UvoT
         hYqLSTydxbOSJqKajWnT/VDJO/dPRMx0t0PoPUyBs/urt2J0wU7FpfXAjYadkseFZ989
         FodmFhBDYhaVD7nF6cvEgQFXiB00nsPPHpyrRbnmGkYBJlnncQ+kiKNhlZMrtIehVeEs
         7ISiWBqEKeAe7eaxkL4guIc8lY9RfbhhJf6NH2UXGoJV67oY8RtqXrBFbj0XJ2a+NYfv
         U7MIe1OMpF5DsVMmmIaeh0nckA9+RolAP5M8WM9DE5SyxXV4KYv9fZHjnbajsriok7bA
         o3dg==
X-Gm-Message-State: AOAM532G7g7orM2sou+pIQVJFkFXiC+qQ6+I8yXwbSFmpdSfrFeG0jlU
        VR0s8bsLFjXqf4eXn3OP72POJQ==
X-Google-Smtp-Source: ABdhPJxC9fqJgM9+wwtN9ii5TWwn07S+AweGvci74XJz8sCoa7YTp5luuS887vQ/F30mfWkuVpSA9Q==
X-Received: by 2002:a05:6000:1681:b0:20c:5aa2:ae14 with SMTP id y1-20020a056000168100b0020c5aa2ae14mr13246647wrd.443.1652096262849;
        Mon, 09 May 2022 04:37:42 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id az11-20020a05600c600b00b003942a244f3asm15270053wmb.19.2022.05.09.04.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 04:37:42 -0700 (PDT)
Message-ID: <0972c833-432d-a850-958f-0d4f482e25a4@linaro.org>
Date:   Mon, 9 May 2022 13:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/7] clocksource: timer-npcm7xx: Enable timer 1 clock
 before use
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
 <20220508194333.2170161-3-j.neuschaefer@gmx.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220508194333.2170161-3-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2022 21:43, Jonathan Neuschäfer wrote:
> In the WPCM450 SoC, the clocks for each timer can be gated individually.
> To prevent the timer 1 clock from being gated, enable it explicitly.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---


Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
