Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723EF4C5A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiB0KIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiB0KIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:08:44 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FD65DE65
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 02:08:07 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F76E3FCA8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645956485;
        bh=t39kLNlFZ66vLOwNBorCd7lyGkkC23z5r0vz3N8AmfQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=N2WJGxsACitGVbP+ojjbWwdvIqgN0adt4oICV4Ji8sDou9rhsVKsTJzlbyTdJvQTp
         DSfFHTZ3+WkhSoItWvoZCCqBFnXM+MQFbK1ojlg1Q0eDFZiRBO/FlC60XGTIBAOyhX
         FDn2OcW4Q6jM0AMAeEl5bfz2ulQEtjzceD+/3M8ujoM4a7u5/AyOhiPnXBayiOxZfR
         sW9uccK/eZlABBxT5Q2PRa36EdLpa3u1VCbNtEXza/+8Q6jrcoQNQ2f9ICTMuDkr+q
         N6CAzWQZ3Z0Ya/UnjMobVDIaVMGvxdzey4s4K7E90BVbIYQ0+0O523qbEAu/mn50fG
         R7SeY05DEz3Qw==
Received: by mail-ed1-f72.google.com with SMTP id b13-20020a056402278d00b0041311e02a9bso4000386ede.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 02:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t39kLNlFZ66vLOwNBorCd7lyGkkC23z5r0vz3N8AmfQ=;
        b=76BzziBIMHwwAMptmh1/JarwswN25zoIeB+MUtnE83VgjAvHH6U2hiMsEsOMVYvgyV
         6/QXwlivUea4voOrw9Ys0Bjq3V0A5IxxV8NqXodSAISbUcA5dfuNMUBunhD8sMpL6Yk1
         e/Hk3rbxp7FjyoC7fHAvK5pHxQNd+JYlSAnHTXMrkypILBPQp4rYsBvU+pQE9lqsytVw
         XUlBemiI+EcJDu9yKY+PbYRPRU7XZiomfmjEy2+AcMt1hUwSZcbWVDdqOt62Qi0KGwY/
         8jVqk3e5/pB2EnOglgagX+VSq0tnYFdZcv5/gxErIf2D9lnDEfYQDkBVyv4QUuVLJHmG
         vseQ==
X-Gm-Message-State: AOAM532fVQM8ww2Q8WvNQiw9hV3duqKxhDBlkNmE5BOCrWBQd4gLol0F
        ro55vfVKP5ofIgpudhbqfSYefJHDBQ9ThZc6PT8aqfIE6mbc0+gCmXheZq4+Ju1Aa3q25CzBfde
        oGnoI8Q2/c6nbDaOoubPKurHzh3NVYNd1iAP8nO3zoA==
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id f9-20020a056402354900b00412b31c5509mr14865078edd.224.1645956484758;
        Sun, 27 Feb 2022 02:08:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQAnvtCXE0xO0XRte1z2S3jF4ZnFOgFimpWcSv/fQckmAOJ3pVtCTn5WpkGMmHECl8gicPlQ==
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id f9-20020a056402354900b00412b31c5509mr14865061edd.224.1645956484614;
        Sun, 27 Feb 2022 02:08:04 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id dn14-20020a05640222ee00b00410b88abd6fsm4324340edb.45.2022.02.27.02.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 02:08:04 -0800 (PST)
Message-ID: <530d4625-8f31-32ca-b770-d75b6514343e@canonical.com>
Date:   Sun, 27 Feb 2022 11:08:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: timer: Convert rda,8810pl-timer to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220225173734.GA7573@standask-GA-A55M-S2HP>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220225173734.GA7573@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 18:37, Stanislav Jakubek wrote:
> Convert RDA Micro Timer bindings to DT schema format.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../bindings/timer/rda,8810pl-timer.txt       | 20 --------
>  .../bindings/timer/rda,8810pl-timer.yaml      | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 48 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
