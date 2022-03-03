Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129294CC1C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiCCPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiCCPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:43:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B9226C1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:42:53 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0CC813F5F9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646322172;
        bh=ME4I2xtDxLjtSdGBX3DKk+XrqVNliOSTqfJoYUoRWk0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=UOyA3UQCRiTXq3BUUQLdGK40qlctSLcRko7WtSOm4zJRti1g0/cnpZsVW+AQ0O2Ld
         ubJFtJ4yJtLMYiQw28qA3zrF5+f9/tfUuwyTEkEqlLx2w8TWilsXirgvR3kK8TpllB
         qPm8UlUaVRyYPv4zx0AuttJeYT1bktvs9R8jBSurfUtXNlxLPVo7sAW3wSInsOGwI+
         GnG1iieKNa2wl+GUlqU5r+XkP6ux09h3C46UTGDvr+Oy6JR6CkIw1e7IMck2IRlHZw
         1A696/WvfDdpdbt+EYZqhe71oTeYtAxRGJZmTAQxCBA8FsRQOHC1V0LvZGQ9rQ5FHi
         05f6pH5mLAC7w==
Received: by mail-ed1-f72.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso3071792edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ME4I2xtDxLjtSdGBX3DKk+XrqVNliOSTqfJoYUoRWk0=;
        b=SsbJmg9NJKBlBjfSu8QrSGnBNBqpg4olKmfdi7+PyP6F+za0u1gtJ3iyP2xjK2iY4Q
         px/jNKh7TAdIYPido1DaIqs/B/5SZ92MD25Pn+a40kv943ko7C+CSnTQv25kgglm3dzH
         qTaHvK4dxviQi5sWZbEqiT9ciPube0MsOY/MnpmMqidu0pGAwWDiCBi5CPBaaHSV55Vz
         ox8Gzj8z7h2ymLU9rrpVzfnAqzbcLk6NFjMbTc/+ShrpEKQNvJ2ZHiESPUgm3p4u188Y
         ZFi7NMY3aSGwjJW+mW78AdeGHWhMAUn7zwQSAWdbx7jS0gNo1f56H7xs9wnQcl7didpr
         E1Zg==
X-Gm-Message-State: AOAM533f0tTpX6ZoRfPPhnzXdmMAHgA1UkRNGd1IO8TZC9cyBWF9IEIL
        mmhC3rXGsCRWf76q//L1AcyylK7+UTfKc+1W2BZNM5N5XriliGFJZ/9J3b24IIfozPTzLOg9R36
        kKlgoaeXoIA7WZPy82LPD/lSInxXlgBjbDidXASb6Xg==
X-Received: by 2002:a17:907:3e22:b0:6da:83fd:418 with SMTP id hp34-20020a1709073e2200b006da83fd0418mr4705167ejc.321.1646322171423;
        Thu, 03 Mar 2022 07:42:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzo2mCEi6JNvhbFVtiZ/5DeFZMU3OF1EMgZti7mkxs4OomQXS6Xn1JoWk2kQOUgUWbTOWbjDQ==
X-Received: by 2002:a17:907:3e22:b0:6da:83fd:418 with SMTP id hp34-20020a1709073e2200b006da83fd0418mr4705157ejc.321.1646322171259;
        Thu, 03 Mar 2022 07:42:51 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709062f8f00b006cd545d4af6sm817849eji.45.2022.03.03.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 07:42:50 -0800 (PST)
Message-ID: <758fc38c-53ec-4351-534a-95e1a54fb60d@canonical.com>
Date:   Thu, 3 Mar 2022 16:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: add QCOM SM6125 display clock
 bindings
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220303131812.302302-1-marijn.suijten@somainline.org>
 <20220303131812.302302-3-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220303131812.302302-3-marijn.suijten@somainline.org>
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

On 03/03/2022 14:18, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6125 SoC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../bindings/clock/qcom,dispcc-sm6125.yaml    | 87 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,dispcc-sm6125.h    | 41 +++++++++
>  2 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
