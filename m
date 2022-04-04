Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89184F0F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377422AbiDDGa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355250AbiDDGaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:30:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27276581
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:28:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d3so2031857wrb.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 23:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F18H9mro7XZlJ63rYvhg0QoIzVvlFGRUClKbuycY1zI=;
        b=ybw9kPhcs/vvj37VHTM6JWCD2qPVOBO6c+h1NWPlXheagtEl4lSR7obAjJKCZXXjy0
         LK5mb9M/cESlUJZnUzRyPQ1eomsfO687RS3OSVeaAa1TOQeKGEstQ7UtQDEBXrJLWjaV
         ITIXKzMy0oAeBNFDyZtpOu8syyoWXceX/E1y7khJRtxdUqIHDW5IBoVS9msUeM7mf/hq
         kanOP7CDm2DjvegWU4Boh6IgVCVNMSnNHP5tf47ODMNNPR3J5fgVenVrnAiREyNkAP9z
         MpqK8gnhBpnujhubYj59z8GnHP5TPlRCzGq56bUzixfS8m5V35qKoHZeZeJ5zGiJ4l/W
         aTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F18H9mro7XZlJ63rYvhg0QoIzVvlFGRUClKbuycY1zI=;
        b=YOUVI9B0D2jDY3u9vUhvn+0HnGHwIBD7DhhTnpkN7QlpM87p6E2UL7tyF3Rhayw2L4
         Kz/TGEbbw6/koqSr/3mORVl55BRyUcyArBHxqxcKdxtyRmUdMxApSDx3mWP0QoRF3sN+
         7VZnxJ75PR9i7vKN6+RMqxkPFQqxHQYAtbh91anqOGPTIt9RG3MVEo2HWojMbl/CKCWO
         q3AzxDoWzC9totIaoPzspdLzRGJiP7NMT5hxMBR2oxq38y1pCfWVQRwHboOPwGkYpB5K
         rKCwWDCUdN0+QtXO+131kTEXDeUI180W1UfTvYk7Wd+U4uHb8Ajtcp7j6UfhbpgSbVQ8
         o1Yg==
X-Gm-Message-State: AOAM5333rNNgpURJA6flLjAVgMzX/CiY9P2XccyqxyIg787Hij8T4DC+
        v412OQVigzTXus1Hv468aiKmDA==
X-Google-Smtp-Source: ABdhPJxL4YYPEaBzk67vUcT3vxfr6uHYgpGZk8Je1DcAg1MbalILzhyX8FdoGh+lE7iKa3y9LSe+OQ==
X-Received: by 2002:a5d:4302:0:b0:206:4b2:8690 with SMTP id h2-20020a5d4302000000b0020604b28690mr7072357wrq.224.1649053735582;
        Sun, 03 Apr 2022 23:28:55 -0700 (PDT)
Received: from [192.168.0.172] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d5912000000b00205a7d0c6a3sm8335123wrd.69.2022.04.03.23.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 23:28:55 -0700 (PDT)
Message-ID: <bf02f917-2c3d-f098-0d34-fbe664d40433@linaro.org>
Date:   Mon, 4 Apr 2022 08:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PM: opp: Fix NULL pointer exception on a v2 table
 combined with v1 opps
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220401120325.820763-1-krzysztof.kozlowski@linaro.org>
 <20220404062618.jtqlb4cfkerctpas@vireshk-i7>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220404062618.jtqlb4cfkerctpas@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2022 08:26, Viresh Kumar wrote:
> On 01-04-22, 14:03, Krzysztof Kozlowski wrote:
>> dev_pm_opp_add() adds a v1 OPP.  If the Devicetree contains an OPP v2
>> table with required-opps, but the driver uses dev_pm_opp_add(), the
>> table might have required_opp_count!=0 but the opp->required_opps will
>> be NULL.
> 
> This use-case isn't supported currently, as either all OPPs should
> have required-opp or none. This kind of scenario may end up breaking
> at other places later on, as I have designed this stuff with the
> above assumption.

I understand this is not a proper use case, but it is easy to trigger
(UFS driver adds opps manually, DTS also adds one). Maybe you prefer to
handle it differently - exit with ERRNO? Because NULL pointer exception
in case of proper, but unexpected DTB is not a good way to handle it.

Best regards,
Krzysztof
