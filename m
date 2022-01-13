Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D1748D85C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiAMM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:58:16 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51560
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234852AbiAMM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:58:14 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A7EEF3F1C9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642078693;
        bh=hJY+iTJXxh7N+a9cAeVo6uxkvEx09OIa8izcVhHm85o=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IpiOiteyx37tD2UyrUeK5mNYpNoOsKisp5MwmGQKRd5q6ykDlmeiueHw/f25wzcwS
         dRPq/SZ/syX4AAoDuTH/KZTtZuDjZY8vqqnsXWBZQcDyZyO+Su6ElqbZduexksAmwE
         wf6QdyWj8bKiLVtgTU7rhMADdx1wimlHMO8CJfSizAhs+YVUnck6LAshzCkOM/yM+V
         YiAp795fOuRixIXN+PXSmPtWcZMX3eVJdLUTVpZ8IH7Dt5hAfSqKJ6aqOJiUK/jTrM
         IeyLJS+/yyGgeH17+MZgAo8A9MIS4e88AT+FYiyzJa+nQ9EGs9l4TBLPRR7VuuxBre
         FElAl+lC6W5bA==
Received: by mail-ed1-f69.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so5264751edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 04:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hJY+iTJXxh7N+a9cAeVo6uxkvEx09OIa8izcVhHm85o=;
        b=PQIto5kS5q/qxuYr+6tmfAt1YBi/NeYBvRTWFrAFcLY5f7zRmX3JQAf4bsCI2uCLSd
         FrWgPxn2wVqrmnTq3GRKrU67O60eSniUaJ0SpyMuPbWAiGv7DKGREVFi7fJEI940h+OE
         OR2wRDR5trRmHx0rx4iHwXpQvGrJ+ULlX52fC0ZSGnK2n/rCQvWlXW1c0OMya6taUAu/
         gmlqORmsyLSoyVqfZNvfD8f3nG5r7jQhccKSI9N36SdzhV0eNouBq2We7SpR94Wkxv9b
         9Tb4xh+lZZeXQPnvLx4lInTa3qPKxF2IauzN3VQciE+lUwBbTtK590zQbV7uDI4aq11S
         XxHQ==
X-Gm-Message-State: AOAM532sBpPjK3/jRcSh5rNXBNqj8W3ODNkWSW3rGpjpj2jY83cMIFgI
        YbQ4IO3dJak3exd5b/B7uvmDSYzIDT8mVYjgl9I3TCqeSUJht0TK8oGBeJ+MTFvv/AuQtKVbw8w
        WBXT4pgUepGrWdc8s8pMAlYp8TjdowFRBsY54ufxXZA==
X-Received: by 2002:a17:906:2890:: with SMTP id o16mr3429775ejd.99.1642078693389;
        Thu, 13 Jan 2022 04:58:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJz/KUtwGDsFrbTAXt/C7unJ3bAy1RqQ2PDpyX9XObENafua0PnOgc/W74tPU9CS4vGKDuoQ==
X-Received: by 2002:a17:906:2890:: with SMTP id o16mr3429764ejd.99.1642078693221;
        Thu, 13 Jan 2022 04:58:13 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id kx19sm865643ejc.112.2022.01.13.04.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 04:58:12 -0800 (PST)
Message-ID: <176af0b0-a324-da39-2848-1c2e01cfadf5@canonical.com>
Date:   Thu, 13 Jan 2022 13:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 12/23] dt-bindings: add vendor prefix for Tesla
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122404epcas5p4aa1c3ac09510eb55cce5fdd0791993a6@epcas5p4.samsung.com>
 <20220113121143.22280-13-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113121143.22280-13-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 13:11, Alim Akhtar wrote:
> Add vendor prefix for the Tesla (https://www.tesla.com)
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(

This should be the first patch in the series.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
