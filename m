Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A924D2BED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiCIJ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiCIJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:29:09 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E335614D26C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:28:10 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8108B3F1C5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646818089;
        bh=W1ZmGzzIil/BY1tOmvj18fZ/kKQqmwIhZnir6U/EX5w=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jWt712BXAsHaDWILBo5BVHV2sOALVNfCgNeI70JyW4/lVqLCtvPYo27wthjw8IfCI
         4KYd3lCERMvbJsDG9JHfH4hIkkbt4mqOOdfmnGGKC8hIONBlei6xtvdrPKb9Esv7OI
         5jz0pxw8FIto3P3NYL5FxHirxPCHODSRlvHAsljV1zWDN1nVaWtOgt3ybhGBXrs1zx
         lOG05uUfg36YnNynJnogsSGWadIf2lu7oIkhtNaJd1Os3N2HMlelmFckidido0t2V9
         yAaEnGAf+6IZ7FTJOykQw8QhW6hFcCIxynP7QA3hHVYuiexD3hcoSzJ86R8CXzPOKW
         xdjahaSe+z73g==
Received: by mail-ed1-f71.google.com with SMTP id h17-20020a05640250d100b004133863d836so997061edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W1ZmGzzIil/BY1tOmvj18fZ/kKQqmwIhZnir6U/EX5w=;
        b=XynkyMF4eBcQWZO4QAtgJQeL8O9g1EBYgVtrgCs1fj0W8V/s+sdrtlqA1g6Q4JbrTm
         O4J973Q1dOTJ8yY+LPL0BNTJuunUqrngBLQAJJpmpXToB5q+SaaY2Vyi4G1UlNFtDrtG
         NTGf9uEN/0m0cGVeyDEPYxauDfIRoafoT7RgDEVrNx5Wq+ZnixrzArPR1bV/0PhKSZQN
         re9kKisPJo1anPWb22c8nPEpUxGUaV82En4thsOwngOHAn0L/yDofE3Ksdlf4FQNHeVF
         Jv3wyWGPf6C9M2xlnMQnKI/Er+dTPyRfEv1DygvZxJVwQ1gAOXPjWpMsF63gjiDdr+R3
         EDsw==
X-Gm-Message-State: AOAM5331YtBLpaDlU690wp2LIwPEsTzuxDhtEvPTpDCi0HX8gqEuH98T
        tWqS8hJeJu+BKut/GrkakeiUYF1zFWDWE7gd5u3QX6FRQa45//bqKytodcemNxzJ5RXyiRsEbPM
        RD0fYTJ0HHDloK1FWtQqECmrAtoDFSQxxzbnqoLVcpQ==
X-Received: by 2002:a17:907:a40a:b0:6db:462:dbe9 with SMTP id sg10-20020a170907a40a00b006db0462dbe9mr15774938ejc.59.1646818088938;
        Wed, 09 Mar 2022 01:28:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsMwx6ua3btbQvYyeevwGk42BscQP3xI9D8KoR2lq9SemLHw6dTp3pN5n0R1N/DkOoTtWXhw==
X-Received: by 2002:a17:907:a40a:b0:6db:462:dbe9 with SMTP id sg10-20020a170907a40a00b006db0462dbe9mr15774923ejc.59.1646818088779;
        Wed, 09 Mar 2022 01:28:08 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id vl11-20020a17090730cb00b006d8121d0fc4sm488489ejb.138.2022.03.09.01.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 01:28:08 -0800 (PST)
Message-ID: <45c682ea-db99-e7b2-fbae-395e214962f4@canonical.com>
Date:   Wed, 9 Mar 2022 10:28:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add sc8280xp TLMM
 binding
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308221132.1423218-1-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220308221132.1423218-1-bjorn.andersson@linaro.org>
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

On 08/03/2022 23:11, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform contains a single block of registers
> for the TLMM block. This provides pinconf and pinmux for 228 GPIOs, 2
> UFS_RESET pins and one SDC interface.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Dropped $ref: pinctrl.yaml
> - Dropped reg-names from required list
> - Fixed spelling mistake in example
> 
>  .../pinctrl/qcom,sc8280xp-pinctrl.yaml        | 151 ++++++++++++++++++
>  1 file changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
