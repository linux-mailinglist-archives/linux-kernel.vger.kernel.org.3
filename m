Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4F4DB625
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355606AbiCPQaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiCPQaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:30:07 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E7E53B58
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:28:53 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 691503F338
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647448132;
        bh=O9azuf7ICO8h5uyN+uYKd3/hmAqYJNPc/YeUIk6IvOY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Q0qgCv8g85usPyzQsDtGgDFalJ7TfoRPzDbFubrVduaO+EnSR+Jwmho7GLJBT0her
         m2eVXmy2o6L443/C8vl81t9iWwgM8obJMbAfXS76tirzzcbUlK5DXTiZrQO1Ar5oPt
         74qqjrdoPuO9b4cjO9PjBSiOMv+cuayW1niULMz2Ypw5LEgo95ozpwDRFUvmHkjEUH
         P1IDwxi+JJcabZhL/vI1NBq6fy4TXvZ4v5l89off3mcM4d2xRD27ezXXid8LKFHjwG
         g+gczEkKmWsctrK7Bm0tEJYxwggi9AGbIglwWvErO+7hig46FduXvlgo7hWlMcDn3A
         DHcDtwHL5L+iw==
Received: by mail-wr1-f72.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so725811wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O9azuf7ICO8h5uyN+uYKd3/hmAqYJNPc/YeUIk6IvOY=;
        b=Xn48X8f28XaOITFI68PmT9lPmkIUmCvlZfCTC7iMZuEoAt/N/+sZE606shfZ7Aj92x
         eeK12ONFYIdzkyDzQzrGlVmOlZyQSAsmeUSH8dgTXau1XroJa/9fDyGGpGc2pguLVQD3
         UzM1lIich9UAcX1oKcuAq5oVUgFvmCgGpOslA/e3AS0ILD9D/4M/pgy76mZE0c9Yizow
         3eEp54tgMVQnaCtjHqA+K5nJB+dEm4PDRdFumqrsEVZehtxT6SG0hbozFGGDfdKHzBub
         g7oX8DgTfrPZPBiENeb9sszHifupv7JqnHc1iovWF5SWHJICeelnnzpHhVCC9Z/sITuy
         8CiA==
X-Gm-Message-State: AOAM532ptMlqlEmN2SLonE30tKDsTigoZG9RaZQVj7laqTx0GVm8un4r
        Nn0vrtrCrfTj2+X6BYfGO2tvWQ6JIZA48MqOpW0P/NzdIrA/5gbBJoOHn/gYDGF7sAio1vQP5+t
        NNVgmF7ihQD5J33Hf1WIFRTSGzW1YgBuV+pd06d2Vzw==
X-Received: by 2002:a05:600c:22c4:b0:38c:70f5:25a9 with SMTP id 4-20020a05600c22c400b0038c70f525a9mr399235wmg.119.1647448132149;
        Wed, 16 Mar 2022 09:28:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKAKAWokuZKgPZXqwJlDzsHHWTVsJ9pCwRX+QtYBaOkXVUSCX+5SlHY5BD4mQkdYO5g15k/Q==
X-Received: by 2002:a05:600c:22c4:b0:38c:70f5:25a9 with SMTP id 4-20020a05600c22c400b0038c70f525a9mr399217wmg.119.1647448131987;
        Wed, 16 Mar 2022 09:28:51 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id l18-20020adfe592000000b001f064ae9830sm2007779wrm.37.2022.03.16.09.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:28:51 -0700 (PDT)
Message-ID: <662981fe-7cf4-b0e6-2d43-3f33a53a6abd@canonical.com>
Date:   Wed, 16 Mar 2022 17:28:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] dt-bindings: timer: Document arm,cortex-a7-timer for
 arch timer
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
 <20220316095433.20225-3-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220316095433.20225-3-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 10:54, Kuldeep Singh wrote:
> Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
> conjugation with "arm,armv7-timer". Since, initial entry is not
> documented, it start raising dtbs_check warnings.
> 
> ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
> 'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
> 'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
> 
> In general, removing an existing entry is mostly devastating considering
> backward compatibility. Therefore, document it.

How removing undocumented and unused compatible is devastating for
backwards compatibility? I don't see it.

DTS is rather wrong, not bindings. Otherwise please explain it more, why
DTS is correct.



Best regards,
Krzysztof
