Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA59595D15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiHPNRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiHPNRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:17:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9C4B6D0B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:16:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v2so14878943lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WpveidhoH5bD/0MSr6APaKClQAGOik9LoKqKj6TsJ5M=;
        b=wlXhVABb6DuNOKMp2jJfTsQeCgWmlpjO9qhyw6ILpgP6KITF7+3ce6xYpIJ38wjz63
         DOw07+Ehyxq5EeY/KrbgtM/JfK1iY6Yydfsyjgngx9KFx2KLKOKPDhEjR4izgItAKeW4
         H5m3M2KjqATWIojX2h9IfMFgV9mV0Vzg2RJ1V6F48oiV50l9pZD+sHRUWZ154e5Yhy9D
         pESu0aK87HESTVXfXF+H/ZwJLvqz4VuEganMjk1MmiHWT5Ak6dbIWpH6SZurPArwolXI
         oZrxdh+tN3RqjvUFDT3cZnT2D9j8qu1XlxicqKHI9zYz/B/J6WVdhgJ+4rpIWuEBO/P8
         RjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WpveidhoH5bD/0MSr6APaKClQAGOik9LoKqKj6TsJ5M=;
        b=CRn92S2Utwuooy9HWjdcsHNZu88kbR6SVMzBdYxZGmKiSmgIXbBjYtCXkN6UvLnikg
         /ZxSezJyRFuQzn+oXTe+V6t8RKpfv2F37viTojNMPqkUD+jmceHJRNcj94MokpIaRb7V
         rycQR1iVA7rdOH6MlaaolC9DvWOAf0qeQHJx1KhVuab7wofL5ucZPBvpo+lniMmBX5Xt
         74q4sfYEMzhHvDG3ox9KCD5ID7agLj/Cpgp91jotJXFdWCYqoUEb79jh0+IO40284gs1
         h6RzscB7nRC697CuG7rysp9/EZnR2U3eQZfDVIXpOm6/OLPNRCmLfGn2FKqX4IP4wyjg
         pvPw==
X-Gm-Message-State: ACgBeo2aHvwbetmyVYzjoTB3elktZPEvc3tUBChMQYygrxjMRQSc4V2L
        TuIvSN2yMMWdvoRPCKB4BTo66w==
X-Google-Smtp-Source: AA6agR5tgahZD6sKKJ5xtAu8W6AUYS8nvCvK9dPEE95gFwW8UrWV5Xo6lBCfR/k2wtwRxdZ0rNth2Q==
X-Received: by 2002:a05:6512:3d25:b0:48b:562:162d with SMTP id d37-20020a0565123d2500b0048b0562162dmr6575622lfv.684.1660655778779;
        Tue, 16 Aug 2022 06:16:18 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id q27-20020ac25a1b000000b0048bd7136ef3sm1386448lfn.221.2022.08.16.06.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:16:18 -0700 (PDT)
Message-ID: <478dc6a0-99b5-a3be-1358-d29fec28b3dd@linaro.org>
Date:   Tue, 16 Aug 2022 16:16:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: phy: Drop Pratyush Yadav
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, pratyush@kernel.org
Cc:     devicetree@vger.kernel.org, kishon@ti.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org, vkoul@kernel.org
References: <20220811063840.7670-1-krzysztof.kozlowski@linaro.org>
 <20220816131041.1771872-1-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220816131041.1771872-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 16:10, Michael Walle wrote:
> [+ Pratyush ]
> 
>> Emails to Pratyush Yadav bounce ("550 Invalid recipient").
> 
> FWIW, he updated his entry in MAINTAINERS in commit 92714596cdbe
> ("MAINTAINERS: Use my kernel.org email"). So I'm not sure if this was
> just an oversight.

Thanks, I'll update the patch to use his @kernel email.

Best regards,
Krzysztof
