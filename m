Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90BD4AAEF7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiBFLTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBFLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:19:11 -0500
X-Greylist: delayed 375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 03:19:10 PST
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FD5C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 03:19:10 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A3A2B40257
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644145968;
        bh=Kz7mmAE3kwHUdZq/qrSuuc4f2qKKp8Rw3RTt4cdUUnU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TFAG9tqDNyJtCATSN9Egw7eW+ipj9f2E1YqMQLeOX29EaRZVKyKqt9t9teh0AVZzh
         VBuLDZqv9+dGFBEjDpKLlM6pPHl/R9W+Taay3MVPLuvVqPf0ERl94wTp7I4jJmKagF
         CUVYqPUzg0eyU6D4skOMKliMdxw/NfjbAfbxM/KdLMkAOArLmiS3T5IN8D+PaaDKCX
         pCAWIknHuN3EFjg7dgpjAKtc/RkYvkmBi1hpNO2t+m3y+lGKbqLWluQ9rY+8VOY9eA
         q+5cqRsZ3hOwEhPNgLiU+ctNb7OjXcKfaTdNYMvRd8eIIQdMK5fTEWkGPb0YAmrkav
         md40iMhgJhTHw==
Received: by mail-ed1-f69.google.com with SMTP id n8-20020a50cc48000000b0040f345d624aso1778256edi.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 03:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kz7mmAE3kwHUdZq/qrSuuc4f2qKKp8Rw3RTt4cdUUnU=;
        b=CaeYoP0/1pXIZfb89xKCTHh5yTFwQnNqFMMW+Ef6OhBPek3raXCV3eyo9M01HCO4mP
         56SX6BINuitVTAXJFCbPPJg22ppL4LgpjvDajJ8QJt6y4gqL0v7sPUrVjnAUuSSbz/dx
         Wrwap8dK/TWpKnL4uphcewLDot3ZsLW+J+duqCNFOzO6CZq/S0R+SM74p4fjC3K+hcvn
         f7/fq244s53iAw7BjxiN0ialuI+2O3BXSiRVPNMjWhdlLsTZri03rSUJWIj0Kdulyx+c
         qJHt9q4twUSpDJFIFlkzLeelewzfGexrTMaRjdgF2dIf7zOYb1V+wfqCnlqPyFSMSn9u
         WPVA==
X-Gm-Message-State: AOAM53355UPbn14yq1w3crXM9GFoO/UhYg/i9KD1xJM7NAibd0CqWdLg
        JO7wON7u1/2Mqnjeb28UMFJXE0lN0RSyIbLt+wHPCbj6rFeT8LxwHLdg6BqQGu6ASuz+LeduMjL
        puHRPPWXbSdoMOh3mgSekE0HLV59cS/UWw2tNTgxuKA==
X-Received: by 2002:a17:907:2d0e:: with SMTP id gs14mr5943953ejc.225.1644145968301;
        Sun, 06 Feb 2022 03:12:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4HMfQ/8SuQ3r9SyDV83dQPXy5i2p+IC2yeF1DDOzRhTvOb+K8tMXdIGUY4v9lAjjEVYNI/w==
X-Received: by 2002:a17:907:2d0e:: with SMTP id gs14mr5943938ejc.225.1644145968059;
        Sun, 06 Feb 2022 03:12:48 -0800 (PST)
Received: from [192.168.0.83] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id fw6sm1192599ejc.143.2022.02.06.03.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 03:12:47 -0800 (PST)
Message-ID: <5170e307-1fba-0526-6c13-78334e74dcb6@canonical.com>
Date:   Sun, 6 Feb 2022 12:12:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/5] dt-bindings: memory: lpddr3: convert to dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
 <20220205120043.8337-2-krzysztof.kozlowski@canonical.com>
 <1644075381.224411.542295.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1644075381.224411.542295.nullmailer@robh.at.kernel.org>
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

On 05/02/2022 16:36, Rob Herring wrote:
> On Sat, 05 Feb 2022 13:00:39 +0100, Krzysztof Kozlowski wrote:
>> Convert the LPDDR3 memory bindings to DT schema format.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../memory-controllers/ddr/jedec,lpddr3.yaml  | 266 ++++++++++++++++++
>>  .../memory-controllers/ddr/lpddr3.txt         | 107 -------
>>  2 files changed, 266 insertions(+), 107 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.example.dt.yaml:0:0: /example-0/lpddr3/timings@800000000: failed to match any schema with compatible: ['jedec,lpddr3-timings']

This is patch ordering issue - I'll change the order to fix it.

> 
> doc reference errors (make refcheckdocs):
> Warning: Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt
> Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml: Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt

I'll fix it in v3.


Best regards,
Krzysztof
