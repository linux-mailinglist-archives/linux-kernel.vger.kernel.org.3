Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931C54C8657
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiCAIUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiCAIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:20:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AF86C1F9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:20:13 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 625DA3FCAA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646122811;
        bh=wrc3c7oIUMwYQxhE3r5p7FIJPm98qYbXpx/SJrulnFQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=kokhnWHxZdm3LAyaRDkLvt2GK6tJbfbgaH7tMQEP/VgszUXfz/HLod5OwrBHuBNn4
         KfNfirIwWJw7/L1BLPXvcWfA4oibuER+gT6R9AXbT/z74ZCdJ/q4kzEIYaUjxUd7az
         Bhgm2ClmvlrO9JOMw6FgiwfWOOcJ5CKl77FxihcKQ5Q0oPabFzVp2bNkwGNS0j1guF
         4WUZIdrI1sZUY+gMWMOuIdSBpSqgp3FZ6180pXtHpDVUZ63umsL3fjNlkCbfB6pWmy
         Cd/0y6+Hha2C3Yo9PvkMXIgC9bCedtieV+wJ3Fe/UJx3ABrgPLWQl6bvXbSVT3nv8q
         YYoduWlOGMB/w==
Received: by mail-ej1-f72.google.com with SMTP id j6-20020a170906830600b006d6e2eb61f7so1037649ejx.15
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wrc3c7oIUMwYQxhE3r5p7FIJPm98qYbXpx/SJrulnFQ=;
        b=OfyMIuaLToxYkzLIowFBYVxM5ZtkYrZst5X1vSzWYt8ltdp38saQZz3ujyqAcTstLT
         vJJSvn+j6FDdOsxgh5VKS+LC09acwA6VMcs3mjTz+m5Awh1PBbfaJ3N8ZFygja1qFqoQ
         TwJMK17qdJnq0tUjCzxi3W4KXfYt+pkyBgGM98P3QjVUIlgAHvRMZq1m2XxF6+v9uFq6
         PiOGwLaEmpF2hZ6ItJLSynqSz0lIilEU8dnYjl5Tq4cc/s1Y3PZAWEK0WZBjpO1P8BeG
         nlDe8LpHbZQPTwnUTMzeIr1kOVNQvEpAbKMdBaOZZdsVeJD8/1vMYZPd+4BFCL49ii15
         EjMQ==
X-Gm-Message-State: AOAM531dosN+mcQNCRXEB5LKLLF/2EsFIQYSVgyIB6Q/QObzemdCqzXV
        wQan7FU4EQ8AX1nplDI9IjI4yFrHfUQ8rYWidYRc5Vwg/rFivr5mMrYMDR8uqUI4Xfsmh3iEUpC
        eQNT1dkHYtxVhGXhQCRvAPlSTrNPzdsH3xQbUoKysFw==
X-Received: by 2002:a17:906:4688:b0:6d6:e103:5e36 with SMTP id a8-20020a170906468800b006d6e1035e36mr2781922ejr.407.1646122810406;
        Tue, 01 Mar 2022 00:20:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyBQ6isFVLqMehtypRvFgUjjtT929Gj5H/cCPXv89jKdof9042ejhK/i0Dq+tOJBkQ+j+I7g==
X-Received: by 2002:a17:906:4688:b0:6d6:e103:5e36 with SMTP id a8-20020a170906468800b006d6e1035e36mr2781916ejr.407.1646122810225;
        Tue, 01 Mar 2022 00:20:10 -0800 (PST)
Received: from [192.168.0.135] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id gj7-20020a170907740700b006cf57a6648esm5091934ejc.90.2022.03.01.00.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:20:09 -0800 (PST)
Message-ID: <664af071-badf-5cc9-c065-c702b0c8a13d@canonical.com>
Date:   Tue, 1 Mar 2022 09:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] net/nfc/nci: use memset avoid infoleaks
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220301081750.2053246-1-chi.minghao@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220301081750.2053246-1-chi.minghao@zte.com.cn>
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

On 01/03/2022 09:17, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use memset to initialize structs to preventing infoleaks
> in nci_set_config
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>  net/nfc/nci/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index d2537383a3e8..32be42be1152 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -641,6 +641,7 @@ int nci_set_config(struct nci_dev *ndev, __u8 id, size_t len, const __u8 *val)
>  	if (!val || !len)
>  		return 0;
>  
> +	memset(&param, 0x0, sizeof(param));
>  	param.id = id;
>  	param.len = len;
>  	param.val = val;

The entire 'param' is overwritten in later code, so what could leak here?

Best regards,
Krzysztof
