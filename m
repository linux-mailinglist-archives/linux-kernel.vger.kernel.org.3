Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B5E4DB60A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357500AbiCPQVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiCPQVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:21:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCE66D1BA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:20:29 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 779483F1FC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647447626;
        bh=O52a6BJ0eqWTsc/2DbHo6Vw/EG0KeFOooHXm8fZQaTo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=v6XzZQVCs8AyABaV6tUe0xX6u9tFxW0ldvmRgaitu+MYvXE3m1cqRs+aqpA2v5PH/
         eDQSWZgduMfXSK7y2qFr45jGJZR4/G9Q/t34X/jMvM4umccxdASZNbRvCDyQz4Hsfa
         WSPfAOxG7f53C0nFrtPPuoGmDsfj1bLUeH/psbsYXa9NqC8bwIYzA1LwgAS3Or7fwu
         7/luNlQexBDjZSAD8R+ItYii5N+APDYYEdd4yEz0QM3Zh0ySHnvkAqoPDoX7DUBFWU
         1QTywdQ7c+OFD1ws8OoCuDrykQWxfBeIj5a9clVLcsn2pTFCQ9CXruOmjGdsNJoKdn
         DCJvddf50gQcw==
Received: by mail-wr1-f69.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so711481wrg.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O52a6BJ0eqWTsc/2DbHo6Vw/EG0KeFOooHXm8fZQaTo=;
        b=CR5fuz8mKJNLIlRzUd1KjI1BnNLldPk2mpH5/2DJgEEsWk9lQedTUWKTiom/zCyfS5
         yEaJ5JccTIMeXav69VQsFqL8+UuyLuiCzLdGU+gNUbI7u4bN70KGvufuQ44dnL6sD8Cc
         Z3+W+TYyzj5wGbCVt3jhhk+usfd89YgiusEkXdRCGt4gqWSsLTYocS+5NW92aIsDOodx
         bfoJWVL8jxeTT7So1106DJX+fd+qpDhzRRdqEvmhFgBQR/3ELpnp+hLfeVnAWxG3H+0l
         Ymlh1eHN4hHR6lAKbfUr1qpanfNJX/q8z3QPL0p1IYMEGf9sVkXSjgyhDdxILqNSpF1H
         gOxw==
X-Gm-Message-State: AOAM530vj5SBmIfXsTiVLIMeTxVo8Bxz4vwpxV+sUROzv/lmudhJH6lI
        BIbvaWKDP7fnb7bSEYuTgXhkFcKgWmR+4/kXdk3JtONMyCyEr4mk25QbJAoLqkDB5m2WtYee3i8
        GjwYG/zC6tPxKecHHZhpMVaNSAgvCpgIpwRweio9Haw==
X-Received: by 2002:a5d:4bcd:0:b0:203:cec2:edf with SMTP id l13-20020a5d4bcd000000b00203cec20edfmr533642wrt.25.1647447624982;
        Wed, 16 Mar 2022 09:20:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvx/VWi9UpWEvGj+o7+fQNO9ol8C7gLCx1pm8lTtoDiyvjUWQUiU9XrTGq/gyB46keTeolwQ==
X-Received: by 2002:a5d:4bcd:0:b0:203:cec2:edf with SMTP id l13-20020a5d4bcd000000b00203cec20edfmr533629wrt.25.1647447624842;
        Wed, 16 Mar 2022 09:20:24 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id r186-20020a1c2bc3000000b0037bdd94a4e5sm2117243wmr.39.2022.03.16.09.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:20:24 -0700 (PDT)
Message-ID: <74ed4ba2-168e-b1c4-7449-443ff6955e6b@canonical.com>
Date:   Wed, 16 Mar 2022 17:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/6] dt-bindings: power: Add rpm power domain bindings for
 SDX65
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        rnayak@codeaurora.org, collinsd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
 <1647410837-22537-4-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1647410837-22537-4-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 07:07, Rohit Agarwal wrote:
> Add RPM power domain bindings for the SDX65 SoC.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  include/dt-bindings/power/qcom-rpmpd.h                  | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
