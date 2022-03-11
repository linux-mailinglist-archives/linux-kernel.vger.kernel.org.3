Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94374D5FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbiCKKl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbiCKKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:41:52 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952B61BBF6E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:40:49 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3105F3F203
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646995248;
        bh=X21HZt8T3IqWraDQ7iGgx+oLbWN9WZTETBwQGf+ZZUQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KdcjXER4uQ15ZhxmI3i0zIVeFSQKIZek5+hagVNE5I56vSdFzQfUtno6aqjCUJqMh
         5H/SNAtPMBlQaHJkY4PVYaXBSN1btJzNBrvDMdFcA2EFDyv6o2FTTzwwun92FlsZik
         m0nqjITOhYvTMauZdBCkHM6jGTpPTRxBmcsa1cGrusJ9drPiayPdTousE6D+jTNCKN
         s+ZKT/K1kzfCzbddPTnTLIiyl9mBhkhLiSYlRMsLhNrEWytMEYJ5ZKfa/aT9fgnrP4
         ABzi/i0Y1rSzJFrVrm3KouQzgsFNYDX3WVGGxNk6NsFY4bb+JMPk2kCygAFSyE7uQM
         aQUBr+aAQELJw==
Received: by mail-ej1-f69.google.com with SMTP id y5-20020a1709060a8500b006da9258a34cso4703771ejf.21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X21HZt8T3IqWraDQ7iGgx+oLbWN9WZTETBwQGf+ZZUQ=;
        b=LCN6sjUpXJHmz1Aah/H9sAJSqm9Ls+Y8WK/fwrsnpFLUf37Wfo6axOP48FzOLNXaEC
         +02WODteWvMCjUKlpqswXuM0DRhCTNIoG3n2XjZdEKGBFyKGQtyDcGftMY/WAJBgU/fR
         DaDMQe0ebQr3bywr7LnIfh6ermsYh4bCJf718vcX3akJfg9Y+4Rhmluk8JB0xcYZKWse
         YfWhrG19DppFKPLiWV00LnRRwFda1jkg8WI8fBkitjT27YYqc0+mVTCmYz9/LRLIY2NV
         v/dYKE/yr9eEpESFUwRzqLqHBpVl4rwF3YQfAQ8JzwRU/aGVpG1WWvO6pTjEbodS23kq
         Cl8A==
X-Gm-Message-State: AOAM532I8aZgV53j9s4jyyZRMPF+1ncVXQvrqgYqewW2Hzs8PHWKqEtx
        G+dNTIWkkA7JxulbYQy8f0l78bIv7ZR9YWeSX2YGE5SbAxzx41pCxhzYM4x24EAK/0qhiy1lHj4
        GMXdi3TzKbPIN00kGYchIVxAlLaJrMkD9JE6hz7Kn7A==
X-Received: by 2002:a05:6402:68e:b0:415:d29e:dfe8 with SMTP id f14-20020a056402068e00b00415d29edfe8mr8020406edy.351.1646995247919;
        Fri, 11 Mar 2022 02:40:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx44n4lTaDW21Sf5vUfjbgKehNameHRuZxjI/VFFs7cXlR4x7K02XzPeqdOLSqhYmJx/XlfIw==
X-Received: by 2002:a05:6402:68e:b0:415:d29e:dfe8 with SMTP id f14-20020a056402068e00b00415d29edfe8mr8020389edy.351.1646995247762;
        Fri, 11 Mar 2022 02:40:47 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906161900b006d43be5b95fsm2830773ejd.118.2022.03.11.02.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 02:40:47 -0800 (PST)
Message-ID: <46c82688-79fd-fe65-b740-ac72a809f189@canonical.com>
Date:   Fri, 11 Mar 2022 11:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: samsung: Add ARTPEC-8 UART
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski@canonical.com
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        alim.akhtar@samsung.com
References: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
 <20220311094515.3223023-2-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311094515.3223023-2-vincent.whitchurch@axis.com>
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

On 11/03/2022 10:45, Vincent Whitchurch wrote:
> Add a compatible for the UART on the ARTPEC-8 SoC.  This hardware block
> is closely related to the variants used on the Exynos chips.  The
> register layout is identical to Exynos850 et al but the fifo size is
> different (64 bytes in each direction for all instances).
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
