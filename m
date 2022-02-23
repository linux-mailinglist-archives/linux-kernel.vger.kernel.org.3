Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8634C132A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240620AbiBWMtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbiBWMtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:49:23 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDE2A94C7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:48:54 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 40D293F1B7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645620533;
        bh=NesaMe6AAtPcbdsNiOaIasWekYnWN+a1MuvJIFl2Bqk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=chJkfMm+X7AXDvr/HTUMsdYHUVu6AiEHzkNNLdvefPxddzk7JtjyGjv2+D+xG+XmP
         f+cPdPxeKavzLtx8QjZVb9rlNk9K6TyFNoB1NnFeywVWcVC6IDAjceBgm7lqMMDFuP
         EKEN34/tDmfrqxPHmZp7UoAS5caay/otohDu4TGMexTeEzM2A5qPHd8iUvILARTuFw
         v/0KI13LQpoVgTmXxmn8YhPhQ3cB3sFjAA1MheClD/r2US9lJXQ6F0exsSRJOvJBbo
         GPDtVcMaCqv9I8vBU5/Zt3yYNhcioqLpr3DS7Mu9Ej3mW/zxM0rbmYUwlq1BBdGEyx
         ZFdXyB0nemTWg==
Received: by mail-ed1-f70.google.com with SMTP id l24-20020a056402231800b00410f19a3103so13568939eda.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NesaMe6AAtPcbdsNiOaIasWekYnWN+a1MuvJIFl2Bqk=;
        b=jUJEcVindPypwtYWN5z0a9Nh0PdshzQ+BAyROR6u6KxdZBjAk8LsUzY7nE8Sb7Rfj/
         XSDxSeGCVJL/BGDhxMu98yJ+5fD1wvfuD9RzgwrD+onoGlsqLM90WyntewLWG/+rTbLP
         R0I6XCtTb7pVT4YHY+zjzAMA9+4vloAi5Aq2F5aj7zLNB2R4022aFa8FsZPw45Wl4FlQ
         w/plcx5zuCLiSmdSo+M0tAEkYm3qnvGyn3M40j3jD0AgAtS04VinJYXn4H+SfdQ6xgMf
         IN8KDNwhqq4Kfu54pf6UpJn8tRHtTzW8mD6sZH9hwDMqLU9OxUN37Sv61Tz8iwRnDSnw
         JvcA==
X-Gm-Message-State: AOAM532650ULPNe7ZB5ji1GxUH42WRMDXmpcZb4K3zLC3qPgksJbjJ0E
        LMh1ruPjcY+3Qd5IBmDsi/b7NXGZHqwAWoRTmiTHdYUkeTSZuCshBJnU5GTWIIWsI9M3YbnglTF
        n0VTyMDvIUe2OYPEr1yC/yu28YxEd6uYaVoIIMNvMcA==
X-Received: by 2002:a17:906:7189:b0:6b6:1ef8:f392 with SMTP id h9-20020a170906718900b006b61ef8f392mr22560399ejk.590.1645620532992;
        Wed, 23 Feb 2022 04:48:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlMqo0+lCiKQuYiIxgwvGDiKs3nUuBFpD+SmKArC4ih9QTg9OmjdwfiyJrUKH1Ndf+bFi3PA==
X-Received: by 2002:a17:906:7189:b0:6b6:1ef8:f392 with SMTP id h9-20020a170906718900b006b61ef8f392mr22560390ejk.590.1645620532828;
        Wed, 23 Feb 2022 04:48:52 -0800 (PST)
Received: from [192.168.0.125] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id v24sm7425426ejx.161.2022.02.23.04.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 04:48:51 -0800 (PST)
Message-ID: <e6300716-914e-aa45-8c4c-489930cdbdd6@canonical.com>
Date:   Wed, 23 Feb 2022 13:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: frequency: Add ADMV4420 doc
Content-Language: en-US
To:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220223115736.12485-1-cristian.pop@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220223115736.12485-1-cristian.pop@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 12:57, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> 
> squash
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

This requires fixing.

> ---
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 

With fixed commit msg:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
