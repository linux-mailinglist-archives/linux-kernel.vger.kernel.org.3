Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF844CC36F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiCCRL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiCCRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:11:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC4E18886D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:10:40 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C9B233F1C5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646327438;
        bh=yOpfl3Hcjndvk/B6vqY0qQ9g4TjpRuVNspq+zRHWaMY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=D1fNvbz+8Cgoym0nTo1cYmPsHj2mGebSJ3fwWY06T62VptzQzOLil7vwL7KCVzwYe
         rMSjz35C8TIExrZxhquqQzQ4IDhoqfq4PLwToNHfdTSTjm1qc6t60oQJTq/3TGXPfH
         lKA34/ezbkeuZzHXpG4OoKiPFzkU1liRReem6R6OMIJ/vjGpBLek7d6bNgesdp2dML
         5nfAnA//x65ow60PGpVNNj5zq2TtW2fe2p8zuUze8t1XM6Ssp1EJGY0+ygC0lZK0bx
         MCJXYR1cO3CTgbFRZWQMYUkhSl1c+9AEAfvc9kB9Y6lBPDtZUzqDCIw6BNBcr/eUnE
         17fL5ji7DUemA==
Received: by mail-ed1-f71.google.com with SMTP id l14-20020a056402344e00b0041593c729adso3200576edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yOpfl3Hcjndvk/B6vqY0qQ9g4TjpRuVNspq+zRHWaMY=;
        b=etRscFuGog5hhdZ9Gr9yZwVw3NYfUwVBSNuvRfBm6IWMdPlEF7EzRMsT0l0j8163PB
         IYgAv9smvQYlQoDoslKwtZgcCpohQAlKA5TWSsR3Jca0PlWRzE+QAcBJZpbvGCMRQhOZ
         w7gVDVP5ZHgRKMJJzLRFqQyTFKI68z0O33pjSeuxqK8ndZHFzbCsctIy9zzPdXuKVqQu
         rg7irq4rwMnvxwKHFIgB2BsdwY1HOA9WAyUwB0IEm1KHMSXt01pCqh2NGOYUC8rdUENw
         Ioawos4c7AVNscFszQbn9MN3JQ4zmEpox6ZW6j82cjYLQPYKkZeOKOPGtVvOa/QX5aZb
         GwOA==
X-Gm-Message-State: AOAM533r24M00CJCLmTvvwYr4WU7zrfSz+loYqj23s9DwAvxITQ3zurA
        GpM/ntsQ3SNmAfgPVZoBgQxuvGnrkwmEwjr9s60Z1fVNARNCjZdnRwOX9gG1TnlG59Lmx4dfakS
        AFPQ1aY2rEYHf2pkysgZsPk7XbgA4IK8f7OHgXxJ4sA==
X-Received: by 2002:a50:fb19:0:b0:404:eb52:62cb with SMTP id d25-20020a50fb19000000b00404eb5262cbmr35228376edq.363.1646327438494;
        Thu, 03 Mar 2022 09:10:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6bnmzjskCorkUY/nXeAQY/98C8GWRr5oY3xWGOPL3+b/RpQKLOt1AzH6nS2grakO845503w==
X-Received: by 2002:a50:fb19:0:b0:404:eb52:62cb with SMTP id d25-20020a50fb19000000b00404eb5262cbmr35228353edq.363.1646327438262;
        Thu, 03 Mar 2022 09:10:38 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w10-20020a17090652ca00b006c605703245sm913234ejn.43.2022.03.03.09.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 09:10:37 -0800 (PST)
Message-ID: <4df511e4-a1f9-d4ac-4971-028c3681e5fd@canonical.com>
Date:   Thu, 3 Mar 2022 18:10:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: arm: Allow 32-bit 'cpu-release-addr' values
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220303165710.1859862-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220303165710.1859862-1-robh@kernel.org>
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

On 03/03/2022 17:57, Rob Herring wrote:
> While the DT Spec says 'cpu-release-addr' is always 64-bit, some 32-bit Arm
> DTs used a 32-bit value. We're now stuck with those cases, so add uint32 as
> a valid type.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
