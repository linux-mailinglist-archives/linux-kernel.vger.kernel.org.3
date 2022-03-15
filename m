Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809174DA263
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351063AbiCOS1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351056AbiCOS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:27:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630285A0A5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:26:30 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 44F303F07E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647368789;
        bh=wELfczD6aecqiQgUFZDUOzRE+BacZC1tX6h2eC851HA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vabl2WNtkd+K4ZM+SbQdIrms55u1O2FFqjfH+p+dzigjsh0iTKl5iV5Npr0UXA+cd
         9U9B1BCFbTiqlkyLDvS+1sV0zF1cSYA/fz6Qc34ZHq+6iILxRROjC8NsPN+jcdaGcN
         e2cYrCer84ka88A4c+3Owz/nF3KfqQ8821NCLQKJf4/AXb5S8yW0Nkm3LF3F8/ERvE
         /qwf++r1bQrPKbWTx8egxOID7YvSxNzQ5CBFwPRhvv+ZlUArhBbrDLLTmcEMw23MC/
         SLySk3G0UtqZn9jafbSmD16AqvAXw7eBUCtHT5ow7ffLS8v8/U56c9ByuoaPF/Al5k
         gr55x9cVOr2xg==
Received: by mail-ej1-f71.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso10103482ejc.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wELfczD6aecqiQgUFZDUOzRE+BacZC1tX6h2eC851HA=;
        b=hEmpKTURyfQbYcoaBopwPboIxwWsfig3dlU9736k25ATn25wBtjDShZXV4+8pEYBZm
         Tf56/9LsNt9pfotQQyNb7GyE234GDut/TrvcJRJNqIWoouYTuVpp91XiOFYBIjdF/PKe
         3m7Sn+IiFej2lvdvZuxTo1YRFeixy2OmZSUk9P4vetfCNKNvYv3ddeCzVEhQgGgtRLNT
         EwF0U9rF07LiRGU8qitPudB2y0XhKHlGotX6XsMGRxhQhSTzsqR9h1796FMy/WtHsPk2
         INeHH5gfku6y1PmYYSNMNWETXjXgPAzSjCxrgPqf8j4yBonIoy3LEme/1JbBTJQw9M8w
         gCHA==
X-Gm-Message-State: AOAM530RnIn10x9GDysCoXSgB1gPPOWMexAzX5OKkYumj/0FwszgSJjr
        eV0m2GFkAlqHKDmhMicuAajbW99WTyo5WDNn6Wm4rks9KDnhzrR2ARF3nrArdopPZ4K7R/jb0QL
        go9AH1vWM44++jMPUJDMFuuP5LYDLpbpApAW/SvwL7w==
X-Received: by 2002:a17:906:b288:b0:6da:825e:a2ee with SMTP id q8-20020a170906b28800b006da825ea2eemr23434508ejz.254.1647368789018;
        Tue, 15 Mar 2022 11:26:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7LxDT4MGNn2j5zGW0un4xcdJmoSwgEnvj4oTYvh7dGyCaYWm2rZ7O73KACh19pmoqcC1v1g==
X-Received: by 2002:a17:906:b288:b0:6da:825e:a2ee with SMTP id q8-20020a170906b28800b006da825ea2eemr23434496ejz.254.1647368788821;
        Tue, 15 Mar 2022 11:26:28 -0700 (PDT)
Received: from [10.227.148.193] (80-254-69-65.dynamic.monzoon.net. [80.254.69.65])
        by smtp.googlemail.com with ESMTPSA id q5-20020aa7cc05000000b004129baa5a94sm9780644edt.64.2022.03.15.11.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 11:26:28 -0700 (PDT)
Message-ID: <09e8fdab-978b-fa9d-9e45-f8625ebc9c52@canonical.com>
Date:   Tue, 15 Mar 2022 19:26:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: timer: Convert rda,8810pl-timer to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220225173734.GA7573@standask-GA-A55M-S2HP>
 <20220315140140.GA2558@standask-GA-A55M-S2HP>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220315140140.GA2558@standask-GA-A55M-S2HP>
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

On 15/03/2022 15:01, Stanislav Jakubek wrote:
> Hi all,
> 
> anything holding this back? It's been sitting on the mailing lists
> with 2 R-B's for ~2 weeks.

Maybe it's too late in the cycle for Daniel to take this?

Daniel,

If you are waiting for Rob's ack, mine should be sufficient.


Best regards,
Krzysztof
