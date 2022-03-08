Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799364D1AB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbiCHOit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347509AbiCHOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:38:44 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE55A2B187
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:37:45 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 906293F61B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646750264;
        bh=GQhf5FMMDwlXkcpGtUZU5kpnoxqIM3H1XBt87rWPIas=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZJHj12rWGbVi6KEEt7guWjkujYjuPXxSd73w83pLTleiFf0s9n9M2TayIjc8hw0Du
         Nq0Ta0HSA7ipNvyRKS6ytiOwt2spN8c5a5bLrq7ydyEuKTDkqyWe2xordGZmpe8YPs
         sCw5seGE77J3dX8bT5JR1Fg9RUPAfF1XIAPueySy+K/uCKTggctZ9npLHnv5iAw0g+
         uDxtHca1m9ypNJvgw0kLIdd1kWeIwH/l+B5cchcuXqxyFDTu9WDkkSg/G1uOgGoQxp
         Xy5ZF2MIPgslEcd7pzDrn5oqaGuDUvyOmrLfzg+nvwdGm3+gRdlOnQ7wDxF5HUriv6
         wEqo4yMPkKf+A==
Received: by mail-ej1-f70.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso8774586ejc.22
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GQhf5FMMDwlXkcpGtUZU5kpnoxqIM3H1XBt87rWPIas=;
        b=thIfdcsJ5Mp2NOCxFWHeoqC3PRHcS4oiSeSX8a8CnFgmMbc2B8HwD9t5uYa8toeq4q
         112fNz9y+OhKX/o3EPxM6HTssmRjqvz8U5CVkfyAezboniU5QZPbmaW4/CjHrUuEc4A+
         e7ajg619699eW/SZEQU4Cg0FhNPeoOYCXjDA8f9/43l+4t8k2EW2RFfXmgjwDnNB4njO
         teCRLucFlpGHwX2DtEigX/kkrwym44+8U9x7jZ5+ZbmO1CHxLL+BYwxvbUd7K+ahOLqg
         QIsedLOTNXcPmoRshSkXafjKsI8uucNpivm231ctHR/pDYJYgdoGZn0xHLm/oFv7BGwB
         XghA==
X-Gm-Message-State: AOAM532CInShEv5Z15nuQjtuTOU1XhM6ZSoe9cf8e6Jl2l60Vf5ehC7E
        xa6yNAkXtQ2oo90x/9cDUYhOZR4qMhwn4ppMrn4oene7nPK3uq3GrxJ0YHZZDlscnj7RjJqSRVh
        Q0V75UA9b2YHgN2uBR6jmehUQQrWifZ2HIZXc74NzZg==
X-Received: by 2002:a17:906:848f:b0:6cf:7234:8ae with SMTP id m15-20020a170906848f00b006cf723408aemr13893168ejx.620.1646750263863;
        Tue, 08 Mar 2022 06:37:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHPs13dq7ClqBcdJtQ2TjHjlfNW1+0JBLXqLPlMbYx0Qdb5usODrxQXpim42hs00FIxKoO4A==
X-Received: by 2002:a17:906:848f:b0:6cf:7234:8ae with SMTP id m15-20020a170906848f00b006cf723408aemr13893155ejx.620.1646750263680;
        Tue, 08 Mar 2022 06:37:43 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id a102-20020a509eef000000b0041614c8f79asm5773963edf.88.2022.03.08.06.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:37:42 -0800 (PST)
Message-ID: <3fb46905-6946-7164-4229-82d5d7d345b4@canonical.com>
Date:   Tue, 8 Mar 2022 15:37:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] dt-bindings: timer: exynos4210-mct: Add ARTPEC-8
 MCT
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, robh+dt@kernel.org
References: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
 <20220308142410.3193729-2-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220308142410.3193729-2-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 15:24, Vincent Whitchurch wrote:
> This SoC has an MCT with 4 global and 8 local timer interrupts, add a
> specific compatible to match it as is done for the other platforms with
> this hardware block.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v2: New.  Requires Krzysztof's "dt-bindings: timer: exynos4210-mct: describe
>         hardware and its interrupts".
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
