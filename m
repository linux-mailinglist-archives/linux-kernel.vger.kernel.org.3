Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4783C4AAFF8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbiBFOdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbiBFOdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:33:52 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68347C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 06:33:51 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 43F184003B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644158030;
        bh=w5jCFzVfh1DIQgm2OWP8AtmTxGG5HpkOkroBXrwOf9Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=hOEAJyLf37aMfEvgIALkYDXB7X+VOTKPwolUx2LoI2Is5BcbvxTBT+Rd2n6meYYIE
         WIw3IvhTAy5dv1yRSLXLXDxUM1DoePwW70T8b3mTOfVxKssDGdcW2z6OcWWlGzQZRL
         FUUjxmLrb+zkj5tv3ZBWseXmEn82a+gssUgvDKRgonmZfSVSvoD2hzlbRTHtmF9CvZ
         inDOwbGIrAUQ7h9gfDItVUc6sDxdIn/oYTnIv7l3f7jv/3Ql/WG93l+tpSqTvz4+Fy
         697wVaqbnlREXyRNhx4FdztCuJJsAroLkEBPxx17cbiX3jRmipwmjexU3JTMqCGY5E
         4WU2kkCGoB6SQ==
Received: by mail-wm1-f71.google.com with SMTP id l4-20020a05600c4f0400b0037bb2ce79d8so2314726wmq.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 06:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w5jCFzVfh1DIQgm2OWP8AtmTxGG5HpkOkroBXrwOf9Y=;
        b=425CjvW1eisLS7uwvFyD65ScMp3bS7sQ+lHBfWCOa0X5l8MYN8K2b/hiJEHWxUi7ML
         ubiThUUImklzAN8qle2JRizd4Bkcey78qgsh7PXJG+u6Y58jsYCMExAPeYg2rwVjiGRM
         lxVWl1iA3L0VCT8COKNdh4/4xfv2Nv3OjUOr9JJ/ljREVbHBVSOPkvDy+LoVZMFqKxOg
         gvQUXksnlWXdnUlyjgR0BnbHcm4FRLAN9t8brCcM863sCfinqzWINndEq3ysKSQXzfI6
         uxkLQyccsZE75mmTFsgaamjxe90W3B1aEaDbkoFNTU/oHaHTWZ6NRIkSAF4Eq3F0DeNn
         aVxw==
X-Gm-Message-State: AOAM531iQaUorXKgf5XX/Sb/KeLMYHQtpNFilPb1LUWmt4hQ94wJUSdz
        3ulbJaYwmAjjh9Tb10Ru5LBj1KARIoX07TS84OomoTK/iHNSvNrzTw/CSOVDbr7cWzCj81dLNMG
        Uek7PvwBFhALIviqRcsqpj2DLC19vigAKoTqZzv33vg==
X-Received: by 2002:a05:6000:3c7:: with SMTP id b7mr6523656wrg.260.1644158029917;
        Sun, 06 Feb 2022 06:33:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqsVrLqsEVmIG0EJZY6joT43WAvfZIedwl1wfReqMz2vv6IM3sgPdvQ53f6KQ6AeSQEkAvXA==
X-Received: by 2002:a05:6000:3c7:: with SMTP id b7mr6523641wrg.260.1644158029744;
        Sun, 06 Feb 2022 06:33:49 -0800 (PST)
Received: from [192.168.0.85] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e10sm8158842wrq.53.2022.02.06.06.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 06:33:49 -0800 (PST)
Message-ID: <24c963c0-8521-b14f-e8f4-aefb037151e4@canonical.com>
Date:   Sun, 6 Feb 2022 15:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 8/9] dt-bindings: arm: msm: Add LLCC compatible for
 SM8450
Content-Language: en-US
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasad <quic_psodagud@quicinc.com>, Rob Herring <robh@kernel.org>
References: <cover.1643355594.git.quic_saipraka@quicinc.com>
 <f5235371f07ac0ce367c6ea84ed49937fb751a07.1643355594.git.quic_saipraka@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <f5235371f07ac0ce367c6ea84ed49937fb751a07.1643355594.git.quic_saipraka@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2022 08:47, Sai Prakash Ranjan wrote:
> Add LLCC compatible for SM8450 SoC.
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
