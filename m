Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2611048B042
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbiAKPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:03:55 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53280
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243287AbiAKPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:03:54 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 396A53F31F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641913433;
        bh=IYze5jR3qO6DwvRj2WvqsMLmcMVBiBOg+v8HeU+h+As=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=gRJEi6cEOs95dkEHS4Wm3VoYdlHeOd+hPMQ0VEgEbklmt3gO3Ld8QMQ3VhUvZEg5K
         iYYLTDr3fWwGErIn9sdTPB8euT0oyKE332mqt2VlV70+M67Yg2c6v9DzauTq65J/Xy
         veHFRlD5Boo+YX9kkcRCEEMUry++rGck6hFQbobBUvdzIw8cwvokGlObJdwI5tChHV
         gEK4wRuVToZ/OBhcKj9nTZesFR9y3lyt581luwoGZ828NEimbeqiaVD35ngzAUsJkf
         ZSZrpSBKU78GMoWuCfW3Qb7vrLjuiSadSzgW/VM2ATG0GBhIndAJIAB+SF3UmDAoL6
         NGkrzC3aKb6tw==
Received: by mail-ed1-f72.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so13565631edz.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IYze5jR3qO6DwvRj2WvqsMLmcMVBiBOg+v8HeU+h+As=;
        b=u9FVasA87zRoeKfJDvBiW0nviDUEOG5ULSfmYjz/Ck0xtQuRjRE+gkkyaI0MEPlhS+
         PR1S6PEn1L49iGCNstLz7rlIBRmD+4jbWsw9IHlHTMRgCoS7uzMZ9hkd+NRd7O1pJDr7
         4t7IBtDvMa7p+S7bnj1NJ9SBPD1AqyBehYayEMm/TbdV2ZQKXS+NrbRQOkyFZrIdAtYi
         q8EHhsHxBkiibMM2eAco+qdsM0JXbae6BtNzQQh922kACfyLBcEYK+fWZtgJ/JHHP1PL
         A5ZqigWxbTbykaFHTVv7PnnNAbttnc2Fl+77kRwyiUqiuA+xCkNiQgEJeVF3r08OUUup
         YVnA==
X-Gm-Message-State: AOAM531Z6+PTNDSpI7nm2/+MkrD/UYq2bRKq1aqlQO/EPNnFQRAmrcmT
        UxzhBfgEir1a6WnYvxLiBRCrpMDEsEZGuwtAUqTc4Cj6wPhPB41uzVJbgILtkBtMeBaOIJnmEl6
        FXMGl+Z7gyLqA8Ia7wSOzV4N5BNxNd+n6bfmn+uPM6g==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr4888652eds.240.1641913432709;
        Tue, 11 Jan 2022 07:03:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDNRq5OgEYq9q0OcJZ+LftNyARufACeAEd50pZ8N6QddIaIPn7tod2xjmXmdJrlbUyNmrbmQ==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr4888638eds.240.1641913432542;
        Tue, 11 Jan 2022 07:03:52 -0800 (PST)
Received: from [192.168.0.25] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id nc29sm3695670ejc.3.2022.01.11.07.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 07:03:51 -0800 (PST)
Message-ID: <86288708-8024-d981-6900-44e06278c24a@canonical.com>
Date:   Tue, 11 Jan 2022 16:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/4] dt-bindings: leds: maxim,max77693: convert to
 dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
 <20211228163930.35524-2-krzysztof.kozlowski@canonical.com>
 <1640799296.482933.824019.nullmailer@robh.at.kernel.org>
 <bedc4126-7536-a7f9-b833-d06f383ec15d@canonical.com>
 <YdRjNUMht6HjVM7s@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YdRjNUMht6HjVM7s@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2022 16:09, Rob Herring wrote:
> On Thu, Dec 30, 2021 at 11:53:37AM +0100, Krzysztof Kozlowski wrote:
>> On 29/12/2021 18:34, Rob Herring wrote:
>>> On Tue, 28 Dec 2021 17:39:27 +0100, Krzysztof Kozlowski wrote:
>>>> Convert the LEDs bindings of Maxim MAX77693 MUIC to DT schema format.
>>>> The existing bindings were defined in ../bindings/mfd/max77693.txt.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>>> ---
>>>>  .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++++++++++
>>>>  1 file changed, 105 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
>>>>
>>>
>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>
>>> yamllint warnings/errors:
>>>
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/common.example.dt.yaml: led-controller@0: 'reg' does not match any of the regexes: '^([a-z]+-)?led[01]?$', 'pinctrl-[0-9]+'
>>> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/maxim,max77693.yaml
>>>
>>> doc reference errors (make refcheckdocs):
>>> Documentation/devicetree/bindings/leds/maxim,max77693.yaml: Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
>>>
>>> See https://patchwork.ozlabs.org/patch/1573762
>>>
>>> This check can fail if there are any dependencies. The base for a patch
>>> series is generally the most recent rc1.
>>>
>>
>> I updated my yamllint and dtschema, run with DT_CHECKER_FLAGS=-m but
>> still cannot reproduce it. Probably because I based on linux-next, so
>> maybe this was a fixed issue in leds/common.yaml.
> 
> Are you setting DT_SCHEMA_FILES, because the error is in 
> common.yaml but caused by this schema.
> 
> Clearly, 'reg' is not defined here. And there is no change to 
> common.yaml in next.
> 

Indeed, I'll fix this up.


Best regards,
Krzysztof
