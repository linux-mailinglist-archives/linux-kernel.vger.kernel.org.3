Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3134CFD3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiCGLpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239663AbiCGLpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:45:07 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2956757B33
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:44:10 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 434D13F5F5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646653449;
        bh=7K92x3leOgbA5D2Deikx6J1ja1DW43dq73YDI+O/z/4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=WQMI8vZMMLJQ97J731i/63zkIyIDqvqpzVBKZQvEKQnD7IhOxqJS+XClAQjp0PlHq
         /KTsHbXwpapUEnhcDmlSzdiiVKrXL5vWUC3uNy9FJsA9teWtazIzCVD6XyZyR3lSKr
         cLF/PrmTHFemlcRO49grMOMP+MJQH3OQJmND9/DW8i2veGAfAoeOXi9anVoNgZbrfd
         6wAfhrrb8sWVzyIqX1J3LWaH6cwmpu1SfLJ/J8aR42DyKanpxP4nSyjHWWyNUEsB9w
         rzkB8keWtDJrBhW2Imsd2qz8ZQFqeYNfwDPvneej13F+GsVJqT2fy7Se8hsHW/LAap
         mWGaHuo8drDFQ==
Received: by mail-ed1-f71.google.com with SMTP id y26-20020a50ce1a000000b00415e9b35c81so6177061edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 03:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7K92x3leOgbA5D2Deikx6J1ja1DW43dq73YDI+O/z/4=;
        b=KcsVNOvpPwFRZBF3hC7bSaN4WsOd8QG8EDTKvJDFatz9FPirNrTaxtA/bOxWz3Xq9X
         uAyLQzD2RGk2lyzIiVdakSCaqx+lU/SF5IwHwRMK/FP3Z3TOPGkIctQh2Il88QFeNHI+
         KyNxaIDKgLBCgksrynvK/Ise+yBrTRjFcTNxOrc7QncoWxhHkjVJBdpOekCYSbXLYp2O
         JgptzdgPv1XDPfUSTX1qXiN75Iou+HGOrrVkeAhUhrwMtTzQKWR7nW9SZ5GJ++P3ydZp
         /O4R0xVGnUbeDG3/qpAG7HXHaAiFiFODoYUc43oOdEiEO/XKmmn5HZpqWHhp7CMdD7qA
         z3Ng==
X-Gm-Message-State: AOAM532Gt5gHsewmA+tIByx85hUsK3FPMrH3j04ATngWhxUgENARlfWy
        9uPL+r4XmxtIIfHDqcMCuVeu1dEfK78pswhbeFlEEswGTGklWElxufzkavNDZL86LQCNJKtF7Ce
        d5WDK7gkTGzpXNarJ/3AdCHZlH+18X4vIr18t00GDZg==
X-Received: by 2002:a17:907:608f:b0:6da:8d84:e272 with SMTP id ht15-20020a170907608f00b006da8d84e272mr8959400ejc.559.1646653448158;
        Mon, 07 Mar 2022 03:44:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7CquB49ISr7Cb3Um7I9XdJ9HGKHMsRL215XarEZGvF2Bjnl7tyullhjBdnRCd/oaHDZEQ6A==
X-Received: by 2002:a17:907:608f:b0:6da:8d84:e272 with SMTP id ht15-20020a170907608f00b006da8d84e272mr8959392ejc.559.1646653448011;
        Mon, 07 Mar 2022 03:44:08 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id dx10-20020a170906a84a00b006da8608e09fsm4624043ejb.9.2022.03.07.03.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 03:44:07 -0800 (PST)
Message-ID: <ff33d3a5-d2f3-8a7d-204e-0ab7205b932d@canonical.com>
Date:   Mon, 7 Mar 2022 12:44:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/6] ASoC: dt-bindings: Document Microchip's PDMC
Content-Language: en-US
To:     Codrin.Ciubotariu@microchip.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     lars@metafoo.de, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, Nicolas.Ferre@microchip.com
References: <20220307100428.2227511-1-codrin.ciubotariu@microchip.com>
 <20220307100428.2227511-3-codrin.ciubotariu@microchip.com>
 <73c49f2b-ef2e-5ed8-f3d5-aa696f9af9e6@canonical.com>
 <38975dd7-2f54-8920-af28-0a002f0faf5e@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <38975dd7-2f54-8920-af28-0a002f0faf5e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 12:34, Codrin.Ciubotariu@microchip.com wrote:
> On 07.03.2022 13:18, Krzysztof Kozlowski wrote:
>> On 07/03/2022 11:04, Codrin Ciubotariu wrote:
>>> +description:
>>> +  The Microchip Pulse Density Microphone Controller (PDMC) interfaces up to 4 digital microphones
>>> +  having Pulse Density Modulated (PDM) outputs.
>>
>> This exceeds 80 characters.
> 
> I thought it was raised to 100. checkpatch doesn't report anything also.

https://elixir.bootlin.com/linux/v5.17-rc7/source/Documentation/process/coding-style.rst#L104

The hard-constraint was lifted, but still 80 is preferred, unless
readability is increased with 100. That's not the case - readability is
the same, so keep 80.



Best regards,
Krzysztof
