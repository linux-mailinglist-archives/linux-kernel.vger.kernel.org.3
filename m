Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9960759566E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiHPJbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiHPJaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:30:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED5C124202
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:50:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z6so13710923lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SsFQ1RIKNiJVmQ5p1REhokCaS6zA2xCDkzmoDwE4rX4=;
        b=C0vovSaBtU3Al/+uuR5jDDnyI0+U1TP282RQhz+GQNbnU36bQz68AnK5kXLHecmF5A
         axOm3+W83f958RvgYeCKIkNS2glYVCYOrnGKMtcBNOEjCW2uEZGCp/UIoq7k0PGgNCe5
         IaLDe0R3RR1+G0S1Ta/V8OGoA+zrMQfpq/kxlJLuwZ59Ta0nAWPVpHdpCdi34td8WLod
         +0DGSh8mHtK0ro69ztI/vT43EY7+SsTZHhb8LaHHU9qoZHW8097OXTkZNeLHKhY9DQnA
         5xW1kRi7YOtHwZRwFAanL8RrpAUc+Ty/vJstUKxz0zzGyY1L13nix0HgOmjzc9TIGFxx
         3pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SsFQ1RIKNiJVmQ5p1REhokCaS6zA2xCDkzmoDwE4rX4=;
        b=QJjuaTKfpRzARRwOmVEtDAW7pAT/kzE9bUEE/j6H2cotUBBKQgUenl4IfSoN8F3lcK
         49RpJZUvm+gBHbRVZCmSmsEnHxZEm4bd6uipGeX/v2i72lhlP2V2CVqYylBtVucbq6hd
         o6NZn6vQ0xGfoQjNh6YpTihNpdd9hPkzIhBi1z7K571qA77375zFp/lUp85g5ZCNIDAP
         LGPdTPnpmCKYxIAyuMeTcOUlnBjLDHZJGVCXVBlqAcamarqcUonq4WUah1XwFARAxqmZ
         +X0U/NVFt4CvK9ToWnF03bwaz3kWCwJ26aN5qMzFqGclBo5tPOzDX9U76IC0ZMtf2hK/
         iZDg==
X-Gm-Message-State: ACgBeo2XV6ZEQnD//o/ZqKqLatp2uQVErtekyxtf94o0mI/Ru6B32Ju+
        Z7K6BMafJuGSR93YSbJSzZkpdQ==
X-Google-Smtp-Source: AA6agR61EpgIZo4areU1VwiZwwTCgopZu+2bI0uZ3goHpEzDHA9edBrmuCgn1s1AR0GHg0VZ6JjiWA==
X-Received: by 2002:a05:6512:1050:b0:491:dda4:1e2c with SMTP id c16-20020a056512105000b00491dda41e2cmr3973398lfb.467.1660636256607;
        Tue, 16 Aug 2022 00:50:56 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id u11-20020ac258cb000000b0048b13d0b896sm1308697lfo.141.2022.08.16.00.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:50:56 -0700 (PDT)
Message-ID: <c547ac5f-e4e8-d043-22bf-626cc580a69a@linaro.org>
Date:   Tue, 16 Aug 2022 10:50:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add PinePhone Pro
 bindings
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     martijn@brixit.nl, ayufan@ayufan.eu, megi@xff.cz,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <20220815123004.252014-2-tom@tom-fitzhenry.me.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815123004.252014-2-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8
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

On 15/08/2022 15:30, Tom Fitzhenry wrote:
> Document board compatible names for Pine64 PinePhonePro.
> 
> https://wiki.pine64.org/wiki/PinePhone_Pro
> 
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
