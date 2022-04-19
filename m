Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9C45066FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350025AbiDSIfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350027AbiDSIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:35:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113CE19282
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:32:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k23so31353984ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Uv3d/o/806ehQWARNzXCTE9V0xEyE2ujT7hzeCnXZOM=;
        b=TfpRTEcQBJjGwylM5lPmbE9Sokay7j8KnqwaUaos+LKYQ1woooRQ19BQpVz8kPar32
         esfUVPrC63VXdBdWvbb4P1M2+SxHc13af1Evi0/lzJosRqCH0xOdMTQns/hgnNpmJURt
         RCV/ABAtI4iWA8pdTRSvpYlpi9kWTA9hxBJOjvdjUpIFoWIKe+PqksjlL9FyFpT0HW7Y
         gcWm9ZwlYbMtSQpvDA1yL6bC6yIIna8FVd/hSn1LcTRasuCyWC4JROgamsg6jueb83t6
         IvVYxhDVANdxBjB79/XM1/HwihVEus25U+kEMClHem3LnwMvyMYaH6iAjRK8IX1gxjmw
         McKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uv3d/o/806ehQWARNzXCTE9V0xEyE2ujT7hzeCnXZOM=;
        b=cG8FSbDq9rs8nw/R5AEm8buiuR4aMG1eu9pi1xffXNWaB1kRlIqon6CSpNYzbew3Um
         NmKmgaBO1dcRykL8lPQkSdjQTNTXdK8dHqd0gOFas8+Zhffz92A68rzGQ4nszr5xdMKq
         K+VbzTf7Bs1zKAzZrmaVI8GVzgJPApOI4lcIHXry3l62WwEwBXKCQhC9fFnDyGONXXum
         g0iN0hcr30AxQsckNHAJmt3TiuZCBB6Qy2ZlXoVqNKc2O1b4ye/mxzrPbtZstyT0/M4F
         6bufhOBGyvwD3moY5NcIg+9x2/3so6Y0HtXIAfQPprdnf/zG3VrYnRbSppjxrXRDQ35F
         TRPg==
X-Gm-Message-State: AOAM530xBeaSABMWBX12VXOLqdZAdnf/A/vPzkLG/qTS6K4Y31Yu9ava
        zxRSvWEMrl13R9k9c6HFflsLOg==
X-Google-Smtp-Source: ABdhPJw+5rmqS/LdAxogjfpIh94vjbsa9aPZC2x7C1G/78t6qXMTGqnXsWMrD/xAsUsv+fmyGW7hbQ==
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id mp30-20020a1709071b1e00b006d731b0e821mr12523412ejc.334.1650357146335;
        Tue, 19 Apr 2022 01:32:26 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ee17-20020a056402291100b0041fe1e4e342sm8051869edb.27.2022.04.19.01.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 01:32:25 -0700 (PDT)
Message-ID: <bacca876-c023-3c3f-e27e-61ef957bbdd0@linaro.org>
Date:   Tue, 19 Apr 2022 10:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] extcon: ptn5150: add queue work sync before driver
 release
Content-Language: en-US
To:     Li Jun <jun.li@nxp.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
References: <1650354202-10445-1-git-send-email-jun.li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1650354202-10445-1-git-send-email-jun.li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 09:43, Li Jun wrote:
> Add device managed action to sync pending queue work, otherwise
> the queued work may run after the work is destroyed.
> 
> Signed-off-by: Li Jun <jun.li@nxp.com>

Fixes: 4ed754de2d66 ("extcon: Add support for ptn5150 extcon driver")


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
