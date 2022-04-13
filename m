Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB54FF442
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiDMJ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbiDMJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:59:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA356400
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:57:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bg10so2851569ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BoRyXJyiezioU86Sm/aljGreuf33ZfT6BJLzBNsYxXg=;
        b=omhuFPP17o7WmTkQEZ/ey1v3Go+8BL8tjJxT4U351QG/ra9Bryv3m3VIz9SPeHTJ17
         jCw/SE//G3phX7o7tXLoRgKcoX4BSJ9PABjI9xQCFfe6W3G4swybnV3G/h9LsnOdLbwT
         5fagV3p66C2I+jC4xwGmJolqwcFge+Ye4XnAndQ37sv6VLhVJSNCl9h8uNrA5FsAHPPa
         FHzmSsT6IsXqjyoO/7HBo4+CLfRCzPbqWXRse5r+JNQlmAGCgbB2E35s3laF1+fuCL82
         tkCC1kZSg/JtVprV+SxonH1pDFjrmnVdxcygBf88gFWybmaonjF9JtnH6Rq8hQS9fQ6F
         v/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BoRyXJyiezioU86Sm/aljGreuf33ZfT6BJLzBNsYxXg=;
        b=UVqPReEi9dUPeMqdCk6QICnfWOnkl+ME4HMJtv4DMj9Ex+wAjDkwv4AnVGJiriNU1r
         RuZTnxWBgRjFsIKdYWu1Cjekfkvn09u4lsbNoyz8vDfhCiTRcG85vnAD/IUmkh1O4/55
         jnAHwNDcI5qkv9a/5bTvPQH+jBYtnYTDDQazV63iHzmhMbz5l/l092amF6vhf+9rleu6
         0z0XDSRAZyQOx8N0+DZM4o1u8a6twpGy8F4RPqYwyMPQ8UYWb0hyn1Z+tzWk48QmPpo8
         jIVMfCHPJPayadgwMZHkynH7bOTDkOyOkXn7X7C0I6BhRXjTXTRx3Bd6T+nmaVGDx3Pn
         NTmw==
X-Gm-Message-State: AOAM530s7oE62G734BVmooGywiBR3REORkPDZO7QgtVvSqeXcQmvH2mV
        g0mboSxBaFc0aq/ehsCYo0LRRMPaWOlUvR8n
X-Google-Smtp-Source: ABdhPJy2fHjgfklx0Z5VlYqV/vz9vbavseCTQTpvw3q5LckX8zitbG3juuiHqZrfjR9BZ7vSaecpgw==
X-Received: by 2002:a17:906:19c6:b0:6ce:98a4:5ee6 with SMTP id h6-20020a17090619c600b006ce98a45ee6mr37493225ejd.567.1649843834448;
        Wed, 13 Apr 2022 02:57:14 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id w6-20020a170906d20600b006ca00cb99e0sm13883293ejz.34.2022.04.13.02.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 02:57:14 -0700 (PDT)
Message-ID: <1a12abfa-3459-18d8-5214-221f5184a9cd@linaro.org>
Date:   Wed, 13 Apr 2022 11:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] phy: samsung: exynos5250-sata: fix missing device put in
 probe error paths
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220309170028.51913-1-krzysztof.kozlowski@canonical.com>
 <YladK4z//z1hmTRX@matsya>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YladK4z//z1hmTRX@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 11:51, Vinod Koul wrote:
> On 09-03-22, 18:00, Krzysztof Kozlowski wrote:
>> The actions of of_find_i2c_device_by_node() in probe function should be
>> reversed in error paths by putting the reference to obtained device.
> 
> This fails to apply on phy-fixes, pls rebase

You applied resent version, so you can ignore this one.

https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=fixes&id=5c8402c4db45dd55c2c93c8d730f5dfa7c78a702


Best regards,
Krzysztof
