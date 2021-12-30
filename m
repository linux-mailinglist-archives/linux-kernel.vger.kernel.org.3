Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF2481B83
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhL3Kxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:53:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54272
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238730AbhL3Kxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:53:40 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 691D93F179
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640861619;
        bh=xYZejbhFSF4xwglRpwhIzdBP63mw8AEIBR2gKWeRi5A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NjaeV4dvjeUcYm/clWTVK4LbDm74B4hrMVhFCmq7/JJrED2Bcgz9tFrjSXnsghEgm
         02HxkACJ5lVAEKfhCrnmg4VnbBzNGMcNrVQNiozvHxneMZTFaArpTCBL93b5+LfI+J
         WVQkZQWala2ZY766qZN0EapkYAmCE4rm7q82Qei168qpQP7l+3a32p4rXrt5dB/Tj0
         u2tltRliJEgvopGm/ta4fwyrZfvMJR0nsI/jkSkTPPLyw31XsQQMCH5pKutbBd3tPu
         +g91BV4aYb3USSp6eTWcEevdmttvW4NZnC1zJjuv6SF9QLlS6/ujJ5VYw4HEDP2pE7
         kfPP25DRR36OQ==
Received: by mail-lf1-f72.google.com with SMTP id z23-20020a0565120c1700b004258a35caf2so4803429lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xYZejbhFSF4xwglRpwhIzdBP63mw8AEIBR2gKWeRi5A=;
        b=vKL0fUTO6Q9f1tEzlfDQblB9sujAigf41rQCz/618gXwAfXyaJ9N9Tl+ahshrQkxVi
         wlPcQzf+i6iyw8LjHMv0BxnL5uOQNqnyvNORhclMqkaGr7lotk6ljfIQcf+8ZikubnEO
         5IzLS82SqA6gNXk8RivCUeXWfbMqBOA8YCAk7rw74WSHlJbUO37TOUya65VVOxjxlruE
         PacsG5nVN0iCYdnfJvrcCSM5BtGNyyDfqwh1MgEo7CI5Czm+IoMWvj9b0kDEuhd5MNuA
         vSEf5r13KdyKb9V1rUgG3xRmFY61EFQwyW8pdQGi1LEl0Ae2rJUA8/hMRp2OFz8TvkUM
         OwLw==
X-Gm-Message-State: AOAM532ZLknJnYaEnDBVesLerYAO9XzA0qvZzW1D/DwJXMP/6wJuXZbE
        Alm7UIH4FnHCfYKfeHg0LvS/4lH1te3tjLGNrbin5JPuOMyku1El9K2QydFdRGZxRxwfWZSwGjC
        4SsShtmD0hsW1ETOQb0I+92wjwdklbYLgV3Gv6T6Ajw==
X-Received: by 2002:a05:6512:39c7:: with SMTP id k7mr24100703lfu.619.1640861618727;
        Thu, 30 Dec 2021 02:53:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyerqRnK1+XWImhdPq1FQz+KmsRHbdUCEsRHH6fubnWEVc0pW5KHWs9+wMlLjJM1Dyfo3fJjQ==
X-Received: by 2002:a05:6512:39c7:: with SMTP id k7mr24100682lfu.619.1640861618556;
        Thu, 30 Dec 2021 02:53:38 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id v12sm1528591lfa.143.2021.12.30.02.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 02:53:38 -0800 (PST)
Message-ID: <bedc4126-7536-a7f9-b833-d06f383ec15d@canonical.com>
Date:   Thu, 30 Dec 2021 11:53:37 +0100
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
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com>
 <20211228163930.35524-2-krzysztof.kozlowski@canonical.com>
 <1640799296.482933.824019.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1640799296.482933.824019.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2021 18:34, Rob Herring wrote:
> On Tue, 28 Dec 2021 17:39:27 +0100, Krzysztof Kozlowski wrote:
>> Convert the LEDs bindings of Maxim MAX77693 MUIC to DT schema format.
>> The existing bindings were defined in ../bindings/mfd/max77693.txt.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/common.example.dt.yaml: led-controller@0: 'reg' does not match any of the regexes: '^([a-z]+-)?led[01]?$', 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/maxim,max77693.yaml
> 
> doc reference errors (make refcheckdocs):
> Documentation/devicetree/bindings/leds/maxim,max77693.yaml: Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
> 
> See https://patchwork.ozlabs.org/patch/1573762
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 

I updated my yamllint and dtschema, run with DT_CHECKER_FLAGS=-m but
still cannot reproduce it. Probably because I based on linux-next, so
maybe this was a fixed issue in leds/common.yaml.

Best regards,
Krzysztof
