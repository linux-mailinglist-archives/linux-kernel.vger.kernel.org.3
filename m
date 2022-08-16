Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD359565F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiHPJ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiHPJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:29:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EE0D1E15
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:48:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v2so13716603lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=yFUBgz3pK9QWwSbzGCfInZAjRCTvtg/IqzHSqSibfcQ=;
        b=xnI8Hz/2eFboCj+I/E9Q3gczZYmeokZidCXOP6RRvwhoBE63XLgs6sWYGFqMc3NLYp
         8IyN6HZvy4oiy+xSyyUGVc7AGKp+8SnlqLcGF+6KnqhtkaMwq8njFwmRjwro2nUIIZQ3
         kcmbV3vSzzuy/+hl+zh1kVaNuNnQgEJokBzCBAFXXSNGVne9r7ccDJ6+u0nGQIUTI7ya
         /b4Ra6OiRwTP1Db0vRF9+1HEKoO4Gn2LO21wiBzYZ98erHndtOn+Hz/6dwE+Bnuvy9OW
         peXDzW9csz6gfL5NIoWLpXArGX6YFSBjeGWFyZl1/iCmLV7Imy/B2Q6d5ik5k6+iu/oX
         rrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=yFUBgz3pK9QWwSbzGCfInZAjRCTvtg/IqzHSqSibfcQ=;
        b=Ei5XsK+zQnPQ7PVxVJMGBFJR+tislhsz75pbcEQvitlxcw8TNwxPbUKsIuDJfgkAoL
         5Lmia8yNAkfI9B9OiHycaAIVczp2W0tbo7HST3HLv+rQ1HU1UOPk1NyHLwXMezOl8ZbW
         gABk4VqVVWKacRfOS8lcOw7tEWhaVygD9iPP0+KoX5JQ8e0a8uXzWxqPD2kycKkixs5+
         SmwGssoCjjcMNhP8NAPMYDCRc6OODO3ltzq8ptUp6O2l69ahZkJM3ETg6z6XiOtBhokG
         v7r8v6zifz+1JruERMQXFmcyrGcTY2yP7kXqI3KR95GWnc/bJ/U4CZ/I4UT4YTMWBBCE
         Z3Og==
X-Gm-Message-State: ACgBeo2ajCnMBTidozIe6MQ4plZoGYJYnHHoY8720w1XzT827gMEBwb5
        ZlvCQomacjTEKo2JTdoFt2bIgA==
X-Google-Smtp-Source: AA6agR6s2CP6tfcHWtaPiCDJpAarnXCTA2bmkyEejKPAQnbvBOwBxcmdrgA45aqTgPA2oPxw7fTnFg==
X-Received: by 2002:a05:6512:2989:b0:48a:f4b9:84bf with SMTP id du9-20020a056512298900b0048af4b984bfmr7204878lfb.39.1660636099244;
        Tue, 16 Aug 2022 00:48:19 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1299811lfo.258.2022.08.16.00.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:48:18 -0700 (PDT)
Message-ID: <dccdc50e-2a59-8b06-7d44-e4c9116612c9@linaro.org>
Date:   Tue, 16 Aug 2022 10:48:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] dt-binding: pinctrl: Add cypress,cy8c95x0
Content-Language: en-US
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220816054917.7893-1-patrick.rudolph@9elements.com>
 <20220816054917.7893-2-patrick.rudolph@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816054917.7893-2-patrick.rudolph@9elements.com>
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

On 16/08/2022 08:49, Patrick Rudolph wrote:
> Added device tree binding documentation for
> Cypress CY8C95x0 I2C pin-controller.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
