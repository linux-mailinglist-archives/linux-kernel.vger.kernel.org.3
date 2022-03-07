Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01754D06D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiCGSsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbiCGSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:47:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97078BF78
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:46:59 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 93D593F7E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646678817;
        bh=7Du6NUZLSH6JPd0VdCqJVM5KAFisPVhRd3glhN4UZOQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZH/oSi7URveDAMBb9Lavf3tmKC61lAgU695SejnodQd4GV5svsK1W7Lmo04xCrxq3
         ypYtQYtBQGE8/8Zfxu/KyBp5giI8zBtWx943Vpag856JYNkQtrjysDMBTomNZOlsiW
         zGuU/3xWlFjlR8NlZ8nor338G8Y5TXSAnwSkJdvYn9kkYVjdmc7S4zxohx24ohci1h
         mUmkGx8K8w5eNURmV0yFQ9u0Sp4tsCwLPAoUEY4I/zy4XiWxzdRVi7LG5MGYMuKP34
         LVCNQEzOWowCvEoxrQIgkI/wvO+21JNEnB5NDqb8k85yro6P/GiomC5tojJ2fX+Y1b
         O0UQSjlZ+VuIg==
Received: by mail-ed1-f70.google.com with SMTP id da28-20020a056402177c00b00415ce4b20baso8241872edb.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Du6NUZLSH6JPd0VdCqJVM5KAFisPVhRd3glhN4UZOQ=;
        b=Xe/8SSyojbCG9Soz8E9Wfh5KwZHk2G3B90KrsbAvnZailC0M/uLhKiAiRaT/SuaucQ
         +jZHWjjLwgAP+ZewKdXjWZL9NV2yqlAZGjf40xEza0Uj6PDKef4sJQFXkmdOqPjcK923
         KiYN97jBis4ooYfCSAs+m6lhWRkW+jgxwsnQrOiVBSXa7ZiY15bCgKo8uMiEQIyCwNkd
         eBYxi+QP8TX+JKPNvFQ1BC0Qn8VIwUG/YKFjd7EEGA6NwQWiCH0PwQOiORHDsnoN+BJK
         0whUmsecKv8OBc0yZ5ZFeFENbl67nvcaR3i/N/0W7qSxAlTeNcnWHFLfEa3wYydgFht5
         6AlQ==
X-Gm-Message-State: AOAM530af07pVfsgruneLHpeuH0mS9TCO3ZuBhPHyTdV3A0NMWD8LhKk
        eRRUAfyd5K+FdZ5YhUpsq99xv6kVw3/wi/Jv4nL1RXPkacQm2JWjcLKizQ3FO947PmmeSsTBB95
        w3VvxrHxEFfkwR5tg6b+iE4sO5doTdE5z7bFlwqdfCg==
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id kl22-20020a170907995600b006cfcd25c5a7mr9944905ejc.635.1646678816736;
        Mon, 07 Mar 2022 10:46:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpJUHm+abc5eCLSEqkNsLa+Mh4u6+Bzb3sUElgNYSsiueLRLyvJgLpRmFoXyMOzSLGycIl0Q==
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id kl22-20020a170907995600b006cfcd25c5a7mr9944880ejc.635.1646678816500;
        Mon, 07 Mar 2022 10:46:56 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709060c5300b006d582121f99sm4960417ejf.36.2022.03.07.10.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 10:46:55 -0800 (PST)
Message-ID: <0901c63a-6684-348c-6f74-919075700e8b@canonical.com>
Date:   Mon, 7 Mar 2022 19:46:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/2] dt-bindings: i2c: update bindings for MT8168 SoC
Content-Language: en-US
To:     Kewei Xu <kewei.xu@mediatek.com>, wsa@the-dreams.de
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, qii.wang@mediatek.com,
        liguo.zhang@mediatek.com, caiyu.chen@mediatek.com,
        housong.zhang@mediatek.com, yuhan.wei@mediatek.com
References: <20220307033649.11564-1-kewei.xu@mediatek.com>
 <20220307033649.11564-2-kewei.xu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307033649.11564-2-kewei.xu@mediatek.com>
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

On 07/03/2022 04:36, Kewei Xu wrote:
> Add a DT binding documentation for the MT8168 soc.
> 
> Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
